Return-Path: <bpf+bounces-68649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFDB7E25B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CA91675D5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8631A81D;
	Wed, 17 Sep 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NCedJiDU"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6331A814
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112846; cv=none; b=JTscVvjVS9Mu+Eg2g9TSVGvWlrf5w7yoAes2ulYgeLlphNxeJARYyyoB/u3FgkVX+IvsxbnBPKsWMEo6KtvEC172NBpYfG4f64Jbp4xUCY/PrEPBKJOlkZtGzR+P1rlQd9jGyb4lBtB5bIeTcKyYuQejiJEo0TfoPKtkLJv+uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112846; c=relaxed/simple;
	bh=UA6WikGdgYbv6z5PzYbj6Z7TVlg6SJpK+aYkPOKkSx4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=nOi4URaSt1OhaUO4IB+DQEdDk3RA28fQ9VBpyukUjQBAJXj0UVyxvMHiDgA7z56pFqBH0dxD3RMit/NjBgJ92x9MiYgZJoPcbeDNm8i7xM0VB+iZAaejmuzMs2lkaX5rgeOPKA1xuhg1PFswASbaikU8BFF/fhpzO5cOBydsuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NCedJiDU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758112841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LE28i0bX+SlGJIWDCcB82wFsooa5my1ttefkIRgVbKE=;
	b=NCedJiDUjNWm18reHiolj+QDupntrsFTQUouVnVoDYmbVxPgwcJyz/ehQIq3oWTujxinEK
	jpMwXAzk5PEV81PAZBRFLxrMX65o3bZEd59iQ47NVv6WyA2VfUTSxOZ3ENe+BBWECOEVEe
	IjFpMXbhJqNeO/JfAowVyq5AUgrQv10=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 20:40:30 +0800
Message-Id: <DCV2ZG5KIFEO.R8HEGONFWBLP@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Allow union argument in trampoline
 based programs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Amery Hung" <ameryhung@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <yatsenko@meta.com>,
 <puranjay@kernel.org>, <davidzalman.101@gmail.com>,
 <cheick.traore@foss.st.com>, <chen.dylane@linux.dev>,
 <mika.westerberg@linux.intel.com>, <menglong8.dong@gmail.com>,
 <kernel-patches-bot@fb.com>
References: <20250916155211.61083-1-leon.hwang@linux.dev>
 <20250916155211.61083-2-leon.hwang@linux.dev>
 <CAMB2axM2o+tr0hUJYWgPRO7sGg5rE5RSa_tW_sHY_oegi1_bbg@mail.gmail.com>
In-Reply-To: <CAMB2axM2o+tr0hUJYWgPRO7sGg5rE5RSa_tW_sHY_oegi1_bbg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Sep 17, 2025 at 5:35 AM +08, Amery Hung wrote:
> On Tue, Sep 16, 2025 at 8:52=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Currently, functions with 'union' arguments cannot be traced with
>> fentry/fexit:
>>
>> bpftrace -e 'fentry:release_pages { exit(); }' -v
>> AST node count: 6
>> Attaching 1 probe...
>> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
>> Kernel error log:
>> The function release_pages arg0 type UNION is unsupported.
>> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0
>>
>> ERROR: Loading BPF object(s) failed.
>>
>> The type of the 'release_pages' argument is defined as:
>>
>> typedef union {
>>         struct page **pages;
>>         struct folio **folios;
>>         struct encoded_page **encoded_pages;
>> } release_pages_arg __attribute__ ((__transparent_union__));
>>
>> This patch relaxes the restriction by allowing function arguments of typ=
e
>> 'union' to be traced in verifier.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h | 3 +++
>>  include/linux/btf.h | 5 +++++
>>  kernel/bpf/btf.c    | 8 +++++---
>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 41f776071ff51..010ecbb798c60 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1119,6 +1119,9 @@ struct bpf_prog_offload {
>>  /* The argument is signed. */
>>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>>
>> +/* The argument is a union. */
>> +#define BTF_FMODEL_UNION_ARG           BIT(2)
>> +
>
> [...]
>
>>  struct btf_func_model {
>>         u8 ret_size;
>>         u8 ret_flags;
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 9eda6b113f9b4..255f8c6bd2438 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -404,6 +404,11 @@ static inline bool btf_type_is_struct(const struct =
btf_type *t)
>>         return kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_UNION=
;
>>  }
>>
>> +static inline bool __btf_type_is_union(const struct btf_type *t)
>> +{
>> +       return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION;
>> +}
>> +
>>  static inline bool __btf_type_is_struct(const struct btf_type *t)
>>  {
>>         return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_STRUCT;
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64739308902f7..2a85c51412bea 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>>         /* skip modifiers */
>>         while (btf_type_is_modifier(t))
>>                 t =3D btf_type_by_id(btf, t->type);
>> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type=
_is_struct(t))
>> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_i=
s_struct(t))
>>                 /* accessing a scalar */
>>                 return true;
>>         if (!btf_type_is_ptr(t)) {
>> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 bt=
f_id,
>>         if (btf_type_is_ptr(t))
>>                 /* kernel size of pointer. Not BPF's size of pointer*/
>>                 return sizeof(void *);
>> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_st=
ruct(t))
>> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_stru=
ct(t))
>>                 return t->size;
>>         return -EINVAL;
>>  }
>> @@ -7347,6 +7347,8 @@ static u8 __get_type_fmodel_flags(const struct btf=
_type *t)
>>                 flags |=3D BTF_FMODEL_STRUCT_ARG;
>
> Might be nit-picking but the handling of union arguments is identical
> to struct, so maybe we don't need to introduce a new flag
> BTF_FMODEL_UNION_ARG just for this. Changing __btf_type_is_struct() to
> btf_type_is_struct() here should also work.

Correct. It should work with such changing.

However, it would be more readable to introduce the new flag as the flag
indicates the argument is a 'union' instead of a 'struct'.

>
> Otherwise, the set looks good to me.
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

Thank you for your review.

Thanks,
Leon

[...]

