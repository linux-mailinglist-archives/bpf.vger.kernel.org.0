Return-Path: <bpf+bounces-21818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86EA852707
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28503B289DD
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7FCA47;
	Tue, 13 Feb 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WlvVa2Ip"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5E631
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787439; cv=none; b=h5FuGmm3M680ERoa0NhYjHaXsud4zvGYI07Mc+/j5vAG/dGLnKUMFN7tZEv6XAOw7LQwazol22lkaPzDlYf7kH7GCFnuZBeZOqeXZQzbuzS6LYScl5NCUSHoFWycIr3+FekFAtORiVb99foE/lEdUg/PpSeVLk3xk48rdlifnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787439; c=relaxed/simple;
	bh=C08BIsOJkWPyAMKEFrOGto4TCSYtZpqMLK0MfDdLF+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMHwaxDJ6Yg1TTdj4J9hC7JYa/ndPRv33rU8GUHNsm5qSGdVxRhxWdMBjYbDQ5KE+3qLpGuxeOe5Dod7HEikCH114eYcoy/zLEarHOqu7iMm5oVjmfZ+arkmG5WVRgtGNEGRNF9NChlmdw1SONLeX/Q2SHZ0fd8OcqWCSooXZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WlvVa2Ip; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3b89acf-fb83-4bdf-84e1-6c4a77f3ad36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707787436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=texyvZ/XwQWQWgeYnioyP/KDLsoY6O6tqmtEXOQYBhA=;
	b=WlvVa2Ipfmn6PvwSHK1ow3JeoLl5XOG7dboDAVvT0YfAbKt1O+kxkO4NLkNgejgNbu7l2R
	/hPnLmJtAIT3CUWu8EcMrP0Fra76P7MxR5fUFyYJwWSvp62ojnBLgRn/c/P/m9z3Y8/B5c
	5l+RTkk+uRH7/PokGWcjYwAWb3W/CgA=
Date: Mon, 12 Feb 2024 17:23:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in
 new conformance group
Content-Language: en-GB
To: dthaler1968@googlemail.com, "'Jose E. Marchesi'"
 <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
 <036301da5dfd$be7d1b30$3b775190$@gmail.com>
 <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
 <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/12/24 5:18 PM, dthaler1968@googlemail.com wrote:
>> -----Original Message-----
>> From: Yonghong Song <yonghong.song@linux.dev>
>> Sent: Monday, February 12, 2024 2:49 PM
>> To: dthaler1968@googlemail.com; 'Jose E. Marchesi'
>> <jose.marchesi@oracle.com>; 'Dave Thaler'
>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>> Cc: bpf@vger.kernel.org; bpf@ietf.org
>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
>> conformance group
>>
>>
>> On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
>>>> -----Original Message-----
>>>> From: Yonghong Song <yonghong.song@linux.dev>
>>>> Sent: Monday, February 12, 2024 1:49 PM
>>>> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
>>>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>>>> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
>>>> <dthaler1968@gmail.com>
>>>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx
>>>> instructions in new conformance group
>>>>
>>>>
>>>> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>>>>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
>>>> only, see `Program-local functions`_
>>>>> If the instruction requires a register operand, why not using one of
>>>>> the register fields?  Is there any reason for not doing that?
>>>> Talked to Alexei and we think using dst_reg for the register for
>>>> callx insn is better. I will craft a llvm patch for this today. Thanks!
>>> Why dst_reg instead of src_reg?
>>> BPF_X is supposed to mean use src_reg.
>> Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch of flags
>> (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this property as
>> well in case in the future we will introduce variants for callx.
> Ah yes, that makes sense.
>
>> The following is the llvm diff:
>>
>> https://github.com/llvm/llvm-project/pull/81546
> Which llvm release is it targeted for?
> 18.1.0-rc3? 18.1.1?  later?

llvm19

>
>>> But this thread is about reserving/documenting the existing practice,
>>> since anyone trying to use it would run into interop issues because
>>> of existing clang.   Should we document both and list one as deprecated?
>> I think just documenting the new encoding is good enough. But other
>> people can chime in just in case that I missed something.
> Ok.
>
> Dave
>

