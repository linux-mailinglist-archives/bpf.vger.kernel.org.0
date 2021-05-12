Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B237EF54
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347746AbhELXE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbhELW6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 18:58:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D65C06138A
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 15:56:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i67so23929794qkc.4
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8IPURGtEFzuEgj+t7YYPcm0/W4cVT5eQQ0tWFffsI14=;
        b=HvAIsfV0UlzqOabx+lDWlSq85I/ucVUl4mpIIvnw2GWbuRUnMOdj+6QmmbhFZoNsUF
         MuO2GTrChTCxEJ2y2R2CTUqhPGI/WFnG275gsyLeJOiwPgFyMJgstAJPZf0Bpj+Hmbhn
         CDSLVr3ga28zxAa38HgOmS6PvuaBr2N+GUeUNT8p+78vW8eFyNbhbq4bdoTvEWF5dEoI
         7jyoqeEYudle+D29hhosWhBJzg37f4dAKUHHUQ+kG8E+oZ/w4tjc/QXeA/vQHyUGi2MK
         X7dgevSUDFYVnL9PeOd+L/9g7cXwvMcwy4zr9g+0gbta1/iZW7aT2eJwBQAD1vSB7KZC
         gv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8IPURGtEFzuEgj+t7YYPcm0/W4cVT5eQQ0tWFffsI14=;
        b=hxuOjX3ixAg9RMdJ7Af5cW0KLWS91j8suSjfOwoXnxPKVMLsYROS8sSMtkhBdaQ3HF
         iDO6Tui88VSyJVerAn0rghp5KF+L/tXu8XEMPqVD8XZroH03hK2G2/Fvb1Tsbx/Vgejo
         0yLc0uvQ4Q5KWwsc7hQpGxIAauVFwAYkokZljFe/XPrUUR956Ja0CdupVb0X4kLi91P1
         h81YXU/guuoN7EqYgx078AfWLqQ8mb16b6ZWnOv7AJxQ8WuSU6vA0h0Hg3UQ093uVamx
         Qix+nTWLb8LUGMOMsiQQJah9CrZa2C2x1u4WbdtEQ9w4djDShpLz+mnJ3unF82yoTnmn
         DqTA==
X-Gm-Message-State: AOAM5325Zb8byhzMTxWgvyqwlOvlH9EJQ8crgUK7xmgO+VspGWoKAlr1
        oOytHVnyzHaezSYW+VxrNFaaWg==
X-Google-Smtp-Source: ABdhPJwSFEe2ZpnWeLqlZVF63LuaqBvBIvDB06fVD4y4d3nkAHVrcmB+1fyGFxvUV3y4dzwBc3hpvg==
X-Received: by 2002:a05:620a:1223:: with SMTP id v3mr35465656qkj.470.1620860166046;
        Wed, 12 May 2021 15:56:06 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-25-174-95-97-70.dsl.bell.ca. [174.95.97.70])
        by smtp.googlemail.com with ESMTPSA id w7sm1007322qtn.91.2021.05.12.15.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:56:05 -0700 (PDT)
Subject: Re: [RFC Patch bpf-next] bpf: introduce bpf timer
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Joe Stringer <joe@cilium.io>
References: <20210402192823.bqwgipmky3xsucs5@ast-mbp>
 <20210402234500.by3wigegeluy5w7j@ast-mbp>
 <CAM_iQpWf2aYbY=tKejb=nx7LWBLo1woTp-n4wOLhkUuDCz8u-Q@mail.gmail.com>
 <20210412230151.763nqvaadrrg77kd@ast-mbp.dhcp.thefacebook.com>
 <CAM_iQpWePmmpr0RKqCrQ=NPiGrq2Tx9OU9y3e4CTzFjvh5t47w@mail.gmail.com>
 <CAADnVQLsmULxJYq9rHS4xyg=VAUeexJTh35vTWTVgjeqwX4D6g@mail.gmail.com>
 <CAM_iQpVtxgZNeqh4_Pqftc3D163JnRvP3AZRuFrYNeyWLgVBVA@mail.gmail.com>
 <CAADnVQLFehCeQRbwEQ9VM-=Y3V3es2Ze8gFPs6cZHwNH0Ct7vw@mail.gmail.com>
 <CAM_iQpWDhoY_msU=AowHFq3N3OuQpvxd2ADP_Z+gxBfGduhrPA@mail.gmail.com>
 <20210427020159.hhgyfkjhzjk3lxgs@ast-mbp.dhcp.thefacebook.com>
 <CAM_iQpVE4XG7SPAVBmV2UtqUANg3X-1ngY7COYC03NrT6JkZ+g@mail.gmail.com>
 <CAADnVQK9BgguVorziWgpMktLHuPCgEaKa4fz-KCfhcZtT46teQ@mail.gmail.com>
 <CAM_iQpWBrxuT=Y3CbhxYpE5a+QSk-O=Vj4euegggXAAKTHRBqw@mail.gmail.com>
 <d38c7ccf-bc66-9b71-ef96-7fe196ac5c09@mojatatu.com>
 <CAM_iQpXLcpga=DF+ateBk1jiiCx2mPJW=WHT+j3JrS8kuPS4Zw@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <59378178-57e2-c278-02cd-d58f9973b638@mojatatu.com>
Date:   Wed, 12 May 2021 18:56:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXLcpga=DF+ateBk1jiiCx2mPJW=WHT+j3JrS8kuPS4Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-05-11 5:29 p.m., Cong Wang wrote:
> On Mon, May 10, 2021 at 1:55 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:

>>
>> That cilium PR was a good read of the general issues.
>> Our use case involves anywhere between 4-16M cached entries.
>>
>> Like i mentioned earlier:
>> we want to periodically, if some condition is met in the
>> kernel on a map entry, to cleanup, update or send unsolicited
>> housekeeping events to user space.
>> Polling in order to achieve this for that many entries is expensive.
> 
> Thanks for sharing your use case. As we discussed privately, please
> also share the performance numbers you have.
> 

The earlier tests i mentioned to you were in regards to LRU.
I can share those as well - but seems for what we are discussing
here testing cost of batch vs nobatch is more important.
Our LRU tests indicate that it is better to use global as opposed
to per-CPU LRU. We didnt dig deeper but it seemed gc/alloc - which was
happening under some lock gets very expensive regardless if you
are sending sufficient number of flows/sec (1M flows/sec in our
case).
We cannot use LRU (for reasons stated earlier). It has to be hash
table with aging under our jurisdiction. I will post numbers for
sending the entries to user space for gc.

cheers,
jamal

