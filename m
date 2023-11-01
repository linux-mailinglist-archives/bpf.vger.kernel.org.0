Return-Path: <bpf+bounces-13787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B897DDDB8
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 09:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BDF1C20D2B
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A356FBA;
	Wed,  1 Nov 2023 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+EfT11F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07406FAE;
	Wed,  1 Nov 2023 08:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7FEC433C7;
	Wed,  1 Nov 2023 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698827146;
	bh=yFVtjEK6MAAB7vMXEvUnFtsjPel4TJMN6k8Ko8VXdYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+EfT11FBVdWRjAfeYkOnUaRHnTJepVNb5nikvZ26s+2qtK3y703T79U7MvmnrmF2
	 ZlcsraE72qoE3Uy6DpNUBlvnWhtZX21/hweezd934PF0SVpcJlo//becBi2Y03TdSq
	 JNIHPs3PP1SF/ua9iAUYzitWUPRcslT3VuHs3KX2U8tTxgzfFcu13Jd4sWSX56Afmq
	 uXsahwZaUXj7YVmpAd5RSS6SPsAuS0opg3CIJQ3D9tvxEgn9MItedOmQskZd7fLoeg
	 7WaMqGRTfheQriy6+wtkm9I9q28wtTbbBiKNaKR437HxxnejFXD7FXw/bl9vFSXiuU
	 g0XwNSRHsK/9A==
Message-ID: <9aad3bb9-daca-405a-93c3-dccea3c0a07a@kernel.org>
Date: Wed, 1 Nov 2023 09:25:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Content-Language: en-GB, fr-BE
To: Jiri Olsa <olsajiri@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, kernel test robot <lkp@intel.com>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
 <ZUEzzc/Sod8OR28B@krava>
 <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
 <ZUH9cveAsjcUgz9e@krava>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
In-Reply-To: <ZUH9cveAsjcUgz9e@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jirka, Alexei,

On 01/11/2023 08:25, Jiri Olsa wrote:
> On Tue, Oct 31, 2023 at 08:54:56PM -0700, Alexei Starovoitov wrote:
>> On Tue, Oct 31, 2023 at 10:05 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>
>>> On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
>>>> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
>>>> possible to build the kernel without CONFIG_CGROUPS:
>>>>
>>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>>>>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>>>>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>>>>         |              ^~~~~~~~~~~~~~~~~~~
>>>>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
>>>>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>>>>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>>>>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>>>>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>>>>     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>>>>         |                                                            ^~~~~~
>>>>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>>>>     930 |         css_task_iter_start(css, flags, kit->css_it);
>>>>         |         ^~~~~~~~~~~~~~~~~~~
>>>>         |         task_seq_start
>>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>>>>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>>>>     940 |         return css_task_iter_next(kit->css_it);
>>>>         |                ^~~~~~~~~~~~~~~~~~
>>>>         |                class_dev_iter_next
>>>>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
>>>>     940 |         return css_task_iter_next(kit->css_it);
>>>>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>>>>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>>>>     949 |         css_task_iter_end(kit->css_it);
>>>>         |         ^~~~~~~~~~~~~~~~~
>>>>
>>>> This patch simply surrounds with a #ifdef the new code requiring CGroups
>>>> support. It seems enough for the compiler and this is similar to
>>>> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
>>>> been added in kernel/bpf/helpers.c and in the selftests.
>>>>
>>>> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
>>>> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
>>>> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
>>>
>>> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
>>
>> I believe this patch has the same issue as Arnd's patch:
>> https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com/

@Alexei: Arf, sorry, I didn't find this patch when searching for
"9c66dc94b62a" on lore. I don't know why I didn't search for the commit
title as usual...

>> I'd like to merge the fix asap. Please make it a complete fix.
> 
> ugh, it won't fail the build, it just warns.. I think we should
> fail the build in that case, I'll check

@Jirka: Thank you for checking that! Please tell me if you want me to
send a v2 or if you prefer to do that. I don't mind if you prefer to
send your own patches, as long as there is a fix for that at the end :)

Note that if a warning is emitted for these new bpf_iter_css_task_*()
functions, I guess you will have the same issue with bpf_iter_css_*()
and probably others as mentioned in my commit message.

Cheers,
Matt

