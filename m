Return-Path: <bpf+bounces-20552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763AC83FF9C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 09:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB3A28306D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05452F84;
	Mon, 29 Jan 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0MZB9Bc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255F53802
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515586; cv=none; b=DbFegK1h1viBcnzeQAuxRvSOgsg4mLPn4vDSSbZTI480c9cBPdBQsZ+dwvu6RtTCp7rlGHs2lbnZhUgqXmnAu63fgtRw0W0jlIFL/74cXtgtdsv+c8SCR3icUEBva9lm1aRpXX6jB8sAr2vOVIgnR/xdQxla1K+u79FGXKyjeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515586; c=relaxed/simple;
	bh=wizf/N1yiuWXS86LJIaK6ePscQYmOHU1hT1ODhjDqGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub1YkCFIjP+vbw0QEnh3OHuNA+uvzMASdqVETKrY8ALveVIp/NbpfabesghgArs801mBmfokyR+7dMqvXMgV22LC1PXg6S4EJGqQjlH9kPaTMBAnXxGRPn7Yi2kru4VXw+fHLZ9TbriY8l27yuDbcPOGiwZGDtT9mMI+KJoTp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0MZB9Bc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf47acf8f8so23965461fa.1
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706515582; x=1707120382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9e8ScksLMa1kSFGa4MeqkycZDTxe116Rjce2WdVB6bY=;
        b=C0MZB9BcINGxpYwSYO1ote1mv69ONaek5kkKUp4yOFRaq0RfpRcgUvrb60Iw48OvPp
         F28x9G7+040f1j9udreQL5f57I8YiAoMwX0PgnKaq1q3lUvdzJObbLAkMq1mwmbdUqZw
         pIiQMX/xKw7D6KWUFLqEJK46I3FEy4wVuO/gcrd89qEiKQi4DgjKi1GTHVmXmZIO4//u
         TZNsITT9QyHZySOVexM9gDJjeuDv2sGKRV/7PPtQ6Rrxu3os6/97b8KqRkiUbQqCXvmv
         ICv70e35FEeVLUkTxOEEzMFHw5ppx0h/5L+YSel7ZLM5NHFkOvywHXE6WMVbKAWPNmLt
         q5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515582; x=1707120382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9e8ScksLMa1kSFGa4MeqkycZDTxe116Rjce2WdVB6bY=;
        b=jzIq9jNtAEiLvwtDL1BObN1IVKFUPqBzcyT0fg35586zNTIx6CIxuNfuYAehe0cdA1
         VBRdgLZMT4RWHDQNKt/NQlqXHy9U1rIWVXXXufU9RU+JSTTk9lzGwqpWT1sniv0ZuE4L
         NR/VVB3ZQppnX+66EBhdrLXq0kzFCID2CaZxi/Gk9YtuS3YiGK/hS7e1/USbPYW7zTqw
         CPoKXJKF8EWT2LF5h6HpUfppG7XlSYosXtYhcKt1iHyabeIENAUcwzSJwnDs4mzHY1Nj
         KOIrF5baQ8/pFc/RyZj8mKbUDmmNUIHjMz0rv+JL9JU8dTE4hCJj5KXSNXRQrJqev0ZL
         RrJA==
X-Gm-Message-State: AOJu0YzDF+nwO245LNH/qvKDdF5GNS4Z/rJKDE0+tf4RcL1KxJkZ3QSb
	3FZgujBuiamqoKU5weK/R7dIjcQo5XSRmmIjMjatIh/rLOT+M2A0bpuPuj2WZ+3d94ASZmMdQv8
	amMcH2lQLFxwJFAGReLxZTLj6YiM+cGF2thJQrA==
X-Google-Smtp-Source: AGHT+IE3GFzRTK+gEYhAKVDdNv5dFPD9sD0dkQBG91cWCF8DdnJBOEHg4VxPLo6WJDQ2akkzMsQX3aJpjWz+q3rAypA=
X-Received: by 2002:ac2:4d82:0:b0:50e:797c:249a with SMTP id
 g2-20020ac24d82000000b0050e797c249amr2622926lfe.12.1706515581936; Mon, 29 Jan
 2024 00:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706451150.git.lorenzo@kernel.org> <7fd76e88e2aadc03f14b040ffc762e88d05afc8c.1706451150.git.lorenzo@kernel.org>
