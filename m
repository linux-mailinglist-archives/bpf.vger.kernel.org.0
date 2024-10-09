Return-Path: <bpf+bounces-41358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80A995FD3
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8AF285A61
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001184E18;
	Wed,  9 Oct 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lIzkPqEF"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5641DA5F
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455510; cv=none; b=kwllJ8HEXYeMK9oE8avVIeOcGhFj2bcajLPHfXejsNt7DOGUxUW+is9JO8ov20rIp8gMTN8W8dQNxx1i+RDTxBcvU/RsNVAHTLw/T/7OF1QLV1Nh0TIJQ5uGTj0I5sDDdsDmXZDwSs5NvhNVdmA75bFjh7yYCb/OIPqXhbXbf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455510; c=relaxed/simple;
	bh=kfztGTol3tpwfSDrozx85B0S7Y+yoH1d1HAKh32Ce+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF/MFXqTnUxoeYBCWldc6vLabrw4VIXYR0VgSN0pGlpd4g+ibtcrobFjCDUKjodYAIB2R50xFtJM1M1hBBrj3W5TziRhbg1u8bsd09y1/PI9jAJHCsmNjJcRCa6fVcaho3ehmnXRGx5mEnWh5JhCIydm78YoqWbCBzrc7AgPHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lIzkPqEF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62260dde-9e1d-430a-b350-01c28613b062@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728455506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joGGbGq1SmBM1sum40joifI5FVVKjKe6p3lxY1NRd3w=;
	b=lIzkPqEFG2p8Hlfkaf828dPwqJ4kzdEcwzHL7i8vWyhYdqCUNV5jghP+fzJLQr0+Yr5rz8
	/GJg4mrP5DnuYdfTQdCJA8IMYYJINIyZc32iqEYaru7hWBHfwaK/k65fwqa+2T2gVdRxzl
	8PP8hEJICBxLekMDhdyzsomOkM7tMPY=
Date: Tue, 8 Oct 2024 23:31:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
 <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
 <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
 <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev>
 <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
 <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com>
 <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev>
 <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
 <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/8/24 7:06 PM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 3:10 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> We need to scrap this idea.
>> Let's go back to push/pop r11 around calls :(
> I didn't give up :)
>
> Here is a new idea that seems to work:
>
> [  131.472066]  dump_stack_lvl+0x53/0x70
> [  131.472066]  bpf_task_storage_get+0x3e/0x2f0
> [  131.472066]  ? bpf_task_storage_get+0x231/0x2f0
> [  131.472066]  bpf_prog_ed7a5f33cc9fefab_foo+0x30/0x32
> [  131.472066]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6d
> ...
> [  131.417145]  dump_stack_lvl+0x53/0x70
> [  131.417145]  bpf_task_storage_get+0x3e/0x2f0
> [  131.417145]  ? selinux_netlbl_socket_post_create+0xab/0x150
> [  131.417145]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x60/0x6d
>
>
> The stack dump works fine out of main prog and out of subprog.
>
> The key difference it to pretend to have stack_depth=0,
> so there is no adjustment to %rsp,
> but point %rbp to per-cpu private stack and grow it _up_.
>
> For the main prog %rbp points to the bottom of priv stack
> plus stack_depth it needs,
> so all bpf insns that do r10-off access the bottom of that priv stack.
> When subprog is called it does 'add %rbp, its_stack_depth' and
> in turn it's using memory above the bottom of the priv stack.
>
> That seems to work, but exceptions and tailcalls are broken.
> I ran out of time today to debug.
> Pls see the attached patch.

The core part of the code is below:

EMIT1(0x55); /* push rbp */ - EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp 
*/ + if (tail_call_reachable || !bpf_prog->aux->priv_stack_ptr) { + 
EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */ + } else { + if 
(!is_subprog) { + /* mov rsp, pcpu_priv_stack_bottom */ + void __percpu 
*priv_frame_ptr = + bpf_prog->aux->priv_stack_ptr + 
round_up(stack_depth, 8); + + /* movabs sp, priv_frame_ptr */ + 
emit_mov_imm64(&prog, AUX_REG, (long) priv_frame_ptr >> 32, + (u32) 
(long) priv_frame_ptr); + + /* add <aux_reg>, gs:[<off>] */ + 
EMIT2(0x65, 0x4c); + EMIT3(0x03, 0x1c, 0x25); + EMIT((u32)(unsigned 
long)&this_cpu_off, 4); + /* mov rbp, aux_reg */ + EMIT3(0x4c, 0x89, 
0xdd); + } else { + /* add rbp, stack_depth */ + EMIT3_off32(0x48, 0x81, 
0xC5, round_up(stack_depth, 8)); + } + }

So for main program, we have

push rbp rbp = per_cpu_ptr(priv_stack_ptr + stack_size) ... What will 
happen we have an interrupt like below? push rbp rbp = 
per_cpu_ptr(priv_stack_ptr + stack_size) <=== interrupt happens here ... 
If we need to dump the stack trace at interrupt point then unwinder may 
have difficulty to find the proper stack trace since *rbp is a arbitrary 
value and *(rbp + 8) will not have proper func return address. Does this 
make sense?


