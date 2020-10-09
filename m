Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8B288EB3
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbgJIQWs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 12:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbgJIQWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 12:22:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914E0221FD;
        Fri,  9 Oct 2020 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602260567;
        bh=TIczJXmPf50q0olLNbq9jiDpSR769OLXqycKrQlK63c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1nRtKHlKWlam8uvGHw7hntNqWbOgs9sVipPkZpMuFVeJZur1bNv+yc9Ob5D75BY29
         NKAuut6vRVUDJQAmDCLbcqvm26kojN2eh8ARjvLLv1mk3k2iu354L5QOGswsTQO8Q8
         a8T4+4dIsFY4dJUpu8I/OKhBWxmqHFVuRCKXrGLA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBB3D403AC; Fri,  9 Oct 2020 13:22:43 -0300 (-03)
Date:   Fri, 9 Oct 2020 13:22:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
        Oleg Rombakh <olegrom@google.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Subject: Re: [PATCH v2 dwarves 0/8] Switch BTF loading and encoding to libbpf
 APIs
Message-ID: <20201009162243.GD322246@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 08, 2020 at 04:39:52PM -0700, Andrii Nakryiko escreveu:
> This patch set switches pahole to use libbpf-provided BTF loading and encoding
> APIs. This reduces pahole's own BTF encoding code, speeds up the process,
> reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole finally
> gets support to generating BTF for cross-compiled ELF binaries with different
> endianness (patch #8).
> 
> Additionally, patch #3 fixes previously missed problem with invalid array
> index type generation.
> 
> Patches #4-7 are speeding up DWARF-to-BTF convertion/dedup pretty
> significantly, saving overall about 9 seconds out of current 27 or so.
> 
> Patch #5 revamps how per-CPU BTF variables are emitted, eliminating repeated
> and expensive looping over ELF symbols table. The critical detail that took
> few hours of investigation is that when DW_AT_variable has
> DW_AT_specification, variable address (to correlate with symbol's address) has
> to be taken before specification is followed.
> 
> More details could be found in respective patches.
> 
> v1->v2:
>   - rebase on latest dwarves master and fix var->spec's address problem.

Thanks, I applied all of them, tested and reproduced the performance
gains, great work!

I'll do some more testing on encoding a vmlinux for some big endian arch
on my x86_64 workstation and then push things publicly.

If Hao find any issues we can fix in a follow up patch.

I also added the people involved in the discussion about cross builds
failing, please take a look, I'm pushing now to a tmp.libbtf_encoder so
that you can test it from there, ok?

- Arnaldo
 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Andrii Nakryiko (8):
>   btf_loader: use libbpf to load BTF
>   btf_encoder: use libbpf APIs to encode BTF type info
>   btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
>   btf_encoder: discard CUs after BTF encoding
>   btf_encoder: revamp how per-CPU variables are encoded
>   dwarf_loader: increase the size of lookup hash map
>   strings: use BTF's string APIs for strings management
>   btf_encoder: support cross-compiled ELF binaries with different
>     endianness
> 
>  btf_encoder.c  | 370 +++++++++++++++------------
>  btf_loader.c   | 244 +++++++-----------
>  ctf_encoder.c  |   2 +-
>  dwarf_loader.c |   2 +-
>  libbtf.c       | 661 +++++++++++++++++++++----------------------------
>  libbtf.h       |  41 ++-
>  libctf.c       |  14 +-
>  libctf.h       |   4 +-
>  pahole.c       |   2 +-
>  strings.c      |  91 +++----
>  strings.h      |  32 +--
>  11 files changed, 645 insertions(+), 818 deletions(-)
> 
> -- 
> 2.24.1
> 

-- 

- Arnaldo
