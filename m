Return-Path: <bpf+bounces-52240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B44A4053E
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 04:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354E419E325B
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920C1E2847;
	Sat, 22 Feb 2025 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZhDcaJjW"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26CEEDE
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193276; cv=none; b=C0lhk5Pz/VFZYm2SJIDz1Wsvc7SN4W3vx26GlstXH+gdJ6n4iPDNTQJBE8kwXu2tEJ/B+qZJLvvKWj9whiWpSZoNWykus1jz//M39sZWkRsIAISe86d2V8R0TCc1eJP0w6HTu0LZbOMHH8i/ar48qIHAntNgqsXmZtuhmwhy7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193276; c=relaxed/simple;
	bh=ZOJUc7908s6v3aPgIOk+AQRLD1psJvVNRZf7IPLFPW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI4WkrpdSXJAnfjCAoKKcg++fHOX1pVTckKcqVq8d8c3lxDzv/CQ5itBdVp6DjS4R3BKGEtZ+Hh79gWY61ZFgm+1/vbNZ0p8NWMqZ2ejxVL87H2QwzZAdxVYZEDumZpsl1lU44Cc7tUaCLBNVScGpdlA7xpqAIkJO6Pa2DbGoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZhDcaJjW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e52990a8-32d3-487e-ad1a-8ad95f322806@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740193271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiWFpDdL4A7YTKLURfXRoHywJpFk36w4rMNGrCCt670=;
	b=ZhDcaJjWeduO/PhQg5tpAbsdib+drANcBvhH3m0pHBNWFbgMJdqIxHAysdJghyl2s4L8DV
	eQM28eVBm5VSClElS0vW5ak0M73+CB7zNwAzTm56nybp92G3e9TJzlgKvXp5tHRN1Lpqjw
	2R5Xjny16/j7liC4SOSv4T48Zwu/1Oc=
Date: Sat, 22 Feb 2025 11:00:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc
 API selftests
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com,
 Tao Chen <dylane.chen@didiglobal.com>
References: <20250221163335.262143-1-chen.dylane@linux.dev>
 <20250221163335.262143-5-chen.dylane@linux.dev>
 <d3dacc81d79d67f1c4372adc2517176bed57fadd.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <d3dacc81d79d67f1c4372adc2517176bed57fadd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/22 02:19, Eduard Zingerman 写道:
> On Sat, 2025-02-22 at 00:33 +0800, Tao Chen wrote:
> 
> [...]
> 
>> +static const struct {
>> +	const char *name;
>> +	int code;
>> +} program_types[] = {
>> +#define _T(n) { #n, BPF_PROG_TYPE_##n }
>> +	_T(KPROBE),
>> +	_T(XDP),
>> +	_T(SYSCALL),
>> +	_T(SCHED_CLS),
>> +	_T(SCHED_ACT),
>> +	_T(SK_SKB),
>> +	_T(SOCKET_FILTER),
>> +	_T(CGROUP_SKB),
>> +	_T(LWT_OUT),
>> +	_T(LWT_IN),
>> +	_T(LWT_XMIT),
>> +	_T(LWT_SEG6LOCAL),
>> +	_T(NETFILTER),
>> +	_T(CGROUP_SOCK_ADDR),
>> +	_T(SCHED_ACT)
>> +#undef _T
>> +};
>> +
>> +void test_libbpf_probe_kfuncs_many(void)
>> +{
> 
> Hi Tao,
> 
> Sorry, probably some miscommunication from my side.
> I did not mean this test for inclusion, it was meant as a one time
> manual inspection of libbpf_probe_bpf_kfunc results.
> Just as a sanity check before series is merged.
> As an automated test it does not provide much meaningful signal.
> 

Ok, i will resend v8 without this case, and check all the prog types 
later with your program. Thanks.

>> +	int i, kfunc_id, ret, id;
>> +	const struct btf_type *t;
>> +	struct btf *btf = NULL;
>> +	const char *kfunc;
>> +	const char *tag;
>> +
>> +	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
>> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
>> +		return;
>> +	for (id = 0; id < btf__type_cnt(btf); ++id) {
>> +		t = btf__type_by_id(btf, id);
>> +		if (!t)
>> +			continue;
>> +		if (!btf_is_decl_tag(t))
>> +			continue;
>> +		tag = btf__name_by_offset(btf, t->name_off);
>> +		if (strcmp(tag, "bpf_kfunc") != 0)
>> +			continue;
>> +		kfunc_id = t->type;
>> +		t = btf__type_by_id(btf, kfunc_id);
>> +		if (!btf_is_func(t))
>> +			continue;
>> +		kfunc = btf__name_by_offset(btf, t->name_off);
>> +		for (i = 0; i < ARRAY_SIZE(program_types); ++i) {
>> +			ret = libbpf_probe_bpf_kfunc(program_types[i].code,
>> +						     kfunc_id, -1, NULL);
>> +			if (ret < 0) {
>> +				ASSERT_FAIL("kfunc:%s use prog type:%d",
>> +				      kfunc, program_types[i].code);
>> +				goto cleanup;
>> +			}
>> +		}
>> +	}
>> +cleanup:
>> +	btf__free(btf);
>> +}
> 
> 


-- 
Best Regards
Tao Chen

