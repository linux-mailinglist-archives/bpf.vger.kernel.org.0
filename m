Return-Path: <bpf+bounces-77724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6799CEF839
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 01:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B2C5300D333
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932B1ADC83;
	Sat,  3 Jan 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9DjK7g3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084C13AF2
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399301; cv=none; b=NfwLAmFB6er8F4k27QkXTBJTutCzPd5s3PZG3Cq46ebar/8EwPOgov34XHNxA3yelX+U/hxAQM2YD+JRns1roFtdpxYU92wLXPeXW7BwedL+nu+2bOKiOh011CtB6fevpv1vQsxBsdoLTl48K8KG7JXzpUoTV9qwur8nBSkCRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399301; c=relaxed/simple;
	bh=PyqUjkxb6usvaX1FPyXgGb6lW3uRD0ozW2LWqJdC8qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLLYzYfuNyPWJ+HWgu59LngfpHTEch/ILOfZ3ltWmHCjr994D07NBuwQp0r26Ixkt52UN8Ws0qWJInhJocJGWgC1I/l9WPDXR6XewhGPV04G1hNmbeIgitQFbmLtm1GX2LEM4ZMiq02G01uJo7F62sL9/weQjX5wiX+GlDLcqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9DjK7g3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so7245105f8f.2
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767399298; x=1768004098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m3Xzq4yrS7S661mIt0t1819iS3JesXub/bksAIEXnM=;
        b=c9DjK7g3AqL06U0Bbz+gRjvNuqUHd3+oYT6Wjm8iVlCiLRUmaZQOI3OYWZN27Yn/T5
         hT4SoB9zsTab6R2n9WcQqlefJiqcohnDbM22sxAa9O2Ob8CLGo0zk3RDJ71meGkvgRKC
         mMYHjRVV4a9sjq1FU+iYyc17y4Nl69fUIuexYlZm7FMlQbxnpTNWcdbS9/nz6YCfDXGz
         Ui839WECzS6g6Aff2tVRrsTloyktTPnQyms0vBbG9DNEeNhXigy2d/35pYsFsnjavK6g
         wEt2K4hpeb34SFGIKjLiZBk68Y4oV7CwfaXWlVqoaGWUT7VFrxWOIE0LQAg4nTAtgXov
         rmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399298; x=1768004098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7m3Xzq4yrS7S661mIt0t1819iS3JesXub/bksAIEXnM=;
        b=G/dMVMHJg61glJh5YKkMoF6MpE9e6JKeUB40RhE6AN+a42HsH+Hv985QV+rG17CZ5f
         Nw8Me1H48ZhJwMCHEIOyBzq598vKjQEoqpcYHwtccOICX6LFitrRxP+U8EsxnBHPm+yA
         fQIIfw4eh3srFY1j5QierosWe9ZJSUeelZ8hquyM9k98OVuNSfS1AHZO25301sc9cT1u
         RTSnQKUhSW0cg7GByPyo5ktEz9nzvut4HFPx58Vm1vPjS/Mh1LKUqcvK8HnO+N2gHaGr
         4/In4iITFLGrtEEve2xxg3XdHPpb0SGldagU/Yeampk8CWI04Wev98VK7s09yAj8GLYN
         99dA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Eu+ehUmjzhASBWvBhljvNA5Gux+bibmSDpsg7bO4ZfujXO/qKHa5YFix2APwuyzb+tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHjRNCBlVMJBsrs5JKVwSMLlNBaRRBiYEBc1mLexvJ3y1vPVT
	FmNY/Q/FFrsASUhUFYCI9pyUJQK8W2D5UvS/mcfQ6Vj2Dt5gHq5gywVOH5lp8CliVLfEtxVo5cq
	NEcp/ce6rLaZ6/90juDGPQFgVKTIfRds=
