Return-Path: <bpf+bounces-72549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5BC153ED
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110674643B7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1233A030;
	Tue, 28 Oct 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLAljYi1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC819ADBA;
	Tue, 28 Oct 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662691; cv=none; b=Q4YjKzSBUlUWJceTXkd8fUe9PF/oNgvt+YMoMW9FVvMNzUXAC6hZn68/4SyjmIXBexTQoT90IssE+9MkqYxG4CLJc/By/3UH7XyLRetagus8MirxzzQcSkjridSlZomk7EyO7E2q2dkdqUoYv3Diy7o/fpcNeDVT9HkYg2KODaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662691; c=relaxed/simple;
	bh=fuPk2vf7KDqzwHVW9GxJh9JwUPAx4o37mqyOQ65OjsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMeX8y0MkD8NdTHYsUQQna+/0gOaGTWIIvDbtE+Wrju7lWNiBxYgdpQ3hS1Y+ccFLXHOzJutwlGMJb6kdlsWX2rqSNoTBSFNtHiA6OaMJbS8+OjLA/Lg1Qju0Dp0jDKOnct50nUaYJsyz/t3p838dXEskK3UTIaHWcjw1oXjg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLAljYi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B640C4CEE7;
	Tue, 28 Oct 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761662691;
	bh=fuPk2vf7KDqzwHVW9GxJh9JwUPAx4o37mqyOQ65OjsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLAljYi1+jk/WhrIiqhIINxvGFpBqh32vlKGDHG3QuwonoRqUlG1ghczULAFAyrdZ
	 ATscMcsqe7wIKzxij7h9z3ekG5i2WZG3pH3f7tvImg/mEsisU2gmkBGZNdADN5B8EO
	 36USKwSp68WptmLr+K8Dn2Xbgq6KkADMhn6czbx7Hmji1nIGXlXCTSXTDe3rDCf8M6
	 F1ONo9On4+Nqyr7Mo+QTsHsQLHsPLhTR6mPbYcmM6N9cK0QYdYNWGsiYMgKndo4b27
	 sRn5ZioW1MTT6HKYY304EHGC7aUDlUmnIlMbqTOGpfQ0/y9MFU/McePA4jY5jLoGbx
	 TWrgkcXFT5Xag==
Date: Tue, 28 Oct 2025 14:44:44 +0000
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH
 setsockopt
Message-ID: <aQDW3HK6bx2LgfBY@horms.kernel.org>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-2-kerneljasonxing@gmail.com>
 <aPt_WLQXPDOcmd1M@horms.kernel.org>
 <CAL+tcoDnAv7+kG4WdAh1ELP0=bj_1og+DdD-JS4YuWzZC+9OhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDnAv7+kG4WdAh1ELP0=bj_1og+DdD-JS4YuWzZC+9OhA@mail.gmail.com>

On Sat, Oct 25, 2025 at 05:08:39PM +0800, Jason Xing wrote:
> Hi Simon,
> 
> On Fri, Oct 24, 2025 at 9:30 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Oct 21, 2025 at 09:12:01PM +0800, Jason Xing wrote:
> >
> > ...
> >
> > > index 7b0c68a70888..ace91800c447 100644
> >
> > ...
> >
> > > @@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
> > >               WRITE_ONCE(xs->max_tx_budget, budget);
> > >               return 0;
> > >       }
> > > +     case XDP_GENERIC_XMIT_BATCH:
> > > +     {
> > > +             struct xsk_buff_pool *pool = xs->pool;
> > > +             struct xsk_batch *batch = &xs->batch;
> > > +             struct xdp_desc *descs;
> > > +             struct sk_buff **skbs;
> > > +             unsigned int size;
> > > +             int ret = 0;
> > > +
> > > +             if (optlen != sizeof(size))
> > > +                     return -EINVAL;
> > > +             if (copy_from_sockptr(&size, optval, sizeof(size)))
> > > +                     return -EFAULT;
> > > +             if (size == batch->generic_xmit_batch)
> > > +                     return 0;
> > > +             if (size > xs->max_tx_budget || !pool)
> > > +                     return -EACCES;
> > > +
> > > +             mutex_lock(&xs->mutex);
> > > +             if (!size) {
> > > +                     kfree(batch->skb_cache);
> > > +                     kvfree(batch->desc_cache);
> > > +                     batch->generic_xmit_batch = 0;
> > > +                     goto out;
> > > +             }
> > > +
> > > +             skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
> > > +             if (!skbs) {
> > > +                     ret = -ENOMEM;
> > > +                     goto out;
> > > +             }
> > > +             descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
> > > +             if (!descs) {
> > > +                     kfree(skbs);
> > > +                     ret = -ENOMEM;
> > > +                     goto out;
> > > +             }
> > > +             if (batch->skb_cache)
> > > +                     kfree(batch->skb_cache);
> > > +             if (batch->desc_cache)
> > > +                     kvfree(batch->desc_cache);
> >
> > Hi Jason,
> >
> > nit: kfree and kvfree are no-ops when passed NULL,
> >      so the conditions above seem unnecessary.
> 
> Yep, but the checkpatch complains. I thought it might be good to keep
> it because normally we need to check the validation of the pointer
> first and then free it. WDYT?

I don't feel particularly strongly about this.
But I would lean to wards removing the if() conditions
because they are unnecessary: less is more.


