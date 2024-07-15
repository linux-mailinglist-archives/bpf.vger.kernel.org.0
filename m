Return-Path: <bpf+bounces-34841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9B931BA3
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4890D1F222CF
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445113AA5F;
	Mon, 15 Jul 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F148nSjS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2833C5;
	Mon, 15 Jul 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074384; cv=none; b=uqGQ0Wx4QfGhHca6cCs5lzJR0ZsoCYzogr4JG+LTtJ0e+JT7IJOnv4iPQYaJo6Ay8Cq17Q31gDbDI5toGlSIeXJEwYkpYP71BW4+raoWU2r+5DPcYxPzwimTZgDUuoGRLaY0Y1Irl1AAfFsy+QfqPBwEoAean78xFed+H9bPx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074384; c=relaxed/simple;
	bh=7OmVVQobhT3hSRfGbLhcTRfJUMXmXRi2dqnL5IXZS94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrQAAL5hLRNc9DRTmGaOvBBY/PfoME0pkD3ZIay4o9l2ZNLTwdouCOOxSlWfFwvhzdjiNtBHE37uvZFifoI795i/r8aToLgubqla4BiEETYtuEPxV7E1mfNTnUCabz2tNQmZSxj/lLdd5aa/mrQkRqdZoYboHdbReUdHlgY9VxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F148nSjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71526C4AF0E;
	Mon, 15 Jul 2024 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721074383;
	bh=7OmVVQobhT3hSRfGbLhcTRfJUMXmXRi2dqnL5IXZS94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F148nSjStWATTjAnDYTpC9c0XIaOxn1KvnJIj6HAtt2tSLK4GBJH0V6yQNyB6At8E
	 Dh3cmk92UReqsRsOHGHl+wlMc51+Pa7rXBDAH4A5gBFUkmKCjAx4/Nbb2OecpxJ/WZ
	 H6u6L7FXB4kNbf+l/QiqaEA+GNakZKgc+RV3FHko1ds2meoYeOYfEkb/SRDOxcokbl
	 Lia4mvNHDklhZjiMQj2WhrAVaYM7WctgK847g18BDjlWvZ5LsO7i6SnGzJSWmJusUn
	 ch23mcGe2aRrSlDluuxG0h9Q0z/GVTwTpZlsR9e3ujPY3tDhIzFYIyUHr9r67F8UaK
	 ErQGpvoWKsRlw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so55142541fa.0;
        Mon, 15 Jul 2024 13:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbl6JiuPOR6UGrkTfnU3IL3jUnqr4t3v9M4Z6UkaUHDJ+fNAG8DnW/6MHqOIREXTMi2IJ0yGaxuifdd/PIXMNAAqeNCqzAcOLQi4b7fjPnYoGkGo5hcr4kkOfFvHVhJROkGKdSowSI9sLq6gxG2at/wyFbrOqbV9xxoNFR5gMKYLwrIJ1XuVWbMa1I1g5/WQTVLKqpcdRkteLhjHIONqqcJB5LzpqpsCQ/1LqwwbO52K9YRKyd7hxN18YQwtlOis1RKA==
X-Gm-Message-State: AOJu0YwRKCORehAv2OfGaC7w3yOUEonDn/79PKSP4MWHYFnZFqhCnNQJ
	JnkqqI2Ta2jkEpNnrCRPtWQHYexWs5IV/KYfZrxv7KRNwPxUKwvOlasQ9BgJgFuehbp0GENhWY8
	hW7CydkMl12NKSYlVC9PwyrS0XEw=
X-Google-Smtp-Source: AGHT+IHobuX65Qnne2KlfE18leFW6GlJLHaB/JmPa66fpayvh11K/s2F89TKgZdfpv7KGVf5mpLk/XmBKYwXCMmctQY=
X-Received: by 2002:a05:6512:1282:b0:52c:e393:6634 with SMTP id
 2adb3069b0e04-52edf019b1amr10513e87.33.1721074382019; Mon, 15 Jul 2024
 13:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613133711.2867745-1-zhengyejian1@huawei.com> <20240613133711.2867745-2-zhengyejian1@huawei.com>
In-Reply-To: <20240613133711.2867745-2-zhengyejian1@huawei.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jul 2024 05:12:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkSnZ1nVXiZH9kg52H-A_=urcsv-W7wGXvunMGhGX8Vw@mail.gmail.com>
Message-ID: <CAK7LNAQkSnZ1nVXiZH9kg52H-A_=urcsv-W7wGXvunMGhGX8Vw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kallsyms: Optimize multiple times of realloc() to one
 time of malloc()
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mcgrof@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nicolas@fjasle.eu, kees@kernel.org, james.clark@arm.com, 
	kent.overstreet@linux.dev, yhs@fb.com, jpoimboe@kernel.org, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:36=E2=80=AFPM Zheng Yejian <zhengyejian1@huawei.=
com> wrote:
>
> Array 'table' is used to store pointers of symbols that read from in.map
> file, and its size depends on the number of symbols. Currently 'table'
> is expanded by calling realloc() every 10000 symbols read.
>
> However, there generally are around 100000+ symbols, which means that
> the expansion is generally 10+ times.
>
> As an optimization, introduce linked list 'sym_list' to associate and
> count all symbols, then store them into 'table' at one time.
>
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>


I do not think this is worthwhile.

realloc() is simple.

If this is a problem, you can increase the
"+=3D 10000" to "+=3D 65536" or something.







--=20
Best Regards
Masahiro Yamada

