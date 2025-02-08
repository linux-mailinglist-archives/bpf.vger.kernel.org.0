Return-Path: <bpf+bounces-50868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9AA2D6EB
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DAB3A79A9
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E12500AF;
	Sat,  8 Feb 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZHw5krk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FD13EFE3;
	Sat,  8 Feb 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029063; cv=none; b=NHj2h5wzw515e4BBPeXfyfEx94UPS3JJntIxppREV89Z9UFdCb/LXwSr81dYt/+kNapwDaKuocpN4fdgVM2iihKSpY/kMvmlcfmCaihRNRrzWrySi16awB6J73sQ6GzPY0P+spcE3Hn8hax+oGVI5renOr3r0GNDZ4/2BRocyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029063; c=relaxed/simple;
	bh=VWCQV1asK8mkBC5s9MXTmP3MYrgvswMj5EQIzW1lZ+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZata5OxdjV5FEnNPNW+wD/Oxto/rJLreP6TYwx0YCPz4VAVYqxKDYxon8xEBij1CFrRox+Zwh9z3y8H4lnR3o3Wbwy85NT0NaCpELbEz5BQVW66DgSom2KqfZ7++OGGnkGlo6mfxis+uCDYeIsaTNK6qg0uuXnHvBTX0xJBmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZHw5krk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa44590eebso1197901a91.3;
        Sat, 08 Feb 2025 07:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739029061; x=1739633861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkMGKQ7AKClIujpM9LEQv3XkqSpczhRaDa7fxIiDIII=;
        b=AZHw5krk9RHxrj2N0FBYEJUwbM5D8EnIWdaiBC0dJFAXL1/z4YsG4xFG6cz33iN6pL
         jZQpycoMnc5RLOzrgBlOBrg7GYfkGtlR/Bym0okuw96C+l+pGIHcOV155/U9Cz17f8Uk
         0G5pl1bXQODCM5/O4jtAWyWi7fCkhJEE6/I5FfoX/uoIlp3PDJJX4o+mYhdf9UD7LZlK
         Vg44Njvpc2bRaGP9FVv9DPey7IODqiBbHMs7XS4msgge/a/Ww+CdLJGMqfMoLY4cLYNH
         UgPta1cHn+5Nd74cunYXhKcSWzbs8NcI33FO47GEg8uv2JHk0yM1RoRuEPfm0qcpNdLq
         qWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739029061; x=1739633861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tkMGKQ7AKClIujpM9LEQv3XkqSpczhRaDa7fxIiDIII=;
        b=Hgg4XnFmkwsXw5Ho374+Z7EN2UPCCx4LEL2maCU6E67l/a167iAp9lQjykiKelmx/0
         7yIu5UA/FUS8wZqgCg8mQQ7JwyFNOzj+qq4lp+IJNgJks/yqzFwpOoaPb0dhSH5xTIZ6
         KPPVpuxuQnd4BWT9DYp74nw3s6q9h7io9keuiLiv0NYS2vnkG07qddnIpxFPGFDkjVJg
         KClwmtf7K5NTtIq2UrPZTUIKIdscoW/aiR74nMiAoS6L59VkuRe1oUMu7mQnbnKwhDq/
         DLmeJPTC+n0fIWRBGMiEBO0iF31f1MOzeIgTUwn1JMEt82ac3lTuLsuodhAbtEGy1yg2
         a2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWDVeJWUYHGmUaxLmLkK0eF7PyVwFtudv4J3PBa9YypLz+khsIR7bGxLs9IPYRQT98XY9XanK56aaazMtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOC5IzYds1PSQans7Wy/BnmAYzu6PtP/bXd+CM3fIxiJgM7vne
	aKLomfd1rOpB+Zrd2yySuEqtspxSNHtwNc5RWgmVBjaN8/rePD8A
X-Gm-Gg: ASbGncs4qyBiCpekFNHngPBIZHu+WetsNU7FXfL0z5zRfh7wiHVKM9ELOa1vw3mvz/Y
	uIzJ/1vK+XwoL2pMmxmdnKjO6KPbPl7dbalM0udd+uwXGXMbU1S7OEzN0oKQgiM/JOb4P6EE4mc
	6i/f/bNSzN53BwLt+109srw6d9P8xH442I6kIZXAFfTIr+mkP54QbDoj8zmFJHcy8hUONpw4P39
	BRPWXRoCrmNzfQuT+uzLLdxCDLfefi6Uok/ZBqtnYEraIINlD1vifcto2eMCKAHZJPzh6NhhB8S
	cQpYA85p4R1gCY81XkxwC0X6Emx0wSSzTw==
