Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3832B50F0
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgKPTWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 14:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPTWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 14:22:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADFC2225B;
        Mon, 16 Nov 2020 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605554543;
        bh=baJPuSDZTb+9cztMy4Iiha+BaCJE7GJT6MobXYZyz1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUAglBs3m/q/gKlOtMKFBw7Fh9p7iYlRwNBJqWnRPrLqpufzAWVB2RSvHzU3UbjSg
         Z0kJVJ0gfaeh4WEcPMR7TWAjj+Zf1LGyRf/89McOAxEk1HUEpNnC0AJLFsYLNI201W
         UK6Ty79Ja0MDk4PSCEGrTj0oqKG6ZRy8eUWe/f6E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66C9340E29; Mon, 16 Nov 2020 16:22:21 -0300 (-03)
Date:   Mon, 16 Nov 2020 16:22:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201116192221.GB614220@kernel.org>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
 <CAEf4Bzb4yu4K+fk33n0Tas78XsKMFw+tofF2o5sOwumBC82u9Q@mail.gmail.com>
 <20201113212907.GD842058@krava>
 <CAEf4BzZY9SF2rVNXpUUN=rYJ_jvBy1eq+fcQi+iRdv8dV2OVFQ@mail.gmail.com>
 <20201116135016.GA509215@kernel.org>
 <20201116182145.GF1081385@krava>
 <20201116191544.GA614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116191544.GA614220@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 16, 2020 at 04:15:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 16, 2020 at 07:21:45PM +0100, Jiri Olsa escreveu:
> > On Mon, Nov 16, 2020 at 10:50:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Nov 13, 2020 at 01:43:47PM -0800, Andrii Nakryiko escreveu:
> > > > On Fri, Nov 13, 2020 at 1:29 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > 
> > > > > On Fri, Nov 13, 2020 at 12:56:40PM -0800, Andrii Nakryiko wrote:
> > > > > > On Fri, Nov 13, 2020 at 7:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > 
> > > > > > > Current conditions for picking up function records break
> > > > > > > BTF data on some gcc versions.
> > > 
> > > > > > > Some function records can appear with no arguments but with
> > > > > > > declaration tag set, so moving the 'fn->declaration' in front
> > > > > > > of other checks.
> > > 
> > > > > > > Then checking if argument names are present and finally checking
> > > > > > > ftrace filter if it's present. If ftrace filter is not available,
> > > > > > > using the external tag to filter out non external functions.
> > > 
> > > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > 
> > > > > > I tested locally, all seems to work fine. Left few suggestions below,
> > > > > > but those could be done in follow ups (or argued to not be done).
> > > 
> > > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > 
> > > > > > BTW, for some stats.
> > > 
> > > > > > BEFORE allowing static funcs:
> > > 
> > > 
> > > Nowhere in the last patchkit comments is some explanation for the
> > > inclusion of static functions :-\ After the first patch in the last
> > > series I get:
> > > 
> > >   $ llvm-objcopy --remove-section=.BTF vmlinux
> > >   $ readelf -SW vmlinux  | grep BTF
> > >   $ pahole -J vmlinux
> > >   $ bpftool btf dump file ./vmlinux | grep 'FUNC '| cut -d\' -f2 | sort > before.bpftool
> > >   $ cp vmlinux vmlinux.before.all
> > >   $ wc -l before.bpftool
> > >   28829 before.bpftool
> > 
> > I think you see the original number of functions, because without
> > the 'not merged' kernel patch, that added the special init section,
> > pahole will fail to detect vmlinux and fall back to checking dwarf
> > declarations
> 
> Indeed, I moved the verbose/force setting to the beggining of the
> encoder and:
> 
> ------------
> Found 352 per-CPU variables!
> vmlinux not detected, falling back to dwarf data
> File vmlinux:
> search cu '/home/acme/git/linux/arch/x86/kernel/head_64.S' for percpu global variables.
> -----------------
> 
> Now I have to read that code to figure out what that "vmlinux not
> detected, falling back to dwarf data" message means, as vmlinux is where
> DWARF data is, so what is that isn't being "detected", /me checks...

So with some debugging I see, the message is just confusing:

"vmlinux not detected, falling back to dwarf data (functions_cnt=53238, has_all_symbols(&fl)=0"

It finds the ELF symtab, finds the percpu variables there, tons of
functions, matching the number after this approach of marking BPF init
functions was dropped its just that vague "has_all_symbols()" routine
that fails to find all the symbols it needs in the vmlinux file.

- Arnaldo
