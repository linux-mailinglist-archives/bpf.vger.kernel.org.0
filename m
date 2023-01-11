Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3516658BA
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbjAKKNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjAKKM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA57D6B
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 02:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 690CBCE1AA2
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 10:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C3C433EF;
        Wed, 11 Jan 2023 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673431917;
        bh=4bKaK2zLXESHKi43ChDclvB+QiofVA67MwSl7Xi5zcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/TqRJEkT+SWI4dm6Z1E0e+q4QPK0ywjCYuA3G7wH+bFOU68AHhEaPG8EeR1HSwy/
         B7/7XZEAVcAbKEnywYTbQhj6l8vGTFHuDaqtf7ufVOJDxp6k6IMWRjkYfA+lGfc6ub
         Ln+kchPu5FiHhb9DS8uX4ufn2TeRgm2YUTmdcSZB3gkqOQ12rerH9E4oFqvzBD4JtN
         PDkKC012xqUehe6sSxF4AkghKRwWsa+d/3F/IEOo8qCvXKWJqLRS+5McqkwaHglThw
         7q/u+aFX1DvMZDdA76WJqwuBaoMIctVT3m+bO6V/w3Leirgsw7yG2BEArghw7dv441
         kRu8D5lGM0org==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 2/2] bpf/selftests: Add verifier tests for loading sleepable programs
Date:   Wed, 11 Jan 2023 11:11:42 +0100
Message-Id: <20230111101142.562765-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111101142.562765-1-jolsa@kernel.org>
References: <20230111101142.562765-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/verifier/sleepable.c        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sleepable.c

diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
new file mode 100644
index 000000000000..15da44f7ac8a
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
+	"sleepable kprobe/uprobe accept",
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

