Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379550EDBF
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiDZAsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiDZAsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63752252A2
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:34 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP73L003560
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:33 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeytxke7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:33 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2704018FD8F3C; Mon, 25 Apr 2022 17:45:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/10] libbpf: record subprog-resolved CO-RE relocations unconditionally
Date:   Mon, 25 Apr 2022 17:45:07 -0700
Message-ID: <20220426004511.2691730-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YoqYiXctnltbYcTcAMb8By_djy_UK-ao
X-Proofpoint-ORIG-GUID: YoqYiXctnltbYcTcAMb8By_djy_UK-ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, libbpf recorded CO-RE relocations with insns_idx resolved
according to finalized subprog locations (which are appended at the end
of entry BPF program) to simplify the job of light skeleton generator.

This is necessary because once subprogs' instructions are appended to
main entry BPF program all the subprog instruction indices are shifted
and that shift is different for each entry (main) BPF program, so it's
generally impossible to map final absolute insn_idx of the finalized BPF
program to their original locations inside subprograms.

This information is now going to be used not only during light skeleton
generation, but also to map absolute instruction index to subprog's
instruction and its corresponding CO-RE relocation. So start recording
these relocations always, not just when obj->gen_loader is set.

This information is going to be freed at the end of bpf_object__load()
step, as before (but this can change in the future if there will be
a need for this information post load step).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efc1ea91e12e..5ebbfe8b5e1c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5749,16 +5749,16 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				return -EINVAL;
 			insn = &prog->insns[insn_idx];
 
-			if (prog->obj->gen_loader) {
-				err = record_relo_core(prog, rec, insn_idx);
-				if (err) {
-					pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
-						prog->name, i, err);
-					goto out;
-				}
-				continue;
+			err = record_relo_core(prog, rec, insn_idx);
+			if (err) {
+				pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
+					prog->name, i, err);
+				goto out;
 			}
 
+			if (prog->obj->gen_loader)
+				continue;
+
 			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
@@ -6299,7 +6299,6 @@ bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
 	if (err)
 		return err;
 
-
 	return 0;
 }
 
@@ -6360,8 +6359,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 				err);
 			return err;
 		}
-		if (obj->gen_loader)
-			bpf_object__sort_relos(obj);
+		bpf_object__sort_relos(obj);
 	}
 
 	/* Before relocating calls pre-process relocations and mark
@@ -6421,8 +6419,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
-	if (!obj->gen_loader)
-		bpf_object__free_relocs(obj);
+
 	return 0;
 }
 
@@ -7014,8 +7011,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		if (err)
 			return err;
 	}
-	if (obj->gen_loader)
-		bpf_object__free_relocs(obj);
+
+	bpf_object__free_relocs(obj);
 	return 0;
 }
 
-- 
2.30.2

