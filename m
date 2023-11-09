Return-Path: <bpf+bounces-14643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED177E73C4
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADED1C209F0
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703AD38DF0;
	Thu,  9 Nov 2023 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd2jM6Qt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE838DDA;
	Thu,  9 Nov 2023 21:39:25 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187314211;
	Thu,  9 Nov 2023 13:39:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso237902466b.1;
        Thu, 09 Nov 2023 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565962; x=1700170762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mivFoTsyzu5D3ktYakV/iPJjqNTQ6vxhMqnx19AOq4=;
        b=Pd2jM6QtX35Iqp+ALpamDOuMRu9JJCF2TeYvGiN9FdwPzQyT7CQmZuSuYvoQ3Ss+z5
         GZLAdGvX2c/YaFYb5XLzePD2Qmaqgz2xINb8UX8xJwnPYAL6rohSfgiAsT5zCnZBpfXt
         Rj69pO/AtA45FHEwGwqymEHix+tne3moyHHScGLBU59q43t9NOKkIu0ecqhujDI9cgoK
         D2P+XSAFRbRiJC9BTJ7kk3eHsKH/HASzpv2S6o2hXe2gPpqqRO3lsQ4ISv1xJSzwDs4H
         TQ6UT+Dad+mBo7gheLTC24nSroK5Xv1+3UPnmch0tegCWZ7AEKPe4ytI+R3DvdAxfGoP
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565962; x=1700170762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mivFoTsyzu5D3ktYakV/iPJjqNTQ6vxhMqnx19AOq4=;
        b=jgdx+uqRrXGbTHwwNdM6FmLF20j+lbQshQM3ExoICrTxa3vgQBdzQg71j4zQgAniKL
         UNzuuOdGsXsSUnNkrkfpRwF0KdHRG7JJHO82xfyi8W7xya5+tRM6rR8ArIyAlNGXhy+d
         Hzn8IP+JMgBHW8wpuYcIzTIHQ39qdVRlhBueErftl5yhvvpPr5fWxr6uuZ3VK72ECqPa
         tAKrOnZArFnPnErmCcqJeIVuHFztkZxmddflLkyhBgJoA5cUOvSSSj89FWOjPDftOFbX
         hIp7Ao2pLklEMaVFwlP2tIWNNMvl+b//WBgbX+edZvzOWkjPYgERFK/vuW16N7tCtWrA
         ymIg==
X-Gm-Message-State: AOJu0YyUYvTQL2df4FXwLDYaIE1nCcSU9gAO1hkxGJwlLsQPjYPEfW53
	oPicMan4OEKx4EAeW9e/gWs=
X-Google-Smtp-Source: AGHT+IGX3N5iX5LSKJ95LCTzhUOw3nwL5273uioZrF9b4UvDKOmdcXT+cZl5S1QF5kdiE4gl0U5Yxw==
X-Received: by 2002:a17:907:910a:b0:9e4:e405:27b4 with SMTP id p10-20020a170907910a00b009e4e40527b4mr1447235ejq.53.1699565962160;
        Thu, 09 Nov 2023 13:39:22 -0800 (PST)
Received: from krava ([83.240.60.131])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b0099c53c44083sm3057499ejb.79.2023.11.09.13.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:39:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 Nov 2023 22:39:14 +0100
To: Lee Jones <lee@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [REPORT] BPF: Reproducible triggering of BUG() from userspace PoC
Message-ID: <ZU1RgvcM0FFXunOA@krava>
References: <20231108154626.GB8909@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108154626.GB8909@google.com>

