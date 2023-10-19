Return-Path: <bpf+bounces-12663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548877CEFF1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F031C20D67
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B32104;
	Thu, 19 Oct 2023 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlqhRM3q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64663A1
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:14:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E611B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697696083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaoX9q6thKlB+2I1d+DCIncQXMpQXvV56vmw4EL+YqE=;
	b=AlqhRM3qj+h+t01QdDsnPrLVKu1saIFRwQOeiD0AiZFzx6N2cFc6+a8qeor1S//96Q8SxB
	KVCc31QCo1Xbuc3N95lWrh0AXLA4TW51lsFdDeYt/Irk6vCGppTykOLIOnTR7718yoaXtM
	9ec1FvFwBxTtNLSKT76tznSty3NCLGE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-wlONc4xTOqe9ko4eddq4YA-1; Thu, 19 Oct 2023 02:14:40 -0400
X-MC-Unique: wlONc4xTOqe9ko4eddq4YA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c51d0f97e3so41700421fa.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696079; x=1698300879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaoX9q6thKlB+2I1d+DCIncQXMpQXvV56vmw4EL+YqE=;
        b=v07x/ZFtOhNGsRkKwzjbNLr9h4movJYWZRyWHKR7YcTHDLKRBk6dMF+TfWFssiplCx
         cCTgubldt4qJ+PQ8rDIioBrmPKmVGqr/xgVo7xRBcskAi73fSY5/gcpBXwonXKGc9hkQ
         soSq8ObvP8zkPJkSF9fFj9cPwDcGF/wwHwNPXrqtrZSIQ5awRw6Qtjt0Xf6yoevh/BOc
         J0B/oSAbIukY4hZBj7oWp7Aqbqe1gQqwHs67s3QaLydPdrIt2xMa2GUpt9dzHuYiFPRO
         u6X5PNMPR3z9hj2IfDQO4VhLFGXynT2+jjkcQIrNyh3C34hPn/7UTVO9SkqYfE8cfWSd
         FoHw==
X-Gm-Message-State: AOJu0YzK5r6mPZvhabqWC9PrYCivoL9GTNQ+IxmiPTyN9U6XYpL90Udo
	9a8CqCkPnPh6XMuvo+JxS5fXZtYSiNzUCkwll6wKUE9qubdeO/4lYL4z8b18WwpF+jZEG1+3Anq
	iXnt7MMPddU2EG6ZPCvCOQM3Yz3Cn
X-Received: by 2002:a05:651c:504:b0:2c1:375a:b37c with SMTP id o4-20020a05651c050400b002c1375ab37cmr641277ljp.40.1697696079167;
        Wed, 18 Oct 2023 23:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBTT2NYXRh+ikFuqxWTl27ffuH4vUMzVfxcxXtJwXaHCwNGlO3S5qn+SOdMBy2fmayTRTyUnd1rLTyH1rnC0E=
X-Received: by 2002:a05:651c:504:b0:2c1:375a:b37c with SMTP id
 o4-20020a05651c050400b002c1375ab37cmr641265ljp.40.1697696078563; Wed, 18 Oct
 2023 23:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:14:27 +0800
Message-ID: <CACGkMEvQvyjxX7PKVtTjMMtQNX3PzuviL=sA5sMftEToduZ5RA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 05/19] virtio_net: add prefix virtnet to all
 struct/api inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> We move some structures and APIs to the header file, but these
> structures and APIs do not prefixed with virtnet. This patch adds
> virtnet for these.

What's the benefit of doing this? AFAIK virtio-net is the only user
for virtio-net.h?

