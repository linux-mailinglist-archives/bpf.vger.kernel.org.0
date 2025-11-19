Return-Path: <bpf+bounces-75033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FAC6C867
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8617734E892
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFE2C3769;
	Wed, 19 Nov 2025 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bGycDVf+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F07221DB9
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521816; cv=none; b=Zov74q6cyJX/mCrkea7gGZWzuanImS+I3zztpA6UF0wruQABT/fxC89KAQryrQfrg97Wv9PGCea+XR+W5acu6lJc58lpGADBhv+AAXYol6k4Vq5E1cZh6Q/WJL0lcDpQVpS9wWpZAd7RvgqAmSPdj2jw2ITvgs8XwTF4EWVf4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521816; c=relaxed/simple;
	bh=68APKa9GlwtzRJX5iUtVJTi8dtri1nANgnJn/bvUutI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC3tndkFWt6uvfKcyNSxct6RitNPb6Itl23EtQPmiLYLi+jG4OImzRF/YAJ+KsUKAzvsqi9va4e8m3T+Gh6jzjv4fEZPZ9v354uDEoHZxmBWVSRIwJnkLAogEWwtvVWytwKfiOvNUmwjfz5Iw2mDhm8z5jE8G8Dnq4bVCcwP/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bGycDVf+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b97e59520so42428051fa.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763521812; x=1764126612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2YghkojSSpevvv9N/FPojo07MSL6tIdS5NFPr/1Qtk=;
        b=bGycDVf+S2KpLGKFGK1l+3DgXbILSDFu0HQWI+0ZHyMS6ahNIeQO9vLoGXVhIBonku
         zlP2S4IoH/aybfeafH0yz8/yv5Sc84EMr7osHCHRpHgQLOyfuPdfRBoyL8aOT5jMwcwo
         gNOhehI7bSjW7l0/uSwhD0EogZuMFDkGHdTWaLy80PxGBwWTBvySTCOOixmF7qTqoeNe
         Ga9ql2d7nSfXntqiwOF1uFflWtW07XMet7WSqNeqLUPeztJFtEE/laUvg1yGd2T4VQ9g
         ecZ8sVchhWF3zPJPH2tagkuZ+6WDUQrM9QFw1JLUX/Zxod+Sq2RVXi8UdMlbk7EgVjxQ
         Ug/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763521812; x=1764126612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2YghkojSSpevvv9N/FPojo07MSL6tIdS5NFPr/1Qtk=;
        b=VHjiBqGD/8X2QEQw6pHWYgMbzGO47RUh4nV98VPPtFh0rbBnmXAGONVMHIyJrXKv74
         rL4S4cBwPSsOManhDXXkyhB0AeBVwPmQIgBAvfyuytA9hgSVVKWABwCbEBgsAWNiIF3/
         gAb/Sp8D9I3gpH+2Taa89kpO0QsIhfQuhHugg2JJwWGGsCvF0dMUDQjYDHmlMrIWYt9v
         h9bSENtMX/x5fJ2wHuQzXlc1oXfw2NrDZNoqsU/NfylvHqI0Dybm95S8MpZElpOYk7b/
         YnYmDNylPk0nlqjteJwF1OSYDNK281nd+bY2M5NSzAlEqh7VcUCsTaDyM/Y9K6YAZFUI
         v5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIqLkDrpwK9IeWN/rqreO+x5rpGRGYqt3muR/xLcVgGcOzDP/6BQQWZPVxyQ7/0TYguiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVxPEEM4iQ5MHYp+bwiaAFKmFxbWLxy2scCdHutzjt2Dnj6jC
	x2Ld3L/lBHCEdZ/DtHVSN0OQ0zD/mqTwgKn2CRkX0iEnIxN27nT6L+s20AliCejnNOszTjGAiHu
	pPUW4QH2oXeDJD5tfX19Ox+gy+LfQWjLS3YATSDtkWQ==
X-Gm-Gg: ASbGncu5jDY7ybp8wEc3yjMQcMtpty2qtJ9sI8VSOIy3Gi94E/q46dJRnI2hbO0f/Jh
	Oo21EygGhydcPMDO/04aA3yAshywYlkTc2WI8TXWmkp3nVfSe+O2DypVfaShxDY+JM0tvvoG8mH
	i+HJx53QJdivaJYUDBSHtzD3JjHY1XmL9QChn6EqUnI9xCkIx066Z5cUl7lIuBlMxB4JkMjM/Lx
	/R+bur/uMH0yQCNEthnxF0n66/2L6/3AZx1U1j3uAJZLjp+XLSq85T4Hv9oyEh8B7c3xB2Iui2Q
	KWYExgjL9x3QfwzcwHvsXRzjCkhRwG0k6xqREb8ggKPlfQW0C1E=
X-Google-Smtp-Source: AGHT+IHMfGHXG2CYSD+9mEa3R6HmQrws78pTq2FdPwawAY9UdcuMW4+8J5YqjKlFwTC664TQ0iqCfNsOnK8j4YPxHfc=
X-Received: by 2002:a05:6512:61cb:10b0:595:91dc:7289 with SMTP id
 2adb3069b0e04-59591dc7516mr2637749e87.9.1763521812320; Tue, 18 Nov 2025
 19:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115225550.1086693-1-hoyeon.lee@suse.com> <20251115225550.1086693-2-hoyeon.lee@suse.com>
 <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
In-Reply-To: <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Wed, 19 Nov 2025 12:09:38 +0900
X-Gm-Features: AWmQ_bnkvj7-3fT807_E8LeNQCflok9rVCdhBURRRkQZwi9Cgcuqb5hVKaJ_Sr8
Message-ID: <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:12=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 11/15/25 2:55 PM, Hoyeon Lee wrote:
>
> >   struct tuple {
> >       int family;
>
> The "family" is not needed either. Just use the ss_family from src or
> dst. The 'struct tuple' can be removed also?
>
> I'm on the fence about whether this "struct sockaddr_storage" change is
> worth the code churn. Are patch 1 and 2 the only tests that need this
> change?
>

Thanks for the feedback.

Yes, patches 1 and 2 are the only tests that use a custom address/port
representation. These are the last remaining cases, and no further
changes are needed elsewhere. The code churn is fully contained within
these two patches.

For the =E2=80=9Cfamily=E2=80=9D field, agreed. ss_family is sufficient, an=
d the tuple
wrapper can be removed. If you're okay with that direction, I can drop
the family field and resend patches 1 and 2 with that cleanup applied.

> Patch 3 and 4 make sense. Patch 3 and 4 are applied.
>
> Please post patch 5 as a separate patch on its own.
>

Thanks for applying patches 3 and 4. I will send patch 5 separately as
requested.

Thanks again for your time.


> > -     struct addr_port src;
> > -     struct addr_port dst;
> > +     struct sockaddr_storage src;
> > +     struct sockaddr_storage dst;
> >   };
>

