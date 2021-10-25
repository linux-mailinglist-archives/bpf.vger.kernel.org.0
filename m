Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2182843A6CA
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhJYWsD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Oct 2021 18:48:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232470AbhJYWsD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:48:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiVlX001549
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7ggxr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:40 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:45:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3917D74E6645; Mon, 25 Oct 2021 15:45:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] libbpf: add ability to fetch bpf_program's underlying instructions
Date:   Mon, 25 Oct 2021 15:45:29 -0700
Message-ID: <20211025224531.1088894-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025224531.1088894-1-andrii@kernel.org>
References: <20211025224531.1088894-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kgSlejxPr3BLN2F0uxo8VyeGkAMg9ArK
X-Proofpoint-ORIG-GUID: kgSlejxPr3BLN2F0uxo8VyeGkAMg9ArK
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add APIs providing read-only access to bpf_program BPF instructions ([0]).
This is useful for diagnostics purposes, but it also allows a cleaner
support for cloning BPF programs after libbpf did all the FD resolution
and CO-RE relocations, subprog instructions appending, etc. Currently,
cloning BPF program is possible only through hijacking a half-broken
bpf_program__set_prep() API, which doesn't really work well for anything
but most primitive programs. For instance, set_prep() API doesn't allow
adjusting BPF program load parameters which are necessary for loading
fentry/fexit BPF programs (the case where BPF program cloning is
a necessity if doing some sort of mass-attachment functionality).

Given bpf_program__set_prep() API is set to be deprecated, having
a cleaner alternative is a must. libbpf internally already keeps track
of linear array of struct bpf_insn, so it's not hard to expose it. The
only gotcha is that libbpf previously freed instructions array during
bpf_object load time, which would make this API much less useful overall,
because in between bpf_object__open() and bpf_object__load() a lot of
changes to instructions are done by libbpf.

So this patch makes libbpf hold onto prog->insns array even after BPF
program loading. I think this is a small price for added functionality
and improved introspection of BPF program code.

See retsnoop PR ([1]) for how it can be used in practice and code
savings compared to relying on bpf_program__set_prep().

  [0] Closes: https://github.com/libbpf/libbpf/issues/298
  [1] https://github.com/anakryiko/retsnoop/pull/1

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 12 ++++++++++--
 tools/lib/bpf/libbpf.h   | 36 ++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e27a249d46fb..dc86ad24dfcb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6653,8 +6653,6 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 out:
 	if (err)
 		pr_warn("failed to load program '%s'\n", prog->name);
-	zfree(&prog->insns);
-	prog->insns_cnt = 0;
 	return libbpf_err(err);
 }
 
@@ -8143,6 +8141,16 @@ size_t bpf_program__size(const struct bpf_program *prog)
 	return prog->insns_cnt * BPF_INSN_SZ;
 }
 
+const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
+{
+	return prog->insns;
+}
+
+size_t bpf_program__insn_cnt(const struct bpf_program *prog)
+{
+	return prog->insns_cnt;
+}
+
 int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
 			  bpf_program_prep_t prep)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 89ca9c83ed4e..c6bcc5b98906 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -226,6 +226,40 @@ LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload
 /* returns program size in bytes */
 LIBBPF_API size_t bpf_program__size(const struct bpf_program *prog);
 
+struct bpf_insn;
+
+/**
+ * @brief **bpf_program__insns()** gives read-only access to BPF program's
+ * underlying BPF instructions.
+ * @param prog BPF program for which to return instructions
+ * @return a pointer to an array of BPF instructions that belong to the
+ * specified BPF program
+ *
+ * Returned pointer is always valid and not NULL. Number of `struct bpf_insn`
+ * pointed to can be fetched using **bpf_program__insn_cnt()** API.
+ *
+ * Keep in mind, libbpf can modify and append/delete BPF program's
+ * instructions as it processes BPF object file and prepares everything for
+ * uploading into the kernel. So depending on the point in BPF object
+ * lifetime, **bpf_program__insns()** can return different sets of
+ * instructions. As an example, during BPF object load phase BPF program
+ * instructions will be CO-RE-relocated, BPF subprograms instructions will be
+ * appended, ldimm64 instructions will have FDs embedded, etc. So instructions
+ * returned before **bpf_object__load()** and after it might be quite
+ * different.
+ */
+LIBBPF_API const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog);
+/**
+ * @brief **bpf_program__insn_cnt()** returns number of `struct bpf_insn`'s
+ * that form specified BPF program.
+ * @param prog BPF program for which to return number of BPF instructions
+ *
+ * See **bpf_program__insns()** documentation for notes on how libbpf can
+ * change instructions and their count during different phases of
+ * **bpf_object** lifetime.
+ */
+LIBBPF_API size_t bpf_program__insn_cnt(const struct bpf_program *prog);
+
 LIBBPF_API int bpf_program__load(struct bpf_program *prog, char *license,
 				 __u32 kern_version);
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
@@ -365,8 +399,6 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts);
 
-struct bpf_insn;
-
 /*
  * Libbpf allows callers to adjust BPF programs before being loaded
  * into kernel. One program in an object file can be transformed into
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 116964a29e44..15239c05659c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -393,6 +393,8 @@ LIBBPF_0.6.0 {
 		bpf_object__next_program;
 		bpf_object__prev_map;
 		bpf_object__prev_program;
+		bpf_program__insn_cnt;
+		bpf_program__insns;
 		btf__add_btf;
 		btf__add_decl_tag;
 		btf__raw_data;
-- 
2.30.2

