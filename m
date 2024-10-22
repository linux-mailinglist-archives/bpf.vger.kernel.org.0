Return-Path: <bpf+bounces-42831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49A9AB810
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997971C21377
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6F1CCB50;
	Tue, 22 Oct 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9UOO74p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F7126C05;
	Tue, 22 Oct 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630630; cv=none; b=oB7lLIMHAOMYEFs0LOnbYZozv49nkmMgw1mSOG1R9X/k8TTtdXB8XA63ajBZ1rvN/GNSl1/MeioeM4phJZWxYkEmESABYreehLEAmwIlNAAQcnTpupm9gKf/oJE+mHO13RBVswsq0lpFUfDNigAX8kfk3Hgq6VS9w6OhNsiW32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630630; c=relaxed/simple;
	bh=Z7eCMTu/SeuW9q8xoa7TkU6mNr3MeA+Zi0ZPpXiT0io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1BCPywHV7IPDlNEFc8oYHmiLxCAhzQoxFyJpDKaIQhm3gW6kQYmVjXA0neBuT2p0hI9vM/9zud//6CXwn5D0bRBgtAfNDo4MY7T+AbhbGRbWfO3XLH6lgdyLxqOVQDIeZq1GO0ZsR/m1vWbBqEbEHkl3R0c7zWRoi8FMKAJp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9UOO74p; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e59a9496f9so68965837b3.0;
        Tue, 22 Oct 2024 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729630628; x=1730235428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80QHgysMeY/f6ukz7QwpRl7TAlf0WHVhdn71+vzYCdU=;
        b=k9UOO74pcMoEAcTxCc1EPAnOMBoZqOuwHEz1U2x7S5py5T1k1Kg1JsVS2nPabrFM6G
         fDBeDlnoTtZNyzmhNYtCufGB8fgBf1ZhkTq9XWuC6yem1Qx7oBUhUQ3co7dtUg4/6PDT
         WaCApAh9timZ106jLCKHSPBwKUBycaE+LbWa7WiX1mAUwj3OnQq+qMCGE6csi4oTXi+9
         ehyiLirBnqc04pPwMRF6YW6Um0Fm680taiaQ398xRtBrN1SIy2uMS90zUses27+RJKOB
         R7efJ8LRV/b8bG/R/V3rzGQXwCRZwJ9tPu0dyJZLyERV4mU4wzrJiUksa16spsHb6B06
         LX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630628; x=1730235428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80QHgysMeY/f6ukz7QwpRl7TAlf0WHVhdn71+vzYCdU=;
        b=RI60PUFDYwLkPnxCC40X8K66hW+x5hdsOXiXVHcj+VLU9J7FUPuJSHGbsTX4MEgL2t
         nOWG+m93Jd2He906mns5yL3qfNtHjO5lpB325VvW2+26Zz6CREFXiL3RAdMOBPYn8zek
         CquTX4BRWLAEm2IzXoaGucCgwCd7KN07OfDxl1oTaxuOWDD9Q/6SnWrlQt7OoJTpb5se
         ryqWKe0i6NCiYB2WiJqm2Zb3lTU8DZh58tIC8y+zJpGApf0UyrpFhi3ImrWmmzoSw/dj
         z1p0PwDntlVRwZQjMtfwRy84X8WgRtFjVaFl7+bbmtthPB63R2aL/94pwawDZmlKMRfo
         bpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmD6saTL903Dvqou58a4bQcJakJS0AzRRELjXKqeoWmfATtUCh2gYfV/OS0WJVwS/EidZU9TvGbdOxu7CF@vger.kernel.org, AJvYcCV4zfoh9WpNwKJrvnP+nJdhZ26TdglTo8euMVttEHLIVs+HWvk7V/dR9ucaEdBP1YdvyYI=@vger.kernel.org, AJvYcCVmwbRFzzkMSIxCIAEI6b7hCrggNEWNdblL4coFHRsooIwlY7oXjxo270n8koSVvHeOdltTsMy4OixvdE8t@vger.kernel.org
