Return-Path: <bpf+bounces-4051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2474845B
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428EB1C20B28
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9D6FC8;
	Wed,  5 Jul 2023 12:45:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58810F0
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 12:45:47 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D95AE70
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YMNPgRnklmsa3yVbjXk+HC5gFX+rQoqFA4QMGq+76yA=; b=DM2405sGREa3H1dZb/rAW1//Fi
	JSgcyr41T1thtvUavwPgoc1oxtXCUZdxHj9Sy7KLsuunyEJqCek5RGvRSwLhT0W7W2Mq28JBD79Hh
	w/zqYnNrOSt5wXjVNoNY/S4A+Dtjs7oT/MhMFBfJak2+Qez0qIeT94nhKTHoqFJqh2G5+g4H2xA4Y
	ssXLi9Fx1lm9YbAK7y3LIVd0zucLYllOwG7FM9etta4W46AxUiAYNjtd+J3vNgTWj4ai3y90P/YOc
	ER+w9R7BGqIxITMCDwdXnVvvK9vj4I5xHq0Kw7EZoZfK6RNAKCDf3TNTA6PwlW9FKOPMpxC2krVpv
	LFu/gaYQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH1t9-0001GN-9T; Wed, 05 Jul 2023 14:45:43 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH1t8-000C9L-Q5; Wed, 05 Jul 2023 14:45:42 +0200
Subject: Re: [PATCHv3 bpf-next 00/26] bpf: Add multi uprobe link
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20230630083344.984305-1-jolsa@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4329bb2c-da00-4c19-775b-9d8c1db22caa@iogearbox.net>
Date: Wed, 5 Jul 2023 14:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/30/23 10:33 AM, Jiri Olsa wrote:
> hi,
> this patchset is adding support to attach multiple uprobes and usdt probes
> through new uprobe_multi link.
> 
> The current uprobe is attached through the perf event and attaching many
> uprobes takes a lot of time because of that.
> 
> The main reason is that we need to install perf event for each probed function
> and profile shows perf event installation (perf_install_in_context) as culprit.
> 
> The new uprobe_multi link just creates raw uprobes and attaches the bpf
> program to them without perf event being involved.
> 
> In addition to being faster we also save file descriptors. For the current
> uprobe attach we use extra perf event fd for each probed function. The new
> link just need one fd that covers all the functions we are attaching to.
> 
> v3 changes:
>    - consolidate attach type checks in bpf_prog_attach_check_attach_type [Andrii]
>    - remove bpf_prog_active check [Alexei]
>    - change rcu locking [Andrii]
>    - allocate ref_ctr_offsets conditionally [Andrii]
>    - remove ctx check from bpf_uprobe_multi_cookie [Andrii]
>    - move some elf_* functions in elf.c object [Andrii]
>    - fix uprobe link detection code [Andrii]
>    - add usdt.s program section [Andrii]
>    - rename bpf_program__attach_uprobe_multi_opts to bpf_program__attach_uprobe_multi [Andrii]
>    - remove extra case from attach_uprobe_multi [Andrii]
>    - rework usdt_manager_attach_usdt [Andrii]
>    - rework/rename new elf_find_* functions [Andrii]
>    - elf iterator fixes [Andrii]
>      - renames
>      - elf_sym_iter_next loop restruct
>      - return directly GElf_Sym in elf_sym
>      - add elf_sym_offset helper
>      - add st_type arg elf_sym_iter_new
>      - get rid of '_' prefixed functions
>      - simplify offsets handling
>      - other smaller changes
>    - added acks
>    - todo:
>      - seems like more elf_* helpers could go in elf.c object,
>        I'll send that as follow up
>      - will send fill_info support when [3] is merged [Andrii]
> 
> 
> There's support for bpftrace [2] and tetragon [1].
> 
> Also available at:
>    https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>    uprobe_multi
> 
> thanks,
> jirka
> 
> 
> [1] https://github.com/cilium/tetragon/pull/936
> [2] https://github.com/iovisor/bpftrace/compare/master...olsajiri:bpftrace:uprobe_multi
> [3] https://lore.kernel.org/bpf/20230628115329.248450-1-laoar.shao@gmail.com/
> ---
> Jiri Olsa (26):
>        bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
>        bpf: Add multi uprobe link
>        bpf: Add cookies support for uprobe_multi link
>        bpf: Add pid filter support for uprobe_multi link
>        bpf: Add bpf_get_func_ip helper support for uprobe link
>        libbpf: Add uprobe_multi attach type and link names
>        libbpf: Move elf_find_func_offset* functions to elf object
>        libbpf: Add elf_open/elf_close functions
>        libbpf: Add elf symbol iterator
>        libbpf: Add elf_resolve_syms_offsets function
>        libbpf: Add elf_resolve_pattern_offsets function
>        libbpf: Add bpf_link_create support for multi uprobes
>        libbpf: Add bpf_program__attach_uprobe_multi function
>        libbpf: Add support for u[ret]probe.multi[.s] program sections
>        libbpf: Add uprobe multi link detection
>        libbpf: Add uprobe multi link support to bpf_program__attach_usdt
>        selftests/bpf: Add uprobe_multi skel test
>        selftests/bpf: Add uprobe_multi api test
>        selftests/bpf: Add uprobe_multi link test
>        selftests/bpf: Add uprobe_multi test program
>        selftests/bpf: Add uprobe_multi bench test
>        selftests/bpf: Add usdt_multi test program
>        selftests/bpf: Add usdt_multi bench test
>        selftests/bpf: Add uprobe_multi cookie test
>        selftests/bpf: Add uprobe_multi pid filter tests
>        selftests/bpf: Add extra link to uprobe_multi tests
> 
>   include/linux/trace_events.h                               |   6 ++
>   include/uapi/linux/bpf.h                                   |  16 ++++
>   kernel/bpf/syscall.c                                       | 122 ++++++++++++-------------
>   kernel/trace/bpf_trace.c                                   | 346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   tools/include/uapi/linux/bpf.h                             |  16 ++++
>   tools/lib/bpf/Build                                        |   2 +-
>   tools/lib/bpf/bpf.c                                        |  11 +++
>   tools/lib/bpf/bpf.h                                        |  11 ++-
>   tools/lib/bpf/elf.c                                        | 435 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.c                                     | 396 ++++++++++++++++++++++++++++++++++++++++++---------------------------------------
>   tools/lib/bpf/libbpf.h                                     |  27 ++++++
>   tools/lib/bpf/libbpf.map                                   |   1 +
>   tools/lib/bpf/libbpf_elf.h                                 |  24 +++++
>   tools/lib/bpf/libbpf_internal.h                            |   3 +
>   tools/lib/bpf/usdt.c                                       | 109 +++++++++++++++--------
>   tools/testing/selftests/bpf/Makefile                       |  10 +++
>   tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 ++++++++++++++++
>   tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tools/testing/selftests/bpf/progs/uprobe_multi.c           | 110 +++++++++++++++++++++++
>   tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 ++++
>   tools/testing/selftests/bpf/uprobe_multi.c                 |  53 +++++++++++
>   tools/testing/selftests/bpf/usdt_multi.c                   |  24 +++++
>   22 files changed, 1969 insertions(+), 296 deletions(-)
>   create mode 100644 tools/lib/bpf/elf.c
>   create mode 100644 tools/lib/bpf/libbpf_elf.h
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
>   create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
>   create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
>   create mode 100644 tools/testing/selftests/bpf/usdt_multi.c

