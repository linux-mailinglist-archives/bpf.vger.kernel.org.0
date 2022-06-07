Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA022542072
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 02:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiFHA1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 20:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386264AbiFGWsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 18:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1700429B127
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjNab3OFn3CMBFJ3OlfmcWlYRbnKmNUls/dl1r6BUHg=;
        b=H6LN4g0GQKR+Lye/j2F+Q5Tf4XuL+SVqGW78789trW0bSsluVKuxHhHjmoY46zzVpC47Sj
        HJgqzGAui/wD0oAnr3RAvq4/Q7iekUo3njAcFGZg8udAIXbytehohK+J0d3K5+NSuHbaIW
        ShzQQUeib9sxUedumZn2rfqCslWbb9U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-hruUCaBiPzOt1_1Anq6iww-1; Tue, 07 Jun 2022 15:35:10 -0400
X-MC-Unique: hruUCaBiPzOt1_1Anq6iww-1
Received: by mail-lj1-f197.google.com with SMTP id m8-20020a2e9348000000b0025584af396bso2134499ljh.0
        for <bpf@vger.kernel.org>; Tue, 07 Jun 2022 12:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=UjNab3OFn3CMBFJ3OlfmcWlYRbnKmNUls/dl1r6BUHg=;
        b=hX9CgN3BUIXQd9CBPrQYf1cc3QaN+gX41XTsFpPpftY8+i0XJOJE5utKN7NSNjX4PC
         OiZyaKWABzGJUB4CF3U6CJWAAVOxGGomvb69Pxrbcg7PEgAlXLo9M85lceRueBH6po1d
         iFbvga4URSNdJtX+EAhVZlT/lC/IvCAJp7n8QQsnwe9DHeVjS7TyioHo9dSMRY4gE9MP
         OW192AA+nSUfPjMdmiwaB3fS4nQo2oZh0mUXyz1wtQFdotICwrF8B9PPhosXtdc4J/xJ
         fAUU5uqt6wlcphCUFDKoB7nOOwvLxfRLPITcmiWT5JG6L8sOcj/M/OQ0yqXQ1XdKWrm4
         n8Wg==
X-Gm-Message-State: AOAM530p2XYvw96txJLjjnG/6A5gJ9n9Km9abd/tkpI/BweBQUh9InLh
        wn73pRl1Ng44CjQtuRmE3FkDML0/rMieQZK/JrdGfC2pLBw7+46LDDq9+6KdS5r6+w5LcXVeLR5
        RXDU+RP80/u2f
X-Received: by 2002:ac2:4f03:0:b0:443:5d9d:819d with SMTP id k3-20020ac24f03000000b004435d9d819dmr19621243lfr.165.1654630508297;
        Tue, 07 Jun 2022 12:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvF3BUwFtYxvL9h0b+osvQaLHMOi+Ofm/f91Bphma8+znCnqMrYutpro42GkT2juwG1RcYtA==
X-Received: by 2002:ac2:4f03:0:b0:443:5d9d:819d with SMTP id k3-20020ac24f03000000b004435d9d819dmr19621218lfr.165.1654630508058;
        Tue, 07 Jun 2022 12:35:08 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512104800b004796a17246esm296155lfb.252.2022.06.07.12.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:35:07 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c166aa47-e404-e6ee-0ec5-0ead1923f412@redhat.com>
Date:   Tue, 7 Jun 2022 21:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add BPF-helper for accessing CLOCK_TAI
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
References: <20220606103734.92423-1-kurt@linutronix.de>
 <CAADnVQJ--oj+iZYXOwB1Rs9Qiy6Ph9HNha9pJyumVom0tiOFgg@mail.gmail.com>
 <875ylc6djv.ffs@tglx>
In-Reply-To: <875ylc6djv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 07/06/2022 11.14, Thomas Gleixner wrote:
> Alexei,
> 
> On Mon, Jun 06 2022 at 08:57, Alexei Starovoitov wrote:
>> On Mon, Jun 6, 2022 at 3:38 AM Kurt Kanzenbach <kurt@linutronix.de> wrote:
>>>
>>> From: Jesper Dangaard Brouer <brouer@redhat.com>
>>>
>>> Commit 3dc6ffae2da2 ("timekeeping: Introduce fast accessor to clock tai")
>>> introduced a fast and NMI-safe accessor for CLOCK_TAI. Especially in time
>>> sensitive networks (TSN), where all nodes are synchronized by Precision Time
>>> Protocol (PTP), it's helpful to have the possibility to generate timestamps
>>> based on CLOCK_TAI instead of CLOCK_MONOTONIC. With a BPF helper for TAI in
>>> place, it becomes very convenient to correlate activity across different
>>> machines in the network.
>>
>> That's a fresh feature. It feels risky to bake it into uapi already.
> 
> What? That's just support for a different CLOCK. What's so risky about
> it?

I didn't think it was "risky" as this is already exported as:
  EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);

Correct me if I'm wrong, but this simple gives BPF access to CLOCK_TAI
(see man clock_gettime(2)), right?
And CLOCK_TAI is not really a new/fresh type of CLOCK.

Especially for networking we need this CLOCK_TAI time as HW LaunchTime
need this (e.g. see qdisc's sch_etf.c and sch_taprio.c).

> 
>> imo it would be better to annotate tk_core variable in vmlinux BTF.
>> Then progs will be able to read all possible timekeeper offsets.
> 
> We are exposing APIs. APIs can be supported, but exposing implementation
> details creates ABIs of the worst sort because that prevents the kernel
> from changing the implementation. We've seen the fallout with the recent
> tracepoint changes already.

Hmm... annotate tk_core variable in vmlinux BTF and letting BPF progs
access this seems like an unsafe approach and we tempt BPF-developers to
think other parts are okay to access.

Accessing timekeeper->offs_tai might be okay as it is already "marked" 
with data_race(tk->offs_tai), but I'm not sure about other members, as 
I'm not expert in this area.

I assume that the include filename <linux/timekeeper_internal.h>
indicate that the maintainers don't want to open up access to struct
timekeeper...

--Jesper

