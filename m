Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00D587030
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiHASIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiHASIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:08:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87590EB4;
        Mon,  1 Aug 2022 11:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AF0AB81603;
        Mon,  1 Aug 2022 18:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C4C433C1;
        Mon,  1 Aug 2022 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659377324;
        bh=nL4VzcV6n54wQZr+44GERIOVz/Z2d+j88giD2uYtzPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXXkE9oNd5YlhcUhAax4X2t5hmmaairFVTgljUMjppk8DUJTENsGA4OZ0RLfTe8JC
         ORB72XtCcNpO52fz1Eq9vAy4ogKq+TUz6x9L3Cr8gWEoH/rgsg/hmoLqXCNcQGvqHu
         UXchqjsjNB/cXqpH2I/KgA7HjHYBpoarMBhBUGqghWC+j/IueoZGIMyXj14en05x0d
         TD/S3Ku13x2B9G3C7JVW1hHyqxeUmLZSClK/jNjMj0ho2PMuvz1ugRhGfEQCWwdxRZ
         BBHwQoWD00o9ESheeox8MyPyr2/W4tQ928Plcqob1f/WR4jFgRqoP6RhNkLai4LZyV
         ZRrQI1lAhXEbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A23D940736; Mon,  1 Aug 2022 15:08:41 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:08:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Andres Freund <andres@anarazel.de>, sedat.dilek@gmail.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YugWqb+n3wcs8TIu@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
 <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
 <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
 <60c84caf421d831ce6661c60503c1c56ef55e0ce.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c84caf421d831ce6661c60503c1c56ef55e0ce.camel@decadent.org.uk>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jul 15, 2022 at 09:18:26PM +0200, Ben Hutchings escreveu:
> On Fri, 2022-07-15 at 12:16 -0700, Andres Freund wrote:
> > Hi,
> > 
> > On 2022-07-14 15:25:44 +0200, Ben Hutchings wrote:
> > > Thanks, I meant to send that fix upstream but got distracted.  It
> > > should really be folded into "tools perf: Fix compilation error with
> > > new binutils".
> > 
> > I'll try to send a new version out soon. I think the right process is to add
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> > to the patch I squash it with?
> 
> Yes, OK.

Ok, so you agreed on this, I'm adding Ben's Signed-off-by tag then,

Thanks,

- Arnaldo
