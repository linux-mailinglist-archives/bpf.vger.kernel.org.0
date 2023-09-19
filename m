Return-Path: <bpf+bounces-10337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DD7A5721
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 03:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06FD280E35
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 01:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868463CA;
	Tue, 19 Sep 2023 01:47:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE531399
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 01:47:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E094;
	Mon, 18 Sep 2023 18:47:03 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RqPZQ2t7bzMlf6;
	Tue, 19 Sep 2023 09:43:26 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 09:46:58 +0800
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
To: Ian Rogers <irogers@google.com>
References: <20230914211948.814999-1-irogers@google.com>
From: Yang Jihong <yangjihong1@huawei.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Nick
 Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Andrii
 Nakryiko <andrii@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, James
 Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, Patrice Duroux
	<patrice.duroux@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <llvm@lists.linux.dev>
Message-ID: <fe8320ab-c03c-c195-c051-0d0c2535e124@huawei.com>
Date: Tue, 19 Sep 2023 09:46:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On 2023/9/15 5:19, Ian Rogers wrote:
> Enable BPF skeletons by default but warn don't fail if they can't be
> supported. This was the intended behavior for Linux 6.4 but it caused
> an issue captured in this thread:
> https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/
> 
> This issue isn't repeated here as the previous issue related to
> generating vmlinux.h, which is no longer performed by default as a
> checked-in vmlinux.h is used instead.
> 
> Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
> to 0 disables BPF skeletons. Also, rather than fail the build due to a
> missed dependency, dependencies are checked and BPF skeletons disabled
> if they aren't present.
> 
> Some related commits:
> b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
> a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
> 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
> a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> 1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
> a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
> 
> Ian Rogers (5):
>    perf version: Add status of bpf skeletons
>    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
>    perf test: Update build test for changed BPF skeleton defaults
>    perf test: Ensure EXTRA_TESTS is covered in build test
>    perf test: Detect off-cpu support from build options
> 
>   tools/perf/Makefile.config              | 78 ++++++++++++++++---------
>   tools/perf/Makefile.perf                |  8 +--
>   tools/perf/builtin-version.c            |  1 +
>   tools/perf/tests/make                   |  7 ++-
>   tools/perf/tests/shell/record_offcpu.sh |  2 +-
>   5 files changed, 59 insertions(+), 37 deletions(-)
> 

Thanks for the patchset. The kwork feature has been tested, as show in 
link[1].

Tested-by: Yang Jihong <yangjihong1@huawei.com>

[1]:
# perf version --build-options
perf version 6.6.rc1.g33ee1c1436b6
                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
             debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
              libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
               libslang: [ OFF ]  # HAVE_SLANG_SUPPORT
              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                    aio: [ on  ]  # HAVE_AIO_SUPPORT
                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                libpfm4: [ OFF ]  # HAVE_LIBPFM
          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
# perf kwork rep -b
Starting trace, Hit <Ctrl+C> to stop and report
^C
   Kwork Name                     | Cpu  | Total Runtime | Count     | 
Max runtime   | Max runtime start   | Max runtime end     |
 
