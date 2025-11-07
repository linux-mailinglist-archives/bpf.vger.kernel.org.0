Return-Path: <bpf+bounces-73946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAAC3EC9B
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 08:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A54EABD4
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F530CDB5;
	Fri,  7 Nov 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+ohVcTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88030CD86
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501402; cv=none; b=FzSxzDKw/d4gUuzcEDZC5RaKOWTMIKp5JVWKnhts5D3IQb47ZTQFNRFv/uWzV78kehMN9GqfgNh+k5vGOJYwplpwuvLwbDyb5Ek1xBJnNsQNArnYQ1hyN1SgSadTBiS+E9VE/Gbj0j+SfI/kTllHh+fmRysEjylaYSx3qN4FMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501402; c=relaxed/simple;
	bh=7ZsNpfw+VKmu245YR/Xfwvnn+Ay60Eyiuih/9lQh5No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+0GeYRnos7JJ7lTFaThelXGcqRMdXoHpHtV2Z3Mslt2iazumFcb1Oivbl71B8M/SFXSSfBlruHYPm7RyaapabFV71vyQOQrn3MoNNOC6VY587biGmI7peNKnfgRo+ovw3HeGUCuC3naI03DnpBXCMPmB7p9dbVyPgZ9gHW60DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+ohVcTI; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787be077127so4839507b3.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 23:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762501400; x=1763106200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZsNpfw+VKmu245YR/Xfwvnn+Ay60Eyiuih/9lQh5No=;
        b=E+ohVcTIhBirahdRQiomUK/mG2q6XiehFJnQjLqWPoAUvJEowc3ix3P5XgY8AgZDCx
         DqPFTXwklVv15LbnuxwmIxPRml1kiiT9eL+FFd1uQkAh4PNX8Cu2N+EoZveNqQahGbnM
         kFDLzDG72HyTsm6kUJkru9lDnICmCU/POu87gnHMhobnhiA1M+TUyWwgtBr3ljw/yS1j
         nQYGhJt2McR0EFMTxefsiDCzugg1KOA4HCoEk+vhBaDIOndSG/CNdqrkGDIJybVYpVGQ
         3c5m+PMO1kXg8E0hGnyBvfSQO9ff0wlyiXbkUFh032kTsxUhSkFQKfGFl4wPkCcqWNTJ
         jQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501400; x=1763106200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZsNpfw+VKmu245YR/Xfwvnn+Ay60Eyiuih/9lQh5No=;
        b=Wsw4H3qAS+VyJMp+TvaIh/oFol3kdu/QDnmpxR5XvDZWK9WUrG9j25ZRvOEBx7hZDE
         WKoMt2jfo6KCETFWICAB94j6smvsCKR/wkQFO+wbVRk8ur3e7m5YqtlvTlYCwvhIv8AN
         b/xQeFPuxdvhTPv3FbQw2J2tWuJifv4mqeT68bF0poA0pM4p67yg1LxcgVfs8+PYojh3
         3fQg4o+I70C8Ysp4VfG7R5XjjRikEb8J8KxWTwO2CFOsGgnd4YKAaBKZiidZQcJhb5CS
         UyphRtrTgA2/4ZbgZAlxF+aCoMtCo7ilj/W9KNWgopG9fqjJGYcLV11ir8IQ/WS+/xAf
         hnsg==
X-Forwarded-Encrypted: i=1; AJvYcCUu0hjsWHgHG8Y/BxppeVozDvuTmccGCEusOcxnhVF0ExpJKhlkaag6nkAa4QCzeXKqUHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48wavp7fGXageZmJo0U/Fbg0gNCWu3uEF6QCAZtGIOO4YgEh5
	I9lncB6OM/EpViP42/b59pjZ2plnXwLrdkIXemeZCIvs7BlUE+Xut9/VN8sXRJ7B7lvqlrsUib6
	qkg2yyergmR8Jqab79cuOkZNxP619sps=
X-Gm-Gg: ASbGnctBwBhNsBn48dRWyQpXNkL3+tBQfRdyplSm2G3XgXLs86lvCVekQ3kMcMKpVoR
	JCRbTgD1OTGa8vK3Jn7QQLogB2z9gr/91NsrSksAclqjzFmBKNQhI9YpWOixvtajMqZaUPMZmc9
	DCjyRMfppmSa2fX2AoxI1cm2SNY70Hn294tSuLXl9T5VkMeOhnsAxGkaqpJtYifgA70bpUKuuA+
	ON7PY34k1M7RsZAftN5W8CoZZY7jtpF0iKhCYcrra1goyrb5ce/0yrE8d5mn+VuVkEvPuKtvrZ3
	qI+RVOw=
X-Google-Smtp-Source: AGHT+IHzzCvJB4TTdyGAp5YtiYWZqtTY28E5sItkpjCR4UfUZBouXUGWlPXwqcDeTLYMfY27SlPCSxXdaXxQqChey9U=
X-Received: by 2002:a05:690c:7085:b0:786:8331:6a14 with SMTP id
 00721157ae682-787c53024bbmr19584197b3.1.1762501400062; Thu, 06 Nov 2025
 23:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106205852.45511-1-a.safin@rosa.ru> <CALOAHbCcfszFFDuABhPHoMioT26GAXOKZzMqww0QY1wKogNm1g@mail.gmail.com>
 <afcb878e-d233-4c87-a0fc-803612c8c91f@rosa.ru>
In-Reply-To: <afcb878e-d233-4c87-a0fc-803612c8c91f@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Nov 2025 15:42:44 +0800
X-Gm-Features: AWmQ_bk7yW5jA7HGtIWEyP3vIkQefkWrKOzFO6TXK-ehNiokuss_IQS5LzihN4Q
Message-ID: <CALOAHbDYOx_BChfKuaDVuaxjWt9ixPSO_0x=LuuzNLeEXDuvFA@mail.gmail.com>
Subject: Re: [PATCH] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQsNGE0LjQvQ==?= <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 2:58=E2=80=AFPM =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=B9 =D0=A1=D0=B0=D1=84=D0=B8=D0=BD <a.safin@rosa.ru> wrote:
>
> Yes, that looks even better to me. Changing value_size to u64 at declarat=
ion
> makes the arithmetic safe everywhere and keeps the code cleaner.
>
> I agree with this version.
>
> Should I prepare a v2 patch with this modification, or will you take it
> from here?

Pls send a v2

--=20
Regards
Yafang

