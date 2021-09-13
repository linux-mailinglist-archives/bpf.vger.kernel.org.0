Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7B4083AB
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 07:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhIMFFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 01:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhIMFFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 01:05:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DCC061574
        for <bpf@vger.kernel.org>; Sun, 12 Sep 2021 22:04:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so11712988otf.2
        for <bpf@vger.kernel.org>; Sun, 12 Sep 2021 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=0mxCaCPVbqMxL7M4N+tHG+8t8VbW/YaQbB3aTQHHXXA=;
        b=cQL253J1VLp/TU4MoDaBqEngmyG2P6Yx0nplnMayoPno7yTifpuOuoWkCPIhWO3oYb
         8pffHCzdCxTWc03p1tA3h9lnx7JviFnAdI1tDaq4z/oPLFTkrN6peE6zyNTOYMXjxItC
         EDJWASiJ1Ty+FftJgT6wKz10KnpaZager71Llo9npBUZRRFlH0jGNGaeEDP4WmMniC5P
         8MFY/J6Qs5RWdWxbzhCt2iLTwISjEHxOwDh1UAIyhvh2PvSnoJ8E21BtOcLiG3Yk0FGa
         kIqcSG6CXlu7poPuoL6TYlKUbkvkUgRsXpyFNvaw7fIchPV530BM0nFNVEGHsPkavwec
         2UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0mxCaCPVbqMxL7M4N+tHG+8t8VbW/YaQbB3aTQHHXXA=;
        b=5A/OiNBglVyvOr6Jbq7kuPrzNJHL1fwhFcqY2rMfDJ3Htt/S6qTC55FLGXuSSVL7Hc
         bznAVUINSIXi26c3B0eCAY7k8UT43YRfqJWC8LPPKQtYtBsltnDQgfIYJsY/maKrdZtk
         Cg8o4o4X9lymXuJJA6rKflws/2TEYMp3P0wiSpGb0MK6P9tw2fsoDYVfpJ6uMxqPrYfM
         JZ7AMlRtblUI7O4+7LnDSZg/o6WuLe+AwUPGYsDxRVN/cPQ3jFl14DjZ+VKHYomV2wUp
         4hIBsykFNBCYKwTdcnoi3Z8YjIEPMFyeS/e2Zz7uxvBcPOwyOkC72VuNoMDPQPTXLL0Y
         BxoQ==
X-Gm-Message-State: AOAM532j4OQE9dMEdt9l2SQ4yGih0So2OJCVmoz/824CmYqBn2NdayWf
        U+6fGdzozPDrsvmc4AOhw+Fa8FapFjYZYA==
X-Google-Smtp-Source: ABdhPJzUJqUGYyAeq2ibsHeT8J0TiQVju9nju//iw2sRNwWUTRcbMRAkEHmL7LrlHws3HO2+KpGTAQ==
X-Received: by 2002:a05:6830:918:: with SMTP id v24mr8160931ott.157.1631509443947;
        Sun, 12 Sep 2021 22:04:03 -0700 (PDT)
Received: from [192.168.68.112] (192-241-58-141.ip.ctc.biz. [192.241.58.141])
        by smtp.gmail.com with ESMTPSA id g23sm1630586otl.23.2021.09.12.22.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:04:03 -0700 (PDT)
Subject: Re: Why does tail call only unwind the current stack frame instead of
 resetting the current stack?
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
References: <93b37b05-3aab-3e50-bd1b-e97a8d5776f2@gmail.com>
 <34d3b670-d49d-c432-892e-c86954cfd761@fb.com>
From:   Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Message-ID: <54b7d530-7a6b-8780-cefd-8e4227b10204@gmail.com>
Date:   Mon, 13 Sep 2021 00:04:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <34d3b670-d49d-c432-892e-c86954cfd761@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No, I didn't hit this limit.

The current implementation already keeps tracks of the number of tail 
calls which to me is the same effort of tracking the stack size. I was 
just wondering if there's any fundamental reason that you can't reset 
the stack directly. But it seems that there is not.

Thanks

On 9/12/21 11:08 PM, Yonghong Song wrote:
>
>
> On 9/12/21 10:48 AM, Hsuan-Chi Kuo wrote:
>> Hi,
>>
>> The function check_max_stack_depth 
>> (https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L3574 
>> ) is used to ensure the stack size is no greater than 8KB.
>>
>> The stack can only grow over 8KB because of tail calls as they only 
>> unwind the current stack frame. I wonder why not make tail call reset 
>> the stack since what was on the stack
>>
>> will never be used again?
>
> I think this is just an artifact of current implementation.
> To do a correct reset of the stack, additional instructions
> are needed to keep track and accumulate stack size properly,
> so when a tail call is reached, it knows how much stack size
> to reset.
>
> Did you hit this limitation? Could you describe your use case
> in detail?
>
>>
>>
>> Thanks
>>
