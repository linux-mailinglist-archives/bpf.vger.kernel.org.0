Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA42B4503
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgKPNuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 08:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKPNuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 08:50:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FBC2074B;
        Mon, 16 Nov 2020 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605534620;
        bh=xqc3U2cfEzJGCzcwaSqy1tHPIXb+PAjN9RnnbDjQ4rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfClnCsET3v8QvOvWvoFSnQjLUAEwEDwH8Zddh17YQOYNWrlBcNLUXBKf8J485SLS
         Eb+sFA5chNPhBQRQy2+506are7lneopQ7YcFPNxZIotVIHS6xnuGIFxuXwsT3vVv+T
         aq/ivXOcje213zWrA4ke31GJwBYPbGnC3PWgI314=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89A8D411D1; Mon, 16 Nov 2020 10:50:16 -0300 (-03)
Date:   Mon, 16 Nov 2020 10:50:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201116135016.GA509215@kernel.org>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
 <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
 <20201113212907.GD842058@krava>
 <CAEf4BzZY9SF2rVNXpUUN=rYJ_jvBy1eq+fcQi+iRdv8dV2OVFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZY9SF2rVNXpUUN=rYJ_jvBy1eq+fcQi+iRdv8dV2OVFQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 13, 2020 at 01:43:47PM -0800, Andrii Nakryiko escreveu:
> On Fri, Nov 13, 2020 at 1:29 PM Jiri Olsa <jolsa@redhat.com> wrote:

> > On Fri, Nov 13, 2020 at 12:56:40PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:

> > > > Current conditions for picking up function records break
> > > > BTF data on some gcc versions.

> > > > Some function records can appear with no arguments but with
> > > > declaration tag set, so moving the 'fn->declaration' in front
> > > > of other checks.

> > > > Then checking if argument names are present and finally checking
> > > > ftrace filter if it's present. If ftrace filter is not available,
> > > > using the external tag to filter out non external functions.

> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>

> > > I tested locally, all seems to work fine. Left few suggestions below,
> > > but those could be done in follow ups (or argued to not be done).

> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>

> > > BTW, for some stats.

> > > BEFORE allowing static funcs:


Nowhere in the last patchkit comments is some explanation for the
inclusion of static functions :-\ After the first patch in the last
series I get:

  $ llvm-objcopy --remove-section=.BTF vmlinux
  $ readelf -SW vmlinux  | grep BTF
  $ pahole -J vmlinux
  $ bpftool btf dump file ./vmlinux | grep 'FUNC '| cut -d\' -f2 | sort > before.bpftool
  $ cp vmlinux vmlinux.before.all
  $ wc -l before.bpftool
  28829 before.bpftool
  $
  $ llvm-objcopy --remove-section=.BTF vmlinux
  $ readelf -SW vmlinux  | grep BTF
  $ bpftool btf dump file ./vmlinux | grep 'FUNC '| cut -d\' -f2 | sort > after-1st-patch.bpftool
  Error: failed to load BTF from ./vmlinux: No such file or directory
  $ pahole -J vmlinux
  $
  $ bpftool btf dump file ./vmlinux | grep 'FUNC '| cut -d\' -f2 | sort > after-1st-patch.bpftool
  $ wc -l after-1st-patch.bpftool
  41030 after-1st-patch.bpftool
  $ diff -u before.bpftool after-1st-patch.bpftool | less
  $ diff -u before.bpftool after-1st-patch.bpftool | less
  $

BTF: I built this kernel without CONFIG_DEBUG_INFO_BTF=y, so that I could use: llvm-objcopy --remove-section=.BTF

That matches what you see here, i.e.

BEFORE:

> > > Func:         308304 bytes (25692 types)

AFTER:

> > > Func:         536664 bytes (44722 types)

The number of functions, that is. I'm scratching my head to figure out
why:

https://lore.kernel.org/bpf/20201114223853.1010900-2-jolsa@kernel.org/

[PATCH 1/2] btf_encoder: Generate also .init functions

Causes this, can you guys please explain it so that we have this in the
change log?

As the diff shows that the increase in the number of functions is due to
static functions being added:

[acme@five pahole]$ diff -u before.bpftool after-1st-patch.bpftool | tail
+__zswap_pool_release
+zswap_writeback_entry
+zswap_zpool_param_set
+zs_zpool_create
+zs_zpool_destroy
+zs_zpool_free
+zs_zpool_malloc
+zs_zpool_map
+zs_zpool_total_size
+zs_zpool_unmap
[acme@five pahole]$

static void zs_zpool_unmap(void *pool, unsigned long handle)
{
        zs_unmap_object(pool, handle);
}

Reading below Jiri says:

