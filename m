Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2644400A
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhKCKgs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhKCKgr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 06:36:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49CC061203
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 03:34:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s1so444590qta.13
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xom/hPiNgRklPy6PHcPTBsv7vizg3n2pK7P+Hb9c8c8=;
        b=lp00QQOsPKxBS5e3MyUDUTuCVQF3o1j2ruBENN32WTbQ+VSvXRahf/mNw9oPtwnS54
         ZtJUwPQp518dkw+Tonau/iePibZv3mYllnivU9e1tVi6ENCUiDJOaYhytTPJEFJCWdOu
         ZM/2FkDWVff79sfaG0CVaqxsXKUN1cCE9xt/MfZi2olugzVRuRQH936IjxK9tG/lc0zl
         AiPmFWVBE78FPnGXQLJJKEVlFSOVsBKmyV3DgWydRK0Tq4wbzKeCSR3m8eZEhXrVgQky
         5SOwMDYKm6RNdjbmUUjcAnb5j7KhqBOgwVw25nHfNRzaw/FKpjyWw4Vmhq7WthGYPl9g
         DVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xom/hPiNgRklPy6PHcPTBsv7vizg3n2pK7P+Hb9c8c8=;
        b=Uxz2bhSQcUDsClKMWI3etSK4nql5/8fUHX+IlbIEwwNh6FpUJSyN5QJFVQ3zEPia8n
         VzzWMsqTJmbk7a5darHMkQKGa45UJb6tgyTjm/DtR1RTCrClgxwqwKn0KIDtUWedvqmv
         2oOQyA5Xg3aBUqX3oa0sGJ7lGmQ3Gluj7OjgTt+htN+5VBadt/4Hh9I60HNGLYYCVp5g
         LHMU1CVseYXcNPDYb3hD45lproxY9EaApqdVyeG0hBI7X5Gnad/DZmCJ22i4hUwXGP/0
         /1nigftTk/5ftdSJkqeGgKuEOuGHIl9LGjpDYMlxbgGPCm4GaSL0J8PJGWX5cufTwlsH
         640A==
X-Gm-Message-State: AOAM5317Gs785zJktjXv+UByZkrBZcXFvfjjRG3cQYQf8we409WMRJDH
        YK6rnOVz80wQ0N6k2EQwPJGG3Q==
X-Google-Smtp-Source: ABdhPJwnHjhITyxdempWaCFmOm2UjBn2mXuDkwTso4NHabnTNvkdMSc8ra1hPDgpc3C+ZQcVaPDynA==
X-Received: by 2002:a05:622a:107:: with SMTP id u7mr21943459qtw.79.1635935650114;
        Wed, 03 Nov 2021 03:34:10 -0700 (PDT)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id r7sm1329295qtw.56.2021.11.03.03.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 03:34:09 -0700 (PDT)
Message-ID: <aa6081aa-9741-be05-8051-e01909662ff1@mojatatu.com>
Date:   Wed, 3 Nov 2021 06:34:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v3 0/3] Introduce BPF map tracing capability
Content-Language: en-US
To:     Joe Burton <jevburton.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton@google.com>
References: <20211102021432.2807760-1-jevburton.kernel@gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <20211102021432.2807760-1-jevburton.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-11-01 22:14, Joe Burton wrote:
> From: Joe Burton<jevburton@google.com>
> 
> This is the third version of a patch series implementing map tracing.
> 
> Map tracing enables executing BPF programs upon BPF map updates. This
> might be useful to perform upgrades of stateful programs; e.g., tracing
> programs can propagate changes to maps that occur during an upgrade
> operation.
> 
> This version uses trampoline hooks to provide the capability.
> fentry/fexit/fmod_ret programs can attach to two new functions:
>          int bpf_map_trace_update_elem(struct bpf_map* map, void* key,
>                  void* val, u32 flags);
>          int bpf_map_trace_delete_elem(struct bpf_map* map, void* key);
> 
> These hooks work as intended for the following map types:
>          BPF_MAP_TYPE_ARRAY
>          BPF_MAP_TYPE_PERCPU_ARRAY
>          BPF_MAP_TYPE_HASH
>          BPF_MAP_TYPE_PERCPU_HASH
>          BPF_MAP_TYPE_LRU_HASH
>          BPF_MAP_TYPE_LRU_PERCPU_HASH
> 
> The only guarantee about the semantics of these hooks is that they execute
> before the operation takes place. We cannot call them with locks held
> because the hooked program might try to acquire the same locks. Thus they
> may be invoked in situations where the traced map is not ultimately
> updated.

Sorry, I may have missed something obvious while staring at the patches,
but:
Dont you want the notification if the command actually was successful
on the map? If the command failed for whatever reason theres nothing
to synchronize? Unless you use that as an indicator to re-read the map?

cheers,
jamal
