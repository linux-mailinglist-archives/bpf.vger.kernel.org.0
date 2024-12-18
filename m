Return-Path: <bpf+bounces-47206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F79F6143
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D3B188E118
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC9193077;
	Wed, 18 Dec 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IxgdND3l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2115B13D
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513548; cv=none; b=cfF10ocEltS77jDt+923v7r4qvCcws/unhZxd0G43W5Z6vCXBmgZm7mkDw1Dst0rsn1tglfHKK6NkYMUjKeF6w4KVwomzMFnf+JDdxiNhHyVgHE5gYEQqz9fGKnX7C6LUnWNpJi3rG3WG74rgjoxtMAu7IwKsfKaDqgk97XKVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513548; c=relaxed/simple;
	bh=QJz8k1Kjw+oae3Kp3XGV2LOzijTPJvtEsjZywKvJY4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2LHyTqp8RBlNIhczm6Hk/ORGGl3zalsuFuPYOIaRUykrHQ1I+YNZ2SLI2EvWhuGFxlWFXdwl1RY+DTYuQ/N1EAHzIXcsi9O+Qv6tqg2TPQvsrJGU3mD5a1jzLtarim/nTsEtWfdoF2fWHlHoy7t6yfXm86GQL0t0sg/NyY/WUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IxgdND3l; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso74800341fa.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1734513544; x=1735118344; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mankhUwSowYBB2Cznf0cWVw0fwDxI8T4dZEgqrd2fBo=;
        b=IxgdND3lkPenVfLPkXLpAvLxeWMfsjzFV0ZVdMw2S0mi9HjxnUB1iErjZhKYmpkhi9
         ixOo/9Cp/pI4MUYgkCrHldkqmKQ2Sq/pZqJrAMIxMOh7CiPgCdxENFskYhSHtsYKIlXR
         NttTnLeV0teJ4OyFwJVPwZoHTNBA4AWyCWLmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513544; x=1735118344;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mankhUwSowYBB2Cznf0cWVw0fwDxI8T4dZEgqrd2fBo=;
        b=eKQaSKQke77MAOu27LLo93eg3KpvQ0ApgZdh0IYbb3r988NfV969m+fVJWkuW5gBnS
         QJp+5hP/afTId9RhfJm9iEfPuSDwqYFh37cj4laxtNgEQ9+A6t5GYdo6h2zwAtGCQd8A
         t/a4hOtUQzUJyFUKXLDHziW+UAtdCg7OhpHmKhasPWACW89PSgtbsma2lss6L8tV0sCd
         KFFHLvsClti7xGm1z5l5yqAJz7AgyWI/HSQW/gx4QESjEUZIeIM/rSE3oMvFMjSOT+o/
         QuA6pft5ixZJ4xBu1LoUQcCGBdZZAj8dJdlfIfLZeBcmKsW01lxFfptxOX2sw/qadRsn
         SgfA==
X-Forwarded-Encrypted: i=1; AJvYcCUIRAzikIy0PI+kt7xKZqWGmzJjwhvBP70F3bkB20xg5Tpw0FPoU10noDTVueS40m303jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQEiFcsJN2ljbw3pfJse0uqIqV+sBZnAf8O2/k7qp0wD0NHb9
	Id83xAgC5qGAAvGj9Wi/YeIuDtwGRD4EUVsUBMWE8sHBY4n9bctCZ02qTBmEanyvYwcedD0l/eJ
	vHUMhvQ==
X-Gm-Gg: ASbGncvdN65fIMqWwnh1PJ8neDDA1Hh6kW21TzxzLbAIK8MWKFMuxEjZT/e9ca1mIcl
	k3i4xWjDWMuJc0v37JUXQwTfU4PCpGn1rms6+I941W7YPbwaxUvy1QQMST7NoB6SWqtC3MRiTWJ
	32C7ZAfesOfTvgoHo0//wh9rmzzOwDDqDnzWSYRm9y+z+AfFu7GytwKYjLVhK2xCUfMr97URK+7
	Pr9BLPJtFXfg0bADCYXIbneBCftZXTdjbzGhccyLx7MaK2B4TV1rTudSw==
X-Google-Smtp-Source: AGHT+IF/W8rsS5/PLFAoP7mr1xrLrsYtpxrq9gVAvqoHiKZLa1EVgIGlz7KwfJBKOw5B3CwpQTp94Q==
X-Received: by 2002:a2e:a9a7:0:b0:300:1d45:871f with SMTP id 38308e7fff4ca-3044da69776mr7071541fa.5.1734513544366;
        Wed, 18 Dec 2024 01:19:04 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303440450fbsm15369121fa.39.2024.12.18.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:19:04 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Florent Revest <revest@google.com>,  Steven
 Rostedt <rostedt@goodmis.org>,  LKML <linux-kernel@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: simplify number handling
In-Reply-To: <20241218013620.1679088-1-torvalds@linux-foundation.org> (Linus
	Torvalds's message of "Tue, 17 Dec 2024 17:32:09 -0800")
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
	<20241218013620.1679088-1-torvalds@linux-foundation.org>
Date: Wed, 18 Dec 2024 10:19:03 +0100
Message-ID: <871py5gxh4.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 17 2024, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Instead of dealing with all the different special types (size_t,
> unsigned char, ptrdiff_t..) just deal with the size of the integer type
> and the sign.
>
> This avoids a lot of unnecessary case statements, and the games we play
> with the value of the 'SIGN' flags value
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> NOTE! Only very lightly tested.  Also meant to be purely preparatory. 
> It might be broken. 
>
> I started doing this in the hope that the vsnprintf() core code could
> maybe be further cleaned up enough that it would actually be something
> we could use more generally and export to other users that want to
> basically do the printk format handling. 
>
> The code is *not* there yet, though. Small steps.
>

> +/* Turn a 1/2/4-byte value into a 64-bit one with sign handling */
> +static unsigned long long get_num(unsigned int val, struct printf_spec spec)
> +{
> +	unsigned int shift = 32 - spec.type*8;
> +
> +	val <<= shift;
> +	if (!(spec.flags & SIGN))
> +		return val >> shift;
> +	return (int)val >> shift;
> +}
> +

I think this needs to be a little more explicit that it's not just about
handling sign extension, but also truncation to the desired
width. Otherwise somebody will wonder why this isn't

  if (!(spec.flags & SIGN))
    return val;
  return (int)(val << shift) >> shift;

[with the latter line duplicating our sign_extend32 helper].

The rest looks good.

Rasmus

