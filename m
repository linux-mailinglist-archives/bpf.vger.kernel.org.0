Return-Path: <bpf+bounces-77749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06238CF02C4
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEBC4301B493
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039023B63E;
	Sat,  3 Jan 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuPX78QG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA821C16E
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767456646; cv=pass; b=CXksFOW5BKESbSmKFunLk0uoH5jb9hLepbMjArZYOXZ9TZtKVFBrZzuBdRzDjFNoK6VhiHW8Jbotc9T09AnLXyUbmXcw8hwHpS4IgT7CzR42MApV/wY2a2oxpTkFrvb5n+vE4AmzK/nYMS2TnvnCtzIY/6kaMQnV7s3hOSGVhdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767456646; c=relaxed/simple;
	bh=sLqm4k+Q0xcFLcapu1YoX24l7Z+bf5eMdUHJjUooRBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw48qdWFqzTamt+KbEeTZ1vkAfeI7AZpACRaYudqy4xgFqreHEHkStLi4iowZw8cG4qGBoZE3UWKtSqtxPUPPuklm8P3DGZ/aqxDGnkMZFvFSLpiZ1SJo0xeZ7o4OXDCiDNXoL6MK7QLbRJKOrJfaU4ycteWDZLXvJxhJke+jAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuPX78QG; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f34f257a1bso228161cf.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 08:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767456644; cv=none;
        d=google.com; s=arc-20240605;
        b=SzL+oRAzLvVtLM8LmuPX823g/WEVpeGg25q+nlt/fNthZ3t/rBpiTkvxWhW7Vi6FBi
         rwa1MV5unxAzfE8pMuxdPIcRGuo4i2T3QXlsFX5TkwAhLVC79/Dw+L2OvDHQRpGwUyj2
         Dv22nOX/jmnICV7sT04IJGB8Z5Hax6NJGpWDyImOPDuRwOXQECPdztAhdftHbtQCyypj
         NtYJOm3DP/unPB9Dj8pSgZUwCj6Ilmye4Yef7TCpMn0fes5gciGyQV+ws8NjthnR5WiI
         xtNxJJwJf5KgNGInm6+ZvKPCDSpguJdavmWYi9WyVV7+6kAjyDoXI3ptD5gDvgAX0Nrq
         Wulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        fh=6vKoXYtMKHmYJbY158Fj+QbzKBUrhGKgH7fysnspvEo=;
        b=QTpN9QCRtlKweWQAi6LDFVjEoi7Dw7/P83JmaHUOju8ioQ1ra+ufbTGCZ9zwdBFGht
         FLPRFYuxaBIa0+Nnb06GykV2pQe7IrPBMpsBncrHIztA192g3ND/FdGmVhNjd/3cqplG
         sMEKp34VxMcGeEzPITxiNgYMdhRwtnFnNyk8+V11K6ZrE/1M3wpe6/SKgVNv0oYJHU5z
         8KparWfM8IHJ5JJTV9odipV2fPL32EGW3iUIgieTK+4RNE6MnlsGWnuM+uhhCTKV+uh4
         Ss5mkMKlxCPqsf429v6mxrghPffKsqKhmWEaCXjFuhzMJ4DS610SfpOYtQeWibC9kcOA
         dh9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767456644; x=1768061444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        b=cuPX78QGSpKVqM4YZXDWhY3tEDero5dtAtzmLsN7l3Mx9oQ2oN1nqPcpU2/CkR3LBt
         MD3BPFFGhaNQ7WM5LFtzoqtQ7nQoHZyhONg4Zuq+N/S/fyNfQMsJFXzALg9SNft5+yaQ
         NPQGzLdFhZCeLhlgAqlLn3+zmEdN21cyPtSQf9FRZXhrjKFzuO+26Z828OoSHzbrHmPN
         iltD8GiuseJj8wW4CJgSOY2xPLLYPwmOfVgUJh7nmDlUMbSK/fhqdpSHIuwVyVfrwUiI
         vVEtdjqUvtvTv8BHoJ6OReOkqscyIvWidVsmkCxrvnU0ZxEx8VxZecwW4vilPjgAMYOn
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767456644; x=1768061444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        b=ZGBUKxT8RxbAtFiq3n0XKjjN+RPpww0aOVORDrLWf+jF/MAJK0tnw8HMxSHdSypDhs
         jVQ0jaVKnh61p7Z/LHM3S1eejAhi3up05c4lP5gzfjYfORl8hwqFGFnK+ytXaBwEkVT8
         MwhVZTId29KGp8+JVcZo2CCYgbqdBXfaGf4GfQuVD08Hr5BTYehwr5UntNNLe+OiYHVj
         0oqzCnaxnHQ+UfUkJvF3BnCogT7CH2yeC8cbQqU8kbIQR06T7kfeAy5D+k/0AwqrjMFa
         o8JkvvDrZm/2dV5CwdPCFoE3MjlwKzMJJTSTkzqkozdq8OVsU1tIelVLGUgfR/9bB722
         hsIw==
