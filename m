Return-Path: <bpf+bounces-58836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE8AC25AA
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E57540E9B
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990E298CD7;
	Fri, 23 May 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3Qq9PdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CB298CBD;
	Fri, 23 May 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011966; cv=none; b=YwiHAG13U5fSM4GIuNBwIPFiH1obt7cwyAV+BjD8OihXiRfn9cHxMhREPixJQHVcAgJwmKsfRdPRe4w7xO9g5cyfnTCm6kTDZ7hZ9aVOZ+VURCqUtAOusLFrWXbsbeo//KQVU5cwvU9tK8i6WiI8CvzsFW88MyUR6zWPES+TmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011966; c=relaxed/simple;
	bh=maRnzGJ0uWTVut1ZrZFF3O1/f8XWGrWqh5QkV8UFj8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+FoILKdXEvJgOIrUWaAfpeyY6KYy9iMyeFCgOVba20dHxW7wSsDFJ65nvspIYQy1Ht4cEa+EWNGFRmbUewIJt9qUvEvtMiNEZ43uG+VRSuaGSjDw7lKPl3BN+W+1otVxgN0SmeTcx+3j5QO/u7/S05aDZGDEh1HZSCuvfYnGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3Qq9PdW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso116144505e9.2;
        Fri, 23 May 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748011963; x=1748616763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2+ZmtFW/MEGFd2AyqRDiHSsMkymk3pJIgbkHk1MI78=;
        b=F3Qq9PdWDtmT76H5ZMAqte8Yg0Oj/STkLJOFIivsdSbG6r4blZ/tT0XrgQcbD/Dxsw
         +Ot6WaPin1DhjEVKsL+T1B5pnPipzeIvh+2itwE0Yor7uWzxp8CLa50Dxcarg/cwhUMV
         0tergrlN4n7H5TxlJx/MgoFOnLmLUdR2UYgez5J4AMVaYAfY8tgdv57SYAFUEqlXA8xZ
         786c4Ejh8GIoqC5coWEz2sW4DSiXm1zkcJbsLwOpUDB0SeO+DozormP+tLz5ulivNnmr
         o8UpBSgRiHTc8Fvj0mCU0UZhFMI2zljEXip3pOUTsDxyMFkCXOz7cWEuZ2ypSO87Dw42
         wqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011963; x=1748616763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2+ZmtFW/MEGFd2AyqRDiHSsMkymk3pJIgbkHk1MI78=;
        b=C8G2V/hpJeLE8GxTYcXtAcWCs/Psc+wK6Bu2S9EHggk9UspZxMBzpXKr6w5JiCDg9O
         Ftbk5EQLLq78/EKKj01hatFBpSuliK1U7Gh2H2EXBiWmhWB8A+3xppD1e6aIN3ywvF/1
         aQOyz7w50ricQVBZgLVSjBFqGSU6EM6loubXuUrHWDFg+9zQTOSyLcqoOxbCH7gntL7K
         li5ctmdsC4Jia0NG0Wd6ScCrsd8nWTe5on9uFnK2+PF8tLFnCfR0rNDdJ/KaCiNitVdq
         ldYjkMYgLLkDDGeKujH3hWJeIC51jXhFBeyUSJ1d5vWwoTPmyRpBpmzEV+YOXWI+oZZe
         y78g==
X-Forwarded-Encrypted: i=1; AJvYcCVuVHQcaFSQrkhWaGSx+hU2u8pobIUg6yQaDkI/w8UIDOhJow48sSzgnE+N4G36huPj+AA=@vger.kernel.org, AJvYcCVxbo/Iwubmy0j5f1pjVKAHhEmOwrLq0HzmmE6PQuB8tWGi6ypa8SAOxPsc8zbO4LbcF3kZiy0+W/fiSuua@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xlipFr/en8sb6V3+NubG9tBhpWXOBR8D5FqlmGOxrqV9M3q4
	djEcBHaeiYh/hh9khKf9HxWiLY6TDp7RSIy7KRB3IBKIDiM8vjO03p/J4WO1z0PXfj3kajsFggr
	BOdb5fMwRJbD6Wljo0KEB5bI6szWSdlA=
X-Gm-Gg: ASbGncuQ/IjmQXrQS5Y5gXCubs4tP9mEGvo1ahd4ePYBXYrE7fulsrRAhRLSMzoXsEl
	/3gpxvVcUfSWi1+HDD0jo573h9HXahnf+H9aZvWtRupPfYPrmOb8zLGcheg/EKb6PsCDFSlXUld
	QxwUrx4illTqzWnwHZYjy5uOwsV5xuGf4eI6jyIq36AfAwTXs=
X-Google-Smtp-Source: AGHT+IEN1wGPCfVDVcm0x2LwWtEJSdBEukj/v7dxbhk/bLfgWKdrZ9RyGaFUfXPM/lua3z6UmmXMMnxdBxBFgo0D2HM=
X-Received: by 2002:a05:6000:22ca:b0:3a3:7769:4f79 with SMTP id
 ffacd0b85a97d-3a4c20f8a0fmr3285930f8f.20.1748011962672; Fri, 23 May 2025
 07:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6816e34e.a70a0220.254cdc.002c.GAE@google.com> <634e5312cbaa01a31fe8781167dfb2dc8e932f2a.camel@gmail.com>
