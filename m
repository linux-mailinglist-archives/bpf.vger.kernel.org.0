Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7F6DAB7D
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDGK1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDGK1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 06:27:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD084C05;
        Fri,  7 Apr 2023 03:27:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i9so41964924wrp.3;
        Fri, 07 Apr 2023 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680863239; x=1683455239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45fvxnSeFr51avGPKhwK3t5ZbAaRZOEhoU45v/9aioU=;
        b=MKcGhh/vH4fCViGjtz0AXhqBvfvPy7AEoeDFIFVPmcjIHWR1cvgdVq/fJPeQUT70lM
         oCDAkQFjbGUVAylsz45DVubpYZ/7qcmcFIpP++L5z/D0xcc3zQYZk7YJt4kc6SJw+JUt
         Naa62qBmlYGFgws9x6k9owJc2zCfZ03ZuZwLN863fhphOWvPeOSbK3A7uwc1cHA98A1c
         1WrL7Q2r5YyyQwjf+itRmN9Ij78bb+ufTOzayTZNfaHe4nVkl0l11Q1h/ZnHfWWkndAl
         4xYj0gNqAHKTqoqUuOiHRkbo6eWgtDr3dIwrv8ISoJjWBIntJ4NXX20Gu6C4lzEKd2Yj
         dL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680863239; x=1683455239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45fvxnSeFr51avGPKhwK3t5ZbAaRZOEhoU45v/9aioU=;
        b=1LlQrK7HsuqXRzS8RmOiR8zwyKn3YHM0p5IDzpYCZJnLSssFEp8xJLDoHw1NSpqrW1
         QFZL+SCvKOtYmaDDpuWM3KnanWHafPxFKwFiifGeBKSOtULKkVl8hcgd+N5DU4zD+FgC
         3/ZopxQ4Cmnry0XR7eDOibY3L+mFT+DRt3l380xfrWV5rbmSkfzSkemRTH5Ur2Pifi2u
         3iikLfJ39YkqNWriYT4GXyG6xsm6LiQd9S+dzlxyJ03jd1LRikbF5xXomem1Livi3LEj
         zbwq+WbaEFPhxjaaeMQMY371EYXX7yQiKp4Q1ko65rCV58+m0Ulk5ofxkspMiJ/bNuqX
         D7fQ==
X-Gm-Message-State: AAQBX9cp2RaHvVOAQAkRrk+FQ8cNDIZrfxJLZK74vkmKlMUryBAUvO31
        pgt25wy1W1EMTTgPDyGi+q4=
X-Google-Smtp-Source: AKy350ZWeNWeTOaqH2zeUNWN2Xpa/uoOpT0bCwwEy7k+6VIJiD7TGUKi7oRxrUlrYcfTRUW26QhYZA==
X-Received: by 2002:a5d:6607:0:b0:2cd:f2c6:5d37 with SMTP id n7-20020a5d6607000000b002cdf2c65d37mr935048wru.5.1680863238663;
        Fri, 07 Apr 2023 03:27:18 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe345000000b002efb139ce72sm1149970wrj.36.2023.04.07.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:27:18 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 7 Apr 2023 11:27:15 +0100
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH bpf-next] tools headers: Remove s390 ptrace.h in
 check-headers.sh
Message-ID: <ZC/wA2NoO7yI/xNm@krava>
References: <1680834090-2322-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680834090-2322-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 10:21:30AM +0800, Tiezhu Yang wrote:
> After commit 1f265d2aea0d ("selftests/bpf: Remove not used headers"),
> tools/arch/s390/include/uapi/asm/ptrace.h has been removed, so remove
> it in check-headers.sh too, otherwise we can see the following build
> warning:
> 
>   diff: tools/arch/s390/include/uapi/asm/ptrace.h: No such file or directory
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304050029.38NdbQPf-lkp@intel.com/
> Fixes: 1f265d2aea0d ("selftests/bpf: Remove not used headers")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

not sure this should go through Arnaldo's tree instead,
either way is fine with me

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> commit 1f265d2aea0d ("selftests/bpf: Remove not used headers") is in
> bpf-next tree, so I prefer this patch can be applied to bpf-next tree.
> 
>  tools/perf/check-headers.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index eacca9a..e4a8b53 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -52,7 +52,6 @@ arch/x86/include/uapi/asm/vmx.h
>  arch/powerpc/include/uapi/asm/kvm.h
>  arch/s390/include/uapi/asm/kvm.h
>  arch/s390/include/uapi/asm/kvm_perf.h
> -arch/s390/include/uapi/asm/ptrace.h
>  arch/s390/include/uapi/asm/sie.h
>  arch/arm/include/uapi/asm/kvm.h
>  arch/arm64/include/uapi/asm/kvm.h
> -- 
> 2.1.0
> 
