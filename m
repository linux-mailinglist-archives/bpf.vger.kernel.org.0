Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07E152F079
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiETQWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351534AbiETQW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 12:22:28 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5D170F13
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 09:22:27 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id BBB18240109
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 18:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653063744; bh=pO+0dl8prUVCrsjwIJUITX12QmFzLJFT/66dWfNfMoI=;
        h=Date:From:To:Cc:Subject:From;
        b=qGuiQ1/zkzPdPfByhYWg+dY88s+ghT9lwSIifSjojJhFX9lK1V9xEZlyYrbfB+ZzL
         6+otf13TpgK9NZvGmxfmJhQl/RwzSsBWvjjzo+6QMQrCCwE8QUhIqEpJDZLBSMu/KO
         LGqOdpaLE7/+33S13ApiyvVbypsO33me5AuiO0oiaEsrNAuUMeqPzzQVJwPM/b7XdE
         J1Lgd6EqCxqx/mFwu9pc0TdmKJ+6nLyBWc3de7TE/tpNE8hQ2N7tD5odkiI2hsg8Zw
         VM5hgLFh5bxCFVa3q7DyBukloc2TvsPu0CtGLtUKP4sLli1/o62GyCLNAI22hDjQpb
         ADT79udo+DlDA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L4X7K51dhz9rxF;
        Fri, 20 May 2022 18:22:21 +0200 (CEST)
Date:   Fri, 20 May 2022 16:22:18 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: fix subtest number formatting in
 test_progs
Message-ID: <20220520162112.pffjqfxy5gnermlx@muellerd-fedora-MJ0AC3F3>
References: <20220520070144.10312-1-mykolal@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520070144.10312-1-mykolal@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 12:01:44AM -0700, Mykola Lysenko wrote:
> Remove weird spaces around / while preserving proper
> indentation
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index ecf69fce036e..262b7577b0ef 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -230,9 +230,14 @@ static void print_test_log(char *log_buf, size_t log_cnt)
>  		fprintf(env.stdout, "\n");
>  }
>  
> +#define TEST_NUM_WIDTH 7
> +#define STRINGIFY(value) #value
> +#define QUOTE(macro) STRINGIFY(macro)
> +#define TEST_NUM_WIDTH_STR QUOTE(TEST_NUM_WIDTH)
> +
>  static void print_test_name(int test_num, const char *test_name, char *result)
>  {
> -	fprintf(env.stdout, "#%-9d %s", test_num, test_name);
> +	fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "d %s", test_num, test_name);
>  
>  	if (result)
>  		fprintf(env.stdout, ":%s", result);
> @@ -244,8 +249,12 @@ static void print_subtest_name(int test_num, int subtest_num,
>  			       const char *test_name, char *subtest_name,
>  			       char *result)
>  {
> -	fprintf(env.stdout, "#%-3d/%-5d %s/%s",
> -		test_num, subtest_num,
> +	char test_num_str[TEST_NUM_WIDTH + 1];
> +
> +	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest_num);
> +
> +	fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "s %s/%s",
> +		test_num_str,
>  		test_name, subtest_name);
>  
>  	if (result)
> -- 
> 2.30.2
> 

Looks good to me, thanks.

Acked-by: Daniel Müller <deso@posteo.net>
