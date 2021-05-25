Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DEE3909B5
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhEYThC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhEYThC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 15:37:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C07BC061756
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 12:35:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 5so16676315qvk.0
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSsCLDJJZUmBzGQdFGlj6TWUswdWupQSF2qzwB+7rvE=;
        b=gk8/zRDkAvonTnslqlEVJsOYbm2rGBaIF8/kNSgA+4hqYMBhe1zyxBK3MA3LH5MY30
         9adDbV84t6bYBeb6Ml+boBLPd+GhRJs/lVjYnyz+Av2YrZ2FedfOnt83wdyJe32kLsKS
         B/G7a2UzCAsjsQo8sr8X1BkrsCTbUGEAcZydkAG42r+wP0a4Ti9m09SDZSw8x2+it3qj
         noDMtQS9HPe6D0wvaVXbs2H7tVgwwW25UkWt1+ufAtZswsA+z1KbS0rlxWClUX3lGpMJ
         nAPnR/C65auwiSUquzF6xI5sSAVThTDHdyqng441Z/5BF+oe9h0KXM1h5s7J/zf+MOgB
         /fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSsCLDJJZUmBzGQdFGlj6TWUswdWupQSF2qzwB+7rvE=;
        b=Eum6ORq83ohO7z2jVTDuH7aEJto/MQbkMYJpGStH2TtrPQb69ch1TltRhb1pIdWB9l
         vsEXq2sfyN/Zt3oBAQX1pdTs3fvS5h0Tj804+6xuHIYWO1GM7AWNqymZCaM2oCL73s2v
         if04lYu1mojB13DJbiyspmHLYrN4QYMXBR8LE3zTArBgigWaIXU3p0urDGg6vgk07mRs
         2u/jXKw1idIseQc85ToFZve2zUY9TJMQB8n0MicMDDr919HdKtfikHJ/L2iff101hpVK
         ThFAgz5SK+J7lXbEklyZatgOPInRiVJsl22rQri3AgCwMACi4A5m/q2d5m3sfTEXlXiK
         /86Q==
X-Gm-Message-State: AOAM532NCeMRXp/XxlaRDtHI9v5GVWtS3G+RowHN9GaBvFbNADUu0s7n
        7Bs4ODcx50COP9o6r7rkSZiF+A==
X-Google-Smtp-Source: ABdhPJwLuLVTRFoNUscNyLkGhi5cZfQo7AQgtGXDnzSRxYCsqP+uNP7gL+BVxz4ENvZZsPPs2n0xgg==
X-Received: by 2002:ad4:5343:: with SMTP id v3mr39071570qvs.45.1621971331234;
        Tue, 25 May 2021 12:35:31 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-211.dsl.bell.ca. [184.148.47.211])
        by smtp.googlemail.com with ESMTPSA id p11sm72483qtl.82.2021.05.25.12.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 12:35:30 -0700 (PDT)
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <CAM_iQpWDgVTCnP3xC3=z7WCH05oDUuqxrw2OjjUC69rjSQG0qQ@mail.gmail.com>
 <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
 <CAM_iQpU-Cvpf-+9R0ZdZY+5Dv+stfodrH0MhvSgryv_tGiX7pA@mail.gmail.com>
 <CAM_iQpVYBNkjDeo+2CzD-qMnR4-2uW+QdMSf_7ohwr0NjgipaQ@mail.gmail.com>
 <CAADnVQJUHydpLwtj9hRWWNGx3bPbdk-+cQiSe3MDFQpwkKmkSw@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <bcbf76c3-34d4-d550-1648-02eda587ccd7@mojatatu.com>
Date:   Tue, 25 May 2021 15:35:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJUHydpLwtj9hRWWNGx3bPbdk-+cQiSe3MDFQpwkKmkSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-05-25 2:21 p.m., Alexei Starovoitov wrote:
> On Mon, May 24, 2021 at 9:59 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:


[..]
> In general the garbage collection in any form doesn't scale.
> The conntrack logic doesn't need it. The cillium conntrack is a great
> example of how to implement a conntrack without GC.

For our use case, we need to collect info on all the flows
for various reasons (one of which is accounting of every byte and
packet).
So as a consequence - built-in GC (such as imposed by LRU)
cant interfere without our consent.

cheers,
jamal
