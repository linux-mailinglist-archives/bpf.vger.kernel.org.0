Return-Path: <bpf+bounces-75607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C94C8B86E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65BE835BEC0
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CDB33EB04;
	Wed, 26 Nov 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqxbAVFu"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806F3126BC
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184097; cv=none; b=c+6qETeLuyjuyfQd0mvCFdWOvL9luNw5CZygRiiFbaEdCQ4NpGCxOP9B7UkidHiS1sd2qvdHUhafYgIA0Up1z987hJUTwCfY0XqiUG8XW9OLzAFfIBzQ0TWJUHZYWpoobgPvQejGMkCtayjYQbyB/H5lENSMOMa1wFs4Or4XVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184097; c=relaxed/simple;
	bh=QkrMuFPGwvXJZ5qY/D1AgGZOqbHZcZUqeE2SK3B2p9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swq1TpB1YTKU41Fi1RusGG7dszq59r81HAowPXTberihxjKgT9rm3IJ5Yl3vklHSZNt5wvtvgcw8NLPEJhDRwbLl430tvxJWRyajF4g4V38ur1lWfSaxOGIwpiJjzUQzsTEfZ66VAjxKJNQQES8zzK3m2PjPEvCW9HZSfU5/WIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqxbAVFu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d91c8ccc-cf5f-4d50-9a8e-944f90e0401a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764184094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3P5T0GSkwkYYH5jOoeKnyxxs+DIn65xOfHXjhWpU5M=;
	b=NqxbAVFud7sNqDfhkbP8DgQaySFVpHgOgtZ4wqA0R67NNlFm3wunvqPSZuPZf4EEtHk5sb
	LyQXIisSmUWXWln1O5pcvLfmjmA+gxOhzDZBFdDBNLeDyRfbojM3a9R2Xm+tDT6+l8ypfS
	xJykJ3e/ZdRzZZ/S3IgWSDLT6UrQHBc=
Date: Wed, 26 Nov 2025 11:08:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/4] resolve_btfids: introduce enum
 btf_id_kind
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 nicolas.schier@linux.dev, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 alan.maguire@oracle.com, dolinux.peng@gmail.com, martin.lau@kernel.org,
 clm@meta.com
References: <20251126012656.3546071-4-ihor.solodrai@linux.dev>
 <3d0b94b9fdd5150c136784b5e6904264e5fb09a00d8512e459ec6c3046ed9abb@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <3d0b94b9fdd5150c136784b5e6904264e5fb09a00d8512e459ec6c3046ed9abb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/25/25 6:09 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index b7b44e72e..7f5a9f7dd 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> @@ -260,26 +266,33 @@ static char *get_id(const char *prefix_end)
>>  	return id;
>>  }
>>
>> -static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
>> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
>>  {
>>  	/*
>>  	 * __BTF_ID__set__name
>>  	 * name =    ^
>>  	 * id   =         ^
>>  	 */
>> -	char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
>> +	int prefixlen = kind == BTF_ID_KIND_SET8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__");
>> +	char *id = name + prefixlen - 1;
>>  	int len = strlen(name);
>> +	struct btf_id *btf_id;
>>
>>  	if (id >= name + len) {
>>  		pr_err("FAILED to parse set name: %s\n", name);
>>  		return NULL;
>>  	}
>>
>> -	return btf_id__add(&obj->sets, id, true);
>> +	btf_id = btf_id__add(&obj->sets, id, true);
>> +	if (btf_id)
>> +		btf_id->kind = kind;
>> +
>> +	return btf_id;
>>  }
>>
>>  static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>>  {
>> +	struct btf_id *btf_id;
>>  	char *id;
>>
>>  	id = get_id(name + size);
>> @@ -288,7 +301,10 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>>  		return NULL;
>>  	}
>>
>> -	return btf_id__add(root, id, false);
>> +	btf_id = btf_id__add(root, id, false);
>> +	btf_id->kind = BTF_ID_KIND_SYM;
>                  ^^^^
> 
> Can add_symbol() dereference a NULL pointer here? The function
> btf_id__add() can return NULL on allocation failure (when zalloc fails),
> but the new code sets btf_id->kind before checking if btf_id is NULL.
> 
> In contrast, add_set() checks for NULL before setting the kind field.
> Should add_symbol() do the same?

We pass unique=false to btf_id__add() and that means that it can only
return NULL if zalloc() fails, which is unlikely.

Checking for NULL here is little too defensive, but won't hurt.

> 
>> +
>> +	return btf_id;
>>  }
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19689674924


