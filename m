Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6A117CF5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLJBPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 20:15:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36754 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727626AbfLJBPD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Dec 2019 20:15:03 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA19Gdf014377
        for <bpf@vger.kernel.org>; Mon, 9 Dec 2019 17:15:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GxXBR7i91xiSr8Z10fKbUMj0HcmpbrA39djs9voKQqk=;
 b=DePiT8VjLuontCxBve8V9mzbnEQgiIBKtjc3nl2gThlTXjiw9oWtBNCP4DOSNJXmcjn9
 EAI3GeUJWSnHwKCZx2Nu65K4qRzLXznEdoflyQTP1Q+LcinBI5hUKtpRuD16ODVykC2i
 JWkjGTLfcgeDITrCxUj8BAa9CJaTf/5GMrQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wrbwmkga4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 17:15:02 -0800
Received: from intmgw001.05.ash5.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 9 Dec 2019 17:15:00 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1F66F2EC16B5; Mon,  9 Dec 2019 17:14:58 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 05/15] libbpf: expose field/var declaration emitting API internally
Date:   Mon, 9 Dec 2019 17:14:28 -0800
Message-ID: <20191210011438.4182911-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210011438.4182911-1-andriin@fb.com>
References: <20191210011438.4182911-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_05:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=25 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Expose useful function emitting field/variable declaration compilable C syntax
of a provided BTF type. This is going to be used by bpftool when emitting data
section layout as a struct. This is not a trivial algorithm, so better to
expose it as internal API and let bpftool harness existing libbpf code. As
part of making this API useful in a stand-alone fashion, move initialization
of some of the internal btf_dumper state to early phase.

Also expose useful btf_align_of() function returning alignment of a given BTF
type. This is also used for data section layout-compatible struct definition,
specifically to determine necessary extra padding between fields/variables.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf_dump.c        | 61 ++++++++++++++++-----------------
 tools/lib/bpf/libbpf_internal.h |  6 ++++
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cb126d8fcf75..e597eb9541f5 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -116,6 +116,8 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 	va_end(args);
 }
 
+static int btf_dump_mark_referenced(struct btf_dump *d);
+
 struct btf_dump *btf_dump__new(const struct btf *btf,
 			       const struct btf_ext *btf_ext,
 			       const struct btf_dump_opts *opts,
@@ -137,18 +139,39 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	if (IS_ERR(d->type_names)) {
 		err = PTR_ERR(d->type_names);
 		d->type_names = NULL;
-		btf_dump__free(d);
-		return ERR_PTR(err);
 	}
 	d->ident_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->ident_names)) {
 		err = PTR_ERR(d->ident_names);
 		d->ident_names = NULL;
-		btf_dump__free(d);
-		return ERR_PTR(err);
+		goto err;
+	}
+	d->type_states = calloc(1 + btf__get_nr_types(d->btf),
+				sizeof(d->type_states[0]));
+	if (!d->type_states) {
+		err = -ENOMEM;
+		goto err;
+	}
+	d->cached_names = calloc(1 + btf__get_nr_types(d->btf),
+				 sizeof(d->cached_names[0]));
+	if (!d->cached_names) {
+		err = -ENOMEM;
+		goto err;
 	}
 
+	/* VOID is special */
+	d->type_states[0].order_state = ORDERED;
+	d->type_states[0].emit_state = EMITTED;
+
+	/* eagerly determine referenced types for anon enums */
+	err = btf_dump_mark_referenced(d);
+	if (err)
+		goto err;
+
 	return d;
+err:
+	btf_dump__free(d);
+	return ERR_PTR(err);
 }
 
 void btf_dump__free(struct btf_dump *d)
@@ -175,7 +198,6 @@ void btf_dump__free(struct btf_dump *d)
 	free(d);
 }
 
-static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
 static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
 
@@ -202,27 +224,6 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 	if (id > btf__get_nr_types(d->btf))
 		return -EINVAL;
 
-	/* type states are lazily allocated, as they might not be needed */
-	if (!d->type_states) {
-		d->type_states = calloc(1 + btf__get_nr_types(d->btf),
-					sizeof(d->type_states[0]));
-		if (!d->type_states)
-			return -ENOMEM;
-		d->cached_names = calloc(1 + btf__get_nr_types(d->btf),
-					 sizeof(d->cached_names[0]));
-		if (!d->cached_names)
-			return -ENOMEM;
-
-		/* VOID is special */
-		d->type_states[0].order_state = ORDERED;
-		d->type_states[0].emit_state = EMITTED;
-
-		/* eagerly determine referenced types for anon enums */
-		err = btf_dump_mark_referenced(d);
-		if (err)
-			return err;
-	}
-
 	d->emit_queue_cnt = 0;
 	err = btf_dump_order_type(d, id, false);
 	if (err < 0)
@@ -565,8 +566,6 @@ struct id_stack {
 	int cnt;
 };
 
-static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
-				    const char *fname, int lvl);
 static void btf_dump_emit_type_chain(struct btf_dump *d,
 				     struct id_stack *decl_stack,
 				     const char *fname, int lvl);
@@ -752,7 +751,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 	}
 }
 
-static int btf_align_of(const struct btf *btf, __u32 id)
+int btf_align_of(const struct btf *btf, __u32 id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, id);
 	__u16 kind = btf_kind(t);
@@ -1051,8 +1050,8 @@ static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
  * of a stack frame. Some care is required to "pop" stack frames after
  * processing type declaration chain.
  */
-static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
-				    const char *fname, int lvl)
+void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
+			     const char *fname, int lvl)
 {
 	struct id_stack decl_stack;
 	const struct btf_type *t;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 7ee0c8691835..bb7fd22eb0ab 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -98,6 +98,12 @@ static inline bool libbpf_validate_opts(const char *opts,
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len);
 
+struct btf_dump;
+
+void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id, const char *fname,
+			     int lvl);
+int btf_align_of(const struct btf *btf, __u32 id);
+
 int bpf_object__section_size(const struct bpf_object *obj, const char *name,
 			     __u32 *size);
 int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
-- 
2.17.1

