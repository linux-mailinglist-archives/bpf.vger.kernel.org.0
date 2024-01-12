Return-Path: <bpf+bounces-19389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12B82B896
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6224E1F25F34
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89403657;
	Fri, 12 Jan 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJeHVu6s"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86906A57
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66913891-84ec-449a-9590-bd8e4dc1de95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705019415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiWysPkBri8Ct0ozDGDV3jxYPANNJnSRGwkVBw2sH7A=;
	b=JJeHVu6sjpXpg+uTYHfAz3fC05v69bQ1smJb4NGesA5dZCcvZV01TQUfm0S4RPoWgjATVv
	2Jp6XPxgIH2HEeRaOq2MwnqQ/RY+PDQUJNHVTcH6gwlG3uqfDX3a7TL2utZoBayz15nxU2
	OINsiUYHayY4GBuMCoMxSi56bE7WNWw=
Date: Thu, 11 Jan 2024 16:30:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240110221750.798813-1-thinker.li@gmail.com>
 <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
 <0dd5949b-b6f8-4d88-88ba-cc079096ce32@gmail.com>
 <5d3f90bc-2758-43a4-bf13-45dc50301758@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5d3f90bc-2758-43a4-bf13-45dc50301758@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/11/24 11:08 AM, Martin KaFai Lau wrote:
> On 1/10/24 5:50 PM, Kui-Feng Lee wrote:
>>
>>
>> On 1/10/24 15:44, Martin KaFai Lau wrote:
>>> On 1/10/24 2:17 PM, thinker.li@gmail.com wrote:
>>>> The proposed solution here is to add PTR_MAYBE_NULL annotations to
>>>> arguments
>>>
>>> [ ... ]
>>>
>>>> == Future Work ==
>>>>
>>>> We require an improved method for annotating arguments. Initially, we
>>>> anticipated annotating arguments by appending a suffix to argument 
>>>> names,
>>>> such as arg1__maybe_null. However, this approach does not function for
>>>> function pointers due to compiler limitations. Nevertheless, it 
>>>> does work
>>>> for functions. To resolve this, we need compiler support to enable the
>>>> inclusion of argument names in the DWARF for function pointer types.
>>>
>>> After reading the high level of the patch,
>>> while it needs compiler work to support decl tagging (or arg name) 
>>> in a struct_ops's func_proto, changing the info->reg_type of a 
>>> struct_ops's argument have been doable in the ".is_valid_access" 
>>> without new kernel code change in verifier/btf.c.
>>
>> btf_ctx_access() mentioned in the original message is a help function
>> called by the implementation of .is_valid_access. So, just like you
>> said, they definitely can be handled by .is_valid_access it-self.
>>
>> Do you prefer to let developers to handle it by themself instead of
>> handling by the helpers?
>
> I would prefer one way to do the same thing. ".is_valid_access" should 
> be more flexible and straightforward. e.g. 
> "bpf_tcp_ca_is_valid_access" can promote all "struct sock" pointers to 
> "struct tcp_sock" without needing to specify them func by func.
>
> It would be nice to eventually have both compilers support tagging in 
> the struct_ops's func_proto. I was trying to say ".is_valid_access" 
> can already add PTR_MAYBE_NULL now while waiting for the compiler 
> support.

Considering gcc side does not support decl tag yet, after discussing with Alexei, we think we
should delay to implement this func proto argument name/decl_tag in dwarf thing since we
need to hack with gcc compiler. Adding PTR_MAYBE_NULL in the kernel should be good enough.
Note that similarly, a lot of bpf_iter already adopts the same approach.

For example, map_iter.c, we have
   static const struct bpf_iter_reg bpf_map_elem_reg_info = {
         .target                 = "bpf_map_elem",
         .attach_target          = bpf_iter_attach_map,
         .detach_target          = bpf_iter_detach_map,
         .show_fdinfo            = bpf_iter_map_show_fdinfo,
         .fill_link_info         = bpf_iter_map_fill_link_info,
         .ctx_arg_info_size      = 2,
         .ctx_arg_info           = {
                 { offsetof(struct bpf_iter__bpf_map_elem, key),
                   PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
                 { offsetof(struct bpf_iter__bpf_map_elem, value),
                   PTR_TO_BUF | PTR_MAYBE_NULL },
         },
   };

Or cgroup_iter.c
   static struct bpf_iter_reg bpf_cgroup_reg_info = {
         .target                 = "cgroup",
         .feature                = BPF_ITER_RESCHED,
         .attach_target          = bpf_iter_attach_cgroup,
         .detach_target          = bpf_iter_detach_cgroup,
         .show_fdinfo            = bpf_iter_cgroup_show_fdinfo,
         .fill_link_info         = bpf_iter_cgroup_fill_link_info,
         .ctx_arg_info_size      = 1,
         .ctx_arg_info           = {
                 { offsetof(struct bpf_iter__cgroup, cgroup),
                   PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
         },
         .seq_info               = &cgroup_iter_seq_info,
   };

Eventually types in the above ctx_arg_info are assigned to
reg type and used by the verifier.

Martin proposed change in is_valid_access() callback can also
get modified register type. It should work well.

Although lacking of kernel maybe_null decl, we could still
verify based on program BTF. Martin told me that
current struct_ops func parameter validation does not
check prog BTF. But if we truely want to verify,
we can check program BTF as well to check whether
the corresponding decl tag exists or not.
For example, in tools/lib/bpf/bpf_helpers.h, we have
#define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))

we can introduce
#define __arg_maybe_null __attribute((btf_decl_tag("arg:maybe_null")))

and the kernel can check bpf program argument decl tag
to ensure its has __arg_maybe_null to be consistent
with kernel PTR_MAYBE_NULL marking.

>
> If the sched_ext adds PTR_MAYBE_NULL in its ".is_valid_access", what 
> else is missing in the verifier.c and btf.c? I saw the patch has the 
> following changes in verifier.c. Is it needed?
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 60f08f468399..190735f3eaf5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8200,6 +8200,7 @@ static int check_reg_type(struct 
> bpf_verifier_env *env, u32 regno,
> >       case PTR_TO_BTF_ID | PTR_TRUSTED:
> >       case PTR_TO_BTF_ID | MEM_RCU:
> >       case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
> > +    case PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_TRUSTED:
> >       case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
> >       {
> >           /* For bpf_sk_release, it needs to match against first member
>

