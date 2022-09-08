Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06F5B1A67
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiIHKp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiIHKpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 06:45:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0DD7C18E
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 03:45:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so1363475wmk.3
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=SxXiDCpv5ePqARD9ofSsBk9oYeXNDztMJRIdlqicQ3s=;
        b=Ic5bgE3qmdoInb3nyWjrnLqplQa6JS/sUvuCBa8GbFL4dYzZq/OL04Aco7SKYxso76
         5MmQi/s9waL9MULGvdwKV/9mkAltXgmwf3QwESiwpGxDBWgplt6rwEqNNgJBf1bEYnK7
         kqTpS+chO4JvrQnZcnjVfdZ0IVc6z6J/EuCIrpSDauTP6cB4XKOMOi5DbHgQ9hBnhv7t
         dCJvfhxdddGvqpMm/65MJjSPkEDLDXr2i97AJXMihpPdgxiMRITtCRZ6JFvVP8O7BE8P
         /epaRbWs6elt9fziAUc0+WtVGdhCIkTObXTHnblHWDxWr4g7aWjzGfExywezz3expnmC
         2Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SxXiDCpv5ePqARD9ofSsBk9oYeXNDztMJRIdlqicQ3s=;
        b=nz9nzkeewPHXlrhIbKr0i3sp7OLVYaI/8ZjkKY/P9Xo6jFF8XM9/GCiJUgeTV9Gkqw
         4npUF9WDazM8JhHPEa37Uvg2jLkGp/KiicGOcBzVAorluKJaMOs/01dk7T9EvU9wenPu
         z7/EB2ReahcrwslRjfMRHM1irEH+hkv+EV5Ncaak4EgFzTfX/R8s7i3Tsc8+huCs+brr
         LF9HP0Z2XrmFTJTCkQdUl1I+1S4d9vt77RxfdNpVCH2r0uwOsVjPztGyi13mdrEdsxIu
         JICWYn2ZooZDXKU5lHQYvbEiyoqJuF3QZkEjj0gKnXyB82yriffd9bi7NaR6qxJNgv2m
         PCIg==
X-Gm-Message-State: ACgBeo1udYja2BHYvOCPx3SNUikjnGPsr2n+3WBOAkgIGT1S+vArEI29
        wIWvLS5bwFdQ4spBGqFEZS+Tl2zHz51d0Q==
X-Google-Smtp-Source: AA6agR7PHj3999h/guCh5epJRzTGtcyBBxFZmcyyWtX9b7PNdQCFkLkPn89R+suWBlEtQDuigYYdgg==
X-Received: by 2002:a05:600c:4e52:b0:3a6:d89:4d1b with SMTP id e18-20020a05600c4e5200b003a60d894d1bmr1891759wmq.150.1662633939770;
        Thu, 08 Sep 2022 03:45:39 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id k39-20020a05600c1ca700b003a5f3de6fddsm2611839wms.25.2022.09.08.03.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:45:38 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Song Liu <song@kernel.org>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhoufeng.zf@bytedance.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: Re: [PATCH v2] bpf: Simplify code by using for_each_cpu_wrap()
References: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
        <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com>
Date:   Thu, 08 Sep 2022 11:45:37 +0100
In-Reply-To: <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com>
        (Song Liu's message of "Wed, 7 Sep 2022 17:55:23 -0700")
Message-ID: <877d2ecffy.fsf_-_@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

Thanks for taking a look.

Song Liu <song@kernel.org> writes:

> On Wed, Sep 7, 2022 at 8:58 AM Punit Agrawal
> <punit.agrawal@bytedance.com> wrote:
>>
>> In the percpu freelist code, it is a common pattern to iterate over
>> the possible CPUs mask starting with the current CPU. The pattern is
>> implemented using a hand rolled while loop with the loop variable
>> increment being open-coded.
>>
>> Simplify the code by using for_each_cpu_wrap() helper to iterate over
>> the possible cpus starting with the current CPU. As a result, some of
>> the special-casing in the loop also gets simplified.
>>
>> No functional change intended.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> ---
>> v1 -> v2:
>> * Fixed the incorrect transformation changing semantics of __pcpu_freelist_push_nmi()
>>
>> Previous version -
>> v1: https://lore.kernel.org/all/20220817130807.68279-1-punit.agrawal@bytedance.com/
>>
>>  kernel/bpf/percpu_freelist.c | 48 ++++++++++++------------------------
>>  1 file changed, 16 insertions(+), 32 deletions(-)
>>
>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> index 00b874c8e889..b6e7f5c5b9ab 100644
>> --- a/kernel/bpf/percpu_freelist.c
>> +++ b/kernel/bpf/percpu_freelist.c
>> @@ -58,23 +58,21 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>>  {
>>         int cpu, orig_cpu;
>>
>> -       orig_cpu = cpu = raw_smp_processor_id();
>> +       orig_cpu = raw_smp_processor_id();
>>         while (1) {
>> -               struct pcpu_freelist_head *head;
>> +               for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
>> +                       struct pcpu_freelist_head *head;
>>
>> -               head = per_cpu_ptr(s->freelist, cpu);
>> -               if (raw_spin_trylock(&head->lock)) {
>> -                       pcpu_freelist_push_node(head, node);
>> -                       raw_spin_unlock(&head->lock);
>> -                       return;
>> +                       head = per_cpu_ptr(s->freelist, cpu);
>> +                       if (raw_spin_trylock(&head->lock)) {
>> +                               pcpu_freelist_push_node(head, node);
>> +                               raw_spin_unlock(&head->lock);
>> +                               return;
>> +                       }
>>                 }
>> -               cpu = cpumask_next(cpu, cpu_possible_mask);
>> -               if (cpu >= nr_cpu_ids)
>> -                       cpu = 0;
>
> I personally don't like nested loops here. Maybe we can keep
> the original while loop and use cpumask_next_wrap()?

Out of curiosity, is there a reason to avoid nesting here? The nested
loop avoids the "cpu == orig_cpu" unnecessary check every iteration.

As suggested, it's possible to use cpumask_next_wrap() like below -

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 00b874c8e889..19e8eab70c40 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -68,9 +68,7 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
                        raw_spin_unlock(&head->lock);
                        return;
                }
-               cpu = cpumask_next(cpu, cpu_possible_mask);
-               if (cpu >= nr_cpu_ids)
-                       cpu = 0;
+               cpu = cpumask_next_wrap(cpu, cpu_possible_mask, orig_cpu, false);

                /* cannot lock any per cpu lock, try extralist */
                if (cpu == orig_cpu &&


I can send an updated patch if this is preferred.

Thanks,
Punit
