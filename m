Return-Path: <bpf+bounces-58937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D53AC407B
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA33AAFB4
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C120B80A;
	Mon, 26 May 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy6wunmM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4820127A;
	Mon, 26 May 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266275; cv=none; b=fs+BK/nZ90QjZFLoRBhE7s0Y+zq9bA9ePb5WEreiBrYVNpnXACqBOZhdyABmV7B2Avjpea1sc4q7VUsJ0y8/2rYtwqXUXhCjQ73M157qxDeYPf2gR9KGVpUz5In35FNlYgrdK2ckgkI5R0LdD3iBgqMu6bImXs5klfTN/kV0e6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266275; c=relaxed/simple;
	bh=w0lV+Z40e2Wq9jEnEjj5ufFouBJJJxqRDpf9epEB7RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDXAFge4VRkTzJziFN6H2VcQv9AuIVBsOfTKLvZOtv3PMWkaArgnq14AzhXLl51VSiW4My5s+sJPAjwjnCQ3pH8KEgUQgZvq3t43GKnyUZ4zWyP5h9ObYAGVA4xedp+H3CK7S/qY8BubDaAVpSAens7/zFQ/kOql+2Is3iqXQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy6wunmM; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1575724276.0;
        Mon, 26 May 2025 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266273; x=1748871073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4jfJrSbalapTRI9b7V3Fn+HJCeCdUWooGLczQl8DI4=;
        b=Wy6wunmMICvwnUfW/b2s7w4gRSv04Kk4HrvyvKg2BqsQrXAXrkeImGauNEcna4qcfw
         80Pe2UEqzKnDLZmxUAJXVITrru7gwutiaaDfyWg0Hg53HFcsKwz1O00j7oUD53F2llNw
         83DNg6k4Ty/TPlmWSURHZHPTVt5e8eXlcH8bktlR2m/t65Y81ENASEbIAKUS7k9M9bCR
         xPXie9L7+8p+fIRVMDzUNYVqsBVSQ8l2G25Hs4BQHtOFU9H9Ffj3rQsNiTWib9KRuZVT
         saA9WS7ItDrZHlof+7BTdj0+kxxdOMaL3G6V/mbKMyWugEwnoxNf1KOSgfZQnT1jpC5i
         x+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266273; x=1748871073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4jfJrSbalapTRI9b7V3Fn+HJCeCdUWooGLczQl8DI4=;
        b=JK9Kp0rsH8/YKDGsC1x2ffYSNmFFcRo9zZnpYNSDK1z7Cb2/DlYI3yUil/t29DLWGl
         3OJhXHBOQMDU3VvcprGQ/WsDjTWsDVkM9EYPEK0aeuawQwHuy5EdBOu5P9hYg8Gl8zo8
         m4nxZReWVefGC7Kj6lAGuKtxTpY6hnBpRpmTY2dhPR0gPJRLmyIalYnQL65DiyCX1dv2
         /mBQS2SX048xcoKs9O//oATjv6tY94s11eqVEs6WogmhzqHoanzrJMTFUXGSJDhbtXA8
         cqjg8xregpH0gNiOpvvVhsqb+UUTDErMJAXOtLAysVUIYlxp1AcPm8etFhMV+cVStSMu
         Y6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW+SEID8offz6p68AxzZ6R/E2+3mLu1dBiXCq8n7Hibyy81oR9cQCbECMKgqX7643U3rSNuRniaU1B70+Ns@vger.kernel.org, AJvYcCWyhLtphr0YVGPwG83BbT8WRYjWLoWCsmHxNBv7Uy2Bb0ulq85RDSB9N30EX+BeZGiXSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/v0JCEXUQPnZN1kJHW6qPH2vw4r1Ns6yN5d+/bN7MBGQoVL4
	uvOhrZmbg4KB9hZBGj1wfE/YlljhI8w6oJIAfXVGw5OHHFWDh3CrIuQndApiAFVfv9MpUoKL+te
	r2noZjGo2Vqoy7lWmZV9NbAiIUAsqWPo=
