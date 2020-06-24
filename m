Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2CF207867
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbgFXQHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 12:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404784AbgFXQHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 12:07:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F18206F7;
        Wed, 24 Jun 2020 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593014821;
        bh=3fExpeXt22ZWBPhUjtbFpmP9/5XgvmTsVRHSilRUUlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2FwbykynMOAHSVZZpfLhcO8Tmfjt2HCPJOJCDEEwl0udlzBTKZiVOgTTxxNAV+5/Q
         TbRN4ZAnC3H5TxLkTUz5SjMbCwT2SWJG+TQW1B7u94khO5Qhe8Gokt3y95ZTpLepgB
         +lXdwnN78PT/u2XTpwPZ5nZ5xLIywiRjTeKuupeU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A66E0405FF; Wed, 24 Jun 2020 13:06:59 -0300 (-03)
Date:   Wed, 24 Jun 2020 13:06:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
Message-ID: <20200624160659.GA20203@kernel.org>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
> Hi,
> 
> If pahole -J is used on an ELF that has BTF info from clang, it
> produces an invalid
> output. This is because pahole rewrites the .BTF section (which
> includes a new string
> table) but it doesn't touch .BTF.ext at all.
 
> To demonstrate, on a recent check out of bpf-next:
>     $ cp connect4_prog.o connect4_pahole.o
>     $ pahole -J connect4_pahole.o
>     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
>     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> .BTF.ext=btf-ext.bin connect4_prog.o
>     $ sha1sum *.bin
>     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
>     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
>     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
>     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> 
> This problem crops up when compiling old kernels like 4.19 which have
> an extra pahole
> build step with clang-10.

 
> I think a possible fix is to strip .BTF.ext if .BTF is rewritten.

Agreed.

Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
if clang is generating it already, why use pahole -J?

Does clang do deduplication for multi-object binaries?

Also its nice to see that the BTF generated ends up with the same
sha1sum, cool :-)
 
> Best
> Lorenz
> 
> -- 
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> 
> www.cloudflare.com

-- 

- Arnaldo
