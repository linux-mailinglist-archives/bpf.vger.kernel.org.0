Return-Path: <bpf+bounces-39397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149C97274B
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 04:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259701C21EF8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC914B083;
	Tue, 10 Sep 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5hUyK2D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D01EEC9;
	Tue, 10 Sep 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936069; cv=none; b=rzP6FBS3UIaeZFvrzUa+d+MvRN9gEFEGl8F++/io3jzbx1EkDqZt4GBZKE/C/zRJcVgStgR25rIIUrXQD96pOiR7zK3s4hHConYHhMPJCjQB80aeGFt+sBgdeAeT1jJ6vuJvSPr2xPSti4TVn+2tqX3jERtcs6IOumme09qwWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936069; c=relaxed/simple;
	bh=nWes8kfGZZ0DxHx5CireQtMsrNwijVuS52bKHNj1d/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnOlvZCV1XSZeGFlPv3MMRrsUQHGPDc1Tf0Ma9Nv3CRhkW13MAPRL44BhhuwZAz4/J5KyQ+bj5Z+VQGbOBGv9FAbRnRP/VXivTQgUR0TgZ78XrrOlrNP1WZlHzPEMXnWfa4RhuMBqXfyQqpeA1Mj4QEi+C86XEcwoErYWY8iHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5hUyK2D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so4316255a91.1;
        Mon, 09 Sep 2024 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725936067; x=1726540867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t41SFseR1z7B7tlXMb4jMI4WxF9ePCcDI0zy2hB3TZA=;
        b=A5hUyK2D/IrXcnK0WvRz1cM7nXG+LzoZusWPFdJun40KmT6y6WgCcDgO9QpqTbBBxb
         H8YD2j/gioFEUI4ds9EAwPT3evvm+OT69ltYfh/j49ARBbp83N9KYpC7OXbHva9NNs7w
         VXH2lGz4nOA4ajJSKTrlmjYgqFpXXyIgE10bRtshxCBAV8pd83UzupfBCzrLSUwmFC04
         zytCulVjkrHvaA7mFcEnZTnkB4yLeVXaKFh0JMK3goN5dVrdRQVg5YlU+Cz7llEKXREj
         RaxvTUeRA3yNpqDppCDBno9vjyXpcp5256Uy0aQBJzSJiEfFHfaW15AEc5U7gQKlItdT
         ZXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725936067; x=1726540867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t41SFseR1z7B7tlXMb4jMI4WxF9ePCcDI0zy2hB3TZA=;
        b=M2Kb8DrIIszzHFbGk8zVZHQtFK09BLPIdd1N2hUP9MeTHQ+lca8DynFq8b2rj93gd+
         yahdHLa9UECf61OvRTKUEjaRID0JqCeiFFrCf43G5WlPFS0u12z3aG9D4e0E63fsN6gq
         gz0SYFQ/NRdWdck8Yj/cVPy4P6Pr+eWASoAXAZJgNan3oChj+scBcqCQFlgc7l5z6/qc
         sE/7KxV0kxTD9d4IaA/a7xoe3gbLrD2bVC2dgMRT/Mr5X6tg1GbGYuUtTiEUaawUE5AV
         pHbOWNBmYG/ECw8l5AareGeu04Xlw3hW7TBwr6wKXj4P9EPm4TOhhmZf/lQSCbSIWCLd
         lvpw==
X-Forwarded-Encrypted: i=1; AJvYcCX0TbFMr6rGXSMiNYtBLqT4VYf46LBf6PSs3pu7oJMPHgCdhCNX7H8JKluTIevmoDkTiRloDpldZKAItCXj@vger.kernel.org, AJvYcCXDdc2aZky/SlhA8k3PM0bX1K65krOhfg/+4RaUBwinf/n+UUTY/fj5nmh0YguNV7geWBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRc1Ji3xnQyTleczZSKFft+pPVAGCoHlp/zW8TLhAXJfKPKW3+
	BYWYAnC4tiJmFa19UZ7Fb7rRtZSowyeJOPqtO0Hnog46QEutb0rk
X-Google-Smtp-Source: AGHT+IEOPo/Z6Yjxj3QT5JZ057/fHsmON8dB1weV/meD9gJ+kbRfmbDhIELB3vgpUFfDQlPAkP/tTw==
X-Received: by 2002:a17:90a:ba96:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2db67181b2cmr2370686a91.3.1725936067014;
        Mon, 09 Sep 2024 19:41:07 -0700 (PDT)
