Return-Path: <bpf+bounces-33812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CEF926A7C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AAB25F42
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452119067C;
	Wed,  3 Jul 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJZXOFWt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22319409E
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042771; cv=none; b=dWtqC4dh6p1xP6m+MeSlkqsThbI/E/7AUEpVWJob0NBYizGSi5fWf7y/rfpfkIEfUBXNFo6wXg7tXpZmPMO0ftO/t+0MX6CeF+s5o/d+Y4gtdWb99c/9MYwnsl93gc9EyCw/8xgjL2FZERDrQQN8ayqlu5yoaVy5kgJRAgOAGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042771; c=relaxed/simple;
	bh=QBq5uuzs1sqZ6c9di13jyemNH2/y67Uo5WUyeo9fDmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVNPfxRukHCyMJwY9Umxml681E1qmAHvvcto//+Yup3zn40pXdLYYH9WKEPhafb95yIsgws/4vGucts7AecDFxCxWLa3mA0zhz/lPeLW0juQTCJF5ngFEQPx0PujiqQ0mYnvw1dAcDKv84zjd/qm9GuEvX/WMZqhT6bZlzIjO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJZXOFWt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42579b60af1so35244625e9.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042768; x=1720647568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9aC7cEVU0sxTcNwGVrFtbe/DVWWSg0Yg1hDjWnU0yI=;
        b=LJZXOFWtcGWT2omwUxkoDDYHTCFBU5TweQVacFAxitKzCiYHqE3/04Hk3nw1OJZFoC
         sm/VL1ymc1bMG3yxM3/f6hm5k96/3Xn46W5Bhjct0CpGfc+cK4aUBEWIz07nlrPYBlql
         MNc3K0r31TBSsph636HGuGfG+y3F/A9afwuNlFVVWd283AzxZsgRq1ipTMeAvwXTOe+s
         kuzUNNUU21Kt02tnosHjAZ+5QM8Z1kAw+Qlx9m/b68uQEW7OVSc96KyjcbUnHzC+PdDP
         ZieedYL3QTDQPLYZniComwcTO0vX1dUS9rvnpoixp/SvBExRy9/IqTMTVIWInoLEIY5h
         b2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042768; x=1720647568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9aC7cEVU0sxTcNwGVrFtbe/DVWWSg0Yg1hDjWnU0yI=;
        b=JpIelgYZgzb4kOcpD5vBIPmZPUt1sGUFIEY/8iz6LepTmuDkpZ7P5salyiZsXRrKfs
         sAS5aD59qE7QDwLdK/2qPmQF1GtE4o0slxv/f7lT40CqiXvawaCkOo7z6yAKbYpSRPjI
         lpWnqAA75v24DoUG1PP5XvYr5QsgcqreOJL0BNBuhHS549pmxZiWd/T8eUh9A+lWrMsQ
         FhardjlFXUs7BwVIVqwBoErHPqXkqZ1voGtgpNmPgTku9ncbyWdt4J/sDWqO6WbSWSpI
         aJ/YV3xrqyjFWEsv5wq6p81IpZBndWevYK0ERNTd72WrB1pPpbNjAPfG+L5P0SI1s4PA
         JLGg==
X-Gm-Message-State: AOJu0Ywk8cVgB3AeKUMueZlct+9UT32mhfmt4NPD3pk56oEklUaqT6bL
	Il9VlFvS/MZAhTiQNZbvXbCAMEVk6h4I+pWteUuzggBUOWycTZuYHvCWFbZMf4hB9MZXN9SqYzl
	MepNPQEYG22gBIbTfl21SLiDkXa0=
X-Google-Smtp-Source: AGHT+IFjAl2t9CEv88driALnvJ8YuCumLbJvbkIhAlokxD+PQI/Ft2VvV5VNadEFtRsqTjndOw9hc4zK+O+lr8eaHps=
X-Received: by 2002:adf:f5c6:0:b0:367:96aa:af79 with SMTP id
 ffacd0b85a97d-36796aaafb3mr1356369f8f.58.1720042767499; Wed, 03 Jul 2024
 14:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142542.179753-1-bigeasy@linutronix.de> <20240702142542.179753-2-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-2-bigeasy@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jul 2024 14:39:16 -0700
Message-ID: <CAADnVQKPLGKWT9Dx750CcR6B53cw1cW_cihQtONwBmHqrCRjDA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add casts to keep sparse quiet.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:25=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> sparse complains about wrong data types within the BPF callbacks.
> Functions like bpf_l3_csum_replace() are invoked with a specific set of
> arguments and its further usage is based on a flag. So it can not be set
> right upfront.
> There is also access to variables in struct bpf_nh_params and struct
> bpf_xfrm_state which should be __be32. The content comes directly
> from the BPF program so conversion is already right.
>
> Add __force casts for the right data type and update the members in
> struct bpf_xfrm_state and bpf_nh_params in order to keep sparse happy.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406261217.A4hdCnYa-lkp@i=
ntel.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/filter.h         |  2 +-
>  include/uapi/linux/bpf.h       |  6 +++---
>  net/core/filter.c              | 18 ++++++++++--------
>  tools/include/uapi/linux/bpf.h |  6 +++---
>  4 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 02ddcfdf94c46..15aee0143f1cf 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -728,7 +728,7 @@ struct bpf_skb_data_end {
>  struct bpf_nh_params {
>         u32 nh_family;
>         union {
> -               u32 ipv4_nh;
> +               __be32 ipv4_nh;
>                 struct in6_addr ipv6_nh;
>         };
>  };
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 25ea393cf084b..f45b03706e4e9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6290,12 +6290,12 @@ struct bpf_tunnel_key {
>   */
>  struct bpf_xfrm_state {
>         __u32 reqid;
> -       __u32 spi;      /* Stored in network byte order */
> +       __be32 spi;     /* Stored in network byte order */
>         __u16 family;
>         __u16 ext;      /* Padding, future use. */
>         union {
> -               __u32 remote_ipv4;      /* Stored in network byte order *=
/
> -               __u32 remote_ipv6[4];   /* Stored in network byte order *=
/
> +               __be32 remote_ipv4;     /* Stored in network byte order *=
/
> +               __be32 remote_ipv6[4];  /* Stored in network byte order *=
/
>         };
>  };

I don't think we should be changing uapi because of sparse.
I would ignore the warnings.
pw-bot: cr

