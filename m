Return-Path: <bpf+bounces-49335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B7A176CA
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 06:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3067188A5AA
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F1197A8F;
	Tue, 21 Jan 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUVapJcm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439FA55;
	Tue, 21 Jan 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737436155; cv=none; b=JlnSUzunTSv5H36+L2Q8YcqFd/LQ02CeJNPvYBGY71Tx+jXW6wwVuvNKxmVUNGAQDOGkwqnboPWkBOhpt+MDfJxlFaPLv6uyR/NRIT/7x0ZEOTygvl21sKzASFS1npj7dEE0PTtsUrlQNm9c8lc2i8swP1MRLyNph5BZrEINWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737436155; c=relaxed/simple;
	bh=Mpfwg8Y/Q/+cD9ry0PP+5YwfNW9+Cak+CUzG7cR8D38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCdpAnYffwsWQme/aV28K/JDskur431DQxahx73ZK129J7Wr2YiMUPoFpI6yZ3Um7wzK4wQP4nH9erLG8twBQNz7DAHGc2LPyVXplnZO9t3wrX8fVEOJBM45FItKsxqv2iI9M+1sm7+jyeC+2oERG+dZepFXNQqKkHy6iT/Iriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUVapJcm; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso7616905ab.3;
        Mon, 20 Jan 2025 21:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737436153; x=1738040953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJQfRyC3Wsudpzv9LLtI4oTXgl7XjBx9DhB6xX5CRmA=;
        b=mUVapJcmbPWOBCQ0mv1EiZNNpGKVLFq0RUnwZ9ZWNPy9LIZuGmkrZSh+3CKqs/dTH2
         nbJ0t2CfuC5GWfjlBH0fSRh9WZfrL5CFPYvonCrczluNx9NSjh4pWvcbCWM5rsVC0uLV
         93RUTYJI1padj22Ec4Drq1czjc0H2zyt04jkdM9jMC5BrbIdv4LBobzu7wWZ22YTe0jk
         fQUnktTq/ID25HAu9/8LW3tGDth8G2usYXH6k/+f/c0oKbiCzIYhkDpwnxlsOXmB8UvH
         PQzctDUKnPIIKoKYH6UswRk8zqYvU408d9nWIt1y5KwQ0FDW7uXN+fnodEv+gDbFGNNA
         G9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737436153; x=1738040953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJQfRyC3Wsudpzv9LLtI4oTXgl7XjBx9DhB6xX5CRmA=;
        b=eryiJPb+zTpMaXL8WBCzyOp7U+yCHbUrsyT+HTV77E2p/C8mAZ3PdIF/ROAeiZEcmD
         iwk2c0qQ4KXckIo/wvg/quA2grC1Sg2qlXCphZ6e6Aqz+LaGmJXfQPAfw1Zo1G5BmX1n
         3YlV0LfAEkQmOgMX5+B6DJp0w9FeUTgN9dUivSVSCRX//0/m8e15InvziFjz/yqNcvEy
         dV1WqfF0v/V0y8yzngamXiznvWXa4Sz7w0m5SSK4dmMv4/PDrDHs0Odm8BbLVd/oO10O
         LVdrOFX4u/LJCd4J1L+rScVlanqWHPhHSJHUoJhP7sgr/qMRPoFQgIOR9KTkANXxbPWP
         khAA==
X-Forwarded-Encrypted: i=1; AJvYcCWNbox1m4LfC5nqP10mZ+PVnxFNC9FJqzydB/Tay+nSMETtmkaQrYtKW6wBL4qySWGcR7Gs5B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsbxs1wbrosdYTPm6aT22TQCO7N2B5F7ekHAeJdluvlUUdQxBM
	58xQJI8fJhau2tthE0EgMlYE/fX5MYaCjLJkGnT+cPc9ViTYhvOVo4jxlAlXwxWCtrJHPXwMD6e
	zkBxapgsIr3gBkZk+cb4w70eK0dw=
X-Gm-Gg: ASbGncumJ5wJ2hbEklG9BuBMOMs/MA8bTVCVgntzTFasPjnScdBWkTDmwPm5Gf2atMX
	25yoplceqmzkAdh71ZfWIilJITiWpsm66vxWdP2sYV9PAG6sT2Jc=
X-Google-Smtp-Source: AGHT+IE08hPon2t7JQWZ73xzkucKDLJ54/L0vyFfsq41RSDlrT3eZ3yA5ijWsa93jHwNsPWITrVQHFtBIQsiaJKbASI=
X-Received: by 2002:a05:6e02:148f:b0:3cf:6c4f:396f with SMTP id
 e9e14a558f8ab-3cf7447c7cfmr125236365ab.15.1737436152686; Mon, 20 Jan 2025
 21:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com> <20250121012901.87763-3-kerneljasonxing@gmail.com>
In-Reply-To: <20250121012901.87763-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Jan 2025 13:08:36 +0800
X-Gm-Features: AbW1kvYarHVuBxdCmtWDJVlNxImYh8P0fsc9x69htjnLMINBztSjTf-Mq-C2Uq4
Message-ID: <CAL+tcoBzgjPn1Gmw9NdL0rXhomMJka=s0yvCpc=7GY+DP=AKmA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/13] net-timestamp: prepare for
 timestamping callbacks use
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Later, I would introduce four callback points to report information
> to user space based on this patch.
>
> As to skb initialization here, people can follow these three steps
> as below to fetch the shared info from the exported skb in the bpf
> prog:
> 1. skops_kern =3D bpf_cast_to_kern_ctx(skops);
> 2. skb =3D skops_kern->skb;
> 3. shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_info)=
;
>
> More details can be seen in the last selftest patch of the series.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/sock.h |  7 +++++++
>  net/core/sock.c    | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7916982343c6..6f4d54faba92 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
>                           struct so_timestamping timestamping);
>
>  void sock_enable_timestamps(struct sock *sk);
> +#if defined(CONFIG_CGROUP_BPF)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int=
 op);
> +#else
> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_=
buff *skb, int op)
> +{
> +}
> +#endif
>  void sock_no_linger(struct sock *sk);
>  void sock_set_keepalive(struct sock *sk);
>  void sock_set_priority(struct sock *sk, u32 priority);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index eae2ae70a2e0..e165163521dc 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -948,6 +948,19 @@ int sock_set_timestamping(struct sock *sk, int optna=
me,
>         return 0;
>  }
>

Oops, I accidentally remove the following protection:
#if defined(CONFIG_CGROUP_BPF)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int=
 op)
> +{
> +       struct bpf_sock_ops_kern sock_ops;
> +
> +       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +       sock_ops.op =3D op;
> +       sock_ops.is_fullsock =3D 1;
> +       sock_ops.sk =3D sk;
> +       bpf_skops_init_skb(&sock_ops, skb, 0);
> +       /* Timestamping bpf extension supports only TCP and UDP full sock=
et */
> +       __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> +}

And here:
#endif

I'll add them in the next version.

Thanks,
Jason

> +
>  void sock_set_keepalive(struct sock *sk)
>  {
>         lock_sock(sk);
> --
> 2.43.5
>

