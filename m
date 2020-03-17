Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C670187779
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 02:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgCQBc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 21:32:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51428 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgCQBc6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Mar 2020 21:32:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02H1FKxs008520
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 18:32:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=3XJbYsZfNLsxH4Pi39oXImcRCvseYdjkNaZa0XP7+rU=;
 b=iGbGV2+Ha6HdNzI0fnain4ytncv4IQpYeZMED8Ng75tbJbmBmba0NMkOpdIBQj1cloZR
 /ca+XgmWqEBS6aF9JWHN1TrnWS10upzf9m1NwaRLxgmDyABENMOOlN0MwyfdUSnoyNWe
 d7thUpZ1qxIZpAFmcy8grSFvAItwENhX+9g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ysfdx7tym-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 18:32:57 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 16 Mar 2020 18:32:55 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 699342942D82; Mon, 16 Mar 2020 18:32:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 2/4] bpftool: Print as a string for char array
Date:   Mon, 16 Mar 2020 18:32:52 -0700
Message-ID: <20200317013252.4066668-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317013239.4066168-1-kafai@fb.com>
References: <20200317013239.4066168-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-16_11:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=13 phishscore=0 mlxlogscore=903
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A char[] is currently printed as an integer array.
This patch will print it as a string when
1) The array element type is an one byte int
2) The array element type has a BTF_INT_CHAR encoding or
   the array element type's name is "char"
3) All characters is between (0x1f, 0x7f) and it is terminated
   by a null character.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/btf_dumper.c | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 57bd6c0fafc9..1d2d8d2cedea 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -77,6 +77,42 @@ static void btf_dumper_enum(const struct btf_dumper *d,
 	jsonw_int(d->jw, value);
 }
 
+static bool is_str_array(const struct btf *btf, const struct btf_array *arr,
+			 const char *s)
+{
+	const struct btf_type *elem_type;
+	const char *end_s;
+
+	if (!arr->nelems)
+		return false;
+
+	elem_type = btf__type_by_id(btf, arr->type);
+	/* Not skipping typedef.  typedef to char does not count as
+	 * a string now.
+	 */
+	while (elem_type && btf_is_mod(elem_type))
+		elem_type = btf__type_by_id(btf, elem_type->type);
+
+	if (!elem_type || !btf_is_int(elem_type) || elem_type->size != 1)
+		return false;
+
+	if (btf_int_encoding(elem_type) != BTF_INT_CHAR &&
+	    strcmp("char", btf__name_by_offset(btf, elem_type->name_off)))
+		return false;
+
+	end_s = s + arr->nelems;
+	while (s < end_s) {
+		if (!*s)
+			return true;
+		if (*s <= 0x1f || *s >= 0x7f)
+			return false;
+		s++;
+	}
+
+	/* '\0' is not found */
+	return false;
+}
+
 static int btf_dumper_array(const struct btf_dumper *d, __u32 type_id,
 			    const void *data)
 {
@@ -86,6 +122,11 @@ static int btf_dumper_array(const struct btf_dumper *d, __u32 type_id,
 	int ret = 0;
 	__u32 i;
 
+	if (is_str_array(d->btf, arr, data)) {
+		jsonw_string(d->jw, data);
+		return 0;
+	}
+
 	elem_size = btf__resolve_size(d->btf, arr->type);
 	if (elem_size < 0)
 		return elem_size;
-- 
2.17.1

