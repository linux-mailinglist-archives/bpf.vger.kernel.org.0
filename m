Return-Path: <bpf+bounces-19737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D25830B4E
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEA31F2BDD8
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA100224FE;
	Wed, 17 Jan 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIFeBT5n"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E221364
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509456; cv=none; b=RUclvuxHAWTNbVfeFQaOkGBBPHoDa5sPqSp4mSIIMhN8+zyHrA/TGL3NN7OBFCDyGilr1/k7DDlMeRBq3DM/bZT24YYd6ER2aAB60lXuAyobyV/W8DVruc8QMI9GxeGVBqm4fn3fHiBbSN0X8wHO/0v3nnkLwlequcnygzHpKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509456; c=relaxed/simple;
	bh=quxqBlELDmx/23WoH7bvn2sOo+t/7W8a40DpmJUSCWU=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:X-Clacks-Overhead:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=l3O46+GTVRXt1z4GhByfoL6RGKV/4hhI/GnnxgZcY1tD+jwJNX4+smcWAXI7J3e3lFiMwaBLZMhcWEUIMfsZfKAzVR3aEby/4MTEMxL7oQHgp62KCHEzPk5VmXHW4i8C+zZsYNl9o21dmhVqwQcZX5w0+B+Exon+RFo8vhgm//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIFeBT5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=se4elMsGJU9EC+SNklZxwLpVdn5NqIm93z2voyeARIM=;
	b=MIFeBT5npyxCyXklulyqUmAopxWJ7MudZyHFKjKkyJwK3Sh2prDN7x2MAJkUAFq0uT7U+W
	781LDs3g3XQ7p+xFESyHuDu3zk85o2xeEVEE6SSegf6UKg032IYfTmUeNY27ctfQVEvgF6
	YzxlBgAED3aZch9svmbFWyzQ1HM4XgA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-bDHf-Hd_M12ItEubhXRzOw-1; Wed, 17 Jan 2024 11:37:31 -0500
X-MC-Unique: bDHf-Hd_M12ItEubhXRzOw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-557326932e5so5796366a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 08:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705509450; x=1706114250;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=se4elMsGJU9EC+SNklZxwLpVdn5NqIm93z2voyeARIM=;
        b=sO8UQAJaBW/3GEbB9rQ43YhcNUH6xizjdwXANohHynd3U1nS5dbWXv33D63endezFC
         a1i2iO6Ah8iVTq2caU5w8MwELnQlF4dfdoXcdmmUoH/5fCQF4ajE2yr4SPt6i+sOdqXl
         xfQahaZKQWVyLL2UJHomxo3cEMkZOyjimA2uflFArFv76Q/ZMSjBytfFfi4pzdbDQyE5
         ZbZ6D+jk2YvIXuONbgnwNgaMF51iVfMs++K+x3aehdrOjUISqrDQCA7yP/pRf43i+/wK
         /Mx1CXCssrmWwOV9Y6wxP4z+1H+Ty1HRZIWKT7Q/6sfKQnamxXbl9hRYqkFKo6v01xf6
         9Eeg==
X-Gm-Message-State: AOJu0YxM4l2PAdHaCyKZh/C/xjOAgPtpb+pXalwsyv43RGUBat4Uup6D
	j20shqyIBSaqr9BjqgFoneNzOJ0Ij+uweY+91NRhJGdV9LZ87e8bEo5MF3rgvplhbeT9pgiEdPG
	cPqeKwsoByDPKLuteBc/J
X-Received: by 2002:a05:6402:1247:b0:559:edce:d10c with SMTP id l7-20020a056402124700b00559edced10cmr288412edw.18.1705509450569;
        Wed, 17 Jan 2024 08:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOfrMcGpH3jIhyrQhRuVToqnLSPcbgcfmgpIm4KZwzvqpYdTEe2SVKL/BvprDvAeyDQw9uOQ==
X-Received: by 2002:a05:6402:1247:b0:559:edce:d10c with SMTP id l7-20020a056402124700b00559edced10cmr288393edw.18.1705509450147;
        Wed, 17 Jan 2024 08:37:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7cd89000000b00558e0481b2fsm6868305edv.47.2024.01.17.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:37:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4701F1088A04; Wed, 17 Jan 2024 17:37:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Boqun
 Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao
 Luo <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak
 Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
