Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C05931FE
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiHOPeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiHOPdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:33:42 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0B1FCFF
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:33:25 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNc5b-000BN8-79; Mon, 15 Aug 2022 17:33:15 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNc5a-000ITG-TE; Mon, 15 Aug 2022 17:33:14 +0200
Subject: Re: [PATCH bpf-next] bpftool: Clear errno after libcap's checks
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20220812153727.224500-2-quentin@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dfda4b3e-2935-fd19-ce62-f331c07d6921@iogearbox.net>
Date:   Mon, 15 Aug 2022 17:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220812153727.224500-2-quentin@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26628/Mon Aug 15 09:51:41 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/12/22 5:37 PM, Quentin Monnet wrote:
> When bpftool is linked against libcap, the library runs a "constructor"
> function to compute the number of capabilities of the running kernel
> [0], at the beginning of the execution of the program. As part of this,
> it performs multiple calls to prctl(). Some of these may fail, and set
> errno to a non-zero value:
> 
>      # strace -e prctl ./bpftool version
>      prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
>      prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
>      prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
>      prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
>      prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
>      prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
>      ** fprintf added at the top of main(): we have errno == 1
>      ./bpftool v7.0.0
>      using libbpf v1.0
>      features: libbfd, libbpf_strict, skeletons
>      +++ exited with 0 +++
> 
> Let's clean errno at the beginning of the main() function, to make sure
> that these checks do not interfere with the batch mode, where we error
> out if errno is set after a bpftool command.
> 
> [0] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_alloc.c?h=v1.2.65#n20
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>   tools/bpf/bpftool/main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 451cefc2d0da..c0e2e4fedbe8 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -435,6 +435,9 @@ int main(int argc, char **argv)
>   
>   	setlinebuf(stdout);
>   
> +	/* Libcap */

Good catch! The comment is a bit too terse, could you improve it, so that it's
clear from reading code (w/o digging through git log) why we need to reset errno
in this location? Thx

> +	errno = 0;
> +
>   	last_do_help = do_help;
>   	pretty_output = false;
>   	json_output = false;
> 

