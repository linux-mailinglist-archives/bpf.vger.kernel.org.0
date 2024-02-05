Return-Path: <bpf+bounces-21198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82315849378
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBF31F22C16
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E2BA28;
	Mon,  5 Feb 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkxlOiTl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A2B641
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111646; cv=none; b=DBmlPc/MHwG2EBQta5fkXonQd6/6/kiixl4EfUffy4HDrVsY3ribI9bp7qCbPDGMgwHqpZUxq0h9lbcjhDubbjNRoBNSrMsg6f8cHYeWhR5lN6bG/bTYFC+TxUEL7w1cwnQLVmgLu9B+u+ZXMITUt+7YzRuJ5GuSA4Lzu3WIrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111646; c=relaxed/simple;
	bh=7J2h4fJsQ9LrN+euhG6ExIw+sgrV+FbNGQ1SN+Cnjsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akwt/JdnE4Gm/20u950M/WBbk21cheL3Jff7s/VL51t9n7lmitGLFuYSqKhyETvLnUvjak6V6JRIneF91aj9IXCnaIIrZlQUTmG6EFFwfDqaXebLpJssOiboOxzoXqHinQyg8Kmgil8AoSAXTyWbKG3VxNNjnEC265VMCsYBg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkxlOiTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707111643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vao81QbQZzrGrhYOY0EDY1q3Jajgo5cWkkHtCYtKwO0=;
	b=YkxlOiTlxA1yN8GRsSwgsIXi8U7620+Ya2zB3P4sDYzpvyxKzuOPMuCFgDlbuzCCme06eg
	aja4S4G7FJnt20wCoWOhsHxM8lCjQ6KFul6yhS7GBF2GhD/2Bd6I/5LRtRoJ0uHNEfSTMX
	M51sAoZTfKHX+ME+eRA8p1j6148YHds=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-fXdPn2AnOfqSO7JpxM4yZQ-1; Mon, 05 Feb 2024 00:40:41 -0500
X-MC-Unique: fXdPn2AnOfqSO7JpxM4yZQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so2727538a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707111640; x=1707716440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vao81QbQZzrGrhYOY0EDY1q3Jajgo5cWkkHtCYtKwO0=;
        b=J5SS8/2SEBTipfr0og1z1UPva2udytVByWrSdJsiQBnh3wgJri7eg7Rwl3eVYArYjz
         4Y8VkJR5N8+NiGHzXtE33nFly79wtyfka1wP88gbmn0K5oxxh2XVEi5YczLg0v+y2AMK
         31TOJDCI05e1wa4bOlEya5zXN2wkuAViZClZtUhHt+rl4tGJuOiVjokUMytZ/vF4Pmyj
         zH5jv0F7Iua/0Fst/vXwtbJYb3RySl3U3O3fjwRVk3OjJzCrJ9Qi6surHJ9atWBgR2eY
         oBlclffz9c5nvv7sxHVLz3Rrq4JqLnAVn/MIHfymz5vEVrHkBeNQM0eWjSOGb9k6gbl0
         ECzw==
X-Gm-Message-State: AOJu0YxEjYju64+F8l3rjM8/sHa0/htelauV1T96KE4k1qk9qXdzMxvG
	zKlm7aQ6Nbb2EK0UiDtaLVMR5LdtGJno8UIgJtusp+vIvfdRgbskGldcT9Ub45lteUTwtK17MAP
	VRSaKk9tF/cE0B+0pzL9a8tkV6PatpoBxAtFTLU2cRTW/6sim
X-Received: by 2002:a17:906:5395:b0:a37:bd9c:ad74 with SMTP id g21-20020a170906539500b00a37bd9cad74mr787500ejo.75.1707111640281;
        Sun, 04 Feb 2024 21:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHP8djCtg7CztOKJ1nYCzaGlJeedM43ROtxvWJy4jcKI0EsspJwTPXQCU9D4FN0yZHeOnWAw==
