Return-Path: <bpf+bounces-63411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A48B06D33
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 07:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A10C16C71C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDCA29C33F;
	Wed, 16 Jul 2025 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAJyDpX1"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3812652A4
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643784; cv=none; b=OC7E+Sa/hlYVn2WaVoQzSVt4pp1HFye4PtxCzE4izTJrDmdEgaWSSoFqAsz/RqnN/oJKDNdBV3JRlMR+f6L9ewP62ZKP1fePhULhLp0R/glbbcMUVpRtoL1tUZJZALvRAKoSItPu7iodhylG9T8b+dSrROGIHvVDMfXx183tXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643784; c=relaxed/simple;
	bh=aRIDWx0Vo97BwUWY6RDNUAmXF5pxa+CZ6zSfpPXD2e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f19VUABY/us8jZlQVJ9Waa7bHodtqUQZ1IFT691vKjPgujFFjJO/Yjo1WsuyiCEyvzpxa+KCBK2wEl0lBtlQhNYnsSV5I7Fa3BDieYoZm3wUwJs6bo+5fyMCtG2nMZsdCiKWIHwPZvtgsD5DdEVDS6K8A/j88OtmTFrhDwp3YjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAJyDpX1; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31dac2d6-da40-4b7c-a8ca-d67891e7326d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752643780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcry2zWRJ5O/NvpFg8ru9gzwxCAkaTiLYWddxO8g8so=;
	b=VAJyDpX1ht9X+Jz6Hefw4NKQJqumbU7V+YtCslIwIYMCG7acz5ccjUU170FSB1dp6Wn/xk
	wRaBzSwMuVVuo4DqHtmUs2DOCJe5+twWHtCJA6qSL3iMxFwDtBDckJwloG+KLwPkUXYchO
	koKerLF/l/MsZQa/VM3jT2iSANSe28k=
Date: Wed, 16 Jul 2025 13:29:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add struct bpf_token_info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715035831.1094282-1-chen.dylane@linux.dev>
 <CAEf4BzbkfhqfpBt49h7SXYwbR1SK423pqf1328i8XujofjLYhQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbkfhqfpBt49h7SXYwbR1SK423pqf1328i8XujofjLYhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/16 05:52, Andrii Nakryiko 写道:
> On Mon, Jul 14, 2025 at 8:59 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
>> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
>> already used to get BPF object info, so we can also get token info with
>> this cmd.
>> One usage scenario, when program runs failed with token, because of
>> the permission failure, we can report what BPF token is allowing with
>> this API for debugging.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/bpf.h            | 11 +++++++++++
>>   include/uapi/linux/bpf.h       |  8 ++++++++
>>   kernel/bpf/syscall.c           | 18 ++++++++++++++++++
>>   kernel/bpf/token.c             | 28 +++++++++++++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |  8 ++++++++
>>   5 files changed, 72 insertions(+), 1 deletion(-)
>>
> 
> LGTM, but see a nit below and in selftest patch
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
>>
>> +int bpf_token_get_info_by_fd(struct bpf_token *token,
>> +                            const union bpf_attr *attr,
>> +                            union bpf_attr __user *uattr)
>> +{
>> +       struct bpf_token_info __user *uinfo;
>> +       struct bpf_token_info info;
>> +       u32 info_copy, uinfo_len;
>> +
>> +       uinfo = u64_to_user_ptr(attr->info.info);
>> +       uinfo_len = attr->info.info_len;
>> +
>> +       info_copy = min_t(u32, uinfo_len, sizeof(info));
> 
> you don't use info_len past this point, so just reassign it instead of
> adding another variable (info_copy); seems like some other
> get_info_by_fd functions use the same approach
> 

will change it in v3, thanks.

>> +       memset(&info, 0, sizeof(info));
>> +
>> +       info.allowed_cmds = token->allowed_cmds;
>> +       info.allowed_maps = token->allowed_maps;
>> +       info.allowed_progs = token->allowed_progs;
>> +       info.allowed_attachs = token->allowed_attachs;
>> +
>> +       if (copy_to_user(uinfo, &info, info_copy) ||
>> +           put_user(info_copy, &uattr->info.info_len))
>> +               return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +
> 
> [...]


-- 
Best Regards
Tao Chen

