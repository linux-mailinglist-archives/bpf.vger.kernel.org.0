Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7340D17E
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhIPCAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56414 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhIPCAT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3vli015240
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:59:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3my2b203-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:59 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 498AA422A295; Wed, 15 Sep 2021 18:58:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/7] libbpf: schedule open_opts.attach_prog_fd deprecation since v0.7
Date:   Wed, 15 Sep 2021 18:58:35 -0700
Message-ID: <20210916015836.1248906-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: drC-eFFjaYXY7DhVBxBdNRiQ21eAwQQ2
X-Proofpoint-ORIG-GUID: drC-eFFjaYXY7DhVBxBdNRiQ21eAwQQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object_open_opts.attach_prog_fd makes a pretty strong assumption
that bpf_object contains either only single freplace BPF program or all
of BPF programs in BPF object are freplaces intended to replace
different subprograms of the same target BPF program. This seems both
a bit confusing, too assuming, and limiting.

We've had bpf_program__set_attach_target() API which allows more
fine-grained control over this, on a per-program level. As such, mark
open_opts.attach_prog_fd as deprecated starting from v0.7, so that we
have one more universal way of setting freplace targets. With previous
change to allow NULL attach_func_name argument, and especially combined
with BPF skeleton, arguable bpf_program__set_attach_target() is a more
convenient and explicit API as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 3 +++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf_common.h | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 552d05a85cbb..6aeeb0e82acc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6415,9 +6415,12 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		bpf_program__set_type(prog, prog->sec_def->prog_type);
 		bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 		if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
 		    prog->sec_def->prog_type == BPF_PROG_TYPE_EXT)
 			prog->attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
+#pragma GCC diagnostic pop
 	}
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 7111e8d651de..52b7ee090037 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -90,6 +90,8 @@ struct bpf_object_open_opts {
 	 * auto-pinned to that path on load; defaults to "/sys/fs/bpf".
 	 */
 	const char *pin_root_path;
+
+	LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__set_attach_target() on each individual bpf_program")
 	__u32 attach_prog_fd;
 	/* Additional kernel config content that augments and overrides
 	 * system Kconfig for CONFIG_xxx externs.
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 36ac77f2bea2..aaa1efbf6f51 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -35,6 +35,11 @@
 #else
 #define __LIBBPF_MARK_DEPRECATED_0_6(X)
 #endif
+#if __LIBBPF_CURRENT_VERSION_GEQ(0, 7)
+#define __LIBBPF_MARK_DEPRECATED_0_7(X) X
+#else
+#define __LIBBPF_MARK_DEPRECATED_0_7(X)
+#endif
 
 /* Helper macro to declare and initialize libbpf options struct
  *
-- 
2.30.2

