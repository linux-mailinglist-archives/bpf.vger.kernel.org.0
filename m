Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D62055BD
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbgFWPXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 11:23:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732781AbgFWPXn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Jun 2020 11:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592925821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkdtYf2kwyyb+dIrinnWgEYhv+CYsPN/Gka6CU8eb4Q=;
        b=eadu6oiNvDdNkLAsIdNBn3QmVnCC0q4hjQN2EB+7s9GeXwN1pVbTv1WVt5Izg5vTtPP4US
        0muUO5MV39Qj0DgaVYMzEXgqsfkR78CQ2jobrWJWM973Bg84NINZqW5AgMfDi+hFpNqXm0
        xMQ72IKjrOGdzVbMQLLzNwAjXeOq61c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-aHO5NrcdMgqP1jauFqqg6A-1; Tue, 23 Jun 2020 11:23:37 -0400
X-MC-Unique: aHO5NrcdMgqP1jauFqqg6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C051835B48;
        Tue, 23 Jun 2020 15:23:36 +0000 (UTC)
Received: from carbon (unknown [10.40.208.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB79B60CD3;
        Tue, 23 Jun 2020 15:23:24 +0000 (UTC)
Date:   Tue, 23 Jun 2020 17:23:23 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, toke@redhat.com,
        lorenzo.bianconi@redhat.com, dsahern@kernel.org, brouer@redhat.com
Subject: Re: [PATCH v2 bpf-next 4/8] bpf: cpumap: add the possibility to
 attach an eBPF program to cpumap
Message-ID: <20200623172323.603cf62c@carbon>
In-Reply-To: <734113565894cb8447d1526e6a93eaf6ae994c2d.1592606391.git.lorenzo@kernel.org>
References: <cover.1592606391.git.lorenzo@kernel.org>
        <734113565894cb8447d1526e6a93eaf6ae994c2d.1592606391.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Jun 2020 00:57:20 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> @@ -260,10 +322,11 @@ static int cpu_map_kthread_run(void *data)
>  		 * kthread CPU pinned. Lockless access to ptr_ring
>  		 * consume side valid as no-resize allowed of queue.
>  		 */
> -		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> +		n = ptr_ring_consume_batched(rcpu->queue, xdp_frames,
> +					     CPUMAP_BATCH);

This should have used the non-lock variant __ ptr_ring_consume_batched().
It did before, but I can see in git-history that this is this is a
bug/issue I introduced myself earlier... ups.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