X-Received: by 2002:a17:906:5395:b0:a37:bd9c:ad74 with SMTP id g21-20020a170906539500b00a37bd9cad74mr787475ejo.75.1707111639855;
        Sun, 04 Feb 2024 21:40:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCULVAUVt6GpwUK0FJTcyTcNgZxWZoXwXzlxsb3kV6jmyWh/AgQboJ3xFsum5cU8kGg3wMTK88etD16VvLX1TBH+Y2HlMWy/3z7fZB8X7M5hLF5OJF8IlWrFWI0jVRVuymuDhjJtQBwE6YHTnz6ihqwjUX4eBZ6JkNbMpbGPUUR8JJ+MJbbeBq6+S8ZhHrC2rgO41iEvRoJdtAaiRPZ0ZjYy0DJlSWCKpvDmgRaZek2fRoLZ5gU9FqgHxEhMWWUEMvyLt7VR1TwlwhdoIqmXDXGQxSaCXT/W3UZCqHy6QDyykWEKDJtBSISw7bgNg81u0XtMqaMf0hlkymllJhI0KkgBc0uoZsfsKkEbkAZGVTHICOJIrb1UfHBuzZfLjCRaWDpwQIL3mJHRIAm7RO50E8Z9jxKNx/tJU1EwTamtK7AEKw+3ozp7MsDsQZA7/j763QAe8NS/cuqDQcY9zMCnCuuTEUS6lndtr6g8xytiepQ=
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a372b38380csm3113246ejc.13.2024.02.04.21.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 21:40:39 -0800 (PST)
Message-ID: <dcaa3571-81be-45af-81fc-92e3629f0186@redhat.com>
Date: Mon, 5 Feb 2024 06:40:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Content-Language: en-US
To: Manu Bretelle <chantr4@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
 <vjbvcxsbtz7mrwevvcb3i4sf7hv5ah6iyjyzg7awr4iuiimryv@wjkglqsk6wee>
 <Zb6Km769Hh6BZF8e@surya>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Zb6Km769Hh6BZF8e@surya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/24 19:48, Manu Bretelle wrote:
> On Fri, Feb 02, 2024 at 06:38:18PM -0700, Daniel Xu wrote:
>> Hi Viktor,
>>
>> On Wed, Jan 31, 2024 at 05:24:09PM +0100, Viktor Malik wrote:
>>> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
>>> build and afterwards patched by resolve_btfids with correct values.
>>> Since resolve_btfids always writes in host-native endianness, it relies
>>> on libelf to do the translation when the target ELF is cross-compiled to
>>> a different endianness (this was introduced in commit 61e8aeda9398
>>> ("bpf: Fix libelf endian handling in resolv_btfids")).
>>>
>>> Unfortunately, the translation will corrupt the flags fields of SET8
>>> entries because these were written during vmlinux compilation and are in
>>> the correct endianness already. This will lead to numerous selftests
>>> failures such as:
>>>
>>>     $ sudo ./test_verifier 502 502
>>>     #502/p sleepable fentry accept FAIL
>>>     Failed to load prog 'Invalid argument'!
>>>     bpf_fentry_test1 is not sleepable
>>>     verification time 34 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
>>>
>>> Since it's not possible to instruct libelf to translate just certain
>>> values, let's manually bswap the flags in resolve_btfids when needed, so
>>> that libelf then translates everything correctly.
>>>
>>> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> ---
>>>  tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
>>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>> index 7badf1557e5c..d01603ef6283 100644
>>> --- a/tools/bpf/resolve_btfids/main.c
>>> +++ b/tools/bpf/resolve_btfids/main.c
>>> @@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
>>>  	Elf_Data *data = obj->efile.idlist;
>>>  	int *ptr = data->d_buf;
>>>  	struct rb_node *next;
>>> +	GElf_Ehdr ehdr;
>>> +	int need_bswap;
>>> +
>>> +	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
>>> +		pr_err("FAILED cannot get ELF header: %s\n",
>>> +			elf_errmsg(-1));
>>> +		return -1;
>>> +	}
>>> +	need_bswap = (__BYTE_ORDER == __LITTLE_ENDIAN) !=
>>> +		     (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
>>>  
>>>  	next = rb_first(&obj->sets);
>>>  	while (next) {
>>>  		unsigned long addr, idx;
>>>  		struct btf_id *id;
>>>  		void *base;
>>> -		int cnt, size;
>>> +		int cnt, size, i;
>>>  
>>>  		id   = rb_entry(next, struct btf_id, rb_node);
>>>  		addr = id->addr[0];
>>> @@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
>>>  			base = set8->pairs;
>>>  			cnt = set8->cnt;
>>>  			size = sizeof(set8->pairs[0]);
>>> +
>>> +			/*
>>> +			 * When ELF endianness does not match endianness of the
>>> +			 * host, libelf will do the translation when updating
>>> +			 * the ELF. This, however, corrupts SET8 flags which are
>>> +			 * already in the target endianness. So, let's bswap
>>> +			 * them to the host endianness and libelf will then
>>> +			 * correctly translate everything.
>>> +			 */
>>> +			if (need_bswap) {
>>> +				for (i = 0; i < cnt; i++) {
>>> +					set8->pairs[i].flags =
>>> +						bswap_32(set8->pairs[i].flags);
>>> +				}
>>
>> Do we need this for btf_id_set8:flags as well? Didn't get a chance to
>> look too deeply yet.
>>
>> Thanks,
>> Daniel
> 
> I ran some test and tried and validated Jiri's patch in
> https://lore.kernel.org/bpf/Zb6Jt30bNcNhM6zR@surya/

Right, I'll include that patch. Thanks for testing!

Viktor

> 
> Manu
> 