In-Reply-To: <7fd76e88e2aadc03f14b040ffc762e88d05afc8c.1706451150.git.lorenzo@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jan 2024 10:05:45 +0200
Message-ID: <CAC_iWj+qTUmzD6Du-FRf7yhQj-euG3cFHcT5hZccdeP6tB=jGg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 2/5] xdp: rely on skb pointer reference in
 do_xdp_generic and netif_receive_generic_xdp
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org, 
	toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	sdf@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Sun, 28 Jan 2024 at 16:22, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Rely on skb pointer reference instead of the skb pointer in do_xdp_generic and
> netif_receive_generic_xdp routine signatures. This is a preliminary patch to add
> multi-buff support for xdp running in generic mode.

The patch looks fine, but can we tweak the commit message explaining
in more detail  why this is needed?

Thanks
/Ilias
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/tun.c         |  4 ++--
>  include/linux/netdevice.h |  2 +-
>  net/core/dev.c            | 16 +++++++++-------
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 4a4f8c8e79fa..5bd98bdaddf2 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1927,7 +1927,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 rcu_read_lock();
>                 xdp_prog = rcu_dereference(tun->xdp_prog);
>                 if (xdp_prog) {
> -                       ret = do_xdp_generic(xdp_prog, skb);
> +                       ret = do_xdp_generic(xdp_prog, &skb);
>                         if (ret != XDP_PASS) {
>                                 rcu_read_unlock();
>                                 local_bh_enable();
> @@ -2517,7 +2517,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>         skb_record_rx_queue(skb, tfile->queue_index);
>
>         if (skb_xdp) {
> -               ret = do_xdp_generic(xdp_prog, skb);
> +               ret = do_xdp_generic(xdp_prog, &skb);
>                 if (ret != XDP_PASS) {
>                         ret = 0;
>                         goto out;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 118c40258d07..7eee99a58200 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3958,7 +3958,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>                              struct bpf_prog *xdp_prog);
>  void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
> -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
> +int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
>  int netif_rx(struct sk_buff *skb);
>  int __netif_rx(struct sk_buff *skb);
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index bf9ec740b09a..960f39ac5e33 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4924,10 +4924,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>         return act;
>  }
>
> -static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> +static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>                                      struct xdp_buff *xdp,
>                                      struct bpf_prog *xdp_prog)
>  {
> +       struct sk_buff *skb = *pskb;
>         u32 act = XDP_DROP;
>
>         /* Reinjected packets coming from act_mirred or similar should
> @@ -5008,24 +5009,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
>
>  static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
>
> -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
> +int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
>  {
>         if (xdp_prog) {
>                 struct xdp_buff xdp;
>                 u32 act;
>                 int err;
>
> -               act = netif_receive_generic_xdp(skb, &xdp, xdp_prog);
> +               act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
>                 if (act != XDP_PASS) {
>                         switch (act) {
>                         case XDP_REDIRECT:
> -                               err = xdp_do_generic_redirect(skb->dev, skb,
> +                               err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
>                                                               &xdp, xdp_prog);
>                                 if (err)
>                                         goto out_redir;
>                                 break;
>                         case XDP_TX:
> -                               generic_xdp_tx(skb, xdp_prog);
> +                               generic_xdp_tx(*pskb, xdp_prog);
>                                 break;
>                         }
>                         return XDP_DROP;
> @@ -5033,7 +5034,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
>         }
>         return XDP_PASS;
>  out_redir:
> -       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
> +       kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
>         return XDP_DROP;
>  }
>  EXPORT_SYMBOL_GPL(do_xdp_generic);
> @@ -5356,7 +5357,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>                 int ret2;
>
>                 migrate_disable();
> -               ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
> +               ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
> +                                     &skb);
>                 migrate_enable();
>
>                 if (ret2 != XDP_PASS) {
> --
> 2.43.0
>

