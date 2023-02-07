Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2768DBF9
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBGOqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjBGOqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:46:06 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA87C0
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:46:05 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h24so16852367qta.12
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mlugv/JHT2cOcwy3hpBiHiypyxNNpkghHaSuvVlnYo=;
        b=7/FU/9/MFLe963nXb/mE+Q9uC6bcbkB6ExNvHtPnzrajd2K6dJsTr8cjCAMwKU/d6K
         gGldOwqYXOedlrh7vxhnb07bmKin8ciy1YnMy0jqFCACUpgBciCCiihIPxiU1fEZh2/s
         gBn25O5nwPghYjTSQvhFvtyRfyVc1Tm91g5+Pk6KutJIQdE7RGWuvfBLv6SxHP7UtBfg
         ThavOJtNNfjHKTohpBXFZLm5EkwNU8GZggqQJDkGUKey3CDLxF0f96o2txkvtm1wCISG
         8R5K9FAxfm1b+k/DwSKxeISpLHVf7IIzHjMPEd0reOCz5UcLl/R/OpNxeVYP9YZvrkeY
         fXtA==
X-Gm-Message-State: AO0yUKU0AvvCGLN6bP+alTBrSKckMD2YDXOSix0EpZCQR1+5W7mn/7Re
        CZej4iGkhOSeLaj6elv/qdk=
X-Google-Smtp-Source: AK7set/Aq60CpgeMWrVQVeW7B2g+9i/laqLAs5fqVPSMqmRnHMuzYEDiQn7FqS9Szjj9mFIqU8d0nA==
X-Received: by 2002:ac8:5705:0:b0:3b8:3bd9:9c19 with SMTP id 5-20020ac85705000000b003b83bd99c19mr6104230qtw.54.1675781164614;
        Tue, 07 Feb 2023 06:46:04 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id a8-20020ac84348000000b003b86d8ad0c1sm9647174qtn.3.2023.02.07.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:46:04 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:46:08 -0600
From:   David Vernet <void@manifault.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv3 bpf-next 6/9] selftests/bpf: Load bpf_testmod for
 verifier test
Message-ID: <Y+JkMCHijhcnCz5m@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-7-jolsa@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 05:23:33PM +0100, Jiri Olsa wrote:
> Loading bpf_testmod kernel module for verifier test. We will
> move all the tests kfuncs into bpf_testmod in following change.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: David Vernet <void@manifault.com>

> ---
>  tools/testing/selftests/bpf/test_verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 887c49dc5abd..14f11f2dfbce 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -45,6 +45,7 @@
>  #include "bpf_util.h"
>  #include "test_btf.h"
>  #include "../../../include/linux/filter.h"
> +#include "testing_helpers.h"
>  
>  #ifndef ENOTSUPP
>  #define ENOTSUPP 524
> @@ -1705,6 +1706,12 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
>  {
>  	int i, passes = 0, errors = 0;
>  
> +	/* ensure previous instance of the module is unloaded */
> +	unload_bpf_testmod(verbose);
> +
> +	if (load_bpf_testmod(verbose))
> +		return EXIT_FAILURE;
> +
>  	for (i = from; i < to; i++) {
>  		struct bpf_test *test = &tests[i];
>  
> @@ -1732,6 +1739,8 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
>  		}
>  	}
>  
> +	unload_bpf_testmod(verbose);
> +
>  	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
>  	       skips, errors);
>  	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
> -- 
> 2.39.1
> 