> > > >                                 continue;
> > > >                 } else {
> > > > -                       if (fn->declaration || !fn->external)
> > > > +                       if (!fn->external)
> > >
> > > Hm.. why didn't you drop this fallback? For non-vmlinux, do you think
> > > it's a problem to generate all FUNCs? Mostly theoretical question,
> > > though.
> >
> > because it would probably allowed all static functions,
> > (ftrace data has only static functions that are traceable)
> > and who knows what a can of worms we'd open here ;-)
> >
> 
> Fair enough.

But I'm getting these results (the addition of static variables) after
applying:

btf_encoder: Generate also .init functions

:-\

- Arnaldo

> > > .BTF ELF section
> > > =======================================
> > > Data size:      4101624
> > > Header size:    24
> > > Types size:     2472836
> > > Strings size:   1628764
> > >
> > > BTF types
> > > =======================================
> > > Total        2472836 bytes (83310 types)
> > > Struct:       920436 bytes (10305 types)
> > > FuncProto:    638668 bytes (18869 types)
> > > Func:         308304 bytes (25692 types)
> > > Enum:         184308 bytes (2293 types)
> > > Ptr:          173484 bytes (14457 types)
> > > Array:         89064 bytes (3711 types)
> > > Union:         81552 bytes (1961 types)
> > > Const:         34368 bytes (2864 types)
> > > Typedef:       32124 bytes (2677 types)
> > > Var:            4688 bytes (293 types)
> > > Datasec:        3528 bytes (1 types)
> > > Fwd:            1656 bytes (138 types)
> > > Volatile:        360 bytes (30 types)
> > > Int:             272 bytes (17 types)
> > > Restrict:         24 bytes (2 types)
> > >
> > >
> > > AFTER allowing static funcs:
> > >
> > > .BTF ELF section
> > > =======================================
> > > Data size:      4930558
> > > Header size:    24
> > > Types size:     2914016
> > > Strings size:   2016518
> > >
> > > BTF types
> > > =======================================
> > > Total        2914016 bytes (108282 types)
> > > Struct:       920436 bytes (10305 types)
> > > FuncProto:    851528 bytes (24814 types)
> > > Func:         536664 bytes (44722 types)
> > > Enum:         184308 bytes (2293 types)
> > > Ptr:          173484 bytes (14457 types)
> > > Array:         89064 bytes (3711 types)
> > > Union:         81552 bytes (1961 types)
> > > Const:         34368 bytes (2864 types)
> > > Typedef:       32124 bytes (2677 types)
> > > Var:            4688 bytes (293 types)
> > > Datasec:        3528 bytes (1 types)
> > > Fwd:            1656 bytes (138 types)
> > > Volatile:        360 bytes (30 types)
> > > Int:             256 bytes (16 types)
> >
> > nice, is this tool somewhere in the tree?
> 
> Nope, this is from my personal BTF inspection tool, which I never got
> to open-sourcing, too low on the priority list...
> 
> >
> > >
> > > So 25692 vs 44722 functions, but the increase in func_proto is smaller
> > > due to dedup. Good chunk is strings data for all those function and
> > > parameter names.
> > >
> > >
> > > >  btf_encoder.c | 24 ++++++++++--------------
> > > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > index d531651b1e9e..de471bc754b1 100644
> > > > --- a/btf_encoder.c
> > > > +++ b/btf_encoder.c
> > > > @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > >                 const char *name;
> > > >
> > > >                 /*
> > > > -                * The functions_cnt != 0 means we parsed all necessary
> > > > -                * kernel symbols and we are using ftrace location filter
> > > > -                * for functions. If it's not available keep the current
> > > > -                * dwarf declaration check.
> > > > +                * Skip functions that:
> > > > +                *   - are marked as declarations
> > > > +                *   - do not have full argument names
> > > > +                *   - are not in ftrace list (if it's available)
> > > > +                *   - are not external (in case ftrace filter is not available)
> > > >                  */
> > > > +               if (fn->declaration)
> > > > +                       continue;
> > > > +               if (!has_arg_names(cu, &fn->proto))
> > > > +                       continue;
> > > >                 if (functions_cnt) {
> > > > -                       /*
> > > > -                        * We check following conditions:
> > > > -                        *   - argument names are defined
> > > > -                        *   - there's symbol and address defined for the function
> > > > -                        *   - function address belongs to ftrace locations
> > > > -                        *   - function is generated only once
> > > > -                        */
> > > > -                       if (!has_arg_names(cu, &fn->proto))
> > > > -                               continue;
> > > >                         if (!should_generate_function(btfe, function__name(fn, cu)))
> > >
> > > Seeing Arnaldo's confusion, I remember initially I was similarly
> > > confused. I think this p->generated = true should be moved out of
> > > should_generate_function() and done here explicitly. Let's turn
> > > should_generate_function() into find_allowed_function() or something,
> > > to encapsulate bsearch. Checking !p || p->generated could be done here
> > > explicitly.
> >
> > ok, that should be more obvious, I'll send new version
> >
> > >
> > > >                                 continue;
> > > >                 } else {
> > > > -                       if (fn->declaration || !fn->external)
> > > > +                       if (!fn->external)
> > >
> > > Hm.. why didn't you drop this fallback? For non-vmlinux, do you think
> > > it's a problem to generate all FUNCs? Mostly theoretical question,
> > > though.
> >
> > because it would probably allowed all static functions,
> > (ftrace data has only static functions that are traceable)
> > and who knows what a can of worms we'd open here ;-)
> >
> 
> Fair enough.
> 
> > jirka
> >

-- 

- Arnaldo
