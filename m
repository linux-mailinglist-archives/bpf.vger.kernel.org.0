Return-Path: <bpf+bounces-46308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E99E7817
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA08E1885C56
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ADC1C3C0E;
	Fri,  6 Dec 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNfJIlWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E2153836
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509805; cv=none; b=JccAGkSEkMqD2uuqkRrJVLXovWk50h9D0XargQNjQr1y6u0oiepWkiRYsoXNn6L9GZapkwXQwIpP7jE2G//ufaYvAmiWlbZpUNFUrbmg7a8ZwomOvvXcoJd7jU2HSEOLO+4CuYU1kzCiIsxstVnBWnD+CWwDrpUkvUBItVhAM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509805; c=relaxed/simple;
	bh=YoebFycs5bgL4hQHloxwJeyBFfFlz8UOs3yic0m20qQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocJfkmagzciPKq8p7XERm6pW5idH9wJTwTbGEzh7+XGPswQi3TedISFS02ph6g87r8q6xbJdnDg7Xj+F6FcW0m3BoAgGBqSWcvEcmnq3couDunfF3fdaGpFKMITqYHHyb0MCwZxz69uxJVVePKxctAbc7Ul5qm3PCz+MgrwLMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNfJIlWs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215348d1977so20172585ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509803; x=1734114603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2yCgehQWhD0zRZgTtrVuBJ0Rxu3DXdMa7byRGQbhyw8=;
        b=QNfJIlWsSU9vsnlXiff4rTt3Xv/Ghlh1X9sARglHqZbDnxXKmbOsc8eYlTDLrx1JDu
         iJibkGC+onGJupAChhEGFs9JC5hhd7/nR4Xf4ULSkBXeVf+ciLX+QKvHmdaMC++SGCsy
         RJ5rDztuNLR6J4s4srFzHfw+1PWLGcEME31AB5si7v1eRPdQqjOijgMUESvS7zuGj4UO
         r9iQe6rBHDZEXbvGjvOKPUMAmwY4GvtMPx4mU0Z+LcrpYeBy2uhr6PIl02600FsrRRTE
         zOXeNsJbR/cXqeqoq6wiFyN95JzTBFruWB8Je/urjei7xyKN4MQTX11+owjhz7SCEctp
         FlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509803; x=1734114603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yCgehQWhD0zRZgTtrVuBJ0Rxu3DXdMa7byRGQbhyw8=;
        b=SkE5D/6twr6ypTiHt11vNihBHN72EnPdulXxRtF4HYyIu9V0PQIJ0n3/hg7UQcUhVp
         sFf+THHM2LUF5mLrW3SBaFIJvFCdMnwaG8fTOVXeqE3QTWUOfN+AD8dSw9zuXzrZ3MXr
         NO2fWHbyfiPB2VQYE/tNiDyBRYVJU3mFQ3ZNoYDCyxTXNQ0srdNdswsv/OK9fclZP0zx
         q5ayKKjEHNDgYsxsu/1xuCdf3bh8sIpzXB3JNnLFUce6n8xGYAJcAJikaTDckzf8JpF8
         N5KzXfw1MMaV3ncxCV3WXm2fdkE5Wj+V9VL2gdFey/RUR7T/hnzPs5BASankdKdsKlHr
         AHiw==
X-Forwarded-Encrypted: i=1; AJvYcCXA+WXkzrNE/HY7k2FuPt426dN/m+g+DWMmQ4qX1HWZxrN/jEysOmsfoq8KEmErAh/yk+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/uUF5bZTMB1ie9wsJ2ugSW6NK/YmHV1R2q/ZBd4/fqlEVQS9
	gY/p7a64kGsozbx2XQ+XVZa+OptcE35DxJKpYptuPj7zsHLYlguV
X-Gm-Gg: ASbGnctkydm38CRw2FdEG3LFKjG2k9aq4FMd1oAY7y1K3utfK6Jo6/j3D6YEp1AsHGg
	XxkU4tvPXM3tdQj8cZNay6dRFBkQPgYOagT2KOvQu5kujdrmO/BBNvCr8UTbfD3nMfAELNwmwmZ
	0v2QEvTeSHRHSqQdF8OXkh7/DNp5+0EulasO5+KLZdF9P7WVrC6I86kX0WgMX2V6JaOYHXBuYRo
	it2MQ0iUz8cKOjknUcJ60mNaH041aL77dQtKK8in986X6c=