In-Reply-To: <634e5312cbaa01a31fe8781167dfb2dc8e932f2a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 May 2025 07:52:30 -0700
X-Gm-Features: AX0GCFtwbOH17qSH8PL2_fYDzItSS44MHH9oKZ7XGxUi9Gg5M16a09Bnw-Jdzfo
Message-ID: <CAADnVQLKgP=Ejxm+C0d3tNeQVboEtAcB_QS=hdcCpw_8j-pXMg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in __bpf_prog_ret0_warn
To: KaFai Wan <mannkafai@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: syzbot <syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:48=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> On Sat, 2025-05-03 at 20:47 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of
> > git://git.kernel..
> > git tree:       upstream
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=3D10f03774580000
> > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=3D541aa584278da96c
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3D0903f6d7f285e41cdf10
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > for Debian) 2.40
> > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=3D1550ca70580000
> > C reproducer:
> > https://syzkaller.appspot.com/x/repro.c?x=3D17d10f74580000
> >
> > Downloadable assets:
> > disk image (non-bootable):
> > https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_=
disk-8bac8898.raw.xz
> > vmlinux:
> > https://storage.googleapis.com/syzbot-assets/5f7c2d7e1cd1/vmlinux-8bac8=
898.xz
> > kernel image:
> > https://storage.googleapis.com/syzbot-assets/77a157d2769a/bzImage-8bac8=
898.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357
> > __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-
> > syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> > debian-1.16.3-2~bpo12+1 04/01/2014
> > Workqueue: ipv6_addrconf addrconf_dad_work
> > RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> > Code: f3 0f 1e fa e8 a7 c7 f0 ff 31 c0 c3 cc cc cc cc 90 90 90 90 90
> > 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 87 c7 f0 ff 90 <0f>
> > 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
> > RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
> > RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
> > RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
> > R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
> > FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
> >  __bpf_prog_run include/linux/filter.h:718 [inline]
> >  bpf_prog_run include/linux/filter.h:725 [inline]
> >  cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
> >  tc_classify include/net/tc_wrapper.h:197 [inline]
> >  __tcf_classify net/sched/cls_api.c:1764 [inline]
> >  tcf_classify+0x7ef/0x1380 net/sched/cls_api.c:1860
> >  htb_classify net/sched/sch_htb.c:245 [inline]
> >  htb_enqueue+0x2f6/0x12d0 net/sched/sch_htb.c:624
> >  dev_qdisc_enqueue net/core/dev.c:3984 [inline]
> >  __dev_xmit_skb net/core/dev.c:4080 [inline]
> >  __dev_queue_xmit+0x2142/0x43e0 net/core/dev.c:4595
> >  dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> >  neigh_hh_output include/net/neighbour.h:523 [inline]
> >  neigh_output include/net/neighbour.h:537 [inline]
> >  ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
> >  __ip_finish_output net/ipv4/ip_output.c:313 [inline]
> >  __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
> >  ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:323
> >  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> >  ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
> >  dst_output include/net/dst.h:459 [inline]
> >  ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:129
> >  iptunnel_xmit+0x5d5/0xa00 net/ipv4/ip_tunnel_core.c:82
> >  geneve_xmit_skb drivers/net/geneve.c:921 [inline]
> >  geneve_xmit+0x2bc5/0x5610 drivers/net/geneve.c:1046
> >  __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:5212 [inline]
> >  xmit_one net/core/dev.c:3776 [inline]
> >  dev_hard_start_xmit+0x93/0x740 net/core/dev.c:3792
> >  __dev_queue_xmit+0x7eb/0x43e0 net/core/dev.c:4629
> >  dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> >  neigh_hh_output include/net/neighbour.h:523 [inline]
> >  neigh_output include/net/neighbour.h:537 [inline]
> >  ip6_finish_output2+0xe98/0x2020 net/ipv6/ip6_output.c:141
> >  __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
> >  ip6_finish_output+0x3f9/0x1360 net/ipv6/ip6_output.c:226
> >  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> >  ip6_output+0x1f9/0x540 net/ipv6/ip6_output.c:247
> >  dst_output include/net/dst.h:459 [inline]
> >  NF_HOOK include/linux/netfilter.h:314 [inline]
> >  NF_HOOK include/linux/netfilter.h:308 [inline]
> >  mld_sendpack+0x9e9/0x1220 net/ipv6/mcast.c:1868
> >  mld_send_initial_cr.part.0+0x1a1/0x260 net/ipv6/mcast.c:2285
> >  mld_send_initial_cr include/linux/refcount.h:291 [inline]
> >  ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
> >  addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4341
> >  addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4269
> >  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
> >  process_scheduled_works kernel/workqueue.c:3319 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> >  kthread+0x3c2/0x780 kernel/kthread.c:464
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before
> > testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>
> I think this issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is
> not set and /proc/sys/net/core/bpf_jit_enable is set to 1, causing the
> arch to attempt JIT the prog, but jit failed due to FAULT_INJECTION.
>
> When `bpf_jit_enable` set to 1, sets `fp->jit_requested =3D 1` to
> indicate need to jit when create BPF program. During runtime selection,
> set 'fp->bpf_func' to `__bpf_prog_ret0_warn` by default, and should
> return an error when prog need to jit(`jit_needed`) but not jited.
>
> Since CONFIG_BPF_JIT_ALWAYS_ON is not set and the BPF program contains
> no kfuncs, the `jit_needed` set to false. As a result, incorrectly
> treats the program as valid, when the program runs it calls
> `__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).
>
> --
> Thanks,
> kafai
>
> #syz test
>
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..4c951d60bef5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2474,8 +2474,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
> bpf_prog *fp, int *err)
>         if (fp->bpf_func)
>                 goto finalize;
>
> -       if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -           bpf_prog_has_kfunc_call(fp))
> +       if (fp->jit_requested || bpf_prog_has_kfunc_call(fp))
>                 jit_needed =3D true;

Not quite.
See the thread:
https://lore.kernel.org/bpf/CAADnVQJ6NKjhWbr=3Dya4=3DR7HaWyyiFneLLisByW3Jop=
fQQYLrpg@mail.gmail.com/

I'm still waiting for somebody to send the patch.

