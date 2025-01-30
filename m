Return-Path: <bpf+bounces-50110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CC4A2291B
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 08:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0316505E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAD1A23A0;
	Thu, 30 Jan 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4dKA+LF"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569D188006
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738221887; cv=none; b=LK0Hi0pbwNopHiPb20UnE5R8CchVd8RcCxRBAktCuNUKD0CZdNM+ote+b+d4CJ4YgKb5wQGQ3ZvrsPtmLW6w0nCRf5sE+bgt+y36D1oMAp3k1kVxKgmaGcw90Ki1Xe5jTZTQKWm3qeajU9lne66WgcJHz4wNwE8sE8IOK9ST/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738221887; c=relaxed/simple;
	bh=RI1qLEwnJIdxrbSnQpQ7IO9IGe/kAsFd1iR+h8o+g/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnnNkXmYUyzRn2DdiOX6D/ZAaO1tioogByfFst4nET3awzCvA646Wn3xYxqeBFy8mzKxiX5TsTOZ1knhO3yVtzuQVZW3QNmjhArVkM1MCl5T7SCo0rqCgq+DhzdIQq0Cux/toxH6Ko+cjBen4IE+7L+FCJww2MlikgDT+lL+oIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4dKA+LF; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1ed2a75-1978-4af5-801b-82d5fb911cae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738221879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkB0dL/QKMZ/4G+DweCzS0gfFRwO4K2nqxNpe7CRHFA=;
	b=u4dKA+LFOqzB/8A8rsRNj/CivumjfQ0MF5gIYinJI97+3HpWHua/3ebp/K0+9L1Z2oqj42
	R9B5kZqBqoP4f/LSF+qlsF92EY7nBklkO3Ij1931y6G6K33zWXPIOHRgayZnggadWkvJDX
	ieh935e01ySF6x+TONCQsdqqqYQB3co=
Date: Wed, 29 Jan 2025 23:24:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Uninitialized Variable In BPF Programs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?B?TWFyYyBTdcOxw6k=?= <marc.sune@isovalent.com>
References: <eac5f55f-8aeb-4a6d-9aca-820c5ad4c3a7@linux.dev>
 <CAADnVQKmi0+_=BMLXXyv5YaUrfDoHVb+zW1Ns6mx40wYLH83Zw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKmi0+_=BMLXXyv5YaUrfDoHVb+zW1Ns6mx40wYLH83Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 1/29/25 4:53 PM, Alexei Starovoitov wrote:
> On Tue, Jan 28, 2025 at 1:42 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> If bpf program has an uninitialized variable, clang compiler
>> may take advantage of it to do some optimization. The resulted
>> bpf program may still survive verification but get wrong result.
>> Users then may take quite some time to understand the real
>> reason by inspecting asm codes.
>>
>> The compiler flags '-Wall -Werror' are supposed to issue errors
>> if an uninitialized variable impacts the final result. But in
>> reality, since compiler may not be 100% sure a variable is
>> uninitalized due to limited analysis, the error may not be emitted.
>> gcc has '-Wmaybe-uninitialized' flag to issue warnings for some
>> possible uninit variables but still may miss some others.
>> clang does not support '-Wmaybe-uninitialized' flag.
>>
>> There are already some discussion in llvm community for this ([1]).
>> I would like to elaborate more with some examples, e.g. how llvm
>> internal handle uninit variables, and discuss how we could do
>> something to expose harmful uninit variable earlier.
>>
>>     [1] https://discourse.llvm.org/t/detect-undefined-behavior-due-to-uninitialized-variables-in-bpf-programs/84116?u=yonghong-song
>>
> Compilers maliciously making advantage of unint vars is a tip
> of the iceberg. They do equally nasty "optimizations" for all
> undefined things. It's a real issue for all backends.
> We can experiment -ftrivial-auto-var-init=zero and/or
> introduce similar workarounds.
> The problem is clearly not limited to bpf.
>
> But the main concern is that this discussion cannot happen without
> llvm and gcc involvement, but only gcc folks might be present at lsfmm.
>
> We also still have an issue of missing suffixes when llvm optimizes
> funcs, compilers doing things that messes with the verifier,
> gcc is still missing decl_tag support, etc.
>
> I suggest to fold the status update (not a discussion) into one
> slot that will cover all outstanding gcc and llvm issues.

Good point. Let us discuss the progress of various compiler
related issues at once. Will coordinate with Jose etc.


