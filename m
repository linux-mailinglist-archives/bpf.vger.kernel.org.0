Return-Path: <bpf+bounces-20289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E883B72C
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF8C1F23FF0
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B41FBF;
	Thu, 25 Jan 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQSQVDqJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121496FAD;
	Thu, 25 Jan 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150108; cv=none; b=LVJJjc70RAZtjLVCyD8Uq2nX6XrXDPJmz52YC1b3U4Sr6Lb5WmPuQhqGXSHEa3DakCOYZBrDF7OylRIp2ahsHYxAlNg565y1d/0BsRMzsj3KSBlTrj3qYvKDaDvAetzyk0kOizlyWN9OmDvsw/lFqT94kAZX3ulx9/pJNo+LJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150108; c=relaxed/simple;
	bh=oZB+rnSbNrbRk4wjrjm8hwRt9npaPT1zlo6uV1C7jBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCj0nZPYL3Ax+5WJa0b8lM8YlOrXTVfiguF5h4OCkPQz8p8SA9lwxzOVtjCDgM/xhXp3YxusWZBcHo09+W36J+dajmcWkkmvvYDayqr5HLaNaMcsv5XyibZd5zF+Fc0SJbA+dFovLDp8aHtPqQhBkdYIgXlKNcaf7lW1WY61HiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQSQVDqJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d99f9cdfso5258863f8f.0;
        Wed, 24 Jan 2024 18:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706150105; x=1706754905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UalBL1KksrfmBSIphDpJ0OaRMGhEKAxnBVdciCrs4XE=;
        b=FQSQVDqJ8I6l9c2HOv7z5NNslTKXBwfoYJRfXKARfVUOmcY5OkG2VxPE15OgBPQ/DX
         sJenj2jdje95N7pT2E3W+8U4QOoKKrJ3bxV7pGygxHKXP4XywjlnLqsRQDLQQ4ocUIJK
         XbEyb+Up2XiF4pgrzDGmL7USStK93MRGi9It2iRZ6pAX0XNiCGYU5GnU8t2/+KK8GJ/r
         1nQy0G1TKYIz5nbOtDI6pc/NaqbZAdrGkSk59MZw/Ka0GDZRoEFJneSFt6c7p4khVSWt
         DmCmGcfdroLmGQN9tq55JyBbyzyeMyuPzUd35RWALehHr0PTRsTSaXnJIV31hnpNInqT
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706150105; x=1706754905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UalBL1KksrfmBSIphDpJ0OaRMGhEKAxnBVdciCrs4XE=;
        b=nhBr9NnW8psbensYUPHdctjCmkXnhJUETzj0aaH8V+TQ+EOL+DxAkFhU9rOMVgNBPq
         rU3bbe1RwBPXXSJCRVXPW2z13UnHHGyJdIV5K70xug3uk+ItT/hepnoKMi7CuEzBmYH9
         zje9t+Ko5kqjSNoH5At5VxNonMOd+2O0XK0N+1R3r2El3knrzhQJ9lCB1/bDmFDzNUL1
         AlRwRwED5mCQhotw/tyC8tdkLdh4sUgwgd30XZmG/PrIVu66vM9tUcFECWFzNgb15Y/q
         194otfV2LXP5rFOYWadFtyqDNv71B5Ea5ytEoQdBKwEKm4gM4Eg9LkL65por229wQlqM
         osSw==
X-Gm-Message-State: AOJu0YxFpJDVUOLc0cOBX4CvXXc4dHU1O//qrHf1GIBB/urPl1NiEQ8h
	bGoJ5TW9bcUyf0mv7gWfa3MvQwQrdzsqz6xJsdCpSUP9tVA+sXE2fhAi9UVClDd6I0TmP1UfAid
	iJFOLQDbKco8Bsm/zUj809S7md1w=
