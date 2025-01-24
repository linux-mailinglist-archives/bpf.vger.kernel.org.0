Return-Path: <bpf+bounces-49640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A8A1AF04
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F10D3A7A6C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343621D5CDD;
	Fri, 24 Jan 2025 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThkbKwkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDF1EA65;
	Fri, 24 Jan 2025 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689151; cv=none; b=H0tsc1JKir6Q3z2XEiIg4Dm/EyexpzuzUtgtmbmmsKFQ2V7URm/ylvcuuQ5LSEgm1Q5LnSFpA7/DF0Ej0EoULrni6LyxFRoAdLw08iqNhoAWSkOG3Oz3iF1o6lsfKbGYhPPgEfF54sLB4KeJUR3kQhPa8FjYIq7T34IpsXFk2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689151; c=relaxed/simple;
	bh=ax7XbfWcKbt5yjczkVmgtPM55WKRAhHmlNhQPpd5lQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeYlC98CHou+8iS+ecch0vamWc4R2+6nDiOgswxJMZdigarwTxXjlC4fTZYI6/bpml+Dh8A0VvRENsslcQuGhehbye28q159VtjijKZWU6rx9xK3EwfBUZJxD/qi0KjG8PUVuj6LvnZeCXVTKw/+EGHCeHGeKZNXJ6ou6IXSkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThkbKwkE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2395650a91.2;
        Thu, 23 Jan 2025 19:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737689149; x=1738293949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/ECpJkR7GYET+qVSMn+RFF99ZF7dKGAJmUmgk6cSuY=;
        b=ThkbKwkEeqbex3AmUox7rw7C9aOs3MnAMNO5tSlprEQADUA+kyC7SIz9OPKBQyEPG5
         AMzdOhrrKo/o6nC/VwE7X04sS2ndLNBQPWjE3/O6URH0Qygu9RscmgvbFtYgOKk4McMp
         6zaWP3wSoMhagyBpTH+L+SsDTPcp3ojV0xDfLn8FmTxQgQQeEP4HUBaHsaCJrJzV8hRf
         Ak4gHOQZRbBnEbR+4qE/BMBOPqASVrFOKtBmGIvta4wm+jGBowiBbl4EV7CoguSKeFOq
         NvkMEp3XHJdJ608LCDHKdkLW2bDF9TSMPwCxQi8EAO6XhJRJVdL0bYcnVgeesvtHjr2o
         X6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689149; x=1738293949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L/ECpJkR7GYET+qVSMn+RFF99ZF7dKGAJmUmgk6cSuY=;
        b=GSFh+2RqzG+i1N59HAT0xb2nJGy++C9raUe3nMuEmmC5dRCB6wxL+Soe0ghpMF0SFS
         rbvgnkzxz0/QdesvTNAvM3hfK9Q1Y4EfoJgC2g471RldPfIFL+v35S7lg7q0oEbYfTP8
         2UMsVyMYnz2VA9uvLGi794dSIibsWz2neC3RZkPTmee/dfK0J1rPT3eWrHYLCPGokhbu
         2ExhYZEjnrEybE3LfHNMG2TXQmKJVM/CILqVNteLKkvbnGL//0F+33iSC7yUlwM5FUTw
         sTZw6pb2eT4IKVRUYSBFHrDsfLeekDezu2mebgL36YhnX78cm/845Cj/eZvO9l2DlgSO
         bXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzqs6SZl8eYA0wg5LpBSsDdLoO6SEJ1bt7UVJZwSifqXcq7k/CBNXdSI07/t7b/O6N7XQPmJXhWpXQ/Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/d15/VC4UiEiCJurGCCMbGWn3O/FPCEuqt6gaVcudKh7SqAdc
	tWuMcjE6gBsCVlERWyYtcMh0mluXQMqV7bsAfNoed5IiiNh/VufO
