Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A504113B567
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgANWoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 17:44:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727102AbgANWoR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 17:44:17 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EMfASC024651
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lZ2kdHZvvLGcEBUy1Chx3DTfdzUPgJ+6m1pBddXozRA=;
 b=LSGU/4ECWY8coLnOoi1kJiUfeIJOkTSJDDlTtrBOyB1FhAyEN+BpLoPj0Ja6m+h7U6Yo
 uKwGCgug6nu+CRDUlbgfXIv98QR9+6JGEJIxqJklOqszfKHWti0BSOYuSQJRqQa/4PFM
 CrjFdEDq/VuaY+izOy004BHgXx3tTdu0HG4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhftutcpg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:16 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 14:44:15 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 210CB29438DC; Tue, 14 Jan 2020 14:44:12 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/5] libbpf: Expose bpf_find_kernel_btf to libbpf_internal.h
Date:   Tue, 14 Jan 2020 14:44:12 -0800
Message-ID: <20200114224412.3028054-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114224358.3027079-1-kafai@fb.com>
References: <20200114224358.3027079-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=13 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140174
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch exposes bpf_find_kernel_btf() to libbpf_internal.h.
It will be used in 'bpftool map dump' in a following patch
to dump a map with btf_vmlinux_value_type_id set.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/lib/bpf/libbpf.c          | 3 +--
 tools/lib/bpf/libbpf_internal.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c229f00a67e..0666d6383285 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -73,7 +73,6 @@
 
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 
-static struct btf *bpf_find_kernel_btf(void);
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static struct bpf_program *bpf_object__find_prog_by_idx(struct bpf_object *obj,
 							int idx);
@@ -4339,7 +4338,7 @@ static struct btf *btf_load_raw(const char *path)
  * Probe few well-known locations for vmlinux kernel image and try to load BTF
  * data out of it to use for target BTF.
  */
-static struct btf *bpf_find_kernel_btf(void)
+struct btf *bpf_find_kernel_btf(void)
 {
 	struct {
 		const char *path_fmt;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 8c3afbd97747..8593954d8f81 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -95,6 +95,7 @@ static inline bool libbpf_validate_opts(const char *opts,
 #define OPTS_GET(opts, field, fallback_value) \
 	(OPTS_HAS(opts, field) ? (opts)->field : fallback_value)
 
+struct btf *bpf_find_kernel_btf(void);
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-- 
2.17.1

