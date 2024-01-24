Return-Path: <bpf+bounces-20223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41B83A886
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145DAB23A6E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BD1B598;
	Wed, 24 Jan 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Oumsdk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064401B592;
	Wed, 24 Jan 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096975; cv=none; b=rpw1pnJ17Wi68S3/oiAY8MhxV1rLohHL2I+Cq9gl44BILUg5NhTLD8igYvud6JXkvT/3Q0APcue1ByKprj8WEBFxgkuqscPEOX2FVNQOXnNPPHE2C5CSXVrtRf6BxYQyKMIEcwVymCpILbnHNCTp7NqnbXRC5mzBqxJAHHIkvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096975; c=relaxed/simple;
	bh=dN7fWukx7t3tARlksk2bOu2iLjec41T1JFUWNyeQ8aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oybci32oBbzeoy+AiFtxUhSyqGGrvLAir9ju0614KxjizIT3DdxBP6BZ641HF8+EDTwj4SGzW/0e4yYU3Y+oTcgKwswQLh161rnLPdHQDQuMxHAbcm4R8KAOlkjoOBFWKkAhaR043fO2wiBSPlDKUvD9pyfC5uUtZHb1Rlr44N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Oumsdk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783b3539c16so14921185a.1;
        Wed, 24 Jan 2024 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706096973; x=1706701773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivFNd2hsNPk+T4DFS8JAs+VdfdwaU3+0b1wxcqRPWyM=;
        b=J7OumsdkhtP+pYO19paRRiJa8iHS+SmO4QQvT9HZzdgubv3gcOojsBxk7jQ1p9db6F
         /Hp938Vb5x+/16wqT4U4kXxEWtNofABxoxyYSlG3jRzmQYsqPQEC8G5RAbwaXZforqMS
         aDS+957eABtSzm9w6WrbDPx50tNB7Fof50KziFDrdvIwbTgaCDxXtDAXtWq8OqunkTBw
         zpgwAk7TWc+04jFZvdQOdHaRMnyOji30g+02HbfrAFhyK+nHN+7q16QCJay6Q8BS7qR+
         Md6CbWW2Fm+np9hHwJL3fL8Ry3S9Fo4jx0ZiQQWSivX+ln8lj07/yXu/RuJAfR8ox4BZ
         P91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096973; x=1706701773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivFNd2hsNPk+T4DFS8JAs+VdfdwaU3+0b1wxcqRPWyM=;
        b=YiDPSPNupe10qUFPeeu4YYG425YhQaoraKaQDVnGgF3lqSC5n4BOcmmoFKBn+6efu3
         xQAsemLN7ArVsrUAP9SlRV2gB9pS+8WmH8oilUB411IGgkFY71PlxZyWlNJ8ejdoZ1AA
         oK6U41sv6EYG8MfROUILhXBZuWrqpkVtqen3ArLRt2F2xhKdRX5l6B6NsIBamEW57q7t
         /aNeCt9WsPIpYky1YrtiaFNTFjGnIYJxAFVjx1ZCdXuWmK1iQlzILiQcxXSUQh9kjBhw
         cs8PAQPyDKPbcWUULA5XlIA1l/AwOH+H1lvlsBh3byD1F8mp+t1mEWFEYkqnFlUmq+BD
         2l2g==
X-Gm-Message-State: AOJu0YybCyH9D4jQiMP1MNiuy/lx9+l2acl/4BZP3kAFDTvXCUW1RVie
	42skxOwiBcg5P9pi+CQZDjqE01XHwc6uNeLuqBq8vKps1tPEFp04gbQDugs20hl3LPzjftEJWl/
	OS8Zg9yyN956n943hgE9jsBY20Dw=
X-Google-Smtp-Source: AGHT+IHL9M8THo/LhK0sDEGjYeQ8FVX0PkcBKvSu53c/y2HeaezgQyPLFRcuzFgaqKontAqcoQ+H2m50zNchVRD3l/c=
X-Received: by 2002:a05:6214:4012:b0:685:7cfd:34eb with SMTP id
 kd18-20020a056214401200b006857cfd34ebmr1989766qvb.4.1706096972775; Wed, 24
 Jan 2024 03:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-3-maciej.fijalkowski@intel.com> <CAJ8uoz2W6nqJ=vk6+RR7zEohkv7CTBO+2KsAQAfgp=gf_5-ycA@mail.gmail.com>
 <ZbD3tbiM/xD+aEJB@boxer>
