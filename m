Return-Path: <bpf+bounces-36589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223994AEB3
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A36282417
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E913B7BE;
	Wed,  7 Aug 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfiNOruK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435612C475;
	Wed,  7 Aug 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050886; cv=none; b=jTfY4t60km8aZvBitmgke8UvdvayAbGJaS7CFGIiOoTQxp+Uhpz6YHHShHr+dftUe6MZJ9xVSIkgF9m8lFT5rubDNL7ciIqSzpTa6zLA+J56SJJ8ysxL4SoSpd/lgVE7/ewJpx2U4b1EZXuEpBrMnDdwtcyPBNIljnMY+/skufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050886; c=relaxed/simple;
	bh=r94tD7PqVQVeopTpUYjE5yeG2OfyJJK3BDVAa0qUWPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ue5WfhYRD+XUgzSmEUvrKsurqLMoM08XT67l9fV6En64rQP3Y5ng3eI9PB/JmyVMu6P+L+jKN6YCf8bfNc9PpbrKoGQrM7Lvzgbxa7vraF62n8OZ7+r9MwMihk5WzJULpawfDAfpLCsEb5dFDFT7gnK2KoAdWdKU5/kNzXXyoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfiNOruK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so120198a91.0;
        Wed, 07 Aug 2024 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723050884; x=1723655684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHMTycCGHBZWR90Qh2mi/awK+ras6hpsK07OyP6hWDg=;
        b=ZfiNOruKYZjXdBjUl36Pz+eQm62+fFXFO/Oko/77CINDauK41SuFSoyh1JRwJ/eQUn
         wmzm8vxciiblidFf/lLYJ+S5b22qu0Hvjda1p5qsIHUCswJhwfR6eMR/7oJ7KALOhQV0
         /PAEkswjqauQ1vYAp1Zts2Dq4XlKu7mj7lZI1fc3b0Cs9gcxzn7t0ZSsXog0AzmPQPkw
         B7AQDaIsbkl0/u318uQPy2d0U00iBuVnO+OgJ3FwFFlAafMVSlFDWFGKpjGn47CVFLy/
         FybXRKSfJ7QJCTy33qlBhvURxBM8QmRcz8QuFTn1k/00rYYgP2/r6/mM6TA8UOOqPl9G
         UAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723050884; x=1723655684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHMTycCGHBZWR90Qh2mi/awK+ras6hpsK07OyP6hWDg=;
        b=nxu/8hjVlpGGtz/dpfzOIXjUeEkPtp6ZMNmxbl18zYZI2qThnYp12MTW8z+k2yHRC3
         q5cou+cyB8CXctBXgBIr6NoYo3MM7w9tBiJgfn8ramhgqvTQ1NmMrD3qZBkPfSeqrU7H
         T/lAAESvHWuM+3gA7Jz7rVNBp9BGn2k/AMW8KafLRdVh+cPVh1EyG8MJ/WhxsGp07dB5
         zlg7HCDJmusVVmH6iEZxO1Q0i74lMQPQKvtq/n3/C3B+J4zwqIg05pa+ImBJUuVXYlE0
         /r7G3GjCPqTc0HvcPK0F+26XmMu0ngH9FOmi+PpaTusbe4Dk6LqeHcFy40txeu7X9KJg
         bCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFhx3nVx80Tk3lGfLuNPPKWZXKzq52TEtt4+VmXgJ112bKrY5zjwLmqM+LFtcKNdE9qHc/gZmxCBGuEXznn+dXirMYhEOtw3TIkeAN0Kn2Sdfu0K13lwlYtis2faHyF8bk
X-Gm-Message-State: AOJu0YzB9hx1mgG7m2lHtDqiZlTI9FbsYx/0oAK7tDWqsoqLDbynXHOf
	FulY4tn+x1umzCk0BV4qXtYy7Vy53f5iPjrkq0IinQMBWHyrNBqBrcnSOdhL9UoUcTnHowsej5x
	COhc0rJjsCWKYBn6FJ7l+GQyPFnk=
