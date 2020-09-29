Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9827BAA3
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 04:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgI2CFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 22:05:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15264 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbgI2CFr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Sep 2020 22:05:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T25aw1001213
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 19:05:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rHWs9nT/CK0CxOtWXUm42JeH+PPBxwpdrUgICApbBoY=;
 b=QOok148R0h+VytgTQGK2ptI54Hm7x2XiFUKsgwI0uGzYw7dfoZJl4wN4vUKR7S3X3V3k
 47TK2JTvNOeoXbaBFOC7GBW0isDQcc/PtkqhDoURePz6YuvgeaDNMTrOOOKbaIx5lvUw
 AkepqNPoSFehAZiafBdREyM80Tn62CjrrSc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t35n2m6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 19:05:46 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 19:05:46 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0513F2EC773C; Mon, 28 Sep 2020 19:05:40 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v3 bpf-next 2/3] libbpf: add btf__str_by_offset() as a more generic variant of name_by_offset
Date:   Mon, 28 Sep 2020 19:05:31 -0700
Message-ID: <20200929020533.711288-3-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929020533.711288-1-andriin@fb.com>
References: <20200929020533.711288-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-28,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=837
 mlxscore=0 lowpriorityscore=0 suspectscore=8 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF strings are used not just for names, they can be arbitrary strings us=
ed
for CO-RE relocations, line/func infos, etc. Thus "name_by_offset" termin=
ology
is too specific and might be misleading. Instead, introduce
btf__str_by_offset() API which uses generic string terminology.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c      | 7 ++++++-
 tools/lib/bpf/btf.h      | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7533088b2524..2d0b1e12f50e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1025,7 +1025,7 @@ const void *btf__get_raw_data(const struct btf *btf=
_ro, __u32 *size)
 	return btf->raw_data;
 }
=20
-const char *btf__name_by_offset(const struct btf *btf, __u32 offset)
+const char *btf__str_by_offset(const struct btf *btf, __u32 offset)
 {
 	if (offset < btf->hdr->str_len)
 		return btf->strs_data + offset;
@@ -1033,6 +1033,11 @@ const char *btf__name_by_offset(const struct btf *=
btf, __u32 offset)
 		return NULL;
 }
=20
+const char *btf__name_by_offset(const struct btf *btf, __u32 offset)
+{
+	return btf__str_by_offset(btf, offset);
+}
+
 int btf__get_from_id(__u32 id, struct btf **btf)
 {
 	struct bpf_btf_info btf_info =3D { 0 };
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index d6629a2e8ebf..f7dec0144c3c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -49,6 +49,7 @@ LIBBPF_API int btf__fd(const struct btf *btf);
 LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
 LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *s=
ize);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 =
offset);
+LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 o=
ffset);
 LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *m=
ap_name,
 				    __u32 expected_key_size,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0216ee6fdc2b..6b10ebad69c6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -327,6 +327,7 @@ LIBBPF_0.2.0 {
 		btf__add_volatile;
 		btf__find_str;
 		btf__new_empty;
+		btf__str_by_offset;
 		perf_buffer__buffer_cnt;
 		perf_buffer__buffer_fd;
 		perf_buffer__epoll_fd;
--=20
2.24.1

