Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4E1D1010
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEMKmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgEMKme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 06:42:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54571C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 03:42:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 50so19733493wrc.11
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OpQh1ZV/M07VcOLtThlxG1BOKeVmdsO0NNyLBM2aU1k=;
        b=rTZD+5qw8cEv+AUyMimpI5VwZihR3PvqGTcy3A+deRGRjxM4MNjnjMUDpkKjlLM68o
         EDBFLVueTePAuE1dBX3iIJWs+lFp7Xn2+Ff6XNFHaGzyAcz/P4zMEes4yezjc1ZhGPw5
         KW3u3ZqnwEiufO7KfAeD1TnWve+3DZKqz9MIZRqXjYylvZGkGmXbV0AGM+2vDoWZ3DuC
         cma0D7AyE7hexLxe6jJopK4XGEmVfWNpy5j3rX5vDEEfeqd6MEDq3UK+J9gm2di1k+lC
         tPanOu3bDURZhuOcV7FLklQM63CKQep1ap4AosYBBZEpWErGaXkuBOXBEBmBTcrO+vJc
         92Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OpQh1ZV/M07VcOLtThlxG1BOKeVmdsO0NNyLBM2aU1k=;
        b=TZFd7Kv2KM76n/a+CMc/ESBPL0lYPuQJAK/+7X0LDslGATEnwcKvlYcr8NQADii5mY
         mmqEcINpp0mhvtuof/TUfDTABFb/Ft3vVH6f2YoFUuP4Dze3PPFYBCXfMggTwnevMW92
         CavCGCnepP+tafWehRGprI5+38mTAX3YmJgX8imZxquN4FHU0NjW6H4MaKYmn/vUrGAp
         eMyxI+H6dAD4u0A/EKS77WnjWqXyeL1BrnhaTPDEEeJzVqg1Dt1iY+UOSLq39wi+2GDC
         sDKKkWpQ6YHiHvGYEz3WLgLz6hLF7jPn02+CPNwHF2K23IQ+WNcHIX8lhzKZFfSfAOG3
         T29Q==
X-Gm-Message-State: AOAM533ahLMDeA+AsGj6x36k48cihILyT6mr1u2XrjMO2cL7hC2L2UcC
        6Dxlx2OcwJ9wQyk1PkjUu0lI2Q==
X-Google-Smtp-Source: ABdhPJx2OXCTYsclOXYL5aMT0nEleZM2BFXBxse2ImWzDS5IQmo56UeJPXqUuG/0Nlgf/I8ETK1lbQ==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr6995049wrq.375.1589366553029;
        Wed, 13 May 2020 03:42:33 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.90])
        by smtp.gmail.com with ESMTPSA id k13sm1304602wmj.40.2020.05.13.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:42:32 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpf, bpftool: Allow probing for CONFIG_HZ from
 kernel config
To:     Daniel Borkmann <daniel@iogearbox.net>,
        alexei.starovoitov@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>
References: <20200513075849.20868-1-daniel@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <4cc2a445-5d38-8b9c-71b1-bb5c69ac2553@isovalent.com>
Date:   Wed, 13 May 2020 11:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513075849.20868-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-05-13 09:58 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> In Cilium we've recently switched to make use of bpf_jiffies64() for
> parts of our tc and XDP datapath since bpf_ktime_get_ns() is more
> expensive and high-precision is not needed for our timeouts we have
> anyway. Our agent has a probe manager which picks up the json of
> bpftool's feature probe and we also use the macro output in our C
> programs e.g. to have workarounds when helpers are not available on
> older kernels.
> 
> Extend the kernel config info dump to also include the kernel's
> CONFIG_HZ, and rework the probe_kernel_image_config() for allowing a
> macro dump such that CONFIG_HZ can be propagated to BPF C code as a
> simple define if available via config. Latter allows to have _compile-
> time_ resolution of jiffies <-> sec conversion in our code since all
> are propagated as known constants.
> 
> Given we cannot generally assume availability of kconfig everywhere,
> we also have a kernel hz probe [0] as a fallback. Potentially, bpftool
> could have an integrated probe fallback as well, although to derive it,
> we might need to place it under 'bpftool feature probe full' or similar
> given it would slow down the probing process overall. Yet 'full' doesn't
> fit either for us since we don't want to pollute the kernel log with
> warning messages from bpf_probe_write_user() and bpf_trace_printk() on
> agent startup; I've left it out for the time being.
> 
>   [0] https://github.com/cilium/cilium/blob/master/bpf/cilium-probe-kernel-hz.c
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>

Looks good to me, thanks!

I think at the time the "bpftool feature probe" was added we didn't
settle on a particular format for dumping the CONFIG_* as part as the C
macro output, but other than that I can see no specific reason why not
to have them, so we could even list them all and avoid the macro_dump
bool. But I'm fine either way, other CONFIG_* can still be added to C
macro output at a later time if someone needs them anyway.

Regarding a fallback for the jiffies, not sure what would be best. I
agree with you for the "full" keyword, so we would need another word I
suppose. But adding new keyword for fallbacks for probing features not
directly related to BPF might be going a bit beyond bpftool's scope? I
don't know. Anyway, for the current patch:

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
