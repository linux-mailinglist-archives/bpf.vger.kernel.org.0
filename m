Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6468D5060E7
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiDSA1y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 18 Apr 2022 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiDSA1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 20:27:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5B13F26
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:10 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23J0Gfrn005834
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:10 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ffugnv2ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:10 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:25:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3A06A1831577C; Mon, 18 Apr 2022 17:24:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: support opting out from autoloading BPF programs declaratively
Date:   Mon, 18 Apr 2022 17:24:50 -0700
Message-ID: <20220419002452.632125-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yAY6aLEJEWu0QCVA01jHVd8iQJ9qxtYH
X-Proofpoint-ORIG-GUID: yAY6aLEJEWu0QCVA01jHVd8iQJ9qxtYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Establish SEC("?abc") naming convention (i.e., adding question mark in
front of otherwise normal section name) that allows to set corresponding
program's autoload property to false. This is effectively just
a declarative way to do bpf_program__set_autoload(prog, false).

Having a way to do this declaratively in BPF code itself is useful and
convenient for various scenarios. E.g., for testing, when BPF object
consists of multiple independent BPF programs that each needs to be
tested separately. Opting out all of them by default and then setting
autoload to true for just one of them at a time simplifies testing code
(see next patch for few conversions in BPF selftests taking advantage of
this new feature).

Another real-world use case is in libbpf-tools for cases when different
BPF programs have to be picked depending on particulars of the host
kernel due to various incompatible changes (like kernel function renames
or signature change, or to pick kprobe vs fentry depending on
corresponding kernel support for the latter). Marking all the different
BPF program candidates as non-autoloaded declaratively makes this more
obvious in BPF source code and allows simpler code in user-space code.

When BPF program marked as SEC("?abc") it is otherwise treated just like
SEC("abc") and bpf_program__section_name() reported will be "abc".

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bf4f7ac54ebf..68cc134d070d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -302,7 +302,7 @@ struct bpf_program {
 	void *priv;
 	bpf_program_clear_priv_t clear_priv;
 
-	bool load;
+	bool autoload;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
@@ -672,7 +672,18 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	prog->insns_cnt = prog->sec_insn_cnt;
 
 	prog->type = BPF_PROG_TYPE_UNSPEC;
-	prog->load = true;
+
+	/* libbpf's convention for SEC("?abc...") is that it's just like
+	 * SEC("abc...") but the corresponding bpf_program starts out with
+	 * autoload set to false.
+	 */
+	if (sec_name[0] == '?') {
+		prog->autoload = false;
+		/* from now on forget there was ? in section name */
+		sec_name++;
+	} else {
+		prog->autoload = true;
+	}
 
 	prog->instances.fds = NULL;
 	prog->instances.nr = -1;
@@ -2927,7 +2938,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->load)
+		if (!prog->autoload)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -5702,7 +5713,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->load)
+			if (!prog->autoload)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -6363,7 +6374,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->load)
+		if (!prog->autoload)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -6378,7 +6389,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->load)
+		if (!prog->autoload)
 			continue;
 		err = bpf_object__relocate_data(obj, prog);
 		if (err) {
@@ -6975,7 +6986,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->load) {
+		if (!prog->autoload) {
 			pr_debug("prog '%s': skipped loading\n", prog->name);
 			continue;
 		}
@@ -8455,7 +8466,7 @@ const char *bpf_program__title(const struct bpf_program *prog, bool needs_copy)
 
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
-	return prog->load;
+	return prog->autoload;
 }
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
@@ -8463,7 +8474,7 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 	if (prog->obj->loaded)
 		return libbpf_err(-EINVAL);
 
-	prog->load = autoload;
+	prog->autoload = autoload;
 	return 0;
 }
 
@@ -12665,7 +12676,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *s->progs[i].prog;
 		struct bpf_link **link = s->progs[i].link;
 
-		if (!prog->load)
+		if (!prog->autoload)
 			continue;
 
 		/* auto-attaching not supported for this program */
-- 
2.30.2

