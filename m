Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0074D64673B
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 03:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLHCsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 21:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHCsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 21:48:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D488B75
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 18:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HZZV66Q510zOYrSZ8gvjocnRVxTk+78FBZKmi0gwUK4=; b=PeTbLrft3SflFkZlDXqUlDKUXe
        KvD6z8Gk8Fl36p/CGgFytM/8xq9bmGtdgdWTYi4c1pKZPz2IDQm67VOUnW3ABOT6SJ/YDUvhYO00t
        +olq42xjfqjEG3mgBN9LBSDIGhNklM2UFF739diolakBqaacFuO7dPICD88ok8X1acbDf7FtarIuP
        IuQfO7Q+ONTu29L7tymXPo57yoUmBid//lalUDHYpEpzInOwRtjpxY3ispWr7BliDNujg5ZhwMKbu
        UkXGtbjDXwKxms4mTCWCqQfCXBfJwcmmcKuTgXwD4BKuyh8S43ZAjQ4uSlzhunnPdgXQMt3PTlYUu
        4qIf84Fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p36xf-000WUx-Kg; Thu, 08 Dec 2022 02:48:35 +0000
Date:   Wed, 7 Dec 2022 18:48:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, willy@infradead.org,
        dave@stgolabs.net, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y5FQg3A+wENx50Vf@bombadil.infradead.org>
References: <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
 <Y3vdkuR9aeU/k/xX@bombadil.infradead.org>
 <CAPhsuW4ejraDjOq-C2ScUJ+DD73b26V_1YCW8E4S-hXgh=Gt_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4ejraDjOq-C2ScUJ+DD73b26V_1YCW8E4S-hXgh=Gt_w@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 07:36:21PM -0700, Song Liu wrote:
> On Mon, Nov 21, 2022 at 1:20 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Nov 21, 2022 at 12:12:49PM -0800, Luis Chamberlain wrote:
> > > On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:
> > > > Based on our experiments [5], we measured ~0.6% performance improvement
> > > > from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
> > >
> > > I'd prefer we leave out arbitrary performance data, as it does not help much.
> >
> > I'd like to clarify what I mean by this, as Linus has suggested before, you are
> > missing the opportunity to present "actual numbers on real loads. (not
> > some artificial benchmark)"
> >
> > [0] https://lkml.kernel.org/r/CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com
> 
> Unless I made some serious mistakes, Linus' concern with performance was
> addressed by the exact performance results above. [5]
> 
> [5] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/

AFAICT no, that still is all still artificial.

  Luis
