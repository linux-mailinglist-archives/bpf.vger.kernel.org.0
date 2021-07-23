Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61E03D3D63
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhGWPg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhGWPg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 11:36:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00EC061757
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 09:17:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n21so1122070wmq.5
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HBlU9GJ1UPBOoca/uOa3FVPVjEyPQdH9vrb8OMz1vyM=;
        b=FWM9xU+RNmDSs+352KA7ev84k33Q753TgHEDrJYlUu+EvAKkn30u/UU644pgN628AA
         dsb/6iId92TfGGwakT7B6q+R8zUFpkDDm3muoTdOIL8zs6BhR7F5IckgicArBNoOHAEz
         5K74uQmjABpk5UbKZIuBsHJA0m3Bm9wP4btsIfdFaRvXVVXzcLQIXF+S/Gqs7iq8HHIE
         Xh+4NnLLHUxO3+CU8Yxv2Zmu02IPT3TA6lhz03aDQbPoz9Mv+cGWyZXRI354ORrz02iN
         ztrM0yOySrE24NQ6x3ol3kl1LS+b9ztSS5PZVx1tLY0wOowHERfyqVp46e3kvssSF+Xx
         b3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HBlU9GJ1UPBOoca/uOa3FVPVjEyPQdH9vrb8OMz1vyM=;
        b=Ej6ci1hOHuM5Efw7KWej42oEIaq7NO2tc1RHLMSWGI+vsHUpGrJXdehxaujJqp4bCd
         5WpG4yzGdhDYHnD4yBvDncIH2aofvz1cebINcIX5Ej3kyYqi5IrIHKnPZ1Q4/2rYWevb
         64wTLmHnAZvhLKwPNI13xCNJyaFQcEIk099SYsM/kg1IwM8wZPuahfYqPfI2n7yu9+M7
         +9UPoG0/d4uVxYy3m1Pjc/+sEkTadi/AQ09VajA9HtHo3vTMQSSZiy2ZVccOpe0SPl6B
         QyNYpfSyf9raSpsqRfce8DS0E+ir5H6G2RR8yX7gvdpJS9XVnekbxX1wPfTyWcXYyEkj
         Z+AQ==
X-Gm-Message-State: AOAM5317q1T0eG8flSqSvIUMAwP82qJKCinsjwgQ+3TpBiU6Qcd8WHNb
        +RBfV6AyCnkK3Fjz0Y6DwZzSGw==
X-Google-Smtp-Source: ABdhPJyF3rHa3kIOam6/Aj66moe/YaT6A7K6QQwSTO2053c3Zhb/j2+CfToCWJmiK744shmdiV93Hg==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr15166679wmk.40.1627057048541;
        Fri, 23 Jul 2021 09:17:28 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.71.195])
        by smtp.gmail.com with ESMTPSA id v30sm36099833wrv.85.2021.07.23.09.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 09:17:27 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 3/5] tools: replace btf__get_from_id() with
 btf__load_from_kernel_by_id()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20210721153808.6902-1-quentin@isovalent.com>
 <20210721153808.6902-4-quentin@isovalent.com>
 <CAEf4BzatvJORZvkz37_XJxvk5+Amr8V8iHq=1_4k_uCz0fE-eQ@mail.gmail.com>
 <3802e42d-321f-6580-8d6a-f862ac4f62da@isovalent.com>
 <CAEf4BzZ-a-ZC22iO2fOO3c2HY8iB6MUt0W1gBOoV+V9SnRqARA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <71e4c215-8f4a-0cef-4c75-81183e296eb5@isovalent.com>
