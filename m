Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08BA4B3128
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353988AbiBKXNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353928AbiBKXNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:13:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212AD68
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:13:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c3so5842377pls.5
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=slkN30ujMxi6RyrUAYgGLLOBAD2boltJ7SmUXMuxzQI=;
        b=dDiShCM02nbX9zISLymObsQsAimHsX02WnfWZlZUBhl4FAQUGdP4GIDOdCkO5HIrvO
         vskLpLDzCngorZyRg3quy9Qfj3xlFlZvR41DaN5nYK/FRHD0FyqJ8Ef79Xk6hBLVLbCr
         zRl2b/bFTyczJV3DvK4E/x3EGZUpavR7MdFc+lov2xCFNz+lMFXfIEX30N5h2YJ4rlEc
         dCMbvZMA7Mk0lNdzo/JQDXh/ZsCUQcIcCDGRn6gMpvhShtzXjzNZhckNVRtBNmwi0sgd
         UsnUvQXESOdhY/KGcBaZ+EESSSyL2eqQpkw6n/Z7FsOpYimtXr3ubWYw8tKJrJAOb6L8
         PU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slkN30ujMxi6RyrUAYgGLLOBAD2boltJ7SmUXMuxzQI=;
        b=leSv7sRJrDZFNvu5nCD7V/YhtbACKmZqvCZ7ixtnX6OiJDSqD4W/2IHTqjTBghCd/S
         Rn1Sm82B/FUmoft+FjTTifrC24LwJD2EUyDHSYGXceKib/7LtF8t4ZUbicz6dNpZZNuy
         RldorBXEj2MCsToqbAMxJdhuEAAlL4Y1qBkfsU3gA5/FUTpU8tfirxLug9A76ohJesTB
         2NwKuezuMYIhDMEV3ZkVHM0vuZeek0CD0cRh5u3rrfThuXr7FtzUXU6lhMYaoRK2/bhl
         gGVF4p/LHwB2tNzExYeHJ1yHpZBzhUAWFon93aiKzmjevigzAtt05gp5HaflI4asQhAV
         kXyA==
X-Gm-Message-State: AOAM533AfvQ5SW2TsIOuBjqmYEphx4L1NJvZmRilSpawdSDrbMnBsXBD
        f22qufIKSbuWoXvk/wn1X0jdkLgvG9s=
X-Google-Smtp-Source: ABdhPJwMy0GTUQGB0w2p/kUYX+scSGQZiss2Bt4MmMOAr3dCTPO8Kgat3uXAe3dSxBjGLOnhV9HBYw==
X-Received: by 2002:a17:902:db0c:: with SMTP id m12mr532581plx.72.1644621198660;
        Fri, 11 Feb 2022 15:13:18 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:eb33])
        by smtp.gmail.com with ESMTPSA id i19sm9226350pgn.55.2022.02.11.15.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:13:17 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:13:16 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
Message-ID: <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
References: <20220211211450.2224877-1-andrii@kernel.org>
 <20220211211450.2224877-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211211450.2224877-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 11, 2022 at 01:14:50PM -0800, Andrii Nakryiko wrote:
> Add a selftest validating various aspects of libbpf's handling of custom
> SEC() handlers. It also demonstrates how libraries can ensure very early
> callbacks registration and unregistration using
> __attribute__((constructor))/__attribute__((destructor)) functions.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
>  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
>  2 files changed, 239 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> new file mode 100644
> index 000000000000..28264528280d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <test_progs.h>
> +#include "test_custom_sec_handlers.skel.h"
> +
> +#define COOKIE_ABC1 1
> +#define COOKIE_ABC2 2
> +#define COOKIE_CUSTOM 3
> +#define COOKIE_FALLBACK 4
> +#define COOKIE_KPROBE 5
> +
> +static int custom_init_prog(struct bpf_program *prog, long cookie)
> +{
> +	if (cookie == COOKIE_ABC1)
> +		bpf_program__set_autoload(prog, false);
> +
> +	return 0;
> +}

What is the value of init_fn callback?
afaict it was and still unused in libbpf.
The above example doesn't make a compelling case, since set_autoload
can be done out of preload callback.
Maybe drop init_fn for now and extend libbpf_prog_handler_opts
when there is actual need for it?
