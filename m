Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F66658BF
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbjAKKNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjAKKM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946442FA
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 02:11:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3216861A60
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 10:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17728C433D2;
        Wed, 11 Jan 2023 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673431907;
        bh=1PezASlaasCWebQPXVq06nV/1bPhh8gD2i8bkw7uUOg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTC2daE/WVB3HU0vd7n4H4jP+8D+ilBHt52xD7uYdof8hzTHDH/M2ddJRwHmrsI5U
         6kaHAZJc8MJ24KOts7MKXuCypJOj53PrSBhftn+yz7P/GG/G3Glt27/7ujCtz4Zvai
         Gam36S6jarOZyOYX1ulW9f5tdZyqf3Pa7xXJ/oP6tFFnXbE7uVz8+OZdCCt7W2V1aK
         HXa3ShCK94JI6Z3NDGAW+LGPrWU4ZXHHoaXoeOQ22xlZqVt4kFnTymZaRU5N/e9P33
         FmRKghHEM/PiJMlEWgPDwP6+DAzJ33y2wbnIlfFLIujtj6dApmJPXsTRAatnY038DA
         0t+TKsIDft/ew==
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
Subject: [PATCHv2 bpf-next 1/2] bpf: Do not allow to load sleepable BPF_TRACE_RAW_TP program
Date:   Wed, 11 Jan 2023 11:11:41 +0100
Message-Id: <20230111101142.562765-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - use bool for can_be_sleepable return value [Song]
  - add tests [Song]

 kernel/bpf/verifier.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..f20777c2a957 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16743,6 +16743,18 @@ BTF_ID(func, rcu_read_unlock_strict)
 #endif
 BTF_SET_END(btf_id_deny)
 
+static bool can_be_sleepable(struct bpf_prog *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_TRACING) {
+		return prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		       prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		       prog->expected_attach_type == BPF_MODIFY_RETURN ||
+		       prog->expected_attach_type == BPF_TRACE_ITER;
+	}
+	return prog->type == BPF_PROG_TYPE_LSM ||
+	       prog->type == BPF_PROG_TYPE_KPROBE;
+}
+
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
@@ -16761,9 +16773,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
+	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
 		return -EINVAL;
 	}
 
-- 
2.39.0

