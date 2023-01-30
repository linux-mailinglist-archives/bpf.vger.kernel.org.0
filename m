Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EDE6814FD
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbjA3P21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 10:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbjA3P20 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 10:28:26 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A291E298
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:28:25 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-4ff1fa82bbbso164226767b3.10
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/xBui0rV3rpWJlqEzvT7oJSTVpRutDTzDuHQnS6bko=;
        b=mYAsNDx3GaVoAOgHYJAXpFsw+JZfiy2/eWKA4Gq7TQd9HGvbdetQQnKZr2mGNT4SBq
         JdGaOuzunLIargZ4dJr2sx91HnfuQdJBVmhxBqdW39FruQ/2dUioEKyT4MwRNEAb1nNg
         phZ6Ovv2NaJmDzYCnl8A8Aimt9bgLEoOhDx5B7Ba88k4OYdt8H2p2pjeyzrH6A7eRBu+
         Io+VIHVnlzf1jffvEWcwJFddGdwbubbWKAwEncbfW0k/oeTsN1DzgYwVaoKdimJxXqK2
         zn5k66r7gxjRMGmo6xabmcN5HS65eJKsMqBb4tfiDhFTw1vPrdR2mLlc+zCJm8QhBEmP
         TmqA==
X-Gm-Message-State: AO0yUKUkUEU4ckNxkL4qsVz+KyH/q213QKo5Cwrpi8XdZGh36SKkks85
        umIt421n5oKTETm63dqNrhI=
X-Google-Smtp-Source: AK7set91pcxQM0HHVN4B/oDTAilCsFnpVresl+fviCFSITBHE6hEMik5YO7hDcNj1qVbCdscH6n4jw==
X-Received: by 2002:a81:a83:0:b0:514:beff:deda with SMTP id 125-20020a810a83000000b00514beffdedamr3093035ywk.36.1675092504589;
        Mon, 30 Jan 2023 07:28:24 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id oq37-20020a05620a612500b0070d11191e91sm8195109qkn.44.2023.01.30.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:28:23 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:28:21 -0600
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
Subject: Re: [PATCHv2 bpf-next 3/7] selftests/bpf: Do not unload bpf_testmod
 in load_bpf_testmod
Message-ID: <Y9fiFWSm3DRIn86C@maniforge>
References: <20230130085540.410638-1-jolsa@kernel.org>
 <20230130085540.410638-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130085540.410638-4-jolsa@kernel.org>
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

On Mon, Jan 30, 2023 at 09:55:36AM +0100, Jiri Olsa wrote:
> Do not unload bpf_testmod in load_bpf_testmod, instead call
> unload_bpf_testmod separatelly.
> 
> This way we will be able use un/load_bpf_testmod functions
> in other tests that un/load bpf_testmod module.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_progs.c      | 11 ++++++++---
>  tools/testing/selftests/bpf/testing_helpers.c |  3 ---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index a150c35516ef..9ca718c84890 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1592,9 +1592,14 @@ int main(int argc, char **argv)
>  	env.stderr = stderr;
>  
>  	env.has_testmod = true;
> -	if (!env.list_test_names && load_bpf_testmod(env.stderr, verbose())) {
> -		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
> -		env.has_testmod = false;
> +	if (!env.list_test_names) {
> +		/* ensure previous instance of the module is unloaded */
> +		unload_bpf_testmod(env.stderr, verbose());
> +
> +		if (load_bpf_testmod(env.stderr, verbose())) {
> +			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
> +			env.has_testmod = false;
> +		}
>  	}
>  
>  	/* initializing tests */
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index c0eb54bf08b3..ade6208b4a69 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -262,9 +262,6 @@ int load_bpf_testmod(FILE *err, bool verbose)
>  {
>  	int fd;
>  
> -	/* ensure previous instance of the module is unloaded */
> -	unload_bpf_testmod(err, verbose);
> -
>  	if (verbose)
>  		fprintf(stdout, "Loading bpf_testmod.ko...\n");
>  
> -- 
> 2.39.1
> 

Acked-by: David Vernet <void@manifault.com>
