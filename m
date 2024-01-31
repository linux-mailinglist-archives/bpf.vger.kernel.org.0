Return-Path: <bpf+bounces-20851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C14284461B
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0527EB290C2
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712C12CDB6;
	Wed, 31 Jan 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZpAcXwW"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747D12CDA4
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721824; cv=none; b=BROnF8IbDK/Yrk1f0uSdLFzsw5W0EhERMQ3rWJhbYE8oaT/KGK+LB7M0/w0QTubuf6UCOSspXohjlppxrXmEU7JnmL8yO3ZY7nJugzWs9h9rEZIB4mgREsw0LM/6VPeQaSMSeFFvhhyT1KEIVmnEbHFV3D7djAquNFa79kFTwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721824; c=relaxed/simple;
	bh=CpB9WisrPHTcjFM+f4CxuYpuHMwvOsJRx2KGAe338MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXk6SPjYNaHE8M7lCLepNKBVshepqxNQ6gvCxegZgzXyQXKkBBSuQJAImm/Jjl/Y2cVl561OxTErzebF6OMgpRqa+DnbFNYPkyIe1kkm5x/aAB5PaqICz/xDgPClqa27ugt+YZOmLsGPFVtIEk7nX8qaodvCcrrP0fr3SxTeB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZpAcXwW; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8c6f297-9153-4fbf-8fe2-2df6047ea66f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706721820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHOvwERtKV4zjjNjWmwF90w4F9+6DsAFA9d5Mrj5ngk=;
	b=cZpAcXwWQLsJbs48y07mrFZxZ8OYU9O8ZUSKYsLrj39dgtijBLj8lgI6KlaPLCM1tslPfW
	GXzBVg4gWjJfIWDnjBFwbAQgXAaObSf09QG/++hd8YmViNZOAwODczRPx+CC/Y3nnxZnQp
	CQO0uTA07iEk9AwSAlXqBT1H/1jPcjM=
Date: Wed, 31 Jan 2024 09:23:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to
 libbpf_set_memlock_rlim API
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-3-andrii@kernel.org>
 <aa043e86-586d-45dd-83c0-f47b271c2634@linux.dev>
 <CAEf4Bza1eKtnRmaUfCo_-zkKTz-ZzcoTSLg6dhOQK9N-G97X_A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza1eKtnRmaUfCo_-zkKTz-ZzcoTSLg6dhOQK9N-G97X_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/31/24 9:09 AM, Andrii Nakryiko wrote:
> On Tue, Jan 30, 2024 at 9:16 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
>>> LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
>>> add it to make this API callable from libbpf's shared library version.
>>>
>>> Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
>> Maybe we should the following commit as Fixes?
>>
>>     ab9a5a05dc48 libbpf: fix up few libbpf.map problems
>>
> The one I referenced introduced the problem, the ab9a5a05dc48 one
> fixed some problems, but not all of them (for
> libbpf_set_memlock_rlim). So it feels like pointing to the originating
> commit is better?

Maybe we can put two Fixes here? Just having e542f2c4cd16 is a little
confusing since libbpf_set_memlock_rlim is not in libbpf.map with
e542f2c4cd16.

>
>> Other than the above, LGTM.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    tools/lib/bpf/bpf.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>>> index 1441f642c563..f866e98b2436 100644
>>> --- a/tools/lib/bpf/bpf.h
>>> +++ b/tools/lib/bpf/bpf.h
>>> @@ -35,7 +35,7 @@
>>>    extern "C" {
>>>    #endif
>>>
>>> -int libbpf_set_memlock_rlim(size_t memlock_bytes);
>>> +LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>>>
>>>    struct bpf_map_create_opts {
>>>        size_t sz; /* size of this struct for forward/backward compatibility */

