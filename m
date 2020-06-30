Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB20920F3B1
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgF3Llg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733041AbgF3Lle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 07:41:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438ECC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 04:41:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so18496859wmg.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS/ihn4I7gBA1s//7CfmIRKE50kgObglKHu1jFyAkcw=;
        b=Riqjdk1FEU2lTYQ723CMZXxakGT8I6LEw4Rb5Isax71tz0TDVGju5NvwqTQpIH2blu
         NU7MChP5ooPEONarZGJkoVnw7fF26EpZGt/OPcmE1CVQq2WJXhHyeOTiUbbzzNbRbttq
         tNO084BpHK5/GM10XqE8uX8oe3NvJRPHu9Vo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS/ihn4I7gBA1s//7CfmIRKE50kgObglKHu1jFyAkcw=;
        b=O1Z3Acu5ogt1YyXctMjyuAZh7cNcwSmQ59AfH9t7E+yQ686NVWDgfyebDP49BPtPWw
         pVeMOHODjKNZleWZ4VZeEeM1d2srur9P2wKdm82CG1d4e/v+KwPrfRS7zkTWamhczWDd
         e4rca/WJ486Cs7PMGexbFNnc2j3DriOYuUoMF3iYhjisnVt3rAY2zt2mP/DNLEiLyVO6
         F1InbjHjRWTf1QcXZ6cYSEgP5SUP4WjmyK+732PusK+XbdfRJlF/xOjUrB0LdfmHu8/u
         BdhGceUyHTR+l13Ime+9VXWMVOGWFbXJx/O078avq8g1jU+Ztfv/shPEiXbem+ZePudW
         zQog==
X-Gm-Message-State: AOAM531HWxzXCCYf7Q2bpLi42brjhN2M6pSS+WGjroLFdGs4GvtoJQ4t
        6yIVtgSap5k2KD0HuCMb2omh/A==
X-Google-Smtp-Source: ABdhPJyq2K90Ft5jATln3kdT46BEoGknl0+k6a9ORzS2FTrccO5gvkXZWexF6XXPdio9RAFQEapY0w==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr22873949wmj.54.1593517291516;
        Tue, 30 Jun 2020 04:41:31 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id p13sm3559287wrn.0.2020.06.30.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:41:31 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 30 Jun 2020 13:41:29 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, paulmck@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 3/5] bpf: Add bpf_copy_from_user() helper.
Message-ID: <20200630114129.GA420871@google.com>
References: <20200630043343.53195-1-alexei.starovoitov@gmail.com>
 <20200630043343.53195-4-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630043343.53195-4-alexei.starovoitov@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29-Jun 21:33, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Sleepable BPF programs can now use copy_from_user() to access user memory.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Really looking forward!

Acked-by: KP Singh <kpsingh@google.com>

> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 11 ++++++++++-
>  kernel/bpf/helpers.c           | 22 ++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h | 11 ++++++++++-
>  5 files changed, 45 insertions(+), 2 deletions(-)
> 

[...]

> +	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> -- 
> 2.23.0
> 
