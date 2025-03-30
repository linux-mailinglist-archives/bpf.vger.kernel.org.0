Return-Path: <bpf+bounces-54907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E4A75CC7
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AB63A8E51
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694F1DC98C;
	Sun, 30 Mar 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSoiSl3s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1F322E;
	Sun, 30 Mar 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371380; cv=none; b=nbhVv7vPYnngMO1QDU7Cp92spUCgyZVL+5exA8K6WTkltDZRtVm9gi85GkvgS2NxoDegtTtEqG0OH31DMioD+PE0SL0R/lp6szEqd8cD42v/5iB5pgKUBlR/tDOJz5WXd1KHq1QVjhnUIWrF2Zn+AyMMGwpPsyzaxqBIa48MJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371380; c=relaxed/simple;
	bh=89owqkNig/chtb1qbvXIS/wFn0LF4Vem9rBrdDWcVQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8PZ1OUGztwJmbhxIBofAhvKFO6Ne4ueRLAlFqpcg43mtrPi1x/nmCqk5G6n8oC28Ogh+f61n4t+SruxUtHmM7p4auqHOWYknIWyhcNJAS+MAi3JeO8GaxFMdV8BEQuQD23v1s4SVFwvpYLHeimq3MbuLeIClDh+lq5geghivbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSoiSl3s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2871149f8f.0;
        Sun, 30 Mar 2025 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743371377; x=1743976177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89owqkNig/chtb1qbvXIS/wFn0LF4Vem9rBrdDWcVQc=;
        b=SSoiSl3s0qtJIhX5Nz67nDKc4GnMTQyutv0hSsGDrgxqBJiN33EUdUz3PdcQ+bLiIl
         tTo/yr4kZxvgGmHYSvRL++Nsn3bKQUsH2lIVoK4Kg3DzLcO3F6IBTLCvzB+CQhGiKTb6
         8CbLK2+DLRejqGwX0XQ3iibAwxdoh4pGcvQECyaglfOxJu1TDoCb+mLn66B6cS2ZspQf
         zn1LhjFPspaULKuKsykn/GcqA5KG3SY6FQDl566N2v+5TLijw62HscEWoJGUMl55drDm
         3Q236Q5a/dh8oqoaLySQlQhO8etVGmQeC/RFwS17ivrco/J9UbnpHPR/UkDM5moEMwMR
         Nrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743371377; x=1743976177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89owqkNig/chtb1qbvXIS/wFn0LF4Vem9rBrdDWcVQc=;
        b=tFUJoxhGCOTmfCG+9Q2DCLRWQK7CQOGM73DsGSXIJcx819Xv2aDpjoFvWRLHLUSQfS
         VMVbk0a3PaEpc2ROH7DRCnTpY697WHj1HWdJbN31QBHpUAD3jpiHiNbYW+eT2wPrAR7G
         kEuAsZLL05OhTihjT5CMZQxcyes/6mDZV00LQtLDGjRbDorlFE4CwFJhL+EGzf/7KNrI
         n9scTbG3n+mkDXaERNoH5af2kLE1tjCMAX057vPamNk7Aca6OYZrHgONttPdfvnc0Th2
         oxXoGnY0keRwvYImTcfvKl9FhpGFcEI2J9xikU12NuCkI6iyQzVm8VFsf3ly8405Zt24
         5+uA==
X-Forwarded-Encrypted: i=1; AJvYcCWjj5SKhARuL7g4xqRhAY+cvhjLh56cxtt++b66UDEpogBBaRejwz87ujkXVAWgeavaIkOoTQLIfplybUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RVlrpckS8vgZQuuO0/mDyrVpfmqpojgovvJC412K3g79l5uu
	cdVUX7t1z44Ljah5yI3kyqKeG33VS1KL3/wzDgTRkczspEyBOfYaMeWqCJZlWM9NSZqzMa3qo2C
	r+xq8Kh3JzFunw4FKP+VjniKIMDDShcvg
X-Gm-Gg: ASbGncsknFcCS8fL0EPePlphnSaeUPDg/xa4+VdhFjmc5eMJpfvktw4DYioYkQ+sCPa
	zSNZiq+vgm082fcrf3DD7rtl4ULz320PQL6QgSSnzRHbOdfnBBAn6jCZIHzgQ8Q1tK9fWb293QD
	JDofApzbZ2/WGV/pp/yooJOVE0JFT5leUw43k9wTyhCg==
X-Google-Smtp-Source: AGHT+IEj5nVSpMEmpyscOMP8aBK71ZOCtpa6uRa277a20hDE37jwD6gF+LXfZmgu1gjRnSxec3eIglQ/Ysy3hK0lsJs=
X-Received: by 2002:a5d:5983:0:b0:390:ebae:6c18 with SMTP id
 ffacd0b85a97d-39c120db794mr4805640f8f.12.1743371376647; Sun, 30 Mar 2025
 14:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com> <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
In-Reply-To: <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Mar 2025 14:49:25 -0700
X-Gm-Features: AQ5f1JpJScHiZxdaUdxrBAEAm56iBd_dKXIKv3TysCy4nSIInWB0LPwUwOK27nI
Message-ID: <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 1:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I do think that the lock name needs fixing.
>
> "localtry_lock_t" is not a good name, and spreading that odd
> "localtry" into the actual (non-try) locking functions makes the
> naming actively insane.
>
> If the *only* operation you could do on the lock was "trylock", then
> "localtry" would be fine. Then the lock literally is a "only try"
> thing. But as it is, the naming now ends up actively broken.
>
> Honestly, the lock name should probably reflect the fact that it can
> be used from any context (with a "trylock"), not about the trylock
> part itself.
>
> So maybe "nmisafe_local_lock_t" or something in that vein?
>
> Please fix this up, There aren't *that* many users of
> "localtry_xyzzy", let's get this fixed before there are more of them.

Ok. Agree with the reasoning that the name doesn't quite fit.

nmisafe_local_lock_t name works for me,
though nmisafe_local_lock_irqsave() is a bit verbose.

Don't have better name suggestions at the moment.

Sebastian, Vlastimil,
what do you prefer ?

