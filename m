Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC131523D23
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiEKTIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiEKTIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:08:46 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334316BFD6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:08:45 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id t16so2712536qtr.9
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/BI2Fx61fomPWNl/8lR+3m1OdJfWsK2NDqUa/aEdLA=;
        b=JWjENRQQQnh6u9Jq+mbi/mEtFH9RI/mDx+G8VRVfgm4qg0aw0XXt+AUWydscaeHlmw
         VGJcPxTf5JYfsC52yjDztHX6nFlz+sccep5x41yuF3Bfq+6NOo6yc2GxIznW4FtFH+h2
         LzVslHiF3y4KRSXije0Zh/JLtg2tc2cDMHFqwakvsBTK7H8AEHmVXBHIVDDKw4Y7tmQN
         8gzZombXqNMCXha/YyVlfcR77SISuewgjHKU8Yw0XlLEPcNy+vxYCS0ilH6e3G8Yoq7B
         10BinL2MY1ra9JMporoi3oJvwHTDaZWzh09Lp2qirWxJgGsVDNYkoMKGBILGPBCKSi2C
         2CQA==
X-Gm-Message-State: AOAM5317K4LqRr8+QXVLuCfK4C5vL8JblibI6pEWykm/Q7GZ2vAzn/G4
        BZzz7UirRc5q2qrb4tZfTHc=
X-Google-Smtp-Source: ABdhPJwnjLEnAoRwI6GwtoiLSWVklFWnY9fIaizz8PbB7y1iLdjYd6VpGbY5998LxQtSQKdIOWHb5w==
X-Received: by 2002:ac8:7e96:0:b0:2f3:d427:533e with SMTP id w22-20020ac87e96000000b002f3d427533emr18271514qtj.41.1652296124075;
        Wed, 11 May 2022 12:08:44 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id k2-20020ac84782000000b002f39b99f6bfsm1595091qtq.89.2022.05.11.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:08:43 -0700 (PDT)
Date:   Wed, 11 May 2022 12:08:41 -0700
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a few clang compilation
 errors
Message-ID: <20220511190841.4oxswcsebp7teaa3@dev0025.ash9.facebook.com>
References: <20220511184735.3670214-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511184735.3670214-1-yhs@fb.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 11:47:35AM -0700, Yonghong Song wrote:
> With latest clang, I got the following compilation errors:
>   .../prog_tests/test_tunnel.c:291:6: error: variable 'local_ip_map_fd' is used uninitialized
>      whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>        if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   .../bpf/prog_tests/test_tunnel.c:312:6: note: uninitialized use occurs here
>         if (local_ip_map_fd >= 0)
>             ^~~~~~~~~~~~~~~
>   ...
>   .../prog_tests/kprobe_multi_test.c:346:6: error: variable 'err' is used uninitialized
>       whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (IS_ERR(map))
>             ^~~~~~~~~~~
>   .../prog_tests/kprobe_multi_test.c:388:6: note: uninitialized use occurs here
>         if (err) {
>             ^~~
> 
> This patch fixed the above compilation errors.

I'd argue that these are real bugs that the compiler happens to have
caught, and that the patch should perhaps be framed as fixing them rather
than as avoiding compilation failures, but that might be unnecessarily
nit-picky and I don't feel strongly about it.

> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +++-
>  tools/testing/selftests/bpf/prog_tests/test_tunnel.c       | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 816eacededd1..586dc52d6fb9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -343,8 +343,10 @@ static int get_syms(char ***symsp, size_t *cntp)
>  		return -EINVAL;
>  
>  	map = hashmap__new(symbol_hash, symbol_equal, NULL);
> -	if (IS_ERR(map))
> +	if (IS_ERR(map)) {
> +		err = libbpf_get_error(map);
>  		goto error;
> +	}
>  
>  	while (fgets(buf, sizeof(buf), f)) {
>  		/* skip modules */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> index 071c9c91b50f..3bba4a2a0530 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -246,7 +246,7 @@ static void test_vxlan_tunnel(void)
>  {
>  	struct test_tunnel_kern *skel = NULL;
>  	struct nstoken *nstoken;
> -	int local_ip_map_fd;
> +	int local_ip_map_fd = -1;
>  	int set_src_prog_fd, get_src_prog_fd;
>  	int set_dst_prog_fd;
>  	int key = 0, ifindex = -1;
> @@ -319,7 +319,7 @@ static void test_ip6vxlan_tunnel(void)
>  {
>  	struct test_tunnel_kern *skel = NULL;
>  	struct nstoken *nstoken;
> -	int local_ip_map_fd;
> +	int local_ip_map_fd = -1;
>  	int set_src_prog_fd, get_src_prog_fd;
>  	int set_dst_prog_fd;
>  	int key = 0, ifindex = -1;
> -- 
> 2.30.2
> 

I'm a bit surprised this ever successfully compiled. What version of clang
did you have to upgrade to in order to see this error? IIRC I've used
-Wsometimes-uninitialized on much older versions of clang.

Anyways, looks good to me.

Acked-by: David Vernet <void@manifault.com>