X-Gm-Gg: ASbGnctvDvIzQQsfwDOVicG5rCxc5cz+OHXi07VSpAEMl9Qsb/jDJ/dPgi0wrVxzI07
	lS8WbW6Du6JtKi9BIyAjuKLjiJ8VFkkCpkHGHoZsvdBPji1i0gYpV/j4OlbWR6Yz1KTSKC1ks4K
	FseSg9ay/feq3jStsjryrVsSf8Khyd6PwqXIvcYvQ0NpNe
X-Google-Smtp-Source: AGHT+IEVegPMh9wq9auNj89oeGl82gBVDrNa4BDTZwwFDh/zAf0m0oA+I+fj114L218eF+g85OZmqwsMDQqK2CCN43Y=
X-Received: by 2002:a05:6902:c12:b0:e7b:6671:5658 with SMTP id
 3f1490d57ef6-e7d91b45963mr11770559276.43.1748266272742; Mon, 26 May 2025
 06:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6816e34e.a70a0220.254cdc.002c.GAE@google.com> <634e5312cbaa01a31fe8781167dfb2dc8e932f2a.camel@gmail.com>
 <CAADnVQLKgP=Ejxm+C0d3tNeQVboEtAcB_QS=hdcCpw_8j-pXMg@mail.gmail.com>
