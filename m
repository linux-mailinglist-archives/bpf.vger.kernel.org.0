Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF355FCB3
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiF2Jz1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiF2Jz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 05:55:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F63DA4A
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656496525; x=1688032525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aE3Qm2uDouzTCkxeJcpk3kH9y8lb+LqNrqPV2jK0+kw=;
  b=ZLVpmKpQ746rhUIIFzT6Pvb4aaEkT4FtPZR/5J9FdpSB/atngfYPwDha
   n98CvEpf4O/ozGSKqq68Na9Tmf3ye+Acc33QgrqlCYtUw9GNj+tZxFT9a
   GiMQWNoDQyDc2/VAC2TlB7phRbGKUpxb8ihnou+tf/ZEVT+QK6AICne50
   +RFqXnpPICBkaOj3jY9IzQNkWBiMi2QrwnpwIhaDccIz9DNofn1xkDJhm
   3at2NeCgo73+KseBfM/s6tiKIDcIwNJr3x3f22zmVhOcQ5c6aGj6gpBPj
   /jtwxpSq59SRKgjap32L5ftC6RA8RXbQc4jsDMWxIbbXzONHHsohyDABz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343678639"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343678639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="623253765"
Received: from boxer.igk.intel.com (HELO boxer) ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2022 02:55:24 -0700
Date:   Wed, 29 Jun 2022 11:55:23 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, kernel-team@fb.com,
        Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/15] libbpf: move xsk.{c,h} into
 selftests/bpf
Message-ID: <Yrwhi2VWtxF+QJk6@boxer>
References: <20220627211527.2245459-1-andrii@kernel.org>
 <20220627211527.2245459-2-andrii@kernel.org>
 <YrweLB7omwEe/cR1@boxer>
 <014b5bf0-61b5-3510-0468-515c762247e1@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014b5bf0-61b5-3510-0468-515c762247e1@iogearbox.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 11:53:12AM +0200, Daniel Borkmann wrote:
> Hey Maciej,
> 
> On 6/29/22 11:41 AM, Maciej Fijalkowski wrote:
> > On Mon, Jun 27, 2022 at 02:15:13PM -0700, Andrii Nakryiko wrote:
> > > Remove deprecated xsk APIs from libbpf. But given we have selftests
> > > relying on this, move those files (with minimal adjustments to make them
> > > compilable) under selftests/bpf.
> > > 
> > > We also remove all the removed APIs from libbpf.map, while overall
> > > keeping version inheritance chain, as most APIs are backwards
> > > compatible so there is no need to reassign them as LIBBPF_1.0.0 versions.
> > 
> > Hey Andrii,
> > 
> > First of all, great that you are moving this over to selftests where we
> > can use this as the base for our upcoming control path tests. However,
> > during some of our selftests work we have found a bug in the xsk part of
> > libbpf that you're moving here. What is the way forward to fixing this
> > from your perspective? Should we wait once this set lands so that we would
> > fix this in the xsk.c file in selftests/bpf? Or would you pick the bugfix
> > before doing the move?
> 
> Just to answer this question, fwiw, the set has been applied yesterday to bpf-next
> tree [0], so from an upstream PoV, please send a relative fix for xsk.c file in
> selftests/bpf/.

Hey Daniel,

oops missed that somehow. Thanks for fast response!

> 
> Thanks,
> Daniel
> 
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=f36600634282a519e1b0abea609acdc8731515d7
