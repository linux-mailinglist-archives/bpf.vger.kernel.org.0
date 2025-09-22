Return-Path: <bpf+bounces-69221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A5B91A07
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FF87A801B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA1A224AF2;
	Mon, 22 Sep 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4GKRddX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9350213E9C
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550646; cv=none; b=UMBVkBjHZvx/StOg6YbNgf9FBnvtw3tryjowKJ64CMThT4w7Ca9HNN2gMCTN9igxo9iDHLPAUB3Uq4Emy0jq2y6DPbYyc8LPp8ySpn7W+dw26Z3Tb+SzZ7ZisL1xsWKZyDEqv5qXzX6JcgViC3m4h6n7AZEaUhRSN5SmbiNVHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550646; c=relaxed/simple;
	bh=LXmOnMpve6GxjgBFXNKQalpJi0RKrsDhUYu4/Zoevu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eR76UsELxRc1svUZ47LV4uAtLryckYU6m24p9jhoRyVd5EgAeKVIM4mrfwJEJnvgL96mbD2ysuxtBbhhwYTZKrH+PSCuAqa3s/J4k4BXVk6roblYcuwb0wm7Q6ATAJghu+Tx+2WUW36yYBYVZJzWbtUyHaUtSKGrzwY6cjjZuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4GKRddX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8724C4CEF0
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550646;
	bh=LXmOnMpve6GxjgBFXNKQalpJi0RKrsDhUYu4/Zoevu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4GKRddXgbb/Y2rHalJ+fUK0kRKkgxELH1XdG0RDkjIG9o/PkmaDDixVLlH8X2bLf
	 e0tjzTeMQ52horO0xy3wtnCZYwQf4eqPix+F/GniFPocrbu5gu+87J8e09kszbKg7X
	 gfWlPlsHCnvNmjdz9dyATSKx2hGEBoc7c2Dr7pdITQPtKKJb4DK+r3Oawzqz3pJB0a
	 aw+1bl2apVln4iUs3Xdl84ddq3DPQ1pciSRNV+VpxEPFlt30JY83z2E9+0G0JZQ+81
	 JehMq+hjlxjYNi3wyD3LeB0b5Ni2acwKZRO0vA3/65j2vwRBIH8XseM6quAdnsvJFZ
	 U9L7jwSrckTXQ==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-81076e81a23so612580685a.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 07:17:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLnWQ/KZPAyTEPcjh+hm7sCh/2SRPV3YpFxo4lub6c6Djpst04icRItnSFNuWySdSg1fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTcr6+WEJXcfjkHLUnmegFky47Bzmc89GgN9J7JW7pVHse2CU
	CMrm4kMx6NtidPN6VfzS8pn7n9X/3Mt19BVzbvQR6IFXwMH7OGd98yPsBt+AS5wXQ7szeduitlk
	fUJTX0lyHiXqFMe7dMw4rSgc3V9zh0fw=
X-Google-Smtp-Source: AGHT+IHXXVlQy19IGcMdH/qTYJF9S+WnglG7aaMckm8xjDbblJy1XNpne1jnd703XLZA3yJmkKNQErw24+OBt8OsEtk=
X-Received: by 2002:a05:620a:5642:b0:7f8:d5ac:3bc8 with SMTP id
 af79cd13be357-83ba438b455mr1120199085a.28.1758550645799; Mon, 22 Sep 2025
 07:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922082241.2204-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20250922082241.2204-1-liujing@cmss.chinamobile.com>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Sep 2025 16:17:14 +0200
X-Gmail-Original-Message-ID: <CAPhsuW7gg-hdOSrUZpQHoVUgZs3Uj+cXt7CmXpKgoTWSTDgRog@mail.gmail.com>
X-Gm-Features: AS18NWCZrd-7acvqxQLd1HwRpkuE-l-KLC0Ib0UFejy8mQhjDP5lBMfzeQ1W_U8
Message-ID: <CAPhsuW7gg-hdOSrUZpQHoVUgZs3Uj+cXt7CmXpKgoTWSTDgRog@mail.gmail.com>
Subject: Re: [PATCH] bpf: The main function in the file tools/bpf/bpf_dbg.c
 does not call fclose() to close the opened files at the end, leading to
 issues such as memory leaks.
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A few logistics:

1. Please tag your patch with [PATCH bpf-next <version>] or
[PATCH bpf <version>] so that the CI can apply it to the right tree.
2. Please write better commit log. The subject should include "what";
while the "why" part should go to the later part of the commit log.
For example:

bpf_debug: Close opened files

Add fclose calls to the main function to openeed files, so that we
do not memory leak.

On Mon, Sep 22, 2025 at 10:22=E2=80=AFAM liujing <liujing@cmss.chinamobile.=
com> wrote:
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

3. Please sign off with your full real name.

> ---
>  tools/bpf/bpf_dbg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
> index 00e560a17baf..ac834b6d78a8 100644
> --- a/tools/bpf/bpf_dbg.c
> +++ b/tools/bpf/bpf_dbg.c
> @@ -1388,11 +1388,18 @@ static int run_shell_loop(FILE *fin, FILE *fout)
>  int main(int argc, char **argv)
>  {
>         FILE *fin =3D NULL, *fout =3D NULL;
> +       int result;
>
>         if (argc >=3D 2)
>                 fin =3D fopen(argv[1], "r");
>         if (argc >=3D 3)
>                 fout =3D fopen(argv[2], "w");
>
> -       return run_shell_loop(fin ? : stdin, fout ? : stdout);
> +       result =3D run_shell_loop(fin ? : stdin, fout ? : stdout);
> +
> +       if (fin && fin !=3D stdin)

We can simply do "if (fin)", right?

