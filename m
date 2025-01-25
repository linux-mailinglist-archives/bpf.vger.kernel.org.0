Return-Path: <bpf+bounces-49808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA5A1C3DE
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365DA16836D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FB35951;
	Sat, 25 Jan 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrIiIE1u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525564A1D;
	Sat, 25 Jan 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816998; cv=none; b=eQad2Gwl01JIVmM/3XdAJnznfg3jRW3uieJvm9pPxp6JPRQIg4Umi3PVzvLC3vZayCzJJtV2PY6WJE2xhBVIqW61RzdTCqzJAtKZqlowau6xIMzGLny93rMf2gVZtOzup6cVXNixzddhYY714+7vCp5l/yUxfyvw4W9S1+zJZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816998; c=relaxed/simple;
	bh=ufT8IEYNlkGZ0VIOw6vL2rHfLbQaKo8blM+qbaZpC6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSdF20FcRfziENqpqbn1f+msryGPjecc5I6y+07SF5emQRI+E07x/Lbds73W2LYYuAeRfBJpSXxwnG3rW6CI+OErFRO9LALow6bK3w6MnDrkSD6RSwbd5h8PfPGZJF5nxMfEtYjfJ3s0B1ydFUBEM/6BRecL6cyu8DtajZAxWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrIiIE1u; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21654fdd5daso52138895ad.1;
        Sat, 25 Jan 2025 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737816996; x=1738421796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOFFEDNzLTkB/mqkmggb3wQzuB50GP3FxTBYITmSkl4=;
        b=SrIiIE1uOju24kU2NW0oezgh9DjtouH1ggKpRKzB8UEMTfd+XJxH6au0Adu2rhZtY4
         Z6YQMBbiAyE7U1tOlrIjdhTR0QRiAnsbZ9cAN5Zw/TqQQJ6iA6KnaEUtoxXIvhkavkcQ
         AIUz9G2zsoAOXm+TwxWel4uaQm/dVcYLaZ/sMW4brRpOvpWQ2yfLrGLE9PL/MLyQfzOd
         HOJwfTA1HlPO8api2sA0QKpGZtac1i5WA1/pKn3tb0hctHxFCTyx/EH+8ROjpJavhLbe
         TzTvz4M7MIf0KhXT+3e8kbVmqGaYgWk7X0ZuiTfv0f6j/nktX5EItX2rPEAyZcSfYVAd
         Lj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737816996; x=1738421796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nOFFEDNzLTkB/mqkmggb3wQzuB50GP3FxTBYITmSkl4=;
        b=Lm+SIeU1zg2cdFUe93Pxm6Zv6UHL84eoCA+czEi6XIkxqsfCcVnTmZo/l5Yi+9ImCX
         2ED0MLNnGcIKA8FdR2mTxkUbu1egp6i+XF/avFSJhtW45AfOflOkEIBpzgS1xR/amfIV
         qgJZchNVi/O7uMAx2LQGfd/bpSa0B49ogNBOguIubOfLF2S9Bj+GD+AM80slU759/7Q8
         kPNqbus0FR7ozfgtga3jie+j5vBL+vifNsOm9H5vFloADM44lGX/KNkoUMOK7qsMwQ2q
         by4jabpAphN0KUp706Xlm51fr/jT6sM/IFnJ9Z9hE4YwTLI3mfOx4n+UKHeqFw1/yD4R
         rqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCULkH2jrFMMofK4o20qmmAmqmh+Z2T5SKUNGLMgQ+W4BXUCWC88jQ693+tFgXitj6iv4P0=@vger.kernel.org, AJvYcCWUW+vHvKWTfvmBnRHfISGaoQ6Kv/y+f4QrsKYDIeQnI5PJjnv+317S7tR2nUhngiFyfNGS5J3A+uraGrnr@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuqjBbp/t7vb7gI+KersG84Byxre1OkgoGMy9PufcdPts1dWv
	VMytOD9xm/5R1RZKTCjwcuynWIIse1E1Wt1HzPXSjzozkgiX7N7r
X-Gm-Gg: ASbGnctCmP5vfCvDEMKhQk4YEgVQKEvhBRew1sYlgyiFP1TIVany1frQVEnGTdsxFMV
	+995vILppS2m8n5snaEIejxYAgerLNKmUoZyGOtSNFGfiRXLn75vLLceOWFA6AAITkyzbjKhJZI
	5umYgbH8yLxu0v1KQoMZ/VGY7EQakKjJuZ3eJjmqM/HyLiaAyIgXGBoQxb3nY4S7jpG+rpPsgVf
	HsqCuD/pATiPoryeFMew486J/DSYZssidxBouwgbVg4BZUSBaGeOLEtFml2ZPZOp4K0RRb1lgvL
	YA==
X-Google-Smtp-Source: AGHT+IEZdILOnuVfSCRpRfQ/G1Q06mZ+oDF+SeYuRyiQr9PvjPxktiSLhAAIPwdeIqcGUzciUgTNgQ==
X-Received: by 2002:a17:902:e952:b0:216:760c:3879 with SMTP id d9443c01a7336-21c355f03cfmr493487145ad.46.1737816996496;
        Sat, 25 Jan 2025 06:56:36 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424e869sm33293485ad.214.2025.01.25.06.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 06:56:36 -0800 (PST)
Message-ID: <63f24d23-2efd-4fb2-a637-68765b1f7df9@gmail.com>
Date: Sat, 25 Jan 2025 22:56:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add libbpf_probe_bpf_kfunc
 API selftests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-4-chen.dylane@gmail.com> <Z5O_bNToXdn01f4B@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z5O_bNToXdn01f4B@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/25 00:27, Jiri Olsa 写道:
> On Fri, Jan 24, 2025 at 10:44:11PM +0800, Tao Chen wrote:
>> Add selftests for prog_kfunc feature probing.
>>   ./test_progs -t libbpf_probe_kfuncs
>>   #153     libbpf_probe_kfuncs:OK
>>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> index 4ed46ed58a7b..d9d69941f694 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
>> @@ -126,3 +126,38 @@ void test_libbpf_probe_helpers(void)
>>   		ASSERT_EQ(res, d->supported, buf);
>>   	}
>>   }
>> +
>> +void test_libbpf_probe_kfuncs(void)
>> +{
>> +	int ret, kfunc_id;
>> +	char *kfunc = "bpf_cpumask_create";
>> +	struct btf *btf;
>> +
>> +	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
>> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
>> +		return;
>> +
>> +	kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
>> +	if (!ASSERT_GT(kfunc_id, 0, kfunc))
>> +		goto cleanup;
>> +
>> +	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
>> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0, NULL);
>> +	ASSERT_EQ(ret, 1, kfunc);
>> +
>> +	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
>> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0, NULL);
>> +	ASSERT_EQ(ret, 0, kfunc);
>> +
>> +	/* invalid kfunc id */
>> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL);
>> +	ASSERT_EQ(ret, 0, "invalid kfunc id:-1");
>> +
>> +	/* invalid prog type */
>> +	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
>> +	if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
>> +		goto cleanup;
> 
> nit no need for the goto
> 
> jirka
> 

Ack. Will fix.

>> +
>> +cleanup:
>> +	btf__free(btf);
>> +}
>> -- 
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen

