Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5C45A227
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 13:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhKWMG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 07:06:56 -0500
Received: from www62.your-server.de ([213.133.104.62]:39652 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhKWMGz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 07:06:55 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mpUWX-0005MI-4M; Tue, 23 Nov 2021 13:03:45 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mpUWW-000C6f-M7; Tue, 23 Nov 2021 13:03:44 +0100
Subject: Re: [PATCH v3] bpf: Remove config check to enable bpf support for
 branch records
To:     Kajol Jain <kjain@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, andrii.nakryiko@gmail.com
References: <20211123095104.54330-1-kjain@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d5436a4c-f4dc-7d6c-f521-505e35c57fb5@iogearbox.net>
Date:   Tue, 23 Nov 2021 13:03:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211123095104.54330-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26362/Tue Nov 23 10:18:04 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/21 10:51 AM, Kajol Jain wrote:
> Branch data available to bpf programs can be very useful to get
> stack traces out of userspace application.
> 
> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
> added bpf support to capture branch records in x86. Enable this feature
> for other architectures as well by removing check specific to x86.
> 
> Incase any architecture doesn't support branch records,
> bpf_read_branch_records still have appropriate checks and it
> will return error number -EINVAL in that scenario. But based on
> documentation there in include/uapi/linux/bpf.h file, incase of
> unsupported archs, this function should return -ENOENT. Hence update
> the appropriate checks to return -ENOENT instead.
> 
> Selftest 'perf_branches' result on power9 machine which has branch stacks
> support.
> 
> Before this patch changes:
> [command]# ./test_progs -t perf_branches
>   #88/1 perf_branches/perf_branches_hw:FAIL
>   #88/2 perf_branches/perf_branches_no_hw:OK
>   #88 perf_branches:FAIL
> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> 
> After this patch changes:
> [command]# ./test_progs -t perf_branches
>   #88/1 perf_branches/perf_branches_hw:OK
>   #88/2 perf_branches/perf_branches_no_hw:OK
>   #88 perf_branches:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> Selftest 'perf_branches' result on power9 machine which doesn't
> have branch stack report.
> 
> After this patch changes:
> [command]# ./test_progs -t perf_branches
>   #88/1 perf_branches/perf_branches_hw:SKIP
>   #88/2 perf_branches/perf_branches_no_hw:OK
>   #88 perf_branches:OK
> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
> 
> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
> 
> Tested this patch changes on power9 machine using selftest
> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
> Add bpf_read_branch_records()")
> 
> Changelog:
> v2 -> v3
> - Change the return error number for bpf_read_branch_records
>    function from -EINVAL to -ENOENT for appropriate checks
>    as suggested by Daniel Borkmann.
> 
> - Link to the v2 patch: https://lkml.org/lkml/2021/11/18/510
> 
> v1 -> v2
> - Inorder to add bpf support to capture branch record in
>    powerpc, rather then adding config for powerpc, entirely
>    remove config check from bpf_read_branch_records function
>    as suggested by Peter Zijlstra
> 
> - Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434
> 
>   kernel/trace/bpf_trace.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 7396488793ff..b94a00f92759 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1402,18 +1402,15 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>   BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>   	   void *, buf, u32, size, u64, flags)
>   {
> -#ifndef CONFIG_X86
> -	return -ENOENT;
> -#else
>   	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>   	struct perf_branch_stack *br_stack = ctx->data->br_stack;
>   	u32 to_copy;
>   
>   	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> -		return -EINVAL;
> +		return -ENOENT;

What's the rationale for also changing the above? Invalid/unsupported flags should
still return -EINVAL as they did before ...

>   	if (unlikely(!br_stack))
> -		return -EINVAL;
> +		return -ENOENT;

... meaning only this one here was necessary.

>   	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
>   		return br_stack->nr * br_entry_size;
> @@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>   	memcpy(buf, br_stack->entries, to_copy);
>   
>   	return to_copy;
> -#endif
>   }
>   
>   static const struct bpf_func_proto bpf_read_branch_records_proto = {
> 

