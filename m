Return-Path: <bpf+bounces-10224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C217A35D5
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D2B1C208DC
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C654C61;
	Sun, 17 Sep 2023 14:29:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CA33D0
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:29:53 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D54127
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 07:29:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c43fe0c0bfso11367635ad.1
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694960991; x=1695565791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bbD7osL848QKxxxFqrwWnx41DaF/XQ4MI319Jfm6dE=;
        b=bWCbNd5Gj+4u1SgE1pumceT9Xa77rrqXiiJJLkeSOvKQz0A18e1GMO7R7REaOcw2MZ
         aH9AvuDV1LtpNJfBq3x5CSFSXeCFJhlHimKbjlnVDRa64UZfy0TkE7ljHaRAXtkYwAZf
         74hh7Eay+pTAtfaKaQXSW1evfSlpyUuOAAEea2NOtjErPjdDn3E+fCgqSLyZLSa3gvbP
         tjjiygp8kLT1EJH7jEfIUKO/70AsHa/aVlFMHqZ0kIeReQWu7OTk523VO91sevMxX9Va
         0TVkmLtkOCK+u6oGgY6y2qYzeEOuckpgcndojPDo7o2jVY0QC0cHXWLXrBNetiPgK55K
         bNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694960991; x=1695565791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bbD7osL848QKxxxFqrwWnx41DaF/XQ4MI319Jfm6dE=;
        b=rOeiN1u6Ohnfj0r5tO6S9EtVQF+T4dbhbCqbdBnQ68lyvKk6hrMt5mIDudzjw+NvU7
         e+ucNtXWYn/xqsTqmiJI1LDFGFx17/d9WRVUJXjawwgyRWxajfLjefpjZpQy/5tqTnTm
         0NGNkI5/AZolK053aJ/MJFFf8RwYr2x1H5GGFN6lrbz/9sSXOMle4n+TlLHxs4KsSuar
         AaDIAYlFFyvXQsz6Yk/lhNXdyS0Jln/Z01t6tinIxnC29ud8cBMd6o9ertxCowEHDM/E
         ukLlesM1Gzc13MyUBjXkOmBUUYMWK64N8KlUm5pWGN4fEYuA7LIAv98pVXxEPO5YF4KF
         LcPA==
X-Gm-Message-State: AOJu0YyzrP2wWwiW3q4gvWdjnZ2DWBm2ZDjy0hy02hf8/KZILpoCA3BD
	BNGX3ctce+fgNz/N7Li31sI=
X-Google-Smtp-Source: AGHT+IEyqbE6Flg4K5tzPf1V8DgMhBzcmsnDjFdtcm6P6xEhZ5AjdTERSV6vvzexIt/kD8xFttrJ+g==
X-Received: by 2002:a17:903:451:b0:1c3:9120:2920 with SMTP id iw17-20020a170903045100b001c391202920mr4720987plb.40.1694960991414;
        Sun, 17 Sep 2023 07:29:51 -0700 (PDT)
Received: from [192.168.1.12] (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902708100b001bdeb6bdfbasm2775579plk.241.2023.09.17.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 07:29:50 -0700 (PDT)
Message-ID: <3a354608-6685-ee51-6317-9bf127cfd7b8@gmail.com>
Date: Sun, 17 Sep 2023 22:29:44 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Stanislav Fomichev <sdf@google.com>, kbuild test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 kernel-patches-bot@fb.com
References: <20230914145126.40202-1-hffilwlqm@gmail.com>
 <CAEyhmHRAvR=Ch-DjMpmpB0zeUsbQYcTXkMqyTSL9iwmZukcTgw@mail.gmail.com>
 <8148921c-cc06-bad7-787f-d190cba0bce1@gmail.com>
 <CAEyhmHR9g+B67Fy_wmdTwHzMFhmdw86ak6dPFpMjui16ecTUjw@mail.gmail.com>
 <CAADnVQ+FLBbvE=TPuNHs2ir3s+6kVOpZGQ4U_X3SuAaAAcdL-w@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+FLBbvE=TPuNHs2ir3s+6kVOpZGQ4U_X3SuAaAAcdL-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/16 01:38, Alexei Starovoitov wrote:
> On Thu, Sep 14, 2023 at 7:54 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> On Fri, Sep 15, 2023 at 10:18 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>
>>>
>>>
>>> On 15/9/23 10:13, Hengqi Chen wrote:
>>>> On Thu, Sep 14, 2023 at 10:51 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>>
>>>>> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
>>>>>
>>>>> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check by
>>>>> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able to
>>>>> handle the case that 'bpf_trampoline_get()' returns
>>>>> 'ERR_PTR(-EOPNOTSUPP)'.
>>>>>
>>>>> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to multiple attach points")
>>>>> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
>>>>> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>>> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
>>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>>> ---
>>>>>  kernel/bpf/syscall.c    | 4 ++--
>>>>>  kernel/bpf/trampoline.c | 6 +++---
>>>>>  kernel/bpf/verifier.c   | 4 ++--
>>>>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>> index 6a692f3bea150..5748d01c99854 100644
>>>>> --- a/kernel/bpf/syscall.c
>>>>> +++ b/kernel/bpf/syscall.c
>>>>> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>>>>                 }
>>>>>
>>>>>                 tr = bpf_trampoline_get(key, &tgt_info);
>>>>> -               if (!tr) {
>>>>> -                       err = -ENOMEM;
>>>>> +               if (IS_ERR(tr)) {
>>>>> +                       err = PTR_ERR(tr);
>>>>>                         goto out_unlock;
>>>>
>>>> IS_ERR does not check the null case, so this should be IS_ERR_OR_NULL instead.
>>>
>>> Actually, bpf_trampoline_get() would not return NULL. It returns ERR_PTR(-ENOMEM)
>>> or a valid ptr.
>>>
>>
>> OK, I missed the change in bpf_trampoline_get(). Anyway,
>>
>> Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> That's too much churn to address !JIT config.
> Just make it return NULL in that case,
> instead of hacking things all over the place.

OK, I'll do it in v2 patch.

Thanks,
Leon

