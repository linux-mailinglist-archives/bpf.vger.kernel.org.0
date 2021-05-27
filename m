Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E15392C0F
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhE0Ko4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 06:44:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32964 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhE0Koz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 06:44:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lmDU1-0008Bd-Rh; Thu, 27 May 2021 10:43:21 +0000
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: bpf: Run devmap xdp_prog on flush instead of bulk enqueue
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <86500107-ac79-6a17-7ef6-25033224c669@canonical.com>
Date:   Thu, 27 May 2021 11:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Static analysis with Coverity on linux-next detected a minor issue that
was introduced with the following commit:

commit cb261b594b4108668e00f565184c7c221efe0359
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed May 19 17:07:44 2021 +0800

    bpf: Run devmap xdp_prog on flush instead of bulk enqueue

The analysis is as follows:

370static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
371{
372        struct net_device *dev = bq->dev;
373        int sent = 0, drops = 0, err = 0;
374        unsigned int cnt = bq->count;
375        int to_send = cnt;
376        int i;
377
378        if (unlikely(!cnt))
379                return;
380
381        for (i = 0; i < cnt; i++) {
382                struct xdp_frame *xdpf = bq->q[i];
383
384                prefetch(xdpf);
385        }
386
387        if (bq->xdp_prog) {
388                to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q,
cnt, dev);
389                if (!to_send)
390                        goto out;
391
   Unused value (UNUSED_VALUE)
   assigned_value: Assigning value from cnt - to_send to drops here, but
that stored value is overwritten before it can be used.

392                drops = cnt - to_send;
393        }
394
395        sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
396        if (sent < 0) {
397                /* If ndo_xdp_xmit fails with an errno, no frames have
398                 * been xmit'ed.
399                 */
400                err = sent;
401                sent = 0;
402        }
403
404        /* If not all frames have been transmitted, it is our
405         * responsibility to free them
406         */
407        for (i = sent; unlikely(i < to_send); i++)
408                xdp_return_frame_rx_napi(bq->q[i]);
409
410out:

   value_overwrite: Overwriting previous write to drops with value from
cnt - sent.

411        drops = cnt - sent;
412        bq->count = 0;
413        trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
414}

drops is being calculated twice but the first value is not used. Not
sure if that was intentional or an oversight.

Colin
