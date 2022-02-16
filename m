Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424A44B83BD
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiBPJNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 04:13:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiBPJNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 04:13:42 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB091120F5B
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 01:13:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id u16so1621042pfg.12
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXVF8YX6T/PysZ/3VVeUP/+MdF6ICAi5yeV3tk3lsaU=;
        b=NJge7NSHSXmkqxg59rk74w3jNfnOwgExazO8Usmqhk53hCpSAJ7PzFZ8ogAY7kaE3o
         ZHOzWvbpY4qWCYXBrEXV0IYIKJXbWXPxxE+bA4B6KeIi+UA+iSK4FJCqDxc2zR0ULgXm
         jG/KGjQf7p1JojmMZ86Xew4ADu3KWbSPt5hMIPCqdV2EMiPaux3ll9pax4EAf7qwiINv
         1YfNAAHjIISVqQOA5kVadJoxDCdLLD038H62u1g6x2VqkRIX+YQF9ujl+Ey7A3nvEu8q
         QfzIw23sDyepHcGYbtpNWs+ig81FvSGW1g16XnrA7klR7s1MqLd9Uhp7POHwC1ebC1wG
         f51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXVF8YX6T/PysZ/3VVeUP/+MdF6ICAi5yeV3tk3lsaU=;
        b=SFNQc583GG2w/2XedrFDqIpvXijuaisouSixppsPAX5UDk7gbnxZzx22yTJ2ELMbp/
         aehJYh+axP8eTdBXclBSJ1SzPIESPsdwyFg1vO0L4obSINK7Qyqhqywlp1r6tHWoRtvg
         1Hw6/axn4A1Jez1ytlk0nKmqi6+FV2XHEmmEJguOLalY1ejlizPvKWCjRuDZopmMFWDc
         y6e+RadQXDb5/2q7VAQ4mNcdfqwo6U1EvWQiK6DlbTeu7THwhM8JRUpj2l+vZBfejeqN
         ogEeiFUWBnY2Fva0Ddl4QUFYY/Wtnqh/RZVSCKXvYe86J9TgkOor4GCy19X68YeuhYfU
         e0Ig==
X-Gm-Message-State: AOAM532hK3OBpx6WYlY24C5mnKB/uj3bIqy7WgT19lQHWe2N0XirqLPz
        QupYfHv19vR2+vrupTDnYXid0G2XwIo=
X-Google-Smtp-Source: ABdhPJzBiN8/OedzDCXKNZBHRj/5ucx+kx5un1/SFGUTrLfdlH6pADhiYxh1xGqM5DTwM1/AttNbVQ==
X-Received: by 2002:aa7:9112:0:b0:4e1:3b6:683 with SMTP id 18-20020aa79112000000b004e103b60683mr2218900pfh.63.1645002805929;
        Wed, 16 Feb 2022 01:13:25 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k3sm4861094pgt.29.2022.02.16.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:13:25 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type > __BPF_REG_TYPE_MAX
Date:   Wed, 16 Feb 2022 14:43:23 +0530
Message-Id: <20220216091323.513596-1-memxor@gmail.com>
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

When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
function") added kfunc support, it defined reg2btf_ids as a cheap way to
translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
member of bpf_reg_type enum to after the base register types, and
defined other variants using type flag composition. However, now, the
direct usage of reg->type to index into reg2btf_ids may no longer fall
into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
and kernel crash on dereference of bad pointer.

