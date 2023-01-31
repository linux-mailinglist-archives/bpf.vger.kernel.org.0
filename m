Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22703682137
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 02:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjAaBE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 20:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAaBE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 20:04:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC530284
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 17:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 073B0B81717
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 01:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87014C433EF;
        Tue, 31 Jan 2023 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675127058;
        bh=5cDq8WSVc1jyBRVJl/cWqEA7FAya/qIn0sdtMnLCQT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU+MWvsJieilLEArzsFX6nnsc+DuqHhej0X+aj+OMPZljDXs7K7W3w5PrUnmqkTev
         ylE/WszOI9Svl6WQRYeDZBxNCUOuuiXmcane2OWHliuSApW6McdV5WnopEw1S+ukok
         6zNoxN5qrzX7t5l1qxkf8bnhPkVDabaDpbTRpJgHf39O9SUcR3HAYE4FEyLYZY0OZt
         3uvV/9BJCxjvp/opbijJWV+zew5chTvJto9nIm5BVuX6CaAFvpBRJKpWQKkrqWXNeR
         +rDhLVhrLrZSESn34/4No1d2s4E1H/BqhxjOL9k6iSkzjk+7o52P60KX6W/a0EgyC+
         I2Djc4lHitQDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01891405BE; Mon, 30 Jan 2023 22:04:15 -0300 (-03)
Date:   Mon, 30 Jan 2023 22:04:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9hpD0un8d/b+Hb+@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org>
 <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9hf7cgqt6BHt2dH@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >> +++ b/dwarves.h
> > >> @@ -262,6 +262,7 @@ struct cu {
> > >>  	uint8_t		 has_addr_info:1;
> > >>  	uint8_t		 uses_global_strings:1;
> > >>  	uint8_t		 little_endian:1;
> > >> +	uint8_t		 nr_register_params;
> > >>  	uint16_t	 language;
> > >>  	unsigned long	 nr_inline_expansions;
> > >>  	size_t		 size_inline_expansions;
> > > 
>  
> > Thanks for this, never thought of cross-builds to be honest!
> 
> > Tested just now on x86_64 and aarch64 at my end, just ran
> > into one small thing on one system; turns out EM_RISCV isn't
> > defined if using a very old elf.h; below works around this
> > (dwarves otherwise builds fine on this system).
> 
> Ok, will add it and will test with containers for older distros too.

Its on the 'next' branch, so that it gets tested in the libbpf github
repo at:

https://github.com/libbpf/libbpf/actions/workflows/pahole.yml

It failed yesterday and today due to problems with the installation of
llvm, probably tomorrow it'll be back working as I saw some
notifications floating by.

I added the conditional EM_RISCV definition as well as removed the dup
iterator that Jiri noticed.

Thanks,

- Arnaldo
 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index dba2d37..47a3bc2 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -992,6 +992,11 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *c
> >         return member;
> >  }
> >  
> > +/* for older elf.h */
> > +#ifndef EM_RISCV
> > +#define EM_RISCV       243
> > +#endif
> > +
> >  /* How many function parameters are passed via registers?  Used below in
> >   * determining if an argument has been optimized out or if it is simply
> >   * an argument > cu__nr_register_params().  Making cu__nr_register_params()
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
