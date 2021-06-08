Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101039FC35
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFHQS7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFHQS7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 12:18:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D965C061574
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 09:16:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso2346964wmh.4
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k8ti7RMoF3BkeaTD64A4HNeRS4J8XwVgb+UTGcYG1IM=;
        b=dxFIdkmicJEYMPqKJGiOAo9tXMaYOth3Cg6GaEhInR583Q/iVs+0q/MR0ycXW/Nuls
         /UaPOeC8x/eAexRD0UlfNksFAeHHMG9LmXYHwa+13c4QGMTIhDjOuNrWG2wzKllcPGqT
         HbGlrF0DJZyVVVLoaCW1PyR5kD84wnUvGsP1d9fTnb9n20skb3XvIJ3SJam+mHXldgRq
         ioL7t4us7rFgaosvyz4MshYFI4XRD2pzH87BamUjDOj++eKZeaDhichn0chnG3a7+pLw
         75Xws6T6jwPvcF0GYVcx3dXd1mHobacG6lkUgE1JAxPaAHv1SpxCNk9nhNypnthLC1QO
         Pf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k8ti7RMoF3BkeaTD64A4HNeRS4J8XwVgb+UTGcYG1IM=;
        b=W19M0pUi0EcUskzGJUagRvlmrlYiEWOmMkHKpPTj6+7XQMrB9e/GVKUmOGIp1CwQej
         yv0fZoF6jq9yJ63vuElBGhXxB0Hqt+Da52IAVCpTSPqCgEtzJ/AM2VRE6AnQSecHRf5w
         s11SxciSYkCrOH8yu16D0v9fetz4Wwgy3GsqRDV4rEy451lgScd0OOwT2zbITNxIWwAS
         rcqWzAeriC/EPMmrCG4B5Q3tM8ar1Al4p7FDR8FZ5j1Zq9ns9Ih02QosVH4lOT0CmVIl
         F0Sted5wgM9bqjBWJLyxPWG3MF1mg53ZxjUjGmd5MezBIaYKAs3Mgh2R9kwVzS8KJGAx
         RbbA==
X-Gm-Message-State: AOAM530n975q7wwgPp52V+K87JJ4nGnet79K7ZIMOshb64cisjlT0y4P
        +Yu9jcPXco2gmLS7fghr1N3b55IWPjnbhvtq
X-Google-Smtp-Source: ABdhPJxigVoIzTRJARAMUMQjRoKL2GacNT+dGyi2gpVFKZniYCTkBCI0uVXZYpMT322ArtnI+2F9Ow==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr5139610wmg.87.1623169015640;
        Tue, 08 Jun 2021 09:16:55 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.67.214])
        by smtp.gmail.com with ESMTPSA id k12sm3333775wmr.2.2021.06.08.09.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:16:55 -0700 (PDT)
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Make docs tests fail more
 reliably
To:     Joe Stringer <joe@cilium.io>, bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org
References: <20210608015756.340385-1-joe@cilium.io>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <9f581448-c915-921b-1a24-1cdf33d84a69@isovalent.com>
Date:   Tue, 8 Jun 2021 17:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608015756.340385-1-joe@cilium.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-06-07 18:57 UTC-0700 ~ Joe Stringer <joe@cilium.io>
> Previously, if rst2man caught errors, then these would be ignored and
> the output file would be written anyway. This would allow developers to
> introduce regressions in the docs comments in the BPF headers.
> 
> Additionally, even if you instruct rst2man to fail out, it will still
> write out to the destination target file, so if you ran the tests twice
> in a row it would always pass. Use a temporary file for the initial run
> to ensure that if rst2man fails out under "--strict" mode, subsequent
> runs will not automatically pass.
> 
> Tested via ./tools/testing/selftests/bpf/test_doc_build.sh
> 
> Signed-off-by: Joe Stringer <joe@cilium.io>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
