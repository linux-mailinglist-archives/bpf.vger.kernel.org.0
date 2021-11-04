Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB84451F8
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKDLLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhKDLLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 07:11:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D1C061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 04:08:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id r8so5245245qkp.4
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vkv7mK8GC9ZbiF8Xd4Fzv7sfP3E/qraN1xOduxBglDQ=;
        b=vf6V+2/Wx6uIJEQ8LHVUXCyk5sHw1cOUa/yE1AM3Ct4X10Y/JaDfphVWsXJeGEeo2D
         kPfS8EPiq8NgME3H6IRmFi9rA5Kxe/JIvw8bQbraXnWF5eIhK5z30N1wu4quMaFo6PU5
         pMf050tSAK6OYLTNNQF4BHgsdijrzyOY0vgjO2LGja3v9npFTSPig6tQOOoSPcFgUejy
         k+j+JaS4wdIgewgtcWAXKZJqAj0wGjHDuJ27OQnOdg5i4tdj0KQd6uObpRpJS6aViaxt
         E1KK4xLUuW1J9ykrktmK9Y09s+skZ1q8eyPlDuUav4nJTxGsJd0PcJqEZstX+vyygQ93
         eioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vkv7mK8GC9ZbiF8Xd4Fzv7sfP3E/qraN1xOduxBglDQ=;
        b=QOfB9R3De/JORCvaghGsrtGhd6v+4f7ltqvALCUQSiO9vD8s3oGs36c5dnS5Ko6v09
         JGxJwklQQKPcc80JygZDuFLrZ0NNvfdOCJJX6GwXaiSoVjFkOVGcXiYCroFnk9N+cajP
         XAlfen8aLbrmpNh+PKuRoYKmqbI1ZZzOYw3B2nynfY1ZWUlFYHqTf7sbaGy+aUXul1/v
         iEWWg9O1wpNAtAg5mV1shYNakMC/sxQLZdm54gZADAyVy8Z/A2fH+HD+4DzoubjLdEXG
         Be99n4CJkJbI1YSTqAmEj8rglKnWKZT9YEd3w4pCmFz8umvXo/GlwykTdXeqstCSaqE+
         O7bA==
X-Gm-Message-State: AOAM530xYpg4C4uTJGvAKVeeqcCCX9QH1NnLbvjjg7aVQK1PEeKqIMCa
        UemYk+Fh/yBMR3Xs7eU+EAAk8w==
X-Google-Smtp-Source: ABdhPJxmZ/u/zmRjb0jSoonPklzAsyVXDqZ7EMkfkReN3YuzatPtRe+HIhZDcW2aKNE2Jw4JN6q2RA==
X-Received: by 2002:a05:620a:430b:: with SMTP id u11mr40142573qko.473.1636024131797;
        Thu, 04 Nov 2021 04:08:51 -0700 (PDT)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id o14sm3735117qtv.34.2021.11.04.04.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:08:50 -0700 (PDT)
Message-ID: <1376ab2d-f412-f001-a173-75af12f4ce98@mojatatu.com>
Date:   Thu, 4 Nov 2021 07:08:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v3 0/3] Introduce BPF map tracing capability
Content-Language: en-US
From:   Jamal Hadi Salim <jhs@mojatatu.com>
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton@google.com>
References: <20211102021432.2807760-1-jevburton.kernel@gmail.com>
 <aa6081aa-9741-be05-8051-e01909662ff1@mojatatu.com>
 <CAN22DihBMX=xTMeTQ2-Z8Fa6r=1ynKshbfhFJJ5Jb=-ww_9hDQ@mail.gmail.com>
 <4e602c87-9764-829c-4763-38f4ac057b7c@mojatatu.com>
In-Reply-To: <4e602c87-9764-829c-4763-38f4ac057b7c@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-11-04 06:59, Jamal Hadi Salim wrote:
> On 2021-11-03 13:12, Joe Burton wrote:
>> That's a good point. Since the probe is invoked before the update takes
>> place, it would not be possible to account for the possibility that the
>> update failed.
>>
>> Unless someone wants the `pre update' hook, I'll simply adjust the
>> existing hooks' semantics so that they are invoked after the update.
>> As discussed, this better suits the intended use case.
>>
> 
> If the goal is to synchronize state between two maps (if i understood
> correctly the intent) then it is more useful to go post-update.
> 

To complete that thought: Only positive results are interesting.
For example if the command was to delete an entry which doesnt
exist there is no point in reporting that (or is there?).
OTOH, a successful delete is useful...

cheers,
jamal
