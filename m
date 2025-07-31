Return-Path: <bpf+bounces-64815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F8B1740F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60869A80AC6
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCF1DDA15;
	Thu, 31 Jul 2025 15:43:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A96D515;
	Thu, 31 Jul 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976581; cv=none; b=hGPf/Mu2vw+YTakbekoYzBEx5JgegT04vb+tkK8Cyp9K8sEOEmYO74k9QNwC2OO7/9FLDzflAqwDVZzb46QXovROV0vE4pvA3Etr16/+yqHul0laCfwtTFYeKoQYNuPKCUHJ8PSIJ5oXUN8PphWBqPFqore2Pf393ndy1oS5++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976581; c=relaxed/simple;
	bh=1WWG3Zuv514jM/ZH3hlMOl2lhe3oKQ046ntFyv4CX4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQYU2gq4uKDZTC5ZEK/pLjVuC2ypmZEibG+wuUK0YRAn/YXLJDQUq4LW9Tx1E2m4LZkHe9cT4X5tvEyUQj5TlgEogWD88Fr+bxOqjIsDsNqOl0tFgi0hCkdoth0MWRdrKji8Z9iMGE3Zx9kwiB2GclBEJpbITZb9hMfw6XQoroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A141BF7;
	Thu, 31 Jul 2025 08:42:50 -0700 (PDT)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C46A23F66E;
	Thu, 31 Jul 2025 08:42:54 -0700 (PDT)
Message-ID: <d887e166-0fd8-4b70-b6b7-6d3c0138d87b@arm.com>
Date: Thu, 31 Jul 2025 16:42:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250729113335.2e4f087d@batman.local.home>
 <dc817ce7-9551-4365-bd94-3c102a6acda8@arm.com>
 <20250731092953.2d8eea47@gandalf.local.home>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250731092953.2d8eea47@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31-07-2025 14:29, Steven Rostedt wrote:
> On Thu, 31 Jul 2025 12:44:49 +0100
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>>> The delimiter is '.' and the first item is the structure name. Then the
>>> member of the structure to get the offset of. If that member is an
>>> embedded structure, another '.MEMBER' may be added to get the offset of
>>> its members with respect to the original value.
>>>
>>>     "+kmem_cache.size($arg1)" is equivalent to:
>>>
>>>     (*(struct kmem_cache *)$arg1).size
>>>
>>> Anonymous structures are also handled:
>>>
>>>     # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events
>>
>> Not sure how hard that would be but the type of the expression could probably be inferred from
>> BTF as well in some cases. Some cases may be ambiguous (like char* that could be either a buffer
>> to display as hex or a null-terminated ASCII string) but BTF would still allow to restrict
>> to something sensible (e.g. prevent u32 for a char*).
> 
> Hmm, should be possible, but would require passing that information back to
> the caller of the BTF lookup function.
> 
> 
> 
>>> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
>>> index 5bbdbcbbde3c..b69404451410 100644
>>> --- a/kernel/trace/trace_btf.c
>>> +++ b/kernel/trace/trace_btf.c
>>> @@ -120,3 +120,109 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
>>>    	return member;
>>>    }
>>>    
>>> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
>>> +
>>> +static int find_member(const char *ptr, struct btf *btf,
>>> +		       const struct btf_type **type, int level)
>>> +{
>>> +	const struct btf_member *member;
>>> +	const struct btf_type *t = *type;
>>> +	int i;
>>> +
>>> +	/* Max of 3 depth of anonymous structures */
>>> +	if (level > 3)
>>> +		return -1;
>>> +
>>> +	for_each_member(i, t, member) {
>>> +		const char *tname = btf_name_by_offset(btf, member->name_off);
>>> +
>>> +		if (strcmp(ptr, tname) == 0) {
>>> +			*type = btf_type_by_id(btf, member->type);
>>> +			return BITS_ROUNDDOWN_BYTES(member->offset);
>>
>> member->offset does not only contain the offset, and the offset may not be
>> a multiple of 8:
>> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/btf.h#L126
>>
>>   From the BTF spec (https://docs.kernel.org/bpf/btf.html):
>>
>> If the kind_flag is set, the btf_member.offset contains
>> both member bitfield size and bit offset.
>> The bitfield size and bit offset are calculated as below.:
>>
>> #define BTF_MEMBER_BITFIELD_SIZE(val)   ((val) >> 24)
>> #define BTF_MEMBER_BIT_OFFSET(val)      ((val) & 0xffffff)
> 
> So basically just need to change that to:
> 
> 		if (strcmp(ptr, tname) == 0) {
> 			int offset = BTF_MEMBER_BIT_OFFSET(member->offset);
> 			*type = btf_type_by_id(btf, member->type);
> 			return BITS_ROUNDDOWN_BYTES(offset);
> 
> ?

This would work in practice for now, but strictly speaking you should check
the kind_flag field in btf_type.info (bit 31) of the parent struct/union:
https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/btf.h#L38
  __btf_member_bit_offset() seems to do exactly that.


While writing that, I realized there is another subtlety: BTF encodes int member offsets in 2 different ways:
1. Either their bit offset is encoded struct btf_member, and the btf_type of the member is an integer type with no leading padding bits.
2. Or the rounded-down offset is encoded in struct btf_member and the integer type contains some leading padding bits information:
https://docs.kernel.org/bpf/btf.html#btf-kind-int

The 2nd case is somewhat surprising but BTF_KIND_INT has 3 pieces of information:
1. The C signedness of the type.
2. The number of value bits of the type.
3. The offset of the 1st bit to interpret as being the value. Anything before is leading padding.

That means that the actual bit offset of an int member's value in a parent struct is:

   <offset of the member> + <offset of the type of the member>

You could technically have all members with btf_member.offset == 0 and then encode the actual values offsets in the btf_type of the members.

> 
>>
>>> +		}
>>> +
>>> +		/* Handle anonymous structures */
>>> +		if (strlen(tname))
>>> +			continue;
>>> +
>>> +		*type = btf_type_by_id(btf, member->type);
>>> +		if (btf_type_is_struct(*type)) {
>>> +			int offset = find_member(ptr, btf, type, level + 1);
>>> +
>>> +			if (offset < 0)
>>> +				continue;
>>> +
>>> +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> 
> And here too.
> 
> -- Steve
> 
>>> +		}
>>> +	}
>>> +
>>> +	return -1;
>>> +}
>>> +


