Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE23670C41
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjAQW6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAQW54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:57:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3B4955C
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD38FB81910
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 22:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED737C433D2;
        Tue, 17 Jan 2023 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673995031;
        bh=JqxSPiwFWKaNaUFj4T/2qf4XtYLCmwBEAPkcZz87Tz8=;
        h=From:To:Cc:Subject:Date:From;
        b=fUJfk1UIzzQioVUp5F1TQ4bM1uVK23r6lgL/sLtugs+wPngtusxBgOfv8uNJw6b6U
         xbURMC1Ouv/jBqIe5k1nY7Xsc5wkoU322x0WWMmIqwhuKTHjGOa8oZ5yEfH8PrMBox
         9poQ9DOC7N/w5SRwwY+EqruUacCahphriQeKb2KyK+F1buzAlbrRYjfgRqq5I/sC9S
         btSDGHH1QRsLTdR8+HDp+PTFc1sbL5aOdeIeSaDFueRUaVObzOuRSdugVKp2kHN449
         TOo/JbTna4w1AZ5yWzWXvvqVqPCz163rOOhbUd3tbyvygA4dgAb/C22H56ykVgWSzQ
         buf1R9B/z1J0g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 1/2] bpf: Do not allow to load sleepable BPF_TRACE_RAW_TP program
Date:   Tue, 17 Jan 2023 23:37:04 +0100
Message-Id: <20230117223705.440975-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Currently we allow to load any tracing program as sleepable,
but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
will fail to load.

Updating the verifier error to mention iter programs as well.

Acked-by: Song Liu <song@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v4 changes:
  - remove kprobe from verifier output and add uprobe comment [Yonghong]
  - added ack [Yonghong]

 kernel/bpf/verifier.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..ca7db2ce70b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
 #endif
 BTF_SET_END(btf_id_deny)
 
+static bool can_be_sleepable(struct bpf_prog *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_TRACING) {
+		switch (prog->expected_attach_type) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_ITER:
+			return true;
+		default:
+			return false;
+		}
+	}
+	return prog->type == BPF_PROG_TYPE_LSM ||
+	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
+}
+
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
@@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
+	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
 		return -EINVAL;
 	}
 
-- 
2.39.0

