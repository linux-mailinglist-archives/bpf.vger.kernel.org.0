Return-Path: <bpf+bounces-76362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26519CAFDFE
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85DF330119EE
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75832142E;
	Tue,  9 Dec 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNZZQMVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF512D77FA
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282361; cv=none; b=pMnknE9oQsw6QiQxvr5tXGLrDfyzo3YV5aQkDjFTTqugoQpP4Luao6ySvcC0R09zrWomOFEkFcRf052jrmuLg1Rrd6eqQukIRA+uhB2fWa+5mpsb0plBryEbJOYQEEjrrNnScuetgjwt8Zipubno/SRzzi/fW7hVRV476woAlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282361; c=relaxed/simple;
	bh=VuxjPLI/UAw5tJKbiinNZ84Om6ZqnyBXEnyuPGh7his=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzR5nU8NeW14zNyEdYVWsgDvbrs95qhvPLpLD0DX1icJpP7i8qwC50VvkjR+vo1F4/iJuaTan8dAFH5EREUiUkS4Owdff9gNYSCYPJ2T6YSIyst6AS+Mq3+pRVpGYyhVEwOOV9zigeH/SG0/IcqmrtqbBDYGsJYs4Hd2zycPUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNZZQMVm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c7533dbd87so4843067a34.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 04:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282359; x=1765887159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPO/BvKGg7sBkLwEUPIfmAVXeNPbTgtzjvUBKwIinZM=;
        b=NNZZQMVm+rZehOtMevfQl0tQDZadGvjRC6fl63QweERnrxwxpw+gqjeVMzPSqDGw7F
         VKZtLUn0tkJSCCFyflNLn/da+XVLIFX3kR+QwhPtXMW9noLrS3WMB0o4PaPdBmH/2K92
         eJBR4BMKr2q0rEl43SXaR7M++Y/5hTawZlWsihPVXkmDNNI217ppFtN88JqbBlFf3YE3
         vV24Ug4SrtKSlQMdNqQOgsJNKIMgpFe5C9FGp/NDD4/RrOkW5LTr+EvknkiiNKcKI79C
         /SyPwKMYGTq3FfTUObNrH26M0s53l9AAYJz5PZ/zoUleirOFJM7yJknF5SbijjL0U3m2
         NJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282359; x=1765887159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPO/BvKGg7sBkLwEUPIfmAVXeNPbTgtzjvUBKwIinZM=;
        b=viG5SDR7WWB9IZFv4Xu92Mu0YjXONKTd+SSkcqUTAwSlYmvGeh8BvDNqU67NTBTebI
         4kL8UQguWSRw7Mq3jOEUfVTYLpYKqe3YJVfAXFRFCEQozqiAqxL9FBGolduQ5rH1xYJo
         T7eLBBDekPwwj/TpCuc7dSG6nEW0b3e8DeJTiJgm9AbxpcIjT6HofsgIjUuGPWvNfICx
         Y5zZ07WpMpQppruQyCFtRYU7TWdEqXWWN7NMI9sDZQsufoEalkFzDYdnRLIm+tR+MhxE
         VkDqUNJ7g8wm5WnfxlsYeh9xxyWUzjODrf2WgnXOSErcCNJXQHrShU/sY5YeVnbd9Xu3
         PuSw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCIbdFzu8l9rS5eCNCXu++u87tqwZ8CaXmJColYHdlXqFhYH8j3zyqC6jOBYb01dg07Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmqB/aghUEziF9Mu68UySgxMGYebNiZErxkLK/ccvC1SGVNxX
	vF/621fW5LOdjo7/BytfsF7VRdFkspNmKLoowR86ht/iyTVq3QJCZJUzuKJensmK6AOlDd2bOL4
	80k66ntFI9etnw6LjpvkS3x1m3I9RTdc=
