Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62D48CAA8
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 19:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356052AbiALSKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 13:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356075AbiALSJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 13:09:34 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33393C029820
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:08:46 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id h11so6433798uar.5
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZoRMNrUNftcTbOM+Yn81o2eUmB5Q3ng+/5gzfhuob30=;
        b=WoN33fngJ9NdXK4V2RpEQa3gR/1b2BGruGnRe/tz/QPQbHjNBq+CRAFAsQFuynZxBM
         UOE74fnJtvt8CUydqbtvCG/rCRPA+NBaZ8G0vKgz0oY/16zhWUbRPMyL7hS5f3C9R7a7
         7qtLMtCV9H2Myfi76Gmks5KqOE1KKgHHHtWWz4VcSwj6xLCuvWXa6y9Tp+HhTLdnAPJQ
         H02fSZFL272950uQhm6e4ILTS2atiM9/Me4o3hQCjC4H5Y4sBHoVGPrSwqhwhLupiRhr
         ME5T5n6t/M4+aCveZVerqTKxkqvbfQrMVhHKObRXQp5NhW8aNmNrgjDJY2p6DpbZJH9q
         X2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZoRMNrUNftcTbOM+Yn81o2eUmB5Q3ng+/5gzfhuob30=;
        b=wmiYOx5W0yM0mlosX9354irMImef+b9VKQ5AWORs8Vd2gvtSGVBPUara33GyqH1aKf
         bOzZPeMwrlju1zYNw1RyvxRz1m4Ve2ew/wuVwgB+LDBJJFzQ00WtMnBvWhRC8BYoGUi/
         v1ZVk7b3n7K+oGvTFmrp5m56EoKbCfGyzZ7b7ghqLUgBooKlsd1P7lx1tsEv77iL9wew
         jX8FJXcnDUHsdD9OAE4VaE+tbjE3X1DVJ3EU5ln+bvd4d0/giB2kKna6d7g57xefO5Fz
         N6bLEL/gDq1RWGcU4rcUL0H7wkwLxOnei6RSd40yOFBgut4psKlS6Np18nU7sN+LWYgo
         1TIw==
X-Gm-Message-State: AOAM532BXni4mEa2EkcRbHLdow7+jpphrabt51GulFyca5NwIyjq0XF/
        R4jUrYfFpBji5NlPvPnwFrOXnw==
X-Google-Smtp-Source: ABdhPJw0K+YW+tlmlgeWNbkhC+1z7mdIn1FnR4FiZ4v8E4z2iHGcG334SnVYu3haMLrk2qcq8DA6UQ==
X-Received: by 2002:a67:f497:: with SMTP id o23mr690750vsn.70.1642010925311;
        Wed, 12 Jan 2022 10:08:45 -0800 (PST)
Received: from [192.168.1.8] ([149.86.74.57])
        by smtp.gmail.com with ESMTPSA id 188sm298229vkb.24.2022.01.12.10.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:08:44 -0800 (PST)
Message-ID: <c1d96b78-5eda-6999-bd22-55514f4900dc@isovalent.com>
Date:   Wed, 12 Jan 2022 18:08:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v4 2/8] libbpf: Implement changes needed for
 BTFGen in bpftool
Content-Language: en-GB
To:     =?UTF-8?Q?Mauricio_V=c3=a1squez?= <mauricio@kinvolk.io>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
References: <20220112142709.102423-1-mauricio@kinvolk.io>
 <20220112142709.102423-3-mauricio@kinvolk.io>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220112142709.102423-3-mauricio@kinvolk.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-12 09:27 UTC-0500 ~ Mauricio Vásquez <mauricio@kinvolk.io>
> This commit extends libbpf with the features that are needed to
> implement BTFGen:
> 
> - Implement bpf_core_create_cand_cache() and bpf_core_free_cand_cache()
> to handle candidates cache.
> - Expose bpf_core_add_cands() and bpf_core_free_cands to handle
> candidates list.
> - Expose bpf_core_calc_relo_insn() to bpftool.
> 
> Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> ---
>  tools/lib/bpf/Makefile          |  2 +-
>  tools/lib/bpf/libbpf.c          | 43 +++++++++++++++++++++------------
>  tools/lib/bpf/libbpf_internal.h | 12 +++++++++
>  3 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index f947b61b2107..dba019ee2832 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -239,7 +239,7 @@ install_lib: all_cmd
>  
>  SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h	     \
>  	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
> -	    skel_internal.h libbpf_version.h
> +	    skel_internal.h libbpf_version.h relo_core.h libbpf_internal.h
>  GEN_HDRS := $(BPF_GENERATED)

I don't think these headers should be added to libbpf's SRC_HDRS. If we
must make them available to bpftool, we probably want to copy them
explicitly through LIBBPF_INTERNAL_HDRS in bpftool's Makefile.
