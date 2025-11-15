Return-Path: <bpf+bounces-74649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95EC603BE
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3C64E1795
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B952882A7;
	Sat, 15 Nov 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGxwWuz3"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7852264BD
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763205642; cv=none; b=EHtocOCl9NiP9YkIBmOJ+5dW6GoaUTTCjtPahn4Nnyf0gpKQ+00IHL0DlQuJ8cKcbcpvQI5A7ZuZYraVB+DRFDK5zVXfItbh/sPoYIhPXRbZ2+PZt3TgFKtViLAgNP1zkSHT+c4QU5g59RH3YUMfjWp/jq5Q9mvecoi+tuGsrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763205642; c=relaxed/simple;
	bh=a8zCqIg7DE+0VPor1GAOjQGzNWpE+HKnKxcO6M7EKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLu9CsZ+w8NFqPc4ZCdOuUTI+wDVSvK6OIdSqCFbF8S9ncVSbW5zQ+aBpq1xiJAIwORZYJ8ricPiLST5MVUBeL6r047BMqGkoduFV5klxM5AR0HPX54qSjB8f/2EH2B4G3zPEeLjNILR7u/kSNtjsFmSaDLP5fyuqIIQnDztCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGxwWuz3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763205636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHY1FSfrYIqLGp9tQiy6g3OoqpujTA3vHoKoRYU4M2E=;
	b=hGxwWuz3S7aEPKKNbWJUTV/CINF11bwQa3o7gBLYALvRZSTQvmn4OAePi5vV12pg8A1Wnz
	OmInpg7wlFeCEtwe8+xEpA4xtQJydV21PU89WQobEQb90mXuUq0iT+kmwOIvAcEtGok9z/
	8vLAKROGZ46VrCGRaefYmYrRXpeoWlQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Network Development <netdev@vger.kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2)
Date: Sat, 15 Nov 2025 19:20:12 +0800
Message-ID: <5938862.DvuYhMxLoT@7950hx>
In-Reply-To:
 <CAADnVQK8Viv9DTtfSQTm8T4Nuy2zoUyqRvhqTtzZWNc3By2Xpg@mail.gmail.com>
References:
 <69155df5.a70a0220.3124cb.0018.GAE@google.com> <9537276.CDJkKcVGEf@7950hx>
 <CAADnVQK8Viv9DTtfSQTm8T4Nuy2zoUyqRvhqTtzZWNc3By2Xpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/15 10:36, Alexei Starovoitov wrote:
> On Thu, Nov 13, 2025 at 11:08=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> >
> >
> > Hmm...I have not figure out a good idea, and maybe we can
> > use some transaction process here. Is there anyone else
> > that working on this issue?
>=20
> yeah. it's not easy. rqspinlock is not a drop-in replacement.
> But before we move any further, can you actually reproduce?
> I tried the repro.c with lockdep, kasan and all other debug configs
> and it doesn't repro.
> Maybe it was fixed already by nokprobe-ing lru, but syzbot didn't notice.

I think it's not fix yet. After pulling the latest bpf-next, it can
still be reproduced in my environment by running the ./test_progs
for several times, and following is the log.

We can still use the lru map in NMI context now, right? So I guess
the problem exists.

[  230.458271] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  230.458272] WARNING: inconsistent lock state
[  230.458273] 6.18.0-rc5-g0d1fd0291e7a #82 Tainted: G        W  OE    N=20
[  230.458274] --------------------------------
[  230.458275] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  230.458275] new_name/10710 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  230.458277] ffffe8ffffbeade0 (&loc_l->lock){....}-{2:2}, at: bpf_lru_pop=
_free+0xea/0x620
[  230.458282] {INITIAL USE} state was registered at:
[  230.458283]   lock_acquire+0xbc/0x2e0
[  230.458285]   _raw_spin_lock_irqsave+0x39/0x60
[  230.458288]   bpf_lru_pop_free+0xea/0x620
[  230.458289]   htab_lru_map_update_elem+0x7e/0x430
[  230.458290]   bpf_map_update_value+0x341/0x7d0
[  230.458292]   __sys_bpf+0x2360/0x3090
[  230.458293]   __x64_sys_bpf+0x21/0x30
[  230.458295]   do_syscall_64+0xbb/0x380
[  230.458297]   entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  230.458299] irq event stamp: 186
[  230.458299] hardirqs last  enabled at (185): [<ffffffff8282d75b>] irqent=
ry_exit+0x3b/0x90
[  230.458301] hardirqs last disabled at (186): [<ffffffff8282a3ef>] exc_nm=
i+0x7f/0x110
[  230.458302] softirqs last  enabled at (0): [<ffffffff8131ae53>] copy_pro=
cess+0xa03/0x20a0
[  230.458305] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  230.458306]=20
[  230.458306] other info that might help us debug this:
[  230.458307]  Possible unsafe locking scenario:
[  230.458307]=20
[  230.458307]        CPU0
[  230.458308]        ----
[  230.458308]   lock(&loc_l->lock);
[  230.458309]   <Interrupt>
[  230.458309]     lock(&loc_l->lock);
[  230.458310]=20
[  230.458310]  *** DEADLOCK ***
[  230.458310]=20
[  230.458310] no locks held by new_name/10710.
[  230.458311]=20
[  230.458311] stack backtrace:
[  230.458312] CPU: 3 UID: 0 PID: 10710 Comm: new_name Tainted: G        W =
 OE    N  6.18.0-rc5-g0d1fd0291e7a #82 PREEMPT(full)=20
