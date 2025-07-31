Return-Path: <bpf+bounces-64822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85653B17537
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA074174EC1
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAD23D284;
	Thu, 31 Jul 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO1SKe+Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852E22F770;
	Thu, 31 Jul 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980433; cv=none; b=ZSGzkQdeliGRZbTvk7/8DZPWeIffSECJSQNYV9RNO7SkJbpSlWMFpJQuQUd82y2Fl6PuGcL4wmRR6KsiB8qul1caWzJfrHAuq3uV/Fipbe6baCeybGjZb8vo2yhvVYeQFO6ckrr5eGCJPsZyiGZfEDgaB4NftXb+BtocSTSb1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980433; c=relaxed/simple;
	bh=x4EPmaDswDcgZARfsoubDOpse2mC/yXs4z98zCQpGAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtikCIUD+Wllc4WyuLTxryou1+Ka5aByuluMeLO8mXOjP9t9Qql8Fp9Y0yxmjcqIOzwWPaxggiTx6oZMbjJxz4ElVY9FhfOe0gDPqEOxfexZDCSIRIdIrymgdGUXeefk/ND3F67WJNAZxRz8gim6uQryV8sd4Zw2rormPu+axQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO1SKe+Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so941986f8f.0;
        Thu, 31 Jul 2025 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753980430; x=1754585230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5bR6xZ7biKap3ECfXH+Cp/kOPb3Bhqh+JJnjDss70A=;
        b=lO1SKe+YZiAz05cOZqLxrYyFU7IjgFU/VuHaeJVD5JPtlUU234lg27jISNjBDSKr3Q
         V9uXWqfCCXh6JZuyx2GQjrsCiN/Y3j4PvjEdKNPlt1++UVl45Viq69N0H6gr2x9iJnLF
         8ys8BJQNDDLlkFb9PhbNK8yLHPIvLDy4GoF6LCs7xUj/52ALBqFY9Qtn22k/9nFKI406
         NpQZI1M1+g8PcPhApwKxePov6BCt7UQrA1HpTESrrKlfBE88GVW7fpjvDB3Od8jGNp3E
         eSNc9CnTtp33DhmIXaVDbrLzULn5IUZA1JhbmAhahI9jQ6Ty5yIcVUvXs6UfWw4xH8sh
         KdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980430; x=1754585230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5bR6xZ7biKap3ECfXH+Cp/kOPb3Bhqh+JJnjDss70A=;
        b=nl44BpT3+s1CR0aYQG0cBT/nOci06yN+fJI0j78DGm7I+/EyfsrU05lxkExiA+6T72
         Sb7cambGf5qtAPl5noc47iBHiV/XgUD+PCj/YLdRGoy5EIRg2+z1XOjpVyOACojaLzVE
         VtHjjVs6YRtDcdxzwGEMof+bQHLaiAqyycT51uHzjhRJ9vT8ODl9Jj3FZeTwqygTuLAq
         HXikJUfA3hAUakibaGxZ66XK366Ed2Kwp1jnaucC00pji0jqrDqucMbZt4eRU5Q53+2I
         223hmg4xgNfApAxJ5jpJyTbvHVak57/vsJ2SJXFCM88tI+XWGphntwnXQLVmHKMc/4M4
         /jsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3W4lEbwY/Zk377VGalZ3kAqxwcmRqHfJ8ucC2922piDwhU3a4B3djkvNvwEBz50amEs=@vger.kernel.org, AJvYcCX69WVOzGo9tyQ7UdYBOC9Xt6VZg+kl7w2+zIIHtl/gafj3OscChapqv0FBpv9t5BlLerjzr1MeC5psgxRa@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3KEVOfltH1ZztwZtyIrpYQIofhjgOwkzI5KpMr5axJWYzLlU
	5E7X55bgfUvGc6/gfEL2HlWWGvGeqQhPfCrBFROzJuJQjmBRCDI7o0eEGStGlCVRQ/0xow3/Aox
	0h+uP7YtalaMgpMFmzwT6TrkyWNA//h4=
X-Gm-Gg: ASbGnctGrWaJB7R7V6Mf8zeuo82KhxjdefK8Z0vhOQElk1sREfkta89ZeFuh6/z/Web
	nwVFrFtSw8n08HFhxpVM7mY1Eftsaariw30DTwUaLwiAT/efiAmz0wAOQF28d8Fzt54/p0sW+xF
	TTlSxl0Bv2q/aYSg0y5DrszUDZgP+oK2HVoptGa/3WM9Fb6VCOrpbAQYn2Kxs7WaXn50abjf5oI
	HXwg3W4utCQTsP6EzIkCyE=
X-Google-Smtp-Source: AGHT+IFLYxnEH1e29Nll8XRF/X7eZ+D4F26rZMtv64r1XFwRysgBfQL6GOj6dk/N7A5aGcZsG1QDMg+/hz017OsFcwE=
X-Received: by 2002:a05:6000:2288:b0:3b7:9dc1:74a5 with SMTP id
 ffacd0b85a97d-3b79dc176aamr2687256f8f.52.1753980429791; Thu, 31 Jul 2025
 09:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730185218.2343700-1-soham.bagchi@utah.edu>
In-Reply-To: <20250730185218.2343700-1-soham.bagchi@utah.edu>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 09:46:56 -0700
X-Gm-Features: Ac12FXwPK7BH6RA_BTpzDOMWzFHKuwcD1DLk-SThUxSeuFlI-ShUSyR7PxHHdAc
Message-ID: <CAADnVQJqbYN1VGoSqsHMqvMoZgTw1+PPS87zqsKhUtPgSarY1g@mail.gmail.com>
Subject: Re: [PATCH] bpf: relax acquire for consumer_pos in ringbuf_process_ring()
To: Soham Bagchi <soham.bagchi@utah.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Soham Bagchi <sohambagchi@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:53=E2=80=AFAM Soham Bagchi <soham.bagchi@utah.ed=
u> wrote:
>
> Since r->consumer_pos is modified only by the user thread
> in the given ringbuf context (and as such, it is thread-local)
> it does not require a load-acquire.
>
> Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
> ---
>  tools/lib/bpf/ringbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 9702b70da44..7753a6570cf 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -241,7 +241,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>         bool got_new_data;
>         void *sample;
>
> -       cons_pos =3D smp_load_acquire(r->consumer_pos);
> +       cons_pos =3D *r->consumer_pos;

I don't think it's correct.
See comment in __bpf_user_ringbuf_sample_release()

--
pw-bot: cr

