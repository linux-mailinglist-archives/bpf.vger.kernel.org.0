Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3C6820AA
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAaAZd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjAaAZ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:25:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C22B635
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFACE6133A
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 00:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8CC433D2;
        Tue, 31 Jan 2023 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675124720;
        bh=kfHOQ/Qr0gkDvzmLrbRpfQ5V4P80RYmJ9onaz5pGXXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2uvn9ShE/8yS8KImGmFbc9nncscECtAxNabIZsbb+2TbizTfYZCCuGUP/GdFx0R6
         azqcJoCrV15JaEp9UJqgeOTdBgKFCLnMc/68fP/D1kgkE6KVnedNBhZik2OErotD9Z
         bMGZkKRySAQXOY3RiGay5Y9ApbePx9+Oucg7RX1HIeZC+/YiHDNBZNT7Ozp0bukQRG
         MJRiASKW6HXyuY9YXMdKsbim8xdlPNVYvdUCxn9WfFPObwrCNoSilMk2Y7Rd3vJpro
         ss9vgHv+tWDT3Wt4O3yftBh0Jg5oCehF8Mu73P1qxRj5icaQGQ2QUIDIhl0VmTBlqs
         lGS18dHJWDjFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4DB79405BE; Mon, 30 Jan 2023 21:25:17 -0300 (-03)
Date:   Mon, 30 Jan 2023 21:25:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9hf7cgqt6BHt2dH@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org>
 <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> +++ b/dwarves.h
> >> @@ -262,6 +262,7 @@ struct cu {
> >>  	uint8_t		 has_addr_info:1;
> >>  	uint8_t		 uses_global_strings:1;
> >>  	uint8_t		 little_endian:1;
> >> +	uint8_t		 nr_register_params;
> >>  	uint16_t	 language;
> >>  	unsigned long	 nr_inline_expansions;
> >>  	size_t		 size_inline_expansions;
> > 
 
> Thanks for this, never thought of cross-builds to be honest!

> Tested just now on x86_64 and aarch64 at my end, just ran
> into one small thing on one system; turns out EM_RISCV isn't
> defined if using a very old elf.h; below works around this
> (dwarves otherwise builds fine on this system).

Ok, will add it and will test with containers for older distros too.

- Arnaldo
 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index dba2d37..47a3bc2 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -992,6 +992,11 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *c
>         return member;
>  }
>  
> +/* for older elf.h */
> +#ifndef EM_RISCV
> +#define EM_RISCV       243
> +#endif
> +
>  /* How many function parameters are passed via registers?  Used below in
>   * determining if an argument has been optimized out or if it is simply
>   * an argument > cu__nr_register_params().  Making cu__nr_register_params()

-- 

- Arnaldo
