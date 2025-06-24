Return-Path: <bpf+bounces-61330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B031EAE58C9
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8D7B1997
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028627BAEC;
	Tue, 24 Jun 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnuufv7f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAB1FC8;
	Tue, 24 Jun 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726093; cv=none; b=A4a0mN+4yryEl63L9yVIxcV5L3Sn9ObOReUK97GY1RtTuzWATTm4q+/odIjqP+Ay4NszVC6fJOKfkF5bW2YqAt6Jt97aDQBebWyeJ53wXp3d5SMRBpKjWVHkIoRMBNI6JTlawuzmM0Fby0vlkelcQPyC9anPq1wP75GXiS+kAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726093; c=relaxed/simple;
	bh=rTOaygTTYcmTIdRpitcwMypkdeq6SvvCNV1aaqNDkkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8uUH3F3Py8BTJ8Q8ssvlmqIjZ0lrxC6pjRsLxdCaY8kLsi1QSJRmjQC8tfOi58ONhhh3b1essnN7So5HfK6yGqbjKzSTtEhgHFrho8QMhRC23rTl3zyWyg7JyOxHKKAq7dCK5Z/0LLDSb7k4LNUrVsILGSxaeYpAeFiyCiLbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnuufv7f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so4160884a91.1;
        Mon, 23 Jun 2025 17:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750726091; x=1751330891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1MZWPTRDfQCchc00xep2B3mpKruFnE3qnSwqiREt7M=;
        b=Bnuufv7fHGVG7HhBUadOI2Ppq6nfqVbvSkLf6kT3GMqb1y8FhDvE8mawQPqMfgXFn0
         /5qPA8Nt3galZ6uEqOxb2GrxJUNFiYwerweJLBYoLYQBv1n1p0uYcr75rOE61PNWo4qB
         RXB2YC9pIyw6HhSdJ1VyXyV8Ybwfft6BJEbngBZVqoCuOdvCnZ4o7UVJn5r3awNW2Jsh
         M/t8gJvTnJASmKV4fmiIh9Z2Gmn7hflcBJc69/jkmbFndu8St4TzwYqc+xhAIV+fo+QC
         chWK75efF9KvCNc47q+EdwqrnHLsdPU+87S6tIb7eW6jgYUepjR49Sw3ofYlJLvUUZsV
         WVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726091; x=1751330891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1MZWPTRDfQCchc00xep2B3mpKruFnE3qnSwqiREt7M=;
        b=t5wha5s+jAsGuEzvAfOXl0Ra0ol6yRfKshFTlenYDKHq66hRxWJrTzYyycmYI0J+iB
         ECfcnWcZhM+CBOSX4s6LAqpZEmfFZkjRsOypgvqKTEDxBj6xz7xn00lacxZz8mSmDajN
         29mYs0OfIcoJVM0SAR/fiRMDP/u6NjUlt3OEJMye2glULTWplzve9qIlrCmsIhLi21/6
         fNkDqCCOsJqJskcprxHTj1sHI7Lc7idOvpE9diPVjPJ7Am+DmdABMZ9eVmibhrdjvddz
         MxEB3ABk3VytzDqZvSEhABJCDsQojtgzMZFR4BQWKEGumh5D46AKgBsvOkcJ7PoUIkLR
         WHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOWtbt9YVG7ce5xHTJ+8jKsBZQH60ygxSjzemS4JaWApkGJ1XpNZTpdTR4nMEVe0ofUco=@vger.kernel.org, AJvYcCVX/rgvNtqIQatAyXkjzqSdE/nCU0zSPoJ0cC7ArpLEeMgSGq0ExA0MPw/xx7mrDZAuadEainJE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3UC2jjuieOALFvrHSQ+Zhg4JNAZ1+NHuih3ip7HQVznTbaYU
	I1gcoOaAlYuMilLIqgtUJK8WVU0bDaYsKU/CpdJqhArbmeR3DJgP4v4=
X-Gm-Gg: ASbGnctm9tVOAiOy8X/6/BUjQlPp3W4M/L4X5CCO801RoQ/29Du8koLTyHi09u8PrFZ
	6Dv4pJWdAskT5p+E8Oz83zu9hNoBak925tXO1rQwZoj+Ks7Jd06OA5WMJj2vSsnG7vWO/PqRwEv
	381WKGiqWZb1hX1Di1gKYNrOsVBuX65hWwskSOiBgxobYdv0X0CCALicw8g8P41nMUoxckhsOnA
	yUlMvkC31Z3LPHaaDrYGD75tSgEyrGaXwzUp/HOa3R9h/w1YqdMiC6GKvuEUiNEYb0wRYmEA1rs
	veZayOfuUOcZa614T/oFXk1rGTKOC6b9Rwl0Bg/TBNxKW7L23bH0RoWt0TiVsgLZkc9TEex/Wqa
	hN1IhgTmy5RJ/tdGW0S+0ww4=
X-Google-Smtp-Source: AGHT+IFpTSWnfkk3n1/q3G/36QROk1wYdIfk2vmBl7VVUFO2y6+pdPyN3yh6v5HIVpQX8xNt49uB6w==
X-Received: by 2002:a17:90b:4a4d:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-3159d8ff05amr20598914a91.32.1750726091056;
        Mon, 23 Jun 2025 17:48:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3158a335460sm11786350a91.49.2025.06.23.17.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 17:48:10 -0700 (PDT)
Date: Mon, 23 Jun 2025 17:48:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aFn1ybR3kgSfvL_N@mini-arch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
 <aFWQoXrkIWF2LnRn@mini-arch>
 <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>
 <aFliLQiRusx_SzQ4@mini-arch>
 <CAL+tcoBub4JpHrgWekK+OVCb0frXUaFYDGVd2XL3bvjHOTmFjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBub4JpHrgWekK+OVCb0frXUaFYDGVd2XL3bvjHOTmFjQ@mail.gmail.com>

On 06/24, Jason Xing wrote:
> On Mon, Jun 23, 2025 at 10:18 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/21, Jason Xing wrote:
> > > On Sat, Jun 21, 2025 at 12:47 AM Stanislav Fomichev
> > > <stfomichev@gmail.com> wrote:
> > > >
> > > > On 06/21, Jason Xing wrote:
> > > > > On Fri, Jun 20, 2025 at 10:25 PM Stanislav Fomichev
> > > > > <stfomichev@gmail.com> wrote:
> > > > > >
> > > > > > On 06/19, Jakub Kicinski wrote:
> > > > > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> > > > > > > >     rcu_read_lock();
> > > > > > > >  again:
> > > > > > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > > > > > -           if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > > > > > > > +           int max_budget = READ_ONCE(xs->max_tx_budget);
> > > > > > > > +
> > > > > > > > +           if (xs->tx_budget_spent >= max_budget) {
> > > > > > > >                     budget_exhausted = true;
> > > > > > > >                     continue;
> > > > > > > >             }
> > > > > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > > > > >  {
> > > > > > > >     struct xdp_sock *xs = xdp_sk(sk);
> > > > > > > > -   u32 max_batch = TX_BATCH_SIZE;
> > > > > > > > +   u32 max_budget = READ_ONCE(xs->max_tx_budget);
> > > > > > >
> > > > > > > Hm, maybe a question to Stan / Willem & other XSK experts but are these
> > > > > > > two max values / code paths really related? Question 2 -- is generic
> > > > > > > XSK a legit optimization target, legit enough to add uAPI?
> > > > > >
> > > > > > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> > > > > > whether we want to affect zc case given the fact that Jason seemingly
> > > > > > cares about copy mode is a good question.
> > > > >
> > > > > Allow me to ask the similar question that you asked me before: even though I
> > > > > didn't see the necessity to set the max budget for zc mode (just
> > > > > because I didn't spot it happening), would it be better if we separate
> > > > > both of them because it's an uAPI interface. IIUC, if the setsockopt
> > > > > is set, we will not separate it any more in the future?
> > > > >
> > > > > We can keep using the hardcoded value (32) in the zc mode like
> > > > > before and __only__ touch the copy mode? Later if someone or I found
> > > > > the significance of making it tunable, then another parameter of
> > > > > setsockopt can be added? Does it make sense?
> > > >
> > > > Related suggestion: maybe we don't need this limit at all for the copy mode?
> > > > If the user, with a socket option, can arbitrarily change it, what is the
> > > > point of this limit? Keep it on the zc side to make sure one socket doesn't
> > > > starve the rest and drop from the copy mode.. Any reason not to do it?
> > >
> > > Thanks for bringing up the same question that I had in this thread. I
> > > saw the commit[1] mentioned it is used to avoid the burst as DPDK
> > > does, so my thought is that it might be used to prevent such a case
> > > where multiple sockets try to send packets through a shared umem
> > > nearly at the same time?
> > >
> > > Making it tunable is to provide a chance to let users seek for a good
> > > solution that is the best fit for them. It doesn't mean we
> > > allow/expect to see the burst situation.
> >
> > The users can choose to moderate their batches by submitting less
> > with each sendmsg call. I see why having a batch limit might be useful for
> > zerocopy to tx in batches to interleave multiple sockets, but not
> > sure how this limit helps for the copy mode. Since we are not running
> > qdisc layer on tx, we don't really have a good answer for multiple
> > sockets sharing the same device/queue..
> 
> It's worth mentioning that the xsk still holds the tx queue lock in
> the non-zc mode. So I assume getting rid of the limit might be harmful
> for other non xsk flows. That is what I know about the burst concern.

But one still needs NET_RAW to use it, right? So it's not like some
random process will suddenly start ddos-ing tx queues.. Maybe we should
add need_resched() / signal_pending() to the loop to break it?

