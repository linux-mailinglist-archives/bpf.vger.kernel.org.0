Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE321DE8DE
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgEVO2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 10:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbgEVO2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 10:28:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74CB22D2A;
        Fri, 22 May 2020 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590157695;
        bh=gWd6Dp0QUtBPCxzBiT2I2dBLdCo6gJM2lGpMQsZdKjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0DCZjtMWMlYPlUiP2Ek50J3c6JPU05W7BmhJ5G39W7tpAz0hFjEvjQifj5/w3IzR
         JRyBoQZFgnYxOToUisJEQw9l9co6ndQYuQO4qSI94g6AhD5NVhOjCiy7Er+eQhFH0S
         FX2GPGvWLB2TBfeo0uMfFdiNvc5yAJuAXTepzrWM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5FD2440AFD; Fri, 22 May 2020 11:28:13 -0300 (-03)
Date:   Fri, 22 May 2020 11:28:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        haoluo@google.com, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, olegrom@google.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: accessing global and per-cpu vars
Message-ID: <20200522142813.GF14034@kernel.org>
References: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
 <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, May 21, 2020 at 11:58:47AM -0700, Andrii Nakryiko escreveu:
> On Thu, May 21, 2020 at 10:07 AM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 2. teach pahole to store ' A ' annotated kallsyms into vmlinux BTF as
> > BTF_KIND_VAR.
> > There are ~300 of them, so should be minimal increase in size.
> 
> I thought we'd do that based on section name? Or we will actually
> teach pahole to extract kallsyms from vmlinux image?

No need to touch kallsyms:

  net/core/filter.c
  
  DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
  
  # grep -w bpf_redirect_info /proc/kallsyms
  000000000002a160 A bpf_redirect_info
  #
  # readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep bpf_redirect_info
  113637: 000000000002a2e0    32 OBJECT  GLOBAL DEFAULT   34 bpf_redirect_info
  #

Its in the ELF symtab.

[root@quaco ~]# grep ' A ' /proc/kallsyms | wc -l
351
[root@quaco ~]# readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep "OBJECT  GLOBAL" | wc -l
3221
[root@quaco ~]#

So ' A ' in kallsyms needs some extra info from the symtab in addition
to being OBJECT GLOBAL, checking...
 
> There was step 1.5 (or even 0.5) to see if it's feasible to add not
> just per-CPU variables as well.

- Arnaldo
