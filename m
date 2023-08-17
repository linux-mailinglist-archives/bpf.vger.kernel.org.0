Return-Path: <bpf+bounces-7962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A077F063
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5806281D9C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CAA53;
	Thu, 17 Aug 2023 06:08:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921A395
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 06:08:39 +0000 (UTC)
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618211987
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 23:08:38 -0700 (PDT)
Message-ID: <42d6b829-ab97-2b81-de2c-7551da13f913@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692252516; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy4Xdhm6JP810lhoDVOEnB7UsTV82pmc6PvGVvQdJi4=;
	b=rG343MDNxBNV0uFba6XARJQssvBL3/SgJe/GirlWC/5lOA7PqDglHhz4hOVVvvVntz+xgl
	lx9dTNZdoyR3uVhJPNyzxn4M2i75/SVJtueEFWdTKZ/cufK4uY74CJKdYHqWIhchj1xcLr
	RtVfqe8b3BiOT2kxupCXrVWKZzUTSEA=
Date: Wed, 16 Aug 2023 23:08:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, kernel test robot <lkp@intel.com>
References: <20230816150634.1162838-1-void@manifault.com>
 <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
 <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 8:48 PM, Alexei Starovoitov wrote:
> On Wed, Aug 16, 2023 at 8:38 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/16/23 8:06 AM, David Vernet wrote:
>>> We recently got an lkp warning about missing declarations, as in e.g.
>>> [0]. This warning is largely redundant with -Wmissing-prototypes, which
>>> we already disable for kfuncs that have global linkage and are meant to
>>> be exported in BTF, and called from BPF programs. Let's also disable
>>> -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
>>> reproduce the warning even on W <= 3, so I can't actually be 100% sure
>>> this fixes the issue.
>>>
>>> [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/
>>
>> Okay, I just got a similar email to [0] which complains
>>     bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
>> missing declarations.
>>
>> In the email, the used compiler is
>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>
>> Unfortunately, I did not have gcc-7 to verify this.
>> Also, what is the minimum gcc version kernel supports? 5.1?
> 
> pahole and BTF might be broken in such old GCC too.
> Maybe we should add:
> config BPF_SYSCALL
>          depends on GCC_VERSION >= 90000 || CLANG_VERSION >= 130000

Do you remember what kind of issues pahole/BTF have for
< 9.0 gcc and < 13.0 clang?


