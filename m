Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAC578A51
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiGRTH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiGRTHz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 15:07:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A32FFCC
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 12:07:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090aac1500b001ef977190efso9899178pjq.7
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b93WATLSeb+/8lgQq53Rq+szbQ0R4RtxaRS2/OmpcSA=;
        b=gH3eKz1pfooEPO8kIjiB125JT6ieDEUXTQLieuOG0YXR91/nyukom7FRIyTzilr0Wy
         W8/rJbrjpicLW0i0TjQ/qfwSyQL0XPxPCgkFP5JkD75dbfi/pRHTm9oyH1cN24JlOsmR
         Fg/Hljh36/7ZZMSjY4t/IBDd2rY4FPq1umojFRbv8LiAeZrhanuNvtjweQhmmAPqOT+M
         82pkY9ztfH8nkkmOYzAfqQsR9Vi+OZSmwIkcRnE0uof0P0TsfiYz6gnfO5LfVIbmrHhD
         KydmWTqp62zDRfv56FCCd1uF7hEhslvrI6CvPPfwFQUH0Q9PIQIJ9Efo5Mj3/JpBZmvO
         hd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b93WATLSeb+/8lgQq53Rq+szbQ0R4RtxaRS2/OmpcSA=;
        b=caFK12/SlmgZis0QqdGl3ggHFWf8p3PXrkw1B/1q6ZLIXeiQ270obDH2toKEEIgJyj
         G7RCi6wS1YJmhgsXcCPbkdlNUtNwOqB77K1v8TfbIOyITgoxxb0dZBNsF6v/dQxorTjW
         24g937LFTDQFo/4Beq1c71o+PsZU+2QA4bJYrFHZNIptyBlxNua8lk/D0Cc2mkIOXleQ
         J8JUhUBVVS/GG/8LUKpeSE0GDjVNLSChQOmCj0yETpdkpujbZpXe1jeRXSuTRttPu+w8
         tBs5RC8RAagXgOMlZBO2cvVHbf3A7OguzmRYO9dx8/uWEashu9yZumoKediNxzaRT1nf
         rrlg==
X-Gm-Message-State: AJIora+XbvgHZTqMgzXP8ly8GDvHxrUqexcaQfjN7H5l63oCEEyJ72VK
        p4SXEFSXnr4BfxVKl6XPU31RtSjO2RZBHJjUQGLS72x9rkYEXJh2Xo2U1KyaJycYiyM8pqoBj4y
        7DAYnI6faBgEPmKD/rCHooE9ywCUo6VWvMhZ9gi7d1TXXdajb7Q==
X-Google-Smtp-Source: AGRyM1uHZnyYsRKwlklm3KgGUPQhsj4APKl/XbxRMbyzp3JeVFnFceazfhT1T6PgqEoimaOVUck2mmM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:7884:b0:16d:7cc:fdd2 with SMTP id
 q4-20020a170902788400b0016d07ccfdd2mr392727pll.36.1658171270375; Mon, 18 Jul
 2022 12:07:50 -0700 (PDT)
Date:   Mon, 18 Jul 2022 12:07:48 -0700
Message-Id: <20220718190748.2988882-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Motivation:

Our bpf programs have a bunch of options which are set at the loading
time. After loading, they don't change. We currently use array map
to store them and bpf program does the following:

val = bpf_map_lookup_elem(&config_map, &key);
if (likely(val && *val)) {
  // do some optional feature
}

Since the configuration is static and we have a lot of those features,
I feel like we're wasting precious cycles doing dynamic lookups
(and stalling on memory loads).

I was assuming that converting those to some fake kconfig options
would solve it, but it still seems like kconfig is stored in the
global map and kconfig entries are resolved dynamically.

Proposal:

Resolve kconfig options statically upon loading. Basically rewrite
ld+ldx to two nops and 'mov val, x'.

I'm also trying to rewrite conditional jump when the condition is
!imm. This seems to be catching all the cases in my program, but
it's probably too hacky.

I've attached very raw RFC patch to demonstrate the idea. Anything
I'm missing? Any potential problems with this approach?
Note, I don't intent to submit as is, mostly to start a discussion..

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/prog.c |  3 +++
 tools/lib/bpf/libbpf.c   | 43 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f081de398b60..89d11b891735 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1596,6 +1596,9 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		/* log_level1 + log_level2 + stats, but not stable UAPI */
 		open_opts.kernel_log_level = 1 + 2 + 4;
 
+	if (getenv("BPFTOOL_KCONFIG"))
+		open_opts.kconfig = getenv("BPFTOOL_KCONFIG");
+
 	obj = bpf_object__open_file(file, &open_opts);
 	if (libbpf_get_error(obj)) {
 		p_err("failed to open object file");
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 77ae83308199..58b45eb9a30a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5773,11 +5773,48 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 				if (obj->gen_loader) {
 					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 					insn[0].imm = obj->kconfig_map_idx;
+					insn[1].imm = ext->kcfg.data_off;
 				} else {
-					insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
-					insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+					bool is_set = ext->is_weak && ext->is_set;
+					bool is_ld_ldx = (BPF_CLASS(insn[0].code) == BPF_LD) &&
+						         insn[1].code == 0 &&
+							 (BPF_CLASS(insn[2].code) == BPF_LDX);
+
+					if (is_set && is_ld_ldx) {
+						__u32 dst_reg = insn[2].dst_reg; /* dst_reg is unchanged */
+						__s32 imm = 1; /* TODO: put real config value here */
+						int j;
+
+						/* Resolve dynamic kconfig lookups. */
+						insn[0] = BPF_JMP_A(0);
+						insn[1] = BPF_JMP_A(0);
+						insn[2] = BPF_ALU64_IMM(BPF_MOV, dst_reg, imm);
+
+						/* Look ahead at 7 insns. */
+						for (j = 3; j < 10; j++) {
+							/* SKETCHY?
+							 *
+							 * We can also replace conditional jump when it triggers with the opposite value.
+							 * Scan a bunch of insns and stop as long we hit a jump or some other
+							 * operation on the dst_reg.
+							 */
+							if (BPF_CLASS(insn[j].code) == BPF_JMP) {
+								/* next insn is jump */
+								if (insn[j].dst_reg == dst_reg && /* that operates on the same dst_reg */
+								    insn[j].imm == !imm) /* and the imm is the opposite */
+									insn[j] = BPF_JMP_A(0);
+								break;
+							} else {
+								if (insn[j].dst_reg == dst_reg)
+									break;
+							}
+						}
+					} else {
+						insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+						insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+						insn[1].imm = ext->kcfg.data_off;
+					}
 				}
-				insn[1].imm = ext->kcfg.data_off;
 			} else /* EXT_KSYM */ {
 				if (ext->ksym.type_id && ext->is_set) { /* typed ksyms */
 					insn[0].src_reg = BPF_PSEUDO_BTF_ID;
-- 
2.37.0.170.g444d1eabd0-goog