X-Gm-Gg: ASbGncuPtF3qUAQw0JyzXDZ+OWhkfeerP0AS8uJNgQBeLngR85t7B9b10+of0tUxUpz
	kWzklROBnhKRndJ2V6auta1GcyfXnUfxrhRtNYAWI68uhilzk1WLh4Fjhmz5oSKp4QV+5jusdfx
	eslkMKNkYQ+1AaL9c8OhMLf0daqJPAMj4RZjbsdT9GyXMfmHbS1LDfULRbqfpmsr6TX+SJQET9J
	cE+jofD6aBtSzGSOrlGaQCaIrE3Xm6z0IbVdH1RmzsGdAbij5MMYgVmV/n9VC8IaQxEChU=
X-Google-Smtp-Source: AGHT+IEjEeVeN7jrrz6hBysMK/wp7Dao0ahhwFRlvs+E2NHCTRzvpL64IBfuIJom0oyae7nuV2pfZHPgKzBo5ZkBYdU=
X-Received: by 2002:a05:6820:1b19:b0:656:b1fb:a8fd with SMTP id
 006d021491bc7-6599a8a097fmr4639005eaf.1.1765282358807; Tue, 09 Dec 2025
 04:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209031628.28429-1-kerneljasonxing@gmail.com> <6937d508.a70a0220.38f243.00c9.GAE@google.com>
In-Reply-To: <6937d508.a70a0220.38f243.00c9.GAE@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 9 Dec 2025 20:12:02 +0800
X-Gm-Features: AQt7F2oj04V18heapGTuW-sH7huLMZrlgW5Il7HJbcoA1PpdckVwNgFNVsARJoM
Message-ID: <CAL+tcoDfvz9fR4XK6FPH8Ng+OfF67UX86=fZL2xxZGnuA2Rs5g@mail.gmail.com>
Subject: Re: [syzbot ci] Re: xsk: move cq_cached_prod_lock to avoid touching a
 cacheline in sending path
To: syzbot ci <syzbot+ci28a5ab4f329a6a88@syzkaller.appspotmail.com>
Cc: ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jonathan.lemon@gmail.com, 
	kernelxing@tencent.com, kuba@kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 3:52=E2=80=AFPM syzbot ci
<syzbot+ci28a5ab4f329a6a88@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v4] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sendi=
ng path
> https://lore.kernel.org/all/20251209031628.28429-1-kerneljasonxing@gmail.=
com
> * [PATCH RFC net-next v4] xsk: move cq_cached_prod_lock to avoid touching=
 a cacheline in sending path
>
> and found the following issue:
> BUG: unable to handle kernel NULL pointer dereference in xp_create_and_as=
sign_umem
>
> Full report is available here:
> https://ci.syzbot.org/series/d7e166a7-a880-4ea1-9707-8889afd4ebe8
>
> ***
>
> BUG: unable to handle kernel NULL pointer dereference in xp_create_and_as=
sign_umem
>
> tree:      net-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netde=
v/net-next.git
> base:      0177f0f07886e54e12c6f18fa58f63e63ddd3c58
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~e=
xp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/d327cc4b-7471-413b-b244-519c6d16d=
43b/config
> C repro:   https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd8d=
b8d34/c_repro
> syz repro: https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd8d=
b8d34/syz_repro

Interesting. Only rx logic is initialized while tx not. That causes
the cq_tmp to be uninitialized.

>
> UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, ple=
ase contact the netdev mailing list
> BUG: kernel NULL pointer dereference, address: 0000000000000058
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 80000001b2496067 P4D 80000001b2496067 PUD 0
> Oops: Oops: 0002 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5973 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> RIP: 0010:lockdep_init_map_type+0x1e/0x380 kernel/locking/lockdep.c:4944
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 48 83 e=
c 10 89 cd 48 89 fb 65 48 8b 05 67 af d1 10 48 89 44 24 08 <48> c7 47 10 00=
 00 00 00 48 c7 47 08 00 00 00 00 8b 05 8c f2 dc 17
