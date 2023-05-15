Return-Path: <bpf+bounces-491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7D702205
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 05:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342F7280F91
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCF1FAD;
	Mon, 15 May 2023 03:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89ACEA0
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 03:13:39 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B310F8
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 20:13:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-528cdc9576cso8371593a12.0
        for <bpf@vger.kernel.org>; Sun, 14 May 2023 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684120417; x=1686712417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxpFGoxleToaQwkHibZ+pniT5a0w07wmiTEGO0b16Vo=;
        b=aSCO1ZUHRnLT0HbSwrWiP7TCHqlmHQdUDduIsVKHGoUaY6ROnA8cP5+RczTadKuocY
         sLMNEMpTCzItVU6bBBNwPIRNLJumVtiSPafhhhkJfCilQ5U7Qpu2I4Vml+BGcoHJ5KfL
         dWTTAq0Bb2x+jTp92UjXF3FfIHfAd2HpjVjKgtAyVwA5h7kGB+0FjgNSQLHuYat8Z0Al
         fmuvZFXdJcpIZR4jgmQc8/eFd6PftjcIFBqFpTLQpsgBAL4kbaNJ9h/hNouQ9EaSyabV
         dmuM1n+VfEkkX29aeVZYacIxt2BHDSXUkFiy1wP8lzq6V7alRLEtIK69mGZWTspgr2YO
         LFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120417; x=1686712417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxpFGoxleToaQwkHibZ+pniT5a0w07wmiTEGO0b16Vo=;
        b=LiOMz3tfAiDssuYUxs3cSpvoHz25e0Tolz3N/RE2ZsimMaMoPKQ6XR0Dl5Y+vICyj7
         W77y9i22Tw8c0P5mjc0d5Q3DEUdJbncs32Tp5oK8p9aeK3kmbhCETeO0tcGJmUWlmEc3
         ZxI5bFDtDP7E3QVB8rs2gTdtiiwSDAWAhnGyH+6ONzPUbhvnrLaBICZczPL9FZhXqczL
         B/Tof298M96QM79IBg8EpbSwn+JBKwd0zyHv0bvQi0XTJFjJKvQut1995IjmiTYPUQ/a
         Ce8oXoPm+ISNCfAFQM3zmtgFsLSLohVcrPV4wCUkzxxVbVVPLIDA7/z5zj9eyiz8lmPo
         +KNQ==
X-Gm-Message-State: AC+VfDyLao22oiuWjeSq7I1LdnE35FTfIWxd5csw4vps1a/pmBj3Uq5g
	qzMrg1TmowhVH90eff9+4WI=
X-Google-Smtp-Source: ACHHUZ7bom1WsQSB9N7JbS2hNeG7BAQVaheeDyi1N5Vs6lkfmNmaRmJdqhiEQg2hZDvBtME2yZj8YQ==
X-Received: by 2002:a17:90a:760c:b0:24e:5ed7:2e3f with SMTP id s12-20020a17090a760c00b0024e5ed72e3fmr33118826pjk.13.1684120416916;
        Sun, 14 May 2023 20:13:36 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id o4-20020a17090a744400b00252b3328ad8sm4943577pjk.0.2023.05.14.20.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:13:36 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Ze Gao <zegao@tencent.com>,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/4] Make fpobe + rethook immune to recursion
Date: Mon, 15 May 2023 11:13:09 +0800
Message-Id: <20230515031314.7836-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current fprobe and rethook has some pitfalls and may introduce kernel stack recusion, especially in
massive tracing scenario.

For example, if (DEBUG_PREEMPT | TRACE_PREEMPT_TOGGLE) , preempt_count_{add, sub} can be traced via
ftrace, if we happens to use fprobe + rethook based on ftrace to hook on those functions, 
recursion is introduced in functions like rethook_trampoline_handler and leads to kernel crash
because of stack overflow.

