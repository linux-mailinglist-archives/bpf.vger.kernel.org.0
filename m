Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66841B3063
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDUTb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbgDUTb6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Apr 2020 15:31:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52647C0610D6
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 12:31:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so1841949pjb.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NZNBzPPg39ZyrA+9K1+5SfyJG/p/D3ab1EaiN8kOOpQ=;
        b=D5E4GkQI8kMxBOpuDMOjkCGLYjzhv9SzQx5s04xfcN97rcZAXp10VOjQbSAr2Va2Ep
         xOLMpcHjY6zHeW3ZNP3LQzJ0SI8bn5J7t4sslKU5XoQ8Hh7f/hmV2OTnxPoAF8Ci6nyN
         khM6ZLtn45Nblr0G9fbnMUFmCSjbE687sAfFlBF1OaQI60mi6gjnomTCbesFpqhm3BVV
         RD+IOKedrI/zH7nugKGj5JxvNaJpwHc7iAPT/cZDE2h8z/lyWZ5haQUSHayyaaVJjnis
         3vFRPZc89wAtD42w3NPuMAAgRbODqu8Ixx1ApaoC8jSjx15fAdrO1g+HM4T+YSNo5KeE
         imow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NZNBzPPg39ZyrA+9K1+5SfyJG/p/D3ab1EaiN8kOOpQ=;
        b=EHGPse+15xyNvN1cEIdox/qCdcTCu+xMhzhF1LHLjYUAj5JOOwrKaDNx0DJyUlHBLf
         f510GEMgAFsImZwPcvXwPSFroJUpRNXO9QOezpmgu4ug/z6+PERCXPX88tVoV88DasSW
         Tiur+/wBCiOAZQ+zgwsAfNHO4uYL+c04lgq6c9OB5Gw1j96GNllt8asnvRviF6gXz6nP
         RvvkkcsXawaB9JMdShsm/BAQEV+/XTnVr9kGGwUDu0fo/aemtX8Yv4bJ+sIC0xD0QERi
         5LlwLW7J5KpNiv3s6n7E9afJkaBvqTd/RMc8uFTFJSAiuzmR+saO4yDx4aQ/oTqHwmgS
         bs0Q==
X-Gm-Message-State: AGi0PubSsh/1tphF4DCtgPvHdAsuDs8bCMHBqoCXfE0WcyLqnUvt6BdR
        QMwfQ4DwM8wVMtg1PqJICjs6Cg==
X-Google-Smtp-Source: APiQypJFBgqr1TsKQVWWIkIK19DIg+mC/W2jjmH2JPSKGjxUsdqPajleKdFLi5uyE7M2nN3ydVuYqg==
X-Received: by 2002:a17:902:c193:: with SMTP id d19mr21224614pld.184.1587497516540;
        Tue, 21 Apr 2020 12:31:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y25sm2998977pgc.36.2020.04.21.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:31:55 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:31:54 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: remove watermark_boost_factor_sysctl_handler
In-Reply-To: <20200421171539.288622-3-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004211231410.54578@chino.kir.corp.google.com>
References: <20200421171539.288622-1-hch@lst.de> <20200421171539.288622-3-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Apr 2020, Christoph Hellwig wrote:

> watermark_boost_factor_sysctl_handler is just a pointless wrapper for
> proc_dointvec_minmax, so remove it and use proc_dointvec_minmax
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Rientjes <rientjes@google.com>
