Return-Path: <bpf+bounces-12662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8317CEFED
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96951C20D96
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591B2104;
	Thu, 19 Oct 2023 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TipE8y9t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD598610A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:13:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993AFE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697695990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBn/pL5jjDgY1hx4gDJsDMHxcedqktTOUoT9HrZ6ESA=;
	b=TipE8y9tLqm825sV8H/VWDYFLSVaYezyjsJ3q97ThISLEZ1ypyinUwf02EbsJz+svBGR7Y
	OAKYQCO11jkoINhbsMiS/KwPnZCkeGNZuXk8UmzXhUcDOv2z6ZKIbs523IhRIpcI3uWMjO
	MTVuaUZ74grll4xyqPU/Mz9UpbXjsDo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-wJGINHXPPvePsFHKjLL3KQ-1; Thu, 19 Oct 2023 02:13:08 -0400
X-MC-Unique: wJGINHXPPvePsFHKjLL3KQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507c8a8e5d1so1570953e87.3
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695987; x=1698300787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBn/pL5jjDgY1hx4gDJsDMHxcedqktTOUoT9HrZ6ESA=;
        b=LqiWZLFjJWwLI7VN5b3G4Qg3Pi7GdRBPbxfJewdl9+2IkNHurjHT05lSH3kQ4ca31j
         u+pFb6a0q8JtFYyxcnnUxvd5QMhEzku3zXjuWkqZGrXJevSwBJR76jkMeLYQ+0hvEDaB
         4dGGCm3FeMHdqbLv9rt5nml/dKOStdju0D/nwEsNb/lcrwdth8v4P/rNsfcnLannrlIe
         fzQ0dOwx5SmfQzdAGS2nP9aKM0g8yWClLvFTtKQ4x2MxZvimFatN/J+yLJmOLS2Z7WTt
         69HfPIv52JDWxj+5hM17wzkOsslnck9y7Q/R+p4yB7oMv+v2J8ECQKDpNjtqNdlaTFbB
         3GWA==
X-Gm-Message-State: AOJu0YzvEc2GLRc+nxpg1ecvsVseo3doAP/J3HhcrDVRsnVrK4wu7oMC
	V6CjP4zhHvntNnV2JG1yPthnCMMOSuEw3/GNdapLgaQCC91rFQIWpddibJwyQttLmda2C0Z1c/y
	imwSPmiVsPvVSnEOUZRZP+XrIXh6F
X-Received: by 2002:a05:6512:62:b0:507:a1b3:2d47 with SMTP id i2-20020a056512006200b00507a1b32d47mr711271lfo.17.1697695987348;
        Wed, 18 Oct 2023 23:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKKWq/IvrJbW9nWBBbOsicCcjEchXmuN+dvBdK6+phRjrHRr4uB7jRbV5DIB6i2rs9tfx/WDAmwBNVpzpv4ug=
X-Received: by 2002:a05:6512:62:b0:507:a1b3:2d47 with SMTP id
 i2-20020a056512006200b00507a1b32d47mr711246lfo.17.1697695986945; Wed, 18 Oct
 2023 23:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:12:55 +0800
Message-ID: <CACGkMEtmvyJ93Xa0791KVSZEzqZgT9trzOkxz1OY+wOJ1xaR5A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/19] virtio_net: move to virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Move some structure definitions and inline functions into the
> virtio_net.h file.

Some of the functions are not inline one before the moving. I'm not
sure what's the criteria to choose the function to be moved.


