Return-Path: <bpf+bounces-17524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF880ECF7
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41C4B20BF0
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470961677;
	Tue, 12 Dec 2023 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N15Vzw1O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D484B3;
	Tue, 12 Dec 2023 05:14:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9f11fee25so704664b6e.1;
        Tue, 12 Dec 2023 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386854; x=1702991654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stDkgdoFk0XfmYwjrEqVrLdT/Qh3MCip8pO7lUFKZX8=;
        b=N15Vzw1O7q07AGFIFRPfh+yCQHEmyfvMvBzOx5u/1ys5y/44pbZZ/tDDLz3agnFH8v
         LRRNvkb9ajUlLsfmFVzy3o9tDnjmNhtIZGmNs/Tg6Qod8pxqdcExBtW/kO+qSGBCx3d1
         vZlm+1dUqcsYxcZyo+zKniRd6twvF9nj2DSd6tfKHPeh5waoq75SDSPmtZLUGPAgTZoP
         z/GhGcULi3wXaMnox6aiXxAf6Z9K5Vm6l4Yk75AVFiF3YwIDnxKxExwUsXBrBSwBE2VW
         PpTmEQXJHVsFy+1Wa50C3QJtEVENpBTXz2sbzUQMQw1PruG66n37Tv7Dn6DU4hH4gltb
         QE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386854; x=1702991654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stDkgdoFk0XfmYwjrEqVrLdT/Qh3MCip8pO7lUFKZX8=;
        b=Jn5rjaLxIhMuxbwXhCrmi5OJs705jz6rpw9nQQqnn84aORdrM/fGTcUvizGoQfy643
         MxY0ZBvdO2TN/h+ro5yyndpTMGLrB/hmCXTttNQduGFeobXy2+1+9p8TbrQFDJhaAU5/
         gePcwpy+Y4iy3Ujces/Rfll2dmq61ttWh6M5Vm8v3lPdelmPevzY/sFY2y3v8vV3Z7hY
         JRsA5n++9uc6oP95RUnUJE0vO2d6GhTq86vtCSPcp8o9/fO0XixxWxHfY2CYnVHHxina
         m4e147In2JQWYbVXGbaDP1CG+hHuR5v0Oe8YCzamwP8xneUYeka64bXnnxVc8WoBtVhf
         xe0g==
X-Gm-Message-State: AOJu0Yz7P/P+z48ic/OjWmLZhlAKbZgSbgrDf2IMBZJoxKIB3+bIZNpR
	Pf2J+1X1Ym9usxAzwaZXiHzaXihjw+7Lo1qOTHQ=
X-Google-Smtp-Source: AGHT+IE3wz9HTHyYZ4+Lo9d8+GOwzJctb4smYkI63Bkdba2mY6t3XVYydLAQHDNX0sIllWcM4QY28mDDUJ0FCNZGGFE=
X-Received: by 2002:a05:6358:71b:b0:16e:4d4c:68a2 with SMTP id
 e27-20020a056358071b00b0016e4d4c68a2mr10370064rwj.2.1702386854289; Tue, 12
 Dec 2023 05:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212125713.336271-1-maciej.fijalkowski@intel.com> <20231212125713.336271-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20231212125713.336271-2-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 12 Dec 2023 14:14:02 +0100
Message-ID: <CAJ8uoz3XnapArhHjb1yX5q7YrFUgrO2mWgvDDsTBVzTCr=Yzxw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/3] xsk: recycle buffer in case Rx queue was full
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 13:58, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Add missing xsk_buff_free() call when __xsk_rcv_zc() failed to produce
> descriptor to XSK Rx queue.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 281d49b4fca4..bd4abb200fa9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -167,8 +167,10 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>                 contd = XDP_PKT_CONTD;
>
>         err = __xsk_rcv_zc(xs, xskb, len, contd);
> -       if (err || likely(!frags))
> -               goto out;
> +       if (err)
> +               goto err;
> +       if (likely(!frags))
> +               return 0;
>
>         xskb_list = &xskb->pool->xskb_list;
>         list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
> @@ -177,11 +179,13 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>                 len = pos->xdp.data_end - pos->xdp.data;
>                 err = __xsk_rcv_zc(xs, pos, len, contd);
>                 if (err)
> -                       return err;
> +                       goto err;
>                 list_del(&pos->xskb_list_node);
>         }
>
> -out:
> +       return 0;
> +err:
> +       xsk_buff_free(xdp);
>         return err;
>  }
>
> --
> 2.34.1
>
>

