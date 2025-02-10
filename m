Return-Path: <bpf+bounces-50993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5172A2F152
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51099163E64
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB1204873;
	Mon, 10 Feb 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ACWGFh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF732528E1;
	Mon, 10 Feb 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200763; cv=none; b=vEUbLfSif3c6tctzFo806MiZ96cBj007QYJSVIYg094PpMSA9aWDFFUUhqktJnDOCUHjIXZbS8keDOKcZ2BWEM2opti0lpfKZ1ARC0psgQuzNvsZXqUn7GSG8OTFU5pfwlnnCGbfBKw8F+IvuDEXGZ6fIyuo0Z92FYy814EGPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200763; c=relaxed/simple;
	bh=tlpzLO1OaFJr0EbryVPAKN5AO5zM0QtHGFJNz2HgE/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjQdKW+5zO95blP5lPFbEbngnqI4w0O967WhwCFc/xmsrA71osE7B/hUgzLquMuiDc0mF4DUrchWyoxOWDGlV+OLNyvuyRiMs6A/KoIQNc81kTWCxtJP2j081AqM0NV4wPU16XwjuYhJc2DhpH2pIl6vp2j1IwWwlk44Z8cmW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5ACWGFh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so6929241a91.2;
        Mon, 10 Feb 2025 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200761; x=1739805561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xqRKY+q8PyHYDf3BVGRcr2KWDeTP/NWjkUy2+uT95c=;
        b=N5ACWGFhuVdkKcn6f+UahD3gO8GIUxl7a7jgEvaafss8iupuUaZJcVMYEURBsflmcY
         flkRIQGMICmbmU2DHMUNlBZALkaRTLbjdlbMnVA1BW2vNET+TnyXD/rtlZYU7FPdFIaH
         a4cX5nHG8IFAHCgSGrFY1WwwSXBdWB4HY4fTArlXAUp0B7Qy2n1NDmp4ltOTo+hav4SK
         dEd97baU1CU8ozj4QA2jy/d3714fx8fnmP9rUkzI0a4TI//zDlBapcGiMICz41+KZrEF
         K/KQVTvIA90SiG+IkrgHuZ8hMzBWlbaH0E2PBNuMyHQ1OnKTJSWokdJzF+NSKNbw0EmL
         SOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200761; x=1739805561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3xqRKY+q8PyHYDf3BVGRcr2KWDeTP/NWjkUy2+uT95c=;
        b=blDdcdRIhGgUieM9LAG25EsCjsWkZaKBhT4uN5QgY3KJMnaMGYmXXOh3X6T4QD3Eg+
         s+9DohqAGe4yIqbNy+cCM1icf5MmamJMw5IOJOlv1jI4YSiY9EzAPKejhuXXuPNX3VQu
         RaVqOwL+5801Eye2tCfj+cMgvHTHMyvyrDDEcDgkpiaDvhR1p7+sGuGlGGhp9gIJ+5Nu
         LaGopHgwn5Mb98KGldhP8SP0vrmaQ+xT0/Q1C1Bzxf2vb0Mjz8d1ukwH4zAgY2zDoTPv
         Bqvaxx0zxcWAPNixvgaanG7jToUkHmKLNfyR4vh8Ac3yqMI2i1kMrsZVSuzXu+bWeijK
         cC7w==
X-Forwarded-Encrypted: i=1; AJvYcCWRuA+N14zFj0r18EVFfa+4M7ZqdvvLAjSgmveFLVYkjED/lrmT7722Iox4KyOmLLFjWrJp9Tkb/0YxQD0w@vger.kernel.org, AJvYcCWpnenUxi+fV9HRkPyRLUoWEoaQXtQPkO6la+FasrQW2BKXEu0Cc/sqXpM88w+wQx6hkCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo62OcquZ05CtEIK25IMeCeQpfiXzVcND7PZOe+rN1w/+fVe+t
	4Pws8y0R8Hc3tGUv1wxq651yUw77VssA8ji2jNcjuIbjD84VkhNw
