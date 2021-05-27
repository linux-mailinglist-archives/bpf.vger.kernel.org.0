Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB6392F2A
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhE0NNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 09:13:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:32372 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhE0NNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 09:13:09 -0400
IronPort-SDR: BjQqo8Qa4ioM90TIe1Vhne9O4Y+xR0Mn8gB61VMheApCqLgKXzvhkMVSmUviuFNQ1GgArM5SY9
 G8rbKbPyTVqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182383803"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="182383803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:11:36 -0700
IronPort-SDR: +JDOAma+uJ9hDhTIScQWJOcLnw2cYxnK/84jTZ/PK4VbPIahNfaIekTqdgGgSQwrxEMINZgJ4X
 zHyIs0jTop1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="480574798"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2021 06:11:34 -0700
Date:   Thu, 27 May 2021 14:58:41 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bpf: Run devmap xdp_prog on flush instead of bulk enqueue
Message-ID: <20210527125841.GA5695@ranger.igk.intel.com>
References: <86500107-ac79-6a17-7ef6-25033224c669@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86500107-ac79-6a17-7ef6-25033224c669@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 11:43:20AM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity on linux-next detected a minor issue that
> was introduced with the following commit:
> 
> commit cb261b594b4108668e00f565184c7c221efe0359
> Author: Jesper Dangaard Brouer <brouer@redhat.com>
> Date:   Wed May 19 17:07:44 2021 +0800
> 
>     bpf: Run devmap xdp_prog on flush instead of bulk enqueue
> 
> The analysis is as follows:
> 
> 370static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> 371{
> 372        struct net_device *dev = bq->dev;
> 373        int sent = 0, drops = 0, err = 0;
> 374        unsigned int cnt = bq->count;
> 375        int to_send = cnt;
> 376        int i;
> 377
> 378        if (unlikely(!cnt))
> 379                return;
> 380
> 381        for (i = 0; i < cnt; i++) {
> 382                struct xdp_frame *xdpf = bq->q[i];
> 383
> 384                prefetch(xdpf);
> 385        }
> 386
> 387        if (bq->xdp_prog) {
> 388                to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q,
> cnt, dev);
> 389                if (!to_send)
> 390                        goto out;
> 391
>    Unused value (UNUSED_VALUE)
>    assigned_value: Assigning value from cnt - to_send to drops here, but
> that stored value is overwritten before it can be used.
> 
> 392                drops = cnt - to_send;
> 393        }
> 394
> 395        sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
> 396        if (sent < 0) {
> 397                /* If ndo_xdp_xmit fails with an errno, no frames have
> 398                 * been xmit'ed.
> 399                 */
> 400                err = sent;
> 401                sent = 0;
> 402        }
> 403
> 404        /* If not all frames have been transmitted, it is our
> 405         * responsibility to free them
> 406         */
> 407        for (i = sent; unlikely(i < to_send); i++)

FWIW at the time that I was suggesting a rewrite of bq_xmit_all we were
using the 'drops' above via:

		for (i = 0; i < cnt - drops; i++) {

So looks like now the calculation at line 392 is actually not needed.

> 408                xdp_return_frame_rx_napi(bq->q[i]);
> 409
> 410out:
> 
>    value_overwrite: Overwriting previous write to drops with value from
> cnt - sent.
> 
> 411        drops = cnt - sent;
> 412        bq->count = 0;
> 413        trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
> 414}
> 
> drops is being calculated twice but the first value is not used. Not
> sure if that was intentional or an oversight.
> 
> Colin
