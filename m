Return-Path: <bpf+bounces-39322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863D971CF3
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C6EB21CE9
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816E1BAEDE;
	Mon,  9 Sep 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+2uUcx1"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91641DA5F
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892969; cv=none; b=UoJsMo46mNtbH8tRuAYsTF1VKuqaB5jDKdw4Jxhy69d8twMjVuuYsh/XtIEJg2Cy0RY+uGLQN+G+6bgFZ5V66LHpdLNH3xwc23TpxrWtBzd7UoRa4hPNAjV6Mhzv9Txk9Ptlcq2vpp4/XTz2mPRRZUIhnYS51M6tkHuzne391rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892969; c=relaxed/simple;
	bh=JjLbMja7LdpNXQrWiNrK6FzKeSwRSg7n+dXCUym8YQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+uB5xsnw3qyi0auOhsjxo3rnVKMAUqEDpTXeBJ7v5kcoicfbwoBtTR282fobgdlXudTmJQuso7yIQRjK9DKsbIqnEJy4aCROl5VFgVelbjXAcYTDCkFpssrVKhPJ1KG3+6pTlLpDrbE5aZ7iehqZc3WoUtelccGBiM594gM04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+2uUcx1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e955de3-396a-4def-925c-0e8463f29b23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725892964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrYIAIG0mVP770afTfndkrCEODt10uDmB5TGXxoh17s=;
	b=C+2uUcx1pMLnD1PYf0Zw+pxpJ9ZzPkTYRqv5ghT0ijPKpERAH120xCOwUNH+F0+45LREBk
	acbkQdQ+Qh8MX7BzLn+zMND6RJ09vP/dMMy3TvgN3u713eSLVrcxbmMmuJj4QID5Rsv+lj
	JvdmP3b65JUrp8CErvXmxKX5I5bzXPQ=
Date: Mon, 9 Sep 2024 22:42:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
 <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
 <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev>
 <0fc08a50-8812-4932-bb85-9d81cedf142a@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0fc08a50-8812-4932-bb85-9d81cedf142a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/9/24 20:08, Xu Kuohai wrote:
> On 9/9/2024 6:38 PM, Leon Hwang wrote:
>>
>>
>> On 9/9/24 17:02, Xu Kuohai wrote:
>>> On 9/8/2024 9:01 PM, Leon Hwang wrote:
>>>>
>>>>
>>>> On 1/9/24 21:38, Leon Hwang wrote:
>>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the
>>>>> same
>>>>> issue happens on arm64, too.
>>>>>

[...]

>>>>>
>>>> Hi Puranjay and Kuohai,
>>>>
>>>> As it's not recommended to introduce arch_bpf_run(), this is my
>>>> approach
>>>> to fix the niche case on arm64.
>>>>
>>>> Do you have any better idea to fix it?
>>>>
>>>
>>> IIUC, the recommended appraoch is to teach verifier to reject the
>>> freplace + tailcall combination. If this combiation is allowed, we
>>> will face more than just this issue. For example, what happens if
>>> a freplace prog is attached to tail callee? The freplace prog is not
>>> reachable through the tail call, right?
>>>
>>
>> It's to reject the freplace + tailcall combination partially, see "bpf,
>> x64: Fix tailcall infinite loop caused by freplace". (Oh, I should
>> separate the rejection to a standalone patch.)
>> It rejects the case that freplace prog has tailcall and its attach
>> target has no tailcall.
>>
>> As for your example, it depends on:
>>
>>                  freplace       target    reject?
>> Has tailcall?     YES            NO        YES
>> Has tailcall?     YES            YES       NO
>> Has tailcall?     NO             YES       NO
>> Has tailcall?     NO             YES       NO
>>
>> Then, freplace prog can be tail callee always. I haven't seen any bad
>> case when freplace prog is tail callee.
>>
> 
> Here is a concrete case. prog1 tail calls prog2, and prog2_new is
> attached to prog2 via freplace.
> 
> SEC("tc")
> int prog1(struct __sk_buff *skb)
> {
>         bpf_tail_call_static(skb, &progs, 0); // tail call prog2
>         return 0;
> }
> 
> SEC("tc")
> int prog2(struct __sk_buff *skb)
> {
>         return 0;
> }
> 
> SEC("freplace")
> int prog2_new(struct __sk_buff *skb) // target is prog2
> {
>         return 0;
> }
> 
> In this case, prog2_new is not reachable, since the tail call
> target in prog2 is start address of prog2  + TAIL_CALL_OFFSET,
> which locates behind freplace/fentry callsite of prog2.
> 

This is an abnormal use case. We can do nothing with it, e.g. we're
unable to notify user that prog2_new is not reachable for this case.

Thanks,
Leon


