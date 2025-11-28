Return-Path: <bpf+bounces-75674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166CC90B22
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 04:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BF2C34C03A
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF83288C20;
	Fri, 28 Nov 2025 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxYWz1vw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNmNttyI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB16270565
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298943; cv=none; b=UEXJoJ9m5cksh4aT2fLOBSl/JQpQm9fI/6d+ma8kohSVaiTQuVIEhmfvY7MPURLIZTxlcwapZYA2hIzkbfPuW+D3cBjxp5hb8Lkp2iWhxpGamSTmlIk4Hpb0gCosH+oTUxo/0rgF5Fy2/N66PWW5KbOTZAV8nXqVHWqPtmX6owA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298943; c=relaxed/simple;
	bh=dRqtZE1W2JnVrg3loh/r52YhX0ka0xKpniTFG22/y1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy6wQ1+gFPGsRvjVXiaG0ApMWI8FpLUA+xXFgrJUxVarSldlQZuU5Axt/jsUL6NpDErBKlPpDXdXElSNnIjYWYqoZJW/PvH1Z7zAdK4dMsQypV5r+Cpz6c1EtJavBeJJHd+3z6hG6mkxxdEPhVwvLmoTWEVoX9TLBzAt+TNnN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxYWz1vw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNmNttyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764298939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
	b=ZxYWz1vwl7eCF/IT8d6uiQWEXV1SKHpNkxMvxrh/WHi0HXtIyY4JpVDZX2JhV+RpgWck3r
	+omNidCnef5+/i7e9ecPXBuhuLFtIzVhzo5tCmYXWgC3WB6mOxEQnY1ALMdskWRrnz3Tsf
	04Wbqz3XHFl6/fW89GPZ8fctCyT+/MI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-jkp5JNjaOAyYa7DkK4boOQ-1; Thu, 27 Nov 2025 22:02:17 -0500
X-MC-Unique: jkp5JNjaOAyYa7DkK4boOQ-1
X-Mimecast-MFC-AGG-ID: jkp5JNjaOAyYa7DkK4boOQ_1764298937
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343daf0f488so1174700a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 19:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764298937; x=1764903737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
        b=PNmNttyIryeeL4v70hetGJzNeW7PuH0Me4HZOeQ6QHxHKhRK3bJ8ekXktljURCJD0W
         t76mlFaaQqooNDJkEXprtfEsd0IMTY4E3nDitpngJjcT7m/fCv8LWxX5GjZ2zQvYZbUV
         3uZcejbOPm4HOjMST4p1rYEsoQDOue19BBI5LMUhsyq7+MN6GtebGjU+FX78SBzhybNm
         kRIOugSNCAePX05LZz8t5wtfbIBGF+EkaCxHzVKs7tFIX4sY1JdNkWv40KAA0jH4utOG
         Mh/LDeP55pXbStzFZl95gmpHanfar+D0kA6k8cnOTzpVk94s4a2ve/BR6Fi8abfWyyvy
         FRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764298937; x=1764903737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+ddStysEuNpBbHzgItNVROsOVlJtz7kVHTtVmCFdRo=;
        b=gmcKt+gEVhNAZWS5fSW7FG0DFipxSClZUphL7U2etLO2+lZYxC5nCXVAjy7t+mnNJR
         k1YkQ0JjIIGr7iya2fhv+jO3rw1tgor/i7OZP2ajfKZJ1Edc2/H4r3UoGB69zrnLOGng
         khwa50aatG665LgVCAu1Ow3CLlgOWEhcR/G/WjrQ4QlbbUIyLavPM9a+d3reMl9W/Wa2
         8VqKeAqlR2rxg0zVY86SB8AE7J4XfplXUFTq5TGeN/v9SrgQRMBpNNZdELILjqxBFEGJ
         J69p7o/V8SAeCrrASne4ii1TlnUGKSNvu9eY4iJcSxoc41IkliBPEJthMkHv0ixNPhA3
         qvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqPAImV8xC7PiQp9yRoIvwH6WLl2b6BS95qssZYCkJ6rVXBssQ/CbkNGKeOMUGf+S5Vy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGHjOvm5ntK12CVsaLdDQPiNCo/0by0q8Z3o1gNbnnxMT9Nmd
	gEugbtQAxjr0UZ4WYs0l2hLd/0vyNZzRMSaXvyNOQtlFPW0rrYRj4iGmeYk9wHlJhzn28DuX99D
	4HJ1c/8Z4YoNaLPaqMRzLqzuPDNO6h2nrp7mcQF/ss7r5tjNQzAgctGDgdOW3HiKrKSmlNmZS32
	/ypd4H+i00qr7zsOzqlNH7IojYEQz3
X-Gm-Gg: ASbGncuDYOVgJ90MvMRmvVki3fdhyLJ3ANO0Tc3GqOA+WxbWZ7Df19phFFZn6LNRq0L
	aujSVXNo+DM72hH0mQKQ4ClfPDoiHpYn7UhChGxPuYJT3uExu/e7rFiKfdaF+yeuTzPsnzKOP1W
	VmzXs8IMmrZUFdTpndskypLid7qUSaG2LR1MrcnTHiTdkUVuLNnOhYVWVeF9H7T+OB
X-Received: by 2002:a17:902:e88b:b0:298:8ec:9993 with SMTP id d9443c01a7336-29bab148965mr146593685ad.38.1764298936692;
        Thu, 27 Nov 2025 19:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb/vno8tBL60EjWrJ0v3mEHZu6lI84RYKVvpcd7S9xmdup6uJ6jb7zQONK+XFQp9YOFydz+pix8DS6nLzyidI=
