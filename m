Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA8445B30
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhKDUsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 16:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230443AbhKDUsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 16:48:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E19376120E;
        Thu,  4 Nov 2021 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636058731;
        bh=gZOBqz+lxKTgLuq+5ILj4GUvseGdbaGixbQyb6HHeK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEpc2LaleIr2cBNslKVL7CpM8f2fJOQf41acEweJDFL+hs63TQOwRzocBTNTtMsSL
         PgVCSEEgX5QpyplamVlnvrCQd8gHKoBSq3YkjWEk933HHA/gDvcFrffNfgFDTSQSDv
         plmzl4FPUb4PdCj2Dx4rDmeNFihtmiymWIJr4c6/ERiIOID9LsRcl3KHQhB6ycJkQ7
         oNf3epAyjlrb8bJ4ISX3LiFeb4nbAyNRW/ciOeFFynCaMbATMu7qot4uiNfsgaeDd4
         qqw9Fp1GKjzlUpOyZBUI3/xDGVq9hQ61fFq06QPg2DimG7bAm6ENJfE/wGzRCSlW7P
         Iqt6HNY7fxotw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7398A410A1; Thu,  4 Nov 2021 17:45:28 -0300 (-03)
Date:   Thu, 4 Nov 2021 17:45:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Message-ID: <YYRGaKbfJCe6XElu@kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <CAEf4Bzaj4_hXDxk18aJvk2bxJ-rPb++DpPVEeUw0pN-tJuiy0Q@mail.gmail.com>
 <YYQhzbh1tL5MPgaI@kernel.org>
 <83f48296-fa72-a27f-5acb-654b51cd848f@isovalent.com>
 <YYQ/WMJ9mitKB/PO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYQ/WMJ9mitKB/PO@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 04, 2021 at 05:15:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 04, 2021 at 06:15:57PM +0000, Quentin Monnet escreveu:
> > 2021-11-04 15:09 UTC-0300 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Em Thu, Nov 04, 2021 at 10:47:12AM -0700, Andrii Nakryiko escreveu:
> > >> On Thu, Nov 4, 2021 at 10:38 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > >> cc Quentin as well, might be related to recent Makefiles revamp for
> > >> users of libbpf. But in bpf-next perf builds perfectly fine, so not
> > >> sure.

> > > This did the trick:

> > > ⬢[acme@toolbox perf]$ git show
> > > commit 504afe6757ec646539ca3b4aa0431820e8c92b45 (HEAD -> perf/core)
> > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date:   Thu Nov 4 14:58:56 2021 -0300

> > >     Revert "bpftool: Remove Makefile dep. on $(LIBBPF) for $(LIBBPF_INTERNAL_HDRS)"

> > >     This reverts commit 8b6c46241c774c83998092a4eafe40f054568881.

> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> > > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > > index c0c30e56988f2cbe..c5ad996ee95d4e87 100644
> > > --- a/tools/bpf/bpftool/Makefile
> > > +++ b/tools/bpf/bpftool/Makefile
> > > @@ -39,14 +39,14 @@ ifeq ($(BPFTOOL_VERSION),)
> > >  BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> > >  endif

> > > -$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR):
> > > +$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
> > >         $(QUIET_MKDIR)mkdir -p $@

> > >  $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
> > >         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
> > >                 DESTDIR=$(LIBBPF_DESTDIR) prefix= $(LIBBPF) install_headers

> > > -$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
> > > +$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h $(LIBBPF)
> > >         $(call QUIET_INSTALL, $@)
> > >         $(Q)install -m 644 -t $(LIBBPF_HDRS_DIR) $<

> > Interesting. I needed that patch because otherwise I'd get errors when
> > compiling bpftool after the switch to libbpf's hashmap implementation.
> > For the current breakage, it could be a matter of how we pass variables
> > when descending into bpftool/ from perf's Makefile.perf. I'll try to
> > look at this in details, and to experiment tonight, if I can. (Thanks
> > Andrii for the CC!)
 
> yeah, if we pass the location for those headers from the perf side, it
> should work.

But it isn't obvious how perf should communicate to bpftool where to
find bpf/bpf.h for the bootstrap make target, which seems something
bpftool should know.

Anyway, I'm calling it a day, will get back to this tomorrow, if you
don't beat me to it.

- Arnaldo
