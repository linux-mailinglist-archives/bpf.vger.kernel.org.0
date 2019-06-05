Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F22835C16
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfFELyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 07:54:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:55842 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfFELyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 07:54:22 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYUUm-00048D-Ur; Wed, 05 Jun 2019 13:54:21 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYUUm-000T2s-Or; Wed, 05 Jun 2019 13:54:20 +0200
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
To:     Hechao Li <hechaol@fb.com>, Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, yhs@fb.com,
        andrii.nakryiko@gmail.com
References: <20190604223815.2487730-1-hechaol@fb.com>
 <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
 <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com>
 <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
 <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2a6ab005-0ac1-be09-d5dc-05ea672cbf9a@iogearbox.net>
Date:   Wed, 5 Jun 2019 13:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25471/Wed Jun  5 10:12:21 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/05/2019 02:18 AM, Hechao Li wrote:
> I looked into current public APIs in libbpf.h and bpf.h. Most of them seem to be directly related to bpf object/program/map. But this function, bpf_num_possible_cpus(), is just a utility used while looking up per-CPU maps. I am not sure if it is appropriate to make it an official API. Yonghong, the author of libbpf_util.h, also asked me to put it into libbpf_util. But I am fine with either way. I can move it to libbpf.h/.c if you all agree.

(please avoid top-posting)

It's a good question, I think it depends how much we want to aide users consuming libbpf
that are using per-CPU maps, for example. If we only want to reuse it for in-tree selftests,
it's fine to keep it in an unexposed internal header that selftests would include.
Other option could be to expose and prefix as libbpf_num_possible_cpus() to denote it's a
misc helper and perhaps also move f3515b5d0b71 ("bpf: provide a generic macro for percpu
values for selftests") into libbpf. I'd be fine either way, my preference is to add it
as an libbpf_ API given users would need something along these lines when walking the value
anyway. See e00c7b216f34 ("bpf: fix multiple issues in selftest suite and samples") for
context on why this helper was added and sysconf(_SC_NPROCESSORS_CONF) use would be broken
in this context.

Thanks,
Daniel

> Thanks,
> Hechao
> 
> ﻿On 6/4/19, 5:08 PM, "Daniel Borkmann" <daniel@iogearbox.net> wrote:
> 
>     On 06/05/2019 01:54 AM, Hechao Li wrote:
>     > I put the implementation in libbpf_util.c mainly because it depends on pr_warning defined in libbpf_internal.h. If including libbpf_internal.h in libbpf_util.h, then the internal stuff will be exposed to whoever include libbpf_util.h. But let me know if there is a better way to print the error messages other than depending on libbpf_internal. 
>     > 
>     > Thanks,
>     > Hechao
>     > 
>     > On 6/4/19, 4:40 PM, "Song Liu" <songliubraving@fb.com> wrote:
>     > 
>     >     
>     >     > On Jun 4, 2019, at 3:38 PM, Hechao Li <hechaol@fb.com> wrote:
>     >     > 
>     >     > Getting number of possible CPUs is commonly used for per-CPU BPF maps 
>     >     > and perf_event_maps. Putting it into a common place can avoid duplicate 
>     >     > implementations.
>     >     > 
>     >     > Hechao Li (2):
>     >     >  Add bpf_num_possible_cpus to libbpf_util
>     >     >  Use bpf_num_possible_cpus in bpftool and selftests
>     >     > 
>     >     > tools/bpf/bpftool/common.c                    | 53 ++--------------
>     >     > tools/lib/bpf/Build                           |  2 +-
>     >     > tools/lib/bpf/libbpf_util.c                   | 61 +++++++++++++++++++
>     >     > tools/lib/bpf/libbpf_util.h                   |  7 +++
>     >     > tools/testing/selftests/bpf/bpf_util.h        | 42 +++----------
>     >     > .../selftests/bpf/prog_tests/l4lb_all.c       |  2 +-
>     >     > .../selftests/bpf/prog_tests/xdp_noinline.c   |  2 +-
>     >     > tools/testing/selftests/bpf/test_btf.c        |  2 +-
>     >     > tools/testing/selftests/bpf/test_lru_map.c    |  2 +-
>     >     > tools/testing/selftests/bpf/test_maps.c       |  6 +-
>     >     > 10 files changed, 88 insertions(+), 91 deletions(-)
>     >     > create mode 100644 tools/lib/bpf/libbpf_util.c
>     >     > 
>     >     > -- 
>     >     > 2.17.1
>     >     > 
>     >     
>     >     The change is mostly straightforward. However, I am not sure whether
>     >     they should be added to libbpf_util.h. Maybe libbpf.h is a better 
>     >     place?
>     >     
>     >     Daniel and Alexei, what's your recommendation here? 
>     
>     Hm, looks like the patch did not make it to the list (yet?). Agree it makes
>     sense to move it into libbpf given common use for per-CPU/perf-event maps.
>     Given from the diff stat it's not added to libbpf.map, is there a reason to
>     not add it to, say, tools/lib/bpf/libbpf.c and expose it as official API?
>     
>     Thanks,
>     Daniel
>     
> 

