Return-Path: <bpf+bounces-67001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE5B3C0DA
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48447B0C19
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E832A3DB;
	Fri, 29 Aug 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgKkOVvv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275E101DE
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485282; cv=none; b=jeanPcex0r+mgfkJhz/WHr1mN+9JzLe9R1rylNDUmuWTEzLlEDrWGW13FYrmisWreVl9YaP7Hxp8NinTHpOPA177J3wPtKMjkQUIOmRoy063D7PTW3aP1s3wIPSkzKHd1n3yHm0l5jf9cf+eid5+vAZ7cZwm3+o7e2Wsu2kMqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485282; c=relaxed/simple;
	bh=w02vc4ZIN2Yf79bTdKCIFILkHtJW+xpLkB9Df766SjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi1feOSQoem0FO2C3ygxBXe72QLdMFSADDhaADB1tHy5pLLVv2VGZGzEqMlEEOFZg+aF+RzNcKsXBCR6Ii0CA+VTX4hY2CgXf9Pk/p3wUzary8VYku+AdjxYsUdO3452vCWhjPaJD1kTz0SP9iorA1agg2A1KBcy6JTjvkO8PLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgKkOVvv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b10c1abfe4so21489471cf.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485279; x=1757090079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJbh/xt21xx/+x2x94uAOCLVyNPUW7zvmYwO/H9Z7jc=;
        b=fgKkOVvvn5iSE2wMO8ukaQSbym8MN7l4vYMQUzhCMuYq9qAZaT4hBkbVwVxCRs408z
         fdpsC1VQYeTZR//qC+bTm7Mc2MINkfivYjM1Czh7Y/BcY2eQjL7S+UKzPLvpXNyx7RbU
         q7iSnsRC97a+32Sp7qefa1/cfALlKqrFSeEQUP4gE/+rkv570gvULbL0TzJvOnVEpwLI
         opCVFfTPDxfGWSEipCkJ/oQoIZr7CmQbmbNG850jXuhRTgKZB+lTejff6OMO4g4boQRX
         MFMxHD/sD2JKD/RAlLa+BONNOCtIFomb4CTVX53+wB9MBVlS0JIQsokHCv/hE0mboZAH
         HfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485279; x=1757090079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJbh/xt21xx/+x2x94uAOCLVyNPUW7zvmYwO/H9Z7jc=;
        b=KFLnLGjLjuX10Osg5laKG2ezuqlTHvk3Qe+/ongQxljoAo9qjk2dZf/XTZKcflqnAJ
         V1pyRqSQguuZQO0/G3YVINGGffjZouRkWvlIRhhqlvoPZd+fo7EGCCZA9XJKEpKFk90k
         /0RpgnZRzWu8h/fxDFYsCjsIE864FX5Y/L9RG2djhqYQ5eMV1q182WUw1+361bwXTfc6
         TkSxhUJ7mmOREujflK54tROeO74dW/2FG9GduEO9PPv2fHMwWOooOigHGYTPDKjA+t+g
         e2enlY1foAunYRVfpRF5krm/YZHQLsfOXa1Zlm8sG2ovCiMcT5FHVTGzT3BL+Rg2bxPv
         mmrA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZBmwRcAw/gWx3YO0Xn3YXqI7rsSXP9cQbGOTBwVjFtEYqulOgqd+KA2hIaG90pYoMhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qR+a9LDXDFjw/WN4rOvGK7iUm1GvJGNJKdLAB0AAMhiKYKmq
	t0cqX7hqjfIpXjO8HTuizQBxMI/qanLIgpovaKj47DR9g59/uvboLhtF/BSCGpGytQwKTCr9hYr
	sGz2IygjzG7HC8BQ6IhMUkrt5eJeB4rrrlDKfW9LM
X-Gm-Gg: ASbGncun/knn9CMhMcavx6yAopaAmbVXmmkSDt71vtlgXSiEDOfeX6212ZceGnsFxNF
	WoYBD56+6TO3gl64fU9FgAk1mFRssCUVzHgQo0N5YwM9+9iSSqJ6f4p5azXpn3mbQhFRyd+y1MT
	7XCVcotBWyvbBwJrpfRKbv4/8RvtLHmTFG0jYo6GESH2OXQL5MI9o0wnJDchyXm+OqfhqaeCdYd
	w8FTGKMsDAsuFFoti2uM+Q7ekowkXzsoO4bQI8AjBrtjT1V4r0pW7LbDtY=
X-Google-Smtp-Source: AGHT+IENd4Z0R9bs0yr+ss5hcDT2iTdZpCbQuWcpSCFPXVpeEPiccjbKYZO4LaH+miGYLmYc3pfD6qG5WCFK1qvIYh4=
X-Received: by 2002:ac8:58cf:0:b0:4b2:fe63:ae03 with SMTP id
 d75a77b69052e-4b2fe63b804mr87346471cf.22.1756485278738; Fri, 29 Aug 2025
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:34:26 -0700
X-Gm-Features: Ac12FXzW_w7AW6j0jAtk0R2jBActMK4XmdvL7HZnq7aTeIkGOtaz1bYi8RYYyM4
Message-ID: <CANn89iJbbqCvTWnaWgRQd1KEVveaPL+qLPfsfNkCrDFenAjEgA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:36=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits ot the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

