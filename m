Return-Path: <bpf+bounces-7807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200FC77CC71
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C8F1C20CF3
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51011CAF;
	Tue, 15 Aug 2023 12:19:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E345C9D;
	Tue, 15 Aug 2023 12:19:16 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D3F12E;
	Tue, 15 Aug 2023 05:19:15 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64712741d5cso7978176d6.1;
        Tue, 15 Aug 2023 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692101954; x=1692706754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUoMJvwvNDiWDbpEX8hXChfExLzmgKTcQbHp89OBZMs=;
        b=dLw29zKrqoD2PGMb3iRNbMvVW9Ao5kN7FnTC/ZapK4csW7kpJKYrajq+QeUbDhr+1X
         SwpC/tMarYSMQFpn/XgAurFXJZKPHVy7sDmo61muWTDyBcL/GXkspVS80IvKPSjwc/VC
         ek+iNzFqz7NwX2B+IItLUaSky4Db7SvRfbgcdOILtCE8mp2GYVYnW9SoJRw+SRsAULYE
         RTF4xAPfC6noYZd4QsQNLV0XBop0CKbE2eI8xiPbZE1WyQJWGmVB0ReykajBja59xRqW
         tAcA6fCThCUmt5quC8aMcYUm8dRDpxhXSjvStvuCQXdrDaMmutztuSPThA33AASD0/DI
         GGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101954; x=1692706754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUoMJvwvNDiWDbpEX8hXChfExLzmgKTcQbHp89OBZMs=;
        b=kpYg/oJUXlZE3fMSSvw2Dpqdoz9408Lna7etFyVmqpWeA5Xl5q5aaMG89MImRraL0A
         N+Vo36mSK2T1hE4ekSW0PjVllgSOI0hrRI5gOmiKDo01qEKJxLZKduIKx8oknvvkPonD
         KtOAjpZHfZYsXJFCokZSzqI9+wueqQm/sk+u7zfUnov31ob8av7IWb3kdw4uLvi8VfEv
         hq3OosU3EsH6JRDWF5wge/ylZCKeiKYNgZiU2/21zaEOI1IRPKf6ZqAWcrHr0v9kn3+g
         m88JaOncUCfoxtMdTeagIjF4A1wWiNR9ZSkJFEcRwYBYygwoKAfpoQLUyKmNr3YS83Z0
         orxg==
X-Gm-Message-State: AOJu0YwQLFfA3fldRqFAdkC9OdD2odtzsU8b51jynOM7pYSgQe8Dtngl
	TJMcSlTO1q5MhX/U70JSGrC5rtfx24rH6LeEOy4=
X-Google-Smtp-Source: AGHT+IGAUWQgEDBbjZlUJhilsyn0HTT73s2jGPd8nSnSgtvj0hq/pGLJeKsGGOVaNjzL0E35+yiCXJg/jbX5WX5Dfrc=
X-Received: by 2002:ad4:5c4c:0:b0:635:fa38:5216 with SMTP id
 a12-20020ad45c4c000000b00635fa385216mr18797070qva.0.1692101954034; Tue, 15
 Aug 2023 05:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <20230809165418.2831456-2-sdf@google.com>
 <ZNoIdzdHQV6OUecF@boxer> <CAKH8qBv9jw_C1B_LRcnbGK90dfsS9bY7GqYJA5Nvyiug1VqRCQ@mail.gmail.com>
 <CAKH8qBshXjc3rKgn6A-dfE4sXtk+ckSJx0qr=14t4heKXXEhcQ@mail.gmail.com>