X-Received: by 2002:a17:902:e88b:b0:298:8ec:9993 with SMTP id
 d9443c01a7336-29bab148965mr146593295ad.38.1764298936199; Thu, 27 Nov 2025
 19:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125200041.1565663-1-jon@nutanix.com> <20251125200041.1565663-6-jon@nutanix.com>
In-Reply-To: <20251125200041.1565663-6-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 11:02:05 +0800
X-Gm-Features: AWmQ_bnD3FteqMoolfxSscqI3rlth8bjbR4RDzQCfkC6fXywE4Xhn0JdD8kvjT0
Message-ID: <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in tun_xdp_one
To: Jon Kohler <jon@nutanix.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:19=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> Optimize TUN_MSG_PTR batch processing by allocating sk_buff structures
> in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
> This reduces allocation overhead and improves efficiency, especially
> when IFF_NAPI is enabled and GRO is feeding entries back to the cache.

Does this mean we should only enable this when NAPI is used?

>
> If bulk allocation cannot fully satisfy the batch, gracefully drop only
> the uncovered portion, allowing the rest of the batch to proceed, which
> is what already happens in the previous case where build_skb() would
> fail and return -ENOMEM.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Do we have any benchmark result for this?

> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 97f130bc5fed..64f944cce517 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2420,13 +2420,13 @@ static void tun_put_page(struct tun_page *tpage)
>  static int tun_xdp_one(struct tun_struct *tun,
>                        struct tun_file *tfile,
>                        struct xdp_buff *xdp, int *flush,
> -                      struct tun_page *tpage)
> +                      struct tun_page *tpage,
> +                      struct sk_buff *skb)
>  {
>         unsigned int datasize =3D xdp->data_end - xdp->data;
>         struct virtio_net_hdr *gso =3D xdp->data_hard_start;
>         struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
>         struct bpf_prog *xdp_prog;
> -       struct sk_buff *skb =3D NULL;
>         struct sk_buff_head *queue;
>         netdev_features_t features;
>         u32 rxhash =3D 0, act;
> @@ -2437,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>         struct page *page;
>
>         if (unlikely(datasize < ETH_HLEN)) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
>                 dev_core_stats_rx_dropped_inc(tun->dev);
>                 return -EINVAL;
>         }
> @@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>                 ret =3D tun_xdp_act(tun, xdp_prog, xdp, act);
>                 if (ret < 0) {
>                         /* tun_xdp_act already handles drop statistics */
> +                       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);

This should belong to previous patches?

>                         put_page(virt_to_head_page(xdp->data));
>                         return ret;
>                 }
> @@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>                         *flush =3D true;
>                         fallthrough;
>                 case XDP_TX:
> +                       napi_consume_skb(skb, 1);
>                         return 0;
>                 case XDP_PASS:
>                         break;
> @@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>                                 tpage->page =3D page;
>                                 tpage->count =3D 1;
>                         }
> +                       napi_consume_skb(skb, 1);

I wonder if this would have any side effects since tun_xdp_one() is
not called by a NAPI.

>                         return 0;
>                 }
>         }
>
>  build:
> -       skb =3D build_skb(xdp->data_hard_start, buflen);
> +       skb =3D build_skb_around(skb, xdp->data_hard_start, buflen);
>         if (!skb) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
>                 dev_core_stats_rx_dropped_inc(tun->dev);
>                 return -ENOMEM;
>         }
> @@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock, struct=
 msghdr *m, size_t total_len)
>         if (m->msg_controllen =3D=3D sizeof(struct tun_msg_ctl) &&
>             ctl && ctl->type =3D=3D TUN_MSG_PTR) {
>                 struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> +               int flush =3D 0, queued =3D 0, num_skbs =3D 0;
>                 struct tun_page tpage;
>                 int n =3D ctl->num;
> -               int flush =3D 0, queued =3D 0;
> +               /* Max size of VHOST_NET_BATCH */
> +               void *skbs[64];

I think we need some tweaks

1) TUN is decoupled from vhost, so it should have its own value (a
macro is better)
2) Provide a way to fail or handle the case when more than 64

>
>                 memset(&tpage, 0, sizeof(tpage));
>
> @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock, struc=
t msghdr *m, size_t total_len)
>                 rcu_read_lock();
>                 bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
>
> -               for (i =3D 0; i < n; i++) {
> +               num_skbs =3D napi_skb_cache_get_bulk(skbs, n);

Its document said:

"""
 * Must be called *only* from the BH context.
"""

> +
> +               for (i =3D 0; i < num_skbs; i++) {
> +                       struct sk_buff *skb =3D skbs[i];
>                         xdp =3D &((struct xdp_buff *)ctl->ptr)[i];
> -                       ret =3D tun_xdp_one(tun, tfile, xdp, &flush, &tpa=
ge);
> +                       ret =3D tun_xdp_one(tun, tfile, xdp, &flush, &tpa=
ge,
> +                                         skb);
>                         if (ret > 0)
>                                 queued +=3D ret;
>                 }
>
> +               /* Handle remaining xdp_buff entries if num_skbs < ctl->n=
um */
> +               for (i =3D num_skbs; i < ctl->num; i++) {
> +                       xdp =3D &((struct xdp_buff *)ctl->ptr)[i];
> +                       dev_core_stats_rx_dropped_inc(tun->dev);

Could we do this in a batch?

> +                       put_page(virt_to_head_page(xdp->data));
> +               }
> +
>                 if (flush)
>                         xdp_do_flush();
>
> --
> 2.43.0
>

Thanks


