Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEA68DBE1
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBGOmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBGOm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:42:26 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479853D925
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:41:36 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id g7so16847343qto.11
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T25EmlWokuVxWisu+UiCdhr38+cw6JD8/Umv/9XWXXE=;
        b=D8Ig8cauHGRXrHXLg2j043c+vbEQBzYUutw2NTT014oNIP3lrbePqqpVynfc03Y0SM
         o7EqOX6hiJiFpbJMeVGTn9Yh2X8KdT8GeZnn/4WReOjaYDxZ11f71vTC9Zz1JN+x2erY
         C+q7Xy+iMFVGchgd10TtEvxI0ne216Y6Tivu8M/5ndNhEifDQcQ4eKgwS7qlzcb9PV4n
         ydc9FYeb8VNSnlwiD8NMYZl29anRCrbqZUXUX0vOgcgnV8byBPUGrWkxsg+ZjwkS+6F0
         ouu5l7JuX5Nyu7/Ldd2rBCKD7lHwR3KnoJfhefBTP3SxoZlh8QjSQsPF/5PcL22QXfny
         6zqw==
X-Gm-Message-State: AO0yUKWf2zcBATbmI01aDTIIVocgFtMqoxqrnvNedT57hgDa8VlaZWvR
        hHFxD4VtDSuzyLXFLPv+4YI=
X-Google-Smtp-Source: AK7set+8usmM6KFAf86QZAw1X+npvNEjYIhyfbSCnwHJ5UHZh5vrrN9bLoAPRtEIMXqMOoRqusaaTA==
X-Received: by 2002:a05:622a:1447:b0:3ae:ee82:33b7 with SMTP id v7-20020a05622a144700b003aeee8233b7mr5512327qtx.5.1675780895222;
        Tue, 07 Feb 2023 06:41:35 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id s20-20020a05622a019400b003b860983973sm9433152qtw.60.2023.02.07.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:41:34 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:41:38 -0600
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
Subject: Re: [PATCHv3 bpf-next 3/9] selftests/bpf: Use only stdout in
 un/load_bpf_testmod functions
Message-ID: <Y+JjIus7zdcEk2IZ@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-4-jolsa@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 05:23:30PM +0100, Jiri Olsa wrote:
> We are about to use un/load_bpf_testmod functions in couple tests
> and it's better  to print output to stdout,  so it's aligned with
> tests ASSERT macros output, which use stdout as well.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: David Vernet <void@manifault.com>

Should we remove FILE *stderr from struct test_env? Seems like it might
be prudent if using it can actually cause a mismatch between testcase
output and the test runner?

> ---
>  tools/testing/selftests/bpf/testing_helpers.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 3a9e7e8e5b14..fd22c64646fc 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -244,14 +244,14 @@ static int delete_module(const char *name, int flags)
>  void unload_bpf_testmod(bool verbose)
>  {
>  	if (kern_sync_rcu())
> -		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
> +		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
>  	if (delete_module("bpf_testmod", 0)) {
>  		if (errno == ENOENT) {
>  			if (verbose)
>  				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
>  			return;
>  		}
> -		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> +		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
>  		return;
>  	}
>  	if (verbose)
> @@ -270,11 +270,11 @@ int load_bpf_testmod(bool verbose)
>  
>  	fd = open("bpf_testmod.ko", O_RDONLY);
>  	if (fd < 0) {
> -		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> +		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
>  		return -ENOENT;
>  	}
>  	if (finit_module(fd, "", 0)) {
> -		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> +		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
>  		close(fd);
>  		return -EINVAL;
>  	}
> -- 
> 2.39.1
> 
