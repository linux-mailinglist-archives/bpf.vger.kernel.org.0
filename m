Return-Path: <bpf+bounces-30053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610EF8CA3CE
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B521E1F2179E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007EB139566;
	Mon, 20 May 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wbDcTEx/"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5521A1C
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240732; cv=none; b=FGTflNb4A0pqrGNQCtSNIqKaKQCJKvaNW8HdSMRWyCP2lNo3Ndsu51A8VVDLlWmmLOb/k8updSLDpTejAWKqKIj5U+lpLgG+u6hUsXsb9rqGLTzoL5TR28Uq5nTUleq5/lxzDqxyWPP7muww6YiznOpLHU7/g5mOP9PjpSoobOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240732; c=relaxed/simple;
	bh=+phe3Dn0kAJsEJKCKqC/u42l/w9QPlrwTCBb5jkGSDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBCp1PAd4U5pg975leOJNG0o0gMkUrhAT3a/1DZQ3O9TKW5IrWdpuGIzlOos3/1cFFvnCPG4lBe57HIXV8b4uVdcf1iydZZNJXE2ORBjxEXf9bWdKCOiiCqJT5WjuhOTB6nIzQf3rBblQaWnb6iUVOKTzPJacUrEn1Ah3kdc+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wbDcTEx/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ivan@cloudflare.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716240725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcY+s6m5RT0WTmqxlbBbw/jl5u8VPujdIzVjdDRst3A=;
	b=wbDcTEx/QcBRXvd2RyiZqCIupe22EhKXZiTSwk75VXq4iqcIwm5rr8LFvEQNBn5SyqjLLf
	iWrQxi/Qe7po8jJKQcMkGy4V/CZS+3VFdXT/AMmk6fA+GzBDbyNZkw+KfPLDpT+ITYpSjy
	+J4c1f21mdCOWD2ikEhS6PcYOB4dE98=
X-Envelope-To: alexei.starovoitov@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
Message-ID: <80b405c5-4bab-4364-ba32-e3f6ab9a5d57@linux.dev>
Date: Mon, 20 May 2024 14:31:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpftool does not print full names with LLVM 17 and newer
Content-Language: en-GB
To: Ivan Babrou <ivan@cloudflare.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
 <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
 <CABWYdi14d61j9=nei6q7YCT8ZLv2DDc1uqmY_f_DimBUAW5MCA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CABWYdi14d61j9=nei6q7YCT8ZLv2DDc1uqmY_f_DimBUAW5MCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/20/24 12:44 PM, Ivan Babrou wrote:
> On Fri, May 17, 2024 at 4:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Fri, May 17, 2024 at 2:51 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>>> Hello,
>>>
>>> We recently bumped LLVM used for bpftool compilation from 15 to 18 and
>>> our alerting system notified us about some unknown bpf programs. It
>>> turns out, the names were truncated to 15 chars, whereas before they
>>> were longer.
>>>
>>> After some investigation, I was able to see that the following code:
>>>
>>>      diff --git a/src/common.c b/src/common.c
>>>      index 958e92a..ac38506 100644
>>>      --- a/src/common.c
>>>      +++ b/src/common.c
>>>      @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
>>> bpf_prog_info *prog_info, int prog_fd,
>>>          if (!prog_btf)
>>>              goto copy_name;
>>>
>>>      +    printf("[0] finfo.type_id = %x\n", finfo.type_id);
>>>          func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>>      +    printf("[1] finfo.type_id = %x\n", finfo.type_id);
>>>          if (!func_type || !btf_is_func(func_type))
>>>              goto copy_name;
>>>
>>> When ran under gdb, shows:
>>>
>>>      (gdb) b common.c:439
>>>      Breakpoint 1 at 0x16859: file common.c, line 439.
>>>
>>>      (gdb) r
>>>      3403: tracing  [0] finfo.type_id = 0
>>>
>>>      Breakpoint 1, get_prog_full_name (prog_info=0x7fffffffe160,
>>> prog_fd=3, name_buff=0x7fffffffe030 "", buff_len=128) at common.c:439
>>>      439        func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>>      (gdb) print finfo
>>>      $1 = {insn_off = 0, type_id = 1547}
>>>
>>>
>>> Notice that finfo.type_id is printed as zero, but in gdb it is in fact 1547.
>>>
>>> Disassembly difference looks like this:
>>>
>>>      -    8b 75 cc                 mov    -0x34(%rbp),%esi
>>>      -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>>>      +    31 f6                    xor    %esi,%esi
>>>      +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>>>
>>> This can be avoided if one removes "const" during finfo initialization:
>>>
>>>      const struct bpf_func_info finfo = {};
>>>
>>> This seems like a pretty annoying miscompilation, and hopefully
>>> there's a way to make clang complain about this loudly, but that's
>>> outside of my expertise. There might be other places like this that we
>>> just haven't noticed yet.
>>>
>>> I can send a patch to fix this particular issue, but I'm hoping for a
>>> more comprehensive approach from people who know better.
>> Wow. Great catch. Please send a patch to fix bpftool and,
>> I agree, llvm should be warning about such footgun,
>> but the way ptr_to_u64() is written is probably silencing it.
>> We probably should drop 'const' from it:
>> static inline __u64 ptr_to_u64(const void *ptr)
>>
>> and maybe add a flavor of ptr_to_u64 with extra check
>> that the arg doesn't have a const modifier.
>> __builtin_types_compatible_p(typeof(ptr), void *)
>> should do the trick.
> In bpftool there's just two call sites that are unhappy if I remove
> "const" in the arguments:
>
> * this problematic one
> * "GPL" literal passed
>
> I'll send the patch to drop "const" from the struct initialization

Yes, this should work as we discussed earlier. Thanks!

> today or tomorrow (it works great in our internal build), but I'll
> leave the bigger change to you. There seem to be many places in libbpf
> and I'm far from being a C expert to drive this change.

As discussed in below link. It is not easy for compiler to deduce whether
an undefined behavior is triggered or not. The additional
const_ptr_to_u64() serves the purpose to force patch author and reviewer
to double check whether the 'u64' value may eventually invalidate
'const' property or not.

>
> I managed to bisect clang to find the commit that introduced the change:
>
> * https://github.com/llvm/llvm-project/commit/0b2d5b967d98
>
> I also mentioned the commit author and they have some ideas about
> UBSAN catching this (it doesn't in the current state):
>
> * https://mastodon.ivan.computer/@mastodon/112465898861074834
>

