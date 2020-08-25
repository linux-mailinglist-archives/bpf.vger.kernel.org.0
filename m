Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E77251FC6
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHYTWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Aug 2020 15:22:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726723AbgHYTWC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 15:22:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-gLIvsCQxOSShPCYuSto1Fw-1; Tue, 25 Aug 2020 15:21:57 -0400
X-MC-Unique: gLIvsCQxOSShPCYuSto1Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A4E186A560;
        Tue, 25 Aug 2020 19:21:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75A719C4F;
        Tue, 25 Aug 2020 19:21:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH v12 bpf-next 05/14] bpf: Add type_id pointer as argument to __btf_resolve_size
Date:   Tue, 25 Aug 2020 21:21:15 +0200
Message-Id: <20200825192124.710397-6-jolsa@kernel.org>
In-Reply-To: <20200825192124.710397-1-jolsa@kernel.org>
References: <20200825192124.710397-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding type_id pointer as argument to __btf_resolve_size
to return also BTF ID of the resolved type. It will be
used in following changes.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dbc70fedfb44..ee0e2a5e6c88 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1082,6 +1082,7 @@ static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
  * *elem_id: id of u32
  * *total_nelems: (x * y).  Hence, individual elem size is
  *                (*type_size / *total_nelems)
+ * *type_id: id of type if it's changed within the function, 0 if not
  *
  * type: is not an array (e.g. const struct X)
  * return type: type "struct X"
@@ -1089,15 +1090,16 @@ static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
  * *elem_type: same as return type ("struct X")
  * *elem_id: 0
  * *total_nelems: 1
+ * *type_id: id of type if it's changed within the function, 0 if not
  */
 static const struct btf_type *
 __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		   u32 *type_size, const struct btf_type **elem_type,
-		   u32 *elem_id, u32 *total_nelems)
+		   u32 *elem_id, u32 *total_nelems, u32 *type_id)
 {
 	const struct btf_type *array_type = NULL;
 	const struct btf_array *array = NULL;
-	u32 i, size, nelems = 1;
+	u32 i, size, nelems = 1, id = 0;
 
 	for (i = 0; i < MAX_RESOLVE_DEPTH; i++) {
 		switch (BTF_INFO_KIND(type->info)) {
@@ -1118,6 +1120,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
+			id = type->type;
 			type = btf_type_by_id(btf, type->type);
 			break;
 
@@ -1150,6 +1153,8 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		*elem_type = type;
 	if (elem_id)
 		*elem_id = array ? array->type : 0;
+	if (type_id && id)
+		*type_id = id;
 
 	return array_type ? : type;
 }
@@ -1158,7 +1163,7 @@ const struct btf_type *
 btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		 u32 *type_size)
 {
-	return __btf_resolve_size(btf, type, type_size, NULL, NULL);
+	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
 }
 
 /* The input param "type_id" must point to a needs_resolve type */
@@ -3988,7 +3993,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		mname = __btf_name_by_offset(btf_vmlinux, member->name_off);
 
 		mtype = __btf_resolve_size(btf_vmlinux, mtype, &msize,
-					   &elem_type, NULL, &total_nelems);
+					   &elem_type, NULL, &total_nelems, NULL);
 		if (IS_ERR(mtype)) {
 			bpf_log(log, "field %s doesn't have size\n", mname);
 			return -EFAULT;
-- 
2.25.4

