Return-Path: <bpf+bounces-66682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888C2B3874B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EBA1B22FB8
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09011304BBF;
	Wed, 27 Aug 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETvhn5Em"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66431FCF7C;
	Wed, 27 Aug 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310722; cv=none; b=kJqSLjvtf0j4LMEfYlsvriFskP1/Sm0X7+6amszTXNezea2PWAL3Zpp9vEN1hGcpA88Tn6KB4r8WppV9ePEa0BO9GX/DwhZe/32lMloTSPbj8wu9DadII8OoDBoDQuCUJj1t6EKImQgoNrQwawuyZv+89QC5aksmIfjiIkXm0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310722; c=relaxed/simple;
	bh=V62TN212d0XAhmGkwkz4Xj4iVl7RBk34I1OjFnHdnoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJGY6H4m5Gxe5TH1nr+he8B+SQKn18kG2QC1nzRjv2reFg9uREM59xFb3ntZEODQDycqOg9/gSG8Vt5q1aPuBM5hBN33k5Qj46VGBZljW9Jr/ZKUWuTggSwbGE1gV5YBiHp2nxjbTUS7RtOVz3etsNDZ69vY4t3CYFmjpdgKZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETvhn5Em; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c79f0a606eso2516207f8f.0;
        Wed, 27 Aug 2025 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310719; x=1756915519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8echyaSyemifndFbaz+Cq3LhNHgLiuKZBgQlFXgopc=;
        b=ETvhn5EmcTIDqk/fIW5EE030JRp0hdQRi8ORCLk56OLo/DIyYnIXkwPWLTV7keSluj
         rOeVfC1TQTvvPNALuHwM3t0mmkxnBxrlg4k5Jj3OwuecLPuveTYR70BEKLHcc7Jmmdqa
         nTURpCFz28R3Vxm2yxA16oN0EbVZ4IR464sj6i3hLaAuWtBk+lX1/JlgKn5kyNxy/rV5
         KRBrqbz7S8I1oJEUXFUwpiPdcCHOs2f1UXskQYVKFgAAdKqTmXWb45lKMe6h87IYizGW
         k2TYAuaH8xgRMXa2ygPLFWUdcfG4RCdFW7FyovpRsNY0rk8M4qf0x1epY/ZAafs/qGeq
         m2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310719; x=1756915519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8echyaSyemifndFbaz+Cq3LhNHgLiuKZBgQlFXgopc=;
        b=Ny51ZHKc65Fx+FfRJYoBPrtoYz7q9FTcdKSvsBh3C/4GpejV+soHNiJBlll+VlIvU0
         uMKrGArO20yBLyuwC5Xzf+OMgz/nXqFJXVj0JnZkymzTr+Hq1FgGa5cTZrZ2/a4SGu1I
         zJHQtBynWdPvNj/n9pIocUHzjG0sMqmF+e1CALnLbF3xS3f3799EPWbuvNrIn/BNmdMa
         n3kOL2eMZ4K7c6K/zA3wxzDGhIhhZ3B2vBCx8YM8f0/4aNb5slmSGO7KQaZgvUP+Fdhz
         dY7mY+0DWv8U8baFp1ebhs25fv0UbiH6FmE3qYUzf0KICWzJb18o4eAkuOmPRzzEFOFM
         D0fg==
X-Forwarded-Encrypted: i=1; AJvYcCWY3uJ6SL3h6GZTC81omSJ0nKNB0hGesdS6Y12jlpiNL3ri42fGLc3mln07MAsoBQgL/02XCis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIF8yuzGyLPGIHew5D3F5CAgfjLssP9oakjOC6tPn/RQW2k+d
	KtfVayDMsoode7BsPMluTRGgd8Aibd9gGnnYmQ/4HxEBhnfiJkkGQr4DxELK1DvzROZwsH3AZac
	9+IuxYic5JM2CsU2iM4ZGDP5T6kkIq6c=
X-Gm-Gg: ASbGncte2XNMtxXODY8KlwLgs1t5O8qrPmrrB4Ew6+R1R01Vo8x85uUR/6IFAIXwn+l
	Ex6YKcbnAE63cLX5z91DlbMPzWA4SX4/Viz876yQyNAOOSTJnTOFGcK29DA0e9WXrdUSjI95clz
	k4EIS3M4oYc4fESNitEfiiWb6mMKQEGCyyzE0fz0IDluv3UQmiMIxyVQVbgMWP5oro5U8EO0H7p
	GKtLgKC/UAveiBJBiWXm1S8xIz5K6JQnQ==
X-Google-Smtp-Source: AGHT+IFXt2ulxP9TAAF3i91GIGrtoVEleaKDJ/XailXy95W5qAPF5EVu8tqb0u3Q1EhMUuBmHiDt7eT0AwPyjgv85rw=
X-Received: by 2002:a5d:5d0a:0:b0:3b7:792c:e8d9 with SMTP id
 ffacd0b85a97d-3c5daf023eamr17172267f8f.14.1756310718800; Wed, 27 Aug 2025
 09:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com>
In-Reply-To: <20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 09:05:06 -0700
X-Gm-Features: Ac12FXzujJqM2XD0Qt4sUWrAUk4oY8A7Nr5j-BlwoYQ0DcexGi-MJ5rILKCktk4
Message-ID: <CAADnVQL_8guWC9io1P5jhTgnyD3u=0WvTnHM3DJFVvE_Sy7DBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: stub out skb metadata dynptr read/write ops
 when CONFIG_NET=n
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team <kernel-team@cloudflare.com>, 
	Network Development <netdev@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:48=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Kernel Test Robot reported a compiler warning - a null pointer may be
> passed to memmove in __bpf_dynptr_{read,write} when building without
> networking support.
>
> The warning is correct from a static analysis standpoint, but not actuall=
y
> reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
> impossible since the constructor kfunc is missing.
>
> Fix this the same way as for skb and xdp data dynptrs. Add wrappers for
> loading and storing bytes to skb metadata, and stub them out to return an
> error when CONFIG_NET=3Dn.
>
> Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata throu=
gh a dynptr")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@i=
ntel.com/
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/filter.h | 26 ++++++++++++++++++++++++++
>  kernel/bpf/helpers.c   |  6 ++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 9092d8ea95c8..5b0d7c5824ac 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1779,6 +1779,20 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 of=
fset, u32 len);
>  void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
>                       void *buf, unsigned long len, bool flush);
>  void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
> +
> +static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb,
> +                                           u32 offset, void *to, u32 len=
)
> +{
> +       memmove(to, bpf_skb_meta_pointer(skb, offset), len);
> +       return 0;
> +}
> +
> +static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 of=
fset,
> +                                            const void *from, u32 len)
> +{
> +       memmove(bpf_skb_meta_pointer(skb, offset), from, len);
> +       return 0;
> +}
>  #else /* CONFIG_NET */
>  static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 of=
fset,
>                                        void *to, u32 len)
> @@ -1818,6 +1832,18 @@ static inline void *bpf_skb_meta_pointer(struct sk=
_buff *skb, u32 offset)
>  {
>         return NULL;
>  }
> +
> +static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb, u32 off=
set,
> +                                           void *to, u32 len)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 of=
fset,
> +                                            const void *from, u32 len)
> +{
> +       return -EOPNOTSUPP;
> +}

imo that's too much to shut up the warn.
Maybe make:
static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
{
        return NULL;
}

to return ERR_PTR(-EOPNOTSUPP);

instead?

