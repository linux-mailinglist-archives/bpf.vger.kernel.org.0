Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A531DEEA9
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgEVRzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 13:55:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730741AbgEVRzP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 13:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590170114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHUSAzeELb2TzwWrwfP1SxTdKCGMte/l75+CkFOS9Mg=;
        b=FSRIMd6YXBviVmlA+94QTYr+UKUPMpqOLj9NCmZARjZKmteCh9GVOCzSLbUoQJrSj+9F6h
        Lm5vSgIurg8yPcBbTwmBvpmSHbyqOJRZUt4QvXwWrfq6F7PVNswQKjRK4MiuYvrnFar22S
        8WgOiSxw/UPtIjUwmdqMeUSwZ0w1w68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-4dzWbWqFPneBgbq9nxaPHA-1; Fri, 22 May 2020 13:55:10 -0400
X-MC-Unique: 4dzWbWqFPneBgbq9nxaPHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25CB5872FE2;
        Fri, 22 May 2020 17:55:07 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6417C105B1E0;
        Fri, 22 May 2020 17:54:58 +0000 (UTC)
Date:   Fri, 22 May 2020 19:54:56 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, brouer@redhat.com
Subject: Re: [RFC bpf-next 1/2] bpf: cpumap: add the possibility to attach a
 eBPF program to cpumap
Message-ID: <20200522195456.73ddb852@carbon>
In-Reply-To: <289effd3-5a58-17a3-af2f-22cc3222f2d9@gmail.com>
References: <cover.1590162098.git.lorenzo@kernel.org>
        <6685dc56730e109758bd3affb1680114c3064da1.1590162098.git.lorenzo@kernel.org>
        <289effd3-5a58-17a3-af2f-22cc3222f2d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 22 May 2020 11:44:04 -0600
David Ahern <dsahern@gmail.com> wrote:

> On 5/22/20 10:11 AM, Lorenzo Bianconi wrote:
> > @@ -259,28 +270,64 @@ static int cpu_map_kthread_run(void *data)
> >  		 * kthread CPU pinned. Lockless access to ptr_ring
> >  		 * consume side valid as no-resize allowed of queue.
> >  		 */
> > -		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> > +		n = ptr_ring_consume_batched(rcpu->queue, xdp_frames,
> > +					     CPUMAP_BATCH);
> >  
> > +		rcu_read_lock();
> > +
> > +		prog = READ_ONCE(rcpu->prog);
> >  		for (i = 0; i < n; i++) {
> > -			void *f = frames[i];
> > +			void *f = xdp_frames[i];
> >  			struct page *page = virt_to_page(f);
> > +			struct xdp_frame *xdpf;
> > +			struct xdp_buff xdp;
> > +			u32 act;
> >  
> >  			/* Bring struct page memory area to curr CPU. Read by
> >  			 * build_skb_around via page_is_pfmemalloc(), and when
> >  			 * freed written by page_frag_free call.
> >  			 */
> >  			prefetchw(page);
> > +			if (!prog) {
> > +				frames[nframes++] = xdp_frames[i];
> > +				continue;
> > +			}
> > +
> > +			xdpf = f;
> > +			xdp.data_hard_start = xdpf->data - xdpf->headroom;
> > +			xdp.data = xdpf->data;
> > +			xdp.data_end = xdpf->data + xdpf->len;
> > +			xdp.data_meta = xdpf->data - xdpf->metasize;
> > +			xdp.frame_sz = xdpf->frame_sz;
> > +			/* TODO: rxq */
> > +
> > +			act = bpf_prog_run_xdp(prog, &xdp);  
> 
> Why not run the program in cpu_map_enqueue before converting from
> xdp_buff to xdp_frame?

Because we want to run the XDP-prog on the remote-CPU.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

