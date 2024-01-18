Return-Path: <bpf+bounces-19809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E88318BA
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 12:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D99A1C22C31
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8124210;
	Thu, 18 Jan 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACmCzgVb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B75241EC
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578686; cv=none; b=F18qbCCs6CcFA8bLNCaSHZnct8+MuWp2A4p0mQnLTCNi/sSHNuQEaDP/mABd7VMBEpzqcE57PNPRxJ8ElxSg8/D4UCOKM7aCtKwFba/qS1keKd+HMQS0ewUMpcgOn8r58h6mxeJ2rUW7tf/yY45GxUFrmSOuL2tPv4QH7aLTAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578686; c=relaxed/simple;
	bh=gjKL/IdNxXoEFbPq3V+ULP/88RRcg6e6ZtkZpfaK71w=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:X-Clacks-Overhead:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=HadT/sshYohHxDrlWy2AOCVLuZUujRulYV1sgZgS1F9h2adh4Jd+ufB8xdybfRK8OS6SzVAbJ1PjmQEyQ9rqfJD1HxvAQHTLFPUOCu8e8dxqf1Lg4f9ziEZGk45efgHjO5TJsZ7cXVHKHdFbr+FODmxBEx29osef48zIav+3o/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACmCzgVb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705578683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dES9AcNoy5iDWvH8/jwu9Q9jSrExSLuFvfw2IDCTzWM=;
	b=ACmCzgVbRmdD26be/T8T25ajV0TXPoKr+tObdQ6pn7V3l6WvXvMmP5OrOuDOkwYizMApYq
	fykR0SuD+gBZcxVUgMyFWoe0BdxX/XPb+JK0lBzqrVVBvBTNiU7KwI8gAeRwihnrz8bwhf
	G8LwMo5xohw4XLw6X8Y9iFM0KY5GLjY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Bc6hOmSLNgu8Jm5VL3AK3Q-1; Thu, 18 Jan 2024 06:51:21 -0500
X-MC-Unique: Bc6hOmSLNgu8Jm5VL3AK3Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55a35a29597so162867a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 03:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578680; x=1706183480;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dES9AcNoy5iDWvH8/jwu9Q9jSrExSLuFvfw2IDCTzWM=;
        b=j705/kdSuUOsNi35UmFoNSDsua/uEZWuAfTGIvz5p5qKMGPWvXDXYBJR0jrRxfjApm
         xmEihzRHx68LPBwqel3UPuhDbEOrqLG+Z3x7GNJCr9dPzqRph60ovgLF4Lzouu+LYrj1
         tX+Gyu+hazB0JdmyhLtQ4TDFSh7B3oUoasAHuCBq2MjUH2bYTTWIsbeSh71mHzTpD1wn
         PNZLzZ49W5m0PELz3fTmUJZC5u6KCMP3ALXOsXV8HlQOfwDnQ3P//6RlOrJ2G4+xp56V
         4pOrK5/lzYL51NinVBODo1wnHijvMoezu28Me+O5vXLlxcKtk2P4aUR8FZyIATkXGQKT
         tXQQ==
X-Gm-Message-State: AOJu0YzAcczfDH/vA8UxqKbkN9EMe0Q5755N8H81kpcAvXWXNW4tKvVN
	fnLcsVhi3LXES56iCrsc2cmsGajN4B7NRaV+3NsI49/blBrcC9vWCAjj+7//pUwViG4AKPYPUjF
	5qn/FL1TrZccmktCjutNg6vPkEmjCgY0SzRW9acJxqUqUS3+13w==
X-Received: by 2002:aa7:cf07:0:b0:559:e763:6bfc with SMTP id a7-20020aa7cf07000000b00559e7636bfcmr477448edy.56.1705578680244;
        Thu, 18 Jan 2024 03:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZxNA+3we4N57JAj4aSvmZmv7PX3SA4s4PiqefRRfW+RbV+w2ZNWBG3LhJT8xEATP5sdjuAQ==
X-Received: by 2002:aa7:cf07:0:b0:559:e763:6bfc with SMTP id a7-20020aa7cf07000000b00559e7636bfcmr477425edy.56.1705578679854;
        Thu, 18 Jan 2024 03:51:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b3-20020a0564021f0300b005545dffa0bdsm9338903edb.13.2024.01.18.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:51:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ABB751088BAE; Thu, 18 Jan 2024 12:51:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
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
In-Reply-To: <20240117180447.2512335b@kernel.org>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk> <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk> <20240117180447.2512335b@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jan 2024 12:51:18 +0100
Message-ID: <87bk9i6ert.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 17 Jan 2024 17:37:29 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> I am not contesting that latency is important, but it's a pretty
>> fundamental trade-off and we don't want to kill throughput entirely
>> either. Especially since this is global to the whole kernel; and there
>> are definitely people who want to use XDP on an RT kernel and still
>> achieve high PPS rates.
>>=20
>> (Whether those people really strictly speaking need to be running an RT
>> kernel is maybe debatable, but it does happen).
>>=20
>> > I expected the lock operation (under RT) to always succeeds and not
>> > cause any delay because it should not be contended.=20=20
>>=20
>> A lock does cause delay even when it's not contended. Bear in mind that
>> at 10 Gbps line rate, we have a budget of 64 nanoseconds to process each
>> packet (for 64-byte packets). So just the atomic op to figure out
>> whether there's any contention (around 10ns on the Intel processors I
>> usually test on) will blow a huge chunk of the total processing budget.
>> We can't actually do the full processing needed in those 64 nanoseconds
>> (not to mention the 6.4 nanoseconds we have available at 100Gbps), which
>> is why it's essential to amortise as much as we can over multiple
>> packets.
>>=20
>> This is all back-of-the-envelope calculations, of course. Having some
>> actual numbers to look at would be great; I don't suppose you have a
>> setup where you can run xdp-bench and see how your patches affect the
>> throughput?
>
> A potentially stupid idea which I have been turning in my head is=20
> how we could get away from having the driver handle details of NAPI
> budgeting. It's an source of bugs and endless review comments.
>
> All drivers end up maintaining a counter of "how many packets have
> I processed" and comparing that against the budget. Would it be crazy
> if we put that inside napi_struct? Add a "budget" member inside
> napi_struct as well, and:
>
> struct napi_struct {
> ...
> 	// poll state
> 	unsigned int budget;
> 	unsigned int rx_used;
> ...
> }
>
> static inline bool napi_rx_has_budget(napi)
> {
> 	return napi->budget > napi->rx_used;
> }
>
> poll(napi) // no budget
> {
> 	while (napi_rx_has_budget(napi)) {
> 		napi_gro_receive(napi, skb); /* does napi->rx_used++ */
> 		// maybe add explicit napi_rx_count() if
> 		// driver did something funny with the frame.
> 	}
> }
>
> We can also create napi_tx_has_budget() so that people stop being
> confused whether budget is for Tx or not. And napi_xdp_comp_has_budget()
> so that people stop completing XDP in hard irq context (budget=3D=3D0)...
>
> And we can pass napi into napi_consume_skb(), instead of, presumably
> inexplicably to a newcomer, passing in budget.
> And napi_complete_done() can lose the work_done argument, too.

I do agree that conceptually it makes a lot of sense to encapsulate the
budget like this so drivers don't have to do all this state tracking
themselves. It does appear that drivers are doing different things with
the budget as it is today, though. For instance, the intel drivers seem
to divide the budget over all the enabled RX rings(?); so I'm wondering
if it'll be possible to unify drivers around a more opaque NAPI poll
API?

-Toke