[   20.448584] BUG: unable to handle page fault for address: 0000000000524156
[   20.449149] #PF: supervisor read access in kernel mode
[   20.449537] #PF: error_code(0x0000) - not-present page
[   20.450025] PGD 0 P4D 0
[   20.450303] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   20.450808] CPU: 0 PID: 323 Comm: test_verifier Tainted: G    B   W   E     5.17.0-rc2+ #286
[   20.451567] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
[   20.452364] RIP: 0010:btf_check_func_arg_match+0x651/0xe10
[   20.452868] Code: ea 04 80 fa 01 0f 87 2a 06 00 00 48 c7 c7 a0 16 f8 a5 e8 82 6d 15 00 48 8b 05 1b 3d aa 04 48 89 df 48 89 04 24 e8 2f 6c 15 00 <8b> 2b 89 ac 24 c0 00 00 00 89 ee 48 8b 2c 24 48 8d 94 24 c0 00 00
[   20.454693] RSP: 0018:ffff88800727f4f8 EFLAGS: 00010282
[   20.455232] RAX: 0000000000000000 RBX: 0000000000524156 RCX: ffffffffa14dd991
[   20.455963] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000524156
[   20.456683] RBP: ffffffffa398c6d4 R08: ffffffffa14dd991 R09: 0000000000000000
[   20.457297] R10: fffffbfff484f31c R11: 0000000000000001 R12: ffff888007bf8600
[   20.457917] R13: ffff88800c2f6078 R14: 0000000000000000 R15: 0000000000000001
[   20.458596] FS:  00007fe06ae70740(0000) GS:ffff88808cc00000(0000) knlGS:0000000000000000
[   20.459303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.459817] CR2: 0000000000524156 CR3: 000000000902a004 CR4: 0000000000770ef0
[   20.460527] PKRU: 55555554
[   20.460746] Call Trace:
[   20.460938]  <TASK>
[   20.461120]  ? btf_kfunc_id_set_contains+0x100/0x100
[   20.461534]  ? btf_kfunc_id_set_contains+0xd6/0x100
[   20.461996]  ? btf_try_get_module+0xc0/0xc0
[   20.462361]  do_check_common+0x3961/0x5490
[   20.462726]  ? bpf_check+0x27e0/0x4c60
[   20.463036]  ? check_helper_call+0x3050/0x3050
[   20.463435]  ? lock_is_held_type+0xe4/0x140
[   20.463873]  ? lockdep_hardirqs_on_prepare+0x129/0x220
[   20.464402]  ? kasan_quarantine_put+0x9c/0x1f0
[   20.464815]  ? lockdep_hardirqs_on+0x7e/0x100
[   20.465253]  ? kasan_quarantine_put+0x9c/0x1f0
[   20.465580]  ? slab_free_freelist_hook+0x7d/0x150
[   20.465961]  ? bpf_check+0x3ae1/0x4c60
[   20.466262]  ? kfree+0xbe/0x2d0
[   20.466518]  bpf_check+0x3da4/0x4c60
[   20.466800]  ? bpf_get_btf_vmlinux+0x50/0x50
[   20.467152]  ? lock_is_held_type+0xe4/0x140
[   20.467471]  ? lock_release+0x238/0x410
[   20.467761]  ? ktime_get_with_offset+0x3c/0xf0
[   20.468168]  ? lock_downgrade+0x390/0x390
[   20.468578]  ? __might_fault+0x57/0xb0
[   20.468974]  ? memset+0x20/0x40
[   20.469314]  bpf_prog_load+0x7b3/0xfb0
[   20.469714]  ? __bpf_prog_put.constprop.0+0x120/0x120
[   20.470235]  ? lock_is_held_type+0xe4/0x140
[   20.470641]  ? avc_has_perm+0x7e/0x110
[   20.470982]  ? avc_has_perm_noaudit+0x250/0x250
[   20.471461]  __sys_bpf+0x121b/0x3350
[   20.471826]  ? bpf_raw_tracepoint_open+0x3e0/0x3e0
[   20.472291]  ? __do_fault+0x210/0x210
[   20.472675]  ? __handle_mm_fault+0x15a0/0x1c20
[   20.473138]  ? lock_is_held_type+0xe4/0x140
[   20.473589]  ? up_write+0x270/0x270
[   20.473964]  ? mark_held_locks+0x24/0x90
[   20.474383]  __x64_sys_bpf+0x44/0x50
[   20.474765]  do_syscall_64+0x59/0x80
[   20.475066]  ? asm_exc_page_fault+0x1e/0x30
[   20.475439]  ? asm_exc_page_fault+0x8/0x30
[   20.475801]  ? lockdep_hardirqs_on+0x7e/0x100
[   20.476252]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   20.476778] RIP: 0033:0x7fe06af6e18d
[   20.477159] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
[   20.479034] RSP: 002b:00007ffcf84bbc78 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[   20.479602] RAX: ffffffffffffffda RBX: 00007fe06b16fc40 RCX: 00007fe06af6e18d
[   20.480187] RDX: 0000000000000090 RSI: 00007ffcf84bbd80 RDI: 0000000000000005
[   20.480727] RBP: 00007ffcf84bbc90 R08: 00007ffcf84bbeb0 R09: 00007ffcf84bbd80
[   20.481441] R10: 0000000000000007 R11: 0000000000000202 R12: 00007fe06b11f7b0
[   20.482127] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   20.482628]  </TASK>
[   20.482810] Modules linked in: crc32_pclmul(E) intel_rapl_msr(E) intel_rapl_common(E) rapl(E) ghash_clmulni_intel(E) crct10dif_pclmul(E) crc32c_intel(E) serio_raw(E)
[   20.484185] CR2: 0000000000524156
[   20.484441] ---[ end trace 0000000000000000 ]---
[   20.484900] RIP: 0010:btf_check_func_arg_match+0x651/0xe10
[   20.485401] Code: ea 04 80 fa 01 0f 87 2a 06 00 00 48 c7 c7 a0 16 f8 a5 e8 82 6d 15 00 48 8b 05 1b 3d aa 04 48 89 df 48 89 04 24 e8 2f 6c 15 00 <8b> 2b 89 ac 24 c0 00 00 00 89 ee 48 8b 2c 24 48 8d 94 24 c0 00 00
[   20.487173] RSP: 0018:ffff88800727f4f8 EFLAGS: 00010282
[   20.487709] RAX: 0000000000000000 RBX: 0000000000524156 RCX: ffffffffa14dd991
[   20.488393] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000524156
[   20.489045] RBP: ffffffffa398c6d4 R08: ffffffffa14dd991 R09: 0000000000000000
[   20.489696] R10: fffffbfff484f31c R11: 0000000000000001 R12: ffff888007bf8600
[   20.490377] R13: ffff88800c2f6078 R14: 0000000000000000 R15: 0000000000000001
[   20.491065] FS:  00007fe06ae70740(0000) GS:ffff88808cc00000(0000) knlGS:0000000000000000
[   20.491782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.492272] CR2: 0000000000524156 CR3: 000000000902a004 CR4: 0000000000770ef0
[   20.492925] PKRU: 55555554

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Hao Luo <haoluo@google.com>
Fixes: c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e16dafeb2450..416345798e0a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5568,13 +5568,21 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }

-static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
+static u32 *reg2btf_ids(enum bpf_reg_type type)
+{
+	switch (type) {
 #ifdef CONFIG_NET
-	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
-	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
-	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+	case PTR_TO_SOCKET:
+		return &btf_sock_ids[BTF_SOCK_TYPE_SOCK];
+	case PTR_TO_SOCK_COMMON:
+		return &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
+	case PTR_TO_TCP_SOCK:
+		return &btf_sock_ids[BTF_SOCK_TYPE_TCP];
 #endif
-};
+	default:
+		return NULL;
+	}
+}

 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
@@ -5688,7 +5696,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			}
 			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
-		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids(reg->type))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5706,7 +5714,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				reg_ref_id = reg->btf_id;
 			} else {
 				reg_btf = btf_vmlinux;
-				reg_ref_id = *reg2btf_ids[reg->type];
+				reg_ref_id = *reg2btf_ids(reg->type);
 			}

 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
--
2.35.1

