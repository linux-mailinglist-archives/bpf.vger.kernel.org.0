Return-Path: <bpf+bounces-65479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A096FB23C6A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5F73A5B3A
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CB2874F0;
	Tue, 12 Aug 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H98XV7TD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7E2F069F;
	Tue, 12 Aug 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042417; cv=none; b=twspQ1ZbIqZV7MmS5A/DDQjFmT8HyLjNDIn+sZ3zPl0keB0282a3rgqJEGnldErMQmKDrT7mjp+YSkIpzoHEYLUTnqg0zsGgphYt2gDrhZyRoi/p0nvMFgDnLULRlfAEVDKk1i9+PCglH/Ak6c0rF9bwS/KOM83+tS9V+fkTusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042417; c=relaxed/simple;
	bh=yf/TpEP9k3XhdvkWxK3b3q+7QA+blq7VFiGxGxKzelY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBcWWjkIoU1b/BJea4j48ho3kytf28Swg7QRFJq9Wtj9gDWHtKbm2Ai5L+n7h22MHtnFLPXAkJAQ/DSqHCOFc56ydvOtINrZbXQ+TIuIvH6vu/qTVIePeEM+PZPOdA5fJ+vzT4ESVSmn2QKybQt8rKUJbHNYhN+3OIwRTU1QPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H98XV7TD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8842a9b0899so1718839f.1;
        Tue, 12 Aug 2025 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755042414; x=1755647214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9q0yuyWp0H/yLFtjBM+2kXrqrRRzZKo9yfmECDwsl4=;
        b=H98XV7TDEgk/CjWraZGKbMhH8aE4VkNTUuIUQZHPT3gboaxqQqyUVLz6qRmDOYzzmR
         Xij791lNcuvBmGxOnGxUu+N9rvkWwj2wnjmc+GCSYMsMt57zuf2OvlVsrxIWlhiZf2rY
         uyU/RqsLYUmMwNFgonDjtKC7v0LJP3DdkrfkYrZSPZg9CA26JT0Ox5FwmsiX/gZ86stR
         JVUYUHIHgmA5CtAVyC9TJPjSKpFmWRCyWo5LjGJ9Z0dA3pZgTW1ZFF2z3TVrprInbpYw
         2e+f1NwvMAhx40Uc9H29fGjAnJxaGGMhNJlaXK2twU0U5s1wnApjR+J1Rpm0AgAHCIyq
         T3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755042414; x=1755647214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9q0yuyWp0H/yLFtjBM+2kXrqrRRzZKo9yfmECDwsl4=;
        b=jnKzalTRqe65ycXkzLov5TcFq+TfbzoTg5St3ZBVoCYlsXANOupvlnCBI4vh+xGHbb
         RSgzpKneug9HTHMu4ozSmWwruGuZrm8YrbOfQ48m/KXXg6nqgr/lRnbUaLNTD6PrebzK
         EahmFhdxSU7lftW4sfmyKE0Lf90cYV6uSNBCKo7BqwqHxj/3cBppsrK3E1XbWxZxiX55
         NYOtvaZuO4OExT0tebNXZ1gZkJ3zRQTTp/BTGGD8oj2wZw5LDZ5AYFqRyKuqLjrw6Pr3
         KLZUDrLEPCOfDUQ+zePeiLDxFXaD1H4hheykIoL1/sgzi1UzUL5+vAoVvWhfjQQCq6+j
         zAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUAtgSyuTzPTfD1vk4IgEXRN9wJw+5gEW8Dr1aa6KWmod79LmM//qEjR4Db9CRGcxxNuyxjGd//@vger.kernel.org, AJvYcCVmIhv/JiR9oubGEjoL8jcimF7V6mwD1Jjned+w6XYWwXWxj9u2ZiUfbkWrEo6n6py0TwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3ps4T9E5yIWJIMPpp1dRBJp1HZhvmJ2w5jutouGeDHKmSNLF
	EmWESKRPYh+HgUYJNMv8CsiddrUbOF0yy1iruntF04NcK/eRW+VYJXWfXMg5XzolN1epe48cxit
	meG2nk5adD0YAePfI2gDpv+fA5XLN5rg=
X-Gm-Gg: ASbGnctKVwYTUojhf+1nQJz7i+BIEyGlIQbCF56zg46SBBlz6AH63C3uNcolywCINBg
	JkUDBz9hakog7sUO/kgzmD7Eq4dRmV5nDF8cXxPgjsBHuLETV0I9MUmnpO+22dw+K6UCEnlMPqZ
	L195bXqLahr77XYNX0+xO++7sDlb/QkRS3fI9aIXRvVWneS1GtdZ1sQr/gJMVDm7XAlAPguRgvf
	2LAjr4=
X-Google-Smtp-Source: AGHT+IHjOSz2R6AUtf9Q60thDG/jVKyVKH1Q2Br1fnq3TjWbNwCgaInWW1RI8ZNsS0pOk+qoE9o+MiHXwQdBfza5dl8=
X-Received: by 2002:a5e:990f:0:b0:87c:6851:81f1 with SMTP id
 ca18e2360f4ac-884296924b3mr191031739f.12.1755042414428; Tue, 12 Aug 2025
 16:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-2-kerneljasonxing@gmail.com> <aJtucfMw+mXp79FV@boxer>
