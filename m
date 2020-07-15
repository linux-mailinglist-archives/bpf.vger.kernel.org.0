Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3357A2212F7
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGOQtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgGOQtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 12:49:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D6EC08C5DB
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 09:49:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so3369665wrw.12
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hUz/UVXmFj5gZkksWixwGiXAm29+FzSoDE9Tp4/NL1g=;
        b=XrZxDHa2amTrRfCa2T5Rp/q84MXJ1I7b+U90J1WhsNps3hWZdjZbsa02bucGaUTHBg
         mEU3a1Bw6aEH6emRRQ8GFwROQJTPl18NYZKVKG9O2Mw9qhF596sToQvTQ0L2BvkL3uVn
         Av2PBRokopzC+dq6d/9GEbgbYI+2m6Aj+xV0cLwOciEG9+R9cfDxT+AzOEFO2v+Z16df
         9S5Q+yIWynYnu/0krW4BKngKk9I1xFRVrMBT00E2a90hfYYq2f1TahWze3GSwQ1f4FUK
         iV/w0R6LawIh0SjtOOBoLF+67ZkBN43rOWo7Sxh/hwYqhKrCMNSZqOdtA+OXKSUqryCc
         fomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUz/UVXmFj5gZkksWixwGiXAm29+FzSoDE9Tp4/NL1g=;
        b=K4OIG/HmfCHZT0IOkld5X+D8pZlvh9L4XAaIT4YU4sgpLcARHPQsCZKf9xGlHhKUEL
         CFLEWDquEI4a/kEedPl8e+HfdMARTvmGvzfxPhiNWQTVqX3A+Wd9PL8Eqsnz5ydqsM5/
         jdMauNsEuewDGqc4sdAhHxGmY376Gj0MAeHUPL2XU8s6ESdpHA808tAyAaJb2PMUYa8i
         TRIK8HPuEwIHBZzDG30nJT7YhpdpxGbZMN+HX6pjJBctikGmIlIiLuUzYUYl9DlN4Gj2
         o+0D1UvKNFq5+ceuf/kXWAeKNxL1rhKtgvN9Cfjvzu83bnwob8wbPCbmqWm6wKbcMkHX
         BI7Q==
X-Gm-Message-State: AOAM530gowkOkjlKKtUQ1DnmbhH1NT5ecdpmLQ2azZqQUGhlJ1CoIXDR
        CNDxZUj5GcOlKqN00R5OI7FWHA==
X-Google-Smtp-Source: ABdhPJz20Mxi0oSIWkoJNQFwJ7mmOvvCgI7hszvgLA57LfanXcsC/k6Sp0CzUZdQool/5nzby8X8DA==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr271208wrp.412.1594831745783;
        Wed, 15 Jul 2020 09:49:05 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.117.124])
        by smtp.gmail.com with ESMTPSA id f15sm4170272wmj.44.2020.07.15.09.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 09:49:05 -0700 (PDT)
Subject: Re: [PATCH] tools/bpftool: Fix error return code in do_skeleton()
To:     YueHaibing <yuehaibing@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200715031353.14692-1-yuehaibing@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <51033bf4-c718-2939-cf18-e5e219e7beb1@isovalent.com>
Date:   Wed, 15 Jul 2020 17:49:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715031353.14692-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-07-15 11:13 UTC+0800 ~ YueHaibing <yuehaibing@huawei.com>
> The error return code should be PTR_ERR(obj) other than
> PTR_ERR(NULL).
> 
> Fixes: 5dc7a8b21144 ("bpftool, selftests/bpf: Embed object file inside skeleton")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
