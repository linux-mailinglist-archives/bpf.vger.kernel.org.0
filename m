Return-Path: <bpf+bounces-6152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D228A766244
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2882825CA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA528EF;
	Fri, 28 Jul 2023 03:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88D185E
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:04:09 +0000 (UTC)
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC581BD1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 20:03:40 -0700 (PDT)
Message-ID: <84b63263-8dca-4e74-d440-a21c4c17da91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690513418; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYTK13fV1KUGxYcbJ0bZgtnTHr57OWZGAPHO6A1BCj0=;
	b=ZKlOY7luP48MjBbg0luooHRNs9QXdJUlY+Py56nI4ibKdOv6salEIRPQyfBa5IysfBt92w
	ff2EOo5MfL9kuVABGffF02NSnZ0mJg1xk8nk7lP2C7hhCkoHlsJKdTQ9rjqo2HLMo3CU/L
	IrBHInLa5FsslBWdcdQm3BWJQ/Dlzac=
Date: Thu, 27 Jul 2023 20:03:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Timofei Pushkin <pushkin.td@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
 <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
 <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
 <8dd70c47d4f395ad5dd3b1da9e77221125eb9146.camel@gmail.com>
 <4067a5cebe3df5b5cf436b27479a7c9a065d69a0.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4067a5cebe3df5b5cf436b27479a7c9a065d69a0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/26/23 4:39 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-26 at 23:03 +0300, Eduard Zingerman wrote:
> [...]
>>>> It looks like `PT_REGS_IP_CORE` macro should not be defined through
>>>> bpf_probe_read_kernel(). I'll dig through commit history tomorrow to
>>>> understand why is it defined like that now.
>>>>   help
>>>
>>> If I recall the rationale was to allow the macros to work for both
>>> BPF programs that can do direct dereference (fentry, fexit, tp_btf etc)
>>> and for kprobe-style that need to use bpf_probe_read_kernel().
>>> Not sure if it would be worth having variants that are purely
>>> dereference-based, since we can just use PT_REGS_IP() due to
>>> the __builtin_preserve_access_index attributes applied in vmlinux.h.
>>
>> Sorry, need a bit more time, thanks for the context.
> 
> The PT_REGS_*_CORE macros were added by Andrii Nakryiko in [1].
> Stated intent there is to use those macros for raw tracepoint
> programs. Such programs have `struct pt_regs` as a parameter.
> Contexts of type `struct pt_regs` are *not* subject to rewrite by
> convert_ctx_access(), so it is valid to use PT_REGS_*_CORE for such
> programs.
> 
> However, `struct pt_regs` is also a part of `struct
> bpf_perf_event_data`. Latter is used as a context parameter for
> "perf_event" programs and is a subject to rewrite by
> convert_ctx_access(). Thus, PT_REGS_*_CORE macros can't be used for
> such programs (because these macro are implemented through
> bpf_probe_read_kernel() of which convert_ctx_access() is not aware).
> 
> If `struct pt_regs` is defined with `preserve_access_index` attribute
> CO-RE relocations are generated for both PT_REGS_IP_CORE and
> PT_REGS_IP invocations. So, there is no real need to use *_CORE
> variants in combination with `struct bpf_perf_event_data` to have all
> CO-RE benefits, e.g.:
> 
>    $ cat bpf.c
>    #include "vmlinux.h"
>    // ...
>    SEC("perf_event")
>    int do_test(struct bpf_perf_event_data *ctx) {
>      return PT_REGS_IP(&ctx->regs);
>    }
>    // ...
>    $ llvm-objdump --no-show-raw-insn -rd bpf.o
>    ...
>    0000000000000000 <do_test>:
>           0: r0 = *(u64 *)(r1 + 0x80)
>              0000000000000000:  CO-RE <byte_off> [11] struct bpf_perf_event_data::regs.ip (0:0:16)
>           1: exit
> 
> [1] b8ebce86ffe6 ("libbpf: Provide CO-RE variants of PT_REGS macros")
> 
> ---
> 
> I think the following should be done:
> - Timofei's code should use PT_REGS_IP and make sure that `struct
>    pt_regs` has preserve_access_index annotation (e.g. use vmlinux.h);
> - verifier should be adjusted to report error when
>    bpf_probe_read_kernel() (and similar) are used to read from "fake"
>    contexts.

The func prototype of bpf_probe_read_kernel() is

BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
            const void *, unsafe_ptr)
{
         return bpf_probe_read_kernel_common(dst, size, unsafe_ptr);
}

Notice the argument name is 'unsafe_ptr'. So there is no checking
in verifier for this argument. Some users may take advantage of this
to initialize the 'dst' with 0 by providing an illegal address.


> - (maybe?) update PT_REGS_*_CORE to use `__builtin_preserve_access_index`
>    (to allow usage with `bpf_perf_event_data` context).
> 
> [...]
> 

