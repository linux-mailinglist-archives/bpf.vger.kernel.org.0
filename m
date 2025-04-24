Return-Path: <bpf+bounces-56567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBBA99D88
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90D0194696F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE42AD51;
	Thu, 24 Apr 2025 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TtZMI5K2"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F74D8CE
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456370; cv=none; b=aRptvRx+ivnFntebH0AmcfQtTnqjQdajelvcXnNsYts3+8mJYel/J5RqXdJ201b//PThuSQh4VqNjwtD3RowSvH7V518vTuq2gT2fpfSBkxqLWYYCeMcDqjWEVQf+oQr1gI6r+mIu2lj2buLTx2CS45FzxMXZw2BOPhW0HlRIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456370; c=relaxed/simple;
	bh=YMVdNrVH10stju8zdM/8bIhx3P1z7QsHwxKn5YMEjso=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kolIKdNYu0lgmvajSpj/GUiG80K2KqaFTDLPY0kAXMdrU8PdTN2a+QUKZPaiH1YaL5zF8eFrLCNG4t59Z4iiNSodBb+RJo0MSjtT+n/QUeoC1OLtpRcKdpIO4vxxmZq2HwFCm8aDPeejfjrV3kFB+PXaFyt+c4JNZG/qp+y1EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TtZMI5K2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745456363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMVdNrVH10stju8zdM/8bIhx3P1z7QsHwxKn5YMEjso=;
	b=TtZMI5K2sg9PNR0v6loiBJw20kDumBj8C2m9cDClr8GLRPc1FB0zABIg9lLnos/+BIWZXR
	vpXnWIqh70AnZ4m/bqE8+dDZw3O3uCu45c9Ut6q2zR17e2q2/3DjKT28dJhcKApkqYNgxV
	f85IuPkYwvCrR8TjOyrMCrWTZtBu5fc=
Date: Thu, 24 Apr 2025 00:59:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <90f887391cff690e883e40cbb67a9614e7757295@linux.dev>
TLS-Required: No
Subject: Re:
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <aAmIi0vlycHtbXeb@pop-os.localdomain>
References: <aAmIi0vlycHtbXeb@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

April 24, 2025 at 08:40, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:



>=20
>=20netdev@vger.kernel.org, bpf@vger.kernel.org
>=20
>=20Bcc:=20
>=20
> Subject: test_sockmap failures on the latest bpf-next
>=20
>=20Reply-To:=20
>=20
> Hi all,
>=20
>=20The latest bpf-next failed on test_sockmap tests, I got the following
>=20
>=20failures (including 1 kernel warning). It is 100% reproducible here.
>=20
>=20I don't have time to look into them, a quick glance at the changelog
>=20
>=20shows quite some changes from Jiayuan. So please take a look, Jiayuan=
.
>=20
>=20Meanwhile, please let me know if you need more information from me.
>=20
>=20Thanks!
>=20
>=20--------------->

Thanks, I'm working on it.