X-Google-Smtp-Source: AGHT+IGDzSrhufVoRNE2fXRGZnsr5pi4JBJdAN8QI72PY4YftYfoWgIBPtleEOK2p463fu9lj9F+JurNTKMXt98dfc0=
X-Received: by 2002:a5d:6448:0:b0:336:ebf3:b8fa with SMTP id
 d8-20020a5d6448000000b00336ebf3b8famr142862wrw.83.1706150104485; Wed, 24 Jan
 2024 18:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
 <20240124191602.566724-5-maciej.fijalkowski@intel.com> <f1ce06fd-30da-405e-8082-e35a9a88c5bd@amd.com>
In-Reply-To: <f1ce06fd-30da-405e-8082-e35a9a88c5bd@amd.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 18:34:52 -0800
Message-ID: <CAADnVQ+7qB44dGT4xkMPRrxNJrY-MFVU8E=jPiD+_CXvL6Didw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 04/11] ice: work on pre-XDP prog frag count
To: Brett Creeley <bcreeley@amd.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Eelco Chaudron <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:26=E2=80=AFPM Brett Creeley <bcreeley@amd.com> wr=
ote:
>
>
>
> On 1/24/2024 11:15 AM, Maciej Fijalkowski wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
> > multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
> > socket.
> >
> > Since support for handling multi-buffer frames was added to XDP, usage
> > of bpf_xdp_adjust_tail() helper within XDP program can free the page
> > that given fragment occupies and in turn decrease the fragment count
> > within skb_shared_info that is embedded in xdp_buff struct. In current
> > ice driver codebase, it can become problematic when page recycling logi=
c
> > decides not to reuse the page. In such case, __page_frag_cache_drain()
> > is used with ice_rx_buf::pagecnt_bias that was not adjusted after
> > refcount of page was changed by XDP prog which in turn does not drain
> > the refcount to 0 and page is never freed.
> >
> > To address this, let us store the count of frags before the XDP program
> > was executed on Rx ring struct. This will be used to compare with
> > current frag count from skb_shared_info embedded in xdp_buff. A smaller
> > value in the latter indicates that XDP prog freed frag(s). Then, for
> > given delta decrement pagecnt_bias for XDP_DROP verdict.
> >
> > While at it, let us also handle the EOP frag within
> > ice_set_rx_bufs_act() to make our life easier, so all of the adjustment=
s
> > needed to be applied against freed frags are performed in the single
> > place.
> >
> > Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side"=
)
> > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
> >   drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
> >   drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++-----=
-
> >   3 files changed, 32 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 74d13cc5a3a7..0c9b4aa8a049 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp=
_buff *xdp,
> >                  ret =3D ICE_XDP_CONSUMED;
> >          }
> >   exit:
> > -       rx_buf->act =3D ret;
> > -       if (unlikely(xdp_buff_has_frags(xdp)))
> > -               ice_set_rx_bufs_act(xdp, rx_ring, ret);
> > +       ice_set_rx_bufs_act(xdp, rx_ring, ret);
> >   }
> >
> >   /**
> > @@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, str=
uct xdp_buff *xdp,
> >          }
> >
> >          if (unlikely(sinfo->nr_frags =3D=3D MAX_SKB_FRAGS)) {
> > -               if (unlikely(xdp_buff_has_frags(xdp)))
> > -                       ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSU=
MED);
> > +               ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> >                  return -ENOMEM;
> >          }
> >
> >          __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->p=
age,
> >                                     rx_buf->page_offset, size);
> >          sinfo->xdp_frags_size +=3D size;
> > +       /* remember frag count before XDP prog execution; bpf_xdp_adjus=
t_tail()
> > +        * can pop off frags but driver has to handle it on its own
> > +        */
> > +       rx_ring->nr_frags =3D sinfo->nr_frags;
> >
> >          if (page_is_pfmemalloc(rx_buf->page))
> >                  xdp_buff_set_frag_pfmemalloc(xdp);
> > @@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring,=
 int budget)
