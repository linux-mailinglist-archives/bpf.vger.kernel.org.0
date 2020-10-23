Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89CC29749F
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbgJWQiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 12:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbgJWQh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 12:37:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6016F206B5;
        Fri, 23 Oct 2020 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603471078;
        bh=CSo/ypbF7U07I2ifEOxskfmETi2a17E5q+9iqLR2hf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eo+ZR/lvvMNCzFdx3qkitk3pWLoXuLf2+dN2HZRQW0T61clYUR3l87GCj3qDiWZDb
         94C1aH6xGuS2bUpyrpWNe0Wg0CdamtqoKVd2sE9VBC3HugOnJ/2+/2O8AeWUUGG+cy
         ZA75gdR+bxKT/ZsZnqTmHb7ZdoDZzelulgnTHk4I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38D43403C2; Fri, 23 Oct 2020 13:37:55 -0300 (-03)
Date:   Fri, 23 Oct 2020 13:37:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: ignore zero-sized ELF symbols
Message-ID: <20201023163755.GA2406834@kernel.org>
References: <20201021155220.1737964-1-andrii@kernel.org>
 <9633d29b-887c-46ec-b131-adda8f69d722@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9633d29b-887c-46ec-b131-adda8f69d722@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 22, 2020 at 07:19:32AM +0200, Jiri Slaby escreveu:
> On 21. 10. 20, 17:52, Andrii Nakryiko wrote:
> > It's legal for ELF symbol to have size 0, if it's size is unknown or
> > unspecified. Instead of erroring out, just ignore such symbols, as they can't
> > be a valid per-CPU variable anyways.
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

thanks applied
 
> > ---
> >   btf_encoder.c | 12 ++++--------
> >   1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2a6455be4c52..2af1fe447834 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -287,6 +287,10 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
> >   		if (!addr)
> >   			continue;
> > +		size = elf_sym__size(&sym);
> > +		if (!size)
> > +			continue; /* ignore zero-sized symbols */
> > +
> >   		sym_name = elf_sym__name(&sym, btfe->symtab);
> >   		if (!btf_name_valid(sym_name)) {
> >   			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> > @@ -295,14 +299,6 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
> >   				continue;
> >   			return -1;
> >   		}
> > -		size = elf_sym__size(&sym);
> > -		if (!size) {
> > -			dump_invalid_symbol("Found symbol of zero size when encoding btf",
> > -					    sym_name, btf_elf__verbose, btf_elf__force);
> > -			if (btf_elf__force)
> > -				continue;
> > -			return -1;
> > -		}
> >   		if (btf_elf__verbose)
> >   			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> > 
> 
> 
> -- 
> js
> suse labs

-- 

- Arnaldo
