Return-Path: <bpf+bounces-8327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8F784DB4
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66322811EE
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACF19A;
	Wed, 23 Aug 2023 00:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224B7E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:11:23 +0000 (UTC)
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [IPv6:2001:41d0:203:375::15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA7CFE
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:11:22 -0700 (PDT)
Message-ID: <66c62a37-cb64-f59f-9faf-bd9d5c425b99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692749480; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkH1z8rONKwGkSuu4kF6/uVz3cGIT+rTMXDEdlQ2QnE=;
	b=tlHHqBIf5Kp4MgtvAqZb677waHgN2nIF4i1zpxxRo7Onj5tzpHBapXXlyaNT2e3/tyYEvJ
	p6aV932KGLRbs1VaCRn9v/rq2/obLyLr/L0Q/F/WucuZYHezu7+/8XBOgzzVpnJFnpwWdD
	/bnxM/BBdEZksqXdfmxGKubxESj0Bvg=
Date: Tue, 22 Aug 2023 17:11:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>,
 Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Stanislav Fomichev <sdf@google.com>, Nathan Slingerland <slinger@meta.com>
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com>
 <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev>
 <c5470820-6e5d-2755-05f9-f932cacd395f@linux.dev>
 <CAADnVQKffM8=3b_hD0EDM9r-rEwipKGmA2rSz=G_FOXaBUp+6g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKffM8=3b_hD0EDM9r-rEwipKGmA2rSz=G_FOXaBUp+6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/22/23 3:36 PM, Alexei Starovoitov wrote:
> On Tue, Aug 22, 2023 at 1:14 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/22/23 12:19 PM, David Marchevsky wrote:
>>> On 8/22/23 1:42 PM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 8/21/23 10:05 PM, Dave Marchevsky wrote:
>>>>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
>>>>> creation and manipulation of struct bpf_iter_task_vma in open-coded
>>>>> iterator style. BPF programs can use these kfuncs directly or through
>>>>> bpf_for_each macro for natural-looking iteration of all task vmas.
>>>>>
>>>>> The implementation borrows heavily from bpf_find_vma helper's locking -
>>>>> differing only in that it holds the mmap_read lock for all iterations
>>>>> while the helper only executes its provided callback on a maximum of 1
>>>>> vma. Aside from locking, struct vma_iterator and vma_next do all the
>>>>> heavy lifting.
>>>>>
>>>>> The newly-added struct bpf_iter_task_vma has a name collision with a
>>>>> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
>>>>> file is renamed in order to avoid the collision.
>>>>>
>>>>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data, is the
>>>>> only field in struct bpf_iter_task_vma. This is because the inner data
>>>>> struct contains a struct vma_iterator (not ptr), whose size is likely to
>>>>> change under us. If bpf_iter_task_vma_kern contained vma_iterator directly
>>>>> such a change would require change in opaque bpf_iter_task_vma struct's
>>>>> size. So better to allocate vma_iterator using BPF allocator, and since
>>>>> that alloc must already succeed, might as well allocate all iter fields,
>>>>> thereby freezing struct bpf_iter_task_vma size.
>>>>>
>>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>>> Cc: Nathan Slingerland <slinger@meta.com>
>>>>> ---
>>>>>     include/uapi/linux/bpf.h                      |  4 +
>>>>>     kernel/bpf/helpers.c                          |  3 +
>>>>>     kernel/bpf/task_iter.c                        | 84 +++++++++++++++++++
>>>>>     tools/include/uapi/linux/bpf.h                |  4 +
>>>>>     tools/lib/bpf/bpf_helpers.h                   |  8 ++
>>>>>     .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>>>>>     ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>>>>>     7 files changed, 116 insertions(+), 13 deletions(-)
>>>>>     rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
>>>>>
>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>> index 8790b3962e4b..49fc1989a548 100644
>>>>> --- a/include/uapi/linux/bpf.h
>>>>> +++ b/include/uapi/linux/bpf.h
>>>>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>>>>>         __u64 __opaque[1];
>>>>>     } __attribute__((aligned(8)));
>>>>>     +struct bpf_iter_task_vma {
>>>>> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
>>>>> +} __attribute__((aligned(8)));
>>>>
>>>> In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_iter_cgroup_task, etc. They may all use the same struct
>>>> like
>>>>     struct bpf_iter_<...> {
>>>>       __u64 __opaque[1];
>>>>     } __attribute__((aligned(8)));
>>>>
>>>> Maybe we want a generic one instead of having lots of
>>>> structs with the same underline definition? For example,
>>>>     struct bpf_iter_generic
>>>> ?
>>>>
>>>
>>> The bpf_for_each macro assumes a consistent naming scheme for opaque iter struct
>>> and associated kfuncs. Having a 'bpf_iter_generic' shared amongst multiple types
>>> of iters would break the scheme. We could:
>>>
>>>     * Add bpf_for_each_generic that only uses bpf_iter_generic
>>>       * This exposes implementation details in an ugly way, though.
>>>     * Do some macro magic to pick bpf_iter_generic for some types of iters, and
>>>       use consistent naming pattern for others.
>>>       * I'm not sure how to do this with preprocessor
>>>     * Migrate all opaque iter structs to only contain pointer to bpf_mem_alloc'd
>>>       data struct, and use bpf_iter_generic for all of them
>>>       * Probably need to see more iter implementation / usage before making such
>>>         a change
>>>     * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
>>>       * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off some verifier
>>>         logic. Could do similar typedef w/ struct to try to work around
>>>         it.
>>>
>>> Let me know what you think. Personally I considered doing typedef while
>>> implementing this, so that's the alternative I'd choose.
>>
>> Okay, since we have naming convention restriction, typedef probably the
>> best option, something like
>>     typedef struct bpf_iter_num bpf_iter_task_vma
>> ?
>>
>> Verifier might need to be changed if verifier strips all modifiers
>> (including tyypedef) to find the struct name.
> 
> I don't quite see how typedef helps here.
> Say we do:
> struct bpf_iter_task_vma {
>       __u64 __opaque[1];
> } __attribute__((aligned(8)));
> 
> as Dave is proposing.
> Then tomorrow we add another bpf_iter_foo that is exactly the same opaque[1].
> And we will have bpf_iter_num, bpf_iter_task_vma, bpf_iter_foo structs
> with the same layout. So what? Eye sore?
> In case we need to extend task_vma from 1 to 2 it will be easier to do
> when all of them are separate structs.
> 
> And typedef has unknown verification implications.

This is true. Some investigation is needed.

> 
> Either way we need to find a way to move these structs from uapi/bpf.h
> along with bpf_rb_root and friends to some "obviously unstable" header.

If we move this out uapi/bpf.h to an unstable header, we will have much
more flexibility for future change. Original idea (v1) to allocate the
whole struct on the stack would be okay even if kernel changes
struct vma_iterator size, whether bigger or smaller.

