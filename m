Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C75F0FE9
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiI3Q1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiI3Q1U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 12:27:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28515AB71
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:27:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u10so7505930wrq.2
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7W3Og/4RNlgYtNzrXgP9eMetXd3+sXqOcX1XfNyoYbg=;
        b=lQnxFmKReWujc0wGC+kBfGDtBWPj4GUt4tKwBdztRU73AtVWAh392JxqfSMnMAojqx
         naI8Xcs9SnlRkKo1IW20una+Ww97iGYJZ8xkpG6psoJgnZNE6SCiANfkXtKfh9qarm45
         /cYQqFwKabPWrxTU/uqDL/83P1GJ4eLxm1eGkZsv3K7tJtWYx3xh4c8xpMr8D4XZlWec
         EDLnLxKJo7M30uAzQvq7iSD4lhetpjbuTk07sXelD5rELGoBkZmZssedlFClx6/zOsxV
         qSclPVcj7h9IzapATeyxyArtS8g22IZGlsFO+w9U6vTfAiDXQpkLaG3+OsU4yE7jT6Z3
         AMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7W3Og/4RNlgYtNzrXgP9eMetXd3+sXqOcX1XfNyoYbg=;
        b=oBLGBMDHN5REFL7R9wdXccZ4css97ycahP5Uh221BcWHLUXazg3zovN5tqhha0xQre
         mYNhBlmvq+B+gemNZjDXxdsgZWofSnXRjhTZTWhGi12Fk3hKvW6Gdw6XSCUfzaCWSPKN
         53PK6IUrsYJKxt7aK0Nz3057v30BuAFvsVJTuc5Yh9xjPKMIlz8hIGiueozxDgiYzkFK
         q9tp2bhKtfyAu1NjBRrB1w82BnXaWOOWEPJFBFKMpFJl9Rgb9gXz9o1JVfyc15AoaR7+
         PHpkwseLtRF6jy1NauwhrABpevHiwj5fcm4cIvDdnYxaDNIKOsNkJqBd6bd3oLZiQ2vM
         NQfw==
X-Gm-Message-State: ACrzQf0dj3waDRMpPyHdecqlF7hE/Zcj3nBVNQxAZlBqE61ubQnW9jC/
        YlnHNeJyDIXtpGNkV3J356TJMw==
X-Google-Smtp-Source: AMsMyM7/cJuCOeZNl0YTke2gk3elfgNT7Y/M69evvzu+NRzMVx7uur4LbtkDKyUrTPSTI1WIBkzbDw==
X-Received: by 2002:adf:d1cc:0:b0:22a:450c:6208 with SMTP id b12-20020adfd1cc000000b0022a450c6208mr6649206wrd.696.1664555231593;
        Fri, 30 Sep 2022 09:27:11 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003b476bb2624sm2091070wmb.6.2022.09.30.09.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:27:10 -0700 (PDT)
Message-ID: <26838c8a-d8d3-51df-ba27-b2a27ecdbcaa@isovalent.com>
Date:   Fri, 30 Sep 2022 17:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [bpf-next v7 2/3] bpftool: Update doc (add autoattach to prog
 load)
Content-Language: en-GB
To:     Wang Yufen <wangyufen@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev
References: <1664277676-2228-1-git-send-email-wangyufen@huawei.com>
 <1664277676-2228-2-git-send-email-wangyufen@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <1664277676-2228-2-git-send-email-wangyufen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tue Sep 27 2022 12:21:15 GMT+0100 ~ Wang Yufen <wangyufen@huawei.com>
> Add autoattach optional to prog load|loadall for supporting
> one-step load-attach-pin_link.
> 
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index eb1b2a2..b81d3d9 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -31,7 +31,7 @@ PROG COMMANDS
>  |	**bpftool** **prog dump xlated** *PROG* [{**file** *FILE* | **opcodes** | **visual** | **linum**}]
>  |	**bpftool** **prog dump jited**  *PROG* [{**file** *FILE* | **opcodes** | **linum**}]
>  |	**bpftool** **prog pin** *PROG* *FILE*
> -|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*]
> +|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
>  |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog tracelog**
> @@ -131,7 +131,7 @@ DESCRIPTION
>  		  contain a dot character ('.'), which is reserved for future
>  		  extensions of *bpffs*.
>  
> -	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*]
> +	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
>  		  Load bpf program(s) from binary *OBJ* and pin as *PATH*.
>  		  **bpftool prog load** pins only the first program from the
>  		  *OBJ* as *PATH*. **bpftool prog loadall** pins all programs
> @@ -150,6 +150,19 @@ DESCRIPTION
>  		  Optional **pinmaps** argument can be provided to pin all
>  		  maps under *MAP_DIR* directory.
>  
> +		  If **autoattach** is specified program will be attached
> +		  before pin. In that case, only the link (representing the
> +		  program attached to its hook) is pinned, not the program as
> +		  such, so the path won't show in "**bpftool prog show -f**",

Nit: no need for double-quotes, the ** markup is enough.

> +		  only show in "**bpftool link show -f**". Also, this only works
> +		  when bpftool (libbpf) is able to infer all necessary information
> +		  from the objectfile, in particular, it's not supported for all

s/objectfile/object file/

> +		  program types. If the *OBJ* contains multiple programs and
> +		  *loadall* is used, if the program A in these programs does not

**loadall** (keyword)

> +		  support auto-attachi, will skip program A(do no operation on

auto-attach

> +		  program A), print a info message such as "Program A does not
> +		  support autoattach", and continue to autoattach the next program.

continue to auto-attach

> +
>  		  Note: *PATH* must be located in *bpffs* mount. It must not
>  		  contain a dot character ('.'), which is reserved for future
>  		  extensions of *bpffs*.

