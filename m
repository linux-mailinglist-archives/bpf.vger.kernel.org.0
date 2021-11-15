Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C078451A3B
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 00:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbhKOXfU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 18:35:20 -0500
Received: from www62.your-server.de ([213.133.104.62]:53340 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353101AbhKOXdO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 18:33:14 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmlQO-000Ci8-7O; Tue, 16 Nov 2021 00:30:08 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mmlQN-000GXA-PZ; Tue, 16 Nov 2021 00:30:07 +0100
Subject: Re: [PATCH] bpf: Enable bpf support for reading branch records in
 powerpc
To:     Kajol Jain <kjain@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com
References: <20211115044437.12047-1-kjain@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5a185d6b-7090-23f0-1ec9-140a31ee5fb4@iogearbox.net>
Date:   Tue, 16 Nov 2021 00:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211115044437.12047-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26354/Mon Nov 15 10:21:07 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/21 5:44 AM, Kajol Jain wrote:
> Branch data available to bpf programs can be very useful to get
> stack traces out of userspace applications.
> 
> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
> added bpf support to capture branch records in x86. Enable this feature
> for powerpc as well.
> 
> Commit 67306f84ca78 ("selftests/bpf: Add bpf_read_branch_records()
> selftest") adds selftest corresponding to bpf branch read
> function bpf_read_branch_records(). Used this selftest to
> test bpf support, for reading branch records in powerpc.
> 
> Selftest result in power9 box before this patch changes:
> 
> [command]# ./test_progs -t perf_branches
> Failed to load bpf_testmod.ko into the kernel: -8
> WARNING! Selftests relying on bpf_testmod.ko will be skipped.
> test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
> test_perf_branches_common:PASS:attach_perf_event 0 nsec
> test_perf_branches_common:PASS:set_affinity 0 nsec
> check_good_sample:PASS:output not valid 0 nsec
> check_good_sample:FAIL:read_branches_size err -2
> check_good_sample:FAIL:read_branches_stack err -2
> check_good_sample:FAIL:read_branches_stack stack bytes written=-2
> not multiple of struct size=24
> check_good_sample:FAIL:read_branches_global err -2
> check_good_sample:FAIL:read_branches_global global bytes written=-2
> not multiple of struct size=24
> check_good_sample:PASS:read_branches_size 0 nsec
>   #75/1 perf_branches_hw:FAIL
>   #75/2 perf_branches_no_hw:OK
>   #75 perf_branches:FAIL
> Summary: 0/1 PASSED, 0 SKIPPED, 2 FAILED
> 
> Selftest result in power9 box after this patch changes:
> 
> [command]#: ./test_progs -t perf_branches
>   #75/1 perf_branches_hw:OK
>   #75/2 perf_branches_no_hw:OK
>   #75 perf_branches:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Kajol Jain<kjain@linux.ibm.com>
> ---
>   kernel/trace/bpf_trace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index fdd14072fc3b..2b7343b64bb7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1245,7 +1245,7 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>   BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>   	   void *, buf, u32, size, u64, flags)
>   {
> -#ifndef CONFIG_X86
> +#if !(defined(CONFIG_X86) || defined(CONFIG_PPC64))

Can this really be enabled generically? Looking at 3925f46bb590 ("powerpc/perf: Enable
branch stack sampling framework") it says POWER8 [and beyond]. Should there be a generic
Kconfig symbol like ARCH_HAS_BRANCH_RECORDS that can be selected by archs instead?

>   	return -ENOENT;
>   #else
>   	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> 

