Return-Path: <bpf+bounces-69542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE7FB9A419
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBB92A323F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFB621146C;
	Wed, 24 Sep 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANgnnZz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B96749C
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724344; cv=none; b=syMXyCYjmnnDnkqJgrFZXoOr4sAo7eqwXUfQHH7ZTzxINVi9E3WILmDTiLTpMt/eVf+KcInTy7DoT9Mb1A8NJXeoSQw6la5/5ULCxb28I6PpZC3Hg7DOjoDcGI5NtsNh4HGQjkvuNuLJD62AgzmUAc+GujwMyNjati8mWbEZXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724344; c=relaxed/simple;
	bh=aEkaUtIOnMKPGIJPYA9C/z+JPUtuUghNdrISbTD8j5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBfGKsyWBQ6fI6M4MeBFI4CKfzErL/UIBVSiPviJuEHDPzAY26qDMHgC082qKez1cEhQXn67qfMvvWC2ao8RYrzvPe1UwXKIBxq6YQLSzIBQR6URhFo/DtBUjK+0rWiZoEpD3TGsFTv0g2zcIhW64BcPi2/5kVPLCjagRwBIMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANgnnZz2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso824088f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724341; x=1759329141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsTVNh8AvzoP4U143/7ZkmBZ2IqmoLaAUgiCcw69LUo=;
        b=ANgnnZz2/dHDA3sK5+nwW7sUaje+6Vwo6Pkj1UQE4ZLj8meIYlRyiOGcgtWSj++EsO
         ejGdl7xTSfGs/qpF0zP2eAxBWG6GQPQ8EjFEDGtFX2gIkA2l70S05MTrK5nkN78Dy5ZA
         5m5JcpgdcsdE7R/sncZBJHGO7+xW6ZbNcYcPxKk99eNndGjxgBIwKVhv9a4rt6dsjNXG
         fSpeO7PHtkfOvhvnn0sniXPzYUMf2doSfEbB+iEhujaHBkSp8msd7zy59ASbXamz4IAl
         GkIHTg+5AAEhYVVbPFugbnkUq9fPTpZiFKTBjvHYcSqdSpiEr+5mW9v8LtlAjSQMSyQ3
         5rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724341; x=1759329141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsTVNh8AvzoP4U143/7ZkmBZ2IqmoLaAUgiCcw69LUo=;
        b=WMUjJ31BQQiDo4r8WZUGOmCvNneYibQyhVpETdFE5ESYD7VgXDpT3lTPt/Am4/r2iV
         IMirAokINkUQWfcgMOvoikrwwkDANdS8ArCA1GkItHS06JAi93ftxExtON4myN4VuXLD
         OHbGpd+Qzr9A6c9ybgUwtiCmX5TzTCBaWOfTdoiASguIzD48qOKOSs7HOVTW8KHKR+6C
         b/ygyUcfj449JGM7eoxA3nKL/+xySvZe0Y2nA0sZ6nPOygQfBVTakmO7Hf8BWPxYkdsE
         Lu6UGYzm4c/KpOf+3YjgnVETH3XfEm3i//9m5kI/2uGCnQhOoluiOF+WXlrcsXu8HZIk
         Ua9w==
X-Forwarded-Encrypted: i=1; AJvYcCVZNeHoRBnxeBdSjzkojw0blt9CdDxnsSg508yjX4ep8Vtk3rcn7uKAkd+OIU6Th52Fquw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpUz71gEdEJ+L5cn3phpYHkAQmpjlpNMT+fHyg7mTFfERmHOD
	pWdWdtbeqwV7H5Eq13+vFV1OwlUmv/Nm0U4f0W7qvU4i7VDOaltgK1gR
X-Gm-Gg: ASbGnctd+dR6+CNHnPJoRZeC0whT11Iv6StWl035RTlwAgTL+hZIymwMCW4FBdm++G3
	uUkHR43cJo6QWPf/a9ABioGRoBNr8es4Lzw44nTALlVouz/dVL+3lSGr7AqLYHY3cS24qvCMmOV
	OsxaUIljUeLONJoXqzm1lvSBi04D/TydIwj3gezLHJAVoX959zzUg/eDFxF8h9nSE812lS7zyLu
	imI3ma3ND9bLgBNBCPDVc7STVLHN+kxWuQyo5TLT8As3jdErPDYwXKqxQYb4YCP/ckDHGEDEM+2
	K5R56nLe7w4WPDUAoRTtSDSkJJ7SKCf4n5xbu9335fBaDzjbrlp7J5oXEj5MHo7mloBuXbs9/vA
	BSJm0epsYUEfQd2mu0Q2pqCSP4w2VZqLYxhXKN9yB/QrecR4A7+um4f7+ARL4Cj+9hBoj5F08O+
	+YKqikS4c=
