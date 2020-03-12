Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE718309B
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCLMsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 08:48:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLMsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 08:48:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so7244702wrw.13
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bGZk2imFnI79D5POt1tFbHTtbjXTRthu10/zPKdmt8Q=;
        b=tzyuncBTSbeZ05bevOKq2Dmf3H3AwgUEF0FE6SOxx6wQYAIJ+8MfcsXKJd1yLFN7ln
         G24Maa3+Q+cDKFGXaHB8nrbHY5Z0Ry7rsPC2E3us6mYtWmzhoLOiSekiiUrcJUJsXmm7
         cc9fkHFlwuCDb5VQoeY/w2y9LM5LtWoc2DRN/EMWmk3srcqXLo9X4SssQl8L0Wsi41eu
         BH5sOkopAaVkBCyldU4DQs44vJ70tTfAeCW2D1i6TGP5LdGW1gNOzk5sEnKqpjvUhfIK
         bsgNB25yetzOhndrXU3pV8LWLHQHrEesbaePXFlguiQgDafbeX4Rbn3QDOr8bQ49aTYJ
         l5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bGZk2imFnI79D5POt1tFbHTtbjXTRthu10/zPKdmt8Q=;
        b=bq4C9JEDUEaaK3tLoprSqXspERSuUA9/04C+uvTK00f1yLtymQP2yozZH6plasvZ/S
         3p2IbO06oUoyOVGCwy6QPVovH8gv4cWDtNnHwaagnGVhkmuKNFzI6/fjVCuY8ZtE2cqo
         7sLBOcexZ0d9D87NlqgKzi0WgmIs/Z3tXt2xLPH6CABNXxLQHiwPaWxpFe/aTQW5PZL4
         CPy3VkdyYIR8/eLCSw/k7uC92U/qtwQeWzehsghN4iiy2wpeiGYh8iXqncEQBfKDYne1
         tJwk65rZLB15wApoI+ekUIepVd77BJdIFruuFkJ4FpQUelFt6SBODsSEJAEsV9HVgri3
         UNDQ==
X-Gm-Message-State: ANhLgQ2bijNKzUw/ABvxavSdSprmJVhty+OA0prSxJF9Qr9EIhn3Auvc
        06WXgz69+qFWC8FGzA3Reie0Ok3TSXg=
X-Google-Smtp-Source: ADFU+vsa8f3grCDxxKfCdBld5fbLq1iAplrJvFwyQYcfoUBbIlxi7IK380xLh12I81SpabX9vBdV6w==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr10418024wrw.335.1584017302464;
        Thu, 12 Mar 2020 05:48:22 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id p16sm11321632wmi.40.2020.03.12.05.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 05:48:21 -0700 (PDT)
Subject: Re: [PATCH] bpftool: use linux/types.h from source tree for profiler
 build
To:     Tobias Klauser <tklauser@distanz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20200312105335.10465-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <e1193ce0-97c7-bc2a-984e-363afb2888e0@isovalent.com>
Date:   Thu, 12 Mar 2020 12:48:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312105335.10465-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 11:53 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
> When compiling bpftool on a system where the /usr/include/asm symlink
> doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
> the build fails with:
> 
>     CLANG    skeleton/profiler.bpf.o
>   In file included from skeleton/profiler.bpf.c:4:
>   In file included from /usr/include/linux/bpf.h:11:
>   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>   #include <asm/types.h>
>            ^~~~~~~~~~~~~
>   1 error generated.
>   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
> 
> This indicates that the build is using linux/types.h from system headers
> instead of source tree headers.
> 
> To fix this, adjust the clang search path to include the necessary
> headers from tools/testing/selftests/bpf/include/uapi and
> tools/include/uapi. Also undef __bitwise in skeleton/profiler.h avoid
> clashing with the empty definition in
> tools/testing/selftests/bpf/include/uapi/linux/types.h.
> 
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

> diff --git a/tools/bpf/bpftool/skeleton/profiler.h b/tools/bpf/bpftool/skeleton/profiler.h
> index e03b53eae767..95358c0df5ef 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.h
> +++ b/tools/bpf/bpftool/skeleton/profiler.h
> @@ -27,6 +27,7 @@ enum {
>  	true = 1,
>  };
>  
> +#undef __bitwise
>  #ifdef __CHECKER__
>  #define __bitwise__ __attribute__((bitwise))
>  #else
> 

Even with the #undef above, I get warnings on __bitwise being redefined
in tools/testing/selftests/bpf/include/uapi/linux/types.h. Can we maybe
just find another name (or number of underscores) for the macro in
skeleton/profiler.h?

Makefile change works well otherwise, thanks (tested on Ubuntu with and
without gcc-multilib).

Quentin
