Return-Path: <bpf+bounces-37969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AAA95D57A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A8A1C22571
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152FA136982;
	Fri, 23 Aug 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clVQMXmV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD18F6B;
	Fri, 23 Aug 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438888; cv=none; b=PumeXJISjSAtByOt1CpSQ3o5My/N7BqXn8HciZMSwrhzCM20ePF0K9s+ASLW2wDwkScww48+/wlPfX4XWGIQR6ZajHxyJE6ANW+e4BJ/G7eUDJDTV3cqzflhyK0BlQAtRy3TPvLkVKBs4x6Xe+5B/si7/FFFCe0SGlHpu6F4Rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438888; c=relaxed/simple;
	bh=POw5n4uPK+5Wgj6bZ8E7UNaTIEwC7nnmx+EmsVvH934=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj75PVCELCyH1/9f3JOqLIqIIH+cZF+uurkY+e96absUUNcCnckdFgM78Kz7u7Bi1SSoWFQVxkffuppUhv95VVUnoJ9sOiHUcWGw6FlkEOo1kd2sPfL0UM44jemdhI1jHjr7LA5tXz8qKY4tr8XeYGiLpRJL4HDVB9TiOZOXuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clVQMXmV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7143c9e68a3so112039b3a.0;
        Fri, 23 Aug 2024 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724438885; x=1725043685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk0/C1AkOx81lEeJcP/sdwvaYycc+SWwymWZxuohJG4=;
        b=clVQMXmV5vVjU+NC2+gMp76TTA3xN3S2+dCJhnfgBJAqtjdreG0od8yayRxFNBXZfD
         kvON9+HlfxUuaO34sYDEwlBBRZOofA01VKt9aHbywNGfUdeItjhUObzylYxOQeRIRecI
         MjVsrHrVpTHsUO5f6wbTqS0JwdU8C3PPjIMHh4Ea+IMPqocFFWN9gVRcMhvLMF7a9Y0h
         RcH++ovff7XWtxDHjiH6Y5QM58aKF51I8ex0Xi2pZo7MDFjfLQspFpwEtSt0wWGOalsC
         crzd31/rtXjdIam8XoVOfsXzQx7nUeD2gEAapmSZ7AUEDUJDsAYAq+EymCPioq1F7N8A
         LOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724438885; x=1725043685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uk0/C1AkOx81lEeJcP/sdwvaYycc+SWwymWZxuohJG4=;
        b=EfVj6PA007KAB4u2hJudTYTjPCj/f6p61IEDmFtoNQ5Nfuvof5v46uFqJdjv2w64BX
         i45agn3n4VJldXNykpUDUk/svUnqsapaflXytxsgqBGmN+bh3s8DlTs5ox0I6dcJoCoV
         WJYgktch/XhlSbp7dRtYO1n8xnoHSRCiBTxYLXrug9XrKYOF54m4MiRTICfQJ53Bg5ym
         U6nYblZr74nIkKCXGzPCB6vkRLeIO67a7LOJ/sy0FozXhlc75RoNAArSjfdhGg5uNeY2
         kJvj65kLCFxbDn1L9iXU2eXtTP9Fo1Rs0Z3eSk8gCdNEuSQrdCoHoiKNCkCWEn/j1CRY
         tkDw==
X-Forwarded-Encrypted: i=1; AJvYcCVO1IF4MK0/7C2C7mcPzc2wmmQIgM2XraJRXpIXy8jos9cj5IPKnienBtlArvoQGo8Yzh1YImwMyOiuAgj3@vger.kernel.org, AJvYcCVPpsOsuhu2yevFIdKrhTc4H/QQdHG8p+4GZMqULw4vhG+zW2BW4Nqqm8LDtrKExXWaNl1JZGsu3uWFrlux@vger.kernel.org, AJvYcCVpiVvYZXmUpoDMpQCS9cl1p0ttOtVELKHYod+S5ilpbIwvxbbwp6R1lGcTbPRiAPFfrho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRsblVJmbKbPq4dBFv9+PT9UDlVXLSZHBO+9Tp03J6iO9XQ0L
	vL3Q1qZdbClSV2rll/4E1QriFmUhLVUf0PrtQb4z+Fyun8pvg88Ju/Q5d2E77CMPFg3XNZoL6qh
	0TbMkcOvOx4V3MJnIYI2qzygmqVQ=
X-Google-Smtp-Source: AGHT+IHU1bqef0K7taMb7NU7AZLtkpaTLnqF/hx5h78WBNReGSNhGIsYsg5UQYCcuDeEKg1DlAP70nhcV8uXO1TKuAc=
X-Received: by 2002:a05:6a20:1589:b0:1c6:ecf5:4418 with SMTP id
 adf61e73a8af0-1cc8a01c07bmr2328000637.4.1724438885555; Fri, 23 Aug 2024
 11:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728125527.690726-1-ojeda@kernel.org> <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
 <ZsiV0V5-UYFGkxPE@bergen>
In-Reply-To: <ZsiV0V5-UYFGkxPE@bergen>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Aug 2024 20:47:53 +0200
Message-ID: <CANiq72khCDjCVbU=t+vpR+EfJucNBpYhZkW2VVjnXbD9S77C0A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:00=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> Do we have to catch all possibilities?  Then, what about this:

Something like that sounds good to me too -- we do something similar
in `rust_is_available.sh`. We also have a `1` in the beginning of
(most of) the `sed` commands there to check only the first line.

I guess it depends on whether Masahiro thinks the extra
checks/complexity is worth it. Here I was aiming to catch the case he
reported, i.e. non-successful programs.

Cheers,
Miguel

