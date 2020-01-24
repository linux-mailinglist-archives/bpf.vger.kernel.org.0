Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B741E147711
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 04:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgAXDGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 22:06:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42815 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbgAXDGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 22:06:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so259793pgb.9
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=g93JSk6IypPNZz8Djm23mdPQGcTkT9fWce84jIWBUaY=;
        b=LsYDMbaMSvtHm9AdjQ9JQcMCuXQNQKMLxYNoA/V1h8zdLbmRVCQfWNlV8Sbtf271Sw
         w/LvxWsd629uu/z8NrLLxAcdr7QOrfTCwDKjPWcYjjTD1tAOc4SiCsbbQIMkEDjTgdPM
         fmDnG+1Ss5tXa4k/p4Qn2KGkqsmHPVXK4f2FD5O/kUCrtq1L6Inz3dWkYXBfxt2XjQ1o
         ZGw1Q/dahM37mEzm7jLIJgZb7ONv5eAz0+oxYZOoOtGS6GBBV1I3Ptw9a4rRruLhCZiB
         x0BNHZ9YhYnDYa45vXU2MKW8RzylD4zgDMF37aan+Rw7PZ1AH/4Ied9QDHsRITs4J6kO
         V5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=g93JSk6IypPNZz8Djm23mdPQGcTkT9fWce84jIWBUaY=;
        b=F0Gbb/EJvWF6j4w58ghVdVFH02q/uw0q2/DYdQjS2C5OYA9Dkam3jxc9dFmY5uyK+w
         KegZ1wtTkHK8l+0tLqerAZMWTCGPj0guNKVc3TKvfnoMrKix9OAoOWdh0YAMOAmIrNMj
         4SvrOPY81Pp7y3PxfV6xzkmHqhsPQdBos32omAxuku2vSPXQ0HxHbsGrBTyAX/87ZOlt
         0NtfDTtSJUOXKeQgl8yKc22eKSCsx0SHtRTgLHbb6kccHOX7RC8ib+O3hn5LGAeQFWys
         XMlQ4S5ZtF3ccGnGd7ywJ4rcnwSOJ6FLB0CdwlcUvYLiYV1ldQfYvHiQSowtwXFuk+WI
         ETsA==
X-Gm-Message-State: APjAAAWWdUu8fRlcAzgUbW4XBJh6FydF1wfpoRXqaUBZUVDhph1cijXa
        fg+Zo3qTuU5eD+KteRo4uYM=
X-Google-Smtp-Source: APXvYqwqL1SS6CLtzJvtWK2aq3o3Q2iY57JSqai7mpVQcI79KNlYnqaqY9f0cCabWoQakJP03YkYOg==
X-Received: by 2002:a63:cf08:: with SMTP id j8mr1683407pgg.292.1579835192866;
        Thu, 23 Jan 2020 19:06:32 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id z5sm4429975pfq.3.2020.01.23.19.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 19:06:32 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:06:24 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Message-ID: <5e2a5f30b9e8e_2162aec864c25b448@john-XPS-13-9370.notmuch>
