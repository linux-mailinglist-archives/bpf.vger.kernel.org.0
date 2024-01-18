Return-Path: <bpf+bounces-19813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3947831927
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC99B1C2256B
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846324B3A;
	Thu, 18 Jan 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvJE7zTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0DA1D6A9
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581020; cv=none; b=D+1M+CCIj09G14HATdZLpULxmSgI2nvBhHGz/eqTifJahlI05hVY/2ZIWDfwM8z2/44OUBzRbT9Y0IEpN/Bn5VrWikzaQ4P96V+B6DpRN7cAefAOWmxv8zVIGfkF3m67CRJTwkYHM9biiZWMhu0ZQs0OYOpeFD3NVYejhBwUicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581020; c=relaxed/simple;
	bh=Tcrmt7M7f/3DITdNMCl1aOg6d5GXjZwZWHu1hFOo8aw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=DEpVaeAWtiD5IIZVJjguhzN9BcRFyg4n5K/d5RFHFhHRn0PimhKoFDElmG074bQwEJupJ073Xkg+0O6IVvGXCIhCITLtTvnGY/DYb7GQ96tqBhrRuoT2catzHUTal6qaTmO9zX//hvxRLeLyUU9Uc3zjDTjG6sXFWnB96D3sEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvJE7zTC; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so2011827276.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705581018; x=1706185818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R3S2S7QE9ok+rn+clnVOkthLLjVF8kfBt95k36VzJ0=;
        b=AvJE7zTCpSB2qd6kYM29qchOs0YTmhqo/c3iVjAvNzTBV4QxvRo8LkVZz5fY7EzUQd
         ZZq4bEdzL/X/GWS7cEXmvMQbHNP6UqBrweLcnEcBEGXyBPe6GMnNKlIw82UPKF2WtXH+
         5FAo/rKdIIDhjhiauxlRL1qNqABpa9h1fu+zbSePvKhpHUn3Cyf2iysv97OJrL783PvS
         i2YEIUNKzuho6jijbY4qQPWsXRqnDYN5Ve86mFhFxhwFygo8Ea9UNged3OER1XgCvYeX
         mUYt7Vvwj0n+I6PE8TwFGiho5/Yp2RxjlnaYQpA5AE3PXsAHLQY3e2+P00p5r1tmU9Pe
         Fz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581018; x=1706185818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R3S2S7QE9ok+rn+clnVOkthLLjVF8kfBt95k36VzJ0=;
        b=BaoNepQWjSDLeDX+iSi2NbAW9eAOOIrXz+5j0UfCKsxpJocZcwxnPcNc6iICuMv3pL
         V8Zxsg9BGTfxpoU59AQTcDvFNA8LS7AWJYq1zC3FigMszpYV71zN5dZkMLLRLNFzsn1k
         gB8/mRZeKxqdr+GDwL6TfydyVqbQMOUINEEidqyFKsIWZCpvlviPawaAPNkQZimN4kuy
         Z2pG12ISPzfu7wpTE0mWL7VTTOKoRTng21C6C4IUzWFT383oA8xuA63IHYVNvH+tGRwy
         70Un5+HzA977Qmz80H8zLVrIjYDRFtvBXaiy4mRuzQn5JPn0NCl7jRt7Zf+Mu6VA32dT
         dlog==
X-Gm-Message-State: AOJu0YzDN15mB8q8TK4rzlA2usYs0YjeJc5CJCiRwaAtGupzCwz1uE0m
	MTkittjoCt+cyZCJScOYmF2EeLGuMlYNjdYpQLSrpuIedbuGCtMrFltVgYQUbiOzTxfTmzGP1mH
	g3fdcBOAyzDVfeUqxMtcEBU/vADZbMxhYT4Q=
X-Google-Smtp-Source: AGHT+IEx9Xwg7IZk0mubeEwIjOYPPF+++jsOXLkjLaE9ev+E0WCapQsYrcuCDjqyjaGA9Ijielgu+mEaQkWBuWC5fNs=
X-Received: by 2002:a25:740a:0:b0:dc2:466a:23be with SMTP id
 p10-20020a25740a000000b00dc2466a23bemr579329ybc.126.1705581018189; Thu, 18
 Jan 2024 04:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118095416.989152-1-jolsa@kernel.org> <20240118095416.989152-4-jolsa@kernel.org>
In-Reply-To: <20240118095416.989152-4-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jan 2024 20:29:42 +0800
Message-ID: <CALOAHbAOJX01vb87FdRFC3Km7UDBVkJmDb9x1s-Yhb3hiWqfOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] bpftool: Fix wrong free call in do_show_link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:55=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The error path frees wrong array, it should be ref_ctr_offsets.
>
> Fixes: a7795698f8b6 ("bpftool: Add support to display uprobe_multi links"=
)
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  tools/bpf/bpftool/link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index cb46667a6b2e..35b6859dd7c3 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -977,7 +977,7 @@ static int do_show_link(int fd)
>                         cookies =3D calloc(count, sizeof(__u64));
>                         if (!cookies) {
>                                 p_err("mem alloc failed");
> -                               free(cookies);
> +                               free(ref_ctr_offsets);
>                                 free(offsets);
>                                 close(fd);
>                                 return -ENOMEM;
> --
> 2.43.0
>


--=20
Regards
Yafang

