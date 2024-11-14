Return-Path: <bpf+bounces-44863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75529C92E0
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 21:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7335A1F2348F
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79D1AB6CB;
	Thu, 14 Nov 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZijfZKN"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DF1A7AC7
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614678; cv=none; b=j2SPM4dHGHbCI8c6Z4jZ2DSQcBZkVsT5h32LSzRVscOsn0CahQ+jYv9RtPx5JFNG2XPalDzHczzpaMPeg9vP8Rkn3QGvPWtfw7D8ti6Db3OwFuirRZ9udjM0YYXBPVD1kdmSSx7JX6WNaaBkmoMUYItQcj/vtz1PBS0hS5zIOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614678; c=relaxed/simple;
	bh=toAVjuke/pygGXRKY/wXVoiJB/xxDFPMBB779RcYWaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrAlCUoaLf7RGh5+1qlNGgnLvr0INWcAfeiyLsZ1vvZ/UHt7uDMVZuoNM1db7QNoZiYg7Qg7FnhGr0O8kBi3YWZP28Np8KfhI9rLyplxNKmeTIOTC1xxH25DBG2NidqwbAVQ7mc6PXlBjCEv3e3ToW3S+Y/8250L4Az5RNrRMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZijfZKN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa3f1a9b-7fee-42f4-9827-b28b1bb3eff6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731614673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pcFK7jw/pPKGjT5evkUQ7HzTJpzDJog3tOiYKbe/zk=;
	b=lZijfZKNX6j0tbzIB5GvIXXWZ+FIT835qwA4jFdNkIvqX6+KkhdBSl1FqQCC5zraQ+QCbQ
	MA2TQ2TdWaryhEH0IRXc6nn9dHapJIUOO5ysDhE9Wo0JFFbhcu2FbUcDz+/DTjd/l4+kp1
	U+zagfWYwO+3YY3C8UYXK7Kz+vfvrFk=
Date: Thu, 14 Nov 2024 12:04:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 song@kernel.org, olsajiri@gmail.com
References: <20241114155822.898466-1-alan.maguire@oracle.com>
 <20241114155822.898466-2-alan.maguire@oracle.com>
 <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
 <80623f0b630bd3761f0239dbe0f3197dcc6ae575.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <80623f0b630bd3761f0239dbe0f3197dcc6ae575.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/14/24 10:21 AM, Eduard Zingerman wrote:
> On Thu, 2024-11-14 at 08:51 -0800, Yonghong Song wrote:
>
> [...]
>
>>> +		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
>>> +		case DW_OP_entry_value:
>>> +		case DW_OP_GNU_entry_value:
>>> +			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
>>> +			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
>>> +			    entry_len == 1) {
>>> +				ret = entry_ops->atom;
>> Could we have more than one DW_OP_entry_value? What if the second one
>> matches execpted_reg? From dwarf5 documentation, there is no say about
>> whether we could have more than one DW_OP_entry_value or not.
>>
>> If we have evidence that only one DW_OP_entry_value will appear in parameter
>> locations, a comment will be needed in the above.
>>
>> Otherwise, let us not do 'goto out' here. Rather, let us compare
>> entry_ops->atom with expected_reg. Do 'ret = entry_ops->atom' and
>> 'goto out' only if entry_ops->atom == expected_reg. Otherwise,
>> the original 'ret' value is preserved.
> Basing on this description in lldb source:
> https://github.com/llvm/llvm-project/blob/1cd981a5f3c89058edd61cdeb1efa3232b1f71e6/lldb/source/Expression/DWARFExpression.cpp#L538
> It would be surprising if DW_OP_entry_value records had different expressions.
> However, there are 50 instances of such behaviour in my clang 18.1.8 built kernel., e.g.:
>
> 0x01f75d14:   DW_TAG_subprogram
>                  DW_AT_low_pc    (0xffffffff818c43a0)
>                  DW_AT_high_pc   (0xffffffff818c43c9)
>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>                  DW_AT_call_all_calls    (true)
>                  DW_AT_name      ("hwcache_align_show")
>                  DW_AT_decl_file ("/home/eddy/work/bpf-next/mm/slub.c")
>                  DW_AT_decl_line (6621)
>                  DW_AT_prototyped        (true)
>                  DW_AT_type      (0x01f51a9b "ssize_t")
>
> 0x01f75d26:     DW_TAG_formal_parameter
>                    DW_AT_location        (indexed (0xa0f) loclist = 0x0062c64f:
>                       [0xffffffff818c43a9, 0xffffffff818c43b5): DW_OP_reg5 RDI
>                       [0xffffffff818c43b5, 0xffffffff818c43c1): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                       [0xffffffff818c43c1, 0xffffffff818c43c9): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
>                    DW_AT_name    ("s")
>                    DW_AT_decl_file       ("/home/eddy/work/bpf-next/mm/slub.c")
>                    DW_AT_decl_line       (6621)
>                    DW_AT_type    (0x01f4f449 "kmem_cache *")
>
> The following change seem not to affect pahole execution time:
>
> @@ -1234,7 +1234,8 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>                              dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
>                              entry_len == 1) {
>                                  ret = entry_ops->atom;
> -                               goto out;
> +                               if (expr->atom == expected_reg)
> +                                       goto out;
>                          }
>                          break;
>                  }

Should we do
			...
			dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
			entry_len == 1 && expr->atom == expected_reg) {
				ret = entry_ops->atom;
				goto out;
		}
		...
?

>
> This question aside, I think the changes fine.
>
> [...]
>


