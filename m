Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB617587026
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiHASD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiHASDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7732AE30;
        Mon,  1 Aug 2022 11:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B04A66109E;
        Mon,  1 Aug 2022 18:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD15C433C1;
        Mon,  1 Aug 2022 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376976;
        bh=fkxFSycSkhpqy8tlJDVKO4EElhG+NIDTEL0EX1VXSWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAY6Bf/AXJVPIRZluNX/xj6T1f9q8K3xsi6rMu/pcQa6J8tqULAUN8YbIpk1R5Uxq
         U7RGLG/cGNTyamoT/mCd8HBijti5HVqhqpnN0qAQaTbPxyn25JS5zXWZ18W5JRSX27
         7CBSjdr1efv8UPLI/gQ9XPb/Wly7LkPvKoLQhb9G0/OF21PBGMJxnNSd+avVhcWa23
         UdBRTyvjt6JCoZ/lUnmAa22v++uTismBy9vGCCdFEDD/qD+y1dDiQm/vWXLVCTZKyb
         yTAYYR/WacItIPIXsKfiNOKiPrE276Y0DW8Z5/LlyP8LIv48pM9/sgEgQYkxuoXPvB
         QHfvkfowbwvEQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB26440736; Mon,  1 Aug 2022 15:02:53 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:02:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andres Freund <andres@anarazel.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YugVTQ7CoqXRTNBY@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <YufK0qnvVWCAFGEH@kernel.org>
 <ce9140c7-dd4b-0c4e-db7c-d25022cfe739@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9140c7-dd4b-0c4e-db7c-d25022cfe739@isovalent.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Aug 01, 2022 at 04:15:19PM +0100, Quentin Monnet escreveu:
> On 01/08/2022 13:45, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jul 31, 2022 at 06:38:26PM -0700, Andres Freund escreveu:
> >> binutils changed the signature of init_disassemble_info(), which now causes
> >> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> >> binutils commit:
> >> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> >>
> >> I first fixed this without introducing the compat header, as suggested by
> >> Quentin, but I thought the amount of repeated boilerplate was a bit too
> >> much. So instead I introduced a compat header to wrap the API changes. Even
> >> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> >> looks nicer this way.
> >>
> >> I'm not regular contributor, so it very well might be my procedures are a
> >> bit off...
> >>
> >> I am not sure I added the right [number of] people to CC?
> > 
> > I think its ok
> >  
> >> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> > 
> > I think its related to libbfd, and it comes from a long time ago, trying
> > to find the cset adding that...
> > 
> >> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> >> in feature/Makefile and why -ldl isn't needed in the other places. But...
> >>
> >> V2:
> >> - split patches further, so that tools/bpf and tools/perf part are entirely
> >>   separate
> > 
> > Cool, thanks, I'll process the first 4 patches, then at some point the
> > bpftool bits can be merged, alternatively I can process those as well if
> > the bpftool maintainers are ok with it.
> > 
> > I'll just wait a bit to see if Jiri and others have something to say.
> > 
> > - Arnaldo
> 
> Thanks for this work! For the series:
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> For what it's worth, it would make sense to me that these patches remain
> together (so, through Arnaldo's tree), given that both the perf and
> bpftool parts depend on dis-asm-compat.h being available.

Ok, so I'm tentatively adding it to my local tree to do some tests, if
someone disagrees, please holler.

- Arnaldo