>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 252 +------------------------------
>  drivers/net/virtio/virtio_net.h | 256 ++++++++++++++++++++++++++++++++
>  2 files changed, 258 insertions(+), 250 deletions(-)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 6cf77b6acdab..d8b6c0d86f29 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -6,7 +6,6 @@
>  //#define DEBUG
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> -#include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_net.h>
> @@ -16,7 +15,6 @@
>  #include <linux/if_vlan.h>
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
> -#include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
>  #include <net/route.h>
> @@ -24,6 +22,8 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>
> +#include "virtio_net.h"
> +
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
>
> @@ -45,15 +45,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG        BIT(0)
> -
> -/* RX packet size EWMA. The average packet size is used to determine the=
 packet
> - * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
> - * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> - * term, transient changes in packet size.
> - */
> -DECLARE_EWMA(pkt_len, 0, 64)
> -
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
>  static const unsigned long guest_offloads[] =3D {
> @@ -74,36 +65,6 @@ static const unsigned long guest_offloads[] =3D {
>                                 (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_USO6))
>
> -struct virtnet_stat_desc {
> -       char desc[ETH_GSTRING_LEN];
> -       size_t offset;
> -};
> -
> -struct virtnet_sq_stats {
> -       struct u64_stats_sync syncp;
> -       u64 packets;
> -       u64 bytes;
> -       u64 xdp_tx;
> -       u64 xdp_tx_drops;
> -       u64 kicks;
> -       u64 tx_timeouts;
> -};
> -
> -struct virtnet_rq_stats {
> -       struct u64_stats_sync syncp;
> -       u64 packets;
> -       u64 bytes;
> -       u64 drops;
> -       u64 xdp_packets;
> -       u64 xdp_tx;
> -       u64 xdp_redirects;
> -       u64 xdp_drops;
> -       u64 kicks;
> -};
> -
> -#define VIRTNET_SQ_STAT(m)     offsetof(struct virtnet_sq_stats, m)
> -#define VIRTNET_RQ_STAT(m)     offsetof(struct virtnet_rq_stats, m)
> -
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc[] =3D {
>         { "packets",            VIRTNET_SQ_STAT(packets) },
>         { "bytes",              VIRTNET_SQ_STAT(bytes) },
> @@ -127,80 +88,6 @@ static const struct virtnet_stat_desc virtnet_rq_stat=
s_desc[] =3D {
>  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
>  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
>
> -struct virtnet_interrupt_coalesce {
> -       u32 max_packets;
> -       u32 max_usecs;
> -};
> -
> -/* The dma information of pages allocated at a time. */
> -struct virtnet_rq_dma {
> -       dma_addr_t addr;
> -       u32 ref;
> -       u16 len;
> -       u16 need_sync;
> -};
> -
> -/* Internal representation of a send virtqueue */
> -struct send_queue {
> -       /* Virtqueue associated with this send _queue */
> -       struct virtqueue *vq;
> -
> -       /* TX: fragments + linear part + virtio header */
> -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> -
> -       /* Name of the send queue: output.$index */
> -       char name[16];
> -
> -       struct virtnet_sq_stats stats;
> -
> -       struct virtnet_interrupt_coalesce intr_coal;
> -
> -       struct napi_struct napi;
> -
> -       /* Record whether sq is in reset state. */
> -       bool reset;
> -};
> -
> -/* Internal representation of a receive virtqueue */
> -struct receive_queue {
> -       /* Virtqueue associated with this receive_queue */
> -       struct virtqueue *vq;
> -
> -       struct napi_struct napi;
> -
> -       struct bpf_prog __rcu *xdp_prog;
> -
> -       struct virtnet_rq_stats stats;
> -
> -       struct virtnet_interrupt_coalesce intr_coal;
> -
> -       /* Chain pages by the private ptr. */
> -       struct page *pages;
> -
> -       /* Average packet length for mergeable receive buffers. */
> -       struct ewma_pkt_len mrg_avg_pkt_len;
> -
> -       /* Page frag for packet buffer allocation. */
> -       struct page_frag alloc_frag;
> -
> -       /* RX: fragments + linear part + virtio header */
> -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> -
> -       /* Min single buffer size for mergeable buffers case. */
> -       unsigned int min_buf_len;
> -
> -       /* Name of this receive queue: input.$index */
> -       char name[16];
> -
> -       struct xdp_rxq_info xdp_rxq;
> -
> -       /* Record the last dma info to free after new pages is allocated.=
 */
> -       struct virtnet_rq_dma *last_dma;
> -
> -       /* Do dma by self */
> -       bool do_dma;
> -};
> -
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
>   * Note, that default structure that describes RSS configuration virtio_=
net_rss_config
>   * contains same info but can't handle table values.
> @@ -234,88 +121,6 @@ struct control_buf {
>         struct virtio_net_ctrl_coal_vq coal_vq;
>  };
>
> -struct virtnet_info {
> -       struct virtio_device *vdev;
> -       struct virtqueue *cvq;
> -       struct net_device *dev;
> -       struct send_queue *sq;
> -       struct receive_queue *rq;
> -       unsigned int status;
> -
> -       /* Max # of queue pairs supported by the device */
> -       u16 max_queue_pairs;
> -
> -       /* # of queue pairs currently used by the driver */
> -       u16 curr_queue_pairs;
> -
> -       /* # of XDP queue pairs currently used by the driver */
> -       u16 xdp_queue_pairs;
> -
> -       /* xdp_queue_pairs may be 0, when xdp is already loaded. So add t=
his. */
> -       bool xdp_enabled;
> -
> -       /* I like... big packets and I cannot lie! */
> -       bool big_packets;
> -
> -       /* number of sg entries allocated for big packets */
> -       unsigned int big_packets_num_skbfrags;
> -
> -       /* Host will merge rx buffers for big packets (shake it! shake it=
!) */
> -       bool mergeable_rx_bufs;
> -
> -       /* Host supports rss and/or hash report */
> -       bool has_rss;
> -       bool has_rss_hash_report;
> -       u8 rss_key_size;
> -       u16 rss_indir_table_size;
> -       u32 rss_hash_types_supported;
> -       u32 rss_hash_types_saved;
> -
> -       /* Has control virtqueue */
> -       bool has_cvq;
> -
> -       /* Host can handle any s/g split between our header and packet da=
ta */
> -       bool any_header_sg;
> -
> -       /* Packet virtio header size */
> -       u8 hdr_len;
> -
> -       /* Work struct for delayed refilling if we run low on memory. */
> -       struct delayed_work refill;
> -
> -       /* Is delayed refill enabled? */
> -       bool refill_enabled;
> -
> -       /* The lock to synchronize the access to refill_enabled */
> -       spinlock_t refill_lock;
> -
> -       /* Work struct for config space updates */
> -       struct work_struct config_work;
> -
> -       /* Does the affinity hint is set for virtqueues? */
> -       bool affinity_hint_set;
> -
> -       /* CPU hotplug instances for online & dead */
> -       struct hlist_node node;
> -       struct hlist_node node_dead;
> -
> -       struct control_buf *ctrl;
> -
> -       /* Ethtool settings */
> -       u8 duplex;
> -       u32 speed;
> -
> -       /* Interrupt coalescing settings */
> -       struct virtnet_interrupt_coalesce intr_coal_tx;
> -       struct virtnet_interrupt_coalesce intr_coal_rx;
> -
> -       unsigned long guest_offloads;
> -       unsigned long guest_offloads_capable;
> -
> -       /* failover when STANDBY feature enabled */
> -       struct failover *failover;
> -};
> -
>  struct padded_vnet_hdr {
>         struct virtio_net_hdr_v1_hash hdr;
>         /*
> @@ -337,45 +142,11 @@ struct virtio_net_common_hdr {
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
> -static bool is_xdp_frame(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> -}
> -
>  static void *xdp_to_ptr(struct xdp_frame *ptr)
>  {
>         return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
>  }

Any reason for not moving this?

Thanks

>


