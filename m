Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55F47D984
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 00:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhLVXKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Dec 2021 18:10:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242264AbhLVXKK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 18:10:10 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHxjSn020449
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 15:10:09 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d3sfjfekp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 15:10:09 -0800
Received: from twshared4941.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 15:10:08 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4467BDE7089D; Wed, 22 Dec 2021 15:10:04 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: improve LINUX_VERSION_CODE detection
Date:   Wed, 22 Dec 2021 15:10:03 -0800
Message-ID: <20211222231003.2334940-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XfqX0RcnY9_j2Ndc66jIS95IPfisqO3S
X-Proofpoint-GUID: XfqX0RcnY9_j2Ndc66jIS95IPfisqO3S
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ubuntu reports incorrect kernel version through uname(), which on older
kernels leads to kprobe BPF programs failing to load due to the version
check mismatch.

Accommodate Ubuntu's quirks with LINUX_VERSION_CODE by using
Ubuntu-specific /proc/version_code to fetch major/minor/patch versions
to form LINUX_VERSION_CODE.

While at it, consolide libbpf's kernel version detection code between
libbpf.c and libbpf_probes.c.

  [0] Closes: https://github.com/libbpf/libbpf/issues/421

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 27 ++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 tools/lib/bpf/libbpf_probes.c   | 16 ----------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cf862a19222b..9cb99d1e2385 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -795,11 +795,36 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
-static __u32 get_kernel_version(void)
+__u32 get_kernel_version(void)
 {
+	/* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
+	 * but Ubuntu provides /proc/version_signature file, as described at
+	 * https://ubuntu.com/kernel, with an example contents below, which we
+	 * can use to get a proper LINUX_VERSION_CODE.
+	 *
+	 *   Ubuntu 5.4.0-12.15-generic 5.4.8
+	 *
+	 * In the above, 5.4.8 is what kernel is actually expecting, while
+	 * uname() call will return 5.4.0 in info.release.
+	 */
+	const char *ubuntu_kver_file = "/proc/version_signature";
 	__u32 major, minor, patch;
 	struct utsname info;
 
+	if (access(ubuntu_kver_file, R_OK) == 0) {
+		FILE *f;
+
+		f = fopen(ubuntu_kver_file, "r");
+		if (f) {
+			if (fscanf(f, "%*s %*s %d.%d.%d\n", &major, &minor, &patch) == 3) {
+				fclose(f);
+				return KERNEL_VERSION(major, minor, patch);
+			}
+			fclose(f);
+		}
+		/* something went wrong, fall back to uname() approach */
+	}
+
 	uname(&info);
 	if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 5dbe4f463880..1565679eb432 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -188,6 +188,8 @@ static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
 	dst[i] = '\0';
 }
 
+__u32 get_kernel_version(void);
+
 struct btf;
 struct btf_type;
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9d3985283dfc..97b06cede56f 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -48,22 +48,6 @@ static int get_vendor_id(int ifindex)
 	return strtol(buf, NULL, 0);
 }
 
-static int get_kernel_version(void)
-{
-	int version, subversion, patchlevel;
-	struct utsname utsn;
-
-	/* Return 0 on failure, and attempt to probe with empty kversion */
-	if (uname(&utsn))
-		return 0;
-
-	if (sscanf(utsn.release, "%d.%d.%d",
-		   &version, &subversion, &patchlevel) != 3)
-		return 0;
-
-	return (version << 16) + (subversion << 8) + patchlevel;
-}
-
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
 			   char *log_buf, size_t log_buf_sz,
-- 
2.30.2