> RSP: 0018:ffffc90003c07bb8 EFLAGS: 00010286
> RAX: ec490cf5c114aa00 RBX: 0000000000000048 RCX: 0000000000000000
> RDX: ffffffff99d16120 RSI: ffffffff8c92a180 RDI: 0000000000000048
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
> R10: ffffed102e5d7800 R11: fffffbfff1efa3cf R12: dffffc0000000000
> R13: ffff8881bdeb3000 R14: ffffffff99d16120 R15: ffffffff8c92a180
> FS:  00005555729bd500(0000) GS:ffff8882a9f31000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000058 CR3: 0000000172faa000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  lockdep_init_map_waits include/linux/lockdep.h:135 [inline]
>  lockdep_init_map_wait include/linux/lockdep.h:142 [inline]
>  __raw_spin_lock_init+0x45/0x100 kernel/locking/spinlock_debug.c:25

Using if-condition to check if cq_tmp is NULL would avoid the corruption.

Will add it in the next version.

Thanks,
Jason


>  xp_create_and_assign_umem+0x648/0xd40 net/xdp/xsk_buff_pool.c:94
>  xsk_bind+0x95a/0xf90 net/xdp/xsk.c:1355
>  __sys_bind_socket net/socket.c:1874 [inline]
>  __sys_bind+0x2c6/0x3e0 net/socket.c:1905
>  __do_sys_bind net/socket.c:1910 [inline]
>  __se_sys_bind net/socket.c:1908 [inline]
>  __x64_sys_bind+0x7a/0x90 net/socket.c:1908
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f591eb8f7c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffce6fcef48 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> RAX: ffffffffffffffda RBX: 00007f591ede5fa0 RCX: 00007f591eb8f7c9
> RDX: 0000000000000010 RSI: 0000200000000240 RDI: 0000000000000003
> RBP: 00007f591ebf297f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f591ede5fa0 R14: 00007f591ede5fa0 R15: 0000000000000003
>  </TASK>
> Modules linked in:
> CR2: 0000000000000058
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:lockdep_init_map_type+0x1e/0x380 kernel/locking/lockdep.c:4944
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 48 83 e=
c 10 89 cd 48 89 fb 65 48 8b 05 67 af d1 10 48 89 44 24 08 <48> c7 47 10 00=
 00 00 00 48 c7 47 08 00 00 00 00 8b 05 8c f2 dc 17
> RSP: 0018:ffffc90003c07bb8 EFLAGS: 00010286
> RAX: ec490cf5c114aa00 RBX: 0000000000000048 RCX: 0000000000000000
> RDX: ffffffff99d16120 RSI: ffffffff8c92a180 RDI: 0000000000000048
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
> R10: ffffed102e5d7800 R11: fffffbfff1efa3cf R12: dffffc0000000000
> R13: ffff8881bdeb3000 R14: ffffffff99d16120 R15: ffffffff8c92a180
> FS:  00005555729bd500(0000) GS:ffff8882a9f31000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000058 CR3: 0000000172faa000 CR4: 00000000000006f0
> ----------------
> Code disassembly (best guess):
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   90                      nop
>    9:   90                      nop
>    a:   90                      nop
>    b:   90                      nop
>    c:   f3 0f 1e fa             endbr64
>   10:   55                      push   %rbp
>   11:   41 56                   push   %r14
>   13:   53                      push   %rbx
>   14:   48 83 ec 10             sub    $0x10,%rsp
>   18:   89 cd                   mov    %ecx,%ebp
>   1a:   48 89 fb                mov    %rdi,%rbx
>   1d:   65 48 8b 05 67 af d1    mov    %gs:0x10d1af67(%rip),%rax        #=
 0x10d1af8c
>   24:   10
>   25:   48 89 44 24 08          mov    %rax,0x8(%rsp)
> * 2a:   48 c7 47 10 00 00 00    movq   $0x0,0x10(%rdi) <-- trapping instr=
uction
>   31:   00
>   32:   48 c7 47 08 00 00 00    movq   $0x0,0x8(%rdi)
>   39:   00
>   3a:   8b 05 8c f2 dc 17       mov    0x17dcf28c(%rip),%eax        # 0x1=
7dcf2cc
>
>
> ***
>
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>   Tested-by: syzbot@syzkaller.appspotmail.com
>
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.
>

