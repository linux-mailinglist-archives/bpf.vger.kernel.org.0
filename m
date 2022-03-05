Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B704CE671
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiCESux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 13:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCESux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 13:50:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296217ED9D;
        Sat,  5 Mar 2022 10:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A26B80CA1;
        Sat,  5 Mar 2022 18:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EAEC004E1;
        Sat,  5 Mar 2022 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646506198;
        bh=JqYl0znm1BYdpC9OUgVyirfpI605DPBrVG/MLUoKXQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgOhfRUk5YwFSQq97l2pds/OziT7CD+DWMF8D3zvcNSW5jVEA9eY9oGBdPxXNTI/V
         K3jafAqUn1u+ZQg+Xp5bY8SWthmoQy0OUtgqWyzcbAYEd5nMmPP8r4IS2W3UveqgI2
         dKHOzLmT2kIHX2NbCoGS1DXvbjFtWDnbWZp9+snW/n7GUcpLcOZCe4qMw9R+bH8fVh
         Pb3msSzt9ccYlafuu8gvy98RPYNwtC3ZjuscXn1/4iHCnOCtLcAzbVMCeK1sdoXBte
         7LPOdB0U4IpNjfK2+6WSdBvWST5whWhXVHVLLkRrULY3i8t7tMLkjsJ1O/UJj5kq2O
         t/mcegqZchkog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58B32403C8; Sat,  5 Mar 2022 15:49:55 -0300 (-03)
Date:   Sat, 5 Mar 2022 15:49:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kkourt@kkourt.io
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: Re: [PATCH] pahole: avoid segfault when parsing a problematic file
Message-ID: <YiOw06rlBwdw2uYx@kernel.org>
References: <20220304113821.2366328-1-kkourt@kkourt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304113821.2366328-1-kkourt@kkourt.io>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 04, 2022 at 12:38:21PM +0100, kkourt@kkourt.io escreveu:
> From: Kornilios Kourtis <kornilios@isovalent.com>
> 
> When trying to use btf encoding for an apparently problematic kernel file,
> pahole segfaults. As can be seen below [1], the problem is that we are trying to
> dereference a NULL decoder.
> 
> Fix this by checking the return value of dwfl_getmodules which [2] whill return
> -1 on errors or an offset if one of the modules did not return DWARF_CB_OK. (In
> this specific case, it was __cus__load_debug_types that returnd
> DWARF_CB_ABORT.)
> 
> Also, ensure that we get a reasonable error by setting errno in
> cus__load_files(). Otherwise, we get a "No such file or directory" error which
> might be confusing.

Can you break this into two patches, one for checking dwfl_getmodules()
failure and the second setting errno?

We should try to avoid these patches that do multiple fixes, as
sometimes one of the fixes isn't really correct and we end up not being
able to use 'git revert' which should be the case when we figure out
that some previous fix wasn't correct.

Thanks for working on this, lemme know if you're busy in which case I
can do this myself.

Best regards,

- Arnaldo
 
> After tha patch:
> $ ./pahole -J vmlinux-5.3.18-24.102-default.debug
> pahole: vmlinux-5.3.18-24.102-default.debug: Unknown error -22
> 
> [1]:
> $ gdb -q --args ./pahole -J vmlinux-5.3.18-24.102-default.debug
> Reading symbols from ./pahole...
> (gdb) r
> Starting program: /tmp/pahole/build/pahole -J vmlinux-5.3.18-24.102-default.debug
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7f4000e in gobuffer__size (gb=0x18) at /tmp/pahole/gobuffer.h:39
> 39              return gb->index;
> (gdb) bt
> (gdb) frame 1
> 1042            if (gobuffer__size(&encoder->percpu_secinfo) != 0)
> (gdb) list
> 1037
> 1038    int btf_encoder__encode(struct btf_encoder *encoder)
> 1039    {
> 1040            int err;
> 1041
> 1042            if (gobuffer__size(&encoder->percpu_secinfo) != 0)
> 1043                    btf_encoder__add_datasec(encoder, PERCPU_SECTION);
> 1044
> 1045            /* Empty file, nothing to do, so... done! */
> 1046            if (btf__get_nr_types(encoder->btf) == 0)
> (gdb) print encoder
> $1 = (struct btf_encoder *) 0x0
> 
> [2] https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdwfl/libdwfl.h;h=f98f1d525d94bc7bcfc7c816890de5907ee4bd6d;hb=HEAD#l200
> 
> Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
> ---
>  dwarf_loader.c | 5 ++++-
>  dwarves.c      | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e30b03c..fecf711 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3235,7 +3235,10 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
>  	};
>  
>  	/* Process the one or more modules gleaned from this file. */
> -	dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
> +	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
> +	if (err) {
> +		return -1;
> +	}
>  
>  	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
>  	// allocated by libdw that will be freed at dwfl_end(), so leave this for
> diff --git a/dwarves.c b/dwarves.c
> index 81fa47b..c5935ec 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -2391,8 +2391,11 @@ int cus__load_files(struct cus *cus, struct conf_load *conf,
>  	int i = 0;
>  
>  	while (filenames[i] != NULL) {
> -		if (cus__load_file(cus, conf, filenames[i]))
> +		int err = cus__load_file(cus, conf, filenames[i]);
> +		if (err) {
> +			errno = err;
>  			return -++i;
> +		}
>  		++i;
>  	}
>  
> -- 
> 2.25.1

-- 

- Arnaldo