[  230.458315] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE=
, [N]=3DTEST
[  230.458315] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Arch Linux 1.17.0-2-2 04/01/2014
[  230.458316] Call Trace:
[  230.458317]  <NMI>
[  230.458318]  dump_stack_lvl+0x5d/0x80
[  230.458322]  print_usage_bug.part.0+0x22b/0x2d0
[  230.458324]  lock_acquire+0x269/0x2e0
[  230.458326]  ? bpf_lru_pop_free+0xea/0x620
[  230.458329]  _raw_spin_lock_irqsave+0x39/0x60
[  230.458330]  ? bpf_lru_pop_free+0xea/0x620
[  230.458332]  bpf_lru_pop_free+0xea/0x620
[  230.458336]  htab_lru_map_update_elem+0x7e/0x430
[  230.458338]  ? srso_alias_return_thunk+0x5/0xfbef5
[  230.458340]  ? srso_alias_return_thunk+0x5/0xfbef5
[  230.458341]  ? __htab_map_lookup_elem+0x39/0xf0
[  230.458344]  bpf_prog_11d2424ce61f7f6c_oncpu_lru_map+0xe4/0x168
[  230.458346]  __perf_event_overflow+0x387/0x590
[  230.458351]  amd_pmu_v2_handle_irq+0x383/0x400
[  230.458363]  ? srso_alias_return_thunk+0x5/0xfbef5
[  230.458364]  ? look_up_lock_class+0x64/0x150
[  230.458365]  ? srso_alias_return_thunk+0x5/0xfbef5
[  230.458366]  ? lock_acquire+0x1e0/0x2e0
[  230.458368]  ? nmi_handle.part.0+0x30/0x230
[  230.458372]  perf_event_nmi_handler+0x34/0x60
[  230.458374]  nmi_handle.part.0+0xc9/0x230
[  230.458378]  default_do_nmi+0x10e/0x170
[  230.458379]  exc_nmi+0xe3/0x110
[  230.458381]  end_repeat_nmi+0xf/0x53
[  230.458383] RIP: 0010:debug_check_no_locks_freed+0x1a/0x130
[  230.458384] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f =
1e fa 8b 15 0a 69 22 03 85 d2 0f 84 86 00 00 00 41 56 41 54 55 53 9c 5d <fa=
> 65 48 8b 05 55 8d d4 03 48 63 80 40 0b 00 00 85 c0 7e 43 65 48
[  230.458385] RSP: 0018:ffffc9000277be08 EFLAGS: 00000202
[  230.458386] RAX: 0000000000000007 RBX: ffff88811d749c00 RCX: 00000000000=
00009
[  230.458387] RDX: 0000000000000001 RSI: 0000000000000400 RDI: ffff88811d7=
49c00
[  230.458388] RBP: 0000000000000202 R08: ffff88812659b500 R09: 00000000000=
38e72
[  230.458388] R10: 0000000000000000 R11: 00000000000025d6 R12: ffff8881000=
45200
[  230.458389] R13: ffffea000475d200 R14: ffffffff8170e3d6 R15: 00000000000=
00000
[  230.458390]  ? free_pipe_info+0xa6/0xb0
[  230.458397]  ? debug_check_no_locks_freed+0x1a/0x130
[  230.458399]  ? debug_check_no_locks_freed+0x1a/0x130
[  230.458401]  </NMI>
[  230.458401]  <TASK>
[  230.458402]  ? free_pipe_info+0xa6/0xb0
[  230.458404]  kfree+0xdc/0x4f0
[  230.458406]  ? srso_alias_return_thunk+0x5/0xfbef5
[  230.458408]  ? __free_frozen_pages+0x1e3/0x600
[  230.458411]  ? free_pipe_info+0xa6/0xb0
[  230.458412]  free_pipe_info+0xa6/0xb0
[  230.458414]  pipe_release+0x10a/0x120
[  230.458416]  __fput+0x103/0x2c0
[  230.458419]  __x64_sys_close+0x3d/0x80
[  230.458422]  do_syscall_64+0xbb/0x380
[  230.458424]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  230.458425] RIP: 0033:0x7f2a8be9f042
[  230.458426] Code: 08 0f 85 d1 40 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[  230.458427] RSP: 002b:00007ffdf8ab3118 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000003
[  230.458428] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2a8be=
9f042
[  230.458428] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00087
[  230.458429] RBP: 00007ffdf8ab3140 R08: 0000000000000000 R09: 00000000000=
00000
[  230.458429] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdf8a=
b3548
[  230.458430] R13: 0000000000000001 R14: 00007f2a95a18000 R15: 000055c8da5=
fdd70

>=20





