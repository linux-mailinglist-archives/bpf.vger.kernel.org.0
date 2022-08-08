Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60058CBF1
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbiHHQPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHHQPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 12:15:14 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622FE126;
        Mon,  8 Aug 2022 09:15:12 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL5Oz-0002Rw-Hu; Mon, 08 Aug 2022 18:14:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oL5Oz-000OuE-0M; Mon, 08 Aug 2022 18:14:49 +0200
Subject: Re: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
To:     Roberto Sassu <roberto.sassu@huawei.com>, quentin@isovalent.com,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, terrelln@fb.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
 <20220719170555.2576993-4-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5f867295-10d2-0085-d1dc-051f56e7136a@iogearbox.net>
Date:   Mon, 8 Aug 2022 18:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220719170555.2576993-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26621/Mon Aug  8 09:52:38 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On 7/19/22 7:05 PM, Roberto Sassu wrote:
> Switch to new EVP API for detecting libcrypto, as Fedora 36 returns an
> error when it encounters the deprecated function MD5_Init() and the others.
> The error would be interpreted as missing libcrypto, while in reality it is
> not.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Given rest of the tooling fixes from Andres Freund went via perf tree and the
below is perf related as well, I presume you'll pick this up, too?

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

>   tools/build/feature/test-libcrypto.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/build/feature/test-libcrypto.c b/tools/build/feature/test-libcrypto.c
> index a98174e0569c..bc34a5bbb504 100644
> --- a/tools/build/feature/test-libcrypto.c
> +++ b/tools/build/feature/test-libcrypto.c
> @@ -1,16 +1,23 @@
>   // SPDX-License-Identifier: GPL-2.0
> +#include <openssl/evp.h>
>   #include <openssl/sha.h>
>   #include <openssl/md5.h>
>   
>   int main(void)
>   {
> -	MD5_CTX context;
> +	EVP_MD_CTX *mdctx;
>   	unsigned char md[MD5_DIGEST_LENGTH + SHA_DIGEST_LENGTH];
>   	unsigned char dat[] = "12345";
> +	unsigned int digest_len;
>   
> -	MD5_Init(&context);
> -	MD5_Update(&context, &dat[0], sizeof(dat));
> -	MD5_Final(&md[0], &context);
> +	mdctx = EVP_MD_CTX_new();
> +	if (!mdctx)
> +		return 0;
> +
> +	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> +	EVP_DigestUpdate(mdctx, &dat[0], sizeof(dat));
> +	EVP_DigestFinal_ex(mdctx, &md[0], &digest_len);
> +	EVP_MD_CTX_free(mdctx);
>   
>   	SHA1(&dat[0], sizeof(dat), &md[0]);
>   
> 

