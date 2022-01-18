Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60897492A09
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbiARQEd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 11:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbiARQEd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 11:04:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1248C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 08:04:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so8742517wmb.1
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4vLQ/LJRpBvFCktzHckjv3WErXi0TVUfn7JdHXFa/is=;
        b=fT9OiCEoRWm4RZPbRpZZoFVtWEgCYKK3TPb4S32TRn3wKvc4LAS11B2jWf80Bt9jxY
         G92SrbjigIUIH0V/dwhsQOIThHDisLZYTNAdTKQgBOtMMmtO1F8tbWc+lleg5vHwC3GG
         D7xfCAWFuTtVMJD2KP+0hXSmKwyqNsPLZ5pQiznv5VOEwkoOVlBVYAzgUbC1fLVrvitp
         mrx2OOMI/4ZbkAQzRLfnFtA4bYzL8776XyPkunUIT1fMKSCfzTV6+yP+LNxe4cpS3hBc
         G0YMYfjwMPTmASADTYsZxjBQo6nBDaCAfo+bY9d1j17ilBelX8rSokIFpICXrLuY8RZw
         A+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4vLQ/LJRpBvFCktzHckjv3WErXi0TVUfn7JdHXFa/is=;
        b=5Tz5nRTIn5I8uRM+aX2PGa4/DZN7/0S0Ydv1E+rBHT7NJfjbQJHUvBfYucHJgFIHv3
         MOvw33A+BYnXviaeDuOYL8i7bJ8aA1KOw4fJzdWPTBkXcSgyAfBXP8Dw39BEkgOI0Suj
         DgRtFpXXhJ0LriLdHam4S+GqARq8JLWt3h/ky4ahIZNzg6GZgjYRNc3OTXVoYnltu3Wk
         WPMzFmZJu8CzZFCrJRiL3LFOcYjM39Y23jLpdMsbkm2YdkN4VldiuLdMgXy6ElGx3I+x
         FOWP87t4xf9A6xucmORYMsccJXAu9SLYJJUWkWo3c0xVmfSUQiqUk3XlAdf1jieDd+fS
         Btng==
X-Gm-Message-State: AOAM530vc3c7lECYKTBTcWprKhObMv7ZgklMHfxJAfGT+6jg+SYBRtDm
        Yp3y9UFJnFYNRA/JV4sLawCLkg==
X-Google-Smtp-Source: ABdhPJzvVtADH8QPKbAxvFwY112espyx/Td/YXRaMjycMzBzZAP86HptNYrxF/x4HgVJM7hGe/hdiA==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr2921148wre.156.1642521871385;
        Tue, 18 Jan 2022 08:04:31 -0800 (PST)
Received: from [192.168.1.8] ([149.86.85.171])
        by smtp.gmail.com with ESMTPSA id l4sm16719268wru.74.2022.01.18.08.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:04:30 -0800 (PST)
Message-ID: <f3075676-723a-e1fe-de08-8338f6a1651b@isovalent.com>
Date:   Tue, 18 Jan 2022 16:04:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next 1/2] bpf/scripts: Make description and returns
 section for helpers/syscalls mandatory
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, andrii.nakryiko@gmail.com
References: <20220118115620.849425-1-usama.arif@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220118115620.849425-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-18 11:56 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> This  enforce a minimal formatting consistency for the documentation. The
> description and returns missing for a few helpers have also been added.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Thank you!
