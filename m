Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3086A4D47
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB0Ven (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjB0Ven (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:34:43 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9E10A9C
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:34:38 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AD11E240046
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 22:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677533676; bh=N3Cl0dVF3KngUNLczghVfGvreW+irH7i9sl26cJN0pw=;
        h=Date:From:To:Cc:Subject:From;
        b=EkoOKwDklZrQaOLgmOQfi8Lqj/SA1SQH9z1lnH9dJhEflaAIeeramLfgDUyllM1mD
         BUH2FX/61Kblj/tDALVWLupK6BmDqM7w+J12ylM+hH65xUP2JHN4HRwcu5Zet8f4Wz
         vAUZS8J5bSvdDvbrxKNMlIVJD1Zc/6FlNcVYQlm5seoYmTZZzv8GpiBFxpz3QsJMxL
         yv/H5QXSTKNSIHGGxdoMTiK5WCspsFUpVS5+UPrbn+1sjf60CZkl60H60LtviPUIuJ
         cBhjmC5WO8YBWwb+vd5d82OQINKsZQRDNOLbodYcs5C09VITK4qEb7lq3QSDCKB81u
         z82/ON8eLYPmg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PQYfy3M1vz6tnm;
        Mon, 27 Feb 2023 22:34:34 +0100 (CET)
Date:   Mon, 27 Feb 2023 21:34:30 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Batteries-included symbolization with blazesym
Message-ID: <20230227213430.qxfrupne3g4lvsla@muellerd-fedora-PC2BDTX9>
References: <20230227193456.jbxt3mba6xfntieu@muellerd-fedora-PC2BDTX9>
 <20230227200748.xdkhnht2w4mtbj2u@kashmir.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227200748.xdkhnht2w4mtbj2u@kashmir.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Mon, Feb 27, 2023 at 01:07:48PM -0700, Daniel Xu wrote:
> On Mon, Feb 27, 2023 at 07:34:56PM +0000, Daniel Müller wrote:
> > Symbolization of addresses is a commonly encountered problem, maybe most so in
> > the context of BPF and tracing with the capturing of stack traces. Perhaps
> > superficially straightforward-looking, there a variety of considerations and
> > intricacies, such as:
> > - different formats/standards (e.g., ELF symbol information, DWARF, GSYM) cater
> >   to different use cases and require vastly different steps to work with
> >   - on top of that, even if a library such as libelf or libdwarf is relied on,
> >     plenty of format specific details need to be known to symbolize addresses
> >     properly
> > - discovery of symbolization sources (e.g., DWARF debug files)
> > - symbolization trade-offs (performance, memory usage)
> > - system-specific details and corner cases
> > 
> > We are working on blazesym [0], a library that aims to provide users with a
> > batteries-included experience for symbolizing addresses (but also the reverse:
> > mapping symbols to addresses).
> > 
> > We would like to provide a brief overview of the library and its goals and then
> > open up for discussion. Some topics we are specifically interested in
> > understanding better:
> > - What are current issues with symbolization that would be great to support?
> > - Does the usage of Rust pose a problem in your context? (C bindings are
> >   available, but a Rust toolchain is required for building; are pre-built
> >   binaries and packages for common distributions sufficient for your use cases?)
> > 
> > In general, we'd be interested in hearing your use cases and in discussing
> > whether blazesym is a fit or could be made to work.
> 
> I didn't look super close at blazesym yet, but was wondering if it would
> support a use case I have in mind.
> 
> Context is it's tricky to determine why a packet was dropped by kernel.
> kfree_skb_reason() with caller address in `location` is a good start but
> we can do better I think.
> 
> The issue is the call stack alone is not enough detail. I want to see
> all the branches taken in the case a single call frame has multiple ways
> to drop.
> 
> Vague idea is to use the recent LBR work (also haven't looked hard yet,
> so this may not be possible) to take LBR stack at
> `tracepoint:skb:kfree_skb` tracepoint. Then map the branches to line
> numbers.
> 
> So my question is this: can/will blazesym be able to map kernel
> addresses to line numbers / file names?

Blazesym should be able to help with the symbolization aspect, yes. That is, it
can convert the addresses you captured into symbol name + source file + line
information as you asked for (you may need DWARF debug information for anything
beyond mere symbol names). In general, the library is able to handle both user
space and kernel addresses.

It is not designed, however, to help you capture those addresses. So how you get
them (e.g., using LBR as you mentioned) is up to you.

Daniel
