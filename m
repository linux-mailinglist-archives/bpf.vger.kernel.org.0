Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810BF689044
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBCHOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 02:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjBCHOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 02:14:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C36F722
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 23:14:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso3146498wms.3
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 23:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2zIdl0e2zV5PJ7rqlLKu0rWqn2K8/ELpkC60hwvTyI=;
        b=AUEWpHQkYOOrYfe8XrynDwkw4tdoup6djI9ODyBXM+AN4UcycvOVGZi3H7FGac0B4/
         QIkPyKZOXNBwd1WUIIuvZfzywgNt4J77dgIKujpE3FYMCb2P16rZ/CeScfTzsTc0cEJs
         PywWJKYXngU86DiHFFNHp+j7ay8AvpL9yFal8IzMWj9sP6KAUyKNObnuZhaJf6Pw2Ktv
         ezAwFOW3x2a+LBUgA9YcbGJQP2eRXLYEabONdbc/iZmEvkLiNTP6bQuNlA+KyZ0xylLC
         gYiZ/y7Uz6Sih3eMS2xvzrTfWlQs8cAWC7ZHNspNoheH5aIwdT+3BP1pNr9yvfX0Rbq/
         nYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2zIdl0e2zV5PJ7rqlLKu0rWqn2K8/ELpkC60hwvTyI=;
        b=VFdekF9cb7VJ8Gl3bMfPNNTmBgpQ+ri4C4Us1siDr7lXgTtlnliTe7xnuVWuGp+39p
         Ttu9kyJksPXf4TnP56E0Hq3KLXnjIvOkLY4uFXRJkmlb9t4zFzuOOPxpMpZ3xBu1HwId
         AJnfna0KeiY51NPwHFS7IHtTXeqOcMDpB8BA7HsP3HgJNGBBPOTqb+GI1vEB/MEHjC1X
         WR30TxxoDtOQI0oiCJY4HgW8CaU0ujKY6JT+Tyg4nifWx7qj+HF9BgPx2q4Ct3YUD51e
         JRtXf0y5PEblWm0WO0nrixvuR/G9WhsDYRwvE5ADFor10x19zhbD6fo9/eIZ3ln8nDlH
         SxZA==
X-Gm-Message-State: AO0yUKWyWq7TGZSifvrLGTwaew0V2RtaSXGkuFs5xeO7J0oQNJne+AuX
        5dh8Mrv11OLGvgvK7eNmLfU=
X-Google-Smtp-Source: AK7set/Ot7l2Q19ODF0qPTHCf9/SzTGOhY+oBf0ndwvkLi+uOqrwCSxUzKTojUfhP9wlkjJbCnPpyg==
X-Received: by 2002:a05:600c:3547:b0:3d3:43ae:4d10 with SMTP id i7-20020a05600c354700b003d343ae4d10mr10789246wmq.11.1675408463273;
        Thu, 02 Feb 2023 23:14:23 -0800 (PST)
Received: from jondnuc ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm6905644wmb.5.2023.02.02.23.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:14:22 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:14:20 +0200
From:   Jon Doron <arilou@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
Message-ID: <Y9y0THRh7zrO4fZL@jondnuc>
References: <20230202062549.632425-1-arilou@gmail.com>
 <CAEf4BzZE_icgcddkwVQW+0HRtHM=wRaHr3jqmkTJ92O86=6hjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZE_icgcddkwVQW+0HRtHM=wRaHr3jqmkTJ92O86=6hjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/02/2023, Andrii Nakryiko wrote:
>On Wed, Feb 1, 2023 at 10:26 PM Jon Doron <arilou@gmail.com> wrote:
>>
>> From: Jon Doron <jond@wiz.io>
>>
>> Add option to set when the perf buffer should wake up, by default the
>> perf buffer becomes signaled for every event that is being pushed to it.
>>
>> In case of a high throughput of events it will be more efficient to wake
>> up only once you have X events ready to be read.
>>
>> So your application can wakeup once and drain the entire perf buffer.
>>
>> Signed-off-by: Jon Doron <jond@wiz.io>
>> ---
>>  tools/lib/bpf/libbpf.c | 4 ++--
>>  tools/lib/bpf/libbpf.h | 3 ++-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index eed5cec6f510..6b30ff13922b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>>         attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>>         attr.type = PERF_TYPE_SOFTWARE;
>>         attr.sample_type = PERF_SAMPLE_RAW;
>> -       attr.sample_period = 1;
>> -       attr.wakeup_events = 1;
>> +       attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
>> +       attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>
>I suspect the case of
>
>LIBBPF_OPTS(perf_buffer_opts, opts);
>
>perf_buffer__new(...., &opts);
>
>is not handled correctly and you end up with sample_period == wakeup_events == 0
>
>Can you please add BPF selftests that's setting wakeup_events to zero
>and separately to >1?
>

Hi Andrii,

I'm not sure what we are testing, when you have sample_period == 
wakeup_events == 0, it basically means to never wakeup, so let's say you 
would wait on the poll_fd infinitely it will never wake you up.

When you have let's say wakeup_event != 0, you will wakeup after the 
ring buffer in the perf buffer has more events than wakeup_events.

I do see your point that if someone is using the macro to build the opts 
they will end with something unexpected, would you like me to treat 0 as 
1 in that case?

-- Jon.

>>
>>         p.attr = &attr;
>>         p.sample_cb = sample_cb;
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 8777ff21ea1d..e83c0a915dc7 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>>  /* common use perf buffer options */
>>  struct perf_buffer_opts {
>>         size_t sz;
>> +       __u32 wakeup_events;
>>  };
>> -#define perf_buffer_opts__last_field sz
>> +#define perf_buffer_opts__last_field wakeup_events
>>
>>  /**
>>   * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
>> --
>> 2.39.1
>>