X-Gm-Message-State: AOJu0YwWq+zs1s827jTnsBq7AHHb2nekHpXh3KaPPcBmm9oewWpwe+sG
	6E27vHiQr9I/uP6H0cuVoEm+0sqqhsHjyAPT96zTsZeXXjwMSV//G6cliDJ8GWvVnNuojPr2QTu
	i4A9pgocwRPoxq6yYOU0FkFujnFpko72U
X-Google-Smtp-Source: AGHT+IGiXrXinljDlaDVbafCVkh57A7ax5msziLAr4GotnEipHlk6LsDs9JIK3g82KoSJfY4uNtkjSERtDE4RxwvYSQ=
X-Received: by 2002:a05:690c:c8c:b0:6e3:33af:6b64 with SMTP id
 00721157ae682-6e7f0defc01mr3962507b3.14.1729630627698; Tue, 22 Oct 2024
 13:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022204908.511021-1-rosenp@gmail.com>
In-Reply-To: <20241022204908.511021-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 22 Oct 2024 13:56:56 -0700
Message-ID: <CAKxU2N9nQFs_wDbe=S_ywfOFYeX+LWuN8f9y1y2iA5GV4tFDFg@mail.gmail.com>
Subject: Re: [PATCH] net: mana: use ethtool string helpers
To: netdev@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:49=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The latter is the preferred way to copy ethtool strings.
>
> Avoids manually incrementing the data pointer.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
forgot to put net-next.
> ---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 55 ++++++-------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 349f11bf8e64..c419626073f5 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -91,53 +91,34 @@ static void mana_get_strings(struct net_device *ndev,=
 u32 stringset, u8 *data)
>  {
>         struct mana_port_context *apc =3D netdev_priv(ndev);
>         unsigned int num_queues =3D apc->num_queues;
> -       u8 *p =3D data;
>         int i;
>
>         if (stringset !=3D ETH_SS_STATS)
>                 return;
>
> -       for (i =3D 0; i < ARRAY_SIZE(mana_eth_stats); i++) {
> -               memcpy(p, mana_eth_stats[i].name, ETH_GSTRING_LEN);
> -               p +=3D ETH_GSTRING_LEN;
> -       }
> +       for (i =3D 0; i < ARRAY_SIZE(mana_eth_stats); i++)
> +               ethtool_puts(&data, mana_eth_stats[i].name);
>
>         for (i =3D 0; i < num_queues; i++) {
> -               sprintf(p, "rx_%d_packets", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "rx_%d_bytes", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "rx_%d_xdp_drop", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "rx_%d_xdp_tx", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "rx_%d_xdp_redirect", i);
> -               p +=3D ETH_GSTRING_LEN;
> +               ethtool_sprintf(&data, "rx_%d_packets", i);
> +               ethtool_sprintf(&data, "rx_%d_bytes", i);
> +               ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
> +               ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
> +               ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
>         }
>
>         for (i =3D 0; i < num_queues; i++) {
> -               sprintf(p, "tx_%d_packets", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_bytes", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_xdp_xmit", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_tso_packets", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_tso_bytes", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_tso_inner_packets", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_tso_inner_bytes", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_long_pkt_fmt", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_short_pkt_fmt", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_csum_partial", i);
> -               p +=3D ETH_GSTRING_LEN;
> -               sprintf(p, "tx_%d_mana_map_err", i);
> -               p +=3D ETH_GSTRING_LEN;
> +               ethtool_sprintf(&data, "tx_%d_packets", i);
> +               ethtool_sprintf(&data, "tx_%d_bytes", i);
> +               ethtool_sprintf(&data, "tx_%d_xdp_xmit", i);
> +               ethtool_sprintf(&data, "tx_%d_tso_packets", i);
> +               ethtool_sprintf(&data, "tx_%d_tso_bytes", i);
> +               ethtool_sprintf(&data, "tx_%d_tso_inner_packets", i);
> +               ethtool_sprintf(&data, "tx_%d_tso_inner_bytes", i);
> +               ethtool_sprintf(&data, "tx_%d_long_pkt_fmt", i);
> +               ethtool_sprintf(&data, "tx_%d_short_pkt_fmt", i);
> +               ethtool_sprintf(&data, "tx_%d_csum_partial", i);
> +               ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
>         }
>  }
>
> --
> 2.47.0
>

