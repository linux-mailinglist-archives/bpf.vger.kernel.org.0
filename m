Return-Path: <bpf+bounces-74680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E96C61C2B
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00E6D35C2D4
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F725A357;
	Sun, 16 Nov 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="PzgA6oFL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A77231A55
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763323908; cv=none; b=o+hGL77ACfN/gPSWhiC4DgBGbtZCVfDpgwZQTGVaSZr6f0mMuMj+yJ2HGUhfkqt8ZOwUAte8mZbr6e/cLU6kArOeT8TfeQGQSNxrynPAdFHD7qH4oLo0YeGFQ6IogNrXn1G3ci7JTNqha5KvhIt6LcdGXm+w+9MEyXQKwRA96WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763323908; c=relaxed/simple;
	bh=O/Vjk1Xh8eYR8Ur3eWl+sAxXffr4Y9FnqGqkh9A6umE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCcQm8CAm8dhAET0ItgkgVcWQvfdXuE+GQ+YtX4vx1AUBrpveVnEB1Y8LUJRmSGzs8peoI19peY8vw8AvxOo/XOcEyrUamaUCVE/2FwP4rcCtWyO6FVDbGMkO4DopL+49xcMrimn+45nze180oU89AwKNzJ8ocuGK/oUvSAJpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=PzgA6oFL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso3901584a91.3
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1763323904; x=1763928704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6s8G8P9JvtfPhs/P97BHamC8MDASN+3jiglPXbUicI=;
        b=PzgA6oFLAjEgKf/hYA0AdGdVOdlOnwt+GNQGft8PRplHl4ksxRggorkAbR5vmW72xq
         1+ZA3cqEX6vHlh7jg8reIDNcqF0+vi0RLG4xBPmWc7MI8PlbZX6S/yvQsNQLejnlOPOD
         OJZb3eF5/7PX7VRA2k9an/I8UQjDUx6qgJmSR/KIVJ8H0eatYZb+BWW2+f+uEBdBtIXu
         4FzAzvWJzcaKiVOnYee9GgVWNaWS9m/GslqotkXNDxycCmIIM4CxNCeTeHqDPKaP1mcm
         BwbwW57SxQORcYiIhhB3WQTb8PxwdjNK8xBqVyQ/glcq/mv5GnXhYIB6xiHc6Zqr82Vq
         NlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763323904; x=1763928704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6s8G8P9JvtfPhs/P97BHamC8MDASN+3jiglPXbUicI=;
        b=rCktSdlWOucp+XzF1mvNjNgRAYklVN9WDAza6l+Q55yDvQXa6C/mfwNimWSgeoxsFt
         X4DYMRvBwtzhfUYZVEmt5T0jCV00muIgqicUibPaFZ0q03xj9F01yg6cbPTp4WRXutZH
         P8vFgYdvYf2Jlb5bxyMn4v1+cyQp8AY6QKm0Iuo63S9luF8n0HmJ7TQYXOs2mvK67sTj
         LLlz6XSQPLCQCRMM7CdY2LgoYWLgNujG3+V9ISuv3geuz7z528J8VD+9JgCMWaRa/Q2A
         6FZnxMwwmUx+TV49LuJBD/b5c8VTsByY2NNeiQlD6yLecpS0R5UmfknrOB1UStHiTnMR
         zTYg==
X-Forwarded-Encrypted: i=1; AJvYcCWvIJm2G48piRdpP91g5KBRgVw7L7oPc3XY/9Rpm2SA+9gmbvtW5Crb8hiorMWbIqPHx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqoEicXGftsPbjuyI+FyB5Wg14x0vO1IHuIGvSBziVLakMrMD
	SIIggmuA99hZQ/ufO62fsJ1WWQe7Yeqv3rMppDXmUZXbWuQ0KEmIm3VUzeoqPSuEUe8cFOJO32N
	tCKElBNWsdQpOVGxxcuEgim5nS0LZTsqV1f+Tv1uysT9/q5+IAnOgwzw=
X-Gm-Gg: ASbGncstMjgeIh+mNhat2agcqJTxR3xl/PILpCwYP7vYCUh4jl2U7mUs19lZHi3T5ao
	iMyn1Vx1xijPXu4JhmZp3AmKESFNqlAphcHTnz/koi34sFzQJk6+LT4dgg9rxWg0ymg6G5enYln
	bcV7+VZHHx1tAB/IWGUNucIITR+gBaGyxAFe3AtdxtEosdvVgR7vUrjWb+y+1V5ssMxQEtDNn4d
	+m0Yib/yHuKQFScREPoYIhh9OoMolgrex4DFvflWg0IPf9aDpQPjEC760h1fQ==
X-Google-Smtp-Source: AGHT+IFBJXOCk3BfQUhUlU9G/ttvy7/dKS+0r8ommAcsJ2pmnQf4zHTY16AW13lZtIdknagx6qjLUyoqNImQEam/YpI=
X-Received: by 2002:a17:90b:5444:b0:339:d1f0:c740 with SMTP id
 98e67ed59e1d1-343f9ea688fmr10542349a91.1.1763323904225; Sun, 16 Nov 2025
 12:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
 <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com> <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com>
In-Reply-To: <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sun, 16 Nov 2025 21:11:32 +0100
X-Gm-Features: AWmQ_blGSsz2lbdMvzp2BaeQnhrwr2EeNt7qLtty5VDkhPvJIqMjnvK8XvmChOE
Message-ID: <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > Hi Alexei,
> >
> > Thanks for the info! I wasn't aware of that fix, but I just checked,
> > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64.
> >
> > I just installed the kernel sources locally to make sure, and the code
> > for rqspinlock matches that of the commit you linked (i.e. the
> > is_nmi() check added in the commit is there). The code for the related
> > commit  164c246 ("rqspinlock: Protect waiters in queue from stalls")
> > is also present. You can verify this yourself on Fedora's 6.17.1 git
> > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.17.1-1/=
kernel/bpf/rqspinlock.c#L474
> >
> > So it's good to know issues have already been fixed in this area since
> > the original commit, but it looks like there's still something lurking
> > here. To clarify, I'm not exactly sure which of the various timeout
> > cases in raw_res_spin_lock_irqsave() this recursive lock situation is
> > hitting.
>
> Ohh. Interesting. It's a new issue then. We thought that
> that commit fixed it for good.
> How quickly does your reproducer hit it ?

It reproduces ~instantly on the machines I've tested on, which is a
bit surprising given the inherently racy nature of this issue.

I've reproduced this on 4 core / 8 threads and 16 core / 32 threads
machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user who
first reported the issue was also on a 16 core / 32 thread machine
(kernel 6.17.4-200.fc42.x86_64).

I'll be out of town for a few days from tomorrow, but I'll try to put
together a more complete repro before then if possible. I can also
provide more diagnostic information if needed.

>
> Kumar,
> please take a look.

