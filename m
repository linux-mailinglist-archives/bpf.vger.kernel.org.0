Return-Path: <bpf+bounces-60938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694AADEEB4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38CD189FCA7
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF22EAB9F;
	Wed, 18 Jun 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOv45vri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4112EAB93;
	Wed, 18 Jun 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255289; cv=none; b=T4BelQy/KP15ruFxEgxyEf7dRY6ioXI5HgAd69CYcqERqyHC201FKEg5+n3A5EIS0lAG3gKqs/sgAfMp7vLGOQBlnLD74EXbyaNE15QiZbmt+Q/Js8vKaDef3zd0mJl5CJ1YcFrhyMvj6ouX/jxtWlLFU54cA1IwrI9CGI5AiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255289; c=relaxed/simple;
	bh=Z8+uBazMTiqM7163DoyZQ8O/lT8MkVC1n+uVh4mn4fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzmTPSze9yzLzaWiUa0rHB81acngKNBMzd915C49gMScXye14/l4ToHyNR+6NKUhYqpi1cyLZ2j+b0wUryi/3Gu3h/0ah5HMLf4MqnPD0yIh9TJY6NHM4Ja74gnNUe5NHacveytmWoNxJcIHjmQGL2RgCmwuDW1UqfNRqT104Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOv45vri; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a35c894313so7809312f8f.2;
        Wed, 18 Jun 2025 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750255286; x=1750860086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8+uBazMTiqM7163DoyZQ8O/lT8MkVC1n+uVh4mn4fU=;
        b=TOv45vriWRuZ1xc69rEoxsyctFzAdWUHHbG8SsovZwzu41nRHowzCLO8DUYqL7ljbU
         xQXXcJJG4YsRVbTg6wok1/0IxIAXNVjCERIqhw5VDBMsy1JozGuMPgI13P1IKekv1x/P
         PlQqG0TxEoZgsTBFqVEXsc0ByI6OVZ+8yBAZgw1yeEQfbhynoRnLlrS/8fELtlcSV0+3
         dv9CFez+kOf6RAYrEVzB646fy7mn4HX4vFd+dQW1CDv//k5N0rUzyHlRN4i7Gu4hr9CW
         cLEEXdFHDJk5i3MjcaJ2jcZY68/oQmbArSUUO9MyqsbAPFvGjCi83GkzJps8Ar0M0/uO
         Axqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255286; x=1750860086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8+uBazMTiqM7163DoyZQ8O/lT8MkVC1n+uVh4mn4fU=;
        b=mHtO5bHau3HuBEfbiQAW2LivyMliSxVcuxAXDR3mvrUKMj2vKemMZvncMznP0NXiMU
         IQRY/HP+Wjd3TeuXErAvWkFzFCKpmX+dIgZsuepU0YxcvKdVxl0DzE90PtDMP+Zc2gyN
         4+i/9oy99ZH46A4X6JIjiKa41Dk4Dlob0qx9JCM3PmsEEX/T/R1YGnhSlxZvY4jsxgiI
         9NjKkLOikW3OaaXIRuOgcU9CGV+g4U0RyW3i8NIOzKsv9IH1yFMT6K+JS2Z6Bl5yERYf
         5weiwhU6NHclHLyfCG3UfJcwHp6AuxBmGh/FxElNt7AaTny1omgR7yQIxmq5MlC4LmLf
         HP3g==
X-Forwarded-Encrypted: i=1; AJvYcCVKc/7Gp7OshgrdX5+7coDlMO2F0KInYQxL7SwpvaWdWKr/cAmPHiIzAZ61VsaHufrT/Hs=@vger.kernel.org, AJvYcCVhIf7A/LxAsnn4BKZiMu0P+s1YHK9CFD1q9uGWTYjhcTjtqFtIiZqav1pOPCaSkOlNgvHK90xAujkI5/du@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIGqdsmPE3OK8yRvgKmQA7CcbptrF58YqyuD5SWusc9BC1A73
	830F0HsQNZGsSTpDXya3ykwMl6V6lbdWOBkj9vCKF/Gwj0C//NTPheVEuELvckq1c6kH4iGC8P6
	368/cEGgQjshl71dwrcnWrtWkdYrb/RI6QA==
X-Gm-Gg: ASbGncskSx6+67agdiBA7k8OkMxSgV86hSfG8bbuVpIrgsqH/bJbHljX/RoeoIQXaJq
	Z9EU4Tud8AyAiinzjTvog2xcWyEdHuGesyfHPTG3wk0l0yUaswcg72dpR+rvi9XSZ6/CnvWJBAj
	ly1Zi21k/ArS3pEkP7LVmIF3/VPaCeo79Lw3cg+7OgEi2nfMhTALVMAHCWpVfxHrW6uXiLTs7z
X-Google-Smtp-Source: AGHT+IHDwJaTOJLspimMxjYpEaHaJDm13WmxfBmjnnwM+3kK2gKQwkuJWmgeVRSP53PAPrwR0SkhxpNBbqngMUrNyBk=
X-Received: by 2002:a05:6000:4611:b0:3a4:edf6:566b with SMTP id
 ffacd0b85a97d-3a57238bb49mr11226092f8f.6.1750255285115; Wed, 18 Jun 2025
 07:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com> <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
In-Reply-To: <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 07:01:13 -0700
X-Gm-Features: Ac12FXxXhvf_V7kl11PZ94uSwcYDO_Vrxg0ADofSFPu5IU8vm1Ap6Wuv8y5gCGQ
Message-ID: <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Matt Fleming <matt@readmodwrite.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Matt Fleming <mfleming@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:29=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Tue, Jun 17, 2025 at 4:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jun 17, 2025 at 2:43=E2=80=AFAM Matt Fleming <matt@readmodwrite=
.com> wrote:
> > >
> >
> > > soft lockup - CPU#41 stuck for 76s
> >
> > How many elements are in the trie that it takes 76 seconds??
>
> We run our maps with potentially millions of entries, so it's the size
> of the map plus the fact that kfree() does more work with KASAN that
> triggers this for us.
>
> > I feel the issue is different.
> > It seems the trie_free() algorithm doesn't scale.
> > Pls share a full reproducer.
>
> Yes, the scalability of the algorithm is also an issue. Jesper (CC'd)
> had some thoughts on this.
>
> But regardless, it seems like a bad idea to have an unbounded loop
> inside the kernel that processes user-controlled data.

1M kfree should still be very fast even with kasan, lockdep, etc.
76 seconds is an algorithm problem. Address the root cause.

