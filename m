Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB663D23D
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiK3JmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiK3JmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 04:42:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3453132
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 01:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8371F61A5E
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 09:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CF2C433C1;
        Wed, 30 Nov 2022 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669801333;
        bh=+hFunFOckwGRMYLvfCOQLQTdvGbAc7QBclk3Vh6O+Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFDP+URli+rlZfs0AsL9hl1RblewQawNLqNKaIgBBNKiOIEZiIcOB4s6SwuggEwA9
         AAg8IBh7xeLw97kpxXzK54o4ob5oncsytUhsG3wEAYbWZYKNPS/tr2PFGtQ1g/QHNs
         LBMfF2EsQxXM9x9WMP/TCIz7u2tp7BqAt14miqBXZtU3MHlO/Ziswo5F0SxMNCh7l/
         xCOjKQw65lW6l7xhzofYxzEUz/Ay3eRIkef7AyknVuIYgkqrLGbp4cDH+OGvslRf43
         SwYvyfrgBWHz3fMB0HWggKNTk5vvEeFDz9fPRpAQ/Pm8NHPMdwxHAH1gKBlGrFvxrG
         SZM7CcUnvITIg==
Date:   Wed, 30 Nov 2022 11:41:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        willy@infradead.org, dave@stgolabs.net, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
Message-ID: <Y4clZK5nPInMfgb3@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
 <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
 <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7AfwpV6G8U7VRXMcjBEUf7OCOY5eR7eagEoXVK-AmBRg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 07:28:36PM -0700, Song Liu wrote:
> On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Also, you mention your perf stats are run on a VM, I am curious what
> > things you need to get TLB to be properly measured on the VM and if
> > this is really reliable data Vs bare metal. I haven't yet been sucessful
> > on getting perf stat for TBL to work on a VM and based on what I've read
> > have been catious about the results.
> 
> To make these perf counters work on VM, we need a newer host kernel
> (my system is running 5.6 based kernel, but I am not sure what is the
> minimum required version). Then we need to run qemu with option
> "-cpu host" (both host and guest are x86_64).
> 
> >
> > So curious if you'd see something different on bare metal.
> 
> Once the above all worked out, VM runs the same as bare metal from
> perf counter's point of view.

TLBs behave differently because of EPT.

-- 
Sincerely yours,
Mike.