> >
> >                  xdp->data =3D NULL;
> >                  rx_ring->first_desc =3D ntc;
> > +               rx_ring->nr_frags =3D 0;
> >                  continue;
> >   construct_skb:
> >                  if (likely(ice_ring_uses_build_skb(rx_ring)))
> > @@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_rin=
g, int budget)
> >                                                      ICE_XDP_CONSUMED);
> >                          xdp->data =3D NULL;
> >                          rx_ring->first_desc =3D ntc;
> > +                       rx_ring->nr_frags =3D 0;
> >                          break;
> >                  }
> >                  xdp->data =3D NULL;
> >                  rx_ring->first_desc =3D ntc;
> > +               rx_ring->nr_frags =3D 0;
> >
> >                  stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> >                  if (unlikely(ice_test_staterr(rx_desc->wb.status_error=
0,
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/et=
hernet/intel/ice/ice_txrx.h
> > index b3379ff73674..af955b0e5dc5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -358,6 +358,7 @@ struct ice_rx_ring {
> >          struct ice_tx_ring *xdp_ring;
> >          struct ice_rx_ring *next;       /* pointer to next ring in q_v=
ector */
> >          struct xsk_buff_pool *xsk_pool;
> > +       u32 nr_frags;
> >          dma_addr_t dma;                 /* physical address of ring */
> >          u16 rx_buf_len;
> >          u8 dcb_tc;                      /* Traffic class of ring */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/ne=
t/ethernet/intel/ice/ice_txrx_lib.h
> > index 762047508619..afcead4baef4 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > @@ -12,26 +12,39 @@
> >    * act: action to store onto Rx buffers related to XDP buffer parts
> >    *
> >    * Set action that should be taken before putting Rx buffer from firs=
t frag
> > - * to one before last. Last one is handled by caller of this function =
as it
> > - * is the EOP frag that is currently being processed. This function is
> > - * supposed to be called only when XDP buffer contains frags.
> > + * to the last.
> >    */
> >   static inline void
> >   ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *r=
x_ring,
> >                      const unsigned int act)
> >   {
> > -       const struct skb_shared_info *sinfo =3D xdp_get_shared_info_fro=
m_buff(xdp);
> > -       u32 first =3D rx_ring->first_desc;
> > -       u32 nr_frags =3D sinfo->nr_frags;
> > +       u32 sinfo_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frag=
s;
> > +       u32 nr_frags =3D rx_ring->nr_frags + 1;
> > +       u32 idx =3D rx_ring->first_desc;
> >          u32 cnt =3D rx_ring->count;
> >          struct ice_rx_buf *buf;
> >
> >          for (int i =3D 0; i < nr_frags; i++) {
> > -               buf =3D &rx_ring->rx_buf[first];
> > +               buf =3D &rx_ring->rx_buf[idx];
> >                  buf->act =3D act;
> >
> > -               if (++first =3D=3D cnt)
> > -                       first =3D 0;
> > +               if (++idx =3D=3D cnt)
> > +                       idx =3D 0;
> > +       }
> > +
> > +       /* adjust pagecnt_bias on frags freed by XDP prog */
> > +       if (sinfo_frags < rx_ring->nr_frags && act =3D=3D ICE_XDP_CONSU=
MED) {
> > +               u32 delta =3D rx_ring->nr_frags - sinfo_frags;
> > +
> > +               while (delta) {
> > +                       if (idx =3D=3D 0)
> > +                               idx =3D cnt - 1;
> > +                       else
> > +                               idx--;
> > +                       buf =3D &rx_ring->rx_buf[idx];
> > +                       buf->pagecnt_bias--;
> > +                       delta--;
> > +               }
>
> Nit, but the function name ice_set_rx_bufs_act() doesn't completely
> align with what it's doing anymore due to the additional pagecnt_bias
> changes.

The patch set was applied. Please advise whether this can stay as-is
or follow up is absolutely necessary.

