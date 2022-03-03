Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9234CC170
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiCCPhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 10:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiCCPhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 10:37:12 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3514346A
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 07:36:24 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPnV8-000GYv-5z; Thu, 03 Mar 2022 16:36:22 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPnV7-000Btv-UA; Thu, 03 Mar 2022 16:36:21 +0100
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
To:     Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org
Cc:     kernel-team@fb.com, Yonghong Song <yhs@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
Date:   Thu, 3 Mar 2022 16:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220302212735.3412041-1-mykolal@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26470/Thu Mar  3 10:49:16 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/22 10:27 PM, Mykola Lysenko wrote:
> In send_signal, replace sleep with dummy cpu intensive computation
> to increase probability of child process being scheduled. Add few
> more asserts.
> 
> In find_vma, reduce sample_freq as higher values may be rejected in
> some qemu setups, remove usleep and increase length of cpu intensive
> computation.
> 
> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
> higher values may be rejected in some qemu setups
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>   .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>   .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>   .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>   .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>   .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>   6 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index cd10df6cd0fc..0612e79a9281 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.config = PERF_COUNT_SW_CPU_CLOCK;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>   	if (!ASSERT_GE(pfd, 0, "perf_fd"))
>   		goto cleanup;
> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> index b74b3c0c555a..7cf4feb6464c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> @@ -30,12 +30,20 @@ static int open_pe(void)
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>   	attr.freq = 1;
> -	attr.sample_freq = 4000;
> +	attr.sample_freq = 1000;
>   	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>   
>   	return pfd >= 0 ? pfd : -errno;
>   }
>   
> +static bool find_vma_pe_condition(struct find_vma *skel)
> +{
> +	return skel->bss->found_vm_exec == 0 ||
> +		skel->data->find_addr_ret != 0 ||

Should this not test for `skel->data->find_addr_ret == -1` ?

> +		skel->data->find_zero_ret == -1 ||
> +		strcmp(skel->bss->d_iname, "test_progs") != 0;
> +}
> +
Thanks,
Daniel
