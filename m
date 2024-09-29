Return-Path: <bpf+bounces-40513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B339896B2
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583B9B2143C
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08943155;
	Sun, 29 Sep 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtGqsHxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D842052;
	Sun, 29 Sep 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632629; cv=none; b=GW1909V0oa65eO8UJtYfg2iNrnsS3Xvx+mN9NEVB4PUMfJ7HygppYWHAZotLz0VYgwX/B06koyshGt4FoJFXucoWnM+Ro78UPn3IJSg3yF6d8/dJ0pa25iCUjHGSBUHeFAWJgv7l99KK2R3HlRkmGVSfAqfX9zN8IN2wCjmPZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632629; c=relaxed/simple;
	bh=iWgTGifBakNI41kLE4UIYfM/KM6Ekd3osCDXkifEj6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ges9ZwgydKWNUOXZ3kYsVh/a2gL8Qd3/HrDvPWhzB8xdyaB0ucAvtvRsBRsFHA1b1lxVT3oX5RE7H/lOE/inmlgPVzuXX1WK4h9b4LlrNMN86lc+1y0VQhuI8tmv3ZWmz5JL+4PfgR9M54NHqplbglRqtbe0DVCMkSO/tAvqUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtGqsHxH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso577637366b.1;
        Sun, 29 Sep 2024 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727632626; x=1728237426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+E7BYwg3MBBSzwH1rru8pxpa3+5KQwtjCo/BuFfYDE=;
        b=HtGqsHxHatqs8UCrODVmk66/Z2OtQtRXaG3YbvPRxlNmWLWVIsDpizYjJTg9eV0uAV
         NsilJx7n1u4oJ6H4wer2/gfWBiY9T5zIcenJAUXKFdPMxuBgFN4WESp8pfNWMaay2bJ4
         HX7grDVWVsTBAytaQDxjjNvbTiqYZk/fnUQdueGhIckzwQZTS3nfn3zLKR7wAqvAVv13
         41qrOR0Yy9se02OICD81sEX7c4Y7ky5BgAFacv+YR5JAP4XDnv+dKtFt9/TFF1dOPRJi
         r+BacLleZJ1d4BDeSS89KW5bFHRSK0rmA4b+c2M5IBFOPNfAbhK8Epfu89MW32iJe8/m
         n9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632626; x=1728237426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+E7BYwg3MBBSzwH1rru8pxpa3+5KQwtjCo/BuFfYDE=;
        b=HHs2AYDeQO/Oy5yPFgBWMwjThwMGMxg0uPVC9FzX6eLe1j2lC5W+fNCXnBKXhDHLHr
         tiIt3LXku+Gjhep8v7p3FKWBprLzJINL6Olsa8D9QdCrrI8TFqBBjUqDhjvt0aEOfoXK
         sElRe8GYcXpIm2TlCV7gcvdZr36yKnfv7tlSOSHeeCewFvpdiIdYrB9ndUULLOQmhJca
         uPO2Kt5UT9b96v19ke7s/5Wrz5CJDAa8fB8Ngkl0Q0YF96LYsGQXqBrTaLz/aoak0Kyp
         oNCC3kuPl7TwLSdOu6dIU6OzbQHHyQjWkbwSoI6J25OiZfH9hT+dAKlZHLYR20KD2vCZ
         BjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1B5CCyX8j0JiwNy6PT9rdgEtNRlW8DsMCRFHdN09BwEWEfQ+1IWaDPvU2w57olp1jUXmQ6Vkt@vger.kernel.org, AJvYcCVuucgCt+3wEmlDjdYHswlqFkkZ0ItxYpyAI4l4IYYFvj2QEfoYZsDbjgYqcVqgZhmUCfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4C14iHRylwEiYCZw7cwtkkLQY1hQ/8WFqiSYR8lhj9Yw3Ad/Y
	oZ6lB3lzrNlKWNYIOxq67POi0U7PoFmaz+rZs/4wR64YCFSEBCNvz7PjHvVh98/qZd8UwU1y7wz
	G4IUmZagy3XMofiWfRFZFdu6AMBU9SSfN
X-Google-Smtp-Source: AGHT+IGjKDm0VGJwF86cqnzkppBYiJx+kLAPc+vhYM4MjsvaqwgOFtwlWHRBnYLE2Q3Mm5TNOQ6Y/hDzKnnlya8Azjw=
X-Received: by 2002:a17:907:36c2:b0:a86:789b:71fe with SMTP id
 a640c23a62f3a-a93c4ae8f90mr1067090966b.48.1727632625597; Sun, 29 Sep 2024
 10:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929124134.24288-1-chenyuan_fl@163.com>
In-Reply-To: <20240929124134.24288-1-chenyuan_fl@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:56:54 -0700
Message-ID: <CAADnVQJneRNysmQNy3vPrMkXUGsW3EM_papHufErKFjnGX8q3g@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix the xdp_adjust_tail sample prog issue
To: Yuan Chen <chenyuan_fl@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 5:41=E2=80=AFAM Yuan Chen <chenyuan_fl@163.com> wro=
te:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> During the xdp_adjust_tail test, probabilistic failure occurs and SKB pac=
kage
> is discarded by the kernel. After checking the issues by tracking SKB pac=
kage,
> it is identified that they were caused by checksum errors. Refer to check=
sum
> of the arch/arm64/include/asm/checksum.h for fixing.
>
> Fixes: c6ffd1ff7856 (bpf: add bpf_xdp_adjust_tail sample prog)
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  samples/bpf/xdp_adjust_tail_kern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/samples/bpf/xdp_adjust_tail_kern.c b/samples/bpf/xdp_adjust_=
tail_kern.c
> index ffdd548627f0..3543ddd62ef4 100644
> --- a/samples/bpf/xdp_adjust_tail_kern.c
> +++ b/samples/bpf/xdp_adjust_tail_kern.c
> @@ -57,7 +57,8 @@ static __always_inline void swap_mac(void *data, struct=
 ethhdr *orig_eth)
>
>  static __always_inline __u16 csum_fold_helper(__u32 csum)
>  {
> -       return ~((csum & 0xffff) + (csum >> 16));
> +       csum +=3D (csum >> 16) | (csum << 16);
> +       return ~(__sum16)(csum >> 16);
>  }

progs/xdping_kern.c is doing it differently:
static __always_inline __u16 csum_fold_helper(__wsum sum)
{
        sum =3D (sum & 0xffff) + (sum >> 16);
        return ~((sum & 0xffff) + (sum >> 16));
}

Let's make it common.

pw-bot: cr

