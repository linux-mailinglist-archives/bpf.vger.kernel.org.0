Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A915514A3C9
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgA0M0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 07:26:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:58812 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgA0M0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:26:13 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw3T0-0000NM-IP; Mon, 27 Jan 2020 13:26:10 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw3T0-000ROo-62; Mon, 27 Jan 2020 13:26:10 +0100
Subject: Re: [PATCH v6 bpf-next 1/2] bpf: Add bpf_read_branch_records() helper
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, ast@kernel.org,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
References: <20200126233554.20061-1-dxu@dxuuu.xyz>
 <20200126233554.20061-2-dxu@dxuuu.xyz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a026ad0c-7d24-09cc-9742-c241d37fbdb0@iogearbox.net>
Date:   Mon, 27 Jan 2020 13:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200126233554.20061-2-dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25707/Sun Jan 26 12:40:28 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/20 12:35 AM, Daniel Xu wrote:
> Branch records are a CPU feature that can be configured to record
> certain branches that are taken during code execution. This data is
> particularly interesting for profile guided optimizations. perf has had
> branch record support for a while but the data collection can be a bit
> coarse grained.
> 
> We (Facebook) have seen in experiments that associating metadata with
> branch records can improve results (after postprocessing). We generally
> use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
> support for branch records is useful.
> 
> Aside from this particular use case, having branch data available to bpf
> progs can be useful to get stack traces out of userspace applications
> that omit frame pointers.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   include/uapi/linux/bpf.h | 25 +++++++++++++++++++++++-
>   kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f1d74a2bd234..332aa433d045 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2892,6 +2892,25 @@ union bpf_attr {
>    *		Obtain the 64bit jiffies
>    *	Return
>    *		The 64 bit jiffies
> + *
> + * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size, u64 flags)

Small nit: s/buf_size/size/, so that it matches with your BPF_CALL below.

  +BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
  +	   void *, buf, u32, size, u64, flags)

> + *	Description
> + *		For an eBPF program attached to a perf event, retrieve the
> + *		branch records (struct perf_branch_entry) associated to *ctx*
> + *		and store it in	the buffer pointed by *buf* up to size
> + *		*buf_size* bytes.
> + *
> + *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
> + *		instead	return the number of bytes required to store all the
> + *		branch entries. If this flag is set, *buf* may be NULL.
> + *	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.

Maybe pull the 2nd paragraph from above in here so that it reflects the description
of the return value when flag is used also for this case in the 'Return' description.

> + *		**-EINVAL** if arguments invalid or **buf_size** not a multiple
> + *		of sizeof(struct perf_branch_entry).
> + *
> + *		**-ENOENT** if architecture does not support branch records.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3012,7 +3031,8 @@ union bpf_attr {
>   	FN(probe_read_kernel_str),	\
>   	FN(tcp_send_ack),		\
>   	FN(send_signal_thread),		\
> -	FN(jiffies64),
> +	FN(jiffies64),			\
> +	FN(read_branch_records),
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>    * function eBPF program intends to call
> @@ -3091,6 +3111,9 @@ enum bpf_func_id {
>   /* BPF_FUNC_sk_storage_get flags */
>   #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
>   
> +/* BPF_FUNC_read_branch_records flags. */
> +#define BPF_F_GET_BRANCH_RECORDS_SIZE	(1ULL << 0)
> +
>   /* Mode for BPF_FUNC_skb_adjust_room helper. */
>   enum bpf_adj_room_mode {
>   	BPF_ADJ_ROOM_NET,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 19e793aa441a..efd119de95b8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1028,6 +1028,45 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>            .arg3_type      = ARG_CONST_SIZE,
>   };
>   
> +BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
> +	   void *, buf, u32, size, u64, flags)
> +{
> +#ifndef CONFIG_X86
> +	return -ENOENT;
> +#else
> +	struct perf_branch_stack *br_stack = ctx->data->br_stack;
> +	u32 br_entry_size = sizeof(struct perf_branch_entry);

'static const u32 br_entry_size' if we use it as such below.

> +	u32 to_copy;
> +
> +	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> +		return -EINVAL;
> +
> +	if (unlikely(!br_stack))
> +		return -EINVAL;

Why the ifdef X86? In previous thread I meant to change it into since it's
implicit:

         if (unlikely(!br_stack))
                 return -ENOENT;

Or is there any other additional rationale?

> +	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
> +		return br_stack->nr * br_entry_size;
> +
> +	if (!buf || (size % br_entry_size != 0))
> +		return -EINVAL;
> +
> +	to_copy = min_t(u32, br_stack->nr * br_entry_size, size);
> +	memcpy(buf, br_stack->entries, to_copy);
> +
> +	return to_copy;
> +#endif
> +}
> +
> +static const struct bpf_func_proto bpf_read_branch_records_proto = {
> +	.func           = bpf_read_branch_records,
> +	.gpl_only       = true,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> +	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> +	.arg4_type      = ARG_ANYTHING,
> +};
> +
>   static const struct bpf_func_proto *
>   pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -1040,6 +1079,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_stack_proto_tp;
>   	case BPF_FUNC_perf_prog_read_value:
>   		return &bpf_perf_prog_read_value_proto;
> +	case BPF_FUNC_read_branch_records:
> +		return &bpf_read_branch_records_proto;
>   	default:
>   		return tracing_func_proto(func_id, prog);
>   	}
> 

