Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B60632785
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiKUPND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiKUPMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:12:10 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A7C6D21;
        Mon, 21 Nov 2022 07:06:17 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id z17so8145198qki.11;
        Mon, 21 Nov 2022 07:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CupXU2YxQxlgExJK8f3HdC36BFYNv+p0Rq++hKAm9D8=;
        b=Sx++5u0zoyXf8X1W7k8bacATk2PzKbwB7KBy78cmD7BOyK55s7gwb/SX5ENFmW3dDh
         Zqq1mLpEW3NSgqKTpZEZnVXCtWPivGmCUFAzzTsd1/wjT3ofycDFXKb1RlOQcn0JoqBn
         4M3Fvbn+9OEGbPfQirOkgJtUmERzsUq9pKnDhN8eXlTPxXFfIzq9FFqc9zJ75ZXICzR1
         N4p5ucsktCWuPwb2RiaiNXKZOsZK4u5GEL7hvp0NAxy/Gk0x8XBoWKQhbhW2GCE7nJZ7
         C8HL5RtIg92h3PJXbYYjuhrs97/y753TEzd0V/zBJDEoaxcMXmKDDSbPLQXMj8tSSsf3
         h7KQ==
X-Gm-Message-State: ANoB5pnuw+dw3ft9D7xf5hVJut6ybXe+k8IwZIPaaHhQlRVTH/As9Rr6
        IZzHQBn0GjL8GsrGYI2Bd10=
X-Google-Smtp-Source: AA0mqf5b4jDAHm/CLmo93tkGxrH6/0Rjf2Z1b3IxtiV1wPcgTrZ1YOirbk+P97yG6VO9eVy6mS/ZfQ==
X-Received: by 2002:ae9:d844:0:b0:6fa:b570:2da7 with SMTP id u65-20020ae9d844000000b006fab5702da7mr1090738qkf.597.1669043176150;
        Mon, 21 Nov 2022 07:06:16 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006cfc9846594sm8430169qkp.93.2022.11.21.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:06:15 -0800 (PST)
Date:   Mon, 21 Nov 2022 09:06:20 -0600
From:   David Vernet <void@manifault.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v3] docs/bpf: Update btf selftests program and
 add link
Message-ID: <Y3uT7KfjF3OcbjMG@maniforge.lan>
References: <tencent_C597352AB3AF24A35A88CC06A3421E590B08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C597352AB3AF24A35A88CC06A3421E590B08@qq.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 10:02:39PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit c64779e24e88("selftests/bpf: Merge most of test_btf into
> test_progs") rename selftests/bpf btf test from 'test_btf.c' to
> 'prog_tests/btf.c'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v3: v2 -> v3
>     s/Kernel bpf selftest/The kernel BPF selftest
>     s/provides extensive/provides an extensive
> v2: https://lore.kernel.org/lkml/tencent_114656E8259D0AEA2BDB6810E29241995006@qq.com/
> v1: https://lore.kernel.org/lkml/tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com/
> ---
>  Documentation/bpf/btf.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index cf8722f96090..681416c86e81 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1062,4 +1062,9 @@ format.::
>  7. Testing
>  ==========
>  
> -Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
> +The kernel bpf selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_

s/bpf/BPF

> +provides an extensive set of BTF-related tests.
> +
> +.. Links
> +.. _tools/testing/selftests/bpf/prog_tests/btf.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
> -- 
> 2.38.1
> 
