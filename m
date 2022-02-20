Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53534BCBB2
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiBTCcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:32:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBTCcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:32:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818EFEE
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:31:42 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s16so11190865pgs.13
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCsFJtDhvumP2msYy4lDXjAdUToA6Oz/Hwnl6SC/cHU=;
        b=JazDptIf5X697ltEu2DW2yjMGOiExErnZ+al9MWftPLlyGUk9PY567XkhEbqaSubzH
         H007ebZZltf1jXHSSqQPvDVPiIN61LbYYD2Vbw1WwT1VVCaq/qBg498Wu6PAgexOUYef
         V8/KbTMuFy1gS1YLCMxgEz++m9w9Gh9PWZkviM77W86fszql4igBJX8CukdjCklVfF+Y
         uCmAnpg2fD81bihm1rn3UYxRJYlmryA2gRK0AIQwae4gGpJecKlEr4tirTeCrorRXiFd
         bsJMQHL04MXPjpxxsNtkxXJplB9N92bfArHCb5n77hcC9c2O8Ql/Rr4dszjwlFGAm6YA
         ivqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCsFJtDhvumP2msYy4lDXjAdUToA6Oz/Hwnl6SC/cHU=;
        b=tGoVz1kATbWdWKbIWVDh1IUFjOK8KebNcRVtqVY4MpqSE9J/IGHWrwp0MCjOE1xVAO
         HfN1mlK4rgBnY7QMh+56zgqkmF0IHTQyV7qLbWJNnc2RdN3/kSel7IpdF7Q8H4nOg3QE
         tb66fy6C+1zhbUndEqR5LcT2ddyfx5Ef+M8MBDUKzw//bXOo/9hiduTSupqatKUTc6Sh
         DEyS5fP1tiv3+8JtKDhg71r0z7S/spLxkzVnTZ6kwYGCGvII67uDVDyxXlL2UECnuGK2
         kZF452nbEsM4kOS9qA15O2eb0V/6WIaiyEE1GzzBjRWCHmQKakG1nZoNw2Yhp8jSslnN
         FlCA==
X-Gm-Message-State: AOAM531yEBpDYGODr8nKLkpfYcdLaaCRzBajfMSLyWKa5RxqbFZYaLYi
        UrZ+wuGEOA1CDDM09VcsFCduQTiO6gY=
X-Google-Smtp-Source: ABdhPJySed83LeagtLPQm/oulhr0NfAiDEUFetwp7OD6hEURErHeECCgcpw4D9uVFjVbEPBp+qzcRg==
X-Received: by 2002:a05:6a00:1c47:b0:4e1:2c3a:ac3d with SMTP id s7-20020a056a001c4700b004e12c3aac3dmr14131724pfw.15.1645324301943;
        Sat, 19 Feb 2022 18:31:41 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id x7sm7780994pfh.216.2022.02.19.18.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:31:41 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add test for reg2btf_ids out of bounds access
Date:   Sun, 20 Feb 2022 08:01:38 +0530
Message-Id: <20220220023138.2224652-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test tries to pass a PTR_TO_BTF_ID_OR_NULL to the release function,
which would trigger a out of bounds access without the fix in commit
45ce4b4f9009 ("bpf: Fix crash due to out of bounds access into reg2btf_ids.")
but after the fix, it should only index using base_type(reg->type),
which should be less than __BPF_REG_TYPE_MAX, and also not permit any
type flags to be set for the reg->type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 829be2b9e08e..0a8ea60c2a80 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -96,6 +96,25 @@
 		{ "bpf_kfunc_call_test_mem_len_fail1", 2 },
 	},
 },
+{
+	"calls: trigger reg2btf_ids[reg->type] for reg->type > __BPF_REG_TYPE_MAX",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 5 },
+	},
+},
 {
 	"calls: basic sanity",
 	.insns = {
--
2.35.1

