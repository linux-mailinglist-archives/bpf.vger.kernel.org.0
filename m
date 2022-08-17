Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9595974A6
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiHQQ5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiHQQ5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:57:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8D7E03B
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:57:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f8so3209701wru.13
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=BxNAR+uUWZbpzMnoZ6xLNT20e9pYEmaXKXCcI9Q/EoM=;
        b=OvdQe09oW8ZLRSDrSRK1/5ENMDWUmiPXIBtNeLitIXG1Kbo6KKzRs2TyhzIBGbRmIQ
         4Rzsqa9Z0lJ/XpJr7er9AiCQnuGTkwUZjAMQabOauEQgN3SZr5waY5Sz/tJ2HSGJ1ol5
         546uiJAvhYEBmqQiDlmGvizNVJo8ggddhh1t193EZLxkd7vuS4HzF0HDasB6FIhT6vwV
         7ugmDNT7R6heDZWsAQgYp3yVpXfrZw7/QdSEqS8a1P2CTOQaifq/AXfmNAEnqCvkBeg1
         VpYkLJCsKjjfjncNdW/VFOj2mprJzJWoB5qY5gIzI2+a/h32aPFA0UgqIyZpMda6pfeV
         OXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BxNAR+uUWZbpzMnoZ6xLNT20e9pYEmaXKXCcI9Q/EoM=;
        b=77RkPDUuXi8vsssJP9Zet5I7Ig9SwUd5iED8wuSsHbfZa5bDcKj8CoWzQ2qcHKDc1n
         rIHa6Ss6dKiOMlaqF2UlT62wKb111OAnGS3D7vXHZumRmygoNYzFW0j3DG685MMjd1v6
         +rgADotwe69/MKhB26EMWzEnKLB1bvSwAJNKlcGwp3sR251WkgoYl7nrRctOwofRkdgj
         ros9TKN5JX76TKpJwtBE7DZqTb/GB7ILF5Etj9RELhSvQ6bZeKV+z1XKwOwRXvPMSuD/
         L6Zts++gEAicw+qALvNCrmM8g39dReUURsAfqPw/RgaaEP6iZ0dR1bEWT7oZO7XoErTf
         oAow==
X-Gm-Message-State: ACgBeo3GGIOmRysIkXhgWE4LnVueaXlURhjpiEDSlgCdxb6xsStiFD7s
        mUM1U9SNXARrdd3lnKsk3LxDyg==
X-Google-Smtp-Source: AA6agR4zTM5CUoO0KVcBt6rgaKRVhEDvUK8539cjpvqm4dBlo5TDNXPNo37AqrjlaaVEKUMz7Emxnw==
X-Received: by 2002:adf:ea91:0:b0:225:2106:f765 with SMTP id s17-20020adfea91000000b002252106f765mr3148651wrm.159.1660755453307;
        Wed, 17 Aug 2022 09:57:33 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003a319b67f64sm9533681wms.0.2022.08.17.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:57:31 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: Re: [PATCH] bpf: Simplify code by using for_each_cpu_wrap()
References: <20220817130807.68279-1-punit.agrawal@bytedance.com>
        <CAADnVQJsDYhNmP6G7O8tVfHZ7rQLeJ4KpwAQweVidny0fgTbyw@mail.gmail.com>
Date:   Wed, 17 Aug 2022 17:57:29 +0100
In-Reply-To: <CAADnVQJsDYhNmP6G7O8tVfHZ7rQLeJ4KpwAQweVidny0fgTbyw@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 17 Aug 2022 09:41:14 -0700")
Message-ID: <87o7wierk6.fsf_-_@stealth>
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

Hi Alexei,

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Aug 17, 2022 at 6:08 AM Punit Agrawal
> <punit.agrawal@bytedance.com> wrote:
>>
>> No functional change intended.
>
> ?
>
>> -       orig_cpu = cpu = raw_smp_processor_id();
>> -       while (1) {
>> +       for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
>>                 struct pcpu_freelist_head *head;
>>
>>                 head = per_cpu_ptr(s->freelist, cpu);
>> @@ -68,15 +67,10 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>>                         raw_spin_unlock(&head->lock);
>>                         return;
>>                 }
>> -               cpu = cpumask_next(cpu, cpu_possible_mask);
>> -               if (cpu >= nr_cpu_ids)
>> -                       cpu = 0;
>> -
>> -               /* cannot lock any per cpu lock, try extralist */
>> -               if (cpu == orig_cpu &&
>> -                   pcpu_freelist_try_push_extra(s, node))
>> -                       return;
>>         }
>> +
>> +       /* cannot lock any per cpu lock, try extralist */
>> +       pcpu_freelist_try_push_extra(s, node);
>
> This is obviously not equivalent!

Thanks for taking a look. You're right - I missed the fact that it's an
infinite loop until the node gets pushed to one of the lists.

I'll send an update with that fixed up.