X-Gm-Gg: AY/fxX5aInCPsLWJW1nXADlk8JFj3n10bIqn7kaOg/hZn/KsbGlxOkacZIlcLkijJs1
	qkSHbvlrZnTWcJI311p623cfJPDQ+fWFOaCmKjFncvX5GuWIL9bms1Q/1iL9pVQhAbV9H4dKnD8
	LaYFkN47lBWaXGiDQloOXSkd+cWotcMiAbJvmd+Hgusm2VnwMa8Cy48ZEnUfWgoRiSekV1Gc6C2
	BcZrhbBnSLA9+EJtEq9dxARqoQ3TIKG4E0tX82J6AYLIVsgYAPuwmNxyZGuqLV/AzUShAHNIYH0
	NzvmTgtx97hHW6J2kTTcs4aTp6Pd
X-Google-Smtp-Source: AGHT+IGaIoXQ09hd438co5n1aUxz4cbfXHjGNkT5dEqcJK2ELfDCwDr6ZUtMvpqTKVK8p6odBRSELG1GsLyaiNmaJh0=
X-Received: by 2002:a05:6000:604:b0:430:7d4c:3dbc with SMTP id
 ffacd0b85a97d-4324e50b175mr59838287f8f.53.1767399297908; Fri, 02 Jan 2026
 16:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
 <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
In-Reply-To: <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 16:14:46 -0800
X-Gm-Features: AQt7F2rlLrvLQd3a1vVdYBsWIyI0gmj4lnLMEl0kDjUy1JeIS_8xIT_Xuw6h_AE
Message-ID: <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 4:57=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Thu, Jan 1, 2026 at 1:07=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> > >
> > > Over the years there's been a number of issues with the eBPF
> > > verifier/jit/codegen (incl. both code bugs & spectre related stuff).
> > >
> > > It's an amazing but very complex piece of logic, and I don't think
> > > it's realistic to expect it to ever be (or become) 100% secure.
> > >
> > > For example we currently have KASAN reporting buffer length violation
> > > issues on 6.18 (which may or may not be due to eBPF subsystem, but ar=
e
> > > worrying none-the-less)
> > >
> > > Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarant=
ee
> > > the inability to exploit the eBPF subsystem.
> > > In comparison other eBPF operations are pretty benign.
> > > Even map creation is usually at most a memory DoS, furthermore it
> > > remains useful (even with prog load disabled) due to inner maps.
> > >
> > > This new sysctl is designed primarily for verified boot systems,
> > > where (while the system is booting from trusted/signed media)
> > > BPF_PROG_LOAD can be enabled, but before untrusted user
> > > media is mounted or networking is enabled, BPF_PROG_LOAD
> > > can be outright disabled.
> > >
> > > This provides for a very simple way to limit eBPF programs to only
> > > those signed programs that are part of the verified boot chain,
> > > which has always been a requirement of eBPF use in Android.
> > >
> > > I can think of two other ways to accomplish this:
> > > (a) via sepolicy with booleans, but it ends up being pretty complex
> > >     (especially wrt verifying the correctness of the resulting polici=
es)
> > > (b) via BPF_LSM bpf_prog_load hook, which requires enabling additiona=
l
> > >     kernel options which aren't necessarily worth the bother,
> > >     and requires dynamically patching the kernel (frowned upon by
> > >     security folks).
> > >
> > > This approach appears to simply be the most trivial.
> >
> > You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
> > And with that the CAP_BPF is the only way to prog_load to work.
>
> I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_disa=
bled,
> because (last I checked) it disables map creation as well,

yes, because we had bugs in maps too. prog_load has a bigger
bug surface, but map_create can have issues too.

> which we do
> want to function
> as less privileged (though still partially priv) daemons/users (for
> inner map creation)...
>
> Additionally the problem is there is no way to globally block CAP_BPF...
> because CAP_SYS_ADMIN (per documentation, and backwards compatibility)
> implies it, and that has valid users.
>
> > I suspect you're targeting some old kernels.
>
> I don't believe so.  How are you suggesting we globally block BPF_PROG_LO=
AD,
> while there will still be some CAP_SYS_ADMIN processes out of necessity,
> and without blocking map creation?

Sounds like you don't trust root, yet believe that map_create is safe
for unpriv?!
I cannot recommend such a security posture to anyone.
Use LSM to block prog_load or use bpf token with userns for fine grained ac=
cess.

