Return-Path: <bpf+bounces-55902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C41A88F25
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 00:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001D33B2BD4
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E01EE00D;
	Mon, 14 Apr 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B422TPFY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49187DDDC
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669957; cv=none; b=j3/SwHp2nIIRcC+vXpb7pOvx6EuSQjevtfabWR8CteBdIx45av0bKT5sv+FyBWgottm8epz1esmz79dLXx+joUQe8cW8IAyV2BDp+0eR6mB2VZHy67JH3mxOLByYpOLJqNctt0bTvb0A9xtRsDtndGtK5izO5RtLkHAiFHPmAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669957; c=relaxed/simple;
	bh=3QidoYoFsfX9ssgzJZ0lnd76I+WSZCGkKoxPq/hoAMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXdbmwNV6VpRXrUN4oMLrScAvwtwTbwz3HVBQAa/H6OBrJ1+kYvP47qi7l29EpQQwxZ2kIonZzodk8oPt4tZDzredPg0tYVixNHtQt+3H/10j5oJ2DrfBD5VdpPgWK+gLBj+PI29HZjyibFPomuAV2ptLojUcWLXorJkx/isxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B422TPFY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3000544f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744669952; x=1745274752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwFcKhRqSEb4x0445AABF6ANszP6R94sPtY6G2w+WHE=;
        b=B422TPFY8AdaJEt7aBj5+Bkvw8zFL2kS4BtFlrbjOG//FHXA5MyUMLVxsnA2vC+XJY
         mJmTregU6chjhci758n+5VRVbQepKthDby9GPi0+DUXoJpnLrLgHwBRx4GW9sZQnJlST
         lQARwft3Ixu4CuYON3Bv8clxvvHEKSMtTZ6gtbLytq+us6KiVKyp7W8bmYdxU1wE3jg5
         qbL/fH8LfsOxmM+H7QLGdfV3J53ItMg6JfSiCD8ZsMdc9H+Vx2voYb2KhjOYTdO3sbi/
         WufkME/HMuKDVJzGc0xQnfec71vto1sMuTS+6eRtkLqhu/u13RuNYYhaIiIIboyZUtcA
         w7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744669952; x=1745274752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwFcKhRqSEb4x0445AABF6ANszP6R94sPtY6G2w+WHE=;
        b=neu2FE5jRo6rKTVS/c/dZKhx/tGUI6HMHOo119VJm8yMVfhr2ldLggTahVu/vtviw9
         lqNAKK0YCIbncYNiGTt7sFw8nInxjlyGf0HmlHfr8CiLj2D2fcw5MNRmA215wDrv/0Rc
         CgKw+bV0OvRi9EyjXrDG9zrtoAhIG8PhHpe4PeBRlejLECJMOqyuynhNQhdxif1HRMh5
         goZHnyujBHvRgMCAYOvoPoGtB2F7AIYQLagXSxsyQNcphumzLHjcRDP9PMmijAcmBAzr
         Q1MU3CEk9aLpwc0zrfSxB6yry9lI/bN5ZCN9J0WZaSjc8/vDgh66ha7SU7VHuQzaOk4l
         1Zgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDCLCfW23ghVotCqkRXcC94S+u2b4vFiPst0FwMZf9suH4saMsvTz7eKxFW23KDEAq338=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aMOD/PcsDjMAg9DSEkDTOoZtjpYms7xCzGZ7c9zsKUp+B3df
	a53oa9asld3VIN1RReF1UMfClTQ1UD4yQtnINROsx8UKZjH4HznEZCrYgzzHw3NbtZpcYKzb6fM
	uCbcVHdiyjzhDgEOJMTwv8JCbIGM=
X-Gm-Gg: ASbGncucJPXoTZcn/lz8KWsWKWDIExZK+/d6/0bFmJkMpZzRqgcLu7jLi6c3HyD2xgA
	P7qs0PHBvT2b4qUF2Syy3fEzR+Kizz/M8tl0NtHRqC0PtVO+v+g3BxOhiKVvXKdfDNhbbMf/UHH
	spArBep7gzFcAHEEYLtRm/nRSc8eLqz+lRvrUSfM37ZLJdv9UY
X-Google-Smtp-Source: AGHT+IHUxbWSQ/REUH6s76OtcTYP0PWEA7dauRqIyzK/7snyea6TeMsiCrd3ClcyRWqgUvv5ZU+N7Gf123NvLlyzO40=
X-Received: by 2002:a5d:64aa:0:b0:391:3915:cfea with SMTP id
 ffacd0b85a97d-39eaaebdaafmr10736861f8f.38.1744669952302; Mon, 14 Apr 2025
 15:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414212207.63163-1-kuniyu@amazon.com> <20250414212207.63163-3-kuniyu@amazon.com>
In-Reply-To: <20250414212207.63163-3-kuniyu@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Apr 2025 15:32:21 -0700
X-Gm-Features: ATxdqUHCekX6ThBPI2PcMmI5VeK_cbdYfbhapFNMW2wdmqThbohxqapJTOkNNSY
Message-ID: <CAADnVQJ6NKjhWbr=ya4=R7HaWyyiFneLLisByW3JopfQQYLrpg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] bpf: Set -ENOMEM to err in bpf_int_jit_compile().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shahab Vahedi <list+bpf@vahedi.org>, 
	Russell King <linux@armlinux.org.uk>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a splat below. [0]
