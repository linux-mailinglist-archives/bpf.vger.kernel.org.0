Return-Path: <bpf+bounces-8128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40F781C48
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 05:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776DA1C2087E
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D557EC6;
	Sun, 20 Aug 2023 03:51:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE0A5A
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 03:51:11 +0000 (UTC)
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8675BAA
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 20:46:48 -0700 (PDT)
Message-ID: <2cc81a2f-4e71-c2cb-1a69-c0e5badea8ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692503206; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QlAIVYufvfpr1fozG5R8oBD9iYt1jNp0NRpc/Wf0t4=;
	b=J9QBlEqgctk1s+CBaxf9jTAHQBnHYdpsr6qf3JKRm5BowGU7zbMXSy7XukW2MvhbVB3OFM
	4JzMJFitI+A1srCARa8KvmLELFl3o4haOa0F/LMiV+wh5Dej7hjM4i+HKtQ6gspC6lCH+D
	NGyEQuX3kgUWmKO4kla/46CQsyFF4rI=
Date: Sat, 19 Aug 2023 20:46:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 02/15] bpf: Add BPF_KPTR_PERCPU_REF as a field
 type
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Marchevsky <david.marchevsky@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172820.1362751-1-yonghong.song@linux.dev>
 <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
 <20230818232431.oatk3fpeuzzclooo@macbook-pro-8.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230818232431.oatk3fpeuzzclooo@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 4:24 PM, Alexei Starovoitov wrote:
> On Fri, Aug 18, 2023 at 02:37:41PM -0400, David Marchevsky wrote:
>> On 8/14/23 1:28 PM, Yonghong Song wrote:
>>> BPF_KPTR_PERCPU_REF represents a percpu field type like below
>>>
>>>    struct val_t {
>>>      ... fields ...
>>>    };
>>>    struct t {
>>>      ...
>>>      struct val_t __percpu *percpu_data_ptr;
>>>      ...
>>>    };
>>>
>>> where
>>>    #define __percpu __attribute__((btf_type_tag("percpu")))
>>
>> nit: Maybe this should be __percpu_kptr (and similar for the actual tag)?
> 
> +1.
> 
> I think it might conflict with kernel:
> include/linux/compiler_types.h:# define __percpu	BTF_TYPE_TAG(percpu)
> It's the same tag name, but the kernel semantics are different from our kptr
> semantics inside bpf prog.
> I think we have to use a different tag like:
> #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))

Agree. Will use __percpu_kptr in the next revision.

> 
>>> index 60e80e90c37d..e6348fd0a785 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -180,14 +180,15 @@ enum btf_field_type {
>>>   	BPF_TIMER      = (1 << 1),
>>>   	BPF_KPTR_UNREF = (1 << 2),
>>>   	BPF_KPTR_REF   = (1 << 3),
>>> -	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
>>> -	BPF_LIST_HEAD  = (1 << 4),
>>> -	BPF_LIST_NODE  = (1 << 5),
>>> -	BPF_RB_ROOT    = (1 << 6),
>>> -	BPF_RB_NODE    = (1 << 7),
>>> +	BPF_KPTR_PERCPU_REF   = (1 << 4),
> 
> I think _REF is redundant here. _UNREF is obsolete. We might remove it and
> rename BPF_KPTR_REF to just BPF_KPTR.
> BPF_KPTR_PERCPU should be clear enough.

Okay, will use BPF_KPTR_PERCPU in the next revision.

