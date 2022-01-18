Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA2492A12
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiARQF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346200AbiARQF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 11:05:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53326C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 08:05:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso333745wmb.3
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=mXK1yMEB/ZsHDTm2YIcPzEej8Ss6LhpBkd3vI5VwyoY=;
        b=EXwdluNrualsTAbCQQj+m72+hbSZ2BcDiXo++kxsx3Ai4h2AY5LV/6qv+/dsja3CoN
         x7baiHPoiiZsDN2kf84sZtVbdiKqOyzoK3rZUUre7WxS7MQHDSm2JIF7Ycr6Z7IaGNp0
         DnlAcNPvRGpOXzOm8nCUY0sn2kTBEXSl7xh4K0Y1m+04Lc+e+gaFR6Cbrj0paXcG2RmW
         LbHeu39JLR+ZIFo6zu72Coytab+PzfvOziHUIIjb97VbDNshCeRfPPjW4iSEAQ+Azo+i
         vqhLPyFwGxG0IDO4arkSxmniUopTbzCOUUUWLOSrxUO05d+KUmmYi1E6Cv+o23RYZaT2
         3Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=mXK1yMEB/ZsHDTm2YIcPzEej8Ss6LhpBkd3vI5VwyoY=;
        b=gf9FmgqgnzQcEONBDaOO+NZNk7Xan8JdiHG3TzWMLrtTIJ/l8cs1XOgMHS7fazHyn0
         xY7anG4TWSY06TX4f0Eei9lFIWiL2I9ueWfyrh7lS1dR3oZaZY/C9GSWPvW1hFQdgvo7
         CAixd6Ev3ZzJPpZRtth31918nzatcXHAs7s6JysVDekblZULShS2/CCHuSQf6Q9c0LkG
         U58jmw1vK9ysnwdtV2Mzu3sxoWCHS7L/w8VpTngKYuIL1x6lpYivXG/1FKXrwGD7h0xr
         UKSra8eFvAFtcayjGA1XKsa7d/iFEn1XL4xexw2YUtfwhCqLktXqiP4vy2aqq8NUu/ZE
         5ZZA==
X-Gm-Message-State: AOAM533yELsD48BKN4jY9fdxFMNtMujmDbQ53wsQ6rB+7CTKRPQJus2T
        y9Zy44MnLQlCBpXsLfeEinLu8w==
X-Google-Smtp-Source: ABdhPJyQDV5JJv4hX83VNqVqodXhU1jXsHZwXoXmMKC5cgRkmAqQ6BnJMcLwItMT07iRumFlHwpqiQ==
X-Received: by 2002:adf:dfcb:: with SMTP id q11mr24542541wrn.181.1642521954935;
        Tue, 18 Jan 2022 08:05:54 -0800 (PST)
Received: from [192.168.1.8] ([149.86.85.171])
        by smtp.gmail.com with ESMTPSA id v15sm3206422wrx.41.2022.01.18.08.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:05:54 -0800 (PST)
Message-ID: <8df5c0c1-d7bb-b7a8-16c9-1b608791213b@isovalent.com>
Date:   Tue, 18 Jan 2022 16:05:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next 1/2] bpf/scripts: Make description and returns
 section for helpers/syscalls mandatory
Content-Language: en-GB
From:   Quentin Monnet <quentin@isovalent.com>
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, andrii.nakryiko@gmail.com
References: <20220118115620.849425-1-usama.arif@bytedance.com>
 <f3075676-723a-e1fe-de08-8338f6a1651b@isovalent.com>
In-Reply-To: <f3075676-723a-e1fe-de08-8338f6a1651b@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-18 16:04 UTC+0000 ~ Quentin Monnet <quentin@isovalent.com>
> 2022-01-18 11:56 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>> This  enforce a minimal formatting consistency for the documentation. The
>> description and returns missing for a few helpers have also been added.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Apologies, this is obviously not a Signed-off, I meant:

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
