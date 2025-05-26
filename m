Return-Path: <bpf+bounces-58929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E73AC3C98
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 11:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE127A3657
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590E1EF391;
	Mon, 26 May 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="NYXTdUnA"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A13143C61;
	Mon, 26 May 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251413; cv=none; b=J0O7I+rtKuB6tIp1ttcNCddwN0FpCLS+b5sQLrbjnpa0fzl2DaTmz9NoLFKSRX4cxmtUrQGQ3OEtr2JKyHk+QK/9q8X25/x5bHO9aLYOI5WPzVYgQ7gZDJocDIdQKBe7aNQrgAfIccrQ4oPXuESmPGAjX2xYrs4AUfiNfo8QLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251413; c=relaxed/simple;
	bh=KGn5Ggz1EixQSDydeBFhr+Vq220sLa44d2Rr0Lsr5VU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVtIbqb4dbFs7jpS4qYM8nncQw4hR4XKw+CDiwmJoIOaOhKVU+W4c6Cpo3aCTu4U9iXKR7cEKoIknv2KayuyhaGybyF2hwpgH9PlkoP/aCycvYkM+6mjTBlsbLQ/p6vshqL08EIWmJ2M7a3GDgLQ0lPMYCsh+Lv9X9cSLoiNp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=NYXTdUnA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748251378; x=1748856178; i=spasswolf@web.de;
	bh=zdlZXV5O/OrmueDPWMt6J9lJXPOoOFVwYIsVcdx7sfk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NYXTdUnAlS28IAR2DbNkgDErMZNYCVy5pBKgGRSMYC80rNe3b7vRPGoI4zbLKh2O
	 gdxYuQG+36ajBdw42tTcslAvqYRa1crrJm9mvLcMar36rLMbzNNwYraeo5qy8/xWm
	 g4NZvDj17PuifbsDwuf7kPf6qZbV0FJFcv5dBDtRlJzA82LbKwJ8CSgWNChas6tc3
	 aW8FxFxRzDufq1eCguZsq50suPPXEGBgEFToNR8A/gMcnHiEpoRt+94NX6kLxvdah
	 xGZMkyjsCnzZuFpW9We9C3VTQ9lRG4i0DhvQ+gcK8WtbDTnRWPDtIZbjxyE+yRw/9
	 ztq8dFoI716fE29TkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1uf1HD3CyM-00e0O1; Mon, 26
 May 2025 11:22:57 +0200
Message-ID: <33c93f52c2894f1e93bd4c3ba264f84e612fdafc.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tejun Heo
 <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Next Mailing List
	 <linux-next@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-rt-users
	 <linux-rt-users@vger.kernel.org>, linux-rt-devel@lists.linux.dev, Thomas
 Gleixner <tglx@linutronix.de>, spasswolf@web.de
Date: Mon, 26 May 2025 11:22:57 +0200
In-Reply-To: <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>
References: <20250525224744.9640-1-spasswolf@web.de>
	 <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mv1jHzhwIFqfaYVSaFCGVFq0pbRpjRdN2iLKkquVLpOUWDr0LOa
 TmwJHQX2H+dqNHOcRFr0zJDMu4eK6Ca9jXyU0g+iUNS5q3ortsN+KNElLJq79KfVW1XMcNu
 VpwFvGJHFlpljVqWO7luhoh/TU2CAoYZZ8a1oTmtd2aojPBcj21P8Zxdt15QUDCTy6bZzuX
 5sr338Cq1acg1hcon7dow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/wCQoRptEvI=;YJLZHr3DfTXG++pE1xZrdjSWiz3
 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
 CA4Y/VuMHR4Lo=

