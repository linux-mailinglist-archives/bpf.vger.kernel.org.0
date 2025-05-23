Return-Path: <bpf+bounces-58835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D788AAC2563
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF87BA4442B
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F221C295DBA;
	Fri, 23 May 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuPfjiUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A0248F63;
	Fri, 23 May 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011684; cv=none; b=pEWPk/Bzwq61wqyU1p6igZ1qkJuo1b8rH+se6/EXEUV7x81BM3tJ7Z+2AJM3qXaKtw38IVipkDlUsqlrGfX0mT9ZhHHXVq1OUa1J5TjlLO9QRXRXSYCrjLX/fGA32Mbh0o9DpKZ9sbxgxOjtZQlXPG4CjAL+OnmVmef9pX/Yobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011684; c=relaxed/simple;
	bh=V8G69pvd2tNZFLKR7XA9L75+glRFI5zfuV/Bbwk9yh8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEwscXNa0ngoDuTPWO/7In+Vv0gR95Y6RNvpH7z/FINEwKd16RuwKrQbXKBEpszUzOQb53/yqiNDM8CR9vc3FtmE5+S36BjYKIUt6rhOwVWjKQ/brmGR2KJ0MzXnGJFD/lI4eWmrKXbIpPcLhzZdnTnXrQMNmzgnuD/6ijxyvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuPfjiUG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70811611315so30137b3.1;
        Fri, 23 May 2025 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748011681; x=1748616481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u6pyxLFnLrt3nYm1AId8zC+SeQN2Lo9TW+oH/5GDDw=;
        b=AuPfjiUGK+4rMuVfQa5vELerW5C8/RyWcVL6Pfv5RV35EHyif81QBxVeCYiEUdRIpN
         8G8tyiwd/pdTRg2v56IVhJI/iz25m0vDGojni4lxmpA1MA+rsGZFWvcDTXHvxCgX2avp
         J1JInxddGZonul0X9GZp0NW9KP4FjHL4t/TjSChoM91Qh7+m2F6VZDXsuqIWUvDKV8Cr
         7zraSzCl8+mekTJ6Kl9hXgVh+fH51A3MDFCGm0dYoOb6b6VZ7SSB1O8AQqK1TgvSx3G1
         CwImzS2KSI8zZEvCUb8K377EATPkQcLWX0dELKwf17b+SU2jGQoDiN8XQ/Dwgf1ZEpRa
         qlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011681; x=1748616481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/u6pyxLFnLrt3nYm1AId8zC+SeQN2Lo9TW+oH/5GDDw=;
        b=aolDzRLyvlvXmlAIpQC1rQsvlaJCofXyD9F2edpCMx8r1UWceDLhHLFoXF2mkWw94K
         cPaMKMinS/Sb7x8GUJoRILjWX3k/iOBLgJ4zTsddP/itLV1YYt3a2UjAcEFeGhuySzFC
         SkCKK2CtIP/GiqFsARdIc6mEjRdA5TnkYsvYvrilPrR52yvUtj/276xd54djU7eVVD7p
         2waDkVmh8WMqGbQUYDQmnF0PAJ94XDrM7WkQCd975CGqpKVlpC0bX6ixz2Qn9SVg3vzB
         T9OhIPg+h5odqg3KUINZzVv6Qyzcu+JTh/YkHSOKtUQidvKjdzcmgmCTba0vrpfiFFYN
         lXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Fi0LCDXGlBlqahYTGO5u1wEaAyHkJzTSLEzMUUS59KpfSkoYWleGmIIy57ZwDTAuBXnpVWuzT5KprZuc@vger.kernel.org, AJvYcCX47uBzCVe1/4nlYe49R0ydjDa4j7eK8Mn6J5yLXg0ARV9IuqRwpo//YsGtpdNC5hYx2WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccMCMMmn94nBJ3m0gcE3PCeDpVU3OOU+Z20sp9QR3Y4SuWqM5
	aYAnctIIFpOB4GJkosDJ7MuzPFJrG569cIabTt7JXVAuoiI/B8gdPUHjzToR/jF8