In-Reply-To: <CAKH8qBshXjc3rKgn6A-dfE4sXtk+ckSJx0qr=14t4heKXXEhcQ@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 15 Aug 2023 14:19:03 +0200
Message-ID: <CAJ8uoz0Hmru4XeVUJK=M97CSML2RMQbucLNTVDFPaZQRjJrgkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] xsk: Support XDP_TX_METADATA_LEN
To: Stanislav Fomichev <sdf@google.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug 2023 at 00:25, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Aug 14, 2023 at 11:05=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > On Mon, Aug 14, 2023 at 3:57=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Aug 09, 2023 at 09:54:10AM -0700, Stanislav Fomichev wrote:
> > > > For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> > > > and carry some TX metadata in the headroom. For copy mode, there
> > > > is no way currently to populate skb metadata.
> > > >
> > > > Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> > > > to treat as metadata. Metadata bytes come prior to tx_desc address
> > > > (same as in RX case).
> > > >
> > > > The size of the metadata has the same constraints as XDP:
> > > > - less than 256 bytes
> > > > - 4-byte aligned
> > > > - non-zero
> > > >
> > > > This data is not interpreted in any way right now.
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  include/net/xdp_sock.h      |  1 +
> > > >  include/net/xsk_buff_pool.h |  1 +
> > > >  include/uapi/linux/if_xdp.h |  1 +
> > > >  net/xdp/xsk.c               | 20 ++++++++++++++++++++
> > > >  net/xdp/xsk_buff_pool.c     |  1 +
> > > >  net/xdp/xsk_queue.h         | 17 ++++++++++-------
> > > >  6 files changed, 34 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 1617af380162..467b9fb56827 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -51,6 +51,7 @@ struct xdp_sock {
> > > >       struct list_head flush_node;
> > > >       struct xsk_buff_pool *pool;
> > > >       u16 queue_id;
> > > > +     u8 tx_metadata_len;
> > > >       bool zc;
> > > >       bool sg;
> > > >       enum {
> > > > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_poo=
l.h
> > > > index b0bdff26fc88..9c31e8d1e198 100644
> > > > --- a/include/net/xsk_buff_pool.h
> > > > +++ b/include/net/xsk_buff_pool.h
> > > > @@ -77,6 +77,7 @@ struct xsk_buff_pool {
> > > >       u32 chunk_size;
> > > >       u32 chunk_shift;
> > > >       u32 frame_len;
> > > > +     u8 tx_metadata_len; /* inherited from xsk_sock */
> > > >       u8 cached_need_wakeup;
> > > >       bool uses_need_wakeup;
> > > >       bool dma_need_sync;
> > > > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xd=
p.h
> > > > index 8d48863472b9..b37b50102e1c 100644
> > > > --- a/include/uapi/linux/if_xdp.h
> > > > +++ b/include/uapi/linux/if_xdp.h
> > > > @@ -69,6 +69,7 @@ struct xdp_mmap_offsets {
> > > >  #define XDP_UMEM_COMPLETION_RING     6
> > > >  #define XDP_STATISTICS                       7
> > > >  #define XDP_OPTIONS                  8
> > > > +#define XDP_TX_METADATA_LEN          9
> > > >
> > > >  struct xdp_umem_reg {
> > > >       __u64 addr; /* Start of packet data area */
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 47796a5a79b3..28df3280501d 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -1338,6 +1338,26 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > > >               mutex_unlock(&xs->mutex);
> > > >               return err;
> > > >       }
> > > > +     case XDP_TX_METADATA_LEN:
> > > > +     {
> > > > +             int val;
> > > > +
> > > > +             if (optlen < sizeof(val))
> > > > +                     return -EINVAL;
> > > > +             if (copy_from_sockptr(&val, optval, sizeof(val)))
> > > > +                     return -EFAULT;
> > > > +             if (!val || val > 256 || val % 4)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             mutex_lock(&xs->mutex);
> > > > +             if (xs->state !=3D XSK_READY) {
> > > > +                     mutex_unlock(&xs->mutex);
> > > > +                     return -EBUSY;
> > > > +             }
> > > > +             xs->tx_metadata_len =3D val;
> > > > +             mutex_unlock(&xs->mutex);
> > > > +             return 0;
> > > > +     }
> > > >       default:
> > > >               break;
> > > >       }
> > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > index b3f7b310811e..b351732f1032 100644
> > > > --- a/net/xdp/xsk_buff_pool.c
> > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > @@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(s=
truct xdp_sock *xs,
> > > >               XDP_PACKET_HEADROOM;
> > > >       pool->umem =3D umem;
> > > >       pool->addrs =3D umem->addrs;
> > > > +     pool->tx_metadata_len =3D xs->tx_metadata_len;
> > >
> > > Hey Stan,
> > >
> > > what would happen in case when one socket sets pool->tx_metadata_len =
say
> > > to 16 and the other one that is sharing the pool to 24? If sockets sh=
ould
> > > and can have different padding, then this will not work unless the
> > > metadata_len is on a per socket level.
> >
> > Hmm, good point. I didn't think about umem sharing :-/
> > Maybe they all have to agree on the size? And once the size has been
> > size by one socket, the same size should be set on the others? (or at
> > least be implied that the other sockets will use the same metadata
> > layout)
>
> Thinking about it a bit more: should that tx_metadata_len be part of a
> umem then?
> Users can provide it as part of xdp_umem_reg which is probably a
> better place to pass it compared to the setsockopt?

If all the sockets sharing the umem have to agree on the
tx_metadata_len, then this is a better place than the setsockopt.
IMHO, it sounds unlikely that multiple versions of the same program,
or different programs, would like to share the same umem.

Please note that some of the members of struct xdp_umem are copied out
to the individual struct xsk_buff_pool even though they are the same
between all of them (chunk_size and the size of the umem for example).
The reason for this is performance, as to avoid having to access the
umem struct in the fast path. Something similar might be a good idea
here too, even though tx_metadata_len is fixed for a umem being
shared. Might be worth trying.

Again, thanks for working on this Stanislav.

