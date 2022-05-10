Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B2521BD3
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiEJOWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbiEJOVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 10:21:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB02532D1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 06:48:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g6so33099079ejw.1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxN4fURmY7B6OoGlAl7TnZh+A6v7toVBfv8XiVHnZPs=;
        b=7SMXTERkd3/gNZd9hcEblZXFf89HNEF1w2DzcV0/SvWbKebt9E/slmZT3Y4BXI7RpN
         nRwzWfOuCBlMvHyEz+Zaxr8s1R8JRNAHJTlBfYC0BD8KMIYsq5xKzNwm22Q3bl7gpfNr
         BAUm/weOcahU4V1JAZCdtcsYzc6+8FfDLXaXF3GIx75QqN7Rr4bd0ScAyzSgfMmYFI42
         k9ThExqUhPAUZ+UNx0lYup3uLi2LJOwM80NmmMJNCdDRm2zaP9cHq6r8ME+m8Iws7LOM
         WuHsOIaHF5e1MvqtFYJ0Sk0IvAiBA1g2EgYsO6VKOiJzve0kJpnb/lXHIdyu3rtpQyzM
         emRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxN4fURmY7B6OoGlAl7TnZh+A6v7toVBfv8XiVHnZPs=;
        b=BVE1NRs9trusMm4uFmvjH8bHJpP5KqjeWcmv0lvIAPEwt052N8cq84E5jP7ZM7s9/9
         ovLYaZxju8ZNJISg0zgdx7GN9FH0ozzL5VeB4fauj7dg/Yl6/IOkbJdRdmMI4Da+/J5+
         0X3MlSt4puWZjLqnZTISQn9g1Jcr4oW4AvfzvIA+bPGRqGZR4HnrIvEIRN4cPz+V8dJa
         DIK5CRwITln3CD7ZJngBbMRLMY2Giob75BZH8GEbLLOcxFWQZso/pkfpf88ke0+KvwyE
         On3EPo/Bd666lRLqqf1VXlzotXgsa5v1HbXvPc+Pvg2rmWjOKBcxxaeRAtnklduknqTy
         aRyg==
X-Gm-Message-State: AOAM533TD609RScmo/jbxxsFeUJJvUz0vRIEuLwgW2oTFqEXbKNRdkVX
        958apkAgxxYYi0Ei2Gb2AjklVg==
X-Google-Smtp-Source: ABdhPJz67etFY7SFqB7dXmIx6c5+FLU2cHXZAcwYNvoIwNsUAstURDc7iQGPVCoNA46qAWnebQ/56g==
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id nc6-20020a1709071c0600b006dfb257cbb3mr19500751ejc.631.1652190483935;
        Tue, 10 May 2022 06:48:03 -0700 (PDT)
Received: from [192.168.47.124] (228-177-145-178.mobileinternet.proximus.be. [178.145.177.228])
        by smtp.gmail.com with ESMTPSA id jz2-20020a17090775e200b006f3ef214e4dsm6278024ejc.179.2022.05.10.06.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:48:03 -0700 (PDT)
Message-ID: <e58c97e5-450a-3abc-f796-180273134423@tessares.net>
Date:   Tue, 10 May 2022 15:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v3 5/8] selftests: bpf: test
 bpf_skc_to_mptcp_sock
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
 <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
 <CAEf4BzY-t=ZtmU+6yeSo5DD6+C==NUN=twAKq=OQyVb2rS2ENw@mail.gmail.com>
 <8afe6b33-49c1-5060-87ed-80ef21096bbb@tessares.net>
 <CAEf4BzbwGHtoEooE3wFotgoYi8uDRYJcK=Y0Vdt-JUtWi4rqhg@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAEf4BzbwGHtoEooE3wFotgoYi8uDRYJcK=Y0Vdt-JUtWi4rqhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On 09/05/2022 23:00, Andrii Nakryiko wrote:
> On Mon, May 9, 2022 at 2:00 AM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Andrii,
>>
>> Thank you for the review!
>>
>> On 07/05/2022 00:26, Andrii Nakryiko wrote:
>>> On Mon, May 2, 2022 at 2:12 PM Mat Martineau
>>> <mathew.j.martineau@linux.intel.com> wrote:
>>
>> (...)
>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 359afc617b92..d48d3cb6abbc 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -13780,6 +13780,7 @@ F:      include/net/mptcp.h
>>>>  F:     include/trace/events/mptcp.h
>>>>  F:     include/uapi/linux/mptcp.h
>>>>  F:     net/mptcp/
>>>> +F:     tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>>>  F:     tools/testing/selftests/bpf/*/*mptcp*.c
>>>>  F:     tools/testing/selftests/net/mptcp/
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>>> new file mode 100644
>>>> index 000000000000..18da4cc65e89
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>>> @@ -0,0 +1,14 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* Copyright (c) 2022, SUSE. */
>>>> +
>>>> +#ifndef __BPF_MPTCP_HELPERS_H
>>>> +#define __BPF_MPTCP_HELPERS_H
>>>> +
>>>> +#include "bpf_tcp_helpers.h"
>>>> +
>>>> +struct mptcp_sock {
>>>> +       struct inet_connection_sock     sk;
>>>> +
>>>> +} __attribute__((preserve_access_index));
>>>
>>> why can't all this live in bpf_tcp_helpers.h? why do we need extra header?
>>
>> The main reason is related to the maintenance: to have MPTCP ML being
>> cc'd for all patches modifying this file.
>>
>> Do you prefer if all these specific MPTCP structures and macros and
>> mixed with TCP ones?
>>
> 
> These definitions don't even have to be 1:1 w/ whatever is kernel
> defining in terms of having all the fields, or their order, etc. So I
> think it won't require active maintenance and thus can be merged into
> bpf_tcp_helpers.h to keep it in one place.

Thank you for your reply!

New structures and macros[1] are going to be added later but I see your
point: there is nothing requiring an active maintenance. We can move
them all to bpf_tcp_helpers.h.

[1]
https://github.com/multipath-tcp/mptcp_net-next/blob/export/20220510T054929/tools/testing/selftests/bpf/bpf_mptcp_helpers.h

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