X-Gm-Gg: ASbGncskzn9oBmutZZR3zpAIZQmaBPH4SlKfn0ys9vzOSI8ViSOkxGZJF64vKtNApxx
	qY05zJRGM9bu8NTj2PGmyQoJlqWdSeFhlxk1AadKE6q8LwqryVI7w2DCdPiAEz/TWrLy8+iaCNv
	5E7VPfyeV7d4RkF2DRVtMJAr7BTJbFt6wkjxQWaQJjqk0x9SLgLU7DR79XlSqV51sj/nccBXoeg
	vA51op/vSoa04YNg5iF9fa2LXMapvtFbDkXWd9GfCMAsIY1ashYmr81YptSeQFJ4GZwqiZTNSmn
	H6MRLXgW1OBIhjCm60HXg87yYhxuBh0yx4wiT5fovG3rH2Qyl+NLZpx/QxYXRQ==
X-Google-Smtp-Source: AGHT+IGul4UHo4z7JKDw1c52ejvIT0ztgH+mxcyv1Hhk3UvBTtfRXOlGadC4PuDYx0h0MedujoQO5A==
X-Received: by 2002:a05:6214:248a:b0:6f2:c81f:9ef0 with SMTP id 6a1803df08f44-6f8b2d15058mr470317116d6.28.1748011670483;
        Fri, 23 May 2025 07:47:50 -0700 (PDT)
Received: from [127.0.0.1] ([62.192.175.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0883e48sm115537826d6.6.2025.05.23.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:47:50 -0700 (PDT)
Message-ID: <634e5312cbaa01a31fe8781167dfb2dc8e932f2a.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in __bpf_prog_ret0_warn
From: KaFai Wan <mannkafai@gmail.com>
To: syzbot <syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com>, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org,  kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev,  sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Date: Fri, 23 May 2025 22:47:43 +0800
In-Reply-To: <6816e34e.a70a0220.254cdc.002c.GAE@google.com>
References: <6816e34e.a70a0220.254cdc.002c.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-05-03 at 20:47 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of
> git://git.kernel..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D10f03774580000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D541aa584278da96c
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D0903f6d7f285e41cdf10
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcc (Debian 12.2.0-14) 12.2=
.0, GNU ld (GNU Binutils
> for Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D1550ca70580000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D17d10f74580000
>=20
> Downloadable assets:
> disk image (non-bootable):
> https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_di=
sk-8bac8898.raw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/5f7c2d7e1cd1/vmlinux-8bac889=
8.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/77a157d2769a/bzImage-8bac889=
8.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357
> __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> Modules linked in:
> CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-
> syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> Code: f3 0f 1e fa e8 a7 c7 f0 ff 31 c0 c3 cc cc cc cc 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 87 c7 f0 ff 90 <0f>
> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
> RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
> RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
> RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
> R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
> FS:=C2=A0 0000000000000000(0000) GS:ffff8880d6ce2000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> =C2=A0<TASK>
> =C2=A0bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
> =C2=A0__bpf_prog_run include/linux/filter.h:718 [inline]
> =C2=A0bpf_prog_run include/linux/filter.h:725 [inline]
> =C2=A0cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
> =C2=A0tc_classify include/net/tc_wrapper.h:197 [inline]
> =C2=A0__tcf_classify net/sched/cls_api.c:1764 [inline]
> =C2=A0tcf_classify+0x7ef/0x1380 net/sched/cls_api.c:1860
> =C2=A0htb_classify net/sched/sch_htb.c:245 [inline]
> =C2=A0htb_enqueue+0x2f6/0x12d0 net/sched/sch_htb.c:624
> =C2=A0dev_qdisc_enqueue net/core/dev.c:3984 [inline]
> =C2=A0__dev_xmit_skb net/core/dev.c:4080 [inline]
> =C2=A0__dev_queue_xmit+0x2142/0x43e0 net/core/dev.c:4595
> =C2=A0dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> =C2=A0neigh_hh_output include/net/neighbour.h:523 [inline]
> =C2=A0neigh_output include/net/neighbour.h:537 [inline]
> =C2=A0ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
> =C2=A0__ip_finish_output net/ipv4/ip_output.c:313 [inline]
> =C2=A0__ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
> =C2=A0ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:323
> =C2=A0NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> =C2=A0ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
> =C2=A0dst_output include/net/dst.h:459 [inline]
> =C2=A0ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:129
> =C2=A0iptunnel_xmit+0x5d5/0xa00 net/ipv4/ip_tunnel_core.c:82
> =C2=A0geneve_xmit_skb drivers/net/geneve.c:921 [inline]
> =C2=A0geneve_xmit+0x2bc5/0x5610 drivers/net/geneve.c:1046
> =C2=A0__netdev_start_xmit include/linux/netdevice.h:5203 [inline]
> =C2=A0netdev_start_xmit include/linux/netdevice.h:5212 [inline]
> =C2=A0xmit_one net/core/dev.c:3776 [inline]
> =C2=A0dev_hard_start_xmit+0x93/0x740 net/core/dev.c:3792
> =C2=A0__dev_queue_xmit+0x7eb/0x43e0 net/core/dev.c:4629
> =C2=A0dev_queue_xmit include/linux/netdevice.h:3350 [inline]
> =C2=A0neigh_hh_output include/net/neighbour.h:523 [inline]
> =C2=A0neigh_output include/net/neighbour.h:537 [inline]
> =C2=A0ip6_finish_output2+0xe98/0x2020 net/ipv6/ip6_output.c:141
> =C2=A0__ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
> =C2=A0ip6_finish_output+0x3f9/0x1360 net/ipv6/ip6_output.c:226
> =C2=A0NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> =C2=A0ip6_output+0x1f9/0x540 net/ipv6/ip6_output.c:247
> =C2=A0dst_output include/net/dst.h:459 [inline]
> =C2=A0NF_HOOK include/linux/netfilter.h:314 [inline]
> =C2=A0NF_HOOK include/linux/netfilter.h:308 [inline]
> =C2=A0mld_sendpack+0x9e9/0x1220 net/ipv6/mcast.c:1868
> =C2=A0mld_send_initial_cr.part.0+0x1a1/0x260 net/ipv6/mcast.c:2285
> =C2=A0mld_send_initial_cr include/linux/refcount.h:291 [inline]
> =C2=A0ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
> =C2=A0addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4341
> =C2=A0addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4269
> =C2=A0process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
> =C2=A0process_scheduled_works kernel/workqueue.c:3319 [inline]
> =C2=A0worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> =C2=A0kthread+0x3c2/0x780 kernel/kthread.c:464
> =C2=A0ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> =C2=A0</TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

I think this issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is
not set and /proc/sys/net/core/bpf_jit_enable is set to 1, causing the
arch to attempt JIT the prog, but jit failed due to FAULT_INJECTION.=C2=A0

When `bpf_jit_enable` set to 1, sets `fp->jit_requested =3D 1` to
indicate need to jit when create BPF program. During runtime selection,
set 'fp->bpf_func' to `__bpf_prog_ret0_warn` by default, and should
return an error when prog need to jit(`jit_needed`) but not jited.=C2=A0

Since CONFIG_BPF_JIT_ALWAYS_ON is not set and the BPF program contains
no kfuncs, the `jit_needed` set to false.=C2=A0As a result, incorrectly
treats the program as valid, when the program runs it calls
`__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).

--=20
Thanks,
kafai

#syz test


diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..4c951d60bef5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2474,8 +2474,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
bpf_prog *fp, int *err)
 	if (fp->bpf_func)
 		goto finalize;
=20
-	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	if (fp->jit_requested || bpf_prog_has_kfunc_call(fp))
 		jit_needed =3D true;
=20
 	bpf_prog_select_func(fp);

