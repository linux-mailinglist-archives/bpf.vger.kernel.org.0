Return-Path: <bpf+bounces-70419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC0BBDED6
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67DC94EA069
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6AF271454;
	Mon,  6 Oct 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBhjTOb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0034BA3A
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751669; cv=none; b=H4JonRADtv1pOJbTdnmdg/V2MpsIvi6u46tdWLDGmnChE3koACBNvYTB/5JkcY2w17yXSOSD1Nqv9HQPKIljzrdeKY219GA1MSuRw1XcAPYG9w/U9UUpMSNFatRJZEOlswh0vMopQWgsdBoIjUN+eotvFnuM5k/D5dIMB3FBWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751669; c=relaxed/simple;
	bh=i9uqsNT8rzXv/9EvNvLZhyocTOen2CGKBN8AJEgArZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp5AhjLBhVwZQlsHL8pKHvetMJlh3gUvUej8l0idWXVoNYtSgFrk6PAc8F/YTN/Rtq1CORxI3p2R8IF3zG1iPOCDqdb+TeCG/z7e1IPZWRX80M9nTqXDRePr97mq4m5AiO802AsAV2XquijK75D86et8LOB+oZCi1q6+cJukNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBhjTOb1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso29558165e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759751666; x=1760356466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m60T0hNEVBmnWG3wzqmTKTjrvxrAYcamiIcA8lZgnA=;
        b=lBhjTOb1OZrfbz8I9btz0vfyJJA0wzndKVORyHbEavJhIDq0bDMewQLPMAWc0uk4U+
         EBCx4ZznYUJUVLglX3lsQ3dYEex03aLDehgp8tks+MNpaDLYyS0Y7DhVosvHUsDJl66O
         tWFBRpMGhIAI08x5L9Ai+s+V4bX3LRtTFBWJEDfqTkblUnsv+gOZmCoHNRfUFlvEtFbO
         OFHJP/JY/73o1RMP4ltzY3Gi169yNscAEUSi2Wf7n7rufkHSaPp2B3PWrBX6t+3OM5n+
         hRoOSfg/SwMC4XsbcB1P769Jcl3TwlSbczlv5qFplxXbx7+7klXCkQhTe36BT6IzGd+C
         oVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751666; x=1760356466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m60T0hNEVBmnWG3wzqmTKTjrvxrAYcamiIcA8lZgnA=;
        b=JCWhOHXbg8JsKnIm6aESJkRjuTnatTe6jw+UA/psEVq9/08IrvSgfG9op2xjUzUh/+
         MR+dy6ezEJSVzbemi/i+3KOaAGUKrmK5JmdFUBBf1YYniED8T+NRNRMIDKGvYUr7tCi7
         bbkVISFQGUI37Db0z0fs6YU5rnAO9CRez+Fa5DC94NJ7blWu+x5iMTE9+IDRNdAnpCQm
         q6kl/OInsVVuLVTeoxt8YmPDea+q7ljsbbcAH7kA1EjD89vb8cbv1vUotJv0f9uXFdPR
         Rz0IO2ny34lS30KOVN8qe3WBbszWpRUNfTtJwT9KWNkCW0xUjutW9853pVyZojJonEwm
         hdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL03ljmx1AOseeSFyzAj3JfZT/0GPIhWgfckgSzP9h2/AEmAteOpSgOq3NXca8GGVMR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStJzUHdmSP1EKdQYkKbPMTkQXobWOxag8eTW1JBJA1hBc83hk
	f4BFGAcJxbNSiLkGIeRUuR/ahL8Lc4fsdmV2ks+MWRSJ1R72Pu7ejVW3
X-Gm-Gg: ASbGncsuJi5KhhLDS4z6nbohWRZT651kgGs+V375q9vFcCdXBmQ9XJ9OlE2N30p3hgY
	SQLw4nNMRA0v/SIxxbz++W6PKs9Mjsc5PI9s10UK13muK9Zg4MtHHDh/PLX8EEH+TtidUYRBFpH
	wfok6JNc+RErkUBeosxK9vw+3r4YOGXwbtx8tbFiaYS0VOEvaVzjRiOlhUN87dC3omTzwQ9clFk
	3rqas5NFPdtufCMPSdSkDYlVG7R5t4k3IxW6SoH3GNhDwlJ0DKFjpbAlsLb+KcS8YHJTkhO/dta
	lEHl6SsdzMXGCmiUtkBdr2U/JL+5+IHT2n53nLLJoPMbgieqvGoVr8K03wJXrog7tyAKv0csLeL
	K5OpyifFb6yTpjZM/+6fM2uADdw5/eqhAm8G8MyN5l4ifQDgj+AvPOOuatJohyFbd/VmqfHRRNB
	IOIDL3iFs=
X-Google-Smtp-Source: AGHT+IFXX9iXDoIIpGAL+MbUKNzImwWdEgRUDmsQT3SjAREz3WuHSAOyVUAjvZt9CCz5Y3eL+ONSpg==
X-Received: by 2002:a05:600c:4fc6:b0:46c:adf8:c845 with SMTP id 5b1f17b1804b1-46e71124395mr97653725e9.16.1759751665573;
        Mon, 06 Oct 2025 04:54:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:7da0:ba20:3ec:edc7? ([2620:10d:c092:500::5:6287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e0asm161986165e9.12.2025.10.06.04.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:54:25 -0700 (PDT)
Message-ID: <1b1c9d10-efff-4eaf-8ff3-0d4ff6e24eb1@gmail.com>
Date: Mon, 6 Oct 2025 12:54:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
 <47e2812f633ad990f6d1a38234d99bc1e6c3bd87.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <47e2812f633ad990f6d1a38234d99bc1e6c3bd87.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 23:24, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
>> new file mode 100644
>> index 000000000000..9dd9a68f3563
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> Do we really need an example of ELF parsing in selftests?
> Maybe just stick to smaller test cases, exercising specific behaviors?
This may be a good idea, I implemented ELF parsing as a proof of concept,
to make sure we reach the goal.
For the selftests, maybe just verifying that the contents of the
file seen in BPF is the same as userspace is good enough.
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>> new file mode 100644
>> index 000000000000..449c4f9a1c74
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> [...]
>
>> +static long process_vma_unreleased_ref(struct task_struct *task, struct vm_area_struct *vma,
>> +				       void *data)
>> +{
>> +	struct bpf_dynptr dynptr;
>> +
>> +	if (!vma->vm_file)
>> +		return 1;
>> +
>> +	err = bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
>> +	return err ? 1 : 0;
>> +}
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +__failure __msg("Unreleased reference id=") int on_nanosleep_unreleased_ref(void *ctx)
>> +{
>> +	struct task_struct *task = bpf_get_current_task_btf();
>> +
>> +	bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unreleased_ref, NULL, 0);
> Why testing this via callback?
>
>> +	return 0;
>> +}
> [...]


