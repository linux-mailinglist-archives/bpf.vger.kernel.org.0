Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BD41EED1
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354153AbhJANpB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbhJANpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 09:45:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A153C06177C
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 06:43:16 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l13so8949753qtv.3
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cf4KervmgbYPewbFXW0H0LrSdYd5Nbh/NaFrqSsod4Y=;
        b=3Hqx4iJoDMd/CbstYyPKbtUv5iaeGCpZ57vqdgLGDE88xLSq+bB1vN3HhmM3qunXk2
         RGfhlmLBWn9fHHH3XFZjMn1aCK4rlwgZzbT0oLEZ48DD4uiiiNaAoxzc84NCFIg5t4Mh
         tbmqATbs2+LHirwbBoQk6zzDCohSeWTej6haXlZe9q/fOv6doKfcW25U1pnsmaNdpKsp
         meHp6BVNTZCxqy8lH6QDsNpHBzvvs+3SsopkLPfDPQLxrQRKVxggWWpI+sHeUc8tb+Yz
         DiFA0U9dq8Nrlj8I83sGM7JxArPjsmkS9TCL4RLHoCcu0Ub2L8ZnR5grPW+2Q2KmCiQ/
         5xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cf4KervmgbYPewbFXW0H0LrSdYd5Nbh/NaFrqSsod4Y=;
        b=tFZ29bTM/0us98H2/dcLwxpPv9z7dKRK0QOWCGIQbFXVQHhoOF8pbWXY3f8feinsoq
         3mOyhh2+b3w+P62+Zmz70xnIKFj8O9KM/nlKrA2EAearSbP5FjCjkGfDEC/PpxPMPpYA
         vJwe764i25+7AHGr6VKujX+f4X/tDz+iH4zQGv2Mk2lq8LQdfCiAVJ1vTnNNANXgRppq
         PuSykT3E68XMWOIbgPwbvJbTpE8guB+YOjzTUB2v4a4OmgWR9v3cbyM35tvfi0NcJ6ha
         ljeMwdoNpi2oDNOZdMqVBiWriVfsJfwpbdILN1TbJC1y5Rf6F9A5+hhJrBE4crY3OZh3
         lhEQ==
X-Gm-Message-State: AOAM533zWhDfQ8rhMiWZy3UGsuAH8VFT5A/AucM3Iri8Mh3KORQF7VEs
        fs5o6UNuzHh23X50GYWy4BecCwHy85KCJQ==
X-Google-Smtp-Source: ABdhPJxtCkBgpFlKSAej/LLmct64vIxRBmKGIpMEhIWICJ6X3uIis+5Y29rgb65pLMVd0YPuDNViIA==
X-Received: by 2002:a05:622a:181:: with SMTP id s1mr13423984qtw.47.1633095795595;
        Fri, 01 Oct 2021 06:43:15 -0700 (PDT)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id y22sm3453660qkp.9.2021.10.01.06.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 06:43:14 -0700 (PDT)
Subject: Re: [RFC Patch net-next v2] net_sched: introduce eBPF based Qdisc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Cong Wang <cong.wang@bytedance.com>,
        Jiri Pirko <jiri@resnulli.us>
References: <20210913231108.19762-1-xiyou.wangcong@gmail.com>
 <CAADnVQJFbCmzoFM8GGHyLWULSmX75=67Tu0EnTOOoVfH4gE+HA@mail.gmail.com>
 <CAM_iQpX2prCpPDmO1U0A_wyJi_LS4wmd9MQiFKiqQT8NfGNNnw@mail.gmail.com>
 <CAADnVQJJHLuaymMEdDowharvyJr+6ta2Tg9XAR3aM+4=ysu+bg@mail.gmail.com>
 <CAM_iQpUCtXRWhMqSaoymZ6OqOywb-k4R1_mLYsLCTm7ABJ5k_A@mail.gmail.com>
 <CAADnVQJcUspoBzk9Tt3Rx_OH7-MB+m1xw+vq2k2SozYZMmpurg@mail.gmail.com>
 <CAM_iQpVaVvaEn2ORfyZQ-FN56pCdE4YPa0r2E+VgyZzvEP31cQ@mail.gmail.com>
 <CAADnVQJX8OpXhQ66jVSN1ws8tav5R8yCERr6eaS9POA+QhRx-A@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <6d648f13-756f-0e3e-b617-5f9244d733b7@mojatatu.com>
Date:   Fri, 1 Oct 2021 09:43:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJX8OpXhQ66jVSN1ws8tav5R8yCERr6eaS9POA+QhRx-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-09-29 4:57 p.m., Alexei Starovoitov wrote:

> Applying queuing discipline to non-skb context may be not your target
> but it's a reasonable and practical request to have.


While i agree that it is useful to deal with queues and scheduling
for other buffer contexts, it certainly not the same infrastructure
wise to deal with sending a context to user space vs dealing with
the qdisc environment. There are a lot of corner cases of dealing with
the mix of hard and softirqs, non-work conserving modes, multiflow
funneling and locking etc that have been refined over the years that
are incorporated into the tc + netdev infra.
The approach that Cong took of just reusing that infra will take
advantage of those learnings. The only thing that is variable between
the different qdiscs is the enqueue/dequeue algos (which is where
Cong is sticking the ebpf hooks). To me that looks like a very
good starting point as i dont believe you can come up with one size
fits all without excessive over-engineering (which seems to defeat
the purpose of ebpf).

cheers,
jamal