THanks

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 122 ++++++++++++++++----------------
>  drivers/net/virtio/virtio_net.h |  30 ++++----
>  2 files changed, 76 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index d8b6c0d86f29..ba38b6078e1d 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -180,7 +180,7 @@ skb_vnet_common_hdr(struct sk_buff *skb)
>   * private is used to chain pages for big packets, put the whole
>   * most recent used list in the beginning for reuse
>   */
> -static void give_pages(struct receive_queue *rq, struct page *page)
> +static void give_pages(struct virtnet_rq *rq, struct page *page)
>  {
>         struct page *end;
>
> @@ -190,7 +190,7 @@ static void give_pages(struct receive_queue *rq, stru=
ct page *page)
>         rq->pages =3D page;
>  }
>
> -static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> +static struct page *get_a_page(struct virtnet_rq *rq, gfp_t gfp_mask)
>  {
>         struct page *p =3D rq->pages;
>
> @@ -225,7 +225,7 @@ static void virtqueue_napi_complete(struct napi_struc=
t *napi,
>         opaque =3D virtqueue_enable_cb_prepare(vq);
>         if (napi_complete_done(napi, processed)) {
>                 if (unlikely(virtqueue_poll(vq, opaque)))
> -                       virtqueue_napi_schedule(napi, vq);
> +                       virtnet_vq_napi_schedule(napi, vq);
>         } else {
>                 virtqueue_disable_cb(vq);
>         }
> @@ -240,7 +240,7 @@ static void skb_xmit_done(struct virtqueue *vq)
>         virtqueue_disable_cb(vq);
>
>         if (napi->weight)
> -               virtqueue_napi_schedule(napi, vq);
> +               virtnet_vq_napi_schedule(napi, vq);
>         else
>                 /* We were probably waiting for more output buffers. */
>                 netif_wake_subqueue(vi->dev, vq2txq(vq));
> @@ -281,7 +281,7 @@ static struct sk_buff *virtnet_build_skb(void *buf, u=
nsigned int buflen,
>
>  /* Called from bottom half context */
>  static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> -                                  struct receive_queue *rq,
> +                                  struct virtnet_rq *rq,
>                                    struct page *page, unsigned int offset=
,
>                                    unsigned int len, unsigned int truesiz=
e,
>                                    unsigned int headroom)
> @@ -380,7 +380,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>         return skb;
>  }
>
> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 le=
n)
> +static void virtnet_rq_unmap(struct virtnet_rq *rq, void *buf, u32 len)
>  {
>         struct page *page =3D virt_to_head_page(buf);
>         struct virtnet_rq_dma *dma;
> @@ -409,7 +409,7 @@ static void virtnet_rq_unmap(struct receive_queue *rq=
, void *buf, u32 len)
>         put_page(page);
>  }
>
> -static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void=
 **ctx)
> +static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **=
ctx)
>  {
>         void *buf;
>
> @@ -420,7 +420,7 @@ static void *virtnet_rq_get_buf(struct receive_queue =
*rq, u32 *len, void **ctx)
>         return buf;
>  }
>
> -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> +static void *virtnet_rq_detach_unused_buf(struct virtnet_rq *rq)
>  {
>         void *buf;
>
> @@ -431,7 +431,7 @@ static void *virtnet_rq_detach_unused_buf(struct rece=
ive_queue *rq)
>         return buf;
>  }
>
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
> +static void virtnet_rq_init_one_sg(struct virtnet_rq *rq, void *buf, u32=
 len)
