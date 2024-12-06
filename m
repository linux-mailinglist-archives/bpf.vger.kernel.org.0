Return-Path: <bpf+bounces-46191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A719E6192
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C352842D3
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA025372;
	Fri,  6 Dec 2024 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV6Gel6R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4043A23
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443442; cv=none; b=qNTjTSj9ynMuSBFkqbfyRQlYNNR5lQXNnLhP7Qr2NB5w3oSQWUEPOhKuq+iqLR+bvO2q5lvOxZ5EaLQh7MaLrBXGuXVOayquWNUzxFw2uS9j4Z5dqDrclm7yTsriB0o4VUS7Y3awzhIi51w6IKD4cgtYGJlBuPMWUibJswg2x7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443442; c=relaxed/simple;
	bh=ksjPmCf98TczRngvZRGBuOSUlnBYMU5IpTO0C812ROA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAf3dCmo82d6yd6TFlku4SYCFCKJtSYjT+yUrvRutom0wY8bmwEuydW7qYifmB5BKPuErL5MqdZVoH/qv19K6gDs3lEpgiJHMbNJpVk1cFfRf8KGPMWONXwPG/iRZOXAthyliwCeuTZBQInlhV3a4shlKO06ApApDLBg9VOy+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV6Gel6R; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd17f2312bso1044090a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 16:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443440; x=1734048240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ei9THWET7ZK87i6ImvtzsU4RFgJ9OQy6RbnIKYhE+o=;
        b=QV6Gel6RI6gFiaQVWBdwFwOYi97ZPVokvdOiq6sxsfeFms+Fh+kHLdKuUtv3PsY/hD
         nAIYe343JHSbFycHbl/PNyQDo5iMOTPTaxgko2RyiWdmndgBo/aCULLN+qDWy6UEf+Ay
         L6UI0nbOr3wMjE/u1VE5HWb8GJ+q9dt5rN167CQIvWO/XGaet++9TRdL9HC/sUBw8N9D
         ChfzaBfZq+Tl/2XE7awx43vviJQeW0dGkJto4CpWN5jy5FwaL6QZSMIbxrd1CkOlQP35
         +zuLWutaLE7c26yI0hMGWFQ4r9sMUgSdSbflleUzDl6bvF34SNlmrq8pV9Wm7NXX4Swv
         t6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443440; x=1734048240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ei9THWET7ZK87i6ImvtzsU4RFgJ9OQy6RbnIKYhE+o=;
        b=MQB4s1ZEi6t64PCaVFT2Rf8jsyW6Bqe3EWdDeMclImUeiBjpycfDSXEDaDaQMRGu8K
         Doi6nTS1IKa2mjt+9AJL8Rc0jyK376Emk0+KKUWd2nEWCoED+D37bI52NnBQ5+Mv0QuW
         va45SEl2eq9zjknvG9hEoUnFkq2lSa6Bcz6R4bZA9ZCVKeQB6RcAywWeTAhaSN2W9Zk0
         LJiebx4uk0KSIuUYrWbJpl2P5CeCV43C0Kq6SEJ3ubEwqoVcrnXYhJAWE67u7/PsjZCq
         5rwFU7ek9S4Ac2+oEMyBAV2A6FrlS4dilAedg2eyGzUOtsf6Y3k9N0xsqABYuOZQNVK/
         J28Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBuZhUZGmfOmhs3B5Hv/k9vUyd0ZKYYQtgCz8fPJRJH3vu8Euh28JeMCJ358+Jkxg9e8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvPs0d+kk2Jja008aROTR6iu2P/1WNFR4jLlUqu+KRhna8GL8
	tinkHD0U1s5iI2JgETJ+iBWUom3t/kBqsZZYbEmFzasHIbGADdFo9T8dFKfnZ6GqZIRnkCT/RZA
	cPRHTz8qtn+XXCbuyA8YRUoYblW8=
X-Gm-Gg: ASbGncvTCtOWba8Yedvxj2Syx7/7weliMTJXQTxp7jKY5lFYnmEECUgiQEd0EK3FoX0
	XswC0GzuB0Af/r5EXoneYACn5CEyReLphLCz+be5Cdm3zTv8=
X-Google-Smtp-Source: AGHT+IEW6+J2HOFk6AUDDIh9TwQ3znCBL/gLgJE1Dg3BMW6g7qUB0AJ9UYfsjZks+ZgcrD312jT+hAZkRPsD8tFpGdM=
X-Received: by 2002:a17:90b:3f45:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2ef69f0b093mr1667913a91.13.1733443440137; Thu, 05 Dec 2024
 16:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com> <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