X-Google-Smtp-Source: AGHT+IEBiOdQixE/sEDSsEkCVBnZLT/H+JJ+GndkTmkOgrdPvikWjN62GqJMO8StduJyqgmGsrZUHQ==
X-Received: by 2002:a05:6a00:c92:b0:725:df1a:27c with SMTP id d2e1a72fcca58-7305d4956ccmr11579244b3a.14.1739029060886;
        Sat, 08 Feb 2025 07:37:40 -0800 (PST)
Received: from [192.168.50.123] ([117.147.91.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d4d7sm4883411b3a.16.2025.02.08.07.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 07:37:40 -0800 (PST)
Message-ID: <be935464-8a36-4019-851a-881f82b2343e@gmail.com>
Date: Sat, 8 Feb 2025 23:37:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206051557.27913-1-chen.dylane@gmail.com>
 <20250206051557.27913-4-chen.dylane@gmail.com>
 <7d667c037e7396fb88cf243162c5aa8a537858bb.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <7d667c037e7396fb88cf243162c5aa8a537858bb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/8 06:35, Eduard Zingerman 写道:
> On Thu, 2025-02-06 at 13:15 +0800, Tao Chen wrote:
> 
> [...]
> 
>>   LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>>   				       enum bpf_func_id helper_id, const void *opts);
>> -
>> +/**
>> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
>> + * use of a given BPF kfunc from specified BPF program type.
>> + * @param prog_type BPF program type used to check the support of BPF kfunc
>> + * @param kfunc_id The btf ID of BPF kfunc to check support for
>> + * @param btf_fd The module BTF FD, if kfunc is defined in kernel module,
>> + * btf_fd is used to point to module's BTF, 0 means kfunc defined in vmlinux.
> 
> Regarding '0' as special value:
> in general FD is considered invalid only if it's negative, 0 is a valid FD.
> Andrii, I remember there was a lengthy discussion about FD==0 and BPF,
> but I don't remember the conclusion.
> 
>> + * @param opts reserved for future extensibility, should be NULL
>> + * @return 1, if given combination of program type and kfunc is supported; 0,
>> + * if the combination is not supported; negative error code if feature
>> + * detection for provided input arguments failed or can't be performed
>> + *
>> + * Make sure the process has required set of CAP_* permissions (or runs as
>> + * root) when performing feature checking.
>> + */
>> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
>> +				      int kfunc_id, int btf_fd, const void *opts);
>>   /**
>>    * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>>    * number of possible CPUs that the host kernel supports and expects.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index a8b2936a1646..e93fae101efd 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
>>   		bpf_linker__add_buf;
>>   		bpf_linker__add_fd;
>>   		bpf_linker__new_fd;
>> +		libbpf_probe_bpf_kfunc;
> 
> This is now in conflict with bpf-next.
> 

My bad, i will rebase the repo.

>>   } LIBBPF_1.5.0;
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index e142130cb83c..c7f2b2dfbcf1 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -433,6 +433,61 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
>>   	return true;
>>   }
>>   
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
>> +			   const void *opts)
>> +{
>> +	struct bpf_insn insns[] = {
>> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, btf_fd, kfunc_id),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	const size_t insn_cnt = ARRAY_SIZE(insns);
>> +	char buf[4096];
>> +	int *fd_array = NULL;
>> +	size_t fd_array_cnt = 0, fd_array_cap = fd_array_cnt;
>> +	int ret;
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (!can_probe_prog_type(prog_type))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (btf_fd) {
>> +		ret = libbpf_ensure_mem((void **)&fd_array, &fd_array_cap,
>> +					sizeof(int), fd_array_cnt + btf_fd);
> 
> Please take a look at the tools/testing/selftests/bpf/prog_tests/fd_array.c,
> e.g. test case check_fd_array_cnt__fd_array_ok(). The offset field of the
> call instruction does not have to be an fd (as it only has 16 bits),
> instead it's an offset inside the fd_array.
> Here it would be sufficient to allocate a small array on stack.
> 

Good idea，thanks for your guidance，I'll make the modifications in the 
next version.

>> +		if (ret)
>> +			return ret;
>> +
>> +		/* In kernel, obtain the btf fd by means of the offset of
>> +		 * the fd_array, and the offset is the btf fd.
>> +		 */
>> +		fd_array[btf_fd] = btf_fd;
>> +	}
> 
> [...]
> 


-- 
Best Regards
Dylane Chen

