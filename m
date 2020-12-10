Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD042D697B
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393948AbgLJVLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 16:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393912AbgLJVLZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 16:11:25 -0500
Message-ID: <44ac4e64db37f1e51a61d67c90edb7e0753b0e38.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607634644;
        bh=RgF4ggI4Rrjq2bHdyztwJ4lP5mR2cVXsKfx5WA0dg5k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T+lRfQtq6lqG7wsUc3LRanCh5imfDmX8CpUXrDZvhKLIEqsqUvuYvVIT4ertQmmNq
         dNCAIjj5b57j88K8ZtfZqqnQMIvsICe8eJeOMX5AvTQ8OnmhHx5wHS2ZpXpjd1tHdr
         qIb347lwFKogb8Yh4E+bhpkiL8LhlnUrSKxFcT9ZGllHnLTp5R4xEdowOSyuHeoW+1
         yA5A/2oryBv59HV/FapkSO2NVrAhmEO4cVw0xQcrtVnvwFCqXo8nlPaYR4fYb/fEvO
         XYF4ovHy0iHmX4AuAvtUYQDdrKj4zHljWVTbzihGCrDVhJMOTYrfgoKhSs4uEuonFb
         FPs+/tbmONndw==
Subject: Re: [PATCH bpf-next] net: xdp: introduce xdp_init_buff utility
 routine
From:   Saeed Mahameed <saeed@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        alexander.duyck@gmail.com
Date:   Thu, 10 Dec 2020 13:10:42 -0800
In-Reply-To: <20201210192804.GC462213@lore-desk>
References: <e54fb61ff17c21f022392f1bb46ec951c9b909cc.1607615094.git.lorenzo@kernel.org>
         <20201210160507.GC45760@ranger.igk.intel.com>
         <20201210163241.GA462213@lore-desk>
         <20201210165556.GA46492@ranger.igk.intel.com>
         <20201210175945.GB462213@lore-desk>
         <721648a5e14dadc32629291a7d1914dd1044b7d0.camel@kernel.org>
         <20201210192804.GC462213@lore-desk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-12-10 at 20:28 +0100, Lorenzo Bianconi wrote:
> > On Thu, 2020-12-10 at 18:59 +0100, Lorenzo Bianconi wrote:
> > > On Dec 10, Maciej Fijalkowski wrote:
> > > > On Thu, Dec 10, 2020 at 05:32:41PM +0100, Lorenzo Bianconi
> > > > wrote:
> > > > > > On Thu, Dec 10, 2020 at 04:50:42PM +0100, Lorenzo Bianconi
> > > > > > wrote:
> > > > > > > Introduce xdp_init_buff utility routine to initialize
> > > > > > > xdp_buff data
> > > > > > > structure. Rely on xdp_init_buff in all XDP capable
> > > > > > > drivers.
> > > > > > 
> > > > > > Hm, Jesper was suggesting two helpers, one that you
> > > > > > implemented
> > > > > > for things
> > > > > > that are set once per NAPI and the other that is set per
> > > > > > each
> > > > > > buffer.
> > > > > > 
> > > > > > Not sure about the naming for a second one -
> > > > > > xdp_prepare_buff ?
> > > > > > xdp_init_buff that you have feels ok.
> > > > > 
> > > > > ack, so we can have xdp_init_buff() for initialization done
> > > > > once
> > > > > per NAPI run and 
> > > > > xdp_prepare_buff() for per-NAPI iteration initialization,
> > > > > e.g.
> > > > > 
> > > > > static inline void
> > > > > xdp_prepare_buff(struct xdp_buff *xdp, unsigned char
> > > > > *hard_start,
> > > > > 		 int headroom, int data_len)
> > > > > {
> > > > > 	xdp->data_hard_start = hard_start;
> > > > > 	xdp->data = hard_start + headroom;
> > > > > 	xdp->data_end = xdp->data + data_len;
> > > > > 	xdp_set_data_meta_invalid(xdp);
> > > > > }
> > > > 
> > > > I think we should allow for setting the data_meta as well.
> > > > x64 calling convention states that first four args are placed
> > > > onto
> > > > registers, so to keep it fast maybe have a third helper:
> > > > 
> > > > static inline void
> > > > xdp_prepare_buff_meta(struct xdp_buff *xdp, unsigned char
> > > > *hard_start,
> > > > 		      int headroom, int data_len)
> > > > {
> > > > 	xdp->data_hard_start = hard_start;
> > > > 	xdp->data = hard_start + headroom;
> > > > 	xdp->data_end = xdp->data + data_len;
> > > > 	xdp->data_meta = xdp->data;
> > > > }
> > > > 
> > > > Thoughts?
> > > 
> > > ack, I am fine with it. Let's wait for some feedback.
> > > 
> > > Do you prefer to have xdp_prepare_buff/xdp_prepare_buff_meta in
> > > the
> > > same series
> > > of xdp_buff_init() or is it ok to address it in a separate patch?
> > > 
> > 
> > you only need 2
> > why do you need xpd_prepare_buff_meta? that's exactly
> > what xdp_set_data_meta_invalid(xdp) is all about.
> 
> IIUC what Maciej means is to avoid to overwrite xdp->data_meta with
> xdp_set_data_meta_invalid() after setting it to xdp->data in
> xdp_prepare_buff_meta().
> I guess setting xdp->data_meta to xdp->data is valid, it means an
> empty meta
> area.
> Anyway I guess we can set xdp->data_meta to xdp->data wherever we
> need and just
> keep xdp_prepare_buff(). Agree?
> 

hmm, i agree, but I would choose a default that is best for common use
case performance, so maybe do xd->data_meta = xdp->data by default and
drivers can override it, as they are already doing today if they don't
support it.

> Regards,
> Lorenzo
> 
> > 

