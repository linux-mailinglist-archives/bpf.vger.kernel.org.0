Return-Path: <bpf+bounces-21790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E928521B9
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711E31F22FE0
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB84E1CA;
	Mon, 12 Feb 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buRQTJFF"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2D4D121
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778151; cv=none; b=gutHcqFs6WeApeKhtX8ZKFzSKAkgXITwS7cYSeAEWZVuGVmUddE3uIBn4UqcLF+RfB1+hXrOO37uBJPEbqtqCI3UKoxnp7MS2hjh6FnqUDHafp4zjT06H8nP5DaGioS/ytvyV7WLV4DgXF7GFGWYcw4OeHPaPxXvycbHJ1jfWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778151; c=relaxed/simple;
	bh=J6X3LDXXvp3AyYS5Lgd0cRDP8FvNOZm3BClCNj+zTYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnL+RD/s2q72aYD7uDFiCK55UvSxthj4LSp6ZTGnkAGWqY2sZ6loSb2HEd6WmTd7Ar1Ytd/SoCE+eh+7WDAp84/RVVfmUDNBC/aMcbs0jvoMF8U10qbhMNSYgBx11BDG/nWrDPmfo36M1RUhfNX1lTSazYOojJAtORV2pA4lOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buRQTJFF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707778146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxxpcU8xAC2U25ibMmPCd2/qGSoxCgvlX90Yj8CWOlE=;
	b=buRQTJFFMfo39aQ31z2BoUDeoIxU7GZffJqwH8PIyPQTSYFNebSTOL1v82F7t8T2os6Y/1
	u5wqi4q0trh2WZmO3n8o7k9XmTnfFA07rf7BoGf1i+/huhedoQZz4pBdfUhkZzEfo7BBpj
	0J7mzt1G36ChuoaiV7hg2pRqBjuxmZU=
Date: Mon, 12 Feb 2024 14:48:53 -0800
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
 <jose.marchesi@oracle.com>,
 'Dave Thaler' <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
 <036301da5dfd$be7d1b30$3b775190$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <036301da5dfd$be7d1b30$3b775190$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
>> -----Original Message-----
>> From: Yonghong Song <yonghong.song@linux.dev>
>> Sent: Monday, February 12, 2024 1:49 PM
>> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
>> <dthaler1968@gmail.com>
>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
>> conformance group
>>
>>
>> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
>> only, see `Program-local functions`_
>>> If the instruction requires a register operand, why not using one of
>>> the register fields?  Is there any reason for not doing that?
>> Talked to Alexei and we think using dst_reg for the register for callx insn is
>> better. I will craft a llvm patch for this today. Thanks!
> Why dst_reg instead of src_reg?
> BPF_X is supposed to mean use src_reg.

Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch
of flags (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this
property as well in case in the future we will introduce variants for
callx. The following is the llvm diff:

https://github.com/llvm/llvm-project/pull/81546

>
> But this thread is about reserving/documenting the existing practice,
> since anyone trying to use it would run into interop issues because
> of existing clang.   Should we document both and list one as deprecated?

I think just documenting the new encoding is good enough. But other
people can chime in just in case that I missed something.

>
> Dave
>