Snippets of such bug are like this:
[   56.038709] BUG: #DF stack guard page was hit at 000000000b5b7199 (stack is 00000000f4b5a9b2..00000000af4160ce)
[   56.038713] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[   56.038715] CPU: 5 PID: 1836 Comm: retsnoop Kdump: loaded Not tainted 6.1.18 #2
[   56.038717] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/05/2021
[   56.038717] BUG: #DF stack guard page was hit at 0000000069dc65a2 (stack is 000000006b9345c5..00000000a221349b)
[   56.038718] RIP: 0010:ftrace_ops_test+0x1a/0x70
[   56.038721] Code: 89 df e8 79 e2 ff ff e9 6e ff ff ff 0f 1f 40 00 48 81 ec b0 00 00 00 49 89 f1 49 89 f8 31 c0 48 89 e6 b9 16 00 00 00 48 89 f7 <f3> 48 ab 48 85 d2 74 35 49 8b 80 d8 00 00 00 48 8b 40 08 48 89 44
[   56.038722] RSP: 0018:fffffe5a8bba5fa0 EFLAGS: 00010046
[   56.038724] RAX: 0000000000000000 RBX: fffffe5a8bba6090 RCX: 0000000000000016
[   56.038725] RDX: fffffe5a8bba6090 RSI: fffffe5a8bba5fa0 RDI: fffffe5a8bba5fa0
[   56.038726] RBP: ffffffffb7137910 R08: ffff8b967f827c70 R09: ffffffffb7137910
[   56.038727] R10: 0000000000000000 R11: 0000000000000000 R12: fffffe5a8bba6090
[   56.038727] R13: ffffffffb729e2bf R14: ffffffffffffffdf R15: ffff8b967f827c70
[   56.038728] FS:  00007f6592d6ed00(0000) GS:ffff8b977da00000(0000) knlGS:0000000000000000
[   56.038730] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.038730] CR2: fffffe5a8bba5f98 CR3: 000000010ed94002 CR4: 00000000003726e0
[   56.038733] Call Trace:
[   56.038735]  <#DF>
[   56.038740]  ? exc_int3+0xa/0xc0
[   56.038743]  arch_ftrace_ops_list_func+0xc2/0x190
[   56.038745]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038748]  ftrace_regs_call+0x5/0x52
[   56.038751]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038754]  ? osnoise_arch_unregister+0x210/0x210
[   56.038757]  ? preempt_count_add+0x5/0xa0
[   56.038760]  preempt_count_add+0x5/0xa0
[   56.038762]  rethook_trampoline_handler+0x5f/0x140
[   56.038764]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038766]  arch_rethook_trampoline_callback+0x3b/0x50
[   56.038768]  arch_rethook_trampoline+0x2c/0x60
[   56.038770]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038775]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038778]  osnoise_arch_unregister+0x210/0x210
[   56.038780]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038781]  arch_rethook_trampoline_callback+0x3b/0x50
[   56.038783]  arch_rethook_trampoline+0x2c/0x60
[   56.038785]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038790]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038792]  osnoise_arch_unregister+0x210/0x210
[   56.038794]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038795]  arch_rethook_trampoline_callback+0x3b/0x50
[   56.038797]  arch_rethook_trampoline+0x2c/0x60
[   56.038799]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038804]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038806]  osnoise_arch_unregister+0x210/0x210
[   56.038808]  ? rethook_trampoline_handler+0x5f/0x140
[   56.038810]  arch_rethook_trampoline_callback+0x3b/0x50
[   56.038811]  arch_rethook_trampoline+0x2c/0x60
...
[   56.039133]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039137]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039139]  osnoise_arch_unregister+0x210/0x210
[   56.039141]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039143]  arch_rethook_trampoline_callback+0x3b/0x50
[   56.039144]  arch_rethook_trampoline+0x2c/0x60
[   56.039147]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039151]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039156]  ? vsnprintf+0x2a3/0x550
[   56.039161]  ? sprintf+0x4e/0x60
[   56.039163]  ? kallsyms_lookup_buildid+0x5f/0x130
[   56.039167]  ? __sprint_symbol.constprop.0+0xec/0x110
[   56.039171]  ? symbol_string+0xc5/0x150
[   56.039197]  ? vsnprintf+0x33a/0x550
[   56.039201]  ? exc_int3+0xa/0xc0
[   56.039204]  ? exc_int3+0xa/0xc0
[   56.039205]  ? ftrace_regs_call+0x5/0x52
[   56.039208]  ? ftrace_regs_call+0x5/0x52
[   56.039211]  ? lock_acquire+0x25d/0x2e0
[   56.039214]  ? lock_release+0x208/0x460
[   56.039218]  ? is_bpf_text_address+0x67/0xf0
[   56.039220]  ? kernel_text_address+0x111/0x120
[   56.039223]  ? __kernel_text_address+0xe/0x40
[   56.039225]  ? show_trace_log_lvl+0x1d7/0x336
[   56.039227]  ? show_trace_log_lvl+0x1d7/0x336
[   56.039236]  ? __die_body.cold+0x1a/0x1f
[   56.039239]  ? die+0x2a/0x50
[   56.039242]  ? handle_stack_overflow+0x49/0x60
[   56.039245]  ? exc_double_fault+0x148/0x180
[   56.039248]  ? asm_exc_double_fault+0x1f/0x30
[   56.039251]  ? rethook_trampoline_handler+0x5f/0x140
[   56.039252]  ? cpu_cgroup_css_free+0x30/0x30
[   56.039254]  ? cpu_cgroup_css_free+0x30/0x30
[   56.039258]  ? ftrace_ops_test+0x1a/0x70
[   56.039260]  </#DF>

This bug is found via tool retsnoop which internally uses bpf based on fprobe + rethook
Discussion of this bug can be found here:
  Link: https://lore.kernel.org/bpf/20230510122045.2259-1-zegao@tencent.com/

This patch series fix this problem by adding more recursion detection in each possible entry
functions, and also mark these specific to fprobe or rethook which are beyond the recusion-free
guarded region notrace. 


Ze Gao (4):
  rethook: use preempt_{disable, enable}_notrace in
    rethook_trampoline_handler
  fprobe: make fprobe_kprobe_handler recursion free
  fprobe: add recursion detection in fprobe_exit_handler
  rehook, fprobe: mark rethook related functions notrace

 arch/riscv/kernel/probes/rethook.c |  4 +-
 arch/s390/kernel/rethook.c         |  6 +--
 arch/x86/kernel/rethook.c          |  8 ++--
 kernel/trace/fprobe.c              | 76 +++++++++++++++++++++++-------
 kernel/trace/rethook.c             | 12 ++---
 5 files changed, 75 insertions(+), 31 deletions(-)

-- 
2.40.1


