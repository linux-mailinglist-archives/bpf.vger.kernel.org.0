Return-Path: <bpf+bounces-17-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F16F76B0
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B257C280A9D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D1182B7;
	Thu,  4 May 2023 19:49:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30776182B3
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:49:48 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5211611;
	Thu,  4 May 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 142456380C;
	Thu,  4 May 2023 19:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583FEC433D2;
	Thu,  4 May 2023 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683229750;
	bh=hyLUe3XXTQX/auUSBvaDHtJg2IMytRMl22Up4TYKhcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcDlYLeCRGHOmz5FIRMG7J9NRvalRXa8YdJWDlqNfdpnX7FQbp77uZaq5ZcfHSWBb
	 xoy+6T+G1DT8S5vAkiVXlN5npZoNFw6xE7uLfxHfBEjAijt/Mt/lbBCFCPAVs9lkJ5
	 oRNoHXGKgyRTyFejE7MfZeuoAOOmgjK0KRg15D3iIckbYtoWN7Qbpt8+O0Lf3eOB3s
	 xOG3dVwISQj+4k/3MLUh1K/4gFz2mXdp2cCyD29V23UTqpA0T8/r8K60cW/uk4o0rh
	 48aX068az853dpaBOe6JjXcgsJ3kYumRTQdnPGzsVaspowb224ACr+n/oyr4YmtUD9
	 4qbJ+9npOTQkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yafang <laoar.shao@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/30] bpf: Add preempt_count_{sub,add} into btf id deny list
Date: Thu,  4 May 2023 15:48:13 -0400
Message-Id: <20230504194824.3808028-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194824.3808028-1-sashal@kernel.org>
References: <20230504194824.3808028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yafang <laoar.shao@gmail.com>

[ Upstream commit c11bd046485d7bf1ca200db0e7d0bdc4bafdd395 ]

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
Acked-by: Hao Luo <haoluo@google.com>
Link: https://lore.kernel.org/r/20230413025248.79764-1-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c95d97e7aa53..d37ecd76cc5a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13632,6 +13632,10 @@ BTF_ID(func, migrate_enable)
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
 #endif
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+BTF_ID(func, preempt_count_add)
+BTF_ID(func, preempt_count_sub)
+#endif
 BTF_SET_END(btf_id_deny)
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
-- 
2.39.2


