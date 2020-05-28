Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790911E6CB1
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407227AbgE1UgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407145AbgE1UgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 16:36:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D189C08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:36:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 185so127254pgb.10
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wwfMgkGqip8IwvYYHgTq2AfBUh/yPjJVBktxnBZLSYM=;
        b=ElqWQcMY5fzf3MeIK0WvxUHFxYLhhgOFRLR9usRLDKnRWntdmS3qM/3wWtpyz0Cigi
         EjvxlWWXeq1mZuB49StRpQUCjwBcy8fhlt25rMW+JbhkqTKKWE1g+CvPd70fbaSVYp3o
         cLCCPkwtDSclikblVVd2EZK1NfJcc+IlVIxunfkNvpSJAoTsVwUZNP0Ixp2TtQjM5DJT
         UKRxF2cTl4NewnD8VT7ZMU9ay8D9xwnn8Fcb4keWy0/JgIVwr5ugIYSS5hnRbC5WYR6L
         530OZYaT8Tcr/pcJ/N+kwJjT6ezcgbaSWrjZolS0ejNfqt4harz9CqayzRVF/MTTUxHR
         migQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wwfMgkGqip8IwvYYHgTq2AfBUh/yPjJVBktxnBZLSYM=;
        b=sWStZ1EJAfpETtmCTowNTZk+ZDSq3WKF6Jvg54QMiaEQB1ptjPm5xpw+CuNies1pjX
         0DSEOYVtNELMW0Z/GxIUxnSLhD8UnpYgd6t44S7I7iWOKs25gP4X0M06vZnIlDTD69EE
         VNog/QBFlxbi/ta4cEbzh0q2JxKKvfBKREvVjy4YI08ke7XPbXrriZxCi422rehJ1ypJ
         tqqPV8sXs+ooCReP1NFo3oifwchqwhlDYpODjkGiX9MuXmyXrbLTZtChOtzEtXwWOUls
         xsymf4YruEjnL4ZhRmMR+7KvG1SURD+AFUbAt6LGEs4XeYTZ6awHG3BBJ0i+mvkO/0JL
         RVXw==
X-Gm-Message-State: AOAM531ely0KoC/OWddA0gk+hyxKZMB/WhiJALdEat32mNzlgqMyyhcU
        CyMeOt3wIkiJQJ7v/CBLpvY=
X-Google-Smtp-Source: ABdhPJw+sIyXMzFTbn6uFP1RJSlPp8+rxpkSNouKz4NGJxRipamubq/9gWea/JcVtIa/7ixLXfDIeg==
X-Received: by 2002:a63:fa12:: with SMTP id y18mr4623155pgh.84.1590698181726;
        Thu, 28 May 2020 13:36:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4a1c])
        by smtp.gmail.com with ESMTPSA id q25sm5283344pfh.94.2020.05.28.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:36:20 -0700 (PDT)
Date:   Thu, 28 May 2020 13:36:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix a verifier issue when assigning 32bit
 reg states to 64bit ones
Message-ID: <20200528203618.gsk6utptz5gls2di@ast-mbp.dhcp.thefacebook.com>
References: <20200528165043.1568623-1-yhs@fb.com>
 <20200528165043.1568695-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528165043.1568695-1-yhs@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 09:50:43AM -0700, Yonghong Song wrote:
> With the latest trunk llvm (llvm 11), I hit a verifier issue for
> test_prog subtest test_verif_scale1.
> 
> The following simplified example illustrate the issue:
>     w9 = 0  /* R9_w=inv0 */
>     r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>     r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>     ......
>     w2 = w9 /* R2_w=inv0 */
>     r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r6 += r2 /* R6_w=inv(id=0) */
>     r3 = r6 /* R3_w=inv(id=0) */
>     r3 += 14 /* R3_w=inv(id=0) */
>     if r3 > r8 goto end
>     r5 = *(u32 *)(r6 + 0) /* R6_w=inv(id=0) */
>        <== error here: R6 invalid mem access 'inv'
>     ...
>   end:
> 
> In real test_verif_scale1 code, "w9 = 0" and "w2 = w9" are in
> different basic blocks.
> 
> In the above, after "r6 += r2", r6 becomes a scalar, which eventually
> caused the memory access error. The correct register state should be
> a pkt pointer.
> 
> The inprecise register state starts at "w2 = w9".
> The 32bit register w9 is 0, in __reg_assign_32_into_64(),
> the 64bit reg->smax_value is assigned to be U32_MAX.
> The 64bit reg->smin_value is 0 and the 64bit register
> itself remains constant based on reg->var_off.
> 
> In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
> smin_val must be equal to smax_val. Since they are not equal,
> the verifier decides r6 is a unknown scalar, which caused later failure.
> 
> The llvm10 does not have this issue as it generates different code:
>     w9 = 0  /* R9_w=inv0 */
>     r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>     r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>     ......
>     r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r6 += r9 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r3 = r6 /* R3_w=pkt(id=0,off=0,r=0,imm=0) */
>     r3 += 14 /* R3_w=pkt(id=0,off=14,r=0,imm=0) */
>     if r3 > r8 goto end
>     ...
> 
> To fix the issue, if 32bit register is a const 0,
> then just assign max vaue 0 to 64bit register smax_value as well.
> 
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8d7ee40e2748..5123ce54695f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1174,6 +1174,9 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>  		reg->smin_value = 0;
>  	if (reg->s32_max_value > 0)
>  		reg->smax_value = reg->s32_max_value;
> +	else if (reg->s32_max_value == 0 && reg->s32_min_value == 0 &&
> +		 tnum_is_const(reg->var_off))
> +		reg->smax_value = 0; /* const 0 */
>  	else
>  		reg->smax_value = U32_MAX;

wouldn't this be a more general fix ?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c7d3634151..83450d5d24ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1217,11 +1217,11 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
         * but must be positive otherwise set to worse case bounds
         * and refine later from tnum.
         */
-       if (reg->s32_min_value > 0)
+       if (reg->s32_min_value >= 0)
                reg->smin_value = reg->s32_min_value;
        else
                reg->smin_value = 0;
-       if (reg->s32_max_value > 0)
+       if (reg->s32_max_value >= 0)
                reg->smax_value = reg->s32_max_value;
        else
                reg->smax_value = U32_MAX;
