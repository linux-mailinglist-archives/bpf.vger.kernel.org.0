Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBA6F4ED4
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjECCdQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECCdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 22:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35615273A
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 19:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B026562961
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 02:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818BBC433EF;
        Wed,  3 May 2023 02:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683081191;
        bh=buveVOwFOebuwLuyDRCX6PdscONvgUosbbXfzhd3W2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iIJPFXex4+ouazaqpf+lM5PNzTtuWJnALfMGpQrgzBy3P4dcBM1GP5cTFQL44ukql
         DfaI3KMZxCupVg9YtoRyNSYuo8nbZdy6Mp4RX3+wXAK71MbPE/t2ZT9LUMX6Fkewun
         U0rWMCXjNWfW39cHNDJ9of3/vZX7K1FcZQcOcFckmLrQHj9xHB77cgVMh8T70AxcCm
         7ec7T9eVowrwNks7ZCiHqFzdh7Bmg3THf9lJfTJiGS0WJ4shjhT5R9neMiHBuFcyFd
         hNRFctxjGQ6rCVBN6kkGqnhir9X29nfrygJf4/n4UtXEPJGb0oMjONvlrPtfkZy1Ac
         STkUAyLXD9OLA==
Date:   Tue, 2 May 2023 19:33:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
        lorenzo@kernel.org,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, linyunsheng@huawei.com, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V3 1/2] page_pool: Remove workqueue in
 new shutdown scheme
Message-ID: <20230502193309.382af41e@kernel.org>
In-Reply-To: <168269857929.2191653.13267688321246766547.stgit@firesoul>
References: <168269854650.2191653.8465259808498269815.stgit@firesoul>
        <168269857929.2191653.13267688321246766547.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 Apr 2023 18:16:19 +0200 Jesper Dangaard Brouer wrote:
> This removes the workqueue scheme that periodically tests when
> inflight reach zero such that page_pool memory can be freed.
> 
> This change adds code to fast-path free checking for a shutdown flags
> bit after returning PP pages.

We can remove the warning without removing the entire delayed freeing
scheme. I definitely like the SHUTDOWN flag and patch 2 but I'm a bit
less clear on why the complexity of datapath freeing is justified.
Can you explain?

> Performance is very important for PP, as the fast path is used for
> XDP_DROP use-cases where NIC drivers recycle PP pages directly into PP
> alloc cache.
> 
> This patch (since V3) shows zero impact on this fast path. Micro
> benchmarked with [1] on Intel CPU E5-1650 @3.60GHz. The slight code
> reorg of likely() are deliberate.