>  {
>         struct virtnet_rq_dma *dma;
>         dma_addr_t addr;
> @@ -456,7 +456,7 @@ static void virtnet_rq_init_one_sg(struct receive_que=
ue *rq, void *buf, u32 len)
>         rq->sg[0].length =3D len;
>  }
>
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> +static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp=
)
>  {
>         struct page_frag *alloc_frag =3D &rq->alloc_frag;
>         struct virtnet_rq_dma *dma;
> @@ -530,11 +530,11 @@ static void virtnet_rq_set_premapped(struct virtnet=
_info *vi)
>         }
>  }
>
> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> +static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
>  {
>         struct virtnet_sq_stats stats =3D {};
>
> -       __free_old_xmit(sq, in_napi, &stats);
> +       virtnet_free_old_xmit(sq, in_napi, &stats);
>
>         /* Avoid overhead when no packets have been processed
>          * happens when called speculatively from start_xmit.
> @@ -550,7 +550,7 @@ static void free_old_xmit(struct send_queue *sq, bool=
 in_napi)
>
>  static void check_sq_full_and_disable(struct virtnet_info *vi,
>                                       struct net_device *dev,
> -                                     struct send_queue *sq)
> +                                     struct virtnet_sq *sq)
>  {
>         bool use_napi =3D sq->napi.weight;
>         int qnum;
> @@ -571,7 +571,7 @@ static void check_sq_full_and_disable(struct virtnet_=
info *vi,
>                 netif_stop_subqueue(dev, qnum);
>                 if (use_napi) {
>                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> -                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> +                               virtnet_vq_napi_schedule(&sq->napi, sq->v=
q);
>                 } else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))=
) {
>                         /* More just got used, free them then recheck. */
>                         free_old_xmit(sq, false);
> @@ -584,7 +584,7 @@ static void check_sq_full_and_disable(struct virtnet_=
info *vi,
>  }
>
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> -                                  struct send_queue *sq,
> +                                  struct virtnet_sq *sq,
>                                    struct xdp_frame *xdpf)
>  {
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> @@ -674,9 +674,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         struct virtnet_sq_stats stats =3D {};
> -       struct receive_queue *rq =3D vi->rq;
> +       struct virtnet_rq *rq =3D vi->rq;
>         struct bpf_prog *xdp_prog;
> -       struct send_queue *sq;
> +       struct virtnet_sq *sq;
>         int nxmit =3D 0;
>         int kicks =3D 0;
>         int ret;
> @@ -697,7 +697,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>
>         /* Free up any pending old buffers before queueing new ones. */
> -       __free_old_xmit(sq, false, &stats);
> +       virtnet_free_old_xmit(sq, false, &stats);
>
>         for (i =3D 0; i < n; i++) {
>                 struct xdp_frame *xdpf =3D frames[i];
> @@ -708,7 +708,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>         ret =3D nxmit;
>
> -       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> +       if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>                 check_sq_full_and_disable(vi, dev, sq);
>
>         if (flags & XDP_XMIT_FLUSH) {
> @@ -816,7 +816,7 @@ static unsigned int virtnet_get_headroom(struct virtn=
et_info *vi)
>   * across multiple buffers (num_buf > 1), and we make sure buffers
>   * have enough headroom.
>   */
> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> +static struct page *xdp_linearize_page(struct virtnet_rq *rq,
>                                        int *num_buf,
>                                        struct page *p,
>                                        int offset,
> @@ -897,7 +897,7 @@ static struct sk_buff *receive_small_build_skb(struct=
 virtnet_info *vi,
>
>  static struct sk_buff *receive_small_xdp(struct net_device *dev,
>                                          struct virtnet_info *vi,
> -                                        struct receive_queue *rq,
> +                                        struct virtnet_rq *rq,
>                                          struct bpf_prog *xdp_prog,
>                                          void *buf,
>                                          unsigned int xdp_headroom,
> @@ -984,7 +984,7 @@ static struct sk_buff *receive_small_xdp(struct net_d=
evice *dev,
>
>  static struct sk_buff *receive_small(struct net_device *dev,
>                                      struct virtnet_info *vi,
> -                                    struct receive_queue *rq,
> +                                    struct virtnet_rq *rq,
>                                      void *buf, void *ctx,
>                                      unsigned int len,
>                                      unsigned int *xdp_xmit,
> @@ -1031,7 +1031,7 @@ static struct sk_buff *receive_small(struct net_dev=
ice *dev,
>
>  static struct sk_buff *receive_big(struct net_device *dev,
>                                    struct virtnet_info *vi,
> -                                  struct receive_queue *rq,
> +                                  struct virtnet_rq *rq,
>                                    void *buf,
>                                    unsigned int len,
>                                    struct virtnet_rq_stats *stats)
> @@ -1052,7 +1052,7 @@ static struct sk_buff *receive_big(struct net_devic=
e *dev,
>         return NULL;
>  }
>
> -static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
> +static void mergeable_buf_free(struct virtnet_rq *rq, int num_buf,
>                                struct net_device *dev,
>                                struct virtnet_rq_stats *stats)
>  {
> @@ -1126,7 +1126,7 @@ static struct sk_buff *build_skb_from_xdp_buff(stru=
ct net_device *dev,
>  /* TODO: build xdp in big mode */
>  static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>                                       struct virtnet_info *vi,
> -                                     struct receive_queue *rq,
> +                                     struct virtnet_rq *rq,
>                                       struct xdp_buff *xdp,
>                                       void *buf,
>                                       unsigned int len,
> @@ -1214,7 +1214,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>  }
>
>  static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> -                                  struct receive_queue *rq,
> +                                  struct virtnet_rq *rq,
>                                    struct bpf_prog *xdp_prog,
>                                    void *ctx,
>                                    unsigned int *frame_sz,
> @@ -1289,7 +1289,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>
>  static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>                                              struct virtnet_info *vi,
> -                                            struct receive_queue *rq,
> +                                            struct virtnet_rq *rq,
>                                              struct bpf_prog *xdp_prog,
>                                              void *buf,
>                                              void *ctx,
> @@ -1349,7 +1349,7 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                          struct virtnet_info *vi,
> -                                        struct receive_queue *rq,
> +                                        struct virtnet_rq *rq,
>                                          void *buf,
>                                          void *ctx,
>                                          unsigned int len,
> @@ -1494,7 +1494,7 @@ static void virtio_skb_set_hash(const struct virtio=
_net_hdr_v1_hash *hdr_hash,
>         skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
>  }
>
> -static void receive_buf(struct virtnet_info *vi, struct receive_queue *r=
q,
> +static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
>                         void *buf, unsigned int len, void **ctx,
>                         unsigned int *xdp_xmit,
>                         struct virtnet_rq_stats *stats)
> @@ -1554,7 +1554,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>   * not need to use  mergeable_len_to_ctx here - it is enough
>   * to store the headroom as the context ignoring the truesize.
>   */
> -static int add_recvbuf_small(struct virtnet_info *vi, struct receive_que=
ue *rq,
> +static int add_recvbuf_small(struct virtnet_info *vi, struct virtnet_rq =
*rq,
>                              gfp_t gfp)
>  {
>         char *buf;
> @@ -1583,7 +1583,7 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>         return err;
>  }
>
> -static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue=
 *rq,
> +static int add_recvbuf_big(struct virtnet_info *vi, struct virtnet_rq *r=
q,
>                            gfp_t gfp)
>  {
>         struct page *first, *list =3D NULL;
> @@ -1632,7 +1632,7 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return err;
>  }
>
> -static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> +static unsigned int get_mergeable_buf_len(struct virtnet_rq *rq,
>                                           struct ewma_pkt_len *avg_pkt_le=
n,
>                                           unsigned int room)
>  {
> @@ -1650,7 +1650,7 @@ static unsigned int get_mergeable_buf_len(struct re=
ceive_queue *rq,
>  }
>
>  static int add_recvbuf_mergeable(struct virtnet_info *vi,
> -                                struct receive_queue *rq, gfp_t gfp)
> +                                struct virtnet_rq *rq, gfp_t gfp)
>  {
>         struct page_frag *alloc_frag =3D &rq->alloc_frag;
>         unsigned int headroom =3D virtnet_get_headroom(vi);
> @@ -1705,7 +1705,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>   * before we're receiving packets, or from refill_work which is
>   * careful to disable receiving (using napi_disable).
>   */
> -static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue =
*rq,
> +static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq=
,
>                           gfp_t gfp)
>  {
>         int err;
> @@ -1737,9 +1737,9 @@ static bool try_fill_recv(struct virtnet_info *vi, =
struct receive_queue *rq,
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>         struct virtnet_info *vi =3D rvq->vdev->priv;
> -       struct receive_queue *rq =3D &vi->rq[vq2rxq(rvq)];
> +       struct virtnet_rq *rq =3D &vi->rq[vq2rxq(rvq)];
>
> -       virtqueue_napi_schedule(&rq->napi, rvq);
> +       virtnet_vq_napi_schedule(&rq->napi, rvq);
>  }
>
>  static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct=
 *napi)
> @@ -1751,7 +1751,7 @@ static void virtnet_napi_enable(struct virtqueue *v=
q, struct napi_struct *napi)
>          * Call local_bh_enable after to trigger softIRQ processing.
>          */
>         local_bh_disable();
> -       virtqueue_napi_schedule(napi, vq);
> +       virtnet_vq_napi_schedule(napi, vq);
>         local_bh_enable();
>  }
>
> @@ -1787,7 +1787,7 @@ static void refill_work(struct work_struct *work)
>         int i;
>
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> -               struct receive_queue *rq =3D &vi->rq[i];
> +               struct virtnet_rq *rq =3D &vi->rq[i];
>
>                 napi_disable(&rq->napi);
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> @@ -1801,7 +1801,7 @@ static void refill_work(struct work_struct *work)
>         }
>  }
>
> -static int virtnet_receive(struct receive_queue *rq, int budget,
> +static int virtnet_receive(struct virtnet_rq *rq, int budget,
>                            unsigned int *xdp_xmit)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> @@ -1848,14 +1848,14 @@ static int virtnet_receive(struct receive_queue *=
rq, int budget,
>         return stats.packets;
>  }
>
> -static void virtnet_poll_cleantx(struct receive_queue *rq)
> +static void virtnet_poll_cleantx(struct virtnet_rq *rq)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
>         unsigned int index =3D vq2rxq(rq->vq);
> -       struct send_queue *sq =3D &vi->sq[index];
> +       struct virtnet_sq *sq =3D &vi->sq[index];
>         struct netdev_queue *txq =3D netdev_get_tx_queue(vi->dev, index);
>
> -       if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
> +       if (!sq->napi.weight || virtnet_is_xdp_raw_buffer_queue(vi, index=
))
>                 return;
>
>         if (__netif_tx_trylock(txq)) {
> @@ -1878,10 +1878,10 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq)
>
>  static int virtnet_poll(struct napi_struct *napi, int budget)
>  {
> -       struct receive_queue *rq =3D
> -               container_of(napi, struct receive_queue, napi);
> +       struct virtnet_rq *rq =3D
> +               container_of(napi, struct virtnet_rq, napi);
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct send_queue *sq;
> +       struct virtnet_sq *sq;
>         unsigned int received;
>         unsigned int xdp_xmit =3D 0;
>
> @@ -1972,14 +1972,14 @@ static int virtnet_open(struct net_device *dev)
>
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  {
> -       struct send_queue *sq =3D container_of(napi, struct send_queue, n=
api);
> +       struct virtnet_sq *sq =3D container_of(napi, struct virtnet_sq, n=
api);
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         unsigned int index =3D vq2txq(sq->vq);
>         struct netdev_queue *txq;
>         int opaque;
>         bool done;
>
> -       if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
> +       if (unlikely(virtnet_is_xdp_raw_buffer_queue(vi, index))) {
>                 /* We don't need to enable cb for XDP */
>                 napi_complete_done(napi, 0);
>                 return 0;
> @@ -2016,7 +2016,7 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>         return 0;
>  }
>
> -static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> +static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
>  {
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
>         const unsigned char *dest =3D ((struct ethhdr *)skb->data)->h_des=
t;
> @@ -2067,7 +2067,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         int qnum =3D skb_get_queue_mapping(skb);
> -       struct send_queue *sq =3D &vi->sq[qnum];
> +       struct virtnet_sq *sq =3D &vi->sq[qnum];
>         int err;
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnum);
>         bool kick =3D !netdev_xmit_more();
> @@ -2121,7 +2121,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>  }
>
>  static int virtnet_rx_resize(struct virtnet_info *vi,
> -                            struct receive_queue *rq, u32 ring_num)
> +                            struct virtnet_rq *rq, u32 ring_num)
>  {
>         bool running =3D netif_running(vi->dev);
>         int err, qindex;
> @@ -2144,7 +2144,7 @@ static int virtnet_rx_resize(struct virtnet_info *v=
i,
>  }
>
>  static int virtnet_tx_resize(struct virtnet_info *vi,
> -                            struct send_queue *sq, u32 ring_num)
> +                            struct virtnet_sq *sq, u32 ring_num)
>  {
>         bool running =3D netif_running(vi->dev);
>         struct netdev_queue *txq;
> @@ -2290,8 +2290,8 @@ static void virtnet_stats(struct net_device *dev,
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 u64 tpackets, tbytes, terrors, rpackets, rbytes, rdrops;
> -               struct receive_queue *rq =3D &vi->rq[i];
> -               struct send_queue *sq =3D &vi->sq[i];
> +               struct virtnet_rq *rq =3D &vi->rq[i];
> +               struct virtnet_sq *sq =3D &vi->sq[i];
>
>                 do {
>                         start =3D u64_stats_fetch_begin(&sq->stats.syncp)=
;
> @@ -2604,8 +2604,8 @@ static int virtnet_set_ringparam(struct net_device =
*dev,
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         u32 rx_pending, tx_pending;
> -       struct receive_queue *rq;
> -       struct send_queue *sq;
> +       struct virtnet_rq *rq;
> +       struct virtnet_sq *sq;
>         int i, err;
>
>         if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -2909,7 +2909,7 @@ static void virtnet_get_ethtool_stats(struct net_de=
vice *dev,
>         size_t offset;
>
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> -               struct receive_queue *rq =3D &vi->rq[i];
> +               struct virtnet_rq *rq =3D &vi->rq[i];
>
>                 stats_base =3D (u8 *)&rq->stats;
>                 do {
> @@ -2923,7 +2923,7 @@ static void virtnet_get_ethtool_stats(struct net_de=
vice *dev,
>         }
>
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> -               struct send_queue *sq =3D &vi->sq[i];
> +               struct virtnet_sq *sq =3D &vi->sq[i];
>
>                 stats_base =3D (u8 *)&sq->stats;
>                 do {
> @@ -3604,7 +3604,7 @@ static int virtnet_set_features(struct net_device *=
dev,
>  static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqu=
eue)
>  {
>         struct virtnet_info *priv =3D netdev_priv(dev);
> -       struct send_queue *sq =3D &priv->sq[txqueue];
> +       struct virtnet_sq *sq =3D &priv->sq[txqueue];
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
>
>         u64_stats_update_begin(&sq->stats.syncp);
> @@ -3729,10 +3729,10 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!is_xdp_frame(buf))
> +       if (!virtnet_is_xdp_frame(buf))
>                 dev_kfree_skb(buf);
>         else
> -               xdp_return_frame(ptr_to_xdp(buf));
> +               xdp_return_frame(virtnet_ptr_to_xdp(buf));
>  }
>
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> @@ -3761,7 +3761,7 @@ static void free_unused_bufs(struct virtnet_info *v=
i)
>         }
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               struct receive_queue *rq =3D &vi->rq[i];
> +               struct virtnet_rq *rq =3D &vi->rq[i];
>
>                 while ((buf =3D virtnet_rq_detach_unused_buf(rq)) !=3D NU=
LL)
>                         virtnet_rq_free_unused_buf(rq->vq, buf);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index ddaf0ecf4d9d..282504d6639a 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -59,8 +59,8 @@ struct virtnet_rq_dma {
>  };
>
>  /* Internal representation of a send virtqueue */
> -struct send_queue {
> -       /* Virtqueue associated with this send _queue */
> +struct virtnet_sq {
> +       /* Virtqueue associated with this virtnet_sq */
>         struct virtqueue *vq;
>
>         /* TX: fragments + linear part + virtio header */
> @@ -80,8 +80,8 @@ struct send_queue {
>  };
>
>  /* Internal representation of a receive virtqueue */
> -struct receive_queue {
> -       /* Virtqueue associated with this receive_queue */
> +struct virtnet_rq {
> +       /* Virtqueue associated with this virtnet_rq */
>         struct virtqueue *vq;
>
>         struct napi_struct napi;
> @@ -123,8 +123,8 @@ struct virtnet_info {
>         struct virtio_device *vdev;
>         struct virtqueue *cvq;
>         struct net_device *dev;
> -       struct send_queue *sq;
> -       struct receive_queue *rq;
> +       struct virtnet_sq *sq;
> +       struct virtnet_rq *rq;
>         unsigned int status;
>
>         /* Max # of queue pairs supported by the device */
> @@ -201,24 +201,24 @@ struct virtnet_info {
>         struct failover *failover;
>  };
>
> -static inline bool is_xdp_frame(void *ptr)
> +static inline bool virtnet_is_xdp_frame(void *ptr)
>  {
>         return (unsigned long)ptr & VIRTIO_XDP_FLAG;
>  }
>
> -static inline struct xdp_frame *ptr_to_xdp(void *ptr)
> +static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
>  {
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> -static inline void __free_old_xmit(struct send_queue *sq, bool in_napi,
> -                                  struct virtnet_sq_stats *stats)
> +static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_=
napi,
> +                                        struct virtnet_sq_stats *stats)
>  {
>         unsigned int len;
>         void *ptr;
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               if (!is_xdp_frame(ptr)) {
> +               if (!virtnet_is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
> @@ -226,7 +226,7 @@ static inline void __free_old_xmit(struct send_queue =
*sq, bool in_napi,
>                         stats->bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
>                 } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +                       struct xdp_frame *frame =3D virtnet_ptr_to_xdp(pt=
r);
>
>                         stats->bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
> @@ -235,8 +235,8 @@ static inline void __free_old_xmit(struct send_queue =
*sq, bool in_napi,
>         }
>  }
>
> -static inline void virtqueue_napi_schedule(struct napi_struct *napi,
> -                                          struct virtqueue *vq)
> +static inline void virtnet_vq_napi_schedule(struct napi_struct *napi,
> +                                           struct virtqueue *vq)
>  {
>         if (napi_schedule_prep(napi)) {
>                 virtqueue_disable_cb(vq);
> @@ -244,7 +244,7 @@ static inline void virtqueue_napi_schedule(struct nap=
i_struct *napi,
>         }
>  }
>
> -static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int =
q)
> +static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *=
vi, int q)
>  {
>         if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
>                 return false;
> --
> 2.32.0.3.g01195cf9f
>


