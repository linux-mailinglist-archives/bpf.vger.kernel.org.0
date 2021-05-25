Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8638FE69
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhEYKH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhEYKH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 06:07:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA42C061756
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 03:06:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d11so31528491wrw.8
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NCZBCroNMR7p1JzT/myPQXtQAllEUtFBzXDIXu0tDFI=;
        b=1WJvYBUTtG7Dc0kh3Jt9ekJ07fxOMYH78nPFDgqW59zshoc/NNo3Nejmb0+bjqCxqw
         AAWd6yeEk6s1bmP+czRgQ6kDEqrgavSDLCK4g6loLlitUrxG6PsfOrRNRB/0T/H1pf8I
         8SbF3lTiOZQwz8I/vR+PsPWtbm1J565oivJvdu++JqPSS6j1mFhSrVb9aWpfcx0cxHG4
         +4rsosD1+aqYHThT3spLU6/ErxSfE+cPLpSBSUcmize8cIct2YM5Ec/si6+Bv/plza8Y
         cDQmkykqVlVFZKLcQoxvDIBSjPUQKUhjigc2Zb+QmcaCL+UiYTOaKn2voYl/z67hGLK6
         YuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCZBCroNMR7p1JzT/myPQXtQAllEUtFBzXDIXu0tDFI=;
        b=i19SLMc39CvoGsIERhiavRCxH4GJ4+rz0G2VOOK1W8SATH6aw43ici6qHyWcKRrauE
         HDhaxv19o800WNWNt6SehsWCX0BA0e1mi0+kU2IXY2W7rMVqX3w+p7J0zFDddGYfCWIE
         6iLYN7ph0qnJjiEX7eacV2+OAmaQbfACgovMYCLsVnQZSrmMCGx0CjWwPZn/m2MCxz9e
         +7kEaGjCZ9b/ftTGsAZDGljE6M1P81J5Zwr0ln2WG71lCsPKv1CdqIo1f7Z6V7r2gWgA
         QHNBTE7misq5wONwTRClKybhukwVi3AdMlDgPTbC9sincZFBB9lWm2roaK71v7WDdPAK
         CL7w==
X-Gm-Message-State: AOAM533MyHytMVOHIMzG751v4BsCUVozif3WxajnIiPS1k0uOgMNtDvY
        EQin/bbKG3REAYW+0MSJ5oQgyM6/yDxCAZcQ
X-Google-Smtp-Source: ABdhPJxs1y8PRBe6HvnjvCijxi56NE/Hsa7mjS+Uu+8RuouUoNWBQUxLe9msrO1XrOiPeH5o/aB7mg==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr26841052wrw.131.1621937184750;
        Tue, 25 May 2021 03:06:24 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.78.247])
        by smtp.gmail.com with ESMTPSA id q27sm15496069wrz.79.2021.05.25.03.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:06:23 -0700 (PDT)
Subject: Re: [PATCH v3] bpftool: Add sock_release help info for cgroup
 attach/prog load command
To:     Liu Jian <liujian56@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20210525014139.323859-1-liujian56@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <e9ce7b93-c441-3a00-5195-0f112abac22f@isovalent.com>
Date:   Tue, 25 May 2021 11:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525014139.323859-1-liujian56@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-05-25 09:41 UTC+0800 ~ Liu Jian <liujian56@huawei.com>
> The help information is not added when the function is added.
> Here add the missing information to its cli, documentation and bash completion.
> 
> Fixes: db94cc0b4805 ("bpftool: Add support for BPF_CGROUP_INET_SOCK_RELEASE")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1 -> v2:
>      Add changelog text.
> v2 -> v3:
>      Also change prog cli help info, documentation and bash completion mentioned by Quentin.
>      So the subject was also changed.

Thanks a lot for taking care of that!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
