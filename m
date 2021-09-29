Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453941C788
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbhI2O6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344723AbhI2O6J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 10:58:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3410C061760
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 07:56:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w29so4763946wra.8
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfAo3cdVdjPUV6pEXL8FQsS7Ke/rTwTEvG/9aTqCFjY=;
        b=bMjNCxXBUAuQEkuVxpP+AmnxM0sw8ckdBezCZ8qTLlBn7xb1DPzzOevOGtfB1HMQJ7
         yNimKNFISVOCm/3nJn+xvys3x549D7c4bFt0jWsK+i9zC0XW8RccB6tp5k3PPM3fUFkh
         IU60hYXMj0QNYBKOk+Da6B9gCo/DD4+4ahvVDvrKTqF/o+S6b9Qzp/lT6D3GFhmz78wY
         BvD/1JEA0fijKi5iBCJT2xvQivNlCM6xWB/dbRUggt5II5vU73hOU8Sz1AUyylwt3ZHz
         cjFNz+5roQMWk4bsIsilbf1k6ZSEayF4cRVHZal9xkjaxjzSmMpYBypenw9TfH3uEVk9
         klcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bfAo3cdVdjPUV6pEXL8FQsS7Ke/rTwTEvG/9aTqCFjY=;
        b=P9oe09vQZIw1kWMY/MbeGYAm1+sOX+rv9Bt2BzQoFoZo30LrKBd976mmoN9425oBdz
         44Ph2dMf3kOGWOsiWJA+OCETukKDQh9VPRao5cOmDh5PJoKn3xuNxssWu4wRZmC7nvJz
         EuA3ewWZUE16cc9yDSWmIDW8Zwkl0MSd9uS2121bAEcc2NnM+NlUMqecZU216dTHePrh
         rXpRTs16CdR+9ZX4lm3ZNy8+ewWn6k/036J5AFotkds/xMiRbfq17Sf0Hh51jUMd8kF7
         1Ge9BCF7euCpPPHEI3W55YVC2+Xu3h2iHhkArjEXpevdxVZwYOq1fK/sOBSLDODKVyXg
         sLEA==
X-Gm-Message-State: AOAM532v32rbKi4Kq5OIpTci/5h68Yd3kQqnJqMT+PW1LejUmqbR0axg
        CyqU/dzL7ghSj4RLpUjc9r8H5w==
X-Google-Smtp-Source: ABdhPJyp/imGDT5ad6y9Nzq9hI1WPlBhRFpSPU8oRLnRL7KGv5egEUHPI/C1pJ7k2WtQkbv+biynMg==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr346530wru.232.1632927386382;
        Wed, 29 Sep 2021 07:56:26 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:784a:8d94:ffe2:2cdc? ([2a01:e0a:410:bb00:784a:8d94:ffe2:2cdc])
        by smtp.gmail.com with ESMTPSA id o16sm148730wrx.11.2021.09.29.07.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:56:25 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH bpf-next 4/4] bpf: export bpf_jit_current
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210924095542.33697-1-lmb@cloudflare.com>
 <20210924095542.33697-5-lmb@cloudflare.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <ba1a177b-f5ca-bf63-b7d1-43688f8ba9ec@6wind.com>
Date:   Wed, 29 Sep 2021 16:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924095542.33697-5-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Le 24/09/2021 à 11:55, Lorenz Bauer a écrit :
> Expose bpf_jit_current as a read only value via sysctl.
bpf_jit_current unit is 'pages' and bpf_jit_limit unit is bytes.
Maybe exposing those values with the same unit will ease debugging.


Regards,
Nicolas
