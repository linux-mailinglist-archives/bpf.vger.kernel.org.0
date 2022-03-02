Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D704CB250
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiCBWa4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiCBWaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:30:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A9E728B
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:30:11 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so3137755pfa.10
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URekYkchn2gT4cFROBojDT1qtgXa/hsmceDshywu+gY=;
        b=ofhQc++xYG4sE14xXwrTsvR77dqnNjvAVuNR2Fc5/mv+2u7GSVGwNbQYLE+MZ9/Gk4
         jcOigJq8X/pRARxne32FKas26Sb19ebzsjqNoZTmVlmSWAokE4/s6TiXMg37+UrKdLa7
         /FXDLn6C8LnHtNb4TevzboP8MsNdfgAC7SJSSasuvtAGuYgrSiX+rlr3buUKw0o6wyIz
         cjUBChMOuJ3vBXLRl6FddhE0/zq8madE/V95AhQ9cO/SCUBrgbYDiTmLSpaNoTRR25Lo
         8l1ZIaA58kDPYUa72LqF/AyHRrJrBWpKhJP5jkQK3VddbLQPA674u/TzowPjzfBscyau
         W8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URekYkchn2gT4cFROBojDT1qtgXa/hsmceDshywu+gY=;
        b=u9eWiuGrcMZb8RVkHW8f31XrdjdpVwDqRMWExLdAU3WaydTbo2i8jvrWnfx2tO3AQ4
         8TJ7khqMb68GuTbC58S7hKYvls5lDq3ZyLcFWROMfNxNMWc0/fk1TlTJF2y8tRXy6MrP
         vU2uijKLFwceh1B13IVRABk+AmmrELufJbbUbpY6aSxVA+lfJqixDVX/8o8fBA+tU1dQ
         gPic2iUQ9m5W8E5I0aFvyJsu6k3Del5o20XCMVy/LHTacj4syNnAX3u1rBssspqtpkch
         UfPGcc+/AegveSWo3WP8baHL6n/wrRO0JhpgXsp85IYHuy78Ut+NjND8B38AGw9Jj82a
         03aQ==
X-Gm-Message-State: AOAM531BFLKZHqFQByt9yeyV531BQqq6yZaYCeq9ybdnBu0UXQAm+yW2
        lXpMLgba4QSZ+77nhBtEMLI=
X-Google-Smtp-Source: ABdhPJxy6M9oKQ+74lOBp5nFmWxuSCIxceGcciw679CU8eD/0uB1+aNK6ThEtxc6MCPUt+4mlmlTHA==
X-Received: by 2002:a63:8ac2:0:b0:341:1e45:26c with SMTP id y185-20020a638ac2000000b003411e45026cmr28386629pgd.31.1646260211302;
        Wed, 02 Mar 2022 14:30:11 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id j1-20020a056a00130100b004df82ad0498sm183046pfu.82.2022.03.02.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:30:10 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:30:08 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton
 functionality
Message-ID: <20220302223008.7deshk5qfw3pytxm@ast-mbp.dhcp.thefacebook.com>
References: <cover.1646188795.git.delyank@fb.com>
 <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 02, 2022 at 02:48:48AM +0000, Delyan Kratunov wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 Facebook */
> +
> +#include <test_progs.h>
> +#include "test_subskeleton.skel.h"
> +
> +extern void subskeleton_lib_setup(struct bpf_object *obj);
> +extern int subskeleton_lib_subresult(struct bpf_object *obj);
> +
> +void test_subskeleton(void)
> +{
> +	int duration = 0, err, result;
> +	struct test_subskeleton *skel;
> +
> +	skel = test_subskeleton__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;
> +
> +	skel->rodata->rovar1 = 10;

The rodata vars in subskeleton will need extra '*', right?
The above is confusing to read comparing to below:

> +void subskeleton_lib_setup(struct bpf_object *obj)
> +{
> +	struct test_subskeleton_lib *lib = test_subskeleton_lib__open(obj);
> +
> +	ASSERT_OK_PTR(lib, "open subskeleton");
> +
> +	*lib->data.var1 = 1;
> +	*lib->bss.var2 = 2;
> +	lib->bss.var3->var3_1 = 3;
> +	lib->bss.var3->var3_2 = 4;
> +}

Could you add rodata to subskel as well?
Just to make it obvious that rodata is not special.

An example of generated skel in commit log would be great.