Looks like BPF CI did not trigger because of build error with LLVM:

https://github.com/kernel-patches/bpf/actions/runs/5423873866/jobs/9908376097

   [...]
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:367:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK(err, "uprobe_multi__attach"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:381:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:367:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK(err, "uprobe_multi__attach"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:361:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:381:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:361:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:352:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:381:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:352:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:344:37: note: initialize the variable 'attach_end_ns' to silence this warning
           long attach_start_ns, attach_end_ns;
                                              ^
                                               = 0
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:361:6: error: variable 'attach_start_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:381:34: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                                           ^~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:361:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_EQ(err, 0, "uprobe_multi__load"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:352:6: error: variable 'attach_start_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:381:34: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                                           ^~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:352:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:344:22: note: initialize the variable 'attach_start_ns' to silence this warning
           long attach_start_ns, attach_end_ns;
                               ^
                                = 0
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:414:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:428:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:414:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:407:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:428:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:407:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:398:6: error: variable 'attach_end_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:428:18: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                           ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:398:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:391:37: note: initialize the variable 'attach_end_ns' to silence this warning
           long attach_start_ns, attach_end_ns;
                                              ^
                                               = 0
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:407:6: error: variable 'attach_start_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:428:34: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                                           ^~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:407:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_EQ(err, 0, "uprobe_multi_usdt__load"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:398:6: error: variable 'attach_start_ns' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:428:34: note: uninitialized use occurs here
           attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
                                           ^~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:398:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK_PTR(skel, "uprobe_multi__open"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c:391:22: note: initialize the variable 'attach_start_ns' to silence this warning
           long attach_start_ns, attach_end_ns;
                               ^
                                = 0
   10 errors generated.
     TEST-OBJ [test_progs] lookup_key.test.o
   make: *** [Makefile:578: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/uprobe_multi_test.test.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

