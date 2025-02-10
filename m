Return-Path: <bpf+bounces-51061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F6A2FD9A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7F4160ACB
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C6253344;
	Mon, 10 Feb 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QNSGwGbs"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29B253354
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227364; cv=none; b=SHX8QxPxtIRXD3jiNkg9LbEtdegZSKbpik8jT5YlxHnnIZPrQYdg40N3J1MK3UC13wN5Hp20TNVhakND6Z/47eM6opWSjJ98zPgAEB1Yxsn2ZJB2u4vkY8HDhszV9XAluM5Et21PmxcVM//LKzP02QaremwpjlSnXHm0KOSlxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227364; c=relaxed/simple;
	bh=hlhP5+pM5XB2kuVuAmMfDXKqG3DKLTGvG3P3xd6hS78=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=II0G5Z0dOjE7m4XU+e2rJQV0quRGxstjIR9fJZdJ32nAcn4DFMfJYaNgfapYhDIHB0Yq+//ssv2w5kXKGZqYcfN9l0KhoPP8v5bqTKDC7l2kiTnOU4oVJa9at5VkpkX3j3jW+RvQiTBTTuRunB21546NcyyIQFg4B0M1sPsAC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QNSGwGbs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739227360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E52sx1D+wKNdhEmk3Eg9/eVOfAPsmCoBiqmXE344za8=;
	b=QNSGwGbsPWC55tqP8rcxRHc2W2ZLthmBDxOwyDTMH4jNmtStHMw/Daln2NpsA7PTGclmpe
	lAM4WhYNnYnjLVXsEckS/eYVCn6D0auVO8cutYNzIpCBwIWWs99VDB67hNbt+zul342XJa
	nyNN6W/mYrkuL8CYxnQ9I58FbwBShnQ=
Date: Mon, 10 Feb 2025 22:42:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <20a49b2ada87ce106607e1ca8c98a76e826dccd1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves 1/3] btf_encoder: collect kfuncs info in
 btf_encoder__new
To: "Eduard Zingerman" <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <3782640a577e6945c86d6330bc8a05018a1e5c52.camel@gmail.com>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
 <20250207021442.155703-2-ihor.solodrai@linux.dev>
 <3782640a577e6945c86d6330bc8a05018a1e5c52.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2/10/25 12:57 PM, Eduard Zingerman wrote:
> On Thu, 2025-02-06 at 18:14 -0800, Ihor Solodrai wrote:
>> From: Ihor Solodrai <ihor.solodrai@pm.me>
>>
>> btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
>> executed right before BTF is deduped and dumped to the output.
>>
>> Split btf_encoder__tag_kfuncs() routine in two parts:
>>   * btf_encoder__collect_kfuncs()
>>   * btf_encoder__tag_kfuncs()
>>
>> [...]
>
> Tbh, I don't think this split is necessary, modifying btf_type
> in-place should be fine (and libbpf does it at-least in one place).
> E.g. like here:
> https://github.com/acmel/dwarves/compare/master...eddyz87:dwarves:arena=
-attrs-no-split
> I like it because it keeps the change a bit more contained,
> but I do not insist.

There are a couple of reasons this split makes sense to me.

First, I wanted to avoid modifying BTF. Having btf_encoder only
appending things to BTF is easy to reason about. But you're saying
modification does happen somewhere already?

The second reason is that the input for kfunc tagging is ELF, and so
it can be read at around the same time other ELF data is read (such as
for fucntions table). This has an additional benefit of running in
parallel to dwarf encoders (because one of the dwarf workers is
creating btf_encoder struct), as opposed to a sequential
post-processing step.

Finally I think it is generally useful to have kfunc info available at
any point of btf encoding, which becomes possible if the BTF_ids
section is read at the beginning of the encoding process.

>
> [...]
>>=20=20
>>=20-		err =3D btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->f=
lags);
>> -		if (err) {
>> -			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
>> -			free(func);
>> +		elf_fn =3D btf_encoder__find_function(encoder, func, 0);
>> +		free(func);
>> +		if (!elf_fn)
>> +			continue;
>> +		elf_fn->kfunc =3D true;
>> +
>> +		kfunc =3D calloc(1, sizeof(*kfunc));
>> +		if (!kfunc) {
>> +			fprintf(stderr, "%s: failed to allocate memory for kfunc info\n", =
__func__);
>> +			err =3D -ENOMEM;
>>  			goto out;
>>  		}
>> -		free(func);
>> +		kfunc->id =3D pair->id;
>> +		kfunc->flags =3D pair->flags;
>> +		kfunc->name =3D elf_fn->name;
>
> If we do go with split, maybe make refactoring a bit more drastic and
> merge kfunc_info with elf_function?
> This would make maintaining a separate encoder->kfuncs list unnecessary=
.
> Also, can get rid of separate 'struct gobuffer *funcs'.
> E.g. see my commit on top of yours:
> https://github.com/acmel/dwarves/compare/master...eddyz87:dwarves:arena=
-attrs-merge-kfunc-info

Yeah, I like it. I'll play with this for v2, thanks.

>
>> +		list_add(&kfunc->node, &encoder->kfuncs);
>>  	}
>>=20=20
>>=20 	err =3D 0;
>>  out:
>> -	__gobuffer__delete(&btf_funcs);
>>  	__gobuffer__delete(&btf_kfunc_ranges);
>>  	if (elf)
>>  		elf_end(elf);
>> @@ -2081,6 +2095,34 @@ out:
>>  	return err;
>>  }
>>=20=20
>
>=20[...]
>

