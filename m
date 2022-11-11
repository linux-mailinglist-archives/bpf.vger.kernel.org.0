Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BE5624F7F
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKKBZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 20:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKBZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 20:25:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1204B987
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:25:28 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k15-20020a170902c40f00b001887cd71fe6so2497347plk.5
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLjepBqbGm3d9zsYB8l1lUcmwcQjwlJI/oP3L4T8CAk=;
        b=B2o8641Eon/idASey/xNHxfazo0eTyvECjcIoeSLTsabmuQ3zDaeEb9mKuaRYiXGP1
         CrPgGjde8x6TKyJNS0F7mldAc88LKF2+WPFeNZUpnQ5xPKK+08oxlCeMW4bCPsIF3en9
         GJLdQIKk+jpta0Y49jO6dCLGKW3cCypurgy82rPNZeUIGW+94E92eSbPdgTivFFXHSRg
         cPz7S0BO304XQhnfllkscSsO/rSWbrKGt+CT6pvX3tAfQZ23yTX7FeXM3PLlmDuCkW7I
         mKHR4fcK7lNLiGpwVz3/baYkzyIrZq+GJucdGOAKy8i+JW1t5F2KXYN35UlIsBRY+/uG
         IhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLjepBqbGm3d9zsYB8l1lUcmwcQjwlJI/oP3L4T8CAk=;
        b=JhP6f4hKM+YmNy3/55g5SofMBl5grpkpHa3DDfXN2hByowwutAPgWi9sXJEfGMiIFb
         bYZIa6FLIPmhjWCksJETOtFr+fQiN9yScxTl/ycwIrsoUCH+AXdqJRst1iTmR9Ud0ttS
         k4JQhOO2fi8z+lK30Z9Ul095Cln8rgstRm3ny2DzDzI8UXleyYCuaeB3ALOTMEAiY5FZ
         uhDZNqm22qDlvgbU6zR7L75xujWQ79w9Y/1gHpp90vKn40yKQqI2nkosMuLB9l5yvYtk
         Y9m/oiuIf3yiX21BZ6b9I4V1y9zyDUc0IlqnK0ExImAKbow+F7ha8Nf3HU+xRuu5ZF3F
         7r/Q==
X-Gm-Message-State: ANoB5pnt31FYLANk3S1hhh0qgfuTxErPiycem+OIdezY8EvLRfssYdmO
        DlJ/Kb3TEb6FHXWU39tX1JhVE7c=
X-Google-Smtp-Source: AA0mqf4LRLYu6xdYswIiBmi/htwl4FHYG8hztPDxCmeCEKA79lKgjTo74tBYEzJc9pWYbhFf0J4GsPo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:a513:b0:188:9542:515 with SMTP id
 s19-20020a170902a51300b0018895420515mr278684plq.102.1668129928300; Thu, 10
 Nov 2022 17:25:28 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:25:26 -0800
In-Reply-To: <20221110223240.1350810-1-eddyz87@gmail.com>
Mime-Version: 1.0
References: <20221110223240.1350810-1-eddyz87@gmail.com>
Message-ID: <Y22khvpDYu639yom@google.com>
Subject: Re: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues
 using LLVM14
From:   sdf@google.com
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11, Eduard Zingerman wrote:
> A fix for the LLVM compilation error while building bpftool.
> Replaces the expression:

>    _Static_assert((p) == NULL || ...)

> by expression:

>    _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) || ...)

IIUC, when __builtin_constant_p(p) returns false, we just ignore the NULL  
check?
Do we have cases like that? If no, maybe it's safer to fail?

s/(p) == NULL : 0/(p) == NULL : 1/ ?

> When "p" is not a constant the former is not considered to be a
> constant expression by LLVM 14.

> The error was introduced in the following patch-set: [1].
> The error was reported here: [2].

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

> [1] https://lore.kernel.org/bpf/20221109142611.879983-1-eddyz87@gmail.com/
> [2] https://lore.kernel.org/all/202211110355.BcGcbZxP-lkp@intel.com/
> ---
>   tools/lib/bpf/hashmap.h   | 3 ++-
>   tools/perf/util/hashmap.h | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index 3fe647477bad..0a5bf1937a7c 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
>   };

>   #define hashmap_cast_ptr(p) ({								\
> -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
> +				sizeof(*(p)) == sizeof(long),				\
>   		       #p " pointee should be a long-sized integer or a pointer");	\
>   	(long *)(p);									\
>   })
> diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> index 3fe647477bad..0a5bf1937a7c 100644
> --- a/tools/perf/util/hashmap.h
> +++ b/tools/perf/util/hashmap.h
> @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
>   };

>   #define hashmap_cast_ptr(p) ({								\
> -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
> +				sizeof(*(p)) == sizeof(long),				\
>   		       #p " pointee should be a long-sized integer or a pointer");	\
>   	(long *)(p);									\
>   })
> --
> 2.34.1

