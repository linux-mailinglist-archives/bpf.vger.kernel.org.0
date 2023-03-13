Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DC6B72CC
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCMJlB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCMJk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 05:40:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1912E
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 02:40:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so17146093eda.1
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678700456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soYbTwP/olAXcSImXe2g6wB/n/lyQSdMQ8bWhKRYlYE=;
        b=dZdjHQx7E2RAmEMB6KE4FQeV1dlSifkUCW5tQoqtdgXv64d/JABFX1CdVFcPecZdkh
         TgcK3tjoEuqO9Qu6navo6wRfjKD/ypvNjdWb1bN71x1JdLss9DgNpV98BqfUVFrmTR5B
         gh7t5oyRMNMZpwl72b0IrklzeU2JVR8EyfAE4W9Le7e6WtBJPW0TJb0PuEk/ntxkedkV
         3xhYHDRWz97Rd6gWEcihUNr59KV4+9psooY32spugMHYQmS44XPrKgYhrd5WE5GApjBD
         9Zk1ezI1kdw0wiXOL/0urKl0P8kzbTlGENmA641KaeBqxix8An7Zk/3J4thAFosMaUb7
         n7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soYbTwP/olAXcSImXe2g6wB/n/lyQSdMQ8bWhKRYlYE=;
        b=Vk3m4d19DN60TYKgM/MPHUZXLCJrmv2+j4jlxnesSeVmo/hHdakxldP69RUTdv6D2b
         15y7gRea3Pnof4Vo5Z2u90X5bbMWlcMr39F1iFKWbzopfM+co4mcBbf7HFtiPFcZnJxg
         ahUiZeZJTCCW/fLNPeb2QnvxQV9nPA65OSxVdqKnw/NpmDZxYaX0HvLCXKw3A66QyoZ2
         JRdh29K3Rf7v1qZWEQf0IiEHUYcxECzOtnnjhcF5JurTfz2ktAa22OkGeOCgz1KQ6eWj
         VpD5DoODNEKPe47Tlc0kvecFNNWnuherjttoam9yfiy4eRNqzoe3ilhkj2psHP3iTJPB
         WgOw==
X-Gm-Message-State: AO0yUKU9HXaH8lfUdnVvWUi4hDaHre5JPPnIUr49XqOGfiIJkAIKZYUs
        ni62lGtSzxjXJ/VppTb/SLU=
X-Google-Smtp-Source: AK7set+EElZaBGCC8QQBcfh7jcOdvdh+LlNmTJykMCaLOS5XG/ycNKRDE1M7PDM1ChTWLmITIpFnEw==
X-Received: by 2002:aa7:c44b:0:b0:4fb:6796:14c0 with SMTP id n11-20020aa7c44b000000b004fb679614c0mr4212264edr.22.1678700455891;
        Mon, 13 Mar 2023 02:40:55 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906b00c00b008c76facbbf7sm3262174ejy.171.2023.03.13.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:40:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 13 Mar 2023 10:40:53 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/3] dwarves: improve BTF encoder comparison
 method
Message-ID: <ZA7vpa3A0IDUUL7W@krava>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 02:50:47PM +0000, Alan Maguire wrote:
> Currently when looking for function prototype mismatches with a view
> to excluding inconsistent functions, we fall back to a comparison
> between parameter names when the name and number of parameters match.
> This is brittle, as it is sometimes the case that a function has
> multiple type-identical definitions which use different parameters.
> 
> Here the existing dwarves_fprintf functionality is re-used to instead
> create a string representation of the function prototype - minus the
> parameter names - to support a less brittle comparison method.
> 
> To support this, patch 1 generalizes function prototype print to
> take a conf_fprintf parameter; this allows us to customize the
> parameters we use in prototype string generation.
> 
> Patch 2 supports generating prototypes without modifiers such
> as const as they can lead to false positive prototype mismatches;
> see the patch for details.
> 
> Finally patch 3 replaces the logic used to compare parameter
> names with the prototype string comparison instead.
> 
> Using verbose pahole output we can see some of the rejected
> comparisons.  73 comparisons are rejected via prototype
> comparison, 63 of which are non "."-suffixed functions.  For
> example:
> 
> function mismatch for 'name_show'('name_show'): 'ssize_t ()(struct kobject *, struct kobj_attribute *, char *)' != 'ssize_t ()(struct device *, struct device_attribute *, char *)'
> 
> With these changes, the syscalls defined in sys_ni.c
> that Jiri mentioned were missing [1] are present in BTF:
> 
> [43071] FUNC '__ia32_compat_sys_io_setup' type_id=42335 linkage=static
> [43295] FUNC '__ia32_sys_io_setup' type_id=42335 linkage=static
> [47536] FUNC '__x64_sys_io_setup' type_id=42335 linkage=static
> 
> [43290] FUNC '__ia32_sys_io_destroy' type_id=42335 linkage=static
> [47531] FUNC '__x64_sys_io_destroy' type_id=42335 linkage=static
> 
> [43072] FUNC '__ia32_compat_sys_io_submit' type_id=42335 linkage=static
> [43296] FUNC '__ia32_sys_io_submit' type_id=42335 linkage=static
> [47537] FUNC '__x64_sys_io_submit' type_id=42335 linkage=static
> 
> [1] https://lore.kernel.org/bpf/ZAsBYpsBV0wvkhh0@krava/
> 
> Alan Maguire (3):
>   dwarves_fprintf: generalize function prototype print to support
>     passing conf
>   dwarves_fprintf: support skipping modifier
>   btf_encoder: compare functions via prototypes not parameter names

lgtm, the syscalls from sys_ni.c are there

for me the total number of syscalls increased from 249 to 432, great ;-)

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  btf_encoder.c     | 67 +++++++++++++++++++++++++------------------------------
>  dwarves.h         |  6 +++++
>  dwarves_fprintf.c | 48 ++++++++++++++++++++++++++-------------
>  3 files changed, 70 insertions(+), 51 deletions(-)
> 
> -- 
> 1.8.3.1
> 
