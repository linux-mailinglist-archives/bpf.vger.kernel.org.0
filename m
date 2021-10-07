Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03533424C54
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhJGEDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 00:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhJGEDl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 00:03:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C614C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 21:01:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i65so1222197pfe.12
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RuerzCch4nqLVXvEGDjejXIum9u11/xWwhEwLuDTz4=;
        b=VSSXdhAuJ1JXN/rdd5f/tJpsDW/b0PRx9U5T6QCoQs6nuCiiMskm7r2jzy8p6Z+4ia
         ZVQArQEXNxZZ8kQrg1eOLzYjZx7TkXgULa2QgPemM7q0O3OnOk2Rm19ltg24X7jmoIXh
         xjFHtsyy9NVb082yTR+QJw/apGnbZK+DOfdoK0x6j/BdkDln5I3tKS6t7YAadBB1gKib
         m+TELTe9swkOT9xG1pk7/gM+qa288oB4dxGuPoXnOei12280A0v14eZGSyhwCcCD0smy
         uCE+o1Dkrn5C3BMgt7HDIbAdSwescVQJMXHZOBwZ/bWEm6j10q37w/l7OnXU1MbIAS+2
         owbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RuerzCch4nqLVXvEGDjejXIum9u11/xWwhEwLuDTz4=;
        b=0U+mhZ0y+iMxi88INSVG83SPvMGZYqhcdkDaI2lOiAPM6r4UthTzQteA9wqfYq1IPa
         5AZSEU7qi3dBU8kpQ6d09T1DKJznZVcgCFFg5gtSeN9bp12QGciALCj4PrJwteX5E9Ka
         SJFLk7jGFAhSHyKZGzpdMdrzjOtBgE9AKT8sS1rDFB89IccxcjyktddVWluKsR9c7ql9
         rHBonmAw9gvw5q5pxaze3F1tgWYQiO8Wj2zWPtEpSYqa3VaFHTvW8NUsHR1UQxPxrAbS
         OuYlI3z7HJP8Lo4lZeU1Z+TqlQDfGE7yWUUs9CcGATpG1LEoMzliTx/KW3ckxV43m1qV
         vbgg==
X-Gm-Message-State: AOAM533mphUWn4KGcdxxj7s1WTHyjDIwsj4Oc4V5YBevWxao1sNKM2nN
        D/tmLtxyb3q5b/GZ5gABI/Y3+hu0I7R/QQ==
X-Google-Smtp-Source: ABdhPJyCdcs5vBSjLIhnP9rZJuPlij/VzlZrdg9OqL9JrWIlAbNhJJixWYkkE6FyaObsTrJYagQAIw==
X-Received: by 2002:a63:3705:: with SMTP id e5mr1583828pga.307.1633579307770;
        Wed, 06 Oct 2021 21:01:47 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id h4sm6450529pjm.14.2021.10.06.21.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 21:01:47 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2 v2] libbpf: Deprecate
 bpf_{map,program}__{prev,next} APIs since v0.7
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20211003165844.4054931-1-hengqi.chen@gmail.com>
 <20211003165844.4054931-2-hengqi.chen@gmail.com>
 <CAPhsuW6NVoUebaxWm4YGNkStjxGwcdf5-hRKtcjtpVRpkEfBow@mail.gmail.com>
 <CAEf4BzbzJC30O288-iHpdOqJRxsoNFdb=cZuHV3C_1ABbdXzWg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <666156ca-9f7f-d365-7c7a-05acde1670ad@gmail.com>
Date:   Thu, 7 Oct 2021 12:01:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbzJC30O288-iHpdOqJRxsoNFdb=cZuHV3C_1ABbdXzWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/7/21 2:07 AM, Andrii Nakryiko wrote:
> On Tue, Oct 5, 2021 at 3:22 PM Song Liu <song@kernel.org> wrote:
>>
>> On Sun, Oct 3, 2021 at 10:00 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>
>>> Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
>>> a new set of APIs named bpf_object__{prev,next}_{program,map} which
>>> follow the libbpf API naming convention.[0] No functionality changes.
>>>
>>>   Closes: https://github.com/libbpf/libbpf/issues/296
>> ^^^ I guess we need "[0]" here?
>>
>>>
>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>> ---
>>
>> Other than the nitpick above
> 
> Fixed that up while applying. There were also 4 more uses of
> bpf_program__next and bpf_map__next in bpftool and samples/bpf, I've
> fixed them up as well to not come back to this again. Hengqi, for
> future deprecations, please do grep for the entire Linux source code,
> not just selftests, there are a bunch of other tools and parts of the
> kernel that use libbpf APIs.
> 

Thanks. Will keep this in mind. :)

> Applied to bpf-next, thanks.
> 
>>
>> Acked-by: Song Liu <songliubraving@fb.com>