>=20
>=20[root@localhost bpf]# ./test_sockmap=20
>=20
> # 1/ 6 sockmap::txmsg test passthrough:OK
>=20
>=20# 2/ 6 sockmap::txmsg test redirect:OK
>=20
>=20# 3/ 2 sockmap::txmsg test redirect wait send mem:OK
>=20
>=20# 4/ 6 sockmap::txmsg test drop:OK
>=20
>=20[ 182.498017] perf: interrupt took too long (3406 > 3238), lowering k=
ernel.perf_event_max_sample_rate to 58500
>=20
>=20# 5/ 6 sockmap::txmsg test ingress redirect:OK
>=20
>=20# 6/ 7 sockmap::txmsg test skb:OK
>=20
>=20# 7/12 sockmap::txmsg test apply:OK
>=20
>=20# 8/12 sockmap::txmsg test cork:OK
>=20
>=20# 9/ 3 sockmap::txmsg test hanging corks:OK
>=20
>=20#10/11 sockmap::txmsg test push_data:OK
>=20
>=20#11/17 sockmap::txmsg test pull-data:OK
>=20
>=20#12/ 9 sockmap::txmsg test pop-data:OK
>=20
>=20#13/ 6 sockmap::txmsg test push/pop data:OK
>=20
>=20#14/ 1 sockmap::txmsg test ingress parser:OK
>=20
>=20#15/ 1 sockmap::txmsg test ingress parser2:OK
>=20
>=20#16/ 6 sockhash::txmsg test passthrough:OK
>=20
>=20#17/ 6 sockhash::txmsg test redirect:OK
>=20
>=20#18/ 2 sockhash::txmsg test redirect wait send mem:OK
>=20
>=20#19/ 6 sockhash::txmsg test drop:OK
>=20
>=20#20/ 6 sockhash::txmsg test ingress redirect:OK
>=20
>=20#21/ 7 sockhash::txmsg test skb:OK
>=20
>=20#22/12 sockhash::txmsg test apply:OK
>=20
>=20#23/12 sockhash::txmsg test cork:OK
>=20
>=20#24/ 3 sockhash::txmsg test hanging corks:OK
>=20
>=20#25/11 sockhash::txmsg test push_data:OK
>=20
>=20#26/17 sockhash::txmsg test pull-data:OK
>=20
>=20#27/ 9 sockhash::txmsg test pop-data:OK
>=20
>=20#28/ 6 sockhash::txmsg test push/pop data:OK
>=20
>=20#29/ 1 sockhash::txmsg test ingress parser:OK
>=20
>=20#30/ 1 sockhash::txmsg test ingress parser2:OK
>=20
>=20#31/ 6 sockhash:ktls:txmsg test passthrough:OK
>=20
>=20#32/ 6 sockhash:ktls:txmsg test redirect:OK
>=20
>=20#33/ 2 sockhash:ktls:txmsg test redirect wait send mem:OK
>=20
>=20[ 263.509707] ------------[ cut here ]------------
>=20
>=20[ 263.510439] WARNING: CPU: 1 PID: 40 at net/ipv4/af_inet.c:156 inet_=
sock_destruct+0x173/0x1d5
>=20
>=20[ 263.511450] CPU: 1 UID: 0 PID: 40 Comm: kworker/1:1 Tainted: G W 6.=
15.0-rc3+ #238 PREEMPT(voluntary)=20
>=20
> [ 263.512683] Tainted: [W]=3DWARN
>=20
>=20[ 263.513062] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.15.0-1 04/01/2014
>=20
>=20[ 263.514763] Workqueue: events sk_psock_destroy
>=20
>=20[ 263.515332] RIP: 0010:inet_sock_destruct+0x173/0x1d5
>=20
>=20[ 263.515916] Code: e8 dc dc 3f ff 41 83 bc 24 c0 02 00 00 00 74 02 0=
f 0b 49 8d bc 24 ac 02 00 00 e8 c2 dc 3f ff 41 83 bc 24 ac 02 00 00 00 74=
 02 <0f> 0b e8 c7 95 3d 00 49 8d bc 24 b0 05 00 00 e8 c0 dd 3f ff 49 8b