X-Forwarded-Encrypted: i=1; AJvYcCXmj6uPqgHxQKC0hzaWic6ehPeO3OW/g7w0yYWPgaxkwq2ol7K1VVBpFWOADOteZ6K31Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcdltHnEUhN/1w/SwX6sm0EtoA0D3GHfRMQ6mMAzPZh2jeKR8
	1/b3faH14ZMwb8ZV0Fsgrzlsn/hiEtyE5HoR9Vp0pV25vywsoBiwrrfdnSZYr1ohWOJBD0NsdO+
	ExwmFFn5DurrRPef3O5OCtBMg9ykimNZ0pjkRLZLQ
X-Gm-Gg: AY/fxX5geN43WaTxfVeWVD1LE7bxCUYDtjI5JawAD3WDSAj6BxwpMijhZi9z1iOr7f7
	aVB4DHtfagdL7wLSwZBoXYIK+O0QAZCtGJarXnEYowXTzS5gmONfcBRm5gR5Ge9o+cr/IdDu5Eu
	+BI0Wc7gPCE1mA8Ge9JXSTr5w+S7koTWDVbcVYZU5icrEXtUKTZzsNb0zqHjQgVaAGFDfwYpKqS
	VLRd+z4eT4Jc7Fp+n3yrXN5IoKKs5Ug9tLMSpStdQJR2alcVn0IWgV46akL1fph4od0Momc6fOZ
	GPy/CgXsrdwnca/Yf0hPA59AZ2PT
X-Google-Smtp-Source: AGHT+IH4VSFS7H9XXCoXCOhz46vr+gFwgZL4hhqfsA0/tTmkZeIcGB0BgXtOAUwNOUGTbWQj+yfsp9N0wX8rE2j0VFU=
X-Received: by 2002:ac8:5e49:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-4ff7cfdab06mr4262571cf.19.1767456643799; Sat, 03 Jan 2026
 08:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
 <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com> <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
In-Reply-To: <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 3 Jan 2026 17:10:31 +0100
X-Gm-Features: AQt7F2q-QskYivbGlULymmanqYCPWC-YbceFTocPslSfTsL2jdavlfuvLb_fAK8
Message-ID: <CANP3RGemkEqfZi2zzB3YFqePf=6ZRJOiENK9mVTD+mJ+tzJJtQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 1:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_di=
sabled,
> > because (last I checked) it disables map creation as well,
>
> yes, because we had bugs in maps too. prog_load has a bigger
> bug surface, but map_create can have issues too.

Yes, of course, bugs happen in all sorts of spots in the kernel,
they're unavoidable in general, all we can do is try to limit our
exposure to as many of them as possible - by putting in various
barriers.  That logic is why we have things like layered sandboxes.

I think you'll agree with me that it is a lot easier to
catch/fix/understand the bpf map related code than it is to understand
issues with verifier/jit.  It's also significantly easier to test/fuzz
map related stuff.

Anyway, in a sense it doesn't matter.  BPF map memory consumption is a
significant problem.  As such while we can require program loading at
boot, being unable to dynamically create (inner) maps after the fact
is a way to limit permanent memory use, for potentially unused (or
lightly used) programs.

(Side note: it would be nice if we could somehow swap in a map into an
existing program at run time without it being in a 1-element outer
array... perhaps we'd need to flag such maps as run time replacable
[provided types match], or something)

> > I don't believe so.  How are you suggesting we globally block BPF_PROG_=
LOAD,
> > while there will still be some CAP_SYS_ADMIN processes out of necessity=
,
> > and without blocking map creation?
>
> Sounds like you don't trust root, yet believe that map_create is safe
> for unpriv?!

FYI, we don't blindly trust kernel ring zero either (AFAIK on some
devices the hypervisor will actually audit all new ring 0 executable
pages, which is difficult with bpf)...

The 'unpriv' we're talking about here is not truly unpriv - it's just
less privileged.  It's still dedicated signed system code running in a
dedicated selinux domain, with sepolicy restricting map_create to
those domains.  It's just that the restrictions on bpf access are
wider than on bpf map creation, which in turn are wider than on bpf
program loading.  There's various levels of restrictions. Some of it
is uid/gid based, some sepolicy, etc.

> I cannot recommend such a security posture to anyone.

Yes, obviously, allowing random apps any access to eBPF is a recipe
for disaster.
Bad enough they have access to cBPF.

> Use LSM to block prog_load or use bpf token with userns for fine grained =
access.

I hope you're aware (last I checked, which was a half year ago or so)
BPF LSM doesn't work due to being buggy (there's a hidden requirement
to enable DYNAMIC FTRACE, without which it is non functional - at
least on x86-64, likely all archs) - trying to attach a BPF LSM hook
unconditionally fails with EBUSY on such a kernel configuration.

I reported that here on the mailing list, search for "6.12.30 x86_64
BPF_LSM doesn't work without (?) fentry/mcount config options" (Aug
22, 2025) - you were cc'ed on the thread.

