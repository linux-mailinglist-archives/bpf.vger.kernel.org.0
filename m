Return-Path: <bpf+bounces-30037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DAE8CA208
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D01C20C64
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB313848F;
	Mon, 20 May 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kpCXiDf1"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBB137C58
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230140; cv=none; b=ihrKr8pUGKWGeGLY9DHiny6lPHtqMrgtP4NpFXxoJFISsjCtbf5uNmXJY0JgmISeNZQteGIj4gQXNuqmI9zITbu7uL6kgrLqcHw2Avgg88Ru6GhyU+Y642z6P2PtIjsjxZxydfRZfM37VCl1cWVHyrXvZVqImwNGnETPWS5cvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230140; c=relaxed/simple;
	bh=CZfd0uHj/fSaT+o523es1GVIWt8s/YIrxPNksULxcB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVUwx5yFqIlMmzfzE1cEn8s18SxKG447SdrHU8v4ynqNLttRdH1iW9egls/hen9LriubKpdV+3tn0Xs7nPIsnHAxzDk/bgmJN7UzLNI2Y/xBVtuSck9yfJEVhul5G99G1URa3ZosvflXu1Xi/omf5pLxJorhrBsmwkL+1kTAm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kpCXiDf1; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716230136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AZRtRqhknhSZ3ZS1rcgNWIIW9Ai9IIESFeT9SJ4Ma8=;
	b=kpCXiDf1lAAGFPgz+XPU2jPYgJqJ/kM7UldmhRs6myXQ06UaYuRiw35tGJ44KzPNRIiOC8
	McuMSXEGtfRPcSO0y8oQKK8+RUyTBZfUamXg3AXH2+LrYx86Ggbc83DFj2bl8aFcYzUI+T
	JnHIFDykbE3FVB7GNiIsUroQfLponBs=
X-Envelope-To: ivan@cloudflare.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
Message-ID: <10e4b141-b466-46ff-a578-4b1b8ba0d568@linux.dev>
Date: Mon, 20 May 2024 11:35:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpftool does not print full names with LLVM 17 and newer
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
 <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
 <5cb46d34-f4a3-49c7-8dd6-df6bc87b4f25@linux.dev>
 <CAADnVQ+jw2d81J=dJmJ9Y8EReQpOpQ9tvEv6+S4jPASR8Lza5A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+jw2d81J=dJmJ9Y8EReQpOpQ9tvEv6+S4jPASR8Lza5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/20/24 11:21 AM, Alexei Starovoitov wrote:
> On Mon, May 20, 2024 at 10:01 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 5/17/24 5:33 PM, Alexei Starovoitov wrote:
>>> On Fri, May 17, 2024 at 2:51 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>>>> Hello,
>>>>
>>>> We recently bumped LLVM used for bpftool compilation from 15 to 18 and
>>>> our alerting system notified us about some unknown bpf programs. It
>>>> turns out, the names were truncated to 15 chars, whereas before they
>>>> were longer.
>>>>
>>>> After some investigation, I was able to see that the following code:
>>>>
>>>>       diff --git a/src/common.c b/src/common.c
>>>>       index 958e92a..ac38506 100644
>>>>       --- a/src/common.c
>>>>       +++ b/src/common.c
>>>>       @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
>>>> bpf_prog_info *prog_info, int prog_fd,
>>>>           if (!prog_btf)
>>>>               goto copy_name;
>>>>
>>>>       +    printf("[0] finfo.type_id = %x\n", finfo.type_id);
>>>>           func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>>>       +    printf("[1] finfo.type_id = %x\n", finfo.type_id);
>>>>           if (!func_type || !btf_is_func(func_type))
>>>>               goto copy_name;
>>>>
>>>> When ran under gdb, shows:
>>>>
>>>>       (gdb) b common.c:439
>>>>       Breakpoint 1 at 0x16859: file common.c, line 439.
>>>>
>>>>       (gdb) r
>>>>       3403: tracing  [0] finfo.type_id = 0
>>>>
>>>>       Breakpoint 1, get_prog_full_name (prog_info=0x7fffffffe160,
>>>> prog_fd=3, name_buff=0x7fffffffe030 "", buff_len=128) at common.c:439
>>>>       439        func_type = btf__type_by_id(prog_btf, finfo.type_id);
>>>>       (gdb) print finfo
>>>>       $1 = {insn_off = 0, type_id = 1547}
>>>>
>>>>
>>>> Notice that finfo.type_id is printed as zero, but in gdb it is in fact 1547.
>>>>
>>>> Disassembly difference looks like this:
>>>>
>>>>       -    8b 75 cc                 mov    -0x34(%rbp),%esi
>>>>       -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>>>>       +    31 f6                    xor    %esi,%esi
>>>>       +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>>>>
>>>> This can be avoided if one removes "const" during finfo initialization:
>>>>
>>>>       const struct bpf_func_info finfo = {};
>>>>
>>>> This seems like a pretty annoying miscompilation, and hopefully
>>>> there's a way to make clang complain about this loudly, but that's
>>>> outside of my expertise. There might be other places like this that we
>>>> just haven't noticed yet.
>>>>
>>>> I can send a patch to fix this particular issue, but I'm hoping for a
>>>> more comprehensive approach from people who know better.
>>> Wow. Great catch. Please send a patch to fix bpftool and,
>> Indeed, removing 'const' modifier should allow correct code
>> generation.
>>
>>> I agree, llvm should be warning about such footgun,
>>> but the way ptr_to_u64() is written is probably silencing it.
>> Yes, ptr_to_u64() cast a 'ptr to const value' to a __u64
>> which later could be used as 'ptr to value' where the 'value'
>> could be changed.
>>
>>> We probably should drop 'const' from it:
>>> static inline __u64 ptr_to_u64(const void *ptr)
>>>
>>> and maybe add a flavor of ptr_to_u64 with extra check
>>> that the arg doesn't have a const modifier.
>>> __builtin_types_compatible_p(typeof(ptr), void *)
>>> should do the trick.
>> I guess we could introduce ptr_non_const_to_u64() like
>>
>> static inline __u64 ptr_non_const_to_u64(void *ptr)
>> {
>>           static_assert(__builtin_types_compatible_p(typeof(ptr), void *), "expect type void *");
>>           return (__u64)(unsigned long)ptr;
>> }
>>
>> and add additional check in ptr_to_u64() like
>>
>> static inline __u64 ptr_to_u64(const void *ptr)
>> {
>>          static_assert(__builtin_types_compatible_p(typeof(ptr), const void *), "expect type const void *");
>>          return (__u64)(unsigned long)ptr;
>> }
>>
>> But I am not sure how useful they are. If users declare the variable as 'const'
>> and use ptr_to_u64(), compilation will succeed but the result could be wrong.
> I mean to flip the default. Make ptr_to_u64(void *) and
> assert when 'const void *' is passed,
> and introduce const_ptr_to_u64(const void *)
> and use it in a few cases where data is indeed const.
>
> And do the same in libbpf and bpftool.

Okay, this is better. Forcing people to think about
const vs. non-const where in most cases people
will just use ptr_to_u64(void *) flavor.

>
>> Compiler could do the following analysis:
>>     (1) ptr_to_u64() argument is a constant and the result is __u64 (let us say u64_val = ptr_to_u64(...)).
>>     (2) u64_val has address taken and its content may be modified in the current function or
>>         through the function call. If this is true, compiler might warn. This will require some
>>         analysis and the warning may not be always true (esp. it requires inter-procedural analysis and
>>         in this case, bpf_prog_get_info_by_fd() eventually goes into the library/kernel so compiler has no
>>         way to know whether the value could change).
>> So I guess it will be very hard for compiler to warn for this particular case.
> indeed.

