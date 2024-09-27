Return-Path: <bpf+bounces-40452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72072988CE7
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 01:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7601C208ED
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46623364BE;
	Fri, 27 Sep 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJZSyNaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD751B2522
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478852; cv=none; b=r+6N3xtUaOfc6kIR/6LE9Rnp0q/hV0Gl+y3tBbgjzhuQQ7WWWVF7iGkUMI5GeBpHNU4aSe4KIp4bDI1NxUNBgcpII5M400EiXF1t3DluLMpyWD2YXwOcFi+Flt4wimVtAd/XkaeY0gt0Oz8GtFREFgbj0wVQ570esu6IirHQIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478852; c=relaxed/simple;
	bh=Hyh2qrRV9h/A2Yj9FUJSqHQULsCjzGEFJLI2mhbdYpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeyLdCJhWKW9YE/3fbZurcCR2lU+vRNPQLFmiW90Ts31G5U7QUfJN4E7fwy0J0Epv+XM4P5DDwEuPP7XI78EUJnWacDwr5ZvSc1yTmiThpWHGLCSPUpgU+rYLoaNHUBs+Qi7VZCMPg+Uw/a5mfEsTKqe4QPrwp/vpYdVMBF9lPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJZSyNaY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so2028095a91.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727478851; x=1728083651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hyh2qrRV9h/A2Yj9FUJSqHQULsCjzGEFJLI2mhbdYpU=;
        b=iJZSyNaYHplqNXoziANahHZ9vc7O/p12YC4A3mx/JRVoQWBQhyHJjgzW1s49NjHqtn
         7+IaA8i31VXq7erq7p2n7Xm7YxRhIU+IohR2nNF9t3ZUn/cp8k+lDcJdkK4gBiHG2UqO
         2CdIBfZDN2FxymHW+ZWAjfMjX6a06ESjk7db/6skr6phbx5RhWmHb9XQyJnBkSZuZg86
         /1GMCMZZLq4i8dsl7xzm4hncB79FljgQPjE/ofreudYY5HdfJT2Iw8o6vLGRflsmVGht
         20/d2AIMXnOIhPhYgNMQ84WEWzH82FmOmi8YUN90K8LQKoF0/vWTlGN3iqxiBnYeWUPh
         CKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727478851; x=1728083651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hyh2qrRV9h/A2Yj9FUJSqHQULsCjzGEFJLI2mhbdYpU=;
        b=wOg7AB78LmZ7NGYhCUdUMOT6SuKLs/+dmhkD2E/p1XdJQPD+awvbGQXUUsBlJgs8C4
         BMCZia764rAkbGkuGIeVpRI7qbRPxw5ejZePbTv25bDtWtZpci+dmwAqZ40whcH17sZj
         Op0ZfdMZCK+jc4AWA920zx1OyYrl9Sd+vWOjz9V5BJeDT148Rt9Y0WjWmC08uyn8XC0v
         gVK9OoRRxnaQ0IGsYGEd35/sxCo4a+jeIy1rPY5TTu57GfCdP5LpGDA7J16ysH7uvj03
         ngmnmk/wvtlBJoC7DVS6F3lOn72UBnlt5WAjkjID+B43EYkMdaR/Uhh8DIhRQmyg5zMx
         UuKg==
X-Gm-Message-State: AOJu0YwS29FaMz4/xIZkbpjMYFynLTcFY1T72C01iovg1y0S5F/IhySN
	LDZKO+zVyC+Kg5BUuSyZjbXeEqnqS6w/Wv6TN1uidX344DNkjF1Z4XfFftvCKIpCRIq0lUSSEcA
	ngyfa23Jik9M5HR7QSS8Pm0vmceQ=
X-Google-Smtp-Source: AGHT+IHED4bp5KEWlE32qIwLWPPxA+i5oVJgirX1+Pnpg9E2kJEHb22D89QxK17paVTCr92uRRhCywhrTtWhvYsuUOE=
X-Received: by 2002:a17:90b:3587:b0:2d8:94d6:3499 with SMTP id
 98e67ed59e1d1-2e0b8ed4c1fmr5362395a91.37.1727478850770; Fri, 27 Sep 2024
 16:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
In-Reply-To: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 16:13:58 -0700
Message-ID: <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com>
Subject: Re: bpf_link_info: perf_event link info name_len field returning zero
To: Tyrone Wu <wudevelops@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 12:59=E2=80=AFPM Tyrone Wu <wudevelops@gmail.com> w=
rote:
>
> Hello,
>
> When retrieving bpf_link_info.perf_event kprobe/uprobe/tracepoint
> data, I noticed that the name_len field always returns 0. After some
> digging, I see that name_len is never actually populated, which
> explains the 0 value.
>
> I expected it to function similarly to
> bpf_link_info.raw_tracepoint.tp_name_len, where that field is filled
> with the length of tp_name. However, I noticed that the selftest
> explicitly asserts that name_len should be 0. I was wondering if
> someone could clarify whether it is intended for the
> bpf_link_info.perf_event name_len field to not be populated.

This sounds like a bug. It should behave consistently with the other
users of input/output string buffer size fields: on input we get
maximum buffer size, on output we should put an actual size of the
string (especially if it was truncated).

Yafang, Jiri, WDYT?

>
> I apologize if this is not the appropriate place to ask this question.
> Thank you for your time!
>

