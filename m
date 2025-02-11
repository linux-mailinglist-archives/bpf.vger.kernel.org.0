Return-Path: <bpf+bounces-51156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99DA310CE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E21E7A0699
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7E25A2C2;
	Tue, 11 Feb 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW3jD+H2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BE25E45A;
	Tue, 11 Feb 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290184; cv=none; b=LfTQOh8XGHTVIhcZVoAhqWyCzTN0VaeesmUdeOINeBByqwW8cmAe7aPGJPdQu9ZDH8GdGozbosIbVQ+8Yn54kIRwCeI/Y9QPaVtjc/Q5rcoPo8Uq08XJZ5JRqELdtZTv439zndkD/Bbujt95dK0vmLu6CIDoa4FVEtwNeDcJPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290184; c=relaxed/simple;
	bh=TVjvnqZdrvC87M+KukkWMSEzPQvjWUj8ceSMgn0mBWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+WEqUOYhSb6phRpRiVVgWPtstndk/5dTO1jF0AKIKc15CwcXxuRrG2+rvzM7cSy4DyzcoBr2OH3u0PYQtp193KkC206fCYEMU1Ax741ikUB6E+vcjWcVxMassRnEYIUsAjIcOYXutyiNvLoMnhl1T+moNM5tI+syxgbtnkQyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW3jD+H2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f464b9a27so97103435ad.1;
        Tue, 11 Feb 2025 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290183; x=1739894983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAyB62GSWdISzPRmuuHh8pA6uRco0XW7ojEAUSp9X+Y=;
        b=UW3jD+H2rndpUZYiHWeqzX8PEaOrpZyHtEMXySuUGsTCZ5YrdsPMLpfT0Ns+NYWEcx
         qkpyf5ZmeTYGiRKEvV06uerLPOdRzXw3F1KjhqeuBc/g4ts5hz39tOXgKNPFY7qxpWeh
         a3lOAwFprS2unnX+OhqPm9kbWsHmw4iSYIcnrrc3UoYDh3mt/sVCFPNq4rE/NJ6QoRhP
         W4IGYE8N1MFf5hZfnUgWd8fWj9/IpBVeiQOL6bxnNTYRy5FmRpFlQzZpl3AxyDJEB89V
         ltjMsIcYOAhrZvFQJ/75fVexJCTRJ3ZdNst3IvxfdfQyV6gJM3hlbEax05w5BvZ5b1du
         0Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290183; x=1739894983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAyB62GSWdISzPRmuuHh8pA6uRco0XW7ojEAUSp9X+Y=;
        b=PGcCZGxu86E+BP2OtJIeob0O05pxyTb9ePXKqRE8KwjWnYLdyKg6wno4rdsgXr5sg8
         fkkXtLqB2xttMrMqhKfwBf66DaKYcVfEmF6aqPkfkxFL2+CxQ6Ct2O7I3kWbKdyNkHJM
         PGOQc7JNck6ilBOOhU+RceulotNUneN++9I9zOJ+bj2px8idPZcd0nGfNy+EV0RSS6yU
         Myk14LNzAPHIRtf7KWepEfnLD8p0NZvPEr2cpvWe6w9wHsUHte/I+Nm70qSCYgBG+6OB
         qdQYdJnX75dvOAJx7Gd5gQV0eU+uE1kALfUqScb5PqQEf3uS19FAskzH8bVY/mf34nNe
         56mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEsdyg+4frpBg0j9Xu6Ym0KdDBGA00eVHeX9OYNKQz9LCFUIfFzFnBi80RPRKHOh0IKU36cYll1yZV2uUZ@vger.kernel.org, AJvYcCX7zousZMOzKRK9f/vX/wzPiezZc2MM+5uhzuidwyTs+C6O3HhJ4wn1BMoGzhcjz2QpLLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qplZQStG4h+uTobnObVOpeUNx+7QVqLpEXU/6cNG2mTnAQ8m
	oWqFrcf5R4lIHZtU2vUzcSHgPUjpm79uO+0CbahsshcaXfExMWSt
X-Gm-Gg: ASbGncvyLRff9QiMg7hiF/XQ8cJWecx5IYtG1w0fz0c7Gv1YevxBxGORBY0rFw1eu3i
	BaL89PDBAbxWEK/gS56mIEtNUyFoE//KTCdehcfAd3cFD6lDa9pCRQrJMcKR2jEx25QdYjuElrQ
	kzB6Mjeyor3HCm8DsXZAvPCW9OPyyqk36BHh6xjunlc1IybXIyJqpVedv6LF2DWYs0hDzvCBt4P
	3JrLgzpMD/cv67+dTL5uhh8yIxyzwEI/wSfQstEwAMCegT2/N931HzYpESN8KFLzfXRvxh3Aks3
	f2fM3saYin/j
X-Google-Smtp-Source: AGHT+IEdXqYKfOJ6fL00vANGxoSeUhWt5V0zAdWJNJZsdX407WjuvWPLIER0NrnWM+bjiiIOqJzYRg==
X-Received: by 2002:a17:90b:4a48:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2fb63d1accbmr540485a91.10.1739290182504;
        Tue, 11 Feb 2025 08:09:42 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a16e53sm10613538a91.11.2025.02.11.08.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 08:09:42 -0800 (PST)
Message-ID: <ad6421b2-10b4-4ac0-8a37-e49d1cdff712@gmail.com>
Date: Wed, 12 Feb 2025 00:09:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Chen <dylane.chen@didiglobal.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
 <20250211111859.6029-4-chen.dylane@gmail.com> <Z6tgfKgUdCRaQJ9c@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z6tgfKgUdCRaQJ9c@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/11 22:36, Jiri Olsa 写道:
> On Tue, Feb 11, 2025 at 07:18:58PM +0800, Tao Chen wrote:
> 
> SNIP
> 
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 8ed92ea922b3..ab5591c385de 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
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
> 
> we could use libbpf_err(-EOPNOTSUPP) in here and in libbpf_probe_bpf_helper
> sry for not spoting it earlier
> 
> other than that the patchset looks good to me
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 

Ack. will change it. Thanks for your review!

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
>> +			      buf, sizeof(buf));
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

