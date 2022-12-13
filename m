Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7164C065
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiLMXVG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiLMXVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:21:04 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E3AE5A
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:21:03 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9504C240104
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 00:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670973661; bh=7Knrs2kqjkxDJI3GQ+m6sRN/uTKKcXGhgc1elWOLL/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=hXd5km9p7YcBJ1EsMC7RCWb/bvZqwKa7THe5mlbDw4c0Z6tvlXazaw3taj6saz5xA
         mpYsDVNb3F9fhJd7U5VHFslYJzeFp7LH6nJYcXrkbOLlp3hVPk/FQFNEdaqxO0W1qT
         Mb/oBS/XzH0SYYLf1RwUh1h6iKJZzGKScq7BP3rkigszwWy0jZ/2H3Rcw99CWa9zpB
         SSjsZ20dpg5VO3ovyafdChidabkHHL0Etkc8Ux4y3MSneQdC/q1ke40b9b/NzUavqi
         YMSqCXfiTgp4wRLkpUDmzWf7mJGLFEOYKBXDtG1S34vuIBAiNQGChXatdTZwEXSBSt
         JQJt7sg+jflbg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWvcp368Dz6tmN;
        Wed, 14 Dec 2022 00:20:58 +0100 (CET)
Date:   Tue, 13 Dec 2022 23:20:54 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: select
 CONFIG_FUNCTION_ERROR_INJECTION
Message-ID: <20221213232054.eaqsyinwtna5drmm@muellerd-fedora-PC2BDTX9>
References: <20221213220500.3427947-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221213220500.3427947-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 02:05:00PM -0800, Song Liu wrote:
> BPF selftests require CONFIG_FUNCTION_ERROR_INJECTION to work. However,
> CONFIG_FUNCTION_ERROR_INJECTION is no longer 'y' by default after [1].
> As a result, we are seeing errors like the following from BPF CI:
> 
>    bpf_testmod_test_read() is not modifiable
>    __x64_sys_setdomainname is not sleepable
>    __x64_sys_getpgid is not sleepable
> 
> Fix this by explicitly selecting CONFIG_FUNCTION_ERROR_INJECTION in the
> selftest config.
> 
> [1] commit a4412fdd49dc ("error-injection: Add prompt for function error injection")
> Reported-by: Daniel Müller <deso@posteo.net>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 612f699dc4f7..5cbc975fd5c8 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -76,3 +76,4 @@ CONFIG_USERFAULTFD=y
>  CONFIG_VXLAN=y
>  CONFIG_XDP_SOCKETS=y
>  CONFIG_XFRM_INTERFACE=y
> +CONFIG_FUNCTION_ERROR_INJECTION=y
> \ No newline at end of file

Thanks for the fix! I believe we try to keep the file sorted (although I do see
one violation) to make it easy to diff against arch specific configs but also to
minimize the risk of merge conflicts (more likely if everybody appends). Would
you mind sorting the addition in?

Looks good to me otherwise.

Acked-by: Daniel Müller <deso@posteo.net>
