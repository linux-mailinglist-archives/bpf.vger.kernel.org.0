Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9A4BA433
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 16:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbiBQPXO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 10:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiBQPXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 10:23:13 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033C2AFE90
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:22:57 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nKicR-00069L-DA; Thu, 17 Feb 2022 16:22:55 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nKicR-0006N7-6i; Thu, 17 Feb 2022 16:22:55 +0100
Subject: Re: [PATCH v2 bpf-next] scripts/pahole-flags.sh: Enable
 parallelization of pahole.
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
Cc:     kernel-team@fb.com
References: <20220216193431.2691015-1-kuifeng@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b28839b5-8baf-6733-bd9b-4eab035a8340@iogearbox.net>
Date:   Thu, 17 Feb 2022 16:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220216193431.2691015-1-kuifeng@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26456/Thu Feb 17 10:25:48 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/22 8:34 PM, Kui-Feng Lee wrote:
> Pass a -j argument to pahole to parse DWARF and generate BTF with
> multithreading.
> 
> v2 checks the version of pahole to apply -j only if >= v1.22.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   scripts/pahole-flags.sh | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index c293941612e7..264c05020263 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -16,5 +16,8 @@ fi
>   if [ "${pahole_ver}" -ge "121" ]; then
>   	extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
>   fi
> +if [ "${pahole_ver}" -ge "122" ]; then
> +    extra_paholeopt="${extra_paholeopt} -j"

Fixed up whitespace and improved commit desc while applying, thanks!
