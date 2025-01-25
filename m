Return-Path: <bpf+bounces-49806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB9A1C3D8
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9523A3A265A
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90902D05E;
	Sat, 25 Jan 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ89AAtA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E335947;
	Sat, 25 Jan 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816733; cv=none; b=RfaVKoxxgjNOt2gRxcVkafO83ORf1u/n7Bl21BnP1frQ8YV1O/BrFSWVJo55uSQoSgOxDdrAzBgT020uyUbxAdrA76snJDxgRQGjZDuzo459Du7PUhF4/ygDbQ2/ifqtvcf3feCYB9wfyl4mfxPuVzvhYSaJzi0l0LgkC5TuuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816733; c=relaxed/simple;
	bh=U8cLi1k6bRitQGFglcYrARlqUklFvkMju3EiAPE1YNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geMaqmb2xH5uaoYb8G02zHpRTo3Gh/zrqgpbXMEsirF3flUXFQ0Dn5rEX1bWkWnRZ7lqPFs1gEMfochF7ArrBPV+NWes3kGjUI5pKfiu2Y6+T7f82nEE1/N+htcqL+YLkdcUr/SW+ZYsJ+wiV4zgpGkBi82SGhOsdy5IKeZxbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ89AAtA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so56117935ad.0;
        Sat, 25 Jan 2025 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737816731; x=1738421531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNuMyLA/pexBhgMV2jzIK6ArauTH0LbZcCgr+1uCTb8=;
        b=NJ89AAtAVrUOtnGZSyt4cDgmG/CtcO6/bszu2GAg4WlvwAqxHzx67fpVpZIUuZ7hl8
         mZ6RxkBa1724ABOEgOWymm8mTeW0lk+jygE3hENbyWY4xeLaJ4EtQ2vk9ziT9FWNHJdS
         T47pXWaWT4WOcSdTEhy2EvKkGHz1Yn0qWcEz07e9t0HH6IUiwa1TMqQ9WJhEzbZdvj5+
         GwRwoSgaiuTSS2Ltxe1wphOdbpoqOSFzMcaeG/gIaTboD25XnnQ4s9Vf6cfSnFf3m+eI
         uY8VTV5WHqtycDJaFWcESMBFT/toGZcBKmyozLyY+1HCTPDRVU6dwIMgAZj+sOa34E7e
         9F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737816731; x=1738421531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNuMyLA/pexBhgMV2jzIK6ArauTH0LbZcCgr+1uCTb8=;
        b=wxl5oicwy2DPGUZ35HgEaW66bEE5RPUjAVuey18pJqI4mbWvwJo2aUQ0ZkpH+zgZcC
         5i0v26+KyM2tUsVcMZmvLSk+Y7SBeEGnxPqpFN9FqPINm0eEgR8d93WRM2oRyBgBtZC8
         bxWlp1g/eRpAzbYHrjlTCoYNaLop876L8drnlWCE0qs1udzVsnBGi838ZEJiX/D++NWl
         m9qw/nrYUDc3gVSL3jQ6sGDdnPEiRZpf/4tk4cXAjwJXNvUNZiv5X1m4zrFTgqYROXXw
         VEs7bCT8usauSXX1cch5iynJVxewp+3NM22yt4dBvWi/6Q9ucd1QakMDUo9b2OkjfmJy
         4kMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Q+EA16p/T5owpyXIAECTf5MD+AA1or6MZFW01i8GBfstO/TAzNmGCUw+2w6dk5DZySY=@vger.kernel.org, AJvYcCUKApjxKe5Xm3OnPHejLq6vLkeDcgo9tbhocjtWFVHUdmrEdGD2Hd6ZY1/1N4EiHQvtOiGzt6ZOFMW+qxpH@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUtJK4hMJUEPd4IuzPEHurhrg4hj0RjgPrYgugpPnwg64Rp2J
	cmsWmbw6njlQdBYR38ZBlCLn4Z1MdOJNJ9R3NAP9QMSIGJQdDJJU
