Return-Path: <bpf+bounces-76664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67250CC09BE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D05301F5D8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE9285071;
	Tue, 16 Dec 2025 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NyQfsXC+"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D2182B8
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852291; cv=none; b=cqVS/Gv1x4xde1DrnvysgcrK34iBjWOzt9Xhh2x0tWs36FR3vJ9N92ZGIsCu5YXfaLkkkrhOTKmiUDkt4/Pb58D+TzCAlSFGbFy12w02UVjuJlfQTwwDIjh8BVGxY9/VM7J2kmG4UM2/w2JlOsn6SeMk06k1vcCBsSCo0I3ILy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852291; c=relaxed/simple;
	bh=/8S/Ip8sOh3c46xequawxtCDOtzr/GWakhL/mtPPUpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGc11tfojQL3lPD0uCz2Z39hNGliUxsDEg+/oX5HpJjBzKvu9r9AT8hAEzcOX1ljBd8u9fcglqZoIsAAobFDkQeXh2WXV7dhDcS2s+kmwAOm2aNQGpt+DKYtcKZWU5sSACkAFwecP09ejUMzFd/xs2F5Rab2ydCAYxVz3VY0sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NyQfsXC+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c857acb9-977a-49ca-a03f-ef3fd68fabae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765852273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbmMny46Lg5VKGtTCasStsI7pn8QMSTjsYdIBiJ1FCo=;
	b=NyQfsXC+Gi/X6yqGBAZzFlYRJWaDO9ThdnF0vKgPsaUbhWmVplbvYdSPN1UDac/T3LcSIz
	WsSgmeA1ueGkO6/niGWoIu9J+NwqYeJq4kMVedvFFEZ9eB4eqgDjsmD2HPBIxJZQotV5c4
	0znJUxR4y/SynX8kgetD2WPuXRtrfSk=
Date: Mon, 15 Dec 2025 18:31:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] resolve_btfids: Introduce enum
 btf_id_kind
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
 <20251205223046.4155870-4-ihor.solodrai@linux.dev>
 <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/25 11:09 PM, Eduard Zingerman wrote:
> On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
>> Instead of using multiple flags, make struct btf_id tagged with an
>> enum value indicating its kind in the context of resolve_btfids.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> (But see a question below).
> 
>> @@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *name, bool unique)
>>  			p = &(*p)->rb_left;
>>  		else if (cmp > 0)
>>  			p = &(*p)->rb_right;
>> -		else
>> -			return unique ? NULL : id;
>> +		else if (kind == BTF_ID_KIND_SYM && id->kind == BTF_ID_KIND_SYM)
> 
> Nit: I'd keep the 'unique' parameter alongside 'kind' and resolve this
>      condition on the function callsite.

I don't like the boolean args, they're always opaque on the callsite.

We want to allow duplicates for _KIND_SYM and forbid for other kinds.
Since we are passing the kind from outside, I think it makes sense to
check for this inside the function. It makes the usage simpler.

> 
>> +			return id;
>> +		else {
>> +			pr_err("Unexpected duplicate symbol %s of kind %d\n", name, id->kind);
>> +			return NULL;
>> +		}
> 
> [...]
> 
>> @@ -491,28 +515,24 @@ static int symbols_collect(struct object *obj)
>>  			id = add_symbol(&obj->funcs, prefix, sizeof(BTF_FUNC) - 1);
>>  		/* set8 */
>>  		} else if (!strncmp(prefix, BTF_SET8, sizeof(BTF_SET8) - 1)) {
>> -			id = add_set(obj, prefix, true);
>> +			id = add_set(obj, prefix, BTF_ID_KIND_SET8);
>>  			/*
>>  			 * SET8 objects store list's count, which is encoded
>>  			 * in symbol's size, together with 'cnt' field hence
>>  			 * that - 1.
>>  			 */
>> -			if (id) {
>> +			if (id)
>>  				id->cnt = sym.st_size / sizeof(uint64_t) - 1;
>> -				id->is_set8 = true;
>> -			}
>>  		/* set */
>>  		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
>> -			id = add_set(obj, prefix, false);
>> +			id = add_set(obj, prefix, BTF_ID_KIND_SET);
>>  			/*
>>  			 * SET objects store list's count, which is encoded
>>  			 * in symbol's size, together with 'cnt' field hence
>>  			 * that - 1.
>>  			 */
>> -			if (id) {
>> +			if (id)
> 
> Current patch is not a culprit, but shouldn't resolve_btfids fail if
> `id` cannot be added? (here and in a hunk above).

By the existing design, resolve_btfids generally fails if
CONFIG_WERROR is set and `warnings > 0`.

And in this particular place it would fails with -ENOMEM a bit below:

       [...]
		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
			id = add_set(obj, prefix, BTF_ID_KIND_SET);
			/*
			 * SET objects store list's count, which is encoded
			 * in symbol's size, together with 'cnt' field hence
			 * that - 1.
			 */
			if (id)
				id->cnt = sym.st_size / sizeof(int) - 1;
		} else {
			pr_err("FAILED unsupported prefix %s\n", prefix);
			return -1;
		}

  /* --> */	if (!id)
			return -ENOMEM;

So I think an error code change may be appropriate, and that's about it.

> 
>>  				id->cnt = sym.st_size / sizeof(int) - 1;
>> -				id->is_set = true;
>> -			}
>>  		} else {
>>  			pr_err("FAILED unsupported prefix %s\n", prefix);
>>  			return -1;
> 
> [...]
> 