>=20
>=20[ 263.518899] RSP: 0018:ffff8880085cfc18 EFLAGS: 00010202
>=20
>=20[ 263.519596] RAX: 1ffff11003dbfc00 RBX: ffff88801edfe3e8 RCX: ffffff=
ff822f5af4
>=20
>=20[ 263.520502] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88=
801edfe16c
>=20
>=20[ 263.522128] RBP: ffff88801edfe184 R08: ffffed1003dbfc31 R09: 000000=
0000000000
>=20
>=20[ 263.523008] R10: ffffffff822f5ab7 R11: ffff88801edfe187 R12: ffff88=
801edfdec0
>=20
>=20[ 263.523822] R13: ffff888020376ac0 R14: ffff888020376ac0 R15: ffff88=
8020376a60
>=20
>=20[ 263.524682] FS: 0000000000000000(0000) GS:ffff8880b0e88000(0000) kn=
lGS:0000000000000000
>=20
>=20[ 263.525999] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>=20
>=20[ 263.526765] CR2: 0000556365155830 CR3: 000000001d6aa000 CR4: 000000=
0000350ef0
>=20
>=20[ 263.527700] Call Trace:
>=20
>=20[ 263.528037] <TASK>
>=20
>=20[ 263.528339] __sk_destruct+0x46/0x222
>=20
>=20[ 263.528856] sk_psock_destroy+0x22f/0x242
>=20
>=20[ 263.529471] process_one_work+0x504/0x8a8
>=20
>=20[ 263.530029] ? process_one_work+0x39d/0x8a8
>=20
>=20[ 263.530587] ? __pfx_process_one_work+0x10/0x10
>=20
>=20[ 263.531195] ? worker_thread+0x44/0x2ae
>=20
>=20[ 263.531721] ? __list_add_valid_or_report+0x83/0xea
>=20
>=20[ 263.532395] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.532929] ? __list_add+0x45/0x52
>=20
>=20[ 263.533482] process_scheduled_works+0x73/0x82
>=20
>=20[ 263.534079] worker_thread+0x1ce/0x2ae
>=20
>=20[ 263.534582] ? _raw_spin_unlock_irqrestore+0x2e/0x44
>=20
>=20[ 263.535243] ? __pfx_worker_thread+0x10/0x10
>=20
>=20[ 263.535822] kthread+0x32a/0x33c
>=20
>=20[ 263.536278] ? kthread+0x13c/0x33c
>=20
>=20[ 263.536724] ? __pfx_kthread+0x10/0x10
>=20
>=20[ 263.537225] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.537869] ? find_held_lock+0x2b/0x75
>=20
>=20[ 263.538388] ? __pfx_kthread+0x10/0x10
>=20
>=20[ 263.538866] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.539523] ? local_clock_noinstr+0x32/0x9c
>=20
>=20[ 263.540128] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.540677] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.541228] ? __lock_release+0xd3/0x1ad
>=20
>=20[ 263.541890] ? srso_return_thunk+0x5/0x5f
>=20
>=20[ 263.542442] ? tracer_hardirqs_on+0x17/0x149
>=20
>=20[ 263.543047] ? _raw_spin_unlock_irq+0x24/0x39
>=20
>=20[ 263.543589] ? __pfx_kthread+0x10/0x10
>=20
>=20[ 263.544069] ? __pfx_kthread+0x10/0x10
>=20
>=20[ 263.544543] ret_from_fork+0x21/0x41
>=20
>=20[ 263.545000] ? __pfx_kthread+0x10/0x10
>=20
>=20[ 263.545557] ret_from_fork_asm+0x1a/0x30
>=20
>=20[ 263.546095] </TASK>
>=20
>=20[ 263.546374] irq event stamp: 1094079
>=20
>=20[ 263.546798] hardirqs last enabled at (1094089): [<ffffffff813be0f6>=
] __up_console_sem+0x47/0x4e
>=20
>=20[ 263.547762] hardirqs last disabled at (1094098): [<ffffffff813be0d6=
>] __up_console_sem+0x27/0x4e
>=20
>=20[ 263.548817] softirqs last enabled at (1093692): [<ffffffff812f2906>=
] handle_softirqs+0x48c/0x4de
>=20
>=20[ 263.550127] softirqs last disabled at (1094117): [<ffffffff812f29b3=
>] __irq_exit_rcu+0x4b/0xc3
>=20
>=20[ 263.551104] ---[ end trace 0000000000000000 ]---
>=20
>=20#34/ 6 sockhash:ktls:txmsg test drop:OK
>=20
>=20#35/ 6 sockhash:ktls:txmsg test ingress redirect:OK
>=20
>=20#36/ 7 sockhash:ktls:txmsg test skb:OK
>=20
>=20#37/12 sockhash:ktls:txmsg test apply:OK
>=20
>=20[ 278.915147] perf: interrupt took too long (4331 > 4257), lowering k=
ernel.perf_event_max_sample_rate to 46000
>=20
>=20[ 282.974989] test_sockmap (1077) used greatest stack depth: 25072 by=
tes left
>=20
>=20#38/12 sockhash:ktls:txmsg test cork:OK
>=20
>=20#39/ 3 sockhash:ktls:txmsg test hanging corks:OK
>=20
>=20#40/11 sockhash:ktls:txmsg test push_data:OK
>=20
>=20#41/17 sockhash:ktls:txmsg test pull-data:OK
>=20
>=20recv failed(): Invalid argument
>=20
>=20rx thread exited with err 1.
>=20
>=20recv failed(): Invalid argument
>=20
>=20rx thread exited with err 1.
>=20
>=20recv failed(): Bad message
>=20
>=20rx thread exited with err 1.
>=20
>=20#42/ 9 sockhash:ktls:txmsg test pop-data:FAIL
>=20
>=20recv failed(): Bad message
>=20
>=20rx thread exited with err 1.
>=20
>=20recv failed(): Message too long
>=20
>=20rx thread exited with err 1.
>=20
>=20#43/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
>=20
>=20#44/ 1 sockhash:ktls:txmsg test ingress parser:OK
>=20
>=20#45/ 0 sockhash:ktls:txmsg test ingress parser2:OK
>=20
>=20Pass: 43 Fail: 5
>