Date:   Fri, 23 Jul 2021 17:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ-a-ZC22iO2fOO3c2HY8iB6MUt0W1gBOoV+V9SnRqARA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-23 08:57 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Jul 23, 2021 at 2:52 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2021-07-22 17:48 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> On Wed, Jul 21, 2021 at 8:38 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>>
>>>> Replace the calls to deprecated function btf__get_from_id() with calls
>>>> to btf__load_from_kernel_by_id() in tools/ (bpftool, perf, selftests).
>>>> Update the surrounding code accordingly (instead of passing a pointer to
>>>> the btf struct, get it as a return value from the function). Also make
>>>> sure that btf__free() is called on the pointer after use.
>>>>
>>>> v2:
>>>> - Given that btf__load_from_kernel_by_id() has changed since v1, adapt
>>>>   the code accordingly instead of just renaming the function. Also add a
>>>>   few calls to btf__free() when necessary.
>>>>
>>>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>>>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>>>> ---
>>>>  tools/bpf/bpftool/btf.c                      |  8 ++----
>>>>  tools/bpf/bpftool/btf_dumper.c               |  6 ++--
>>>>  tools/bpf/bpftool/map.c                      | 16 +++++------
>>>>  tools/bpf/bpftool/prog.c                     | 29 ++++++++++++++------
>>>>  tools/perf/util/bpf-event.c                  | 11 ++++----
>>>>  tools/perf/util/bpf_counter.c                | 12 ++++++--
>>>>  tools/testing/selftests/bpf/prog_tests/btf.c |  4 ++-
>>>>  7 files changed, 51 insertions(+), 35 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>> index 09ae0381205b..12787758ce03 100644
>>>> --- a/tools/bpf/bpftool/map.c
>>>> +++ b/tools/bpf/bpftool/map.c
>>>> @@ -805,12 +805,11 @@ static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
>>>>                 }
>>>>                 return btf_vmlinux;
>>>>         } else if (info->btf_value_type_id) {
>>>> -               int err;
>>>> -
>>>> -               err = btf__get_from_id(info->btf_id, &btf);
>>>> -               if (err || !btf) {
>>>> +               btf = btf__load_from_kernel_by_id(info->btf_id);
>>>> +               if (libbpf_get_error(btf)) {
>>>>                         p_err("failed to get btf");
>>>> -                       btf = err ? ERR_PTR(err) : ERR_PTR(-ESRCH);
>>>> +                       if (!btf)
>>>> +                               btf = ERR_PTR(-ESRCH);
>>>
>>> why not do a simpler (less conditionals)
>>>
>>> err = libbpf_get_error(btf);
>>> if (err) {
>>>     btf = ERR_PTR(err);
>>> }
>>>
>>> ?
>>
>> Because if btf is NULL at this stage, this would change the return value
>> from -ESRCH to NULL. This would be problematic in mapdump(), since we
>> check this value ("if (IS_ERR(btf))") to detect a failure in
>> get_map_kv_btf().
> 
> see my reply on previous patch. libbpf_get_error() handles this
> transparently regardless of CLEAN_PTRS mode, as long as it is called
> right after API call. So the above sample will work as you'd expect,
> preserving errors.

Right, it looks like I got confused on this one. I'll update it.

> 
>>
>> I could change that check in mapdump() to use libbpf_get_error()
>> instead, but in that case it would similarly change the return value for
>> mapdump() (and errno), which I think would be propagated up to main()
>> and would return 0 instead of -ESRCH. This does not seem suitable and
>> would play badly with batch mode, among other things.
>>
>> So I'm considering keeping the one additional if.
>>
>>>
>>>>                 }
>>>>         }
>>>>
>>>> @@ -1039,11 +1038,10 @@ static void print_key_value(struct bpf_map_info *info, void *key,
>>>>                             void *value)
>>>>  {
>>>>         json_writer_t *btf_wtr;
>>>> -       struct btf *btf = NULL;
>>>> -       int err;
>>>> +       struct btf *btf;
>>>>
>>>> -       err = btf__get_from_id(info->btf_id, &btf);
>>>> -       if (err) {
>>>> +       btf = btf__load_from_kernel_by_id(info->btf_id);
>>>> +       if (libbpf_get_error(btf)) {
>>>>                 p_err("failed to get btf");
>>>>                 return;
>>>>         }
>>>
>>> [...]
>>>
>>>>
>>>>         func_info = u64_to_ptr(info->func_info);
>>>> @@ -781,6 +784,8 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>>>                 kernel_syms_destroy(&dd);
>>>>         }
>>>>
>>>> +       btf__free(btf);
>>>> +
>>>
>>> warrants a Fixes: tag?
>>
>> I don't mind adding the tags, but do they have any advantage here? My
>> understanding is that they tend to be neon signs for backports to stable
>> branches, but this patch depends on btf__load_from_kernel_by_id(),
>> meaning more patches to pull. I'll see if I can move the btf__free()
>> fixes to a separate commit, maybe.
> 
> Having Fixes: allows to keep track of where the issue originated. It
> doesn't necessarily mean something has to be backported, as far as I
> understand. So it's good to do regardless. Splitting fixes into a
> separate patch works for me as well, but I don't care all that much
> given they are small.
> 

OK, thank you for the clarification :).
I'll keep a single patch in that case.
