Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65668486A9B
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiAFToU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 14:44:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33118 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbiAFToU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 14:44:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C56CEB82391;
        Thu,  6 Jan 2022 19:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E8C36AE3;
        Thu,  6 Jan 2022 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641498257;
        bh=T6INKLj+ULtVr0TPsyZhCQXTtWGYB45Nxl4YMvhDTUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2rxMowkLDs+cKQpxKrz9Ut/j2aY0fE8WSagESuWvUTrBYoGDEerxnn9eLHe9Wt/i
         SkA5X86J8W9hXXrO3ARoEsGXRLPJpzTda99RS93xCjKv6j1hxSRwdlM1txAyd6+fc1
         kBqSeaCMadJ3RXslYo8azJ+OQtYCcxbgN4K6xycr7DhHvqZ4fYeR8J7UHI+V5vqzw5
         UExP3ZUGbK6KCLgILYbu0/DIChy4NtlmFojMIM14lq5yDi9W/ypek4IcAZWUiYeQ5D
         UzBn/d+m7ZyNf0dzfGeKO5rn+wdCtbbW3JVN/MA1TSRODJpkRGv3TuwOM9QyHTV3IB
         3BBZnUpeiacYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA1DB40B92; Thu,  6 Jan 2022 16:44:14 -0300 (-03)
Date:   Thu, 6 Jan 2022 16:44:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
Message-ID: <YddGjjmlMZzxUZbN@kernel.org>
References: <YddEVgNKBJiqcV6Y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YddEVgNKBJiqcV6Y@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> After merging torvalds/master to perf/urgent I'm getting this:
> 
> util/bpf-event.c:25:21: error: no previous prototype for ‘btf__load_from_kernel_by_id’ [-Werror=missing-prototypes]
>    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf-event.c:37:1: error: no previous prototype for ‘bpf_object__next_program’ [-Werror=missing-prototypes]
>    37 | bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf-event.c:46:1: error: no previous prototype for ‘bpf_object__next_map’ [-Werror=missing-prototypes]
>    46 | bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
>       | ^~~~~~~~~~~~~~~~~~~~
> util/bpf-event.c:55:1: error: no previous prototype for ‘btf__raw_data’ [-Werror=missing-prototypes]
>    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
>       | ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf-event.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> util/bpf_counter.c: In function ‘bpf_target_prog_name’:
> util/bpf_counter.c:82:15: error: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Werror=implicit-function-declaration]
>    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf_counter.c:82:13: error: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
>    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
>       |             ^
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
> 
> I'm checking now...
> 
> BTW I test perf builds with:
> 
> make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python

Nevermind, this was due to a patch by Ian Rogers I was testing,
bisecting get up to the last patch, since I had merged torvalds/master
today it got me to a wrong correlation, sorry for the disturbance.

For reference, this is the patch:

http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.com

- Arnaldo
