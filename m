Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864BD486AA6
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiAFTso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 14:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiAFTsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 14:48:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0097C061245;
        Thu,  6 Jan 2022 11:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FA8861DD7;
        Thu,  6 Jan 2022 19:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A684EC36AE3;
        Thu,  6 Jan 2022 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641498522;
        bh=2LkPOjQHzKO5mfFi4gLfZhHO9AcpCJU0ojJyoXqO260=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMVl8cNPVTI5YOOH0N9CPWnfYegS8tMg4vIDGVMorpWjrG45DjHR/nzkfS0H2CyJS
         gbcleqOm+Xbgw31vgk2WYtw+QIhBeceHKq9aeh12k4r2PcUP4CkXWPgkjCzwzumQXl
         tBAsAAp/XxxCOJq2uOCTaxu1CZ96ec+88EoD565VufmeaHrZDNOskOfYIFTm/3ZHkI
         n80AiEqw2p3DiRRrU7F1WIQ+D4Cg1XK7F7Ajot2PRp9zLo+YiS8XB3mxWxFgAl96En
         EiuOCJ0aMY/g8GimmsRV7IRg03BozBdaAiGz69YoAgW1rm++yCYS2tr8Elwi/7UW9V
         FTmc/CgfPK+ag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F05E40B92; Thu,  6 Jan 2022 16:48:41 -0300 (-03)
Date:   Thu, 6 Jan 2022 16:48:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
Message-ID: <YddHmYhvtVvgqZb/@kernel.org>
References: <YddEVgNKBJiqcV6Y@kernel.org>
 <YddGjjmlMZzxUZbN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YddGjjmlMZzxUZbN@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> > After merging torvalds/master to perf/urgent I'm getting this:
> > 
> > util/bpf-event.c:25:21: error: no previous prototype for ‘btf__load_from_kernel_by_id’ [-Werror=missing-prototypes]
> >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/bpf-event.c:37:1: error: no previous prototype for ‘bpf_object__next_program’ [-Werror=missing-prototypes]
> >    37 | bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > util/bpf-event.c:46:1: error: no previous prototype for ‘bpf_object__next_map’ [-Werror=missing-prototypes]
> >    46 | bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> >       | ^~~~~~~~~~~~~~~~~~~~
> > util/bpf-event.c:55:1: error: no previous prototype for ‘btf__raw_data’ [-Werror=missing-prototypes]
> >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
> >       | ^~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf-event.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > util/bpf_counter.c: In function ‘bpf_target_prog_name’:
> > util/bpf_counter.c:82:15: error: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Werror=implicit-function-declaration]
> >    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
> >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/bpf_counter.c:82:13: error: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> >    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
> >       |             ^
> > cc1: all warnings being treated as errors
> > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
> > 
> > I'm checking now...
> > 
> > BTW I test perf builds with:
> > 
> > make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python
> 
> Nevermind, this was due to a patch by Ian Rogers I was testing,
> bisecting get up to the last patch, since I had merged torvalds/master
> today it got me to a wrong correlation, sorry for the disturbance.
> 
> For reference, this is the patch:
> 
> http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.com

Ian, I have libbpf-devel installed:

⬢[acme@toolbox perf]$ rpm -qa | grep libbpf
libbpf-0.4.0-1.fc34.x86_64
libbpf-devel-0.4.0-1.fc34.x86_64
⬢[acme@toolbox perf]$

But I'm not using LIBBPF_DYNAMIC=1, so you can't just give precedence to
system headers for all of the homies in tools/lib/.

I bet that if I remove the libbpf-devel package it works, yeah, just
tested. So we need to make those overrides dependent on using
LIBBPF_DYNAMIC=1, LIBTRACEEVENT_DYNAMIC=1, etc and avoid the big hammer
that is -Itools/lib/, using a more finegrained approach, right?

- Arnaldo