--------------------------------------------------------------------------------------------------------------------------------
   (w)flush_to_ldisc              | 0003 |      2.188 ms |         2 | 
     1.685 ms |      49451.331861 s |      49451.333546 s |
   (s)NET_RX:3                    | 0002 |      1.278 ms |         3 | 
     0.517 ms |      49451.336568 s |      49451.337085 s |
   (s)SCHED:7                     | 0000 |      1.098 ms |         4 | 
     0.880 ms |      49451.332413 s |      49451.333293 s |
   (w)flush_to_ldisc              | 0003 |      1.081 ms |         1 | 
     1.081 ms |      49452.548841 s |      49452.549922 s |
   (s)RCU:9                       | 0001 |      0.894 ms |         2 | 
     0.864 ms |      49451.333580 s |      49451.334443 s |
   (s)SCHED:7                     | 0002 |      0.803 ms |         3 | 
     0.606 ms |      49452.551313 s |      49452.551918 s |
   (s)SCHED:7                     | 0001 |      0.452 ms |         3 | 
     0.278 ms |      49452.547514 s |      49452.547792 s |
   eth0:10                        | 0002 |      0.429 ms |         2 | 
     0.280 ms |      49451.336029 s |      49451.336309 s |
   (w)vmstat_shepherd             | 0000 |      0.402 ms |         1 | 
     0.402 ms |      49452.551022 s |      49452.551424 s |
   (s)TIMER:1                     | 0005 |      0.292 ms |         2 | 
     0.157 ms |      49452.168443 s |      49452.168600 s |
   (s)SCHED:7                     | 0005 |      0.175 ms |         2 | 
     0.098 ms |      49452.168614 s |      49452.168711 s |
   (s)TIMER:1                     | 0000 |      0.165 ms |         2 | 
     0.116 ms |      49452.550736 s |      49452.550852 s |
   (s)RCU:9                       | 0000 |      0.155 ms |         3 | 
     0.070 ms |      49451.339213 s |      49451.339282 s |
   (s)TIMER:1                     | 0006 |      0.153 ms |         2 | 
     0.087 ms |      49451.334483 s |      49451.334570 s |
   (s)TIMER:1                     | 0002 |      0.149 ms |         1 | 
     0.149 ms |      49452.546829 s |      49452.546978 s |
   (s)TIMER:1                     | 0004 |      0.141 ms |         1 | 
     0.141 ms |      49452.552581 s |      49452.552722 s |
   (w)vmstat_update               | 0002 |      0.139 ms |         1 | 
     0.139 ms |      49452.547366 s |      49452.547505 s |
   (s)RCU:9                       | 0004 |      0.139 ms |         2 | 
     0.106 ms |      49452.553196 s |      49452.553302 s |
   virtio0-requests:25            | 0000 |      0.123 ms |         1 | 
     0.123 ms |      49452.550544 s |      49452.550667 s |
   (s)RCU:9                       | 0003 |      0.092 ms |         2 | 
     0.063 ms |      49451.334604 s |      49451.334667 s |
   (s)SCHED:7                     | 0003 |      0.086 ms |         1 | 
     0.086 ms |      49452.549525 s |      49452.549611 s |
   (s)TIMER:1                     | 0001 |      0.081 ms |         1 | 
     0.081 ms |      49451.544545 s |      49451.544626 s |
   (s)TIMER:1                     | 0003 |      0.079 ms |         1 | 
     0.079 ms |      49452.549420 s |      49452.549499 s |
   (w)vmstat_update               | 0000 |      0.060 ms |         1 | 
     0.060 ms |      49452.551474 s |      49452.551534 s |
   (s)RCU:9                       | 0002 |      0.047 ms |         1 | 
     0.047 ms |      49452.547171 s |      49452.547217 s |
   (s)RCU:9                       | 0005 |      0.035 ms |         1 | 
     0.035 ms |      49451.664719 s |      49451.664754 s |
   (s)RCU:9                       | 0006 |      0.029 ms |         1 | 
     0.029 ms |      49451.334593 s |      49451.334622 s |
 
--------------------------------------------------------------------------------------------------------------------------------

# perf kwork lat -b
Starting trace, Hit <Ctrl+C> to stop and report
^C
   Kwork Name                     | Cpu  | Avg delay     | Count     | 
Max delay     | Max delay start     | Max delay end       |
 
