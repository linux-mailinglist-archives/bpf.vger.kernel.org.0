Return-Path: <bpf+bounces-65281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB36B1EF4F
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 22:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE3DAA0744
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB7222568;
	Fri,  8 Aug 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCjDRNXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA52198A2F;
	Fri,  8 Aug 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684141; cv=none; b=M2mFenWrbVZiNaBWDsPYggAf5TkCQ0oNSGH8EwZc9gkqlKj0A2N7sG17tL55/P51XqKmVrLiHFBXj3taSl6fGER9HXNmPmpnztS+xVkVhcRve6OzS4eMSC4qRZAO/ypmSxpzGVutWJUbst3ybYHw/YZlaoLI72OA0OVdKGSoBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684141; c=relaxed/simple;
	bh=SBi+3/3vAAWMtHOrGr/AI9GV/xOShsDzTg6s7CgPUgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DqklX3tgGV/ZNs4DKjXKXC23eGlL5LVEVNhxKI3e7V3uBKka8t9tfCukz5wF3NS5EkX8hfjiWP3HQdL3+bgDI3aV5p2zHfW68qiokY7Q04QUcecKCBoQiSEkoxN9DWTpOsx3WdqFdHUfWALuwrht5J7CTL93dhalMhTDbzIEVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCjDRNXQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2402774851fso23003455ad.1;
        Fri, 08 Aug 2025 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754684139; x=1755288939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cmn3vrO0n5sCKGvEYFpPcbp16uatruewf6fH+rG16g8=;
        b=kCjDRNXQvVrizFdVC9eQLd9SYnGstIB+MAw5827I17/emH2dttJwwYx32B6+vBv7/k
         RDFFSXWp3vpKlL+y/ygbDl64aF0Q2nMfG6sIo/xmBAbClnU3f1RIfwl6O190LuRP1Qmi
         r8cjC+QLixSoptEjIS0MW+DcL1kRFJLFjBHLBCMQo51EEjqHzqLS/bTmS5AiAAyMaqHr
         HiPfHNLmj3o5G15ZyeRHRvOjjn6KUlOlpYVCCZkvbCPilTM31Xybw4DLQEHNoEkZ+J2q
         DXL5MsSbK460/K1Glqv/ApLqsWQWwZ1MpI5tgRQd0f6nJ/qgBi/B3wYw4nprY6qRZRjx
         iOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684139; x=1755288939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cmn3vrO0n5sCKGvEYFpPcbp16uatruewf6fH+rG16g8=;
        b=ItTlfmcmb1wqkclcFHanTK/n0p3bnXW1plPdjx/kcY67O83hU8aleXB6MNG08F5AU2
         s03HMRcS0mELo6BVrXMbOfLlSHY6NGP1HIiWAqpkDn7Wi6pSAm+yAbM1zgja2m7hHHet
         q58OVoPblmvYBP7kRsk5nWgYr4xbwVuvqq2ouWje4jP8w+rkDzZKUIleDpaIZgdU74nx
         q8ZfLA+qqBljQG9d6Wt6Ilq/+VSg4hWm8sSDiYt8IlO6bDBKaePJHia4JnOjkjEvIEmG
         y25oW/c3U8q9j/czEquPCwaD3wrIbA98SMNkpNacpiUKCKJPIl8s3egBMRTyG0yBgs6F
         6YZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDZOjykBkwhRp8/x894fDUXa517GgzActUGMsmdo1SazdugqmXKA68gapcr4lBLlcfiTo=@vger.kernel.org, AJvYcCUw2vdOlr4mjeck+gX5SKQ4R9F3238aTUcbg/LM4kfwt+pjVMg3T5gxLLlhZc10hr6LORGVYKiz+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxle313Jz1vktQEKqrYIE+Na1+GDLQrASX1uXCq10H/dIql2YRy
	4YQCLQhsczWsD9e9jfTdeoWziUrgGMKH6wI0Nd1wmvmzEB5QVhR5LUkB
X-Gm-Gg: ASbGnctqynaKDPaTtLJVtIIBTPtQEnoSWhoG9+mb3T1mxWG+BVOSffHbmieEsObmj3I
	Ahh1DQm9wVzTnTuIxE+Z4wUoCrCIC2WeVGUGXqQkDWrqbQLGjW3hIsDFUjy5SXsQvttGkNlY+yj
	cJg86sP2BGKJaHNyCmQQOdVqHHiNoQsAfd/DvjRbGk8hFhi8DJUzWKpCCo8vRKa0wjGQW3DXYoq
	c8eyPAkhtkhi0W/btGQA90+EeowqouYoqMBPH5kg7ndSe8r1mdJnmljfcJo6ZH0LlfzQZGfcdlR
	8GAHyYRJcug2a43nyKWPFfQktOnyQnpT0aCyUOW3FeokmIaAQ4JmtoGGZsC1F+AqqyKGZS0cRJe
	aijZP4bJk40LKa7q95/c=