In-Reply-To: <aJtucfMw+mXp79FV@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 07:46:17 +0800
X-Gm-Features: Ac12FXzCzY9QKvnOE6JM-U35E5tfAAPAeZyf0URf4aAEHi2UzRzlfqrN5PvNSSc
Message-ID: <CAL+tcoA=fdiB5exzgyueBi7kxHbsCxWKbs0Y5QO4WG3P4-6Aig@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:40=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Aug 11, 2025 at 09:12:35PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch is to prepare for later batch xmit in generic path. Add a ne=
w
> > socket option to provide an alternative to achieve a higher overall
> > throughput.
> >
> > skb_batch will be used to store newly allocated skb at one time in the
> > xmit path.
>
> I don't think we need yet another setsockopt. You previously added a knob
> for manipulating max tx budget on generic xmit and that should be enough.
> I think that we should strive for making the batching approach a default
> path in xsk generic xmit.

You're right, it=E2=80=98s the right direction that we should take. But I
considered this as well before cooking the series and then gave up, my
experiments show that in some real cases (not xdpsock) the batch
process might increase latency. It's a side effect. At that time I
thought many years ago the invention of GRO didn't become the default.

Thanks,
Jason

>
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  Documentation/networking/af_xdp.rst |  9 ++++++++
> >  include/net/xdp_sock.h              |  2 ++
> >  include/uapi/linux/if_xdp.h         |  1 +
> >  net/xdp/xsk.c                       | 32 +++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/if_xdp.h   |  1 +
> >  5 files changed, 45 insertions(+)
> >
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networ=
king/af_xdp.rst
> > index 50d92084a49c..1194bdfaf61e 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -447,6 +447,15 @@ mode to allow application to tune the per-socket m=
aximum iteration for
> >  better throughput and less frequency of send syscall.
> >  Allowed range is [32, xs->tx->nentries].
> >
> > +XDP_GENERIC_XMIT_BATCH
> > +----------------------
> > +
> > +It provides an option that allows application to use batch xmit in the=
 copy
> > +mode. Batch process minimizes the number of grabbing/releasing queue l=
ock
> > +without redundant actions compared to before to gain the overall perfo=
rmance
> > +improvement whereas it might increase the latency of per packet. The m=
aximum
> > +value shouldn't be larger than xs->max_tx_budget.
> > +
> >  XDP_STATISTICS getsockopt
> >  -------------------------
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ce587a225661..b5a3e37da8db 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -61,6 +61,7 @@ struct xdp_sock {
> >               XSK_BOUND,
> >               XSK_UNBOUND,
> >       } state;
> > +     struct sk_buff **skb_batch;
> >
> >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> >       struct list_head tx_list;
> > @@ -70,6 +71,7 @@ struct xdp_sock {
> >        * preventing other XSKs from being starved.
> >        */
> >       u32 tx_budget_spent;
> > +     u32 generic_xmit_batch;
> >
> >       /* Statistics */
> >       u64 rx_dropped;
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 23a062781468..44cb72cd328e 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_STATISTICS                       7
> >  #define XDP_OPTIONS                  8
> >  #define XDP_MAX_TX_SKB_BUDGET                9
> > +#define XDP_GENERIC_XMIT_BATCH               10
> >
> >  struct xdp_umem_reg {
> >       __u64 addr; /* Start of packet data area */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c3acecc14b1..7a149f4ac273 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1122,6 +1122,7 @@ static int xsk_release(struct socket *sock)
> >       xskq_destroy(xs->tx);
> >       xskq_destroy(xs->fq_tmp);
> >       xskq_destroy(xs->cq_tmp);
> > +     kfree(xs->skb_batch);
> >
> >       sock_orphan(sk);
> >       sock->sk =3D NULL;
> > @@ -1456,6 +1457,37 @@ static int xsk_setsockopt(struct socket *sock, i=
nt level, int optname,
> >               WRITE_ONCE(xs->max_tx_budget, budget);
> >               return 0;
> >       }
> > +     case XDP_GENERIC_XMIT_BATCH:
> > +     {
> > +             unsigned int batch, batch_alloc_len;
> > +             struct sk_buff **new;
> > +
> > +             if (optlen !=3D sizeof(batch))
> > +                     return -EINVAL;
> > +             if (copy_from_sockptr(&batch, optval, sizeof(batch)))
> > +                     return -EFAULT;
> > +             if (batch > xs->max_tx_budget)
> > +                     return -EACCES;
> > +
> > +             mutex_lock(&xs->mutex);
> > +             if (!batch) {
> > +                     kfree(xs->skb_batch);
> > +                     xs->generic_xmit_batch =3D 0;
> > +                     goto out;
> > +             }
> > +             batch_alloc_len =3D sizeof(struct sk_buff *) * batch;
> > +             new =3D kmalloc(batch_alloc_len, GFP_KERNEL);
> > +             if (!new)
> > +                     return -ENOMEM;
> > +             if (xs->skb_batch)
> > +                     kfree(xs->skb_batch);
> > +
> > +             xs->skb_batch =3D new;
> > +             xs->generic_xmit_batch =3D batch;
> > +out:
> > +             mutex_unlock(&xs->mutex);
> > +             return 0;
> > +     }
> >       default:
> >               break;
> >       }
> > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/lin=
ux/if_xdp.h
> > index 23a062781468..44cb72cd328e 100644
> > --- a/tools/include/uapi/linux/if_xdp.h
> > +++ b/tools/include/uapi/linux/if_xdp.h
> > @@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_STATISTICS                       7
> >  #define XDP_OPTIONS                  8
> >  #define XDP_MAX_TX_SKB_BUDGET                9
> > +#define XDP_GENERIC_XMIT_BATCH               10
> >
> >  struct xdp_umem_reg {
> >       __u64 addr; /* Start of packet data area */
> > --
> > 2.41.3
> >