On Wed, Nov 08, 2023 at 03:46:26PM +0000, Lee Jones wrote:
> Good afternoon,
> 
> After coming across a recent Syzkaller report [0] I thought I'd take
> some time to firstly reproduce the issue, then see if there was a
> trivial way to mitigate it.  The report suggests that a BUG() in
> prog_array_map_poke_run() [1] can be trivially and reliably triggered
> from userspace using the PoC provided [2].
> 
>         ret = bpf_arch_text_poke(poke->tailcall_bypass,
>                                  BPF_MOD_JUMP,
>                                  old_bypass_addr,
>                                  poke->bypass_addr);
>         BUG_ON(ret < 0 && ret != -EINVAL);
> 
> Indeed the PoC does seem to be able to consistently trigger the BUG(),
> not only on the reported kernel (v6.1), but also on linux-next.  I went
> to the trouble of checking LORE, but failed to find any patches which
> may be attempting to fix this.
> 
>     kernel BUG at kernel/bpf/arraymap.c:1094!
>     invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>     CPU: 5 PID: 45 Comm: kworker/5:0 Not tainted 6.6.0-rc3-next-20230929-dirty #74
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>     Workqueue: events prog_array_map_clear_deferred
>     RIP: 0010:prog_array_map_poke_run+0x6b4/0x6d0
>     Code: ff 0f 0b e8 1e 27 e1 ff 48 c7 c7 60 80 93 85 48 c7 c6 00 7f 93 85 48 c7 c2 bb c2 39 86 b9 45 04 00 00 45 89 f8 e8 9c 890
>     RSP: 0018:ffffc9000036fb50 EFLAGS: 00010246
>     RAX: 0000000000000044 RBX: ffff88811f337490 RCX: 63af48a1314f9900
>     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>     RBP: ffffc9000036fbe8 R08: ffffffff815c23c5 R09: 1ffff11084c14eba
>     R10: dfffe91084c14ebc R11: ffffed1084c14ebb R12: ffff888116517800
>     R13: dffffc0000000000 R14: ffff888125a1a400 R15: 00000000fffffff0
>     FS:  0000000000000000(0000) GS:ffff888426080000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00000000004ab678 CR3: 0000000122ac4000 CR4: 0000000000350eb0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      ? __die_body+0x92/0xf0
>      ? die+0xa2/0xe0
>      ? do_trap+0x12f/0x370
>      ? handle_invalid_op+0xa6/0x140
>      ? handle_invalid_op+0xdf/0x140
>      ? prog_array_map_poke_run+0x6b4/0x6d0
>      ? prog_array_map_poke_run+0x6b4/0x6d0
>      ? exc_invalid_op+0x32/0x50
>      ? asm_exc_invalid_op+0x1b/0x20
>      ? __wake_up_klogd+0xd5/0x110
>      ? prog_array_map_poke_run+0x6b4/0x6d0
>      ? bpf_prog_6781ebc2dae4bad9+0xb/0x53
>      fd_array_map_delete_elem+0x152/0x250
>      prog_array_map_clear_deferred+0xf6/0x210
>      ? __bpf_array_map_seq_show+0xa40/0xa40
>      ? kick_pool+0x164/0x350
>      ? process_one_work+0x57a/0xd00
>      process_one_work+0x5e4/0xd00
>      worker_thread+0x9cf/0xea0
>      kthread+0x2b4/0x350
>      ? pr_cont_work+0x580/0x580
>      ? kthread_blkcg+0xd0/0xd0
>      ret_from_fork+0x4a/0x80
>      ? kthread_blkcg+0xd0/0xd0
>      ret_from_fork_asm+0x11/0x20
>      </TASK>
>     Modules linked in:
>     ---[ end trace 0000000000000000 ]---
> 
> However, with my very limited BPF subsystem knowledge I was unable to
> trivially fix the issue.  Hopefully some knowledgable person would be
> kind enough to provide me with some pointers.
> 
> bpf_arch_text_poke() seems to be returning -EBUSY due to a negative
> memcmp() result from [3].
> 
>         ret = -EBUSY;
>         mutex_lock(&text_mutex);
>         if (memcmp(ip, old_insn, X86_PATCH_SIZE)) {
>                 goto out;
>         [...]
> 
> When spitting out the memory at those locations, this is the result:
> 
>     ip:        e9 06 00 00 00
>     old_insn:  0f 1f 44 00 00
>     nop_insn:  0f 1f 44 00 00
> 
> As you can see, the information stored in 'ip' does not match that of
> the data stored in 'old_insn', causing bpf_arch_text_poke() to return
> early with the error -EBUSY, suggesting that the data pointed to by
> 'old_insn', and by extension 'prog' should have been changed when
> emit_call()ing, to the value of 'ip', but wasn't.

hi,
thanks for the report.. I can reproduce that easily with [2]

AFAICS it looks like previous update fails because we use bpf_arch_text_poke,
which can't find poke->tailcall_bypass value as bpf program symbol and fails
with -EINVAL

then the following update fails to find expected jmp/nop because it was never
updated.. I think we should use __bpf_arch_text_poke like we do in
bpf_tail_call_direct_fixup and skip the bpf symbol check

with the patch below I can't reproduce the issue anymore, I'll do some more
checking though

jirka


---
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..35c2988caf29 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -391,8 +391,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-				void *old_addr, void *new_addr)
+int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+			 void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb84caf133df..0d7b8311fada 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3172,6 +3172,8 @@ enum bpf_text_poke_type {
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
+int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+			 void *old_addr, void *new_addr);
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
 int bpf_arch_text_invalidate(void *dst, size_t len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..4ab5864746ce 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1073,33 +1073,33 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
 
 			if (new) {
-				ret = bpf_arch_text_poke(poke->tailcall_target,
+				ret = __bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
 							 old_addr, new_addr);
 				BUG_ON(ret < 0 && ret != -EINVAL);
 				if (!old) {
-					ret = bpf_arch_text_poke(poke->tailcall_bypass,
+					ret = __bpf_arch_text_poke(poke->tailcall_bypass,
 								 BPF_MOD_JUMP,
 								 poke->bypass_addr,
 								 NULL);
-					BUG_ON(ret < 0 && ret != -EINVAL);
+					BUG_ON(ret < 0);
 				}
 			} else {
-				ret = bpf_arch_text_poke(poke->tailcall_bypass,
+				ret = __bpf_arch_text_poke(poke->tailcall_bypass,
 							 BPF_MOD_JUMP,
 							 old_bypass_addr,
 							 poke->bypass_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+				BUG_ON(ret < 0);
 				/* let other CPUs finish the execution of program
 				 * so that it will not possible to expose them
 				 * to invalid nop, stack unwind, nop state
 				 */
 				if (!ret)
 					synchronize_rcu();
-				ret = bpf_arch_text_poke(poke->tailcall_target,
+				ret = __bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
 							 old_addr, NULL);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+				BUG_ON(ret < 0);
 			}
 		}
 	}

