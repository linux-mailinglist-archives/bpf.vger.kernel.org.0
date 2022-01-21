Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBC495776
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378439AbiAUAlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 19:41:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378438AbiAUAla (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 19:41:30 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L06aL2008959
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:30 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqj0c84wa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:30 -0800
Received: from twshared14140.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 20 Jan 2022 16:41:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CF774FCAD2AA; Thu, 20 Jan 2022 16:41:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/7] libbpf: deprecate bpf_program__is_<type>() and bpf_program__set_<type>() APIs
Date:   Thu, 20 Jan 2022 16:41:11 -0800
Message-ID: <20220121004115.3845888-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121004115.3845888-1-andrii@kernel.org>
References: <20220121004115.3845888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: H66lnaNeFHvooccxXAglZLNvpi_nXZ2g
X-Proofpoint-ORIG-GUID: H66lnaNeFHvooccxXAglZLNvpi_nXZ2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1034 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=896 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Not sure why these APIs were added in the first place instead of
a completely generic (and not requiring constantly adding new APIs with
each new BPF program type) bpf_program__type() and
bpf_program__set_type() APIs. But as it is right now, there are 13 such
specialized is_type/set_type APIs, while latest kernel is already at 30+
BPF program types.

Instead of completing the set of APIs and keep chasing kernel's
bpf_prog_type enum, deprecate existing subset and recommend generic
bpf_program__type() and bpf_program__set_type() APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6f8e6b3cff84..572b3b967c0d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -591,18 +591,31 @@ LIBBPF_API int bpf_program__nth_fd(const struct bpf_program *prog, int n);
 /*
  * Adjust type of BPF program. Default is kprobe.
  */
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_socket_filter(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_tracepoint(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_raw_tracepoint(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_kprobe(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
@@ -631,18 +644,31 @@ LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
 
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_kprobe(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__type() instead")
 LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog);
 
 /*
-- 
2.30.2

