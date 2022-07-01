Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B7562986
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGADUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 23:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiGADUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 23:20:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788664D6B
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 20:20:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 23so1200879pgc.8
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UXfGFCdmVuXm58c2GJyz3SYsDckxXPxP5AoGJYfEwo4=;
        b=Q72FfzYPo2g8aHn5if7WORrBIL7CtcDlffOdx02JZTEq4eoGH8WYhH/mIrU3EG95d6
         tJRxI3BEZtEzoX+eRhiS3nbdsw72ZC62cdDkQmQiYLQsRMpP803MpMsvGfXiPNgGWlaW
         FmPd9Ku42w6dWE89LpcsWcf+/1TwAEeTzsxrLqFdf8ox3IsNHZq/jGbt51g302AYFbNh
         10CZR/rgr1wl6aP6SvcWfgXRBTj2gH4zLXgzv9wnPgL2nEmSHkv+tcUSAX30Njs6Fb/W
         vHnQfn6QmJ2tx2aa0xUd0IPNCyz+hbpSeC6XeCEfUFpQsyTaHyTClQbrdpIF3FNBIfBV
         Dvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UXfGFCdmVuXm58c2GJyz3SYsDckxXPxP5AoGJYfEwo4=;
        b=5SM9WO+uv0ow5iaKSA58C7BS/77kIFnJqsDWh8CKcYhPWIlGdsHJZDs6ZE8UFHgR9e
         1YvQ0eqx9XSbkV5FZm9NATe7E1D9YughP/JW21opXr+teL+fwUrpEYewcdSygDBi0p9U
         70IBIDgsdEFEaqsVOqqI4PkgIED6Dc+vgiFZdsaq4zqJ2bo5Nmg6mAytGx+M+Yn+RQ3n
         qSm3OTpfapFZExdDWoWpfnm48uQlGAZYPtJYg6vWeXX5pThDcdHuOqc49/7atne084az
         KjW5P0+4HHqo7ib6IZlqZNAmMllIQIqITY8CxPvd9oZgQH9zcspnkgMw5pfi9+YK/Lhl
         xfHg==
X-Gm-Message-State: AJIora8h+hy0l5zuC8cbwNAsIRpo8o1uq8HEDC2CJcecdFRQttXUSaW2
        UeCkUf2N+jF11NHCdDU2en4=
X-Google-Smtp-Source: AGRyM1u1ISs8a7nbL9uwKQq6XEksuAtVmpEXbeH6FCOOsTxqr1d2AaObRd8by6dTafmvqdxcTIG9Hw==
X-Received: by 2002:a65:6a50:0:b0:3f6:4566:581d with SMTP id o16-20020a656a50000000b003f64566581dmr10171240pgu.122.1656645618499;
        Thu, 30 Jun 2022 20:20:18 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b0016223016d79sm14266049plb.90.2022.06.30.20.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 20:20:17 -0700 (PDT)
Message-ID: <7f5af9ab-501d-1c61-04f8-6fb3c1017df4@gmail.com>
Date:   Fri, 1 Jul 2022 11:20:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] libbpf: Allow attach USDT BPF program without
 specifying binary path
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20220630135250.241795-1-hengqi.chen@gmail.com>
 <CAEf4Bzb+OyuRJbsxd2dfU2ROcuD4v24Wx3xVZctnbob-bUiPEQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4Bzb+OyuRJbsxd2dfU2ROcuD4v24Wx3xVZctnbob-bUiPEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/7/1 03:20, Andrii Nakryiko wrote:
> On Thu, Jun 30, 2022 at 6:53 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Currently, libbpf requires specifying binary path when attach USDT BPF program
>> manually. This is not necessary because we can infer that from /proc/$PID/exe.
>> This also avoids coredump when user do not provide binary path.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> Hm... just because I specify PID, doesn't mean I mean main binary of
> that process, it could be some other shared library within that
> process.
> 
> I don't really like this change because it doesn't feel 100% obvious
> and natural. User can easily specify "/proc/self/exe" or
> "/proc/<pid>/exe" if that's what they are targeting.
> 

Actually, this is an implication and practice set by BCC.
If path is not set, BCC assumes that it is targeting the process.

> Documentation for bpf_program__attach_usdt() states
> 
> @param binary_path Path to binary that contains provided USDT probe
> 
> it doesn't say it is optional and can be NULL, so there is no valid
> reason to pass NULL and expect things to work.
> 
> 

OK, then we should at least check against NULL and emit a warning.

>>  tools/lib/bpf/libbpf.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8a45a84eb9b2..4ee9b6a0944e 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10686,7 +10686,19 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>>                 return libbpf_err_ptr(-EINVAL);
>>         }
>>
>> -       if (!strchr(binary_path, '/')) {
>> +       if (!binary_path) {
>> +               if (pid < 0) {
>> +                       pr_warn("prog '%s': missing attach target, pid or binary path required\n",
>> +                               prog->name);
>> +                       return libbpf_err_ptr(-EINVAL);
>> +               }
>> +               if (!pid)
>> +                       binary_path = "/proc/self/exe";
>> +               else {
>> +                       snprintf(resolved_path, sizeof(resolved_path), "/proc/%d/exe", pid);
>> +                       binary_path = resolved_path;
>> +               }
>> +       } else if (!strchr(binary_path, '/')) {
>>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>>                 if (err) {
>>                         pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
>> --
>> 2.30.2
>>
