Return-Path: <bpf+bounces-35706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1193CE0D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0171F21CB0
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 06:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE93A1AC;
	Fri, 26 Jul 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XYdXWlB7"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462BA2A
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974543; cv=none; b=bYnHcapqE8ff75wsgyw67PqPIn38p43XUnx3wO0I1mRFFkaZN/lGD4VW5jowoEL19V7ECh6iI6aGdzq4nQ5kzP8L+AGQaz17UJTZ74RrA4A0lEYmeM3NmsShSkX9ZuPfWI5zyMHAfZwn5eUKACcaLEbQaRf+4uf/UdRHBcCk/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974543; c=relaxed/simple;
	bh=KBVfMp1FwR3VBfR5Q7gyr6/5L6+noeA2qEZa1TVhK4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYeapjH577Zj8Or9t2HCrmKUmAFNXZmNYa9fNKT5a1NW+nWWCI5hH7r+Hw8AqrmwlwFNjvNrSz29oCnH7URxaKPw/EtI7aDJKcoECLyTdzSie81f7QYqJR6+uL50JO8cT8qJW5olfyGw5xgaLSGjE8957GzzUrA0b+9poRJK+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XYdXWlB7; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a31ef08-e252-46ec-9cd5-a3ddcb895dfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721974539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VphGEc15Svc/TijUUEEQHjAfaNApcRTzMyByGXe9EHo=;
	b=XYdXWlB7NA94eo2QeolqqKJ/WixCLRrgA9F6Ga3p7BU2Y6QtKZQBJ+jRLAkf4zUVdfuP5n
	908VKOAWyO1U0N9uEoA7ILXOcR3M7nouQjlC9g4VqCLxqf7+TuhVm4LJZeQ6LL8Db4QeuE
	ou6Aa/A0c+epPfbHhYV/U9iduxIxmhI=
Date: Thu, 25 Jul 2024 23:15:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix updating attached freplace prog to
 PROG_ARRAY map
Content-Language: en-GB
To: leon.hwang@linux.dev, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-2-leon.hwang@linux.dev>
 <181a9753-717c-4eb4-b788-74468f68c0ff@linux.dev>
 <603c6bac4236b4e6632b00dbe222d5213ff8b9e7@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <603c6bac4236b4e6632b00dbe222d5213ff8b9e7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/25/24 8:27 PM, leon.hwang@linux.dev wrote:
> 26 July 2024 at 04:58, "Yonghong Song" <yonghong.song@linux.dev> wrote:
>
>
>
>> On 7/24/24 5:32 PM, Leon Hwang wrote:
>>
>>> The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
>>>
>>>   resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed the following panic,
>>>
>>>   which was caused by updating attached freplace prog to PROG_ARRAY map.
>>>
>> I am confused here. You mentioned that commit f7866c3587337731
>>
>> fixed the panic below. But looking at commit message:
>>
>>   https://lore.kernel.org/bpf/20240711145819.254178-2-wutengda@huaweicloud.com
>>
>> it does not seem the case.
> The commit fixed this panic meanwhile.
>
> This panic seems confusing. I'll remove it in patch v2.
>
[...]

>>>   ---
>>>
>>>   include/linux/bpf_verifier.h | 4 ++--
>>>
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>   diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>
>>>   index 5cea15c81b8a8..387e034e73d0e 100644
>>>
>>>   --- a/include/linux/bpf_verifier.h
>>>
>>>   +++ b/include/linux/bpf_verifier.h
>>>
>>>   @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
>>>
>>>   /* only use after check_attach_btf_id() */
>>>
>>>   static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>>>
>>>   {
>>>
>>>   - return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
>>>
>>>   - prog->aux->dst_prog->type : prog->type;
>>>
>>>   + return prog->type == BPF_PROG_TYPE_EXT ?
>>>
>>>   + prog->aux->saved_dst_prog_type : prog->type;
>>>
>> If prog->aux->dst_prog is NULL, is it possible that prog->aux->saved_dst_prog_type
>>
>> (0, corresponding to BPF_PROG_TYPE_UNSPEC) could be returned? Do we need to do
>>
>>   return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
>>
>>   prog->aux->saved_dst_prog_type : prog->type;
>>
>> Maybe I missed something here?
> It seems better to check prog->aux->saved_dst_prog_type. But I don't think so.
>
> prog->aux->saved_dst_prog_type is set in check_attach_btf_id(). And there is no
> resolve_prog_type() before check_attach_btf_id() in bpf_check().
>
> Therefore, resolve_prog_type() must be called after check_attach_btf_id().

In check_attach_btf_id(), I see
         if (tgt_prog) {
                 prog->aux->saved_dst_prog_type = tgt_prog->type;
                 prog->aux->saved_dst_attach_type = tgt_prog->expected_attach_type;
         }

So it is possible prog->aux->saved_dst_prog_type is 0 (default value).
I don't know that if tgt_prog is NULL, whether later resolve_prog_type()
will be called or not. Need more checking here.


