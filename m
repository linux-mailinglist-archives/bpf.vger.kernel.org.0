Return-Path: <bpf+bounces-49810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F7A1C3EA
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 16:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3680518892EC
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE76374C4;
	Sat, 25 Jan 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMzGpMkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D42C182;
	Sat, 25 Jan 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737817642; cv=none; b=Y0gJcqb0eepweztapHUyUl+QmfRcLWZqmeSXoMFDX72ThYnJAlc3zLIqT1CMpIgUaUsEDz8h01jbvnq9cwd9j44ZsWG7Roq1L4mqWjejR9WTi5VWzqPY3V0lxtfve9GpGYoi5OBr08qHOYL2W0INsoy/6oynL3IWH09b8XdL/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737817642; c=relaxed/simple;
	bh=/9BCJ5LH0uo2rfk8WViinEWKwxfEUU75GdXC9noLjxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWh2z6yhecu3tgR6r1WvfQR2iSwkavucwt4Ze1xi3iK14m7XEs4ossv21SzNsS7lh/D5K65u7PF/d5cGupZkoUnIKKCXE3H7q1f5GgkHl+BZloKzOk94JAJcQLS6+uH1N2xO6WVqmpDHyO8mJ14oIvwZKCZs7epFshPqGK3MqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMzGpMkb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21644aca3a0so71779795ad.3;
        Sat, 25 Jan 2025 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737817641; x=1738422441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slK3NOjMLJo1BI909iXNbOEedp1T3aWuYIC2iTOIvrg=;
        b=nMzGpMkb4VaQklwbqraBFgHiHRkPRdE6T/f9huMVqFU0stR3O4Y3wVcNaAYwlwGqeX
         NPNXwU7IEtpYLbEb3M9VqXzLY2g3szoRJFOa06tSafT1iuk1hDpvlVhsrb3yUychdYiA
         nV/DQtSboJf6DVdyBOnbUmrgtTo2vv2rzaUweYQ0XstjApZOsaW8vJGxw9jB/MU71yvp
         RC37+oWCoref7JkJFjaU+xvLQBGrQM0c8BKYGGsQPF8EoNEpTyF4gSBbdEDn0PKR2yv0
         K6VaAOq1DLXCfh4/VjwKmKODsLIkCVfyAe0Tc/lGp/PyC2aJyKBkPlaGnGhTegXOhO+F
         VsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737817641; x=1738422441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=slK3NOjMLJo1BI909iXNbOEedp1T3aWuYIC2iTOIvrg=;
        b=KUVUDLh+e+FCCmddGHwulK8SH+QstEkodpuhvUvtpjtvmi8TAETubbi1mW1uhFEuWx
         bimFp+oHqr65zSSwrFeDOnI81PxtOpgw8hz5tV074iJ0oLtXKTaj9XJof25tA5P/5KNX
         XpT1VCnzzBjz/FNyg00bVIa5oI7+S4hUwwhwlKVx4WMog9x/Q0lsdrj1QDJwI1dLzimD
         W8b/nOJWMzKpuGc2eCOUcXPVz2XQdZkwjWW32Se3x1j8VnCm6pEaAUR6jp1aua/fWfuo
         VOfC6oxI/9P/3dKOF95lltCDSP3jEbSZHbpbdhIkz6owrBK6rsGZD0oDU/MNT0JLrTLi
         wrxA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZlj/Pq26SjqbrxPOeEoOnWTDLn2yopesSOQwR4L3TU2XVNexrQ+a3YcO9nJ6aF53nutsDkZsWZGvqBi2@vger.kernel.org, AJvYcCVjWf7qYCEXAgEsOFrAiXdoKV22HSPybwJlQwJpmq+hgmucNecHvLgq2k0DsUR1fLFoXZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFAuNYmJj6UOUFVvgc5eEW4lJWnCzG5UlE0aaTlc8oqdxPZKC
	1RGXM3NS2eIS0MF/K/ZH8dpwbx2wKQ2Kd6/IP6yPpWFU7sati3RM
X-Gm-Gg: ASbGncuir3MhVxg6RlaH4IYg2JJSoTL/VICdJ/I3lGEZUZiFqaviE8YwhWfkZd0zYCl
	bhbgyjCAizNcVb/aynRG9Qgco4xMqZWiTTPgvZu+q1V7JcWihoazDN3q1WVyLAFEpnxJ0sWqzRL
	6tBd7JWGgZ/iE8PR7OJ3p/ufWY2xKYBgOzdwvS4xLeCSAnE56AV0O0aUB85y6/rPodjfUlo2TuB
	xzJCjnYhVHmfhY5iZSVizHdHxhE63PpxXhyFzGyPQGbKHSyXpRGviKdjVJFprwAFs1QzWx35x4H
	xw==
X-Google-Smtp-Source: AGHT+IHMFXGLlQ6TzXMYQYzhuf46y92QQe0+dsxndtYgszEkcX3700CwXQIa5MaIO9YdVYh8js7yfw==
X-Received: by 2002:a05:6a20:b3aa:b0:1ed:534e:38b1 with SMTP id adf61e73a8af0-1ed534e38b5mr1342017637.41.1737817640604;
        Sat, 25 Jan 2025 07:07:20 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a5784bcsm3828301b3a.0.2025.01.25.07.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 07:07:20 -0800 (PST)
Message-ID: <3aa0ea64-4ec8-49a1-9af5-b7cde200dbc8@gmail.com>
Date: Sat, 25 Jan 2025 23:07:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add libbpf_probe_bpf_kfunc
 API selftests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-4-chen.dylane@gmail.com>
 <CAEf4BzYP_xPUzFEbntzAA8JH1RQtiwdJHFUtNro04=jNAh9bvQ@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzYP_xPUzFEbntzAA8JH1RQtiwdJHFUtNro04=jNAh9bvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/25 02:48, Andrii Nakryiko 写道:
> On Fri, Jan 24, 2025 at 6:44 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
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
>>                  ASSERT_EQ(res, d->supported, buf);
>>          }
>>   }
>> +
>> +void test_libbpf_probe_kfuncs(void)
>> +{
>> +       int ret, kfunc_id;
>> +       char *kfunc = "bpf_cpumask_create";
>> +       struct btf *btf;
>> +
>> +       btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
>> +       if (!ASSERT_OK_PTR(btf, "btf_parse"))
>> +               return;
>> +
>> +       kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
>> +       if (!ASSERT_GT(kfunc_id, 0, kfunc))
>> +               goto cleanup;
>> +
>> +       /* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
>> +       ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0, NULL);
>> +       ASSERT_EQ(ret, 1, kfunc);
>> +
>> +       /* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
>> +       ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0, NULL);
>> +       ASSERT_EQ(ret, 0, kfunc);
>> +
>> +       /* invalid kfunc id */
>> +       ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL);
>> +       ASSERT_EQ(ret, 0, "invalid kfunc id:-1");
>> +
>> +       /* invalid prog type */
>> +       ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
>> +       if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
> 
> we have ASSERT_ERR(), wouldn't it work here?
> 
> 
> let's also add a test for kfunc in module (we have bpf_testmod, we
> should be able to test something out of there)

Ok, i will add it in v4.

> 
>> +               goto cleanup;
>> +
>> +cleanup:
>> +       btf__free(btf);
>> +}
>> --
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen

