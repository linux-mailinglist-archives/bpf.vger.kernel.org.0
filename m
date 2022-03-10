Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3104D4704
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 13:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiCJMcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 07:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiCJMcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 07:32:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78689325
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 04:31:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l10so3174147wmb.0
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KFEqXsw3kCazEmiGQY9m37Tsc5XnicKLMhtnnXNd7/w=;
        b=u9hGPoBHK+HjInRQgc7cbjpCZ5pNRWPN2c0yrlPxHmvqlb7REV8Nn8+51iPYI3/Nb2
         lXeXRlREi5JoN31G2GUaYOLAOkMUbefgAQZf1ed+S7jskVVtm15SCQ2rsXdlrRxEh3t5
         Jn2r7bDC/dMJ+nX/Y5Ki2IndPpjszIy5MhM5gifCmAlJMfKLj3f3EbBLTJA0lPUF9U0a
         71UdwHbE1/KxpbMDIGJk/JuVgbWA0sJiJt446iS41Av9QWjcgIRJGAcUPya4jEJ+PTvW
         4hXqa7GBatuU7D5dh6t/gpwbNhizRG83FBQwIhgSysLn8Jia0CEcVRdM7kTXASlV3aek
         CWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KFEqXsw3kCazEmiGQY9m37Tsc5XnicKLMhtnnXNd7/w=;
        b=udEoNCmTuft7ynHzMZJVf2uzsV+azAAKSUdLJT3l7i6BWmtwM3R2WP2pBtCaj41vT/
         ghkMODMAGYxviQkpNGuypCHclOiibyNCcOzTbAOIpZ23ziDNm6qQeBFopbwSs4ZI6u4Z
         Odjz6mPL6xO0KfuRsRdhP7jB0pWfMIdUU0OorizI6RD9OcMCDPqtAFMYoC+UDhTh5Cmr
         ZpfqChjIN6eldmeyz2b8kDOhmUbdMJqSexu83pGDj3+exXiOudS9gTAlR3/w10kBg8mP
         OY1dY1fjsmP49SpXpJxoTEuZEux8G7v8UpMx0ilXIy7KeBZ7dnJ87vr0ztQe722yrASD
         BGnw==
X-Gm-Message-State: AOAM531cULtm6i2WBdcA5pz6QF0t5pgKj4MBu4gET3hJo5nI1kDwqYXD
        VxsDYJG1iO66A0Kc8+0bOAa0xQ==
X-Google-Smtp-Source: ABdhPJxWd/wCiyfqQPXP5AmoTr0J2f1m/2mys+M8TIAkoS5X4o0p9ZGgZ1QBytNduK3usIoIpT2qAA==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr11685361wmp.41.1646915463091;
        Thu, 10 Mar 2022 04:31:03 -0800 (PST)
Received: from [192.168.1.8] ([149.86.74.181])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm4306526wmb.22.2022.03.10.04.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:31:02 -0800 (PST)
Message-ID: <a4e23b5e-a8c0-452a-3b55-a22d38fccc9b@isovalent.com>
Date:   Thu, 10 Mar 2022 12:31:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [v3,bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
Content-Language: en-GB
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com
References: <20220310121846.921256-1-niklas.soderlund@corigine.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220310121846.921256-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-10 13:18 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> feature probing") removed the support to probe for BPF offload features.
> This is still something that is useful for NFP NIC that can support
> offloading of BPF programs.
> 
> The reason for the dropped support was that libbpf starting with v1.0
> would drop support for passing the ifindex to the BPF prog/map/helper
> feature probing APIs. In order to keep this useful feature for NFP
> restore the functionality by moving it directly into bpftool.
> 
> The code restored is a simplified version of the code that existed in
> libbpf which supposed passing the ifindex. The simplification is that it
> only targets the cases where ifindex is given and call into libbpf for
> the cases where it's not.
> 
> Before restoring support for probing offload features:
> 
>   # bpftool feature probe dev ens4np0
>   Scanning system call availability...
>   bpf() syscall is available
> 
>   Scanning eBPF program types...
> 
>   Scanning eBPF map types...
> 
>   Scanning eBPF helper functions...
>   eBPF helpers supported for program type sched_cls:
>   eBPF helpers supported for program type xdp:
> 
>   Scanning miscellaneous eBPF features...
>   Large program size limit is NOT available
>   Bounded loop support is NOT available
>   ISA extension v2 is NOT available
>   ISA extension v3 is NOT available
> 
> With support for probing offload features restored:
> 
>   # bpftool feature probe dev ens4np0
>   Scanning system call availability...
>   bpf() syscall is available
> 
>   Scanning eBPF program types...
>   eBPF program_type sched_cls is available
>   eBPF program_type xdp is available
> 
>   Scanning eBPF map types...
>   eBPF map_type hash is available
>   eBPF map_type array is available
> 
>   Scanning eBPF helper functions...
>   eBPF helpers supported for program type sched_cls:
>   	- bpf_map_lookup_elem
>   	- bpf_get_prandom_u32
>   	- bpf_perf_event_output
>   eBPF helpers supported for program type xdp:
>   	- bpf_map_lookup_elem
>   	- bpf_get_prandom_u32
>   	- bpf_perf_event_output
>   	- bpf_xdp_adjust_head
>   	- bpf_xdp_adjust_tail
> 
>   Scanning miscellaneous eBPF features...
>   Large program size limit is NOT available
>   Bounded loop support is NOT available
>   ISA extension v2 is NOT available
>   ISA extension v3 is NOT available
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Signed-off-by: Simon Horman <simon.horman@corigine.com>

Looks good to me, thank you!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