X-Gm-Gg: ASbGncsw5KtoNAsVtGO/J6vhnIf7W4Kyvi1riDyIU3WAZpj1i4u/kp8kp0y688D6nPN
	pmbPWw2J2hb/sbJCPR8BW27I7iLpo0qZJI1FSPIW0/MLWRN94BS0ZUO2MxcWm7PJDJ744d/RjsN
	I/1veUFYL2R1SYP4HjKvnsLYbZfTMduf87CMpFY1spMxAWvZnKq8xm0+rC3y4mz7NIa6X4WGFdA
	gg0knjkyg2yx2VjesSewHiIEfDe2RodjIvZ/tXV0yDv4fGUNqy/x0EpI0z6HT8RGql43XyLXHfT
	A5EC6a2Kg9/N
X-Google-Smtp-Source: AGHT+IEtRndOAtN+hCziPX8YsAWGO9SxbjnZAcVJlej6cGL8luGVUZLenMphyNprKabdaxhTxc895A==
X-Received: by 2002:a17:90b:1989:b0:2fa:200e:acd6 with SMTP id 98e67ed59e1d1-2fa242e5cb7mr20506233a91.28.1739200760081;
        Mon, 10 Feb 2025 07:19:20 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f4d6asm8882617a91.6.2025.02.10.07.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 07:19:19 -0800 (PST)
Message-ID: <4914fa43-650c-403e-b2a5-b5ec66d02101@gmail.com>
Date: Mon, 10 Feb 2025 23:19:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Chen <dylane.chen@didiglobal.com>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
 <20250210055945.27192-4-chen.dylane@gmail.com> <Z6oDdiKkBy7McK-2@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z6oDdiKkBy7McK-2@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/10 21:47, Jiri Olsa 写道:
> On Mon, Feb 10, 2025 at 01:59:44PM +0800, Tao Chen wrote:
> 
> SNIP
> 
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index e142130cb83c..53f1196394bf 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -433,6 +433,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
>>   	return true;
>>   }
>>   
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
>> +			   const void *opts)
>> +{
>> +	struct bpf_insn insns[] = {
>> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, kfunc_id),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	const size_t insn_cnt = ARRAY_SIZE(insns);
>> +	char buf[4096];
>> +	int fd_array[2] = {-1};
>> +	int ret;
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (!can_probe_prog_type(prog_type))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (btf_fd >= 0) {
>> +		fd_array[1] = btf_fd;
>> +	} else if (btf_fd == -1) {
>> +		/* insn.off = 0, means vmlinux btf */
>> +		insns[0].off = 0;
>> +	} else {
>> +		return libbpf_err(-EINVAL);
>> +	}
>> +
>> +	buf[0] = '\0';
>> +	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
>> +			      0, buf, sizeof(buf));
> 
> hum, you pass fd_array_cnt as 0, which IIUC will work properly
> 
> but I guess then we don't need to have fd_array_cnt argument in
> probe_prog_load if all callers pass 0 ?
> 
> jirka
> 

Hi, jiri
In fact, 0 is indeed used everywhere here. I was just thinking about 
whether we might need it in the future. Anyway, it seems better to 
remove it. I'll make the modifications in the next version.

>> +	if (ret < 0)
>> +		return libbpf_err(ret);
>> +
>> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +	 * given BPF program type, it will emit "calling kernel function
>> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
>> +	 * it will emit "kernel btf_id 4294967295 is not a function". If btf fd
>> +	 * invalid in module btf, it will emit "invalid module BTF fd specified" or
>> +	 * "negative offset disallowed for kernel module function call"
>> +	 */
>> +	if (ret == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
>> +			(strstr(buf, "invalid module BTF fd")) ||
>> +			(strstr(buf, "negative offset disallowed"))))
>> +		return 0;
>> +
>> +	return 1; /* assume supported */
>> +}
>> +
>>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>   			    const void *opts)
>>   {
>> -- 
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen

