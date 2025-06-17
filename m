Return-Path: <bpf+bounces-60825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79488ADD3FB
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E8516D14C
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA32EA172;
	Tue, 17 Jun 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk9PjmnJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372792EA15F;
	Tue, 17 Jun 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175717; cv=none; b=uFGOvYJw5VlkGuDWEYELZJS1UgrgYTA6MSYUmv/wOYqnUSehpLWzjsnJjeuydHkaQ4OPGfsqq1QQX/caKUDpl87ixlJVommI0K30Bo8z1Hbj6ghFRSbs+lybTRquCA0Psh2GVQlJzeTjEdeMi5aaDmVyWKKZZX+oraHOr1uBStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175717; c=relaxed/simple;
	bh=xT9LTxXRsAvFMMm/rUTVAJh+ZpJa8uGFFOblzL9irwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8hS2QYBU36PDAUnENayQhEjFYDiz1rmdVzDtxTYTrno5nI+stJMkMGmFobbAsOdSVGavDb+j92KfkdDeUf1aeAPuSaqqWN5PzgQX9LuL6b7kxLVPHB6hRjHb2rDtIJuIiuOYOO2pZyWxPQyIia06ZqEIgl/A6GG9l5gtg30e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk9PjmnJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d7b50815so50331175e9.2;
        Tue, 17 Jun 2025 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175713; x=1750780513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT9LTxXRsAvFMMm/rUTVAJh+ZpJa8uGFFOblzL9irwo=;
        b=Zk9PjmnJUuZwUjAUQ+lXSOf+cvvzFkT2WW3OcXG9J9VBI1E3ma4OYyv9RnV82csl/7
         SN1HvPbSUO2ggKGqTxRzdRZ7WBXSwzJ0+8jMchQg019gfb8fUWwlJ97ZZWtCXgZAIyaa
         JriQykskH47fpofL7uEwwpL02isvFdJZuLVTatXA8bk2v0H4iJyyD1e9i8sb+9KASSV5
         S5rh7gzwlju+4S2weXWO/T/n76PeHhDhaKXQXls+ki57Zr4j0fj5hQ1QDJqwcZl//VSf
         DwCelb+mzQLc0J0oULZBjcl0qUHsf8KIyRaDvKktkCqzZb69qMe1mhJkrmfo1ue1U498
         iTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175713; x=1750780513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT9LTxXRsAvFMMm/rUTVAJh+ZpJa8uGFFOblzL9irwo=;
        b=xOKnjYDe+xQ+VQdFA5KjVvuUQrP9vSAhxvFM40hFIkmmywY3HMkK+UatK12WYaY3b4
         OkUPn6iXaebGwDEZ8Q/tx5dfi3C8QUMWDZNigEoEhdJtJlAhUTfuHJycfX94ht7cW158
         qAF/Vd1vZe2QMSGsWgBVjVB1/NBKHfiivGP9/03WCnRbfekV4Bq8Kk/u8QiwpFnkIbT6
         67/GqIPffTM3HeSZPp0ObqmnTPqv9tTfcRJrOZgNEY9gYMTc1i3eieL0gd1N0T6LFlOF
         QZrDI4n0u3S9J775JJOtpG0PCv//E11k+uaoyyvlxkROWw4eEG9dsZMpZYwNGwFejXzC
         AFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzTnP/r/PEpnl3xsrj/U37pYX7o0xwShHomAKTCRgqoOIyIUcLZHIRff9npg6dl/bfBts=@vger.kernel.org, AJvYcCXn9rvKPcfy/tOQtas0+a0EE2ETYmSGFRLPKQSpFtl7wfEurHvHqJJrx9K9K8LWJygdsxNZwTaExr/bEoQI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZJi+9oqUVBQmO5JjgH+NvoRNOYosAq8KADmcrEm9zyg41CVy
	Wec1vuGczHA7F3Io4Zp4qOcknlwDlG5eyoRnahsztcm/hBB0jIj/PJ5YUdSTfvSigQN+5VneyJZ
	i1+13CEevTP7A5P7wp8on81p+209ABHc=
X-Gm-Gg: ASbGnctHERm1y59nrAdYvgKbszxceI1saOPSPHcsvbJFbx+Rl3RR2mpCDCEUUft8Uig
	rBPGlPklOeZDiQmLszxFTU5uFIbFMOSopCv+s9n6kiEbd7yO7qJ2dJqUIcX56d3usXMiQJcVEGq
	tutL+6HvkT2QYH1uAZ7iqzzjf/1w3frFtKgOw7ja3b+ekUFfRK0fa+a0NLpTvghO/8sgdHFg==
X-Google-Smtp-Source: AGHT+IF6loupEqjpkVoCPngFmIidvYe1fOTHJr4ZZlPwfgyxgdy4K9J73YY9qX/1LHgXt7eEFFKPM9xetfTxt+TpbGk=
X-Received: by 2002:a05:600c:3f0c:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-4533cb3be4bmr141812455e9.17.1750175713255; Tue, 17 Jun 2025
 08:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
In-Reply-To: <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 08:55:02 -0700
X-Gm-Features: AX0GCFuGWDZ5CEkf-fL4zF2NILLUkNtwwrauBu-BssEi-zQPHDI4c5GBqJQAG7s
Message-ID: <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Matt Fleming <matt@readmodwrite.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:43=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Mon, Jun 16, 2025 at 4:51=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Jun 16, 2025 at 2:55=E2=80=AFAM Matt Fleming <matt@readmodwrite=
.com> wrote:
> > >
> > > From: Matt Fleming <mfleming@cloudflare.com>
> > >
> > > Calls to kfree() in trie_free() can be expensive for KASAN-enabled
> > > kernels. This can cause soft lockup warnings when traversing large ma=
ps,
> >
> > I think this could also happen to KASAN-disabled kernels, so the commit=
 log
> > is a bit misleading.
>
> This issue can definitely affect KASAN-disabled kernels.
>
> I mentioned KASAN to give context and explain why I saw this and
> nobody else seems to have reported it. I'm happy to reword this part
> of the commit message if needed but I still think it should mention
> KASAN somewhere because that's the reason I discovered it.

kfree is so slow that it triggers softlock up ?

> soft lockup - CPU#41 stuck for 76s

How many elements are in the trie that it takes 76 seconds??

I feel the issue is different.
It seems the trie_free() algorithm doesn't scale.
Pls share a full reproducer.

pw-bot: cr

