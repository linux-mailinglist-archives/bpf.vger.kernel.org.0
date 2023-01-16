Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8CF66BFC5
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjAPN3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAPN3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 08:29:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF8166DE
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 05:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FA0FB80E8F
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 13:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF1DC433EF;
        Mon, 16 Jan 2023 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875747;
        bh=3zIvWmBmPnQmML9Gmp0G0efe/r3iDOETiDWpXFRZxTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LBUuPOoM4TNvd39ouvHgReBA128XrBj4r+55O/30eI/tQkPXHkkLxFEjFPt800KwA
         T+EBTu6l3VQzNv5iUHbdcEZ7aQQp7gCWpdj1RxCOipGJJkDbENhIHkQ+rgAWIJ5KHG
         xtMITr7jJcRffL6q16MAf2haJl9x4FUsN/OGcOaNcOWFkKHgVwBlqpvU+zjJXL28er
         QT90x9eDTdOM/b74DoaSre4TCBFN+yBV9+3ilIe9izhWhPzfj8nG+i5d03sbId4zOV
         1iaElEDI4ROdg/n5C9NE8Cg/vqcpDcgH/4BU4p0REJLzoK4EvKKSYxjDjuRB3hastU
         LORXXbftSwmiQ==
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
Subject: [PATCHv3 bpf-next 1/2] bpf: Do not allow to load sleepable BPF_TRACE_RAW_TP program
Date:   Mon, 16 Jan 2023 14:29:00 +0100
Message-Id: <20230116132901.161494-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
  - use switch in can_be_sleepable [Alexei]
  - added acks [Song]

 kernel/bpf/verifier.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..966dbfc14288 100644
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
+	       prog->type == BPF_PROG_TYPE_KPROBE;
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
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
 		return -EINVAL;
 	}
 
-- 
2.39.0

