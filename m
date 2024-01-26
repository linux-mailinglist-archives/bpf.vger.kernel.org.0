Return-Path: <bpf+bounces-20365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569F83D25A
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 03:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AACF1C24C32
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06651C13;
	Fri, 26 Jan 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr4ZgS50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422210FF
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234899; cv=none; b=KYIR4JwTYxxwdUf4L+EpluWmqRL7hkABiuNItGlZKqGjGX3sUmfXg9P236OUCIZoGU9pWcHvgJela1I7iXitNyK+OZafsrgNnraZ5Oiht5PjB8nVo4VHMPmV7d58/GchKCdbbb9fbA/FmZggQD2wCohb19fwkPhboIi2ZlBTYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234899; c=relaxed/simple;
	bh=BBvqoUtOmn+cBGmHbv2lINrG6mNqlqxki1regy6nDT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9Iu1J9Sb7AXqYnC+MUZ4GpCWx/QgPFVIHnk7hUkAAMuPtCszbYUdS/lS+dO7nhapJBzd1z932TF+8pEihS6RntgBWN8ddUbepnU84vz9ywu69B87KNzXaKP8WNICq/bQUJlbkQiiGlP9n/xnsgs3pCgKMx/PrGJJJ+EgDa8zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr4ZgS50; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso76426507b3.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 18:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706234897; x=1706839697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKxz3Fdec9Mrk8tTdy73TTVi++/d/gHw+zuMWUqUZYA=;
        b=Kr4ZgS50o1eneQc3t0IOD9NrqfexqpNTmXDrDYRTcKb78ckzMakGwbk3Ojqn5cptJs
         xdPPbzPfsYs9KPP+cpuOwjLDFMMlF4lWSd6YaiNL5aP82jLBLxhpk5TXH7Fegvxuv/fe
         d43MM6nOhoWv7hwW1y8p93m2ReEVLfJJyjsL0NhOtN6UxxAbBUC5wSHdFJbv+zlcpz0/
         7CdhNO8Ik+eeHNi3VnmUe90RTFrHs716JrE2UQPo2OuBKHZ3y0W08Gq2CWPiH3MF00q1
         oQT1hUsE/xsT8/V1VaOaKHpPz88OcTxyTehRAr8KoAL7+jLnd6jJsx6FpDdmapVgfkhf
         FjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234897; x=1706839697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKxz3Fdec9Mrk8tTdy73TTVi++/d/gHw+zuMWUqUZYA=;
        b=suIsfSTSI8+R2WyC7beZ+Zby8FQOlyjuGL11v+9QxjlO89UgYGXX4axBetYA+Ulk35
         cgREn8TIp1RN4B9+FvGuf8zrc5FIhxWUTWZAXRIe5N5VsIi+V8ButAjw7blc3NmRgjYJ
         XdXLJ3dRwEupkpDe8wIJ6i5b7jYSqY9bkRvpZW+VLnJNKlSGJ2PDTxiWVHLk61HSnNkT
         t9+y+KSlY8j2R1TvqE151HUyJUZfRovPh+rMOyDUWX5xm92e2Nd4uozs84FQt/esANuD
         Dv5N++2oU8qlrLI/0y4fTyh33+xsiKAlpxFWg9SBGNvijUIb8mu8+DQ7dWNVoRQcRWbp
         b7nw==
X-Gm-Message-State: AOJu0YyK/diFv4yLuKQdwJhGgZ6kdAY1lNlkKgedpmyNsn88hrqBmKk0
	62bDnzHcXm44CZOFb5ITWaktjVcjNL3xZZrqD6kDM6nNk6c81Lup
X-Google-Smtp-Source: AGHT+IHqY4X25dgAQ5Vnz4mgaxsm7qMYKEopX/aTv+GmVnXWLyEA+wCFNwPW3ZDyJrXAo2NDMXZz2w==
X-Received: by 2002:a81:4148:0:b0:5ff:6aac:42f7 with SMTP id f8-20020a814148000000b005ff6aac42f7mr778978ywk.99.1706234896794;
        Thu, 25 Jan 2024 18:08:16 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:1be3:4284:4c5f:f4fd? ([2600:1700:6cf8:1240:1be3:4284:4c5f:f4fd])
        by smtp.gmail.com with ESMTPSA id ez10-20020a05690c308a00b005ff955581casm58709ywb.113.2024.01.25.18.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 18:08:16 -0800 (PST)
Message-ID: <943eb8f6-ec61-4461-bc36-1601c4d1ebf0@gmail.com>
Date: Thu, 25 Jan 2024 18:08:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix error checks against
 bpf_get_btf_vmlinux().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
References: <20240125233105.1096036-1-thinker.li@gmail.com>
 <ea787f03-7dea-42f0-b467-a4d25943d6e7@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ea787f03-7dea-42f0-b467-a4d25943d6e7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/25/24 16:54, Martin KaFai Lau wrote:
> On 1/25/24 3:31 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Check whether the returned pointer is NULL. Previously, it was assumed 
>> that
>> an error code would be returned if BTF is not available or fails to
>> parse. However, it actually returns NULL if BTF is disabled.
>>
>> In the function check_struct_ops_btf_id(), we have stopped using
>> btf_vmlinux as a backup because attach_btf is never null when 
>> attach_btf_id
>> is set. However, the function test_libbpf_probe_prog_types() in
>> libbpf_probes.c does not set both attach_btf_obj_fd and attach_btf_id,
>> resulting in attach_btf being null, and it expects ENOTSUPP as a
>> result. So, if attach_btf_id is not set, it will return ENOTSUPP.
>>
>> Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
>> Closes: 
>> https://lore.kernel.org/bpf/00000000000040d68a060fc8db8c@google.com/
> 
> There were two different syzbot report. Both should be tagged here as 
> Reported-by.

Sure!

> 
>> Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops 
>> subsystem")
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 2 ++
>>   kernel/bpf/verifier.c       | 8 +++++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index defc052e4622..0decd862dfe0 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -669,6 +669,8 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>           btf = bpf_get_btf_vmlinux();
>>           if (IS_ERR(btf))
>>               return ERR_CAST(btf);
>> +        if (!btf)
>> +            return ERR_PTR(-ENOTSUPP);
>>       }
>>       st_ops_desc = bpf_struct_ops_find_value(btf, 
>> attr->btf_vmlinux_value_type_id);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fe833e831cb6..64a927784c54 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20298,7 +20298,13 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>           return -EINVAL;
>>       }
>> -    btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
>> +    if (!prog->aux->attach_btf_id)
>> +        return -ENOTSUPP;
>> +
>> +    btf = prog->aux->attach_btf;
>> +    if (!btf)
> 
> The commit message mentioned "attach_btf is never null when 
> attach_btf_id is set". Then why this test is still needed when the above 
> has just tested the attach_btf_id. attach_btf must be valid here as long 
> as attach_btf_id is set. This should have been guaranteed by syscall.c, no?

Yes, you are right.

> 
>> +        return -ENOTSUPP;
>> +
>>       if (btf_is_module(btf)) {
>>           /* Make sure st_ops is valid through the lifetime of env */
>>           env->attach_btf_mod = btf_try_get_module(btf);
> 

