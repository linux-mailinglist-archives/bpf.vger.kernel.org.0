Return-Path: <bpf+bounces-43875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06C9BB084
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195561C21CA0
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4631B0F05;
	Mon,  4 Nov 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCb78BQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350E18562F
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714647; cv=none; b=lMCsXjAU9/cMMWhZ3BztllQcpj3t8Fx6eHGHVsSrM5RX/vAPmpi8oXGr/oYKoDQgtiUucy0/HqVKEFgXLLELERv9ffoHKSFZuu0xEvno/jHkXSfRXrwytRV8XwB+pkuCj9lsJhcFdjM5GNlIyuduiSkuG68uKpqcZ58QtqVbtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714647; c=relaxed/simple;
	bh=MhSgiDRe9kWlu3krkcq44QnT0I6xrXTBB2qUzTIjdbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7sFjb+3ZF4dr13rfNFiEr5Xzz4u/EnDq4TvGY7acftLBet+WWLzrOJXuehU3oOpAmYHfk1ckwzrsvf/3LNnCfAbbTd6p6ha16zrot5p6LPYJshbyjMSLy8uX5ed0vePvvtP9ElRzVeTbvxTUgus/jUY+YTc+Y/FM9+/XFWgM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCb78BQj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso1511016a12.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730714643; x=1731319443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWHQXABSdBQg/uFBmbjMbidGd580f14Xd7VejbWBnfw=;
        b=TCb78BQjrcfRHuP+ehX0iyTN/N0hvk6WFSpJVpHRABoE2yuBrVQ+X7ilw7sUNoCjVQ
         Vha2Cp263Spvn8pMeJnCFIn9EYsfJzMeL928GrDlxefHgp8jPdJx/pqIYxodhGveePJX
         SLLtcNGmAZOxncjtS1Vo/HkdUR8Z7d30Xtg3Z3qp268V2HG/8jAiBNXpSdLUqIt+54ZL
         3nkF1X8ZtWb/ik9WGgnZW++bouZaH7KLfwnSq7A9NXsojXsuxuHA+B0FZDqHjAazUwPe
         TzCGhAEUuDq9lUdrfa/mFWNtwtKMMVeen1jh+2O9EZeB75UuJbtjudQwzhBvgz6FiEcm
         F8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714643; x=1731319443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWHQXABSdBQg/uFBmbjMbidGd580f14Xd7VejbWBnfw=;
        b=NrS2ia0BbKYhXFrl5woapKI6W9as0Qz7dSWhBmpDJu4chdU7dnSs55S9eGcNZG5Jmr
         ChsE8hFGtIfRrAQavX6qzfs3CGwFjeoivtLmxSporuXu6JdzQqMHVTwvG0HuQ/yJTm55
         x1gefXFPuvqmYR/20sUBEXj5Q1zKP2Au4Wl+JxLgH2PDpxSi3ZQ7LCCCn8t48vVsaCSj
         7H8Xju7jCtUIOt6MTvbqdza4iJpsPwbdfDnhGqjQAqaHdH216srPhaddRAXY1Ii1QAzN
         c6RB2/jhCp3jIvm/Zp0TQ3OufodxYSBxwBPv9vq9uFxTHOPfk04QlhEIpSVq1S2ubdgu
         vZrg==
X-Forwarded-Encrypted: i=1; AJvYcCV9SO+T3snw7J6jinU06DS5JWMy9HmZSdW7arHhzE2kpgI5NfVBAJl+/3W/nGNEejCXGok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBIHTX8nHNoPqpcmLFfI5/DvSzlNsyeXZVotVRAyoAfSMqFeS
	QC9LO2tNUKW5f2vQji+mjBDY0TmJ1/rSb36gv1nsTV3+c5bvdRj5XgMVQ1Zj+Zt/AnFEOkB8Yy0
	7PouyAqVTMUIrl6RzrVFmVXOfqO2iNnyqw+4L
X-Google-Smtp-Source: AGHT+IGWCN4mosqMf3EbabWrtqPlRv2GtYs4xdwKhJRvXbfP1X66v9dmfnGhmhV6cyrmOqK3QuBDpmNc0jWAqJFJDCU=
X-Received: by 2002:a05:6402:2105:b0:5c9:5ac1:df6c with SMTP id
 4fb4d7f45d1cf-5cea9732262mr12444587a12.33.1730714642898; Mon, 04 Nov 2024
 02:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104040218.193632-1-danielyangkang@gmail.com>
In-Reply-To: <20241104040218.193632-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 11:03:51 +0100
Message-ID: <CANn89iJCccfcfAFxMO3NhpVwF87OPLQAFQPxnyBkbvSf=WAM0Q@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:02=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> KMSAN detects uninitialized memory stored to memory by
> bpf_clone_redirect(). Adding a check to the transmission path to find
> malformed headers prevents this issue. Specifically, we check if the leng=
th
> of the data stored in skb is less than the minimum device header length. =
If
> so, drop the packet since the skb cannot contain a valid device header.
> Also check if mac_header_len(skb) is outside the range provided of valid
> device header lengths.
>
> Testing this patch with syzbot removes the bug.
>
> Macro added to not affect normal builds.
>
> Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.=
org/pub/scm/linux/kernel/git/tj/sched_ext")
> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D346474e3bf0b26bd3090
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> v1: Enclosed in macro to not affect normal builds
>
>  net/core/filter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cd3524cb3..9c5786f9c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2191,6 +2191,14 @@ static int __bpf_redirect_common(struct sk_buff *s=
kb, struct net_device *dev,
>                 return -ERANGE;
>         }
>
> +#if IS_ENABLED(CONFIG_KMSAN)
> +       if (unlikely(skb->len < dev->min_header_len ||
> +                    skb_mac_header_len(skb) < dev->min_header_len ||
> +                    skb_mac_header_len(skb) > dev->hard_header_len)) {
> +               kfree_skb(skb);
> +               return -ERANGE;
> +       }
> +#endif
>         bpf_push_mac_rcsum(skb);
>         return flags & BPF_F_INGRESS ?
>                __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
> --
> 2.39.2
>

I am not a BPF maintainer, but for the record I think it is wrong to
silence KMSAN and give the impression a bug is 'removed'.

