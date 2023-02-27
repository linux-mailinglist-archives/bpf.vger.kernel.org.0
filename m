Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332CE6A4CD3
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjB0VMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0VMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:12:17 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D01E2A6;
        Mon, 27 Feb 2023 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9EFMV8RI95u1IbGQbaI0Q+qMCLpo5vI0UEma9i4EWq8=; b=lmkICcWa037dIV/snWUFxFxXfY
        gi8oPk9SeHoZFLaBxf10MFECZ6iOxxPIS0a2i9694r8ITlmVEOyXX1wuPkdHbO9PzMa3Fp2f1XZup
        NGCVhQy3fSWICfKuWD5D7OmY7JDrd3/WcklHeFJNFxOOFD+uNo4IgofcWZg+W+B2jUvDP20LqbBSv
        C0PTSx1WP8SNJ/WIhr6FAJ6xZ6+BoVFjTwEqIFOSSpuTVYHThrQLgSrKP+D3sYWeBq2YqWDJnYxs0
        PoC+uxjxXyJQ8g8Id3/GqsazrvJrYjLTPPCGy5OsilTZNLqevEUvbuPI4L1sJIwAW9ypn8ZXHpF5c
        IYm4gRIw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pWkn5-0001YJ-N8; Mon, 27 Feb 2023 22:12:11 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pWkn3-000Wp1-Va; Mon, 27 Feb 2023 22:12:11 +0100
Subject: Re: [PATCH v2] Documentation: bpf: Fix link to BTF doc
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Ross Zwisler <zwisler@google.com>
References: <20230222083530.26136-1-bagasdotme@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7cd545a2-4a5c-1961-1cf7-cd0f24e41df8@iogearbox.net>
Date:   Mon, 27 Feb 2023 22:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230222083530.26136-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26825/Mon Feb 27 09:24:38 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/22/23 9:35 AM, Bagas Sanjaya wrote:
> Ross reported broken link to BTF documentation
> (Documentation/bpf/btf.rst) in Documentation/bpf/bpf_devel_QA.rst. The
> link in question is written using external link syntax, with the target
> refers to BTF doc in reST source (btf.rst), which doesn't exist in
> resulting HTML output.
> 
> Fix the link by replacing external link syntax with simply writing out
> the target doc, which the link will be generated to the correct HTML doc
> target.
> 
> Link: https://lore.kernel.org/linux-doc/Y++09LKx25dtR4Ow@google.com/
> Fixes: 6736aa793c2b5f ("selftests/bpf: Add general instructions for test execution")
> Reported-by: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
> 
>    * Reword patch description (I don't see external link semantics on
>      Sphinx documentation [2] when I submit v1).
>    * Drop the corresponding orphan target definition.
>    * Rebase on top of current bpf tree.
> 
> Ross, do you want to give a Reviewed-by or Acked-by?
> 
> [1]: https://lore.kernel.org/linux-doc/20230219030956.22662-1-bagasdotme@gmail.com/
> [2]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#external-links
> 
>   Documentation/bpf/bpf_devel_QA.rst | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 03d4993eda6f05..715f7321020f27 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -469,7 +469,7 @@ under test should match the config file fragment in
>   tools/testing/selftests/bpf as closely as possible.
>   
>   Finally to ensure support for latest BPF Type Format features -
> -discussed in `Documentation/bpf/btf.rst`_ - pahole version 1.16
> +discussed in Documentation/bpf/btf.rst - pahole version 1.16
>   is required for kernels built with CONFIG_DEBUG_INFO_BTF=y.
>   pahole is delivered in the dwarves package or can be built
>   from source at
> @@ -690,6 +690,5 @@ when:
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
>   .. _Documentation/dev-tools/kselftest.rst:
>      https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> -.. _Documentation/bpf/btf.rst: btf.rst

Applied, thanks! Looks like kselftest.rst has a similar issue, could you
send a fix for this too?

>   Happy BPF hacking!
> 
> base-commit: 345d24a91c79f408e355c8b7e873ccde0f097eea
> 

