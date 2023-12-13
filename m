Return-Path: <bpf+bounces-17649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE7810942
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 05:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC9B20F27
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3490C2C0;
	Wed, 13 Dec 2023 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9t5XvlE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AF698
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 20:53:47 -0800 (PST)
Message-ID: <3e8ff438-8684-4f50-a208-3fc2f70ac75b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702443226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NeUI2L102ksTK12Dnnq7T+KQZo7kX/CNR449+da0Qc=;
	b=T9t5XvlEBXQgWBDUzONJBpC8fyRJaOf5kJASrg1BTnmCql0hJ0wVY2ZvN0kFD6mS2UnUC7
	uIht/LEF4MajC6WbtdS0DzwA3IFsw3TKX64IZ3okYjab4T4fAndJg7pX8Hk5OvBb5KZWM8
	XobrPBvv4/SQcnk063Mi+3gNgVEcUCM=
Date: Tue, 12 Dec 2023 20:53:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 2/3] bpftool: add attribute preserve_static_offset for
 context types
Content-Language: en-GB
To: Quentin Monnet <quentin@isovalent.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, alan.maguire@oracle.com
References: <20231212023136.7021-1-eddyz87@gmail.com>
 <20231212023136.7021-3-eddyz87@gmail.com>
 <baee9fb4-7559-4ba2-a254-7388bb6caa63@isovalent.com>
 <90dd9462984be5cfce9db23eda53df44f39a8687.camel@gmail.com>
 <fce6188a-6ccc-4b92-9aa7-9ee18b2f2fa1@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fce6188a-6ccc-4b92-9aa7-9ee18b2f2fa1@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/12/23 8:07 AM, Quentin Monnet wrote:
> 2023-12-12 15:58 UTC+0000 ~ Eduard Zingerman <eddyz87@gmail.com>
>> On Tue, 2023-12-12 at 11:39 +0000, Quentin Monnet wrote:
>> [...]
>>> Hi, and thanks for this!
>>>
>>> Apologies for missing the discussion on v1. Reading through the previous
>>> thread I see that they were votes in favour of the hard-coded approach,
>>> but I would ask folks to please reconsider.
>>>
>>> I'm not keen on taking this list in bpftool, it doesn't seem to be the
>>> right place for that. I understand there's no plan to add new mirror
>>> context structs, but if we change policy for whatever reason, we're sure
>>> to miss the update in this list and that's a bug in bpftool. If bpftool
>>> ever gets ported to Windows and Windows needs support for new structs,
>>> that's more juggling to do to support multiple platforms. And if any
>>> tool other than bpftool needs to generate vmlinux.h headers in the
>>> future, it's back to square one - although by then there might be extra
>>> pushback for changing the BTF, if bpftool already does the work.
>>>
>>> Like Alan, I rather share your own inclination towards the more generic
>>> declaration tags approach, if you don't mind the additional work.
>> Understood, thank you for feedback.
>> The second option is to:
>>
>> 1. Define __bpf_ctx macro in linux headers as follows:
>>
>>      #if __has_attribute(preserve_static_offset) && defined(__bpf__)
>>      #define __bpf_ctx __attribute__((preserve_static_offset)) \
>>                        __attribute__((btf_decl_tag(preserve_static_offset)))
>>      #else
>>      #define __bpf_ctx
>>      #endif
>>
>> 2a. Update libbpf to emit __attribute__((preserve_static_offset)) when
>>      corresponding decl tag is present in the BTF.
>>
>> 2b. Update bpftool to emit __attribute__((preserve_static_offset)) for
>>      types with corresponding decl tag. (Like in this patch but check
>>      for decl tag instead of name).
> I don't have a strong opinion on that part, so...
>
>> I think that 2b is better, because emitting
>> BPF_NO_PRESERVE_STATIC_OFFSET from the same place where
>> BPF_NO_PRESERVE_ACCESS_INDEX makes more sense,
>> libbpf does not emit any macro definitions at the moment.
> ... the above makes sense, I'd say let's go for this if nobody else
> objects (or wants it in libbpf instead - but bpftool is fine as far as
> I'm concerned).

Thanks, Eduard and Quentin, my original proposal for hardcoded list is
for simplicity. Eduard, could you help also do an implementation like
you proposed in the above so we can then compare each other?

[...]


