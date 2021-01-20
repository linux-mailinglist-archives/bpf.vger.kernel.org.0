Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C553B2FDAF9
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbhATU0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 15:26:55 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:36005 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732463AbhATN5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 08:57:02 -0500
X-Greylist: delayed 90664 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2021 08:56:58 EST
Date:   Wed, 20 Jan 2021 13:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1611150972; bh=PE7V/3plIiCk7iENEPTfzL5HtZUy5vQDfr/MINvH93w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=chX6h0ouLTif5ozoqriI8OPrSRoACMRWaUNReTEQbz95JBSG6iEQAxZw8vjtp26gS
         nCvRMeMEF2E0nS0Y7ghATC10fTWd17OJx6Gqd3M07u2NSdCxskIHJ3o81VeREfujMS
         KJYJoiDaTYM6h8Vxh4KgHjwXW9BjZMBJVrMLv5tGTDRmbK1suhXqZf/THAeZUenSa+
         GExvKrbxgcA8y2tNXCbrskrLYokE/ONVKwUvlRPm/HSzJhH9SpkK9pcJhXRJzdFHNW
         MkgI16LVqsni7rYlJLUs3U2vI8Lit0A/Uq/p69iEyp+UrgpSSxmjzEMaa9dKYlLV2U
         RTo47e/j9yOCQ==
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bjorn.topel@intel.com,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH net-next v2 3/3] xsk: build skb by page
Message-ID: <20210120135537.5184-1-alobakin@pm.me>
In-Reply-To: <0461512be1925bece9bcda1b4924b09eaa4edd87.1611131344.git.xuanzhuo@linux.alibaba.com>
References: <0461512be1925bece9bcda1b4924b09eaa4edd87.1611131344.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Wed, 20 Jan 2021 16:30:56 +0800

> This patch is used to construct skb based on page to save memory copy
> overhead.
>=20
> This function is implemented based on IFF_TX_SKB_NO_LINEAR. Only the
> network card priv_flags supports IFF_TX_SKB_NO_LINEAR will use page to
> directly construct skb. If this feature is not supported, it is still
> necessary to copy data to construct skb.
>=20
> ---------------- Performance Testing ------------
>=20
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
>=20
> Test result data:
>=20
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>  net/xdp/xsk.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 86 insertions(+), 18 deletions(-)

Now I like the result, thanks!

