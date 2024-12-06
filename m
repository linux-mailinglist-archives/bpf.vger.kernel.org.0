Return-Path: <bpf+bounces-46254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C359E6C79
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5601883417
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CB1F8AF1;
	Fri,  6 Dec 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRKTOyjF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A31DFD89
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481862; cv=none; b=Oim61Kc3AUQmBJr/fCzkwhmUH29OGKgi/KH0RD5ayUXS2T906NIPd3x2zGmux8e6/lk/6yEi5Vz45UlwMwDa6BI/4xf9aPM3UgAyISkEg1UMfv2YCHOIjEdZduHbSiYestAQIGsqQeM8hBUDurUPkFR97dmeLNPqzVql50K7wDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481862; c=relaxed/simple;
	bh=nTeXRexHxmWZDUZ2GwfRLJEOIQ5SEyCBipbLQd91jjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaYsYM5zq3suasbUD9YTSHeoMTUjn9IRLHzWp7zznZdEPW2JtIs8wGXIBE3UzlXfAgHiJ0fMfaCaxnvHJIphOHieXyAVKmHlN2B1VSeUjzkp2DsU3Oi4aqQFHXSuJEolHxYRvWlgJLkMIb4Xg3q6GtTmGtM04Xx+cBj5OX43SBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRKTOyjF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7259a26ad10so1518291b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733481859; x=1734086659; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nTeXRexHxmWZDUZ2GwfRLJEOIQ5SEyCBipbLQd91jjg=;
        b=CRKTOyjFj1LE9caV9krX6qdq7eiXiQVTduhQxh+dg2X2pvvtqJJh2zzqR3WVA9+PMn
         qDpWeDxqPSYVgDyQWi1ZIs2Mg0yVriqV03fttXwMSAZrQXO4MkNPFY8Y79igdenZ96g/
         Qt58e/Da8G5nwTSErTQOy08ABFosvDALUZ0Hh3nfWSLFpEAgCHYVb0UQubM/YtaqrC+h
         QlKF539REmgVFihPgwtBH9LMqcpNCoKcqCjIyQ9X74Uij8AgYkNsbohDToH8DW7TGbf0
         /hgk95voljxzDI5aViDj4oV9xq0XH5nV6MgdAew8Ch9PrCtWEEJzawRnvc30ghZLKwtP
         O8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733481859; x=1734086659;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTeXRexHxmWZDUZ2GwfRLJEOIQ5SEyCBipbLQd91jjg=;
        b=gZBmWOOF8C12PuSCt0lp5/iw/4OJgzGl/gMh8j6QxuVwD48fxyMuGsQedXOnw3M3eL
         ZPlDV950Ws+Nk3gNsL948fDH8RsQgtGQPVjyh7l33kwkfdihI1T61GJwPdRfwZbAKGQ9
         xmXapSl3B7N8anXLXJck/J7jBVnUzS1NEGP+DXljxm8TOAANwqtn8SOxlb5F+7dxGq/i
         1e5QcEKZSb/+BOldtQeSvmKRXQIExEXvmVw/TEQL6CfJLq9mAxcvWRpfrWAxwhh8AFRI
         IxgeL/JPW+C39ndaxsFhIuhSK13TSxzsEnEVGUZ6KejAhSF+6UPcavg0cVW4dhnesNU7
         ai3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZoq3ubmbGUNn8Sw1Dt3PKDqETO25EpS796VQ47VQLgrM9rY/acroAd8ZgZMHv/ecLqRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbakcNhedHvVi1uCngVk2rI9CP+/tCJHmCtWgRdF9XdTxaT7g8
	wPjeqKK9QUn0Upp+SlmmJFNDvB5Ftub+p0NLZFTL2jXF6d2NV/QJh91mRQ==
X-Gm-Gg: ASbGncvgr2aBBE/0kNphVMjWcA4ATHTJEd4/nCA/HAmfJcSM5nWrwu/DGyLRs3+uWzf
	E8aBFHSeep192QX6V6PhEvdhqyNzx51Se2qezf/pgkFJ7MG9Cvy4zcWyvsxyQ6e6KQUMR0lvCGc
	+MX8dWwBAjulOQgxbWxJQqP6AQoWsfFzTcedxDE42+ccSFu7V6vjTFY7QoYSHRFrJyT/I4ROCun
	yHQ8HrLt+oTx47HiWjcL0okVZsCJYJf7fXjPjaefXeT/MI=
X-Google-Smtp-Source: AGHT+IE52Uxs5zTM9GXGYUzOVQQi2pNlJ1eMkwrmeVMZ9qc/OhGVrmTY9Izk10uuqKzCHQn1L9Wszg==
X-Received: by 2002:a05:6a00:218d:b0:725:8a29:27e4 with SMTP id d2e1a72fcca58-725b7c52e8fmr4425901b3a.0.1733481859300;
        Fri, 06 Dec 2024 02:44:19 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc6c2bsm2752643b3a.184.2024.12.06.02.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:44:18 -0800 (PST)
Message-ID: <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov	
 <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky
 <mejedi@gmail.com>,  bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Date: Fri, 06 Dec 2024 02:44:13 -0800
In-Reply-To: <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
	 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
	 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
	 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
	 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 22:22 -0800, Andrii Nakryiko wrote:
> On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > so I went ahead and the fix does look simple:
> > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
> > >=20
> > > Looks simple enough to me.
> > > Ship it for bpf tree.
> > > If we can come up with something better we can do it later in bpf-nex=
t.
> > >=20
> > > I very much prefer to avoid complexity as much as possible.
> >=20
> > Sent the patch-set for "simple".
> > It is better then "dumb" by any metric anyways.
> > Will try what Andrii suggests, as allowing calling global sub-programs
> > from non-sleepable context sounds interesting.
> >=20
>=20
> I haven't looked at your patches yet, but keep in mind another gotcha
> with subprograms: they can be freplace'd by another BPF program
> (clearly freplace programs were a successful reduction of
> complexity... ;)

If there would be no general objections for the patch-set I posted,
I'll do a v2 with an additional flag in bpf_prog_aux/bpf_func_info_aux
to be checked when freplace attachment is done.

> What this means in practice is whatever deductions you get out of
> analyzing any specific original subprogram might be violated by
> freplace program if we don't enforce them during freplace attachment.
>=20
>=20
> Anyways, I came here to say that I think I have a much simpler
> solution that won't require big changes to the BPF verifier: tags. We
> can shift the burden to the user having to declare the intent upfront
> through subprog tags. And then, during verification of that global
> subprog, the verifier can enforce that only explicitly declared side
> effects can be enacted by the subprogram's code (taking into account
> lazy dead code detection logic).

I considered tags, but didn't like it much for something so easily computab=
le.
Please take a look at the patch, the change for check_cfg() is 32 lines.

> We already take advantage of declarative tags for global subprog args
> (__arg_trusted, etc), we can do the same for the function itself. We
> can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> insist on this laconic name, of course), and during verification of
> subprogram we just make sure that subprog was annotated as such, if
> one of those fancy helpers is called directly in subprog itself or
> transitively through any of *actually* called subprogs.
>=20
> All this will preserve the lazy approach we have with no need to look
> ahead into subprog's implementation. I'd keep the concept of global
> subprog completely and exhaustively described with its type signature
> and associated tags as much as possible.
>=20
> P.S. We still need to keep in mind freplace complications, of course.



