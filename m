Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95E3215A5
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 13:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVMDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 07:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVMDC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 07:03:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3493C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:02:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a132so13349137wmc.0
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CwGLaj4m00enQdy2aJRdc9gZzgOt3EZyqnBuSIAmb7I=;
        b=Mv35pilRElnhyaR2qEddMz1vRzwx7zqWdT6g3rIYN8pIR3kRffm+MFYPt7LBBJQ77x
         yvGygSeUYhYHPzLPqHT+e3Dxxd2jrQuON1QuB2jDxh74dY39R7pFyySXLYDSQni2Z1kj
         okYUdpu+VsMQBvpoh+37RHTHMVAk3yIn77Q/4niphXJ2i2RIerSx+hcH6XQFkIqR33eu
         t3tvUzvVZ0k3kWd4XbZyJSyCClFqaZr9xtJVgK4TkeX/y8u7mQofTjrBjguSe53jlNV7
         lBgfPjkr+YkprAcVONWb2YbETi36gmsvByCtY0Ib4+sMic2cNCd3Y3f+DWs00+t2KVhI
         8NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CwGLaj4m00enQdy2aJRdc9gZzgOt3EZyqnBuSIAmb7I=;
        b=YpHZmwlec1+MaimhynrJsJAMCUAxXeoS4Rqq+bXZ+KNVtAo738F/LpdPNZca+DrMIR
         97syhXRxxh0inTkTCDVaYpZKUACo302a0NUBuLalGNPuUfKzTxxrfTr89BkG0gotWyPp
         AfeUeFjVTP9RgcDwQCeP97bLOUJxFFWCITDs+NMgxoigc56zNKipaQw1fo7OaMtWE4rN
         On0vzul7zoQKbTawk6KJZdWvUGJjT3gfYHNJqXhSchUXScN+UXC62hLhKsM861PfBHuN
         y/xWwS/nrPL/jZMjRCIhWIL1WVUpK/FYK+yhAWyrxTDkAlpjNELdIRJWjJNj96WV+jd+
         cmxA==
X-Gm-Message-State: AOAM533cGYmWnvR+pProzMm5Lr0rYVPXxctbedVUCnxucdTrzNMLumNi
        MbFIRFsP0t1pjPYQRdm/P2QQQg4QsCzGOUIQ
X-Google-Smtp-Source: ABdhPJxE++bzcC+x9cBFumu/bN+XletVKaedZY4yL0H9puutPTUjV9Taa2YoFyzyz3tXhtctyTQdZg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr19837211wmc.162.1613995340261;
        Mon, 22 Feb 2021 04:02:20 -0800 (PST)
Received: from [192.168.1.9] ([194.35.118.216])
        by smtp.gmail.com with ESMTPSA id l1sm25425911wmi.48.2021.02.22.04.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 04:02:19 -0800 (PST)
Subject: Re: [PATCH v2 bpf-next] Add CONFIG_DEBUG_INFO_BTF check to bpftool
 feature command
To:     grantseltzer <grantseltzer@gmail.com>, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org
References: <20210220051321.79729-1-grantseltzer@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <7f29fc1c-85ba-89a9-44eb-d5733040eb7f@isovalent.com>
Date:   Mon, 22 Feb 2021 12:02:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210220051321.79729-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-02-20 05:13 UTC+0000 ~ grantseltzer <grantseltzer@gmail.com>
> This adds the CONFIG_DEBUG_INFO_BTF kernel compile option to output of
> the bpftool feature command. This is relevant for developers that want
> to use libbpf to account for data structure definition differences
> between kernels.
> 
> Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> ---
>  tools/bpf/bpftool/feature.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 359960a8f..34343e7fa 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		{ "CONFIG_BPF_JIT", },
>  		/* Avoid compiling eBPF interpreter (use JIT only) */
>  		{ "CONFIG_BPF_JIT_ALWAYS_ON", },
> +		/* Enable using BTF debug information */
> +		{ "CONFIG_DEBUG_INFO_BTF", },

Nit: The comment is slightly misleading, you can use BTF to list program
C instructions or map structures without this option for example. Maybe
something like this?

	/* Kernel BTF debug information available */

Thanks for the patch!
Quentin
