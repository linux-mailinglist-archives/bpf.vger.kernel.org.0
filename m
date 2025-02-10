Return-Path: <bpf+bounces-50938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C70A2E7EC
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E07188A4FC
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2331C4A13;
	Mon, 10 Feb 2025 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vlg0l6Pd"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F11C3C0D
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180159; cv=none; b=TlYhQ/syEetHs+w5ZDZ7XAAxOSeTiBS45KjQGbGYs9oL+utFAabmkYYmBTBhXwDWNJaoV5+Ia92eGcFNr8Ge/g9qJ2KA0iNRkXhyQ12ZdYaO9Oms7mRagNlI2GAYYcJvFXlHYgWck3rA0XNCfhhGNmVxq6cEwFPkQ/XyCBy/CuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180159; c=relaxed/simple;
	bh=sdCThKiC/fJYoe838UwlxWVdA94tm4MVvKcauljaDIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6JSdOHk+qq5U8FDNQgZDn5tDwDX3WqSuFfF2JHXA2jGn8H9HO6qy4RvNRhbkII0xkGtqveLPxoy2esmhRMZDpLrP0xci9HVmdEm+fHXN4MQZ37P3jsQ8vN7y56pHSxK5EVinqXURhuYONXZwg9VJL98cVQSFuD/FvceYIAG5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vlg0l6Pd; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3134f8da-1d2e-4d91-aeaf-477848f70cdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739180151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvMvlo5rT+V38egx19J85qzbkoolO3ooa29kyQ9cBGA=;
	b=Vlg0l6PdeJk555/yYSJg6EEYx7U9EeEss5hp6NFLm5iLBLbDxIqV9AdzvOoxgCtDpCJQ5G
	pU+c88Bg0/Igmp8QeuCNI6uQd63DYtXfEaf+qI3mi9GE/alMkjX/Fc0ANFGxRSV6y5O5tH
	Uj94pQmwzAjtui2/m9n8RHNdFuBrDxA=
Date: Mon, 10 Feb 2025 17:35:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Introduce global percpu data
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250127162158.84906-1-leon.hwang@linux.dev>
 <20250127162158.84906-2-leon.hwang@linux.dev>
 <CAADnVQJu3KCOQFP6M2MSaan2jZSYrQEa=1+ZS=XfbpnV=iGmZw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJu3KCOQFP6M2MSaan2jZSYrQEa=1+ZS=XfbpnV=iGmZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/2/25 08:23, Alexei Starovoitov wrote:
> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> +
>> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map,
>> +                                             u64 imm, u32 *off)
>> +{
>> +       struct bpf_array *array = container_of(map, struct bpf_array, map);
>> +       u64 base = (u64) array->pptrs[0];
>> +       u64 range = array->elem_size;
>> +
>> +       if (map->max_entries != 1)
>> +               return -EOPNOTSUPP;
>> +       if (imm < base || imm >= base + range)
>> +               return -ENOENT;
>> +       if (!bpf_jit_supports_percpu_insn())
>> +               return -EOPNOTSUPP;
>> +
>> +       *off = imm - base;
>> +       return 0;
>> +}
> 
> Pls add a selftest for off != 0.
> I think the above should work, but this is not obvious.
> 

Ack.

>>
>> +#ifdef CONFIG_SMP
>> +               if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
>> +                   (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
>> +                    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
> 
> Is there a selftest for BPF_PSEUDO_MAP_IDX_VALUE part ?
> I couldn't find it.

Do you mean add a selftest with 'bpftool gen skeleton -L'?

Indeed, it's better to test it.

Thanks,
Leon


