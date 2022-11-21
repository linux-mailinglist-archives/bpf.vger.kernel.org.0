Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82563632DD7
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 21:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKUUUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKUUUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 15:20:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F8CFA67
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 12:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:References;
        bh=qaupadcjhzZWuwo0SW1FLQDoGV393NT+0ekZNi1CQlM=; b=NEF7A7h+pT/8S99HRFYNHfGzd9
        1DGY+mEVxaTLHONneGw7xWiYLcyZF6lE4uZ9PoKfxCM+lAJXd9zEzP9+P3kQLiRQWMj7bZHB+LoeQ
        U8wPTuUOJMmh2rrdgkS2vHyQTVKLV09US9z17HwgouMku/QHyvnrqQGLyoeseECxZ/pmku3VZg5ci
        8PZ2LybZEtCLzgHc5lIh/IqV9LhDDyC9ld9xLgKrLj1JVe+mklsE6Fe+y10TrU6rM+wcbEoLGJ6sZ
        4LYK1AuZoaWg4ryzMEsyay5i4uTUnOLtKFAqAgjuwWsBg3ITTcVcn7VaL/CxNsLtM00aXe275kN4v
        xEyaNwYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxDHO-00HXrP-PS; Mon, 21 Nov 2022 20:20:34 +0000
Date:   Mon, 21 Nov 2022 12:20:34 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y3vdkuR9aeU/k/xX@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 12:12:49PM -0800, Luis Chamberlain wrote:
> On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
> > Based on our experiments [5], we measured ~0.6% performance improvement
> > from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
> 
> I'd prefer we leave out arbitrary performance data, as it does not help much.

I'd like to clarify what I mean by this, as Linus has suggested before, you are
missing the opportunity to present "actual numbers on real loads. (not
some artificial benchmark)"

[0] https://lkml.kernel.org/r/CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com

  Luis