Am Sonntag, dem 25.05.2025 um 18:32 -0700 schrieb Alexei Starovoitov:
> On Sun, May 25, 2025 at 3:48=E2=80=AFPM Bert Karwatzki <spasswolf@web.de=
> wrote:
> >=20
> > [ T2916]  rtlock_slowlock_locked+0x635/0x1d00
> > [ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [ T2916]  ? lock_acquire+0xca/0x300
> > [ T2916]  rt_spin_lock+0x99/0x190
> > [ T2916]  task_get_cgroup1+0xe8/0x340
> > [ T2916]  bpf_task_get_cgroup1+0xe/0x20
>=20
> Known issue.
> Please trim your emails.

Narrowed it down to single tests:

Running (in tools/testing/selftests/bpf):
./test_progs -a cgrp_local_storage/cgrp1_tp_btf

results in this warning:
[ 4782.072921] [  T17037] BUG: sleeping function called from invalid conte=
xt at kernel/locking/spinlock_rt.c:48
[ 4782.072925] [  T17037] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 17037, name: test_progs
[ 4782.072927] [  T17037] preempt_count: 1, expected: 0
[ 4782.072928] [  T17037] RCU nest depth: 2, expected: 2
[ 4782.072929] [  T17037] INFO: lockdep is turned off.
[ 4782.072930] [  T17037] Preemption disabled at:
[ 4782.072930] [  T17037] [<ffffffff97790acd>] fd_install+0x3d/0x360
[ 4782.072942] [  T17037] CPU: 11 UID: 0 PID: 17037 Comm: test_progs Taint=
ed: G        W  O        6.15.0-rc7-next-20250523-gcc-dirty #4 PREEMPT_{RT=
,(full)}=20
[ 4782.072945] [  T17037] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ 4782.072946] [  T17037] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[ 4782.072948] [  T17037] Call Trace:
[ 4782.072950] [  T17037]  <TASK>
[ 4782.072953] [  T17037]  dump_stack_lvl+0x6d/0xb0
[ 4782.072957] [  T17037]  __might_resched.cold+0xfa/0x135
[ 4782.072961] [  T17037]  rt_spin_lock+0x5f/0x190
[ 4782.072964] [  T17037]  ? task_get_cgroup1+0xe8/0x340
[ 4782.072967] [  T17037]  task_get_cgroup1+0xe8/0x340
[ 4782.072969] [  T17037]  bpf_task_get_cgroup1+0xe/0x20
[ 4782.072973] [  T17037]  bpf_prog_8d22669ef1ee8049_on_enter+0x62/0x1d4
[ 4782.072975] [  T17037]  bpf_trace_run2+0xd3/0x260
[ 4782.072978] [  T17037]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 4782.072982] [  T17037]  __bpf_trace_sys_enter+0x37/0x60
[ 4782.072986] [  T17037]  syscall_trace_enter+0x1c7/0x260
[ 4782.072989] [  T17037]  do_syscall_64+0x395/0xfa0
[ 4782.072991] [  T17037]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 4782.072994] [  T17037]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4782.072996] [  T17037] RIP: 0033:0x7f731eb12779
[ 4782.073014] [  T17037] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24=
 08 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ 4782.073015] [  T17037] RSP: 002b:00007fff6713da78 EFLAGS: 00000202 ORIG=
_RAX: 0000000000000141
[ 4782.073017] [  T17037] RAX: ffffffffffffffda RBX: 00007fff6713e208 RCX:=
 00007f731eb12779
[ 4782.073019] [  T17037] RDX: 0000000000000040 RSI: 00007fff6713daf0 RDI:=
 000000000000001c
[ 4782.073020] [  T17037] RBP: 00007fff6713da90 R08: 0000000000000001 R09:=
 00007fff6713daf0
[ 4782.073021] [  T17037] R10: 00007f731ebebac0 R11: 0000000000000202 R12:=
 0000000000000000
[ 4782.073022] [  T17037] R13: 00007fff6713e228 R14: 00007f731f147000 R15:=
 0000558d31b9b890
[ 4782.073029] [  T17037]  </TASK>

Running
./test_progs -a cgrp_local_storage/cgrp1_recursion
gives a similar warning as above but also additional
[ 5185.074482] [   T1419] BUG: scheduling while atomic: Xorg:cs0/1419/0x00=
000002
[...]
[ 5185.077594] [   T1163] BUG: scheduling while atomic: in:imklog/1163/0x0=
0000002
[...]
[ 5185.077852] [   T1165] BUG: scheduling while atomic: rs:main Q:Reg/1165=
/0x00000002
[...]
[ 5185.078004] [   T5845] BUG: scheduling while atomic: dmesg/5845/0x00000=
002
[...]
messages.

Bert Karwatzki