X-Google-Smtp-Source: AGHT+IGxNdOdIv8g6yJGi4kluz0LJ0FmC8acg/ZQPfNTjvbr4SCdqYqRmQ3+zQIyOfLGIFN//1bosg==
X-Received: by 2002:a17:903:1b64:b0:240:7f7d:2b57 with SMTP id d9443c01a7336-242c22a0552mr55661955ad.28.1754684139197;
        Fri, 08 Aug 2025 13:15:39 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm216739515ad.48.2025.08.08.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:15:38 -0700 (PDT)
Message-ID: <0c4043615432db7067fa6e2abae21d18cf3fd2a1.camel@gmail.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 	nick.alcock@oracle.com, Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, dwarves <dwarves@vger.kernel.org>, Arnaldo
 Carvalho de Melo	 <acme@redhat.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Yonghong Song	 <yonghong.song@linux.dev>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,  Namhyung Kim
 <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Date: Fri, 08 Aug 2025 13:15:34 -0700
In-Reply-To: <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com>
References: <20250807182538.136498-1-acme@kernel.org>
	 <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
	 <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
	 <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-08 at 16:10 -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > I'd like to second Alexei's question.
> > In the cover letter Arnaldo points out that un-deduplicated BTF
> > amounts for 325Mb, while total DWARF size is 365Mb.
> > I tried measuring total amount of DWARF in my kernel building directory=
:

[...]

> > And it says 845M.
> > The size of DWARF sections in the final vmlinux is comparable to yours:=
 307Mb.
> > The total size of the generated binaries is 905Mb.
> > So, unless the above calculations are messed up, the total gain here is=
:
> > - save ~500Mb generated during build
> > - save some time on pahole not needing to parse/convert DWARF
>=20
> Well, this 845M number includes modules, that I didn't take into
> account in my quick calculation for both DWARF and BTF.

Sorry about that. I have just a few in my config, for those about 6Mb
of DWARF is generated.

> > Is this is what you are trying to achieve?
>=20
> > In theory, having BTF handled completely by compiler and linker makes
> > sense to me. =20
>=20
> It looks right, no? But it's not efficient as BTF, as you point out
> in your next paragraph, can be generated from DWARF, so better do it
> as a final step if we want to have DWARF _and_ BTF.

Idk, I'd stick to a single way of generating BTF, either using an old
scheme or a new scheme. Allowing both will add one more variable when
debugging BPF/BTF related issues reported from distros.

> > However, pahole is already here and it does the job.
> > So, I see several drawbacks:
> > - As you note, there would be two avenues to generate BTF now:
> >  - DWARF + pahole
> >  - BTF + pahole (replaced by BTF + ld at some point?)
> >  This is a potential source of bugs.
> >  Is the goal to forgo DWARF+pahole at some point in the future?
>=20
> I think the goal is to allow DWARF less builds, which can probably
> save time even if we do use pahole to convert DWARF generated from
> the compiler into BTF and right away strip DWARF.
>=20
> This is for use cases where DWARF isn't needed and we want to for
> example have CI systems running faster.

Ack, thank you for clarification.

> My initial interest was to do minimal changes to pave the way for
> BTF generated for vmlinux directly from the compiler, but the
> realization that DWARF still has a lot of mileage, meaning distros
> will continue to enable it for the foreseeable future makes me think
> that maybe doing nothing and continue to use the current method is
> the sensible thing to do.
>=20
> > - I assume that it is much faster to land changes in pahole compared
> >  to changes in gcc, so future btf modifications/features might be a
> >  bit harder to execute. Wdyt?
>=20
> Right, that too, even if we enable generation of BTF for native .o
> files by the compiler we would still want to use pahole to augment
> it with new features or to fixup compiler BTF generation bugs. And
> maybe for generating tags that are only possible to have the
> necessary info at the last moment.
>=20
> So something that looked like a hack seems not to really be one.

Agree.

> Then there's Gentoo, the one that likes the idea of a DWARF less
> build... I like that too, so will continue working on this 8-)

Out of curiosity, w/o DWARF how do you debug issues when something
goes wrong?

> Now if we could have hooks in the linker associated with a given ELF
> section name (.BTF) to use instead of just concatenating, and then
> at the end have another hook that would finish the process by doing
> the dedup, just like I do in this series, that would save one of
> those linker calls.
>=20
> I did some quick research and couldn't find such infrastructure in
> the linkers, I think this is a sensible path, use the minimal
> changes in my patch series to have a .so plugin to use with a linker
> that supports this, but then this, again, would make sense only for
> a BTF only build.

LD documentation page mentions existence of plugins [1],
but after a cursory look at the source code I'm unable to tell how
easy/hard/possible is BTF modification from such a plugin.

[1] https://sourceware.org/binutils/docs/ld.html#Plugins

