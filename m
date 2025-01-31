Return-Path: <bpf+bounces-50183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A332A2391C
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 04:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6477E16421E
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC149659;
	Fri, 31 Jan 2025 03:56:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92324B28
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738295774; cv=none; b=tkHyHTpI2sqlT1G0Zh0Vx3Rm1CojSYshHPpG3fOz7DKHXH9fJAGv4pKaY2rLTx0rdBczZwgvzF306ELoB6LA/DIg/86HezEIYRBpTWNgKJ6RzpkPK/XpmEOdpCJWTbEPFtK1BW/IGhx6bK02lpxPIlzFfYIVv+KSRWDpCs+hMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738295774; c=relaxed/simple;
	bh=w5w4PHd5PtrNe6AcdcZvsuZlIRfFlIldykWTm9ocYYY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=NehGJ/fSl7TbzOjzD6Y7yHOZOjiN4O+jsr7/PDoAbESl2XiMDjlq6s53VeOef8ZvGXs/jN/Ixvu3G1D8Mly1HXu4k86aYs2m/13v127An/ruh8S9qHsx0dlRKAoY1CJatXUzjQZSwqvEM9W1xd0FZXq3SOaN6cgPYN35YutMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 31 Jan 2025 03:55:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <73a6da135f042c06a8646627078e2699d6bdf2a2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 5/6] bpf: allow kind_flag for BTF type and
 decl tags
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 jose.marchesi@oracle.com
In-Reply-To: <18d4d2c22ae66601fee7a604c1b0c8185ce9f430.camel@gmail.com>
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
 <20250130201239.1429648-6-ihor.solodrai@linux.dev>
 <18d4d2c22ae66601fee7a604c1b0c8185ce9f430.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 1/30/25 6:55 PM, Eduard Zingerman wrote:
> On Thu, 2025-01-30 at 12:12 -0800, Ihor Solodrai wrote:
>> BTF type tags and decl tags now may have info->kflag set to 1,
>> changing the semantics of the tag.
>>
>> Change BTF verification to permit BTF that makes use of this feature:
>>   * remove kflag check in btf_decl_tag_check_meta(), as both values
>>     are valid
>>   * allow kflag to be set for BTF_KIND_TYPE_TAG type in
>>     btf_ref_type_check_meta()
>>
>> Make sure kind_flag is NOT set when checking for specific BTF tags,
>> such as "kptr", "user" etc.
>>
>> Modify a selftest checking for kflag in decl_tag accordingly.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>
> Double checked all places where btf_type_is_type_tag() and
> btf_type_kflag() are used. The changes look correct.
>
> btf_type_is_type_tag() is used in 7 places, in 4 such places it is
> used in conjunction with !btf_type_kflag(t). Not sure if embedding
> btf_type_kflag(t) in btf_type_is_type_tag() makes sense.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Yeah, I briefly entertained a thought of checking the flag directly in
btf_type_is_type_tag(), but decided it'll be too confusing.

btf_type_is_type_tag() currently just checks for the type kind, which
is an obvious behavior. If we check for a flag there, then we have to
introduce btf_type_is_type_attr() or something like that, except that
it would not correspond to a type kind.

A complication of API with no benefits IMO.

>
> [...]
>

