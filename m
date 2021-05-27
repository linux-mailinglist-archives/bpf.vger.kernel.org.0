Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB80939318D
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhE0O4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 10:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhE0O4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 10:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F5F6611AE;
        Thu, 27 May 2021 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622127313;
        bh=h1ngFTq9Zb/SdBnGTwA4Kdpzfw4n5hmVIPGwvKay894=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eo0+vHf+CWES7JSqq5j9FsitfdsmnmmoaHObOBp9VHAR5qYMu1Bs4PX2KhUeWPCpZ
         AwhSbBrRvZCLXaZGyv55Kfql/HH4I2S3vcquYHYimZjIJxmJixg3LgTaiRWtkDLl5U
         hV/tyF5tQWNhZc9SsBih0unJL3Puxv0xqLIQ7EIO9mhfRiZfj5ABPENFg9X/fb4unw
         vcuk7rJRhLbDs/bXbMp3dpxTWG0OE4HSOMOX9Q+UnkkeQlp7dyf1CzRkFQg3qB6x55
         qiCcbMuavjpY/TCDNMvewyMzsejJ2ocizy9ROCTZy6CPrbHUlLKU/cWbyFDMRj76zl
         ucS7Un5P6ZjhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36F144011C; Thu, 27 May 2021 11:55:10 -0300 (-03)
Date:   Thu, 27 May 2021 11:55:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
Message-ID: <YK+yzpPKVhNvm7/n@kernel.org>
References: <20210524234222.278676-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524234222.278676-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> done for DWARF variables when matching them with ELF symbols. This is due to
> zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> happens to be allocated at the exact same address, leading to a lot of
> confusion in BTF.
 
> See [0] for when this causes big problems.
 
>   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/

> +++ b/btf_encoder.c
> @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  
>  		/* addr has to be recorded before we follow spec */
>  		addr = var->ip.addr;
> +		dwarf_name = variable__name(var, cu);
>  
>  		/* DWARF takes into account .data..percpu section offset
>  		 * within its segment, which for vmlinux is 0, but for kernel
> @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		 *  modules per-CPU data section has non-zero offset so all
>  		 *  per-CPU symbols have non-zero values.
>  		 */
> -		if (var->ip.addr == 0) {
> -			dwarf_name = variable__name(var, cu);
> +		if (var->ip.addr == 0)
>  			if (!dwarf_name || strcmp(dwarf_name, name))
>  				continue;
> -		}
>  
>  		if (var->spec)
>  			var = var->spec;
> @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,

I just changed the above hunk to be:

@@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
                 *  per-CPU symbols have non-zero values.
                 */
                if (var->ip.addr == 0) {
-                       dwarf_name = variable__name(var, cu);
                        if (!dwarf_name || strcmp(dwarf_name, name))
                                continue;
                }


Which is shorter and keeps the {} around a multi line if block, ok?

Thanks, applied!

- Arnaldo
