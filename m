Return-Path: <bpf+bounces-10127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD87A13C0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC04C281AB4
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74556ECB;
	Fri, 15 Sep 2023 02:18:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBD7F8
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:18:39 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A31BEB
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:18:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1ff5b741cso15074975ad.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694744319; x=1695349119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVDPL70Kg4GILb44eYhoF+roPDrCsejnz1gm9Vu/IE0=;
        b=G99N3XW+Unk24b5m9AP0ZarS0Smaf91mHV0Rk19Zydon2ZhTbznDQweAFImRRfnI/U
         PjvE7Yd7Bn0FLFf6U57rL6Ck4kQ0kanoZGsTrl/unanGhAKzjGG3LcD5f4PR7Rg1/PfB
         W+2V+oF3Sf+D0Sn5wJK3n0/Reyg/JHWmllbN0eolwRmhe76hGj0aaHHPhcpvUCxqIpko
         82VJ7HXpWPGuG5t7v/zH5EPYdW7T4WZh6IiOGG/ZmxbTzqpR2JYbDJLCzGoebdZeSQZi
         YpfrDdafJRsyb5rcZrAPRwflOdVQTUtQKvpBycWo6QKNl6ooOuOaBFB50UPorSUBaEhu
         b/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694744319; x=1695349119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVDPL70Kg4GILb44eYhoF+roPDrCsejnz1gm9Vu/IE0=;
        b=Zxkp8yxaazlHqUAtvUWx0aL9rngDgGcVsMroJ0/fTkwEPGGZzWg8q+mMB1T4NDuYV2
         uknA9cM2Q/Q9zXV2qmkG9MnXHPuLakVf48gPcpqjEsTW552vRPLZPYgyoMV3gDWt29KS
         xP1kxAKjvCASX/JWdxGOjvZX0aBq+KyhZ5kr73hJaxujuSFl5xO5ZAQjEE1Ts7UyplvV
         ujMWfN4uBlbNWWfzYyYvm8NSw26YjdIOXzEay+V9vlWDSynmhAhiYHs6JZw2G2WNdspE
         TFBU3TQKdNCrscoDRy1HCceY/YbU2gldmWpBFYWPHIvdlxjlqWoo6yuvcIeE6GoF4t28
         JbOw==
X-Gm-Message-State: AOJu0YxbU9XoHdMlanRT1RiRJ5i2i9cJ16Ikwz+Eida8XQzDOyMXFFCI
	AF+ivbmKFGv52ChlMTYVmyY=
X-Google-Smtp-Source: AGHT+IGg+I4SIChNwrDBX9VMARuh6tl+jHlf3TFid8JdDh9N3selr+fMV2DlJh3AyaqhRFO6pZr1UA==
X-Received: by 2002:a17:902:e881:b0:1bc:203f:3b3c with SMTP id w1-20020a170902e88100b001bc203f3b3cmr407800plg.24.1694744318438;
        Thu, 14 Sep 2023 19:18:38 -0700 (PDT)
Received: from [10.22.68.46] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id r8-20020a1709028bc800b001bf11cf2e21sm2230040plo.210.2023.09.14.19.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 19:18:37 -0700 (PDT)
Message-ID: <8148921c-cc06-bad7-787f-d190cba0bce1@gmail.com>
Date: Fri, 15 Sep 2023 10:18:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf] bpf: Fix tr dereferencing
Content-Language: en-US
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, toke@redhat.com, sdf@google.com, lkp@intel.com,
 dan.carpenter@linaro.org, maciej.fijalkowski@intel.com,
 kernel-patches-bot@fb.com
References: <20230914145126.40202-1-hffilwlqm@gmail.com>
 <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/9/23 10:13, Hengqi Chen wrote:
> On Thu, Sep 14, 2023 at 10:51 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
>>
>> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check by
>> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able to
>> handle the case that 'bpf_trampoline_get()' returns
>> 'ERR_PTR(-EOPNOTSUPP)'.
>>
>> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to multiple attach points")
>> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
>> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  kernel/bpf/syscall.c    | 4 ++--
>>  kernel/bpf/trampoline.c | 6 +++---
>>  kernel/bpf/verifier.c   | 4 ++--
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6a692f3bea150..5748d01c99854 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>                 }
>>
>>                 tr = bpf_trampoline_get(key, &tgt_info);
>> -               if (!tr) {
>> -                       err = -ENOMEM;
>> +               if (IS_ERR(tr)) {
>> +                       err = PTR_ERR(tr);
>>                         goto out_unlock;
> 
> IS_ERR does not check the null case, so this should be IS_ERR_OR_NULL instead.

Actually, bpf_trampoline_get() would not return NULL. It returns ERR_PTR(-ENOMEM) 
or a valid ptr.

Thanks,
Leon

> 
>>                 }
>>         } else {
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index e97aeda3a86b5..1952614778433 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -697,8 +697,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>>
>>         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
>>         tr = bpf_trampoline_get(key, &tgt_info);
>> -       if (!tr)
>> -               return  -ENOMEM;
>> +       if (IS_ERR(tr))
>> +               return PTR_ERR(tr);
>>
>>         mutex_lock(&tr->mutex);
>>
>> @@ -775,7 +775,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>>
>>         tr = bpf_trampoline_lookup(key);
>>         if (!tr)
>> -               return NULL;
>> +               return ERR_PTR(-ENOMEM);
>>
>>         mutex_lock(&tr->mutex);
>>         if (tr->func.addr)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 18e673c0ac159..054063ead0e54 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19771,8 +19771,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>
>>         key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
>>         tr = bpf_trampoline_get(key, &tgt_info);
>> -       if (!tr)
>> -               return -ENOMEM;
>> +       if (IS_ERR(tr))
>> +               return PTR_ERR(tr);
>>
>>         if (tgt_prog && tgt_prog->aux->tail_call_reachable)
>>                 tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
>>
>> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
>> --
>> 2.41.0
>>