X-Google-Smtp-Source: AGHT+IGqV5DB03wn1yxRdcrPKO8cQexQ254BuT1IypjnLvXcKxT7CzR0hpRNbmnoXtCDlCW4N4puDw==
X-Received: by 2002:a5d:5f83:0:b0:3ec:42f9:952b with SMTP id ffacd0b85a97d-40abcc76e21mr2643118f8f.4.1758724341013;
        Wed, 24 Sep 2025 07:32:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40ae8405817sm2878159f8f.8.2025.09.24.07.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:32:20 -0700 (PDT)
Message-ID: <b62ab464-a66e-4898-bea9-971fbc5cb34b@gmail.com>
Date: Wed, 24 Sep 2025 15:32:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: task_work selftest cleanup
 fixes
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250924115700.42457-1-mykyta.yatsenko5@gmail.com>
 <20250924115700.42457-2-mykyta.yatsenko5@gmail.com>
 <b8ad075c-c478-4239-bbda-148e6d4d3c3c@iogearbox.net>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <b8ad075c-c478-4239-bbda-148e6d4d3c3c@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 14:52, Daniel Borkmann wrote:
> On 9/24/25 1:57 PM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> task_work selftest does not properly handle cleanup during failures:
>>   * destroy bpf_link
>>   * perf event fd is passed to bpf_link, no need to close it if link was
>>   created successfully
>>   * goto cleanup if fork() failed, close pipe.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/test_task_work.c | 21 +++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> index 666585270fbf..65c4efd05e9e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> @@ -55,8 +55,8 @@ static void task_work_run(const char *prog_name, 
>> const char *map_name)
>>       struct task_work *skel;
>
> [...]
>
>>       struct bpf_program *prog;
>>       struct bpf_map *map;
>> -    struct bpf_link *link;
>> -    int err, pe_fd = 0, pid, status, pipefd[2];
>> +    struct bpf_link *link = NULL;
>> +    int err, pe_fd = -1, pid, status, pipefd[2];
>>       char user_string[] = "hello world";
>>         if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
>> @@ -77,7 +77,11 @@ static void task_work_run(const char *prog_name, 
>> const char *map_name)
>>           (void)num;
>>           exit(0);
>>       }
>> -    ASSERT_GT(pid, 0, "fork() failed");
>> +    if (!ASSERT_GT(pid, 0, "fork() failed")) {
>> +        close(pipefd[0]);
>> +        close(pipefd[1]);
>> +        goto cleanup;
>
> Here we go to cleanup before skel is initialized.
>
>> +    }
>>         skel = task_work__open();
>>       if (!ASSERT_OK_PTR(skel, "task_work__open"))
>> @@ -109,9 +113,12 @@ static void task_work_run(const char *prog_name, 
>> const char *map_name)
>>       }
>>         link = bpf_program__attach_perf_event(prog, pe_fd);
>> -    if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>> +    if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
>> +        link = NULL;
>>           goto cleanup;
>> -
>> +    }
>> +    /* perf event fd ownership is passed to bpf_link */
>> +    pe_fd = -1;
>>       close(pipefd[0]);
>>       write(pipefd[1], user_string, 1);
>>       close(pipefd[1]);
>> @@ -126,8 +133,10 @@ static void task_work_run(const char *prog_name, 
>> const char *map_name)
>>   cleanup:
>>       if (pe_fd >= 0)
>>           close(pe_fd);
>> +    if (link)
>> +        bpf_link__destroy(link);
>>       task_work__destroy(skel);
>
> Passing in uninit skel to task_work__destroy.
Thanks for pointing out! Sending v2.
>
>> -    if (pid) {
>> +    if (pid > 0) {
>>           close(pipefd[0]);
>>           write(pipefd[1], user_string, 1);
>>           close(pipefd[1]);
>