In-Reply-To: <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 16:03:48 -0800
Message-ID: <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-12-03 at 12:19 -0800, Eduard Zingerman wrote:
> > On Tue, 2024-12-03 at 17:26 +0100, Nick Zavaritsky wrote:
> > > Hi,
> > >
> > > Calls to helpers such as bpf_skb_pull_data, are supposed to invalidat=
e
> > > all prior checks on packet pointers.
> > >
> > > I noticed that if I wrap a call to bpf_skb_pull_data in a function wi=
th
> > > global linkage, pointers checked prior to the call are still consider=
ed
> > > valid after the call. The program is accepted on 6.8 and 6.13-rc1.
> > >
> > > I'm curious if it is by design and if not, if it is a known issue.
> > > Please find the program below.
> > >
> > > #include <linux/bpf.h>
> > > #include <bpf/bpf_helpers.h>
> > >
> > > __attribute__((__noinline__))
> > > long skb_pull_data(struct __sk_buff *sk, __u32 len)
> > > {
> > >     return bpf_skb_pull_data(sk, len);
> > > }
> > >
> > > SEC("tc")
> > > int test_invalidate_checks(struct __sk_buff *sk)
> > > {
> > >     int *p =3D (void *)(long)sk->data;
> > >     if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP=
;
> > >     skb_pull_data(sk, 0);
> > >     *p =3D 42;
> > >     return TCX_PASS;
> > > }
> > >
> > > If I remove noinline or add static, the program is rejected as expect=
ed.
> > >
> >
> > Hi Nick,
> >
> > Thank you for the report. This is a bug. Technically, packet pointers
> > are invalidated by clear_all_pkt_pointers() called from check_helper_ca=
llf().
> > This functions looks through all packets in current verifier state.
> > However, global functions are verified independent of call sites,
> > so pointer 'p' does not exist in verifier state when 'skb_pull_data'
> > is verified, and thus is not invalidated.
> >
>
> There are several ways to fix this:
> - The "dumb" way:
>   - forbid calling helpers that bpf_helper_changes_pkt_data()
>     from global functions.
> - The "simple" way:
>   - at some early stage:
>     - scan all global functions, to see if there are any calls to
>       helpers that bpf_helper_changes_pkt_data(). If there are,
>       remember this as an "effect" of the function;
>     - build a call-graph of global functions and propagate computed
>       effects over this call-graph (if A calls B and B does
>       clear_all_pkt_pointers(), then A also does it).
>   - during main verification phase, if a call to a global function is
>     verified, check it's effects and update state accordingly
>     (e.g. call clear_all_pkt_pointers()).
> - The "correct" way:
>   - build a call-graph of global functions;
>   - verify these functions in a post-order;
>   - while verifying, collect "effects" information
>     (so far, the single effect is whether or not
>      clear_all_pkt_pointers() had been ever called for the function);

So this is the only "side effect" we have right now? Are there any
others we have already or can reasonably anticipate? I'm just trying
to decide if we need to generalize this concept.

>   - if a call to global function is verified, check it's effects and
>     update state accordingly (e.g. call clear_all_pkt_pointers()).
>
> "dumb" is probably a no-go as it is too restrictive.
> The only advantage of "simple" over "correct" that I see is
> that the logic for clear_all_pkt_pointers() remains confined
> to check_helper_call() and is not duplicated in a separate pass.

"simple" doesn't take into account dead code elimination, undermining
BPF CO-RE-based feature detection, so I think this is also a no-go

> In theory, this also allows to compute more complex function effects
> on the main verification pass.
>
> I think "simple" is a way to go at the moment.

I think neither of the above are fully valid, tbh. "correct" will do
eager subprog validation, even if due to dead code elimination that
global function might not have been called.

From the outset, I think the "right" way to solve this would be to
start verification from the main program. When we encounter global
subprog verification, we pause verification for the main program,
create a new isolated verifier state, proceed with global subprog
verification, and so on until we check everything. So basically a
stack of subprogs to validate.

This is PITA, of course, just for this (which is also the question
about the generalization of the "side effects" concept). So I don't
know, maybe for now the "dumb" way is the way?

>
> Alexei, Andrii, what do you think?
>