But Patchwork still display your series incorrectly (messages 0 and 1
are missing). I'm concerning maintainers may not take this in such
form. Try to pass the folder's name, not folder/*.patch to
git send-email when sending, and don't use --in-reply-to when sending
a new iteration.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 8037b04..40bac11 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -430,6 +430,87 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  =09sock_wfree(skb);
>  }
>=20
> +static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> +=09=09=09=09=09      struct xdp_desc *desc)
> +{
> +=09u32 len, offset, copy, copied;
> +=09struct sk_buff *skb;
> +=09struct page *page;
> +=09void *buffer;
> +=09int err, i;
> +=09u64 addr;
> +
> +=09skb =3D sock_alloc_send_skb(&xs->sk, 0, 1, &err);
> +=09if (unlikely(!skb))
> +=09=09return ERR_PTR(err);
> +
> +=09addr =3D desc->addr;
> +=09len =3D desc->len;
> +
> +=09buffer =3D xsk_buff_raw_get_data(xs->pool, addr);
> +=09offset =3D offset_in_page(buffer);
> +=09addr =3D buffer - xs->pool->addrs;
> +
> +=09for (copied =3D 0, i =3D 0; copied < len; i++) {
> +=09=09page =3D xs->pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +=09=09get_page(page);
> +
> +=09=09copy =3D min_t(u32, PAGE_SIZE - offset, len - copied);
> +
> +=09=09skb_fill_page_desc(skb, i, page, offset, copy);
> +
> +=09=09copied +=3D copy;
> +=09=09addr +=3D copy;
> +=09=09offset =3D 0;
> +=09}
> +
> +=09skb->len +=3D len;
> +=09skb->data_len +=3D len;
> +=09skb->truesize +=3D len;
> +
> +=09refcount_add(len, &xs->sk.sk_wmem_alloc);
> +
> +=09return skb;
> +}
> +
> +static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +=09=09=09=09     struct xdp_desc *desc)
> +{
> +=09struct sk_buff *skb =3D NULL;
> +
> +=09if (xs->dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> +=09=09skb =3D xsk_build_skb_zerocopy(xs, desc);
> +=09=09if (IS_ERR(skb))
> +=09=09=09return skb;
> +=09} else {
> +=09=09void *buffer;
> +=09=09u32 len;
> +=09=09int err;
> +
> +=09=09len =3D desc->len;
> +=09=09skb =3D sock_alloc_send_skb(&xs->sk, len, 1, &err);
> +=09=09if (unlikely(!skb))
> +=09=09=09return ERR_PTR(err);
> +
> +=09=09skb_put(skb, len);
> +=09=09buffer =3D xsk_buff_raw_get_data(xs->pool, desc->addr);
> +=09=09err =3D skb_store_bits(skb, 0, buffer, len);
> +=09=09if (unlikely(err)) {
> +=09=09=09kfree_skb(skb);
> +=09=09=09return ERR_PTR(err);
> +=09=09}
> +=09}
> +
> +=09skb->dev =3D xs->dev;
> +=09skb->priority =3D xs->sk.sk_priority;
> +=09skb->mark =3D xs->sk.sk_mark;
> +=09skb_shinfo(skb)->destructor_arg =3D (void *)(long)desc->addr;
> +=09skb->destructor =3D xsk_destruct_skb;
> +
> +=09return skb;
> +}
> +
>  static int xsk_generic_xmit(struct sock *sk)
>  {
>  =09struct xdp_sock *xs =3D xdp_sk(sk);
> @@ -446,43 +527,30 @@ static int xsk_generic_xmit(struct sock *sk)
>  =09=09goto out;
>=20
>  =09while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -=09=09char *buffer;
> -=09=09u64 addr;
> -=09=09u32 len;
> -
>  =09=09if (max_batch-- =3D=3D 0) {
>  =09=09=09err =3D -EAGAIN;
>  =09=09=09goto out;
>  =09=09}
>=20
> -=09=09len =3D desc.len;
> -=09=09skb =3D sock_alloc_send_skb(sk, len, 1, &err);
> -=09=09if (unlikely(!skb))
> +=09=09skb =3D xsk_build_skb(xs, &desc);
> +=09=09if (IS_ERR(skb)) {
> +=09=09=09err =3D PTR_ERR(skb);
>  =09=09=09goto out;
> +=09=09}
>=20
> -=09=09skb_put(skb, len);
> -=09=09addr =3D desc.addr;
> -=09=09buffer =3D xsk_buff_raw_get_data(xs->pool, addr);
> -=09=09err =3D skb_store_bits(skb, 0, buffer, len);
>  =09=09/* This is the backpressure mechanism for the Tx path.
>  =09=09 * Reserve space in the completion queue and only proceed
>  =09=09 * if there is space in it. This avoids having to implement
>  =09=09 * any buffering in the Tx path.
>  =09=09 */
>  =09=09spin_lock_irqsave(&xs->pool->cq_lock, flags);
> -=09=09if (unlikely(err) || xskq_prod_reserve(xs->pool->cq)) {
> +=09=09if (xskq_prod_reserve(xs->pool->cq)) {
>  =09=09=09spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>  =09=09=09kfree_skb(skb);
>  =09=09=09goto out;
>  =09=09}
>  =09=09spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
>=20
> -=09=09skb->dev =3D xs->dev;
> -=09=09skb->priority =3D sk->sk_priority;
> -=09=09skb->mark =3D sk->sk_mark;
> -=09=09skb_shinfo(skb)->destructor_arg =3D (void *)(long)desc.addr;
> -=09=09skb->destructor =3D xsk_destruct_skb;
> -
>  =09=09err =3D __dev_direct_xmit(skb, xs->queue_id);
>  =09=09if  (err =3D=3D NETDEV_TX_BUSY) {
>  =09=09=09/* Tell user-space to retry the send */
> --
> 1.8.3.1

Al

