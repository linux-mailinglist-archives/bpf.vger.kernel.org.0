Return-Path: <bpf+bounces-70861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E11BD7037
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAD18A85A4
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701826CE37;
	Tue, 14 Oct 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1PZbMMs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56508255F39
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406881; cv=none; b=c4W3J1JKVp/mM9t1tTbn0KZw/V9ImBn0eEcwQ/LHxqKzPM6vMumRXqi+gNAG0V2IvFE152RCiq0SeWgLgmTvj7sox2iaRdLGCKDh496jfJ0xrXqkk4OnnmCqFz2/iTjxXtBAhcGCLgh0SA22lZ63ObkMJcl+rlXP/5qBqxA+WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406881; c=relaxed/simple;
	bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9vPvguKAW4ebJpR6c1EcnF5m6m5X48gZsHrWnT//fTkUen6O1dlQ3QFE384ei/+xv20MCryhPNnF85S2/ld9v2RReKYmrDazMbF280TCVuCv+855MBT02eyhAFA/6EgHc9bGoUTeSyD1sF2FuX1VCw9EaQMToVLM65lJnFC1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1PZbMMs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63b9da76e42so3461262a12.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406878; x=1761011678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
        b=g1PZbMMs4454TNCD5zmwgDkfo8ROUwYLVatelqK4DoYSMIe3ALdvdHvHUclUxSOIIo
         fGi1elbRruEwt8ukeQBi141pMExvTTqYorYAUZbnN6YJ+y3S7lqC2Pq+N4Am8N4y6IWN
         l9aCKDKj60/zbLaxQNYztNZK8BOddFknYDLT0klUa7kXw2PLxwEHENFCnwBblIPDrMwm
         Hm7NaTeDyBR/zb/8jt+UQ+GzvVzSm1RTP5KyA7aoEUmhVrO+BXqWhIgYWuYk5qYOj7yk
         6D1+pTcByPsoETAqbwELasX4WMFzctSjmdTRskcfmrwjkDSdZWDZy0p0gq0SUZ45W1fU
         LsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406878; x=1761011678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
        b=p0dRJ6Vk31xqJeHMwOX90ZJRSGbtzBUrpCBj9HOlNePhlo9+e8VLEOk6BJNBcW7KvJ
         wm0PlpO8icNNtZ0h9/fBt6ZonYo7J0vuXyCSCqoGF2tmYupPPeW9wgqVdQ6/1wNX+7uV
         qY/60qFvTEX9HwqEMpSYg9ddwpx5gdAo9wJJ6kflUmDGygj4W+e/CLlNn6J4OYY0tRdd
         Yv3Kr5gZhNFTLO0JV7DNLCJY/Q56FPW2Qu+UGlHnJ9qA7CzTjPagDsWfCBKmDwN/LSP3
         zJ5A5ZU1nqKCNeLcsRcyVQiG0gieP99RTh9QDyYmAhKVmiDA+batogmiCnjjRJ5gLPXy
         iR8A==
X-Forwarded-Encrypted: i=1; AJvYcCWx7usJdEhTKInaLVyl/HpbWCvKVNbXhQI7z37mO9uf2pKu1pMb0Y9Js9RqM10oq3Vvg7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvNkujPl6QBrJCjPmAS7DZrgELfZbUKCAvKsNzUypLRKDIso5
	b32o43TJU44Vvj1bUkOmEj8L1ujzLB3ZXxCa91wUVXXLHbsYvbXV2cGGIYl2b+i1xQrrTfcJNEQ
	++La4UDbj66IDFzAbebfJiovj08jhqG4=
X-Gm-Gg: ASbGncstiCYSLcI1zvYfMXsACSuRpS3Cd09xK1hVR9OL5JDJrNbBB/gXOgwfU1ED2Wc
	kEetbZUM9ph1+b9jzX5dLZO+58ZRmVqRdSEZybjNKE7jx+Mtgm7vUpGXPH8Icc45Ijve00PBFsX
	MMZyFM2m72YkE/Y68u2TKZrHT1o7IO9aWnRJ6zLpfNOj4ErgiLvx47DK1KpbXpkr42LJhlN83Dr
	hjKVG8yFMYz5sou+kL1ZCEUl7g=
X-Google-Smtp-Source: AGHT+IFLyxaSkOEOsooMOy2EVh9b/r6FfxU6eF7+7y498s306bG3kLVif9WpacsPupFTNoocWy6y1TRJXeS5SduTWfI=
X-Received: by 2002:a05:6402:34d6:b0:639:fbc8:d38b with SMTP id
 4fb4d7f45d1cf-639fbc8d644mr15052860a12.11.1760406877642; Mon, 13 Oct 2025
 18:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com> <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
In-Reply-To: <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 09:54:24 +0800
X-Gm-Features: AS18NWBcWVoXtEhIyQDN7IDKtMQW7Sq_qJyx9nFb6aduVYEfQL76vjSRcYH8nz8
Message-ID: <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Just a few observations (if we decide to do the sorting of BTF by n=
ame
> > > > in the kernel):
> > >
> > > iirc we discussed it in the past and decided to do sorting in pahole
> > > and let the kernel verify whether it's sorted or not.
> > > Then no extra memory is needed.
> > > Or was that idea discarded for some reason?
> >
> > Don't really remember at this point, tbh. Pre-sorting should work
> > (though I'd argue that then we should only sort by name to make this
> > sorting universally useful, doing linear search over kinds is fast,
> > IMO). Pre-sorting won't work for program BTFs, don't know how
> > important that is. This indexing on demand approach would be
> > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > Overall, paying 300KB for sorted index for vmlinux BTF for cases where
> > we repeatedly need this seems ok to me, tbh.
>
> If pahole sorting works I don't see why consuming even 300k is ok.
> kallsyms are sorted during the build too.

Thanks. We did discuss pre-sorting in pahole in the threads:

https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy-hSu=
HoaT5A@mail.gmail.com/
https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=3De8a=
vRWpMQ@mail.gmail.com/

However, since that approach depends on newer pahole features and
btf_find_by_name_kind is already being called quite frequently, I suggest
we first implement sorting within the kernel, and subsequently add pre-sort=
ing
support in pahole.

>
> In the other thread we discuss adding LOCSEC for ~6M. That thing should
> be pahole-sorted too.

