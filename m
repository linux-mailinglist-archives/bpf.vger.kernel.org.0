Return-Path: <bpf+bounces-53917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FEA5E3CF
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAFE16BCD5
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75A258CE6;
	Wed, 12 Mar 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2EYlh9F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213E2586EC;
	Wed, 12 Mar 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805006; cv=none; b=P982Jq4ijQCK1dw4scZNypMmJzgU6xGelsJNyiur+V2aWE7YwXC1j9ognzvnKG9aPdmncwxNBlMtLoNcTT0rv8GW2pIX2cJfSVoDywPFY+T6raJNWMsrIsUTIRihXxLumqyWE7gNgDhwGV9lxbZ+/ljEiW0kpMNNI6ssGNrHKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805006; c=relaxed/simple;
	bh=bRTrBs8ZvSxZd4T+sQY5s7scvb8SukTXrW9oF7UDx/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6irRg8OX6e4sFhfigcpP2UV7USK3ykNtNykgE8HwuQ2Q0ZcykIkOpTHMjplgtyFFkl7XXF2eF0J3Ug+DmaTZyBnLSjw4OemE8eHpp0gi/YTjCVv4WUgfaY3d3+2hC4UV+KrqSpJ5uBq7ApD53j/ElRBrtUM9Il9gxj3kSn5FDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2EYlh9F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso513648a91.0;
        Wed, 12 Mar 2025 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741805004; x=1742409804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLRzQ2T4mI/FN5EmWDBDoPjyGPBcqp/R1BPpJRwHh4o=;
        b=m2EYlh9FWDfonA8GdhMAojcjherdAyPUlWkPFkqDu8THFeZabTjetub5Ym9WRhkdFF
         YlI6RuGOJ/qZPWFEn4NT6mWL3/C1Dz+yf5hUv1Mf48Njlw60BXW0kzRBpy5F3OtVS6LI
         mV2HSkz/aRJ3CSPKx3QIQEGJtdyMKEzBYIuDmiBMlTbz47s5+hKnJWoWDWj40vaQYiy2
         kHGiu/FdIoAlBrkkHsVa+qtaYCtfFTZM3EEEUhixI9fDKYm9ND8v+WHoC+YYlTK2tnaw
         q8/Svbol/Gnf2of8F7v4RHoLWAL8HDnloXpTc5eI63ZnQFfdJwMB3VikyeHbpVGO2azq
         LAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805004; x=1742409804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLRzQ2T4mI/FN5EmWDBDoPjyGPBcqp/R1BPpJRwHh4o=;
        b=U/QSpHfxY+kXFg5ZWl2uw9Sy5/Tn34WV34XMGYm4xlbWjXrc/50bj6TD7b0MjgNz8F
         ryMqo2kw4uhdIrO/rmmmVog5NairlnCfXeFBkgR+MldWWghv17itYwOlMIONTR3viSaj
         E0LolXPH8LSrtDh1YHuVu1CsTIlbe2kef99Oa993/qV9lzR6LKLovS+ReM4GmajFM6jz
         kNamhI29ffguoCIA+I3/Ixx8pPAbWSEuznvf/GNaN4pper6RmjEa/hzVUY2D9h71LKk3
         dvqON0NQPBVNCIfVLAI2WO3v4DrDLRK7ndcQ1WTSooUD2phE4TSoXs4D0vdxP843BseF
         CMdg==
X-Forwarded-Encrypted: i=1; AJvYcCWWVWMllsiRR7YM1fxz9ICTD4YmazgBnaW1ZUEu9fkwaOUUZeAGpym5vJSiieVtsQC7KJDI0gQX@vger.kernel.org, AJvYcCWkULnqCdeQuZwjCqqFA9TFceeNCr5YEevR9+9dLt+ueMA0ZYjD0dMaFLA1iIyLohFtaGk=@vger.kernel.org, AJvYcCXbGJpgd/Zh+DNh4TWGJ0alsm47OCEmZSg6EN5XCoNPNdEEfedHQBzg4R1VKf4iarE4qaNSOR3rSHTs12aT@vger.kernel.org
X-Gm-Message-State: AOJu0YzLESbKDiB1nmSKtMCNTWXBZrSn5pKjK9dcGFxMRdBQkbTCr4ym
	6pey+qG3fbt7OamfHizElVn4qeRnnETTLmHAY60cz7Fkfh0zffMAgF+f5d70983I2icagFn2mRi
	o1CvLbUxMoVF6sejja1VlRdmREmYGKtz0
X-Gm-Gg: ASbGncvt9guvzc2bCGipJPmGgT2pfTMLnGl8smZYvkakujoDHUL35gQVGx4eE7HLObV
	mzepcBJmul15jMJYi7pij34QppixjNrKotXv4W6xg/nr6FNqu+A7aj97wSPjsFSXLP1JPMcpZHu
	NnOlECjlFQxyIQCKVtx3QW00OUOeEqjkErhyqn8XSN4w==
X-Google-Smtp-Source: AGHT+IF9ycBA6Yl4x+TpQ7vtlBFB54kMvYxjsoLeEH6VcqCNix5FhxJ504+uVaq42bPNb61hmllhGjVsyGe08+WlefI=
X-Received: by 2002:a17:90a:bb8d:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-2ff7cf5f7aemr35160494a91.15.1741805003965; Wed, 12 Mar 2025
 11:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
 <2025031100-impromptu-pastrami-925c@gregkh> <CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>
In-Reply-To: <CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 11:43:12 -0700
X-Gm-Features: AQ5f1JqxkR_T4R54umDhCIYjkeNDpM3zou5S7KUw6c-AcfpZVvagH-Wxud-x4lM
Message-ID: <CAEf4BzZAT_w+=7marwFgMg0i258KJFDnwrwnfwAjZ1DRX52ojA@mail.gmail.com>
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>, Jann Horn <jannh@google.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:03=E2=80=AFPM Chen Linxuan <chenlinxuan@deepin.or=
g> wrote:
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=BA=8C 19:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Mar 11, 2025 at 06:05:55PM +0800, Chen Linxuan wrote:
> > > Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> > > Handle memfd_secret() files in build_id_parse()") to address an issue
> > > where accessing secret memfd contents through build_id_parse() would
> > > trigger faults.
> > >
> > > Original report and repro can be found in [0].
> > >
> > >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > >
> > > This repro will cause BUG: unable to handle kernel paging request in
> > > build_id_parse in 5.15/6.1/6.6.
> > >
> > > Some other discussions can be found in [1].
> > >
> > >   [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kern=
el.org/T/#u
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> >
> > You dropped all the original signed-off-by and changelog text.  Just
>
> The original commit is based on commit de3ec364c3c3 ("lib/buildid: add
> single folio-based file reader abstraction"). `git cherry-pick` result lo=
ts of
> conflicts. So I rewrite same logic on old code.
>

Yep, for the purpose of fixing the issue, I wouldn't try to backport
my folio-based changes to lib/buildid. What you are doing here (an
equivalent direct check for secretmem) makes sense to me.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> > provide a backport with all of the original information, and then if yo=
u
> > had to do something "different", put that in the signed-off-by area.
> > THere are loads of examples on the list for how that was done.
>
> Do you means that I should:
>
> 1. Run git cherry-pick 5ac9b4e935df on stable branches;
> 2. Resolve conflicts by drop all changes then apply changes
>    as I send in this email;
> 3. Note why content of this patch is different from the original
>    one after original signed-off-by area, but before the --- separator.
>
> I am not familiar with contributing to stable kernel tree.
> Sorry for bothering.
>
> >
> > thanks,
> >
> > greg k-h
> >
> >