In-Reply-To: <20200123191815.1364372-1-yhs@fb.com>
References: <20200123191815.1364298-1-yhs@fb.com>
 <20200123191815.1364372-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next 1/2] bpf: improve verifier handling for 32bit
 signed compare operations
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Commit b7a0d65d80a0 ("bpf, testing: Workaround a verifier failure
> for test_progs") worked around a verifier failure where the
> register is copied to another later refined register, but the
> original register is used after refinement. Another similar example is
>   https://lore.kernel.org/netdev/871019a0-71f8-c26d-0ae8-c7fd8c8867fc@fb.com/
> 
> LLVM commit https://reviews.llvm.org/D72787 added a phase

FWIW I was going to try and see if we could refine the bounds by
walking parents chain. But that is an experiment tbd.

> to adjust optimization such that the original register is
> directly refined and used later. Another issue exposed by
> the llvm is verifier cannot handle the following code:
>   call bpf_strtoul
>   if w0 s< 1 then ...
>   if w0 s> 7 then ...
>   ... use w0 ...
> 
> Unfortunately, the verifier is not able to handle the above
> code well and will reject it.
>   call bpf_strtoul
>     R0_w=inv(id=0) R8=invP0
>   if w0 s< 0x1 goto pc-22
>     R0_w=inv(id=0) R8=invP0
>   if w0 s> 0x7 goto pc-23
>     R0=inv(id=0) R8=invP0
>   w0 += w8
>     R0_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R8=invP0
> 
> After "w0 += w8", we got a very conservative R0 value, which
> later on caused verifier rejection.
> 
> This patch added two register states, s32_min_value and s32_max_value,
> to bpf_reg_state. These two states capture the signed 32bit
> min/max values refined due to 32bit signed sle/slt/sge/sgt comparisons.
>   1. whenever refined s32_min_value, s32_max_value is captured, reg->var_off
>      will be refined if possible.
>   2. For any ALU32 operation where the dst_reg will have upper 32bit cleared,
>      if s32_min_value >= 0 and s32_max_value has been narrowed due to previous
>      signed compare operation, the dst_reg as an input can ignore upper 32bit values,
>      this may produce better output dst_reg value range.

Can you comment a bit more on the s32_min_value < 0 case? Regardless of the
s32_{min|max}_value the result should be zero extended and smin_value=0. This
is enforced by verifier_zext(), an aside but I think we should just remove
verifier_zext its not very useful if all jits have to comply imo.

If smin_value=0 && s32_max_value>=0 then we should be safe to propagate s32_max_value
into smax_Value as well.

>   3. s32_min_value and s32_max_value is reset if the corresponding register
>      is redefined.
> 
> The following shows the new register states for the above example.
>   call bpf_strtoul
>     R0_w=inv(id=0) R8=invP0
>   if w0 s< 0x1 goto pc-22
>     R0_w=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,
>              s32_min_value=1,var_off=(0x0; 0xffffffff7fffffff))
>     R8=invP0
>   if w0 s> 0x7 goto pc-23
>     R0=inv(id=0,smax_value=9223372032559808519,umax_value=18446744069414584327,
>            s32_min_value=1,s32_max_value=7,var_off=(0x0; 0xffffffff00000007))
>     R8=invP0
>   w0 += w8
>     R0_w=inv(id=0,umax_value=7,var_off=(0x0; 0x7)) R8=invP0

And we should also have smin_value=0?

> 
> With the above LLVM patch and this commit, the original
> workaround in Commit b7a0d65d80a0 is not needed any more.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/verifier.c        | 73 +++++++++++++++++++++++++++++++-----
>  2 files changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5406e6e96585..d5694308466d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -123,6 +123,8 @@ struct bpf_reg_state {
>  	s64 smax_value; /* maximum possible (s64)value */
>  	u64 umin_value; /* minimum possible (u64)value */
>  	u64 umax_value; /* maximum possible (u64)value */
> +	s32 s32_min_value; /* minimum possible (s32)value */
> +	s32 s32_max_value; /* maximum possible (s32)value */
>  	/* parentage chain for liveness checking */
>  	struct bpf_reg_state *parent;
>  	/* Inside the callee two registers can be both PTR_TO_STACK like
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1cc945daa9c8..c5d6835c38db 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -543,6 +543,14 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>  				if (reg->umax_value != U64_MAX)
>  					verbose(env, ",umax_value=%llu",
>  						(unsigned long long)reg->umax_value);
> +				if (reg->s32_min_value != reg->umin_value &&
> +				    reg->s32_min_value != S32_MIN)
> +					verbose(env, ",s32_min_value=%d",
> +						(int)reg->s32_min_value);
> +				if (reg->s32_max_value != reg->umax_value &&
> +				    reg->s32_max_value != S32_MAX)
> +					verbose(env, ",s32_max_value=%d",
> +						(int)reg->s32_max_value);
>  				if (!tnum_is_unknown(reg->var_off)) {
>  					char tn_buf[48];
>  
> @@ -923,6 +931,10 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  	reg->smax_value = (s64)imm;
>  	reg->umin_value = imm;
>  	reg->umax_value = imm;
> +
> +	/* no need to be precise, just reset s32_{min,max}_value */
> +	reg->s32_min_value = S32_MIN;
> +	reg->s32_max_value = S32_MAX;

If its known it would make more sense to me to set the min/max value vs this
shortcut. Otherwise we wont have bounds to compare against on a JMP32.

>  }

Still thinking through the rest, but figured it would be worth kicking the
couple comments above out.. I'm trying to understand if the coerce_reg_size()
can be made a bit cleaner.

Thanks,
John