Received: from [0.0.0.0] ([5.34.218.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0498cf1csm5191014a91.57.2024.09.09.19.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:41:06 -0700 (PDT)
Message-ID: <56c22b26-6c76-44fa-a8be-e71a515a4e7a@gmail.com>
Date: Tue, 10 Sep 2024 10:40:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH bpf-next 2/2] bpf/selftests: Check errno when percpu
 map value size exceeds
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hou Tao <houtao1@huawei.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jinke han <jinkehan@didiglobal.com>
References: <20240909071346.1300093-1-chen.dylane@gmail.com>
 <20240909071346.1300093-3-chen.dylane@gmail.com>
 <CAEf4BzZ94RvYGJ6GYib-5o_PLukq3x+ygHinBYMecqvXiEMxLg@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzZ94RvYGJ6GYib-5o_PLukq3x+ygHinBYMecqvXiEMxLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/10 04:16, Andrii Nakryiko 写道:
> On Mon, Sep 9, 2024 at 12:14 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> This test case checks the errno message when percpu map value size
>> exceeds PCPU_MIN_UNIT_SIZE.
>>
>> root@debian:~# ./test_progs -t map_init
>>   #160/1   map_init/pcpu_map_init:OK
>>   #160/2   map_init/pcpu_lru_map_init:OK
>>   #160/3   map_init/pcpu map value size:OK
>>   #160     map_init:OK
>> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> Signed-off-by: jinke han <jinkehan@didiglobal.com>
>> ---
>>   .../selftests/bpf/prog_tests/map_init.c       | 32 +++++++++++++++++++
>>   .../selftests/bpf/progs/test_map_init.c       |  6 ++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
>> index 14a31109dd0e..7f1a6fa3679f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/map_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
>> @@ -6,6 +6,7 @@
>>
>>   #define TEST_VALUE 0x1234
>>   #define FILL_VALUE 0xdeadbeef
>> +#define PCPU_MIN_UNIT_SIZE 32768
>>
>>   static int nr_cpus;
>>   static int duration;
>> @@ -118,6 +119,35 @@ static int check_values_one_cpu(pcpu_map_value_t *value, map_value_t expected)
>>
>>          return 0;
>>   }
>> +/*
>> + * percpu map value size is bound by PCPU_MIN_UNIT_SIZE
>> + * check the errno when the value exceed PCPU_MIN_UNIT_SIZE
>> + */
>> +static void test_pcpu_map_value_size(void)
>> +{
>> +       struct test_map_init *skel;
>> +       int err;
>> +       int value_sz = PCPU_MIN_UNIT_SIZE + 1;
>> +       enum bpf_map_type map_types[] = { BPF_MAP_TYPE_PERCPU_ARRAY,
>> +                                         BPF_MAP_TYPE_PERCPU_HASH,
>> +                                         BPF_MAP_TYPE_LRU_PERCPU_HASH };
>> +       for (int i = 0; i < ARRAY_SIZE(map_types); i++) {
>> +               skel = test_map_init__open();
>> +               if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +                       return;
>> +               err = bpf_map__set_type(skel->maps.hashmap2, map_types[i]);
>> +               if (!ASSERT_OK(err, "bpf_map__set_type"))
>> +                       goto error;
>> +               err = bpf_map__set_value_size(skel->maps.hashmap2, value_sz);
>> +               if (!ASSERT_OK(err, "bpf_map__set_value_size"))
>> +                       goto error;
>> +
>> +               err = test_map_init__load(skel);
>> +               ASSERT_EQ(err, -E2BIG, "skel_load");
> 
> This is quite an overkill to test map creation. It will be much more
> straightforward to just use low-level bpf_map_create() API, can you
> please make use of that instead?
> 
> pw-bot: cr
> 

Ok, i will use the bpf_map_create API in v3.

>> +error:
>> +               test_map_init__destroy(skel);
>> +       }
>> +}
>>
>>   /* Add key=1 elem with values set for all CPUs
>>    * Delete elem key=1
>> @@ -211,4 +241,6 @@ void test_map_init(void)
>>                  test_pcpu_map_init();
>>          if (test__start_subtest("pcpu_lru_map_init"))
>>                  test_pcpu_lru_map_init();
>> +       if (test__start_subtest("pcpu map value size"))
>> +               test_pcpu_map_value_size();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/testing/selftests/bpf/progs/test_map_init.c
>> index c89d28ead673..7a772cbf0570 100644
>> --- a/tools/testing/selftests/bpf/progs/test_map_init.c
>> +++ b/tools/testing/selftests/bpf/progs/test_map_init.c
>> @@ -15,6 +15,12 @@ struct {
>>          __type(value, __u64);
>>   } hashmap1 SEC(".maps");
>>
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_HASH);
>> +       __uint(max_entries, 1);
>> +       __type(key, __u32);
>> +       __type(value, __u64);
>> +} hashmap2 SEC(".maps");
>>
>>   SEC("tp/syscalls/sys_enter_getpgid")
>>   int sysenter_getpgid(const void *ctx)
>> --
>> 2.25.1
>>


-- 
Best Regards
Dylane Chen

