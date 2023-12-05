Return-Path: <bpf+bounces-16717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E8804D1D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C71F214B3
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3E3D978;
	Tue,  5 Dec 2023 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUAVM+3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD15120;
	Tue,  5 Dec 2023 01:03:44 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da34f90f6e3so533404276.0;
        Tue, 05 Dec 2023 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701767023; x=1702371823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yrBMYfFc+7psr6y2xtQ4cvLevpqXl5CZRBrVSMY5Aaw=;
        b=DUAVM+3bqNPPhEqWnBXwyXaSjXFWBzsYKsivbUA4AnpZ+5lL3jLkzVZnzRgXJznV/c
         0/rmuWfi3i7Py7R2/oN/Vd7BdIfnGfbMrmmVnN3mZAM4cm5pckHjvzzyn7qVuLYlJ1Am
         3oASudddx1qZkYbWYPydVx1cZTpqaaKtNAFKe21ACQg+BxvGFPXJ0g4eV54VZ2K/ePkZ
         HbDbm+yB9YVXzMxL6Cj7Ku+MNirlXlmstmM43zg347fFGYqUUucne7DnSf3WsQXqAu57
         KODpAb07SfueBhMFiCKys11co2Oy5/Bjp0JOtam5iubZ07wOYd4LxfY3tC3WBlMOTw2A
         kHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767023; x=1702371823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrBMYfFc+7psr6y2xtQ4cvLevpqXl5CZRBrVSMY5Aaw=;
        b=l4G8K0D7MUiUhzmBvnUok2YoOZFJ9I7sohE3fAUMUf5GB7ow9pmtl0Ff6tBh7kCuuo
         CS5b7vZYTSbAG+8IwUHDzXcFxellgAaizJFhR2X3c4BnqUvD++O5r46WLwdOa2Prk9Ir
         smlPo23OXx/pjInB9eKUvZaskpyikIlcuj/nDOHylhvreFkfXCn50ucz7TTauAQSxr5E
         bWltYEWDSlf32DC8JqYUlPBQ9Y/miAdFbpL1lTVmxo7kOiXsA79/Ppk0y2glS2W3zJnr
         3LUD1Nr31i9vGUHElhvOAtcz4zeNczfGTKb4wHHsO/KNpm74HeDldXOp7y4Uss3t4yKu
         ZNMg==
X-Gm-Message-State: AOJu0YwE9odkZngnFJsXAmM9fBYFVMwldgRQidDBjnYMfPZYafToBI7c
	9Ky8S1Ag1gwXE06kdct4bWAtAB9DdAhYf9QKzRE=
X-Google-Smtp-Source: AGHT+IE4BwoGh4B5ISX9h0dKammlHixhugtXmkQkQ2GTJtBfk8ZnV6c3czl2nJMgLPbI5gogYVC9Z6fYXUhivcAcOUw=
X-Received: by 2002:a25:ae02:0:b0:db5:49d7:1c3b with SMTP id
 a2-20020a25ae02000000b00db549d71c3bmr8643178ybj.1.1701767023286; Tue, 05 Dec
 2023 01:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201061048.GA1510@libra05>
In-Reply-To: <20231201061048.GA1510@libra05>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 5 Dec 2023 10:03:32 +0100
Message-ID: <CAJ8uoz3HDEh-vH=hUGcBCDZQr8au2b5ZfM3gpc-Lw1oRr1QDGQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: skip polling event check for unbound socket
To: Yewon Choi <woni9911@gmail.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, threeearcat@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 07:11, Yewon Choi <woni9911@gmail.com> wrote:
>
> In xsk_poll(), checking available events and setting mask bits should
> be executed only when a socket has been bound. Setting mask bits for
> unbound socket is meaningless.
> Currently, it checks events even when xsk_check_common() failed.
> To prevent this, we move goto location (skip_tx) after that checking.

Thanks for the fix.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 1596dae2f17e ("xsk: check IFF_UP earlier in Tx path")
> Signed-off-by: Yewon Choi <woni9911@gmail.com>
> ---
>  net/xdp/xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index ae9f8cb611f6..1e5a65326d1d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -947,7 +947,7 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
>
>         rcu_read_lock();
>         if (xsk_check_common(xs))
> -               goto skip_tx;
> +               goto out;
>
>         pool = xs->pool;
>
> @@ -959,12 +959,12 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
>                         xsk_generic_xmit(sk);
>         }
>
> -skip_tx:
>         if (xs->rx && !xskq_prod_is_empty(xs->rx))
>                 mask |= EPOLLIN | EPOLLRDNORM;
>         if (xs->tx && xsk_tx_writeable(xs))
>                 mask |= EPOLLOUT | EPOLLWRNORM;
>
> +out:
>         rcu_read_unlock();
>         return mask;
>  }
> --
> 2.37.3
>
>