>
> It always followed another splat by fault injection in
> bpf_int_jit_compile(). [1]
>
> Instead of proceeding with __bpf_prog_ret0_warn() and seeing
> a splat later, let's return -ENOMEM to userspace.
>
> [0]:
> WARNING: CPU: 1 PID: 36 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0x=
a/0x10 kernel/bpf/core.c:2357
> Modules linked in:
> CPU: 1 UID: 0 PID: 36 Comm: kworker/1:1 Not tainted 6.14.0-13344-ga984368=
9e2de #28 PREEMPT(voluntary)  167b7ecb8f281ed56016416cdf1d8bb342db88fc
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> Workqueue: mld mld_ifc_work
> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x10 kernel/bpf/core.c:2357
> Code: ff eb 84 e8 b8 cf ee ff e9 7a ff ff ff e8 ae cf ee ff e9 70 ff ff f=
f 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa e8 97 cf ee ff 90 <0f> 0b 90 31 c0=
 c3 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54
> RSP: 0000:ffa0000000267050 EFLAGS: 00010293
> RAX: ffffffff81881569 RBX: ffa0000000393030 RCX: ff11000100dc4500
> RDX: 0000000000000000 RSI: ffa0000000393048 RDI: ff1100010b812a00
> RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff0e5ef77 R12: 0000000000000000
> R13: dffffc0000000000 R14: ff1100010b812a00 R15: ffa0000000393048
> FS:  0000000000000000(0000) GS:ff11000192213000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff451d686ec CR3: 00000001037eb004 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  bpf_prog_run_pin_on_cpu include/linux/filter.h:742 [inline]
>  bpf_prog_run_clear_cb+0x7f/0x140 include/linux/filter.h:983
>  run_filter+0x156/0x260 net/packet/af_packet.c:2135
>  packet_rcv+0x491/0x15b0 net/packet/af_packet.c:2208
>  dev_queue_xmit_nit+0xc27/0xcb0 net/core/dev.c:2592
>  xmit_one net/core/dev.c:3831 [inline]
>  dev_hard_start_xmit+0x1d5/0x720 net/core/dev.c:3851
>  sch_direct_xmit+0x242/0x4a0 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:4127 [inline]
>  __dev_queue_xmit+0x186d/0x37a0 net/core/dev.c:4654
>  dev_queue_xmit include/linux/netdevice.h:3355 [inline]
>  neigh_hh_output include/net/neighbour.h:523 [inline]
>  neigh_output include/net/neighbour.h:537 [inline]
>  ip6_finish_output2+0x11f3/0x16e0 net/ipv6/ip6_output.c:141
>  dst_output include/net/dst.h:459 [inline]
>  NF_HOOK+0x160/0x470 include/linux/netfilter.h:314
>  mld_sendpack+0x7f7/0xd70 net/ipv6/mcast.c:1868
>  mld_send_cr net/ipv6/mcast.c:2169 [inline]
>  mld_ifc_work+0x835/0xde0 net/ipv6/mcast.c:2702
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xa77/0x16a0 kernel/workqueue.c:3319
>  worker_thread+0x8b6/0xd50 kernel/workqueue.c:3400
>  kthread+0x413/0x870 kernel/kthread.c:464
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> [1]:
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 1 UID: 0 PID: 4562 Comm: syz.4.1225 Not tainted 6.14.0-13344-ga98436=
89e2de #28 PREEMPT(voluntary)  167b7ecb8f281ed56016416cdf1d8bb342db88fc
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xfa/0x120
>  should_fail_ex+0x501/0x610
>  should_failslab+0xba/0x120
>  __kmalloc_cache_noprof+0x5d/0x310
>  bpf_int_jit_compile+0x1292/0x18b0
>  bpf_prog_select_runtime+0x439/0x780
>
> Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable =
jits")

The Fixes tag looks wrong and I suspect you root caused it incorrectly
and the "fix" adds a ton of churn for no good reason.

If CONFIG_BPF_JIT_ALWAYS_ON=3Dy and JIT fails for whatever reason
the following should have executed:
                fp =3D bpf_int_jit_compile(fp);
                bpf_prog_jit_attempt_done(fp);
                if (!fp->jited && jit_needed) {
                        *err =3D -ENOTSUPP;
                        return fp;
                }

so the prog won't load and won't execute.

jit_needed will be false if CONFIG_BPF_JIT_ALWAYS_ON=3Dn
and if fp->jit_requested =3D=3D true then ret0_warn may indeed stay.

Then the fix is probably just this hunk:
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..662c1bd9937f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2493,7 +2493,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
bpf_prog *fp, int *err)

                fp =3D bpf_int_jit_compile(fp);
                bpf_prog_jit_attempt_done(fp);
-               if (!fp->jited && jit_needed) {
+               if (!fp->jited && (fp->jit_requested || jit_needed)) {

or maybe this instead:
-       bool jit_needed =3D false;
+       bool jit_needed =3D fp->jit_requested;

pw-bot: cr

