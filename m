Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C8445AFB
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhKDUSD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 16:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhKDUSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 16:18:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D32961052;
        Thu,  4 Nov 2021 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636056924;
        bh=wiVEKn23di1kkSpaW3haI7A/uMZ00njmxSpsuZQihbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsevBF+R2zDnjak5CHQWOTTiFH+Qcx1W0uVofMLmQ0jfQB0ZSuI1x2gNa5jFo7caO
         ay400twZL9l+RHAQhjcHU6CJmeZk6Jn1GvzoHiSK1Odqc+576zmUq2uF0RVJQS0gVI
         dxjVXf5Q6/aIFkcp4lGCqGtf6xAkZMjZL1wahC29CguvY2AOZYil2LCVC9rl0C/UMd
         onCqX9tIkqrxfBuunvs7sAYU2rEkNQ/GcmbHyEz9MSQhvb5qveTrdsvR0tV+uHBmIN
         8ifwbFY9EMXX+NxyG3Ln7VsyHEQmpdoBROKPVrlDhAFZnDrHZ8j3SpYCnjmbtGajQn
         22pLcrVQNMiRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EEB2F410A1; Thu,  4 Nov 2021 17:15:20 -0300 (-03)
Date:   Thu, 4 Nov 2021 17:15:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Message-ID: <YYQ/WMJ9mitKB/PO@kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <CAEf4Bzaj4_hXDxk18aJvk2bxJ-rPb++DpPVEeUw0pN-tJuiy0Q@mail.gmail.com>
 <YYQhzbh1tL5MPgaI@kernel.org>
 <83f48296-fa72-a27f-5acb-654b51cd848f@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83f48296-fa72-a27f-5acb-654b51cd848f@isovalent.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 04, 2021 at 06:15:57PM +0000, Quentin Monnet escreveu:
> 2021-11-04 15:09 UTC-0300 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
> > Em Thu, Nov 04, 2021 at 10:47:12AM -0700, Andrii Nakryiko escreveu:
> >> On Thu, Nov 4, 2021 at 10:38 AM Arnaldo Carvalho de Melo
> >> <arnaldo.melo@gmail.com> wrote:
> >>>
> >>>
> >>> Hi Song,
> >>>
> >>
> >> cc Quentin as well, might be related to recent Makefiles revamp for
> >> users of libbpf. But in bpf-next perf builds perfectly fine, so not
> >> sure.
> > 
> > This did the trick:
> > 
> > ⬢[acme@toolbox perf]$ git show
> > commit 504afe6757ec646539ca3b4aa0431820e8c92b45 (HEAD -> perf/core)
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu Nov 4 14:58:56 2021 -0300
> > 
> >     Revert "bpftool: Remove Makefile dep. on $(LIBBPF) for $(LIBBPF_INTERNAL_HDRS)"
> > 
> >     This reverts commit 8b6c46241c774c83998092a4eafe40f054568881.
> > 
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index c0c30e56988f2cbe..c5ad996ee95d4e87 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -39,14 +39,14 @@ ifeq ($(BPFTOOL_VERSION),)
> >  BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> >  endif
> > 
> > -$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR):
> > +$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
> >         $(QUIET_MKDIR)mkdir -p $@
> > 
> >  $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
> >         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
> >                 DESTDIR=$(LIBBPF_DESTDIR) prefix= $(LIBBPF) install_headers
> > 
> > -$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
> > +$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h $(LIBBPF)
> >         $(call QUIET_INSTALL, $@)
> >         $(Q)install -m 644 -t $(LIBBPF_HDRS_DIR) $<
> 
> 
> Interesting. I needed that patch because otherwise I'd get errors when
> compiling bpftool after the switch to libbpf's hashmap implementation.
> For the current breakage, it could be a matter of how we pass variables
> when descending into bpftool/ from perf's Makefile.perf. I'll try to
> look at this in details, and to experiment tonight, if I can. (Thanks
> Andrii for the CC!)

yeah, if we pass the location for those headers from the perf side, it
should work.

Extra info: if libbpf-devel is installed, it "builds", well, built
before the merge, as the one available for fedora 34 is:

libbpf-devel-2:0.4.0-1.fc34.x86_64

after installing it, on the merged tree, with the above revert, I get:

  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
btf.c: In function ‘dump_btf_type’:
btf.c:328:47: warning: implicit declaration of function ‘btf__type_cnt’ [-Wimplicit-function-declaration]
  328 |                                 if (v->type < btf__type_cnt(btf)) {
      |                                               ^~~~~~~~~~~~~
btf.c:328:45: warning: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Wsign-compare]
  328 |                                 if (v->type < btf__type_cnt(btf)) {
      |                                             ^
btf.c: In function ‘do_dump’:
btf.c:591:23: warning: implicit declaration of function ‘btf__load_from_kernel_by_id_split’ [-Wimplicit-function-declaration]
  591 |                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
btf.c:591:21: warning: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  591 |                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
      |                     ^
btf_dumper.c: In function ‘dump_prog_id_as_func_ptr’:
btf_dumper.c:69:20: warning: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Wimplicit-function-declaration]
   69 |         prog_btf = btf__load_from_kernel_by_id(info->btf_id);
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
btf_dumper.c:69:18: warning: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
   69 |         prog_btf = btf__load_from_kernel_by_id(info->btf_id);
      |                  ^
  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool


If I revert the above revert I get a more catastrophic breakage:

  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
btf.c: In function ‘dump_btf_type’:
btf.c:328:47: warning: implicit declaration of function ‘btf__type_cnt’ [-Wimplicit-function-declaration]
  328 |                                 if (v->type < btf__type_cnt(btf)) {
      |                                               ^~~~~~~~~~~~~
btf.c:328:45: warning: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Wsign-compare]
  328 |                                 if (v->type < btf__type_cnt(btf)) {
      |                                             ^
btf.c: In function ‘do_dump’:
btf.c:591:23: warning: implicit declaration of function ‘btf__load_from_kernel_by_id_split’ [-Wimplicit-function-declaration]
  591 |                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
btf.c:591:21: warning: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  591 |                 btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
      |                     ^
btf_dumper.c: In function ‘dump_prog_id_as_func_ptr’:
btf_dumper.c:69:20: warning: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Wimplicit-function-declaration]
   69 |         prog_btf = btf__load_from_kernel_by_id(info->btf_id);
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
btf_dumper.c:69:18: warning: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
   69 |         prog_btf = btf__load_from_kernel_by_id(info->btf_id);
      |                  ^
gen.c: In function ‘codegen_datasecs’:
gen.c:214:17: warning: implicit declaration of function ‘btf__type_cnt’ [-Wimplicit-function-declaration]
  214 |         int n = btf__type_cnt(btf);
      |                 ^~~~~~~~~~~~~
In file included from /usr/include/bpf/bpf.h:31,
                 from gen.c:15:
gen.c: In function ‘gen_trace’:
gen.c:489:29: error: variable ‘opts’ has initializer but incomplete type
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |                             ^~~~~~~~~~~~~~~
gen.c:489:9: error: invalid application of ‘sizeof’ to incomplete type ‘struct gen_loader_opts’
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |         ^~~~~~~~~~~~~~~~~~~
gen.c:489:9: error: ‘struct gen_loader_opts’ has no member named ‘sz’
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |         ^~~~~~~~~~~~~~~~~~~
gen.c:489:9: error: invalid application of ‘sizeof’ to incomplete type ‘struct gen_loader_opts’
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |         ^~~~~~~~~~~~~~~~~~~
gen.c:489:9: warning: excess elements in struct initializer
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |         ^~~~~~~~~~~~~~~~~~~
gen.c:489:9: note: (near initialization for ‘(anonymous)’)
In file included from /usr/include/bpf/bpf.h:31,
                 from gen.c:15:
gen.c:489:9: error: invalid use of undefined type ‘struct gen_loader_opts’
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |         ^~~~~~~~~~~~~~~~~~~
gen.c:489:46: error: storage size of ‘opts’ isn’t known
  489 |         DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
      |                                              ^~~~
gen.c:494:15: warning: implicit declaration of function ‘bpf_object__gen_loader’; did you mean ‘bpf_object__unload’? [-Wimplicit-function-declaration]
  494 |         err = bpf_object__gen_loader(obj, &opts);
      |               ^~~~~~~~~~~~~~~~~~~~~~
      |               bpf_object__unload
gen.c:556:29: warning: implicit declaration of function ‘bpf_map__initial_value’; did you mean ‘bpf_map__set_initial_value’? [-Wimplicit-function-declaration]
  556 |                 mmap_data = bpf_map__initial_value(map, &mmap_size);
      |                             ^~~~~~~~~~~~~~~~~~~~~~
      |                             bpf_map__set_initial_value
gen.c:556:27: warning: assignment to ‘const void *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  556 |                 mmap_data = bpf_map__initial_value(map, &mmap_size);
      |                           ^
make[3]: *** [Makefile:213: /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o] Error 1
make[2]: *** [Makefile.perf:1048: /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

          7,103.73 msec task-clock:u              #    1.476 CPUs utilized
          7,074.44 msec cpu-clock:u               #    1.469 CPUs utilized

       4.814384825 seconds time elapsed

       3.917534000 seconds user
       3.433976000 seconds sys


70: Event expansion for cgroups                                     : Ok
88: perf all metricgroups test                                      : FAILED!
⬢[acme@toolbox perf]$


Kinda expected, as its an old libbpf version, the one in fedora 34. I'll
remove it, and try to fix it on the perf side, i.e. telling where to
find bpf/bpf.h, bpf/libbpf.h.

- Arnaldo


