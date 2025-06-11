Return-Path: <bpf+bounces-60350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C558AD5CD8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D24C1BC1F74
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2B20FA84;
	Wed, 11 Jun 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="AdfQw0xm"
X-Original-To: bpf@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC6204096
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661707; cv=none; b=HMgr08Uo13YKkMif64iAc9K0llNHfqBrTTcYSoAJYg7/WRG60gjdsIn6r8x060yrWt3Q8fxbUPz1+qciJoBQ65ku++k4EpHrz1pVd8PhUjuFhOWW4CCI13Qe+MLahyUGmx736/9WNBYoPruOQfkp1ROGvLImqb2vhwRzqh1UZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661707; c=relaxed/simple;
	bh=kRrsCeAqTmErlKC0k5gaTGk9ZNHTyvFfX5wo9NjwhSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pf5pSVnjulKRxPZ8GU8PpBrO0GWh76TxI50nPNLMEHcvsHajMqlzCKytS52mBNtQaRhg/TXDpIdoBJYKiRU2hNKWZqm87jm2Mcjqh2iz7K9A0ZQNcJVW/ixDHW+D5OOUuTQbileVHsigvDbo56JB/o8+mW5D4iZPF2fu4ZNXW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=AdfQw0xm; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4A6DE240104
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 19:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749661697;
	bh=kRrsCeAqTmErlKC0k5gaTGk9ZNHTyvFfX5wo9NjwhSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=AdfQw0xmrR3sSgDJdg8qjsLfg84fq37iQ6UNJWVn7knVezHi2CNfLvuE42O4Mlx+2
	 ZuPdZe8Y8RCAIwc0Tq351VB4NDp7ynZZR4SC2TgeR0kV82nGdNKUO1XygJWWH2eH8Y
	 xDKPfiJZaX17PJLlXzmbSnFob5VWDMceKimy83pOLOt2vngWU/bbQv1PezoE2+yyZQ
	 lkzvThxdg8sfnzrPrz9fwrZCZ/UjeHREJDD9squVc7vXjauGTydgbpxHm3VC0dbSrm
	 vcdmLwWpVs1gu1z7St/ztACI2VxfvJyOvCTcTK4/ZUQFVyp21W50tjzvPjyOq1617v
	 WVMXGU92RIit1iIxJG/oOxM/ztFgQi+bgTXZr5bjfzQncKwgX+cJ+O76R3CRn5rY9f
	 oqu+23MXaSepCVkjcAVzWbctCvx/GSSko3XENIEwuisKqQt2+5HvWf9EhrAbMhNa7h
	 lZKGccL1tqCukMlVkAEvMCaTgdOmERyNcy60T5luKCO6zn+rncl
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bHXDF0DwBz6v04;
	Wed, 11 Jun 2025 19:08:12 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Daniel Borkmann <daniel@iogearbox.net>,  John
 Fastabend <john.fastabend@gmail.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Feng Yang <yangfeng@kylinos.cn>,  Tejun Heo
 <tj@kernel.org>,  Network Development <netdev@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>,
  syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2] net: Fix RCU usage in task_cls_state() for
 BPF programs
In-Reply-To: <CAADnVQJu3fYTfdRTWxeB5hraqe3_Esm7cgKfO38nxodknABeHg@mail.gmail.com>
References: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
	<CAADnVQJu3fYTfdRTWxeB5hraqe3_Esm7cgKfO38nxodknABeHg@mail.gmail.com>
Date: Wed, 11 Jun 2025 17:07:49 +0000
Message-ID: <871prqyzoa.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jun 11, 2025 at 2:04=E2=80=AFAM Charalampos Mitrodimas
> <charmitro@posteo.net> wrote:
>>
>> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
>> types") made bpf_get_cgroup_classid_curr helper available to all BPF
>> program types, not just networking programs.
>>
>> This helper calls __task_get_classid() which internally calls
>> task_cls_state() requiring rcu_read_lock_bh_held(). This works in
>> networking/tc context where RCU BH is held, but triggers an RCU
>> warning when called from other contexts like BPF syscall programs that
>> run under rcu_read_lock_trace():
>>
>>   WARNING: suspicious RCU usage
>>   6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>>   -----------------------------
>>   net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usa=
ge!
>>
>> Fix this by also accepting rcu_read_lock_trace_held() as a valid RCU
>> context in the task_cls_state() function. This is safe because BPF
>> programs are non-sleepable and task_cls_state() is only doing an RCU
>> dereference to get the classid.
>>
>> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed0ec
>> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
>> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> ---
>> Changes in v2:
>> - Fix RCU usage in task_cls_state() instead of BPF helper
>> - Add rcu_read_lock_trace_held() check to accept trace RCU as valdi
>>   context
>> - Drop the approach of using task_cls_classid() which has in_interrupt()
>>   check
>> - Link to v1: https://lore.kernel.org/r/20250608-rcu-fix-task_cls_state-=
v1-1-2a2025b4603b@posteo.net
>> ---
>>  net/core/netclassid_cgroup.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
>> index d22f0919821e931fbdedf5a8a7a2998d59d73978..df86f82d747ac40e99597d6f=
2d921e8cc2834e64 100644
>> --- a/net/core/netclassid_cgroup.c
>> +++ b/net/core/netclassid_cgroup.c
>> @@ -21,7 +21,8 @@ static inline struct cgroup_cls_state *css_cls_state(s=
truct cgroup_subsys_state
>>  struct cgroup_cls_state *task_cls_state(struct task_struct *p)
>>  {
>>         return css_cls_state(task_css_check(p, net_cls_cgrp_id,
>> -                                           rcu_read_lock_bh_held()));
>> +                                           rcu_read_lock_bh_held() ||
>> +                                           rcu_read_lock_trace_held()));
>
> This is incomplete. It only addresses one particular syzbot report.
> It needs to include rcu_read_lock_held() as well.

To which other report you are refering to?

>
> pw-bot: cr

