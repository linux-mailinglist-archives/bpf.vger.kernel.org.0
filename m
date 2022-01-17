Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FF490A8F
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiAQOfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 09:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiAQOfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 09:35:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05705C061574
        for <bpf@vger.kernel.org>; Mon, 17 Jan 2022 06:35:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v123so20826523wme.2
        for <bpf@vger.kernel.org>; Mon, 17 Jan 2022 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9zv8TuxDTnlgZaPUVurCzXmFD4FERYFTJLZcn2XRP/0=;
        b=Ms4Bk5MbORe/jSxyWbQkqEnSBMw/SBEUP0mKxl36bDi2xlaubX9yrc3MOqV8FDkL1A
         9+0fIolJtsa6nbUB5S+sPcz7uiB6GLOXcyBWKOF57NO2L7y1sksX6aUT533r9ZWwET2o
         IoVCOBOSiVO4WiOMs4vBqiMvyxoeV1oJjKtWjDqv4iH6S8QxS+Vksz1KgVf14uZq2UWY
         FvsC3b2uD8c7f1FGfUI4Ro3e/kG3bDLHliQ8UMF6dvpWjFoEECbcH49/QfodFzqtyeQ4
         TAuzOydO2y5iOG/N93Pgm8ORcMTwAPAJIETyGwN6DmP+KC4GQqy+F9pEyRdStjHmD2Yj
         jVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9zv8TuxDTnlgZaPUVurCzXmFD4FERYFTJLZcn2XRP/0=;
        b=XCK04qqaay5uwUSQ27qhYy/4irQrXWglD8BEFHp4U0bVjLznYifzGrWjm61pcS++uD
         9dYzvBfthM3h2uj8Y2VMrsxDt6Us6ktG1RXJyBtVECZ6NGDbVVQJkfJYUK2M29X54uxs
         Y8tzehq2Sz3n8BQMjM8FPTMr1IwIrzYF5NmyZZ/91VWk4nfh5DAxi/+CrF7Y+kIquD3i
         rvMBV2Tv59B169iFuCqeh+dgtmYGx7jSxzdC/Pjej1qf4V8Tr/ffRH/9IfksmZHpmeMH
         Q0H8FYpjDY67UQZLFi0tf1vzjTFqhyQQIozs2NCwQI0OGrEtF527VjvFBD89MPy/p6i3
         G5dQ==
X-Gm-Message-State: AOAM530l7Aoxi20r/Vg3TwGgvvmLp9aSTLZ6oDfrio7LJfl35C5PkHl+
        pky4cB96/dMbSmPoPtlLr1bMsg==
X-Google-Smtp-Source: ABdhPJxLxL3bpQYaRHeG0cVijmcVtKCf4YneAcQ48Hke38qmGNYtMpvfdlAWpEZCnane4kYvfOwQhQ==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr20799853wmi.185.1642430137250;
        Mon, 17 Jan 2022 06:35:37 -0800 (PST)
Received: from [192.168.1.8] ([149.86.86.230])
        by smtp.gmail.com with ESMTPSA id b15sm10463729wrr.50.2022.01.17.06.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:35:36 -0800 (PST)
Message-ID: <1c84bb5f-fd71-3fa0-bf90-c188180cbd00@isovalent.com>
Date:   Mon, 17 Jan 2022 14:35:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6] bpf/scripts: raise an exception if the correct number
 of helpers are not generated
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>
Cc:     Usama Arif <usama.arif@bytedance.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@cilium.io>, fam.zheng@bytedance.com,
        Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20220112114953.722380-1-usama.arif@bytedance.com>
 <6586be41-1ceb-c9d3-f9ea-567f51dbab49@isovalent.com>
 <CAPhsuW73qDOOrp2tSEZav_i2ySarUH91RRBhZjFwOtrwEGzREw@mail.gmail.com>
 <CAEf4BzaFfsQXGEVC9LbMS12u9B5nsud=Ep+f+EpUGqEgYwOFvg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzaFfsQXGEVC9LbMS12u9B5nsud=Ep+f+EpUGqEgYwOFvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-14 16:48 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Jan 12, 2022 at 3:51 PM Song Liu <song@kernel.org> wrote:
>>
>> On Wed, Jan 12, 2022 at 4:15 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>> 2022-01-12 11:49 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>>>> Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
>>>> using function documentation present in bpf.h. If the documentation for the
>>>> helper is missing or doesn't follow a specific format for e.g. if a function
>>>> is documented as:
>>>>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
>>>> instead of
>>>>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
>>>> (notice the extra space at the start and end of function arguments)
>>>> then that helper is not dumped in the auto-generated header and results in
>>>> an invalid call during eBPF runtime, even if all the code specific to the
>>>> helper is correct.
>>>>
>>>> This patch checks the number of functions documented within the header file
>>>> with those present as part of #define __BPF_FUNC_MAPPER and raises an
>>>> Exception if they don't match. It is not needed with the currently documented
>>>> upstream functions, but can help in debugging when developing new helpers
>>>> when there might be missing or misformatted documentation.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>
>>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>>
>> Acked-by: Song Liu <songliubraving@fb.com>
>>
>> Thanks!
> 
> Would be great if we could also enforce minimal formatting consistency
> (i.e., that Description and Return sections are present and that empty
> line before the next function definition is present), but it's an
> improvement anyway. Fixed up don't -> doesn't and applied to bpf-next.

Just noting here for the record - Another possible follow-up could be to
add the same check as you did for the documentation of the syscall
subcommands in the same script (parse_syscall()), to make sure no bpf()
subcommand is misformatted or missing in the doc.

Quentin
