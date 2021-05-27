Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB12E393195
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhE0PAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 11:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhE0PAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 11:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57EC46128D;
        Thu, 27 May 2021 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622127507;
        bh=WKWmt3FGSvjzfL/CX2du+GW3pa/sDXJn59U2jNVd9IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlXzuCmH56nds8Lgvodx+rNvBqDtKkQy7UDqVjwlZg0PmyE8ENcsjNK+p567xh0aV
         LuKvcT7BZpU4CpmgnGv6n0bzOI4rRPkL0xmzwU4K1eC2vSQGtI5Y/RkSHAlcxHIW9k
         6uVXGZuJ4INkdyo1r/b7bL44de6TjQeB9gSlLgaqrtz2sC1LGbP8FA3GjPcNvvomI5
         5PjYr1etvgPNr6CuCfzWSLPL3NT25optElhBxd6Mq763Z8t+lsvOWmvGH/VMk7aNYH
         oxTAa8Nepi+z2QPIzK+JaPGMbG/arIzDlDiMdM4Bt+kRIkcE8HGBx0gmK/3uRbnNU+
         lmeQRSJg4ZEGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54AD64011C; Thu, 27 May 2021 11:58:24 -0300 (-03)
Date:   Thu, 27 May 2021 11:58:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, jolsa@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
Message-ID: <YK+zkOOAUzFYsLBy@kernel.org>
References: <20210524234222.278676-1-andrii@kernel.org>
 <YK+yzpPKVhNvm7/n@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YK+yzpPKVhNvm7/n@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, May 27, 2021 at 11:55:10AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> > btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> > done for DWARF variables when matching them with ELF symbols. This is due to
> > zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> > happens to be allocated at the exact same address, leading to a lot of
> > confusion in BTF.
>  
> > See [0] for when this causes big problems.
>  
> >   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/

I also added this:

Reported-by: Michal Suchánek <msuchanek@suse.de>

Michal, so you tested this patch and verified it fixed the problem? If
so please let me know so that I also add:

Tested-by: Michal Suchánek <msuchanek@suse.de>

Thanks,

- Arnaldo
 
> > +++ b/btf_encoder.c
> > @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >  
> >  		/* addr has to be recorded before we follow spec */
> >  		addr = var->ip.addr;
> > +		dwarf_name = variable__name(var, cu);
> >  
> >  		/* DWARF takes into account .data..percpu section offset
> >  		 * within its segment, which for vmlinux is 0, but for kernel
> > @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >  		 *  modules per-CPU data section has non-zero offset so all
> >  		 *  per-CPU symbols have non-zero values.
> >  		 */
> > -		if (var->ip.addr == 0) {
> > -			dwarf_name = variable__name(var, cu);
> > +		if (var->ip.addr == 0)
> >  			if (!dwarf_name || strcmp(dwarf_name, name))
> >  				continue;
> > -		}
> >  
> >  		if (var->spec)
> >  			var = var->spec;
> > @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> 
> I just changed the above hunk to be:
> 
> @@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                  *  per-CPU symbols have non-zero values.
>                  */
>                 if (var->ip.addr == 0) {
> -                       dwarf_name = variable__name(var, cu);
>                         if (!dwarf_name || strcmp(dwarf_name, name))
>                                 continue;
>                 }
> 
> 
> Which is shorter and keeps the {} around a multi line if block, ok?
> 
> Thanks, applied!
> 
> - Arnaldo

-- 

- Arnaldo
