Return-Path: <bpf+bounces-46033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C359E2F12
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707F6B38FEA
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199EE1D7E21;
	Tue,  3 Dec 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSMzIhUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3D205AA9
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262126; cv=none; b=LG0i2E2+MwstqNzMb7jwEgYdwCPJsfdCWKu92cbpfpujw1/MarfVih69OkTPyGTB1xco2Qsqj+iOdFm/SkjIQMmCdHihzp5tSF3SO+BDh5PSjvx03kF8L73dkn0xtT5gVQM923ITbuzA6eW44b4CHgQ8AXf+p2ySo7MW807ORic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262126; c=relaxed/simple;
	bh=gsT30NItzifdGGySFwl8Ys8rY8QgCyi0/TSLbhFOr5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=magJUXjtB6xo8Ppeuwg0EIk2flsfj3Rv9LSHDyXXFZJrCXtGYG2FRdaWCvrIrbtIptB995YOeE1esoFatsC/e6wtJxnCCmoPkQMa5nr+WvRLTgEQXCXqjsiVQHpZQzg0qldM3KQUwQ+tI7hywU87PjJoO+hMkr7i+9u5FX4EXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSMzIhUP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so6062423b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262124; x=1733866924; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lu3H88vK9Ukga8wA+c63KxKRsJQoTtPbQLZsdSsMabg=;
        b=nSMzIhUPhNOlEu6K9lNBSjv9K/x/eiK/8D7wH0WqypFWkXs4ZdgtTfD+Z5YfBBF+ag
         A0xlnhOVtPX1VFyoMJZwaBmhecqyQ0nvCbVf4ymSAiQVrPb+m3iBr/LM84wKnvKV27ZC
         9mwbK7T58nCNVdYwJeDOO66jw0daeZIec463ky55q3Ac5hM6MiBkWN5ZiEJMEB69zkTo
         TobACFqGDIKpWKW0HeDwAMOAEMhjMIpic2xdtY9dVvj7SUKurPVeOW8mOvck5C9eO7KB
         rexDQi1Mej3uYGwZ87F6/zjaUKPqwHSfHdZuqPeYQsv9jiosmOWPoLA3uNd+OFWo76iq
         V7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262124; x=1733866924;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lu3H88vK9Ukga8wA+c63KxKRsJQoTtPbQLZsdSsMabg=;
        b=jHaEdzpTLTaJZM6VBGFu8hm5OW0d5bXxBAQ375gZfFPdpsMygxN7pkghgnjwlv4O/l
         6zle5by8ERlWb1WfctciEO+eZKEIAFU6Ar4sKoLdZYLEaWs1XjkCXrvcyhlwPEedrYke
         TMCpuz7CZ5QsINNJVZngvKM3rQPFY9djyACFUAUk0oCddW80uD3vh6leW2NX5BJsdiO1
         yGEB36kMT+Q07OCl1UnKb1D8hfBwEqbJ5g6gwRyUeuOsaeJFt1H8bkgORbHF8PQgjsSQ
         gSv5bHdN8NZ27O36YiMwUp/9beA9XnvIMgKNcZgDgwKpqHEyQ+Cn4SQrxO0uaJnNafw1
         Gq4w==
X-Forwarded-Encrypted: i=1; AJvYcCWfkuZAFZJ0AuVIf4cRegyW3ornD1hagn+tMAoSR888h1wFry0JqyheDhejJ9LtvOFpXqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwioQfV4FSA7n7yx8PtBOpadseBjBiZGKkfa5ttLkkK3VVfmkVs
	52gD+KPrFcGoH6ZRf9aXJnYSr/C5Ps7C2kU8D3OGxvxt7BJc735S
X-Gm-Gg: ASbGncs6sU/6Yls1AJ+bCLf2fytGhLlZcfCyK3kGwfR8U248ITJiFGZYdsiva0LSc22
	/bfAC3pnInWT/gudHmk754imRkYExkxQRKr0Hw4hXVMNIagTawklsHD9hvDogNJkvgRwDVMGr57
	fzCurdGzQyCpnDDSwvaYUGbBsM/4ujE88BsRvqtbNRNl23hC5O6Tkour6bSEsl4qjznCLh5B25d
	UeLRudFaFnatr4Wr9QAwJ6mB1O+xv2njhMbufF+E3Rfka0=
