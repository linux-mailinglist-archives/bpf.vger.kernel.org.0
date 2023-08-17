Return-Path: <bpf+bounces-7981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE877F986
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767E1281F9E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713241428A;
	Thu, 17 Aug 2023 14:45:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E1134BD
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 14:45:35 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB330E5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 07:45:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-318015ade49so6883526f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1692283524; x=1692888324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkGrMKame+hCoidswsD8X7nx7MG416MhB7l+Xl/0OGA=;
        b=PK/dL7riptzY9V7e7xDyzfca2Du2t/T4guLBZFEe7DxOiKpGU/woOFka0MiigagOA8
         hhLAbWcPuk0wY9mN/GfwQZZs/s54wynG6G8eEPwGVD0hlVlmyZJVkg24yZ4ACJohL3C4
         rOik7pVl3dTq2hGlatHTdjbhbKcAVOrVzfK1sC45z5FIl5+eAfv7cBVYjTQ+gtvnzEfT
         aa+bvmciy0JMrnS1pjLLJQLb3t4XpeG4NjhYcY3JstboucBfwEGQ/y/ks/MN8cRbX/hM
         9AcK5AtGAQzSBjgRbsbvnyHsuKd7bIuxfiYjfpXq8Nas1iKPWTM3ddn8kTONYRdfmVRq
         ukyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283524; x=1692888324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkGrMKame+hCoidswsD8X7nx7MG416MhB7l+Xl/0OGA=;
        b=JQ/VHH879ea0BW21CGuWqWN3mBZaQyjXdBkdAFPhPkJZmlEIkk6RezuXxvIVW9vkep
         P0NeGTHP1iWgXreJCE1Tcnwm2i17jgevGhlyqLjkty8+LVXPM1MYxd6ew4PaGqAiH415
         tzIf/Rlikdi6msslL8g+BnLn1m7b9Q8Go+9AoLqZvnKjWiHJyvU8CdT/dOj2aCsPhlKS
         PDKh/ABqUlH5MGHlStCi/t/ag9/43XaWNCCoDOvFQPH3nGirNAUCCIGbtjarT4S2v+69
         O7zGcxYg+FpLlVWnYa9hmMcURqSMKyQo7reOLeAobo0q5BnBIUysIdQFyzEzUgi8lfhi
         ceuQ==
X-Gm-Message-State: AOJu0YxyNd7iPRSX9QYsp9JBEgwuCqxPEzWxry4BxczdUUQ134rdYpux
	R/yat4uTjYUyMxCJPHwx+VKFVA==
X-Google-Smtp-Source: AGHT+IGL0vmFGT21e95QBA6MwvW/iOJ5YIPwapVB2rfEvO7uV1HSUBuQqEtA8kgODv93gksStkAptQ==
X-Received: by 2002:adf:fc8b:0:b0:313:fd52:af37 with SMTP id g11-20020adffc8b000000b00313fd52af37mr4455648wrr.4.1692283523731;
        Thu, 17 Aug 2023 07:45:23 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fbc30825fbsm3184833wmd.39.2023.08.17.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:45:23 -0700 (PDT)
Date: Thu, 17 Aug 2023 14:45:35 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Vernet <void@manifault.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
Message-ID: <ZN4yj/3tSzqMyVyY@zh-lab-node-5>
References: <20230816150634.1162838-1-void@manifault.com>
 <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
 <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
 <20230817040107.GC1295964@maniforge>
 <d49a61ba-10c0-2094-10c9-60a723776f04@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d49a61ba-10c0-2094-10c9-60a723776f04@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 04:35:26PM +0200, Daniel Borkmann wrote:
> On 8/17/23 6:01 AM, David Vernet wrote:
> > On Wed, Aug 16, 2023 at 08:48:16PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Aug 16, 2023 at 8:38 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> > > > On 8/16/23 8:06 AM, David Vernet wrote:
> > > > > We recently got an lkp warning about missing declarations, as in e.g.
> > > > > [0]. This warning is largely redundant with -Wmissing-prototypes, which
> > > > > we already disable for kfuncs that have global linkage and are meant to
> > > > > be exported in BTF, and called from BPF programs. Let's also disable
> > > > > -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
> > > > > reproduce the warning even on W <= 3, so I can't actually be 100% sure
> > > > > this fixes the issue.
> > > > > 
> > > > > [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/
> > > > 
> > > > Okay, I just got a similar email to [0] which complains
> > > >     bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
> > > > missing declarations.
> > > > 
> > > > In the email, the used compiler is
> > > > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > > > 
> > > > Unfortunately, I did not have gcc-7 to verify this.
> > > > Also, what is the minimum gcc version kernel supports? 5.1?
> > > 
> > > pahole and BTF might be broken in such old GCC too.
> > > Maybe we should add:
> > > config BPF_SYSCALL
> > >          depends on GCC_VERSION >= 90000 || CLANG_VERSION >= 130000
> > 
> > It seems prudent to formally declare minimum compiler versions. Though
> > modern gcc and clang also support -Wmissing-declarations, so maybe we
> > should merge this patch regardless? Just unfortunate to have to add even
> > more boilerplate just to get the compiler off our backs.
> 
> Urgh, to restrict BPF syscall with such `depends on` would be super ugly. Why
> can't we just move this boilerplate behind a macro instead of copying this
> everywhere? For example the below on top of your patch builds just fine on my
> side:
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index df64cc642074..6a873a652001 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -83,6 +83,16 @@
>   */
>  #define __bpf_kfunc __used noinline
> 
> +#define __bpf_kfunc_start	\
> +	__diag_push();	\
> +	__diag_ignore_all("-Wmissing-prototypes",	\
> +			  "Global functions as their definitions will be in vmlinux BTF");	\
> +	__diag_ignore_all("-Wmissing-declarations",	\
> +			  "Global functions as their definitions will be in vmlinux BTF");
> +

This will not solve the robot's compain, as it fails on gcc7. The
__diag_ignore_all for gcc is defined as

    #if GCC_VERSION >= 80000
    #define __diag_GCC_8(s)         __diag(s)
    #else
    #define __diag_GCC_8(s)
    #endif

    #define __diag_ignore_all(option, comment) \
            __diag_GCC(8, ignore, option)

so adding more __diag_ignore_all's will not do anything.  This is better to
patch __diag_ignore_all to include older gcc versions if anybody needs them.

> +#define __bpf_kfunc_end	\
> +	__diag_pop();
> +
>  /*
>   * Return the name of the passed struct, if exists, or halt the build if for
>   * example the structure gets renamed. In this way, developers have to revisit
> diff --git a/net/core/filter.c b/net/core/filter.c
> index c2b32b94c6bd..08dd0dd710dd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11724,11 +11724,7 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>  	return func;
>  }
> 
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -		  "Global functions as their definitions will be in vmlinux BTF");
> -__diag_ignore_all("-Wmissing-declarations",
> -		  "Global functions as their definitions will be in vmlinux BTF");
> +__bpf_kfunc_start
>  __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
>  				    struct bpf_dynptr_kern *ptr__uninit)
>  {
> @@ -11754,7 +11750,7 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
> 
>  	return 0;
>  }
> -__diag_pop();
> +__bpf_kfunc_end
> 
>  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
>  			       struct bpf_dynptr_kern *ptr__uninit)
> 
> Thanks,
> Daniel

