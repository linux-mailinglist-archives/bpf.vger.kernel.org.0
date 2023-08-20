Return-Path: <bpf+bounces-8130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A84781C4A
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C15D1C20889
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628410E2;
	Sun, 20 Aug 2023 03:51:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F21EA9
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 03:51:12 +0000 (UTC)
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2216194
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 20:47:58 -0700 (PDT)
Message-ID: <1d62fbc0-125b-e99e-d385-fa313f6f1f46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692503276; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0IaFpmq4rAGB4PtsZw9c21MUDCaXW+VXKsWKV2nimg=;
	b=RPR2y1thJqR2KTeY3dLDpv3nd4Zw63XZiUexSkVffKnfKnfNPiHK8BREFdYagjuP+HCfG8
	Fs7M5a+/Tp7IfPSzhA9YEJhWhsTrht3laKKo0B7XOF19rm78vU8n1vdnKfFB6wdSf00F4/
	OEfqq7Ghbb/nFH9583p0BIjeomTCRIc=
Date: Sat, 19 Aug 2023 20:47:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 03/15] bpf: Add alloc/xchg/direct_access support
 for local percpu kptr
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172825.1363378-1-yonghong.song@linux.dev>
 <20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230819002907.io3iphmnuk43xblu@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 5:29 PM, Alexei Starovoitov wrote:
> On Mon, Aug 14, 2023 at 10:28:25AM -0700, Yonghong Song wrote:
>> @@ -4997,13 +4997,20 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>>   	if (kptr_field->type == BPF_KPTR_UNREF)
>>   		perm_flags |= PTR_UNTRUSTED;
>>   
>> +	if (kptr_field->type == BPF_KPTR_PERCPU_REF)
>> +		perm_flags |= MEM_PERCPU | MEM_ALLOC;
> 
> this bit doesn't look right and ...
> 
>> +
>>   	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
>>   		goto bad_type;
>>   
>> -	if (!btf_is_kernel(reg->btf)) {
>> +	if (kptr_field->type != BPF_KPTR_PERCPU_REF && !btf_is_kernel(reg->btf)) {
>>   		verbose(env, "R%d must point to kernel BTF\n", regno);
>>   		return -EINVAL;
>>   	}
>> +	if (kptr_field->type == BPF_KPTR_PERCPU_REF && btf_is_kernel(reg->btf)) {
>> +		verbose(env, "R%d must point to prog BTF\n", regno);
>> +		return -EINVAL;
>> +	}
> 
> .. here it really doesn't look right.
> The map_kptr_match_type() should have been used for kptrs pointing to kernel objects only.
> But you're calling it for MEM_ALLOC object with prog's BTF...
> 
>> +	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
>> +		if (meta->func_id != BPF_FUNC_kptr_xchg) {
>> +			verbose(env, "verifier internal error: unimplemented handling of MEM_PERCPU | MEM_ALLOC\n");
>> +			return -EFAULT;
>> +		}
> 
> this part should be handling it, but ...
> 
>> +		if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
>> +			return -EACCES;
> 
> why call this here?
> 
> Existing:
>          case PTR_TO_BTF_ID | MEM_ALLOC:
>                  if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
>                      meta->func_id != BPF_FUNC_kptr_xchg) {
>                          verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
>                          return -EFAULT;
>                  }
> doesn't call map_kptr_match_type().
> Where do we check that btf of arg1 and arg2 matches for kptr_xchg of MEM_ALLOC objs? Do we have a bug?
> 
> Yep. We do :(
> 
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> index 06838083079c..a6f546f4da9a 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> @@ -14,10 +14,12 @@ struct node_data {
>          struct bpf_rb_node node;
>   };
> 
> +struct node_data2 { long foo[4];};
> +
>   struct map_value {
>          struct prog_test_ref_kfunc *not_kptr;
>          struct prog_test_ref_kfunc __kptr *val;
> -       struct node_data __kptr *node;
> +       struct node_data2 __kptr *node;
>   };
> 
>   /* This is necessary so that LLVM generates BTF for node_data struct
> @@ -32,6 +34,7 @@ struct map_value {
>    * Had to do the same w/ bpf_kfunc_call_test_release below
>    */
>   struct node_data *just_here_because_btf_bug;
> +struct node_data2 *just_here_because_btf_bug2;
> 
> passes the verifier and runs into kernel WARN_ONCE.
> 
> Let's fix this issue first before proceeding with this series.

Sounds good. I will investigate and fix this issue before sending
out v2.