In-Reply-To: <20240112174138.tMmUs11o@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk> <20240112174138.tMmUs11o@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jan 2024 17:37:29 +0100
Message-ID: <87ttnb6hme.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-01-04 20:29:02 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>=20
>> >> @@ -3925,6 +3926,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qe=
vent *qe, struct Qdisc *sch, stru
>> >>
>> >>         fl =3D rcu_dereference_bh(qe->filter_chain);
>> >>
>> >> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>> >>         switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
>> >>         case TC_ACT_SHOT:
>> >>                 qdisc_qstats_drop(sch);
>> >
>> > Here and in all other places this patch adds locks that
>> > will kill performance of XDP, tcx and everything else in networking.
>> >
>> > I'm surprised Jesper and other folks are not jumping in with nacks.
>> > We measure performance in nanoseconds here.
>> > Extra lock is no go.
>> > Please find a different way without ruining performance.
>>=20
>> I'll add that while all this compiles out as no-ops on !PREEMPT_RT, I do
>> believe there are people who are using XDP on PREEMPT_RT kernels and
>> still expect decent performance. And to achieve that it is absolutely
>> imperative that we can amortise expensive operations (such as locking)
>> over multiple packets.
>>=20
>> I realise there's a fundamental trade-off between the amount of
>> amortisation and the latency hit that we take from holding locks for
>> longer, but tuning the batch size (while still keeping some amount of
>> batching) may be a way forward? I suppose Jakub's suggestion in the
>> other part of the thread, of putting the locks around napi->poll(), is a
>> step towards something like this.
>
> The RT requirements are usually different. Networking as in CAN might be
> important but Ethernet could only used for remote communication and so
> "not" important. People complained that they need to wait for Ethernet
> to be done until the CAN packet can be injected into the stack.
> With that expectation you would like to pause Ethernet immediately and
> switch over the CAN interrupt thread.
>
> But if someone managed to setup XDP then it is likely to be important.
> With RT traffic it is usually not the throughput that matters but the
> latency. You are likely in the position to receive a packet, say every
> 1ms, and need to respond immediately. XDP would be used to inspect the
> packet and either hand it over to the stack or process it.

I am not contesting that latency is important, but it's a pretty
fundamental trade-off and we don't want to kill throughput entirely
either. Especially since this is global to the whole kernel; and there
are definitely people who want to use XDP on an RT kernel and still
achieve high PPS rates.

(Whether those people really strictly speaking need to be running an RT
kernel is maybe debatable, but it does happen).

> I expected the lock operation (under RT) to always succeeds and not
> cause any delay because it should not be contended.

A lock does cause delay even when it's not contended. Bear in mind that
at 10 Gbps line rate, we have a budget of 64 nanoseconds to process each
packet (for 64-byte packets). So just the atomic op to figure out
whether there's any contention (around 10ns on the Intel processors I
usually test on) will blow a huge chunk of the total processing budget.
We can't actually do the full processing needed in those 64 nanoseconds
(not to mention the 6.4 nanoseconds we have available at 100Gbps), which
is why it's essential to amortise as much as we can over multiple
packets.

This is all back-of-the-envelope calculations, of course. Having some
actual numbers to look at would be great; I don't suppose you have a
setup where you can run xdp-bench and see how your patches affect the
throughput?

> It should only block if something with higher priority preempted the
> current interrupt thread _and_ also happen to use XDP on the same CPU.
> In that case (XDP is needed) it would flush the current user out of
> the locked section before the higher-prio thread could take over.
> Doing bulk and allowing the low-priority thread to complete would
> delay the high-priority thread. Maybe I am too pessimistic here and
> having two XDP programs on one CPU is unlikely to happen.
>
> Adding the lock on per-NAPI basis would allow to batch packets.
> Acquiring the lock only if XDP is supported would not block the CAN
> drivers since they dont't support XDP. But sounds like a hack.

I chatted with Jesper about this, and he had an idea not too far from
this: split up the XDP and regular stack processing in two stages, each
with their individual batching. So whereas right now we're doing
something like:

run_napi()
  bh_disable()
  for pkt in budget:
    act =3D run_xdp(pkt)
    if (act =3D=3D XDP_PASS)
      run_netstack(pkt)  // this is the expensive bit
  bh_enable()

We could instead do:

run_napi()
  bh_disable()
  for pkt in budget:
    act =3D run_xdp(pkt)
    if (act =3D=3D XDP_PASS)
      add_to_list(pkt, to_stack_list)
  bh_enable()
  // sched point
  bh_disable()
  for pkt in to_stack_list:
    run_netstack(pkt)
  bh_enable()


This would limit the batching that blocks everything to only the XDP
processing itself, which should limit the maximum time spent in the
blocking state significantly compared to what we have today. The caveat
being that rearranging things like this is potentially a pretty major
refactoring task that needs to touch all the drivers (even if some of
the logic can be moved into the core code in the process). So not really
sure if this approach is feasible, TBH.

> Daniel said netkit doesn't need this locking because it is not
> supporting this redirect and it made me think. Would it work to make
> the redirect structures part of the bpf_prog-structure instead of
> per-CPU? My understanding is that eBPF's programs data structures are
> part of it and contain locking allowing one eBPF program preempt
> another one.
> Having the redirect structures part of the program would obsolete
> locking. Do I miss anything?

This won't work, unfortunately: the same XDP program can be attached to
multiple interfaces simultaneously, and for hardware with multiple
receive queues (which is most of the hardware that supports XDP), it can
even run simultaneously on multiple CPUs on the same interface. This is
the reason why this is all being kept in per-CPU variables today.

-Toke