X-Gm-Gg: ASbGncsP2TU/RKDu43hCp9aNAGCGOM7X0rwQjyHLmU+trWctymO5B8ECCEDzswlviqe
	ZGAr+ZphxQKzzEnWvlvwvEjR4zAs6oaOiZMHIeJSowEefzqPEs+htHxZ4rsiZUda5NiASxudlMc
	BnyiSEa1uObhDTYVoPinGLhwz49uY0Iciqz51xJMgKUbZVq8oybgt0DZozLcLVuOFk8lyVacBVh
	07NhgRQ8oUDxavCufcerT5eDkDtcHy5WqKN9zoE8KLPvDbAykoTEMCOIfzcl+sZqSbVXbc3+gsz
	Qt12vagufWWulRCEg6lPe2SS
X-Google-Smtp-Source: AGHT+IFb6t3SNsWxFNp3lf1In29j0OdQkDSNt9lBvbNzjc3FdOmxSvOzgxoKDKXro7wXs9GsLYaIyQ==
X-Received: by 2002:a17:90b:1f92:b0:2ee:db8a:29d0 with SMTP id 98e67ed59e1d1-2f782d4f3edmr35747682a91.26.1737689148214;
        Thu, 23 Jan 2025 19:25:48 -0800 (PST)
Received: from [172.23.160.121] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6be09sm505317a91.28.2025.01.23.19.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 19:25:47 -0800 (PST)
Message-ID: <26e2e47f-4c95-4874-969f-c497aadbb5f0@gmail.com>
Date: Fri, 24 Jan 2025 11:25:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123170555.291896-1-chen.dylane@gmail.com>
 <20250123170555.291896-2-chen.dylane@gmail.com>
 <8d286a6b2a5f481e1eb23466c199a1b05ec81a88.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <8d286a6b2a5f481e1eb23466c199a1b05ec81a88.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/24 09:34, Eduard Zingerman 写道:
> On Fri, 2025-01-24 at 01:05 +0800, Tao Chen wrote:
> 
> [...]
> 
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
>> +			   __s16 off, const void *opts)
>                                   ^^^
> Nit:                      maybe name this btf_fd?

Hi Eduard, thank you for your guidance, ack, i will send it in v3.

> 
>> +{
> 
> In v2 function looks identical to libbpf_probe_bpf_helper,
> do we want to copy-paste it or introduce a utility:
> 
>    static int probe_insn(enum bpf_prog_type prog_type, struct bpf_insn insn,
>                          const char **accepted_msgs)
> 
> And call it from both libbpf_probe_bpf_{helper,kfunc}?

Yes, it seems much more concise. I will send it in v3. Thanks.

> 
>> +	struct bpf_insn insns[] = {
>> +		BPF_EXIT_INSN(),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	const size_t insn_cnt = ARRAY_SIZE(insns);
>> +	int err;
>> +	char buf[4096];
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	/* Same logic as probe_bpf_helper check */
>> +	switch (prog_type) {
>> +	case BPF_PROG_TYPE_TRACING:
>> +	case BPF_PROG_TYPE_EXT:
>> +	case BPF_PROG_TYPE_LSM:
>> +	case BPF_PROG_TYPE_STRUCT_OPS:
>> +		return -EOPNOTSUPP;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	insns[0].code = BPF_JMP | BPF_CALL;
>> +	insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
>> +	insns[0].imm = kfunc_id;
>> +	insns[0].off = off;
>> +
>> +	buf[0] = '\0';
>> +	err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
>> +	if (err < 0)
>> +		return libbpf_err(err);
>> +
>> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +	 * given BPF program type, it will emit "calling kernel function
>> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
>> +	 * it will emit "kernel btf_id 4294967295 is not a function"
>> +	 */
>> +	if (err == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function")))
>> +		return 0;
>> +
>> +	return 1; /* assume supported */
>> +}
>> +
>>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>   			    const void *opts)
>>   {
> 
> 


-- 
Best Regards
Dylane Chen

