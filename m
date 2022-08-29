Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F645A50CE
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 17:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiH2P5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2P5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 11:57:52 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565597B0E
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 08:57:50 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSh92-000GrU-SW; Mon, 29 Aug 2022 17:57:48 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSh92-000IYe-Kd; Mon, 29 Aug 2022 17:57:48 +0200
Subject: Re: [PATCH bpf v2] bpf: Add config for skipping BTF enum64s
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
References: <20220828233317.35464-1-yakoyoku@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7def67d7-fb66-3353-ab2f-266559c482bb@iogearbox.net>
Date:   Mon, 29 Aug 2022 17:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220828233317.35464-1-yakoyoku@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/22 1:33 AM, Martin Rodriguez Reboredo wrote:
> After the release of pahole 1.24 some people in the dwarves mailing list
> notified issues related to building the kernel with the BTF_DEBUG_INFO
> option toggled. They seem to be happenning due to the kernel and
> resolve_btfids interpreting btf types erroneously. In the dwarves list
> I've proposed a change to the scripts that I've written while testing
> the Rust kernel, it simply passes the --skip_encoding_btf_enum64 to
> pahole if it has version 1.24.
> 
> v1 -> v2:
> - Switch to off by default and remove the config option.
> - Send it to stable instead.

This should only go to stable and not to bpf tree, right? To which stable versions?
For stable tree submissions you'd need to send this to stable@vger.kernel.org in Cc
and subject should say e.g. '[PATCH stable 5.4]' for 5.4 branch [0]. Either way, pls
clarify.

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-5.4.y

Thanks,
Daniel

> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>   scripts/pahole-flags.sh | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a5..0a48fd86bc68 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,8 @@ fi
>   if [ "${pahole_ver}" -ge "122" ]; then
>   	extra_paholeopt="${extra_paholeopt} -j"
>   fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
> +fi
>   
>   echo ${extra_paholeopt}
> 