In-Reply-To: <CAADnVQLKgP=Ejxm+C0d3tNeQVboEtAcB_QS=hdcCpw_8j-pXMg@mail.gmail.com>
From: Kafai Wan <mannkafai@gmail.com>
Date: Mon, 26 May 2025 21:31:00 +0800
X-Gm-Features: AX0GCFteHgzYp_GcwiwyP1k8EzUZhyhY3OBldjgvnHwgTCXQ0PoK8q2zBgxf3SY
Message-ID: <CALqUS-6rP18c26_cTcAi5nTdAYgu4VNJvnyhCfTZ2dhsk416Yw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in __bpf_prog_ret0_warn
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	syzbot <syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 10:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 23, 2025 at 7:48=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> w=
rote:
> >
> > On Sat, 2025-05-03 at 20:47 -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of
> > > git://git.kernel..
> > > git tree:       upstream
> > > console output:
> > > https://syzkaller.appspot.com/x/log.txt?x=3D10f03774580000
> > > kernel config:
> > > https://syzkaller.appspot.com/x/.config?x=3D541aa584278da96c
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=3D0903f6d7f285e41cdf10
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > > for Debian) 2.40
> > > syz repro:
> > > https://syzkaller.appspot.com/x/repro.syz?x=3D1550ca70580000
> > > C reproducer:
> > > https://syzkaller.appspot.com/x/repro.c?x=3D17d10f74580000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable):
> > > https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootabl=
e_disk-8bac8898.raw.xz
> > > vmlinux:
> > > https://storage.googleapis.com/syzbot-assets/5f7c2d7e1cd1/vmlinux-8ba=
c8898.xz
> > > kernel image:
> > > https://storage.googleapis.com/syzbot-assets/77a157d2769a/bzImage-8ba=
c8898.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the
> > > commit:
> > > Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357
> > > __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> > > Modules linked in:
> > > CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-
> > > syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> > > debian-1.16.3-2~bpo12+1 04/01/2014
> > > Workqueue: ipv6_addrconf addrconf_dad_work
> > > RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> > > Code: f3 0f 1e fa e8 a7 c7 f0 ff 31 c0 c3 cc cc cc cc 90 90 90 90 90
> > > 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 87 c7 f0 ff 90 <0f>
> > > 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
> > > RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
> > > RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
> > > RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
> > > R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
> > > FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000)
> > > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
> > >  __bpf_prog_run include/linux/filter.h:718 [inline]
> > >  bpf_prog_run include/linux/filter.h:725 [inline]
> > >  cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
> > >  tc_classify include/net/tc_wrapper.h:197 [inline]
> > >  __tcf_classify net/sched/cls_api.c:1764 [inline]
> > >  tcf_classify+0x7ef/0x1380 net/sched/cls_api.c:1860
> > >  htb_classify net/sched/sch_htb.c:245 [inline]
> > >  htb_enqueue+0x2f6/0x12d0 net/sched/sch_htb.c:624
> > >  dev_qdisc_enqueue net/core/dev.c:3984 [inline]
> > >  __dev_xmit_skb net/core/dev.c:4080 [inline]
> > >  __dev_queue_xmit+0x2142/0x43e0 net/core/dev.c:4595
> > >  dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> > >  neigh_hh_output include/net/neighbour.h:523 [inline]
> > >  neigh_output include/net/neighbour.h:537 [inline]
> > >  ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
> > >  __ip_finish_output net/ipv4/ip_output.c:313 [inline]
> > >  __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
> > >  ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:323
> > >  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> > >  ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
> > >  dst_output include/net/dst.h:459 [inline]
> > >  ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:129
> > >  iptunnel_xmit+0x5d5/0xa00 net/ipv4/ip_tunnel_core.c:82
> > >  geneve_xmit_skb drivers/net/geneve.c:921 [inline]
> > >  geneve_xmit+0x2bc5/0x5610 drivers/net/geneve.c:1046
> > >  __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
> > >  netdev_start_xmit include/linux/netdevice.h:5212 [inline]
> > >  xmit_one net/core/dev.c:3776 [inline]
> > >  dev_hard_start_xmit+0x93/0x740 net/core/dev.c:3792
> > >  __dev_queue_xmit+0x7eb/0x43e0 net/core/dev.c:4629
> > >  dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> > >  neigh_hh_output include/net/neighbour.h:523 [inline]
> > >  neigh_output include/net/neighbour.h:537 [inline]
> > >  ip6_finish_output2+0xe98/0x2020 net/ipv6/ip6_output.c:141
> > >  __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
> > >  ip6_finish_output+0x3f9/0x1360 net/ipv6/ip6_output.c:226
> > >  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> > >  ip6_output+0x1f9/0x540 net/ipv6/ip6_output.c:247
> > >  dst_output include/net/dst.h:459 [inline]
> > >  NF_HOOK include/linux/netfilter.h:314 [inline]
> > >  NF_HOOK include/linux/netfilter.h:308 [inline]
> > >  mld_sendpack+0x9e9/0x1220 net/ipv6/mcast.c:1868
> > >  mld_send_initial_cr.part.0+0x1a1/0x260 net/ipv6/mcast.c:2285
> > >  mld_send_initial_cr include/linux/refcount.h:291 [inline]
> > >  ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
> > >  addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4341
> > >  addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4269
> > >  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
> > >  process_scheduled_works kernel/workqueue.c:3319 [inline]
> > >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> > >  kthread+0x3c2/0x780 kernel/kthread.c:464
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before
> > > testing.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >
> >
> > I think this issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is
> > not set and /proc/sys/net/core/bpf_jit_enable is set to 1, causing the
> > arch to attempt JIT the prog, but jit failed due to FAULT_INJECTION.
> >
> > When `bpf_jit_enable` set to 1, sets `fp->jit_requested =3D 1` to
> > indicate need to jit when create BPF program. During runtime selection,
> > set 'fp->bpf_func' to `__bpf_prog_ret0_warn` by default, and should
> > return an error when prog need to jit(`jit_needed`) but not jited.
> >
> > Since CONFIG_BPF_JIT_ALWAYS_ON is not set and the BPF program contains
> > no kfuncs, the `jit_needed` set to false. As a result, incorrectly
> > treats the program as valid, when the program runs it calls
> > `__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).
> >
> > --
> > Thanks,
> > kafai
> >
> > #syz test
> >
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf50..4c951d60bef5 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2474,8 +2474,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
> > bpf_prog *fp, int *err)
> >         if (fp->bpf_func)
> >                 goto finalize;
> >
> > -       if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> > -           bpf_prog_has_kfunc_call(fp))
> > +       if (fp->jit_requested || bpf_prog_has_kfunc_call(fp))
> >                 jit_needed =3D true;
>
> Not quite.
> See the thread:
> https://lore.kernel.org/bpf/CAADnVQJ6NKjhWbr=3Dya4=3DR7HaWyyiFneLLisByW3J=
opfQQYLrpg@mail.gmail.com/
>
> I'm still waiting for somebody to send the patch.

I'll send the patch.

