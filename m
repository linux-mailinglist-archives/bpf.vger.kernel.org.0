Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4682DFC20
	for <lists+bpf@lfdr.de>; Mon, 21 Dec 2020 14:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLUNBN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Dec 2020 08:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLUNBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Dec 2020 08:01:13 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FAC0613D6
        for <bpf@vger.kernel.org>; Mon, 21 Dec 2020 05:00:32 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d14so8568309qkc.13
        for <bpf@vger.kernel.org>; Mon, 21 Dec 2020 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1bfoGOpJts7jaVWLrYThHJnE3Hjye0rclWOun0MdVuI=;
        b=gq8AxiPdrhZAFV/+9bswUF8u6F7YLtuabgKaboFK4nurUWIDGR4Y+Cg7KouefoLG4t
         /dLHKupZO2KkySj5/GJizJJmes0ZTEvKe11MWWoUTg2MU4LppsBhueMdmTCmLImbW9g/
         ea6DFGa/VC9YVkIJrbuwU9B31Fc1sYm9GmYGER2GgL6HMWkcxsLgmFwDsxKFWuKL3UNe
         zCCipXeu9QLwCUmlVXosQMeDpDbI3naEuhihA+UPdE7rwiOgyQMs9OfhBMd4QGjkHBaV
         liU3un0js/RBN9NB4m+5lkPtTCWbJjU+lkpHK6BJEKyXKE5sPVdM7b1IAQNtS82hyohG
         94vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bfoGOpJts7jaVWLrYThHJnE3Hjye0rclWOun0MdVuI=;
        b=oYLG3UlxSTnmkU28kCMXg3AQpJPfe4iMitDpxQl6I/XsaZdKdRJLUY/gQpcbdE/x7f
         4rmN9rIAxjx1Rgcxt66J4M2xvAX6Yvz44FATJidtLCIrnm+bas700efEyndRvn988vEN
         I6uCogTUuxtailcQU7msveSH1gJ1Ts8XBsBlsfaaKylHaVFqzT5WSIJjkn5FOdAchulG
         la2sc/nioAvbSn5DliQ5iSrfVkwX0vybd0JzjA3H/3SGweDT6UG6QY2FO7ePxlaKym9h
         dOz2Qs5laiUzQ759tR3j0zEJHfS/mVK+Y62rzPr65tu3HpSAHCY6lH4vh8GXkSqofGzF
         b+eQ==
X-Gm-Message-State: AOAM530qhZoH/WcPrdO0NCBySJFVyaDUkElWDXIScxbPwAci/Nd5h+ZK
        wjVvExRO9hHPc1vtSywbF8MnyQ==
X-Google-Smtp-Source: ABdhPJzvIlGiY8gz/R5rJyoN53CSLcFCkOP2l5RsSai5M3qf2GfskqoTGcfovPIvZt2xcdJCzbmsRg==
X-Received: by 2002:a37:6382:: with SMTP id x124mr16619138qkb.398.1608555631945;
        Mon, 21 Dec 2020 05:00:31 -0800 (PST)
Received: from [192.168.2.48] (bras-base-kntaon1617w-grc-10-184-147-165-106.dsl.bell.ca. [184.147.165.106])
        by smtp.googlemail.com with ESMTPSA id w33sm9350850qth.34.2020.12.21.05.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 05:00:30 -0800 (PST)
Subject: Re: [PATCH v5 bpf-next 03/14] xdp: add xdp_shared_info data structure
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Shay Agroskin <shayagr@amazon.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, echaudro@redhat.com,
        jasowang@redhat.com
References: <cover.1607349924.git.lorenzo@kernel.org>
 <21d27f233e37b66c9ad4073dd09df5c2904112a4.1607349924.git.lorenzo@kernel.org>
 <5465830698257f18ae474877648f4a9fe2e1eefe.camel@kernel.org>
 <20201208110125.GC36228@lore-desk>
 <pj41zlk0tdq22i.fsf@u68c7b5b1d2d758.ant.amazon.com>
 <1b0a5b59-f7e6-78b3-93bd-2ea35274e783@mojatatu.com>
 <20201221100152.58fa6bd7@carbon>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <c7434cfc-66ed-8795-06b1-ec296eefc484@mojatatu.com>
Date:   Mon, 21 Dec 2020 08:00:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201221100152.58fa6bd7@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-12-21 4:01 a.m., Jesper Dangaard Brouer wrote:
> On Sat, 19 Dec 2020 10:30:57 -0500

>> Sorry to interject:
>> Does it make sense to use it to store arbitrary metadata or a scratchpad
>> in this space? Something equivalent to skb->cb which is lacking in
>> XDP.
> 
> Well, XDP have the data_meta area.  But difficult to rely on because a
> lot of driver don't implement it.  And Saeed and I plan to use this
> area and populate it with driver info from RX-descriptor.
> 

What i was thinking is some scratch pad that i can write to within
an XDP prog (not driver); example, in a prog array map the scratch
pad is written by one program in the array and read by another later on.
skb->cb allows for that. Unless you mean i can already write to some
XDP data_meta area?

cheers,
jamal