X-Gm-Gg: ASbGncuXRNidcRkhfBj8Mso1ZZ7iB1wHvBsIsR4mzwcCD7IHhc/BhxZoxoXSEsTqdZt
	4Wb9wLaVfxxF86KT2Vtpk7QUIyAzFsvGVszEjIZ7FtEea1CCNujKpKuYjH5j65U1e2fftcJdWqF
	3jXCAB9bJYxfnQxRPxem/4xCtjK87/tE3K+3Lw/inxsf64f0x3wxO5JCvio4VJ2RRVNTQgvu0ne
	ZiW9EowRsEGRAHObSSCDMTQ5Vv8Pz9gu+3ePpSMKULnpEsLgXtCbwWKGQnDbYBvhTVklaeFQdzq
	+w==
X-Google-Smtp-Source: AGHT+IHQ0Mcne477v9UjGfRZ/ngf1o6IFBX8sDKyd5+xdfG4yRMvPKrRk0kBstZrfZmUqJeqp9OE1w==
X-Received: by 2002:a05:6a00:3c8a:b0:725:f4c6:6b68 with SMTP id d2e1a72fcca58-72daf93116bmr49152856b3a.4.1737816730828;
        Sat, 25 Jan 2025 06:52:10 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6c6775sm3784919b3a.73.2025.01.25.06.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 06:52:10 -0800 (PST)
Message-ID: <a043941b-f7d0-4f5a-a2aa-4f47c58370b2@gmail.com>
Date: Sat, 25 Jan 2025 22:52:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: Refactor libbpf_probe_bpf_helper
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-2-chen.dylane@gmail.com> <Z5O_SBFCWY-3yUI-@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z5O_SBFCWY-3yUI-@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/25 00:26, Jiri Olsa 写道:
> On Fri, Jan 24, 2025 at 10:44:09PM +0800, Tao Chen wrote:
>> Extract the common part as probe_func_comm, which will be used in
>> both libbpf_probe_bpf_{helper, kfunc}
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf_probes.c | 38 ++++++++++++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 9dfbe7750f56..b73345977b4e 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -413,22 +413,20 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
>>   	return libbpf_err(ret);
>>   }
>>   
>> -int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>> -			    const void *opts)
>> +static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
>> +			   char *accepted_msgs, size_t msgs_size)
>>   {
>>   	struct bpf_insn insns[] = {
>> -		BPF_EMIT_CALL((__u32)helper_id),
>> +		BPF_EXIT_INSN(),
>>   		BPF_EXIT_INSN(),
> 
> I'd just keep above in libbpf_probe_bpf_helper and pass insns to probe_func_comm,
> seems easier
> 
> jirka
> 

Hi jiri,
Thank you for your review, your suggestion seems better, i will
send it in v4.

>>   	};
>>   	const size_t insn_cnt = ARRAY_SIZE(insns);
>> -	char buf[4096];
>> -	int ret;
>> +	int err;
>>   
>> -	if (opts)
>> -		return libbpf_err(-EINVAL);
>> +	insns[0] = insn;
>>   
>>   	/* we can't successfully load all prog types to check for BPF helper
>> -	 * support, so bail out with -EOPNOTSUPP error
>> +	 * and kfunc support, so bail out with -EOPNOTSUPP error
>>   	 */
>>   	switch (prog_type) {
>>   	case BPF_PROG_TYPE_TRACING:
>> @@ -440,10 +438,26 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
>>   		break;
>>   	}
>>   
>> -	buf[0] = '\0';
>> -	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
>> -	if (ret < 0)
>> -		return libbpf_err(ret);
>> +	accepted_msgs[0] = '\0';
>> +	err = probe_prog_load(prog_type, insns, insn_cnt, accepted_msgs, msgs_size);
>> +	if (err < 0)
>> +		return libbpf_err(err);
>> +
>> +	return 0;
>> +}
>> +
>> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>> +			    const void *opts)
>> +{
>> +	char buf[4096];
>> +	int ret;
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	ret = probe_func_comm(prog_type, BPF_EMIT_CALL((__u32)helper_id), buf, sizeof(buf));
>> +	if (ret)
>> +		return ret;
>>   
>>   	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
>>   	 * at all, it will emit something like "invalid func unknown#181".
>> -- 
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen

