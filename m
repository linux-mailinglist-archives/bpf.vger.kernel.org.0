Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637335E121
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCJgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 05:36:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:49120 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfGCJgT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 05:36:19 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hibgW-0005es-Iy; Wed, 03 Jul 2019 11:36:16 +0200
Received: from [2a02:1205:5054:6d70:b45c:ec96:516a:e956] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hibgW-000UNG-CN; Wed, 03 Jul 2019 11:36:16 +0200
Subject: Re: [PATCH v4 bpf-next 0/4] libbpf: add perf buffer abstraction and
 API
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        ast@fb.com, kernel-team@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, jakub.kicinski@netronome.com
References: <20190630065109.1794420-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5a48c2f1-2abc-2deb-6863-c9f20e4ac03b@iogearbox.net>
Date:   Wed, 3 Jul 2019 11:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190630065109.1794420-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25499/Wed Jul  3 10:03:10 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/30/2019 08:51 AM, Andrii Nakryiko wrote:
> This patchset adds a high-level API for setting up and polling perf buffers
> associated with BPF_MAP_TYPE_PERF_EVENT_ARRAY map. Details of APIs are
> described in corresponding commit.
> 
> Patch #1 adds a set of APIs to set up and work with perf buffer.
> Patch #2 enhances libbpf to support auto-setting PERF_EVENT_ARRAY map size.
> Patch #3 adds test.
> Patch #4 converts bpftool map event_pipe to new API.
> 
> v3->v4:
> - fixed bpftool event_pipe cmd error handling (Jakub);
> 
> v2->v3:
> - added perf_buffer__new_raw for more low-level control;
> - converted bpftool map event_pipe to new API (Daniel);
> - fixed bug with error handling in create_maps (Song);
> 
> v1->v2:
> - add auto-sizing of PERF_EVENT_ARRAY maps;
> 
> Andrii Nakryiko (4):
>   libbpf: add perf buffer API
>   libbpf: auto-set PERF_EVENT_ARRAY size to number of CPUs
>   selftests/bpf: test perf buffer API
>   tools/bpftool: switch map event_pipe to libbpf's perf_buffer
> 
>  tools/bpf/bpftool/map_perf_ring.c             | 201 +++------
>  tools/lib/bpf/libbpf.c                        | 397 +++++++++++++++++-
>  tools/lib/bpf/libbpf.h                        |  49 +++
>  tools/lib/bpf/libbpf.map                      |   4 +
>  .../selftests/bpf/prog_tests/perf_buffer.c    |  94 +++++
>  .../selftests/bpf/progs/test_perf_buffer.c    |  29 ++
>  6 files changed, 630 insertions(+), 144 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_buffer.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_buffer.c

Hm, set looks good, but this does not apply cleanly. Please rebase against
bpf-next and resubmit. Please also update tools/lib/bpf/README.rst with regards
to the perf_buffer__ prefix. While at it, you could also address Jakub's comment.

Thanks,
Daniel