X-Google-Smtp-Source: AGHT+IG2iULcSsy/dw5rQuixh3gveFJ9D1I+SnIGp9oLAFH/TVcGzeTsKQlUyDuEJ9DJ3ZbJQqwlDw==
X-Received: by 2002:a05:6a00:3a05:b0:725:24c2:b794 with SMTP id d2e1a72fcca58-7257fcc4097mr6166187b3a.23.1733262124337;
        Tue, 03 Dec 2024 13:42:04 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254182bd10sm10947264b3a.154.2024.12.03.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:42:03 -0800 (PST)
Message-ID: <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org
Date: Tue, 03 Dec 2024 13:41:58 -0800
In-Reply-To: <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 12:19 -0800, Eduard Zingerman wrote:
> On Tue, 2024-12-03 at 17:26 +0100, Nick Zavaritsky wrote:
> > Hi,
> >=20
> > Calls to helpers such as bpf_skb_pull_data, are supposed to invalidate
> > all prior checks on packet pointers.
> >=20
> > I noticed that if I wrap a call to bpf_skb_pull_data in a function with
> > global linkage, pointers checked prior to the call are still considered
> > valid after the call. The program is accepted on 6.8 and 6.13-rc1.
> >=20
> > I'm curious if it is by design and if not, if it is a known issue.
> > Please find the program below.
> >=20
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> >=20
> > __attribute__((__noinline__))
> > long skb_pull_data(struct __sk_buff *sk, __u32 len)
> > {
> >     return bpf_skb_pull_data(sk, len);
> > }
> >=20
> > SEC("tc")
> > int test_invalidate_checks(struct __sk_buff *sk)
> > {
> >     int *p =3D (void *)(long)sk->data;
> >     if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
> >     skb_pull_data(sk, 0);
> >     *p =3D 42;
> >     return TCX_PASS;
> > }
> >=20
> > If I remove noinline or add static, the program is rejected as expected=
.
> >=20
>=20
> Hi Nick,
>=20
> Thank you for the report. This is a bug. Technically, packet pointers
> are invalidated by clear_all_pkt_pointers() called from check_helper_call=
f().
> This functions looks through all packets in current verifier state.
> However, global functions are verified independent of call sites,
> so pointer 'p' does not exist in verifier state when 'skb_pull_data'
> is verified, and thus is not invalidated.
>=20

There are several ways to fix this:
- The "dumb" way:
  - forbid calling helpers that bpf_helper_changes_pkt_data()
    from global functions.
- The "simple" way:
  - at some early stage:
    - scan all global functions, to see if there are any calls to
      helpers that bpf_helper_changes_pkt_data(). If there are,
      remember this as an "effect" of the function;
    - build a call-graph of global functions and propagate computed
      effects over this call-graph (if A calls B and B does
      clear_all_pkt_pointers(), then A also does it).
  - during main verification phase, if a call to a global function is
    verified, check it's effects and update state accordingly
    (e.g. call clear_all_pkt_pointers()).
- The "correct" way:
  - build a call-graph of global functions;
  - verify these functions in a post-order;
  - while verifying, collect "effects" information
    (so far, the single effect is whether or not
     clear_all_pkt_pointers() had been ever called for the function);
  - if a call to global function is verified, check it's effects and
    update state accordingly (e.g. call clear_all_pkt_pointers()).

"dumb" is probably a no-go as it is too restrictive.
The only advantage of "simple" over "correct" that I see is
that the logic for clear_all_pkt_pointers() remains confined
to check_helper_call() and is not duplicated in a separate pass.
In theory, this also allows to compute more complex function effects
on the main verification pass.

I think "simple" is a way to go at the moment.

Alexei, Andrii, what do you think?