X-Google-Smtp-Source: AGHT+IGU9KrNBJxxIEX+rhOHgK72v3fDnuPsZTdGwDpnqWLjuua9cJfk2tvOCIgPMaORPMMulliQ/w==
X-Received: by 2002:a17:902:ec85:b0:216:282d:c697 with SMTP id d9443c01a7336-216282dd8e2mr6778325ad.27.1733509803228;
        Fri, 06 Dec 2024 10:30:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0922fsm30927455ad.205.2024.12.06.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:30:02 -0800 (PST)
Message-ID: <c4b76c76647260a40ca45f10d55038f9609071d6.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov	
 <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky
 <mejedi@gmail.com>,  bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Date: Fri, 06 Dec 2024 10:29:57 -0800
In-Reply-To: <CAEf4BzZCv+6H2bn_nrOFxw-rZcuO+rX+eXxw+qPCJBy7fDrDqA@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
	 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
	 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
	 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
	 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
	 <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
	 <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
	 <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
	 <CAEf4BzZJOxnm7z6QaxRr9PsfD_DTV5nSPP9TjiEMQxNMxzLFRA@mail.gmail.com>
	 <fca94f90badf43ee16e2773faf35e136d551ec28.camel@gmail.com>
	 <CAEf4BzZCv+6H2bn_nrOFxw-rZcuO+rX+eXxw+qPCJBy7fDrDqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 10:10 -0800, Andrii Nakryiko wrote:

[...]

> > > You keep ignoring the eagerness issue. I can't decide whether you
> > > think *it makes no difference* (I disagree, but whatever), or you *se=
e
> > > no difference* (in which case let me know and I can explain with some
> > > simple example).
> >=20
> > In the context of the packet pointer invalidation I see no difference.
> > Tags are as eager as check_cfg() traversal.
>=20
> Goodness, Eduard...
>=20
> static __noinline void maybe_trigger_pkt_invalidation(bool do_trigger)
> {
>     if (do_trigger)
>        bpf_whatever_helper_triggers_pkt_invalidation();
>     /* presumably do something useful here */
> }
>=20
> __weak /*global*/ int global_no_pkt_invalidation(void)
> {
>     maybe_trigger_pkt_invalidation(false); /* DO NOT trigger */
>     return 0;
> }
>=20
> __weak /*global*/  __subprog_triggers_pkt_invalidation_and_I_mean_it
> int global_make_pkt_invalidation_great(void)
> {
>     maybe_trigger_pkt_invalidation(true); /* DO trigger */
>     return 0;
> }
>=20
> What does your check_cfg() say about global_no_pkt_invalidation()? Can
> it trigger pkt invalidation or not?

Ok, I see your point, thank you for the example.

[...]

> > > > it is not possible to remove tag using dead code elimination.
> > >=20
> > > That's not the point of the tag to be dynamically adjustable. It's th=
e
> > > opposite. It's something that the user declares upfront, and this is
> > > being enforced by the verifier (to prevent user errors, for example).
> > > If the user wants to have a "dynamic tag", they can have two global
> > > subprogs, one with and one without the tag, and pick which one should
> > > be called through, e.g., .rodata feature flag variable. I.e., make
> > > this decision outside of global subprog itself.
> > >=20
> > > > So I really don't see any advantages in the context of this particu=
lar issue.
> > >=20
> > > See also my reply to Alexei, and keep in mind freplace scenario, as
> > > one of the things your approach can't support.
> >=20
> > Some freplace related mark will have to be present after program verifi=
cation.
> > It might be in a form of a tag, or in a form of an additional bit in
> > an auxiliary structure. There would be code to check this with both app=
roaches.
> >=20
>=20
> tag vs check_cfg() is not about that aspect, in both cases we need to
> recod whether subprog can trigger pkt invalidation or not.
>=20
> It's about whether we derive this (and then where, in check_cfg() or
> in proper verification pass), or whether the user declares it and we
> enforce that in the verifier.

So both approaches can handle freplace.



