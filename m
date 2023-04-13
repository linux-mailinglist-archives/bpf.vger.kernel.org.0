Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0900F6E04E2
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDMCxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDMCxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 22:53:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0C19A7
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:52:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u4so9342707qvj.10
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681354379; x=1683946379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiB7A8AuZoCmy0cdJV+Hevxq7uUYdvaYfcw9wn9xlFM=;
        b=BXH0+7BnaARuyjWjfuCcv3jty2ea/oxZ3ZN3XRl0h0kOw0oXOHbRD6b4zdw84o6uXP
         XKabY5N7EDVxkHql/OIzzvHtdeBIiuc6pbcAqQpYYJG9tqXHXHu0+8y37D8WOi9EupyC
         12bS5TNKYQJGTTAJPF5zcOeLnNlzlwf61l9EI5NC1ZvQPP9jtiRmZl9puBfkfizzRB4y
         c7tj2Jw3uA8C1OnukwvIOOUdOrD0xAOyYAKxQ8IVCrC1zpAzZWZFTHXeCnRHg8KtanxS
         usUb0NCxCqr83ONtDfcjkSCqbuC6F+Db+hNGngIVN4UmGNvlzQJla60t7FL48FFeQHpA
         wDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681354379; x=1683946379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiB7A8AuZoCmy0cdJV+Hevxq7uUYdvaYfcw9wn9xlFM=;
        b=c63cazKwMmIT57XECO5EP2AfBmre7sIB+fSzs3ArW1ZHgwC9gF1lfWAPuF0dePaDAp
         PsGLQxbiaN/fsJb0jqkJ3bE+3D/mpOykDTBXDG4JSBiz5oRAgXPVtfs5iTePObS4chwl
         Cv888IzAqpYY6n9K9I/N7Zs6IzQOErbVsjhi5Vk8eeo8ymxgQ2j7OxkXJfhQwz7iymBE
         6XhNAmUPiBGKn9oEhHhpR/FmVvrSo8qlq97jUorlEqweOV+TnrgES1npU9S7S2+y7pfe
         xNVl13uVxltN4u6LxbuDIMy6KFVAtIXgyt4jPxjRMVlPvCS+fd2xFamtOhKXNTfRdMF1
         zBUA==
X-Gm-Message-State: AAQBX9dXJoZ11Uw6pnqFt3TSCklDLZvc4Ib0dzmPeJZ8RLFzaWMecArT
        9xfVLi2881E5/niSKii2/hU=
X-Google-Smtp-Source: AKy350YGXE7zq9YVgZuHAm5KmdXRmLdPaxyeHnMm8UWbgqnp9R7aNBZoSPsVk8kIYxJFSadAtq7fZg==
X-Received: by 2002:a05:6214:2683:b0:5a9:ed32:1765 with SMTP id gm3-20020a056214268300b005a9ed321765mr1269139qvb.23.1681354378904;
        Wed, 12 Apr 2023 19:52:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:c:fe2:5400:4ff:fe65:32a4])
        by smtp.gmail.com with ESMTPSA id pp26-20020a056214139a00b005dd8b934571sm121424qvb.9.2023.04.12.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 19:52:58 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, Yafang <laoar.shao@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH bpf-next] bpf: Add preempt_count_{sub,add} into btf id deny list
Date:   Thu, 13 Apr 2023 02:52:48 +0000
Message-Id: <20230413025248.79764-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yafang <laoar.shao@gmail.com>

The recursion check in __bpf_prog_enter* and __bpf_prog_exit*
leave preempt_count_{sub,add} unprotected. When attaching trampoline to
them we get panic as follows,

[  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf (stack is 0000000046a46a15..00000000537e7b28)
[  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.2.0+ #4
[  867.843100] Call Trace:
[  867.843101]  <TASK>
[  867.843104]  asm_exc_int3+0x3a/0x40
[  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
[  867.843135]  __bpf_prog_enter_recur+0x17/0x90
[  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
[  867.843154]  ? preempt_count_sub+0x1/0xa0
[  867.843157]  preempt_count_sub+0x5/0xa0
[  867.843159]  ? migrate_enable+0xac/0xf0
[  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
...
[  867.843788]  preempt_count_sub+0x5/0xa0
[  867.843793]  ? migrate_enable+0xac/0xf0
[  867.843829]  __bpf_prog_exit_recur+0x2d/0x40
[  867.843837] BUG: IRQ stack guard page was hit at 0000000099bd8228 (stack is 00000000b23e2bc4..000000006d95af35)
[  867.843841] BUG: IRQ stack guard page was hit at 000000005ae07924 (stack is 00000000ffd69623..0000000014eb594c)
[  867.843843] BUG: IRQ stack guard page was hit at 00000000028320f0 (stack is 00000000034b6438..0000000078d1bcec)
[  867.843842]  bpf_trampoline_6442468108_0+0x55/0x1000
...

That is because in __bpf_prog_exit_recur, the preempt_count_{sub,add} are
called after prog->active is decreased.

Fixing this by adding these two functions into btf ids deny list.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yafang <laoar.shao@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3660b57..8159bd7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18651,6 +18651,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
 #endif
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+BTF_ID(func, preempt_count_add)
+BTF_ID(func, preempt_count_sub)
+#endif
 BTF_SET_END(btf_id_deny)
 
 static bool can_be_sleepable(struct bpf_prog *prog)
-- 
1.8.3.1