X-Google-Smtp-Source: AGHT+IEnvh90PWPMpX4aUsfITOqLyEjj554IuQauVBJBsZmErgtCprL7iwAtKJ2Lm1x1W9o9TQ3XnDon4rEXFWhPdXc=
X-Received: by 2002:a17:90b:4b05:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2cff952d009mr18387237a91.31.1723050884239; Wed, 07 Aug 2024
 10:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-8-andrii@kernel.org>
In-Reply-To: <20240731214256.3588718-8-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 10:14:31 -0700
Message-ID: <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:43=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Another big bottleneck to scalablity is uprobe_treelock that's taken in
> a very hot path in handle_swbp(). Now that uprobes are SRCU-protected,
> take advantage of that and make uprobes_tree RB-tree look up lockless.
>
> To make RB-tree RCU-protected lockless lookup correct, we need to take
> into account that such RB-tree lookup can return false negatives if there
> are parallel RB-tree modifications (rotations) going on. We use seqcount
> lock to detect whether RB-tree changed, and if we find nothing while
> RB-tree got modified inbetween, we just retry. If uprobe was found, then
> it's guaranteed to be a correct lookup.
>
> With all the lock-avoiding changes done, we get a pretty decent
> improvement in performance and scalability of uprobes with number of
> CPUs, even though we are still nowhere near linear scalability. This is
> due to SRCU not really scaling very well with number of CPUs on
> a particular hardware that was used for testing (80-core Intel Xeon Gold
> 6138 CPU @ 2.00GHz), but also due to the remaning mmap_lock, which is
> currently taken to resolve interrupt address to inode+offset and then
> uprobe instance. And, of course, uretprobes still need similar RCU to
> avoid refcount in the hot path, which will be addressed in the follow up
> patches.
>
> Nevertheless, the improvement is good. We used BPF selftest-based
> uprobe-nop and uretprobe-nop benchmarks to get the below numbers,
> varying number of CPUs on which uprobes and uretprobes are triggered.
>
> BASELINE
> =3D=3D=3D=3D=3D=3D=3D=3D
> uprobe-nop      ( 1 cpus):    3.032 =C2=B1 0.023M/s  (  3.032M/s/cpu)
> uprobe-nop      ( 2 cpus):    3.452 =C2=B1 0.005M/s  (  1.726M/s/cpu)
> uprobe-nop      ( 4 cpus):    3.663 =C2=B1 0.005M/s  (  0.916M/s/cpu)
> uprobe-nop      ( 8 cpus):    3.718 =C2=B1 0.038M/s  (  0.465M/s/cpu)
> uprobe-nop      (16 cpus):    3.344 =C2=B1 0.008M/s  (  0.209M/s/cpu)
> uprobe-nop      (32 cpus):    2.288 =C2=B1 0.021M/s  (  0.071M/s/cpu)
> uprobe-nop      (64 cpus):    3.205 =C2=B1 0.004M/s  (  0.050M/s/cpu)
>
> uretprobe-nop   ( 1 cpus):    1.979 =C2=B1 0.005M/s  (  1.979M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.361 =C2=B1 0.005M/s  (  1.180M/s/cpu)
> uretprobe-nop   ( 4 cpus):    2.309 =C2=B1 0.002M/s  (  0.577M/s/cpu)
> uretprobe-nop   ( 8 cpus):    2.253 =C2=B1 0.001M/s  (  0.282M/s/cpu)
> uretprobe-nop   (16 cpus):    2.007 =C2=B1 0.000M/s  (  0.125M/s/cpu)
> uretprobe-nop   (32 cpus):    1.624 =C2=B1 0.003M/s  (  0.051M/s/cpu)
> uretprobe-nop   (64 cpus):    2.149 =C2=B1 0.001M/s  (  0.034M/s/cpu)
>
> SRCU CHANGES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uprobe-nop      ( 1 cpus):    3.276 =C2=B1 0.005M/s  (  3.276M/s/cpu)
> uprobe-nop      ( 2 cpus):    4.125 =C2=B1 0.002M/s  (  2.063M/s/cpu)
> uprobe-nop      ( 4 cpus):    7.713 =C2=B1 0.002M/s  (  1.928M/s/cpu)
> uprobe-nop      ( 8 cpus):    8.097 =C2=B1 0.006M/s  (  1.012M/s/cpu)
> uprobe-nop      (16 cpus):    6.501 =C2=B1 0.056M/s  (  0.406M/s/cpu)
> uprobe-nop      (32 cpus):    4.398 =C2=B1 0.084M/s  (  0.137M/s/cpu)
> uprobe-nop      (64 cpus):    6.452 =C2=B1 0.000M/s  (  0.101M/s/cpu)
>
> uretprobe-nop   ( 1 cpus):    2.055 =C2=B1 0.001M/s  (  2.055M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.677 =C2=B1 0.000M/s  (  1.339M/s/cpu)
> uretprobe-nop   ( 4 cpus):    4.561 =C2=B1 0.003M/s  (  1.140M/s/cpu)
> uretprobe-nop   ( 8 cpus):    5.291 =C2=B1 0.002M/s  (  0.661M/s/cpu)
> uretprobe-nop   (16 cpus):    5.065 =C2=B1 0.019M/s  (  0.317M/s/cpu)
> uretprobe-nop   (32 cpus):    3.622 =C2=B1 0.003M/s  (  0.113M/s/cpu)
> uretprobe-nop   (64 cpus):    3.723 =C2=B1 0.002M/s  (  0.058M/s/cpu)
>
> Peak througput increased from 3.7 mln/s (uprobe triggerings) up to about
> 8 mln/s. For uretprobes it's a bit more modest with bump from 2.4 mln/s
> to 5mln/s.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>

Ok, so it seems like rb_find_rcu() and rb_find_add_rcu() are not
enough or are buggy. I managed to more or less reliably start
reproducing a crash, which was bisected to exactly this change. My
wild guess is that we'd need an rb_erase_rcu() variant or something,
because what I'm seeing is a corrupted rb_root node while performing
lockless rb_find_rcu() operation.

You can find below debugging info (which Gmail will butcher here) in
[0], for convenience.

So, I got the below crash when running `sudo ./uprobe-stress -a20 -f3
-m5 -t4` on a 16-core QEMU VM.

[  179.375551] BUG: unable to handle page fault for address: 0000441f0f6600=
97
[  179.376612] #PF: supervisor read access in kernel mode
[  179.377334] #PF: error_code(0x0000) - not-present page
[  179.378037] PGD 0 P4D 0
[  179.378391] Oops: Oops: 0000 [#1] PREEMPT SMP
[  179.378992] CPU: 5 UID: 0 PID: 2292 Comm: uprobe-stress Tainted: G
          E      6.11.0-rc1-00025-g6f8e0d8d5b55-dirty #181
[  179.380514] Tainted: [E]=3DUNSIGNED_MODULE
[  179.381022] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  179.382475] RIP: 0010:uprobe_notify_resume+0x3db/0xc40
[  179.383148] Code: c1 e1 0c 48 2b 08 48 8b 44 24 08 48 01 c1 8b 35
bb 36 0d 03 40 f6 c6 01 0f 85 be 00 00 00 48 8b 2d ba 36 0d 03 48 85
ed 74 29 <48> 8b 85 90 00 00 00 48 39 c2 72 2d 48 39 d0 72 0f 48 3b 8d
98 00
[  179.385639] RSP: 0000:ffffc90000a93e78 EFLAGS: 00010202
[  179.386338] RAX: 74c2394808478d48 RBX: ffff888105619800 RCX: 00000000000=
04118
[  179.387480] RDX: ffff888109c18eb0 RSI: 00000000000a6130 RDI: ffff8881056=
19800
[  179.388677] RBP: 0000441f0f660007 R08: ffff8881098f1300 R09: 00000000000=
00000
[  179.389729] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881056=
80fc0
[  179.390694] R13: 0000000000000000 R14: ffff888105681068 R15: ffff8881056=
81000
[  179.391717] FS:  00007f10690006c0(0000) GS:ffff88881fb40000(0000)
knlGS:0000000000000000
[  179.392800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  179.393582] CR2: 0000441f0f660097 CR3: 00000001049bb004 CR4: 00000000003=
70ef0
[  179.394536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  179.395485] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  179.396464] Call Trace:
[  179.396796]  <TASK>
[  179.397133]  ? __die+0x1f/0x60
[  179.397640]  ? page_fault_oops+0x14c/0x440
[  179.398316]  ? do_user_addr_fault+0x5f/0x6c0
[  179.398899]  ? kvm_read_and_reset_apf_flags+0x3c/0x50
[  179.399730]  ? exc_page_fault+0x66/0x130
[  179.400361]  ? asm_exc_page_fault+0x22/0x30
[  179.400912]  ? uprobe_notify_resume+0x3db/0xc40
[  179.401500]  ? uprobe_notify_resume+0x11a/0xc40
[  179.402089]  ? arch_uprobe_exception_notify+0x39/0x40
[  179.402736]  ? notifier_call_chain+0x55/0xc0
[  179.403293]  irqentry_exit_to_user_mode+0x98/0x140
[  179.403917]  asm_exc_int3+0x35/0x40
[  179.404394] RIP: 0033:0x404119
[  179.404831] Code: 8b 45 fc 89 c7 e8 43 09 00 00 83 c0 01 c9 c3 55
48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 29 09 00 00 83 c0 01
c9 c3 cc <48> 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 0f 09 00 00
83 c0
[  179.407350] RSP: 002b:00007f1068fffab8 EFLAGS: 00000206
[  179.408083] RAX: 0000000000404118 RBX: 00007f1069000cdc RCX: 00000000000=
0000a
[  179.409020] RDX: 0000000000000012 RSI: 0000000000000064 RDI: 00000000000=
00012
[  179.409965] RBP: 00007f1068fffae0 R08: 00007f106a84403c R09: 00007f106a8=
440a0
[  179.410864] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffff=
fff80
[  179.411768] R13: 0000000000000016 R14: 00007ffc3dc8f070 R15: 00007f10688=
00000
[  179.412672]  </TASK>
[  179.412965] Modules linked in: aesni_intel(E) crypto_simd(E)
cryptd(E) kvm_intel(E) kvm(E) i2c_piix4(E) i2c_smbus(E) i2c_core(E)
i6300esb(E) crc32c_intel(E) floppy(E) pcspkr(E) button(E) serio_raw(E)
[  179.415227] CR2: 0000441f0f660097
[  179.415683] ---[ end trace 0000000000000000 ]---


Note RBP: 0000441f0f660007 and RIP: 0010:uprobe_notify_resume+0x3db/0xc40

Decoding:

[ 179.417075] Code: c1 e1 0c 48 2b 08 48 8b 44 24 08 48 01 c1 8b 35 bb
36 0d 03 40 f6 c6 01 0f 85 be 00 00 00 48 8b 2d ba 36 0d 03 48 85 ed
74 29 <48> 8b 85 90 00 00 00 48 39 c2 72 2d 48 39 d0 72 0f 48 3b 8d 98
00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: c1 e1 0c                shl $0xc,%ecx
3: 48 2b 08                sub (%rax),%rcx
6: 48 8b 44 24 08          mov 0x8(%rsp),%rax
b: 48 01 c1                add %rax,%rcx
e: 8b 35 bb 36 0d 03       mov 0x30d36bb(%rip),%esi # 0x30d36cf
14: 40 f6 c6 01            test $0x1,%sil
18: 0f 85 be 00 00 00      jne 0xdc
1e: 48 8b 2d ba 36 0d 03   mov 0x30d36ba(%rip),%rbp # 0x30d36df
25: 48 85 ed               test %rbp,%rbp
28: 74 29                  je 0x53
2a:* 48 8b 85 90 00 00 00  mov 0x90(%rbp),%rax <-- trapping instruction
31: 48 39 c2               cmp %rax,%rdx
34: 72 2d                  jb 0x63
36: 48 39 d0               cmp %rdx,%rax
39: 72 0f                  jb 0x4a
3b: 48                     rex.W
3c: 3b                     .byte 0x3b
3d: 8d                     .byte 0x8d
3e: 98                     cwtl
...


Let's also look at uprobe_notify_resume+0x3db:

(gdb) list *(uprobe_notify_resume+0x3db)
0xffffffff81242f5b is in uprobe_notify_resume
(/data/users/andriin/linux/kernel/events/uprobes.c:662).
657
658 static __always_inline
659 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
660                const struct uprobe *r)
661 {
662     if (l_inode < r->inode)
663         return -1;
664
665     if (l_inode > r->inode)
666         return 1;

So this is most probably when accessing uprobe through r->inode.

Looking at uprobe_notify_resume disassembly:

0xffffffff81242f2c <+940>:  mov 0x78(%rax),%rcx
0xffffffff81242f30 <+944>:  shl $0xc,%rcx
0xffffffff81242f34 <+948>:  sub (%rax),%rcx
0xffffffff81242f37 <+951>:  mov 0x8(%rsp),%rax
0xffffffff81242f3c <+956>:  add %rax,%rcx
0xffffffff81242f3f <+959>:  mov 0x30d36bb(%rip),%esi #
0xffffffff84316600 <uprobes_seqcount>
0xffffffff81242f45 <+965>:  test $0x1,%sil
0xffffffff81242f49 <+969>:  jne 0xffffffff8124300d <uprobe_notify_resume+11=
65>
0xffffffff81242f4f <+975>:  mov 0x30d36ba(%rip),%rbp #
0xffffffff84316610 <uprobes_tree>
0xffffffff81242f56 <+982>:  test %rbp,%rbp
0xffffffff81242f59 <+985>:  je 0xffffffff81242f84 <uprobe_notify_resume+102=
8>
0xffffffff81242f5b <+987>:  mov 0x90(%rbp),%rax
0xffffffff81242f62 <+994>:  cmp %rax,%rdx
0xffffffff81242f65 <+997>:  jb 0xffffffff81242f94 <uprobe_notify_resume+104=
4>
0xffffffff81242f67 <+999>:  cmp %rdx,%rax
0xffffffff81242f6a <+1002>: jb 0xffffffff81242f7b <uprobe_notify_resume+101=
9>
0xffffffff81242f6c <+1004>: cmp 0x98(%rbp),%rcx
0xffffffff81242f73 <+1011>: jl 0xffffffff81242f94 <uprobe_notify_resume+104=
4>
0xffffffff81242f75 <+1013>: jle 0xffffffff81242d0e <uprobe_notify_resume+39=
8>
0xffffffff81242f7b <+1019>: mov 0x8(%rbp),%rbp
0xffffffff81242f7f <+1023>: test %rbp,%rbp
0xffffffff81242f25 <+933>:  mov 0xa8(%rcx),%rdx

Not how in mov 0x90(%rbp),%rax %rbp is coming from

mov 0x30d36ba(%rip),%rbp # 0xffffffff84316610 <uprobes_tree>

So. This is inlined uprobe_cmp() on uprobes_tree.rb_node (i.e., the
root of RB tree). And we know that rbp was set to 0x0000441f0f660097,
which doesn't look like a valid kernel address to me. 0x90 is
offsetof(struct uprobe, inode), and offsetof(struct uprobe, rb_node)
=3D=3D 0. So we load the rb_node/uprobe pointer from uprobe_tree (struct
rb_root), get 0x0000441f0f660097, and then r->inode crashes the kernel
because r looks like user space address.

Note that we never modify RB tree root (or any node) directly
anywhere. We only mutate it with rb_find_add_rcu() and rb_erase(),
both under uprobes_treelock.


So, any ideas how we can end up with "corrupted" root on lockless
lookup with rb_find_rcu()? This seems to be the very first lockless
RB-tree lookup use case in the tree, so perhaps it's not that safe
after all (certainly rb_erase() is non-trivial enough to not be
"obviously correct" w.r.t. RCU, no)?

  [0] https://gist.github.com/anakryiko/df31ab75f25544af93cd41273056ee88

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b0488d356399..d03962cc96de 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -40,6 +40,7 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
>  #define no_uprobe_events()     RB_EMPTY_ROOT(&uprobes_tree)
>
>  static DEFINE_RWLOCK(uprobes_treelock);        /* serialize rbtree acces=
s */
> +static seqcount_rwlock_t uprobes_seqcount =3D SEQCNT_RWLOCK_ZERO(uprobes=
_seqcount, &uprobes_treelock);
>
>  DEFINE_STATIC_SRCU(uprobes_srcu);
>
> @@ -629,8 +630,11 @@ static void put_uprobe(struct uprobe *uprobe)
>
>         write_lock(&uprobes_treelock);
>
> -       if (uprobe_is_active(uprobe))
> +       if (uprobe_is_active(uprobe)) {
> +               write_seqcount_begin(&uprobes_seqcount);
>                 rb_erase(&uprobe->rb_node, &uprobes_tree);
> +               write_seqcount_end(&uprobes_seqcount);
> +       }
>
>         write_unlock(&uprobes_treelock);
>
> @@ -696,14 +700,26 @@ static struct uprobe *find_uprobe_rcu(struct inode =
*inode, loff_t offset)
>                 .offset =3D offset,
>         };
>         struct rb_node *node;
> +       unsigned int seq;
>
>         lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
>
> -       read_lock(&uprobes_treelock);
> -       node =3D rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
> -       read_unlock(&uprobes_treelock);
> +       do {
> +               seq =3D read_seqcount_begin(&uprobes_seqcount);
> +               node =3D rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_ke=
y);
> +               /*
> +                * Lockless RB-tree lookups can result only in false nega=
tives.
> +                * If the element is found, it is correct and can be retu=
rned
> +                * under RCU protection. If we find nothing, we need to
> +                * validate that seqcount didn't change. If it did, we ha=
ve to
> +                * try again as we might have missed the element (false
> +                * negative). If seqcount is unchanged, search truly fail=
ed.
> +                */
> +               if (node)
> +                       return __node_2_uprobe(node);
> +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
>
> -       return node ? __node_2_uprobe(node) : NULL;
> +       return NULL;
>  }
>
>  /*
> @@ -725,7 +741,7 @@ static struct uprobe *__insert_uprobe(struct uprobe *=
uprobe)
>  {
>         struct rb_node *node;
>  again:
> -       node =3D rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cm=
p);
> +       node =3D rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprob=
e_cmp);
>         if (node) {
>                 struct uprobe *u =3D __node_2_uprobe(node);
>
> @@ -750,7 +766,9 @@ static struct uprobe *insert_uprobe(struct uprobe *up=
robe)
>         struct uprobe *u;
>
>         write_lock(&uprobes_treelock);
> +       write_seqcount_begin(&uprobes_seqcount);
>         u =3D __insert_uprobe(uprobe);
> +       write_seqcount_end(&uprobes_seqcount);
>         write_unlock(&uprobes_treelock);
>
>         return u;
> --
> 2.43.0
>