--------------------------------------------------------------------------------------------------------------------------------
   (w)vmstat_update               | 0005 |      1.444 ms |         1 | 
     1.444 ms |      49459.360837 s |      49459.362281 s |
   (w)disk_events_workfn          | 0005 |      0.745 ms |         1 | 
     0.745 ms |      49459.360745 s |      49459.361490 s |
   (w)e1000_watchdog              | 0002 |      0.745 ms |         1 | 
     0.745 ms |      49459.360745 s |      49459.361490 s |
   (w)blk_mq_timeout_work         | 0005 |      0.683 ms |         1 | 
     0.683 ms |      49457.632872 s |      49457.633555 s |
   (s)RCU:9                       | 0004 |      0.669 ms |         2 | 
     0.967 ms |      49457.484382 s |      49457.485349 s |
   (s)RCU:9                       | 0005 |      0.570 ms |         1 | 
     0.570 ms |      49457.632575 s |      49457.633146 s |
   (w)vmstat_update               | 0002 |      0.502 ms |         1 | 
     0.502 ms |      49459.169103 s |      49459.169605 s |
   (s)RCU:9                       | 0002 |      0.465 ms |         1 | 
     0.465 ms |      49459.168860 s |      49459.169325 s |
   (w)ata_sff_pio_task            | 0005 |      0.435 ms |         1 | 
     0.435 ms |      49459.361942 s |      49459.362377 s |
   (s)SCHED:7                     | 0005 |      0.327 ms |         2 | 
     0.406 ms |      49457.632634 s |      49457.633040 s |
   (s)SCHED:7                     | 0001 |      0.298 ms |         1 | 
     0.298 ms |      49457.484366 s |      49457.484664 s |
   (s)RCU:9                       | 0000 |      0.298 ms |         1 | 
     0.298 ms |      49459.578203 s |      49459.578501 s |
   (s)RCU:9                       | 0003 |      0.294 ms |         1 | 
     0.294 ms |      49459.363345 s |      49459.363638 s |
   (s)SCHED:7                     | 0002 |      0.277 ms |         2 | 
     0.339 ms |      49459.168911 s |      49459.169251 s |
   (w)do_cache_clean              | 0003 |      0.276 ms |         1 | 
     0.276 ms |      49459.363610 s |      49459.363886 s |
   (w)vmstat_update               | 0003 |      0.272 ms |         1 | 
     0.272 ms |      49459.363544 s |      49459.363815 s |
   (w)blk_mq_requeue_work         | 0002 |      0.233 ms |         3 | 
     0.376 ms |      49459.172895 s |      49459.173271 s |
   (s)SCHED:7                     | 0004 |      0.231 ms |         9 | 
     0.456 ms |      49459.573451 s |      49459.573908 s |
   (s)TIMER:1                     | 0000 |      0.217 ms |         1 | 
     0.217 ms |      49459.578169 s |      49459.578386 s |
   (s)TIMER:1                     | 0005 |      0.206 ms |         2 | 
     0.234 ms |      49457.632492 s |      49457.632726 s |
   (s)TIMER:1                     | 0002 |      0.194 ms |         2 | 
     0.203 ms |      49459.168794 s |      49459.168997 s |
   (w)flush_to_ldisc              | 0003 |      0.173 ms |         1 | 
     0.173 ms |      49459.575720 s |      49459.575893 s |
   (s)TIMER:1                     | 0006 |      0.171 ms |         1 | 
     0.171 ms |      49457.485465 s |      49457.485636 s |
   (s)TIMER:1                     | 0004 |      0.167 ms |         6 | 
     0.212 ms |      49457.696331 s |      49457.696543 s |
   (s)RCU:9                       | 0006 |      0.148 ms |         1 | 
     0.148 ms |      49457.485547 s |      49457.485696 s |
   (s)TIMER:1                     | 0003 |      0.147 ms |         1 | 
     0.147 ms |      49459.363301 s |      49459.363448 s |
   (s)RCU:9                       | 0001 |      0.132 ms |         2 | 
     0.173 ms |      49459.578156 s |      49459.578329 s |
   (s)NET_RX:3                    | 0002 |      0.117 ms |         4 | 
     0.225 ms |      49457.485058 s |      49457.485283 s |
   (s)SCHED:7                     | 0000 |      0.074 ms |         9 | 
     0.310 ms |      49457.484688 s |      49457.484998 s |
   (s)BLOCK:4                     | 0003 |      0.072 ms |         1 | 
     0.072 ms |      49459.362765 s |      49459.362837 s |
   (s)SCHED:7                     | 0003 |      0.064 ms |         1 | 
     0.064 ms |      49459.576487 s |      49459.576551 s |
   (s)BLOCK:4                     | 0002 |      0.057 ms |         4 | 
     0.107 ms |      49459.172252 s |      49459.172359 s |
 
--------------------------------------------------------------------------------------------------------------------------------

Thanks,
Yang