In-Reply-To: <ZbD3tbiM/xD+aEJB@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 12:49:21 +0100
Message-ID: <CAJ8uoz1L_EHtU27p=sLuduQ7aZVL9WPL6fDtJ-m3Bix=K39yxQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 02/11] xsk: make xsk_buff_pool responsible for
 clearing xdp_buff::flags
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 12:42, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jan 24, 2024 at 09:20:26AM +0100, Magnus Karlsson wrote:
> > On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > XDP multi-buffer support introduced XDP_FLAGS_HAS_FRAGS flag that is
> > > used by drivers to notify data path whether xdp_buff contains fragments
> > > or not. Data path looks up mentioned flag on first buffer that occupies
> > > the linear part of xdp_buff, so drivers only modify it there. This is
> > > sufficient for SKB and XDP_DRV modes as usually xdp_buff is allocated on
> > > stack or it resides within struct representing driver's queue and
> > > fragments are carried via skb_frag_t structs. IOW, we are dealing with
> > > only one xdp_buff.
> > >
> > > ZC mode though relies on list of xdp_buff structs that is carried via
> > > xsk_buff_pool::xskb_list, so ZC data path has to make sure that
> > > fragments do *not* have XDP_FLAGS_HAS_FRAGS set. Otherwise,
> > > xsk_buff_free() could misbehave if it would be executed against xdp_buff
> > > that carries a frag with XDP_FLAGS_HAS_FRAGS flag set. Such scenario can
> > > take place when within supplied XDP program bpf_xdp_adjust_tail() is
> > > used with negative offset that would in turn release the tail fragment
> > > from multi-buffer frame.
> > >
> > > Calling xsk_buff_free() on tail fragment with XDP_FLAGS_HAS_FRAGS would
> > > result in releasing all the nodes from xskb_list that were produced by
> > > driver before XDP program execution, which is not what is intended -
> > > only tail fragment should be deleted from xskb_list and then it should
> > > be put onto xsk_buff_pool::free_list. Such multi-buffer frame will never
> > > make it up to user space, so from AF_XDP application POV there would be
> > > no traffic running, however due to free_list getting constantly new
> > > nodes, driver will be able to feed HW Rx queue with recycled buffers.
> > > Bottom line is that instead of traffic being redirected to user space,
> > > it would be continuously dropped.
> > >
> > > To fix this, let us clear the mentioned flag on xsk_buff_pool side at
> > > allocation time, which is what should have been done right from the
> > > start of XSK multi-buffer support.
> > >
> > > Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> > > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
> > >  drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
> > >  net/xdp/xsk_buff_pool.c                    | 3 +++
> > >  3 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > index e99fa854d17f..fede0bb3e047 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > @@ -499,7 +499,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> > >                 xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
> > >                 i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
> > >                                           &rx_bytes, xdp_res, &failure);
> > > -               first->flags = 0;
> > >                 next_to_clean = next_to_process;
> > >                 if (failure)
> > >                         break;
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > index 5d1ae8e4058a..d9073a618ad6 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > @@ -895,7 +895,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> > >
> > >                 if (!first) {
> > >                         first = xdp;
> > > -                       xdp_buff_clear_frags_flag(first);
> > >                 } else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
> > >                         break;
> > >                 }
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 28711cc44ced..dc5659da6728 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
> > >
> > >         xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
> > >         xskb->xdp.data_meta = xskb->xdp.data;
> > > +       xskb->xdp.flags = 0;
> > >
> > >         if (pool->dma_need_sync) {
> > >                 dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> > > @@ -601,6 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
> > >                 }
> > >
> > >                 *xdp = &xskb->xdp;
> > > +               xskb->xdp.flags = 0;
> >
> > Thanks for catching this. I am thinking we should have an if-statement
> > here and only do this when multi-buffer is enabled. The reason that we
> > have two different paths for aligned mode and unaligned mode here is
> > that we do not have to touch the xdp_buff at all at allocation time in
> > aligned mode, which provides a nice speed-up. So let us only do this
> > when necessary. What do you think? Same goes for the line in
> > xp_alloc_reused().
> >
>
> Good point. How about keeping flags = 0 in xp_alloc() and adding it to
> xsk_buff_set_size() ? We do touch xdp_buff there and these two paths cover
> batched and non-batched APIs. I do agree that doing it in
> xp_alloc_new_from_fq() and in xp_alloc_reused() is not really handy.

That is an even better idea. Go for it.

> > >                 xdp++;
> > >         }
> > >
> > > @@ -621,6 +623,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
> > >                 list_del_init(&xskb->free_list_node);
> > >
> > >                 *xdp = &xskb->xdp;
> > > +               xskb->xdp.flags = 0;
> > >                 xdp++;
> > >         }
> > >         pool->free_list_cnt -= nb_entries;
> > > --
> > > 2.34.1
> > >
> > >

