Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75BA597801
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbiHQUbm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiHQUbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 16:31:41 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D39DB49;
        Wed, 17 Aug 2022 13:31:39 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOPhL-000F88-8X; Wed, 17 Aug 2022 22:31:31 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOPhK-0009zo-Ty; Wed, 17 Aug 2022 22:31:30 +0200
Subject: Re: [PATCH 1/2] bpf: Fix 32bit bounds update in ALU64
To:     Youlin Li <liulin063@gmail.com>, haoluo@google.com
Cc:     ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9f954e67-67fc-e3b9-d810-22bfea95d2aa@iogearbox.net>
 <20220810100849.25710-1-liulin063@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5d2addca-10e5-f7a6-9efd-43322eec8347@iogearbox.net>
Date:   Wed, 17 Aug 2022 22:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220810100849.25710-1-liulin063@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26630/Wed Aug 17 09:53:39 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/22 12:08 PM, Youlin Li wrote:
> The commit ("bpf: Do more tight ALU bounds tracking") introduces a bug
> that fails some selftests.
> 
> in previous versions of the code, when
> __reg_combine_64_into_32() was called, the 32bit boundary was
> completely deduced from the 64bit boundary, so there was a call to
> __mark_reg32_unbounded() in __reg_combine_64_into_32(). But before
> adjust_scalar_min_max_vals() calls
> __reg_combine_64_into_32() , the 32bit bounds are already calculated
> to some extent, and __mark_reg32_unbounded() will eliminate these
> information.
> 
> Simply remove the call to __reg_combine_64_into_32() and copying a code
> without __mark_reg32_unbounded() should work.
> 
> Before:
>      ./test_verifier 142
>      #142/p bounds check after truncation of non-boundary-crossing range FAIL
>      Failed to load prog 'Permission denied'!
>      invalid access to map value, value_size=8 off=16777215 size=1
>      R0 max value is outside of the allowed memory range
>      verification time 149 usec
>      stack depth 8
>      processed 15 insns (limit 1000000) max_states_per_insn 0
>      total_states 0 peak_states 0 mark_read 0
>      Summary: 0 PASSED, 1 SKIPPED, 1 FAILED
> 
> After:
>      ./test_verifier 142
>      #142/p bounds check after truncation of non-boundary-crossing range OK
>      Summary: 1 PASSED, 1 SKIPPED, 0 FAILED
> 
> Signed-off-by: Youlin Li <liulin063@gmail.com>
> ---
>   kernel/bpf/verifier.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11d8bb54ba6b..7ea6e0372d62 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9014,7 +9014,17 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   		/* ALU32 ops are zero extended into 64bit register */
>   		zext_32_to_64(dst_reg);
>   	} else {
> -		__reg_combine_64_into_32(dst_reg);
> +		if (__reg64_bound_s32(dst_reg->smin_value) &&
> +		    __reg64_bound_s32(dst_reg->smax_value)) {
> +			dst_reg->s32_min_value = (s32)dst_reg->smin_value;
> +			dst_reg->s32_max_value = (s32)dst_reg->smax_value;
> +		}
> +		if (__reg64_bound_u32(dst_reg->umin_value) &&
> +		    __reg64_bound_u32(dst_reg->umax_value)) {
> +			dst_reg->u32_min_value = (u32)dst_reg->umin_value;
> +			dst_reg->u32_max_value = (u32)dst_reg->umax_value;
> +		}
> +		reg_bounds_sync(dst_reg);

Hm, this doesn't apply to the bpf tree. Is this on top of your previous patch [0]?
Please squash both together in that case and resubmit your previous one as a v2.

   [0] https://lore.kernel.org/bpf/9f954e67-67fc-e3b9-d810-22bfea95d2aa@iogearbox.net/

Thanks,
Daniel
