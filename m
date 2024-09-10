Return-Path: <bpf+bounces-39514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40F974203
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068181F26967
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE71A4B81;
	Tue, 10 Sep 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI7rK6gE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EE23774;
	Tue, 10 Sep 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992625; cv=none; b=gCBgON1MHqvLYPWw0N7v17ZPxStT33oeXMpMJh/2TPGYj9Zc0DFr+k6FYAEBIbAyldB7SPeRvz8YP/xo8IuBgm1i4C1xA1WZhdgIWKAvavBDJa4oH3V/T9J3oH1U6AkL/+cU9mp2zqWTeFUhqhGysH6529k5Gyiw4jNRSrOliIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992625; c=relaxed/simple;
	bh=HNcY4LkAQB1SIIkhaGS01KbLj4JR6W36dZtkz2doUhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jahyjcpR0NPEYE0KdwlWnZ8ubSV0EvoS6Jxb9gMH9MsoepGMznQjOMpQattlN/9cv0E6VmOeU3QHs4Q9+ttQoHuPH/bvaYyRiJm17xA7dZdhzTnF94ljORkFuawZQ0AFnwG8POGvVOqnulMAteMFhMp2ud2cxnEdP0YRq7o5LR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI7rK6gE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso4154208a12.1;
        Tue, 10 Sep 2024 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725992623; x=1726597423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qnGEy5MFT5i6y8/5hlGjFtTij7fO7GilxXGuDUHVCQ=;
        b=iI7rK6gE5LwPwc9mwhzvHM59AzaNK2c9f6otBMmsD3VB4V87C1oLDfr+S0+IZVbXMj
         DPBKR20b4PjkQo5killJ93Sk/CP1fIFhIx3RehhUDB1ob+u2vIzLZouFLnCTu0wwmwFI
         NugBeR6DqRxzX1qF49zXzkoCKj1NuU2Klkeqwtyfn4crc2DAp3N9MpVbhv2M8FAkgYo4
         CJTNnAUG/4lLVj2vGIjv9ifBDpI4IGiQLL2SSMraeAHDfPruf50YDhzH3HEV+QldpNPr
         wsPuLLnDhILAk/Mb6iDfYWaCVzMhtZ1t5OlN6VyJtx7SZm+9hFANugzBs3UQ7onxy8Mq
         wVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725992623; x=1726597423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qnGEy5MFT5i6y8/5hlGjFtTij7fO7GilxXGuDUHVCQ=;
        b=JRo1lh9nHv9LCSfhJaB6+1XpxBuD8l54/VUbRIZtAxfrp2lAaMyV4YeSNV+4RgPxgu
         nYGbA8pjcaydWzn5sVTVWP7w/PDKeIESFIaVzkpHx1d7l++BCXa17fElrBJrjDdB+QjY
         8+znhxreLaKWDUQ0OWycu/FY9AZMJnRfaH/1/gqi9/txw+7qV1S1HnEPc8q7lA+Zn/F6
         wIvM109Pmz2R1NdwMlUuQAGcLRxLlDo6dvSX8kEudCGN+v+xz3WdcbjHPnqbBfHMZu46
         Z4LOmJmuWGQlWAsLhc0gNLKT74eQE20DiriszGRJVIiaM5Bm69CYc2E0+tX/VdQxI75i
         JWxg==
X-Forwarded-Encrypted: i=1; AJvYcCWwIvh1Lj62c6F4EfXKu+xBdsobkudSRf+tQy9+SSOSqJ7PnyyqzDpDEGbKuk7ZOV3tX9nBzNHy/Pzk/nQ6HCPotn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyxTaMFSQUMg9Mf1A3xq7mH+za2xc8BGrHQkuv52VIUDMrTM7
	v+zHTjz68adnC0fagG0k0SN0pn5KgwaAOETHwstONx3H0ytlBQWQy1o1tel+pQtb65AvvgE5MbH
	lFn6CTNObHfKldMIPbS3CyhHyUhQ=
X-Google-Smtp-Source: AGHT+IGPWHSsND0wuMVJa3pl4JEbgC3N6l3OGs8DL96P+aaHAJ4NTXkAsbjIwdGTNd2O9iNe4kltmvpmPrJpNXWhU/o=
X-Received: by 2002:a17:90a:7802:b0:2d3:d8ae:67e1 with SMTP id
 98e67ed59e1d1-2dad50ed085mr14765229a91.26.1725992623272; Tue, 10 Sep 2024
 11:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
In-Reply-To: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 11:23:29 -0700
Message-ID: <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ arm ML and maintainers

On Wed, Sep 4, 2024 at 6:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hey,
>
> I just recently realized that we are still missing multi-kprobe
> support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPROBE
> seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
> implemented for ARM64.
>
> It took me a while to realize what's going on, as I roughly remembered
> (and confirmed through lore search) that Masami's original rethook
> patches had arm64-specific bits. Long story short:
>
> 0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementation"
> 83acdce68949 arm64: rethook: Add arm64 rethook implementation
>
> The patch was landed and then reverted. I found some discussion online
> and it seems like the plan was to land arch-specific bits shortly
> after bpf-next PR.
>
> But it seems like that never happened. Why?
>
> I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) all
> have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), it
> seems. How come ARM64 is the one left out?
>
> Can anyone please provide some context? And if that's just an
> oversight, can we prioritize landing this for ARM64 ASAP?
>
>   [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@linux.ibm.=
com/
>

Masami, Steven,

Does Linus have to be in CC to get any reply here? Come on, it's been
almost a full week.

Maybe ARM64 folks have some context?... And hopefully desire to see
this through so that ARM64 doesn't stick out as a lesser-supported
platform as far as tracing goes compared to loongarch, s390x, and
powerpc (which just landed rethook support, see [2]).

Note that there was already an implementation (see [1]), but for some
reason it never made it.

  [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820=
.stgit@devnote2/
  [2] https://lore.kernel.org/bpf/172562357215.467568.2172858907419105155.b=
4-ty@ellerman.id.au/

>
> -- Andrii

