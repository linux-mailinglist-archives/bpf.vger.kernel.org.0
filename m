Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235B66BFC6
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAPN3V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 08:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAPN3V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 08:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5C166DE
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 05:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C017B80D30
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC162C433EF;
        Mon, 16 Jan 2023 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875757;
        bh=wyJ7iMSlfS+oVwngzPGR/Py9YVoyOqW9cjsjqHgQ6V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKXfBmd8AsZXZfKKJMwiO+6MnBSZENrmJS3yQF3Nq1vKwPq47sffYTm156VQ+nYAq
         Y/RZoumC+ycIwSJIJ3LH+XKirL0iAoj5s7l9eUGAoyV/f6muLnvsIHt6LnfuN1aYF2
         fOy872cO4gDfNrUbxqvcON9Ir7G5TWUxhkBCSHGsFuJxnuU6Zvcm+j5ppLPUnEznAi
         j21oxGnf1cT9ZduxI69lkv4vJkC7gqXQrcHdbD4XRb2OzHDNl/D250Jzyvec62AEAt
         BMMCHJIbpdP09Kd8GuoD3OjwWWBsBfDrh0D6bYCeup4YC9kSG89YU7oCDIRDpmPFg6
         6S5rm9H+TrIDQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 2/2] bpf/selftests: Add verifier tests for loading sleepable programs
Date:   Mon, 16 Jan 2023 14:29:01 +0100
Message-Id: <20230116132901.161494-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132901.161494-1-jolsa@kernel.org>
References: <20230116132901.161494-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding verifier tests for loading all types od allowed
sleepable programs plus reject for tp_btf type.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/verifier/sleepable.c        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sleepable.c

diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
new file mode 100644
index 000000000000..4248c3326b89
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -0,0 +1,91 @@
+{
+	"sleepable fentry accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "bpf_fentry_test1",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable fexit accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "bpf_fentry_test1",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable fmod_ret accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_MODIFY_RETURN,
+	.kfunc = "bpf_fentry_test1",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable iter accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_ITER,
+	.kfunc = "task",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable lsm accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable kprobe accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_KPROBE,
+	.kfunc = "bpf_fentry_test1",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sched_switch",
+	.result = REJECT,
+	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable",
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
-- 
2.39.0

