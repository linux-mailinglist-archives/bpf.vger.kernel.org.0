Return-Path: <bpf+bounces-5047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E5754506
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD9C1C21673
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34A17FF6;
	Fri, 14 Jul 2023 22:39:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B84C9E
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 22:39:33 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BF30DC
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:39:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686ef86110so1689343b3a.2
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689374371; x=1691966371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqVnzCCBt+Qlps2QX2NUtvUnNe9+zP7VD7quHijYcgM=;
        b=DQXpCh6Lcn1U0hRXTqMpDoWt2p0YKKDDnxjnY59tlTJHLAd1sBczurUcmaD0XC7bUK
         tfWsmVCcBcGCtlHu8ExLiOMsnZNioUo9SfT+kmzGdQgcwdtCUOfLJTS/+5VxOkvMi9MU
         VaSloWssPYpK1fpycOthZzUywliK15LCXd1iYgrtbEsDxpc26M8nsEXW3XAclWtkQkuL
         inAF5KMUqXMEWpki3SDlNJMi0lfOTl5z2mpUqHOqBz6p26uFS1+4DFeGxC6r/vlrtyvU
         f5JncsTPE9YUiv3o3de9XbPHTj4ZfgyqfjfClyrA1sY3WnzJOk7VobFdhuO1G4mySTz3
         sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374371; x=1691966371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqVnzCCBt+Qlps2QX2NUtvUnNe9+zP7VD7quHijYcgM=;
        b=XR0BmImyuiMsTA2S8f3NHKRlbvXJ9meXSkFPfx6uOvk1FGUAfVH6As2o2Q60judsUW
         HtoSbwG7Epq1EkMWMlHQVzK+E9+AJ5xcs1XhhGZRXSLEw9Lr+p0crm1jGeThuZYuH919
         rWO6tsek2Er8g8eqeqdPfFDXOHChqwWM65j8LhsrMTISq9vdmORIA/o7b8+X0WkWlm79
         uuBjNJn3ZEFdVE8Md6t44rt8GRyTvoriDSfdX550HemxRocy1I8pda0FuHG6IttCXDjO
         2wp29Jq6rL48Lo9SSSfTOcdmwnvlWdnFRa21kmV4bBBYJ/G7nK2TPjLun/KumCvzCtmY
         YU1A==
X-Gm-Message-State: ABy/qLZW/hMEhxqyq2ZlwFyGX9iKNSc79KEJJ1c+ZieLdm5fpP4VqubI
	6vzUNyKTeS7j8rJzI5znTTc=
X-Google-Smtp-Source: APBJJlEK6QEjg7xtjKY+3IvR6lAdhiLQz39E68/mGPpi1PNV6QFTghcE6DQc8nIHQBS8Tu2b1xil1w==
X-Received: by 2002:a17:902:c109:b0:1b8:4ede:4a0b with SMTP id 9-20020a170902c10900b001b84ede4a0bmr4367867pli.9.1689374371378;
        Fri, 14 Jul 2023 15:39:31 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b001b9df74ba5asm8224869pll.210.2023.07.14.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:39:30 -0700 (PDT)
Date: Fri, 14 Jul 2023 15:39:29 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 07/10] bpf: Ensure IP is within
 prog->jited_length for bpf_throw calls
Message-ID: <20230714223929.eu2ijg6t3kvgtl6b@MacBook-Pro-8.local>
References: <20230713023232.1411523-1-memxor@gmail.com>
 <20230713023232.1411523-8-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-8-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> Now that we allow exception throwing using bpf_throw kfunc, it can
> appear as the final instruction in a prog. When this happens, and we
> begin to unwind the stack using arch_bpf_stack_walk, the instruction
> pointer (IP) may appear to lie outside the JITed instructions. This
> happens because the return address is the instruction following the
> call, but the bpf_throw never returns to the program, so the JIT
> considers instruction ending at the bpf_throw call as the final JITed
> instruction and end of the jited_length for the program.
> 
> This becomes a problem when we search the IP using is_bpf_text_address
> and bpf_prog_ksym_find, both of which use bpf_ksym_find under the hood,
> and it rightfully considers addr == ksym.end to be outside the program's
> boundaries.
> 
> Insert a dummy 'int3' instruction which will never be hit to bump the
> jited_length and allow us to handle programs with their final
> isntruction being a call to bpf_throw.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
>  include/linux/bpf.h         |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8d97c6a60f9a..052230cc7f50 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1579,6 +1579,17 @@ st:			if (is_imm8(insn->off))
>  			}
>  			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
>  				return -EINVAL;
> +			/* Similar to BPF_EXIT_INSN, call for bpf_throw may be
> +			 * the final instruction in the program. Insert an int3
> +			 * following the call instruction so that we can still
> +			 * detect pc to be part of the bpf_prog in
> +			 * bpf_ksym_find, otherwise when this is the last
> +			 * instruction (as allowed by verifier, similar to exit
> +			 * and jump instructions), pc will be == ksym.end,
> +			 * leading to bpf_throw failing to unwind the stack.
> +			 */
> +			if (func == (u8 *)&bpf_throw)
> +				EMIT1(0xCC); /* int3 */

Probably worth explaining that this happens because bpf_throw is marked
__attribute__((noreturn)) and compiler can emit it last without BPF_EXIT insn.
Meaing the program might not have BPF_EXIT at all.

I wonder though whether this self-inflicted pain is worth it.
May be it shouldn't be marked as noreturn.
What do we gain by marking?

