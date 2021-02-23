Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496D5323287
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhBWUzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 15:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbhBWUza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 15:55:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C95060233;
        Tue, 23 Feb 2021 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614113689;
        bh=2LyNLNXwfUV4cMur0+fcQl9ItS2sdYXeL9Er3zGpzSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VX3ZulvA7TJS70wZCZ9zEz6Dh0GdeI9kbOke0N7bUxwUVyFVEARp/GyDNShhWPOUh
         6x1sSOgDe2y0SdzYa2w4o8Q0ycqMmB+OuwyvQxV7GBiHbT9cMPd+71bpTHf9opocoG
         hX9N0JL+sO2qQeCRkWWMZV7tcMnHhY2fjGc0OD/MfsyGAk6sokkhxC7TVd/gEAR04i
         STvLbsHATdmnVG6LkL/QLFLIHqJcSZhwuncW8km7j/eHZHHjyrAzfejRBqlPXAtFTk
         Yhzsop68uxhEWGPOUqr/qoaOKP6nLY8Zpewsv8IwloFSuhquW8BGUau2PmwZf0ivQ/
         ZJooXhJFlR0fA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 299CD40CD9; Tue, 23 Feb 2021 17:54:46 -0300 (-03)
Date:   Tue, 23 Feb 2021 17:54:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
Message-ID: <YDVrloA5febB9BeA@kernel.org>
References: <20210212211607.2890660-1-morbo@google.com>
 <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Feb 23, 2021 at 12:44:58PM -0800, Bill Wendling escreveu:
> Bump for exposure.

While preparing my presentation for devconf.cz I stumbled on a problem
with split btf, I want to first bisect this before publishing...

I'll move this to the front of my priority list and inform here about it
ASAP.

- Arnaldo

 
> On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
> >
> > Hey gang,
> >
> > I would like your feedback on this patch.
> >
> > This patch creates one hash table that all CUs share. The impetus for this
> > patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
> > can't handle the DWARF data that clang produces, because the CUs may refer to
> > tags in other CUs (all of the code having been squozen together).
> >
> > One solution I found is to process the CUs in two steps:
> >
> >   1. add the CUs into a single hash table, and
> >   2. perform the recoding and finalization steps in a a separate step.
> >
> > The issue I'm facing with this patch is that it balloons the runtime from
> > ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
> > all) hash buckets have thousands of entries each. I've bumped up the
> > HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
> > above causes a failure.
> >
> > A couple of things I thought of may help. We could increase the number of
> > buckets, which would help with distribution. As I mentioned though, that seemed
> > to cause a failure. Another option is to store the bucket entries in a
> > non-list, e.g. binary search tree.
> >
> > I wanted to get your opinions before I trod down one of these roads.
> >
> > Share and enjoy!
> > -bw
> >
> > Bill Wendling (1):
> >   dwarf_loader: have all CUs use a single hash table
> >
> >  dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >

-- 

- Arnaldo
