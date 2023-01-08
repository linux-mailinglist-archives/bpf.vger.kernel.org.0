Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB7661309
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 03:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjAHCXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Jan 2023 21:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjAHCXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Jan 2023 21:23:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6818B24;
        Sat,  7 Jan 2023 18:23:16 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so3309084oto.5;
        Sat, 07 Jan 2023 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+Ix8GNOC6OPLYkyh//YuERX6kRqmc6hFntEObi2OjY=;
        b=BqlHUwWDxzDrP20R9F+yxq8U4qk4Am5DSZO8pglFDUQd0fdiTEW64xyzUqzsBW9dFu
         yp7UmcBINYHx0m+3qTaZiitoanceWyKySRLSEd47aHb3l4CNL+ItVy3hmXzYgyXTH1nD
         dnAci7l9ee3BgECt69yVCckbxsSKY+IJvMswIrSaadLl3GEf7XGE917UlrdD0lHe0X1e
         Ej1ukYKnL+Ol3NU3vi4jZNp0z13M/M9Jli49GpBNCn4YzYPgokrmCKX0VFsurJGX5zGf
         BiqlTrxfHzRPJxsz3LFaNwmPFVnuv0MOl3TVVPV9hyKzkI4Ba+BK8offEhnZ4bptz8EC
         GX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Ix8GNOC6OPLYkyh//YuERX6kRqmc6hFntEObi2OjY=;
        b=WjPPR4N+2Tu3qJZ5qg/bs2AgR3W9ggssTKle7mWykbf+6tt+78uVPCNP/oSfNur4XO
         yvdCtr2/61PipEHuCp4zJdZcEtfqF9iTFaCXsXwz9AzbuEqkfufFUoHXlpxY9WC/xwn2
         EvDpToBu3N7h8IrX+UoM7cX+cMrnCzz6QmO5mxJ13GqdRM0W2TZ6HsqRoqB7TvPfo9lq
         nhpmUsIwNxG7TXaGDxHHYNzsENDtnj9NcB+H1qSh8zKsFYsqjEmOk7//dbnvIlOziYgp
         MfqHfeDm/Nkc+Rnx2xP+QFd9AwxpCLtupbG/20bTcBZpyE051UafEeHaRaqU6POIg+pl
         rYhA==
X-Gm-Message-State: AFqh2kpRPOL2y3D8vrTK6z0B9mlkXoiHHKqKOT86uS1Pt27bgV5KB+Uh
        GicjddE39ISNiAMXgLEd91X/Ru9HZ6hz5g==
X-Google-Smtp-Source: AMrXdXvqehkZnaN5O9q7fUUERou/mCSyIfVd+xW65YGAQNmnBqkGEsZdeKEn3M0D7JUGBoQZ2oTYAA==
X-Received: by 2002:a9d:6550:0:b0:670:6f6c:5fc7 with SMTP id q16-20020a9d6550000000b006706f6c5fc7mr27565862otl.9.1673144595233;
        Sat, 07 Jan 2023 18:23:15 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y4-20020a0568301d8400b006708d2cd8bcsm2483913oti.65.2023.01.07.18.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 18:23:14 -0800 (PST)
Message-ID: <0ca4ad02-af27-0d1f-8750-1ff6b34e8d2a@gmail.com>
Date:   Sat, 7 Jan 2023 23:23:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Fwd: [PATCH bpf] scripts: Exclude Rust CUs with pahole
Content-Language: en-US
References: <828d438e-afe3-1fc0-bc12-ac98632c0908@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <828d438e-afe3-1fc0-bc12-ac98632c0908@gmail.com>
X-Forwarded-Message-Id: <828d438e-afe3-1fc0-bc12-ac98632c0908@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/5/23 13:40, Eric Curtin wrote:
> Hiya Martin,
> 
> Just in case you hadn't noticed, the test bot complained about this...
> 
>>> grep: include/config/auto.conf: No such file or directory
> --
>>> grep: include/config/auto.conf: No such file or directory
>>> grep: include/config/auto.conf: No such file or directory
>>> grep: include/config/auto.conf: No such file or directory
> 
> Is mise le meas/Regards,
> 
> Eric Curtin
> 
> On Sun, 1 Jan 2023 at 08:57, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Martin,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on bpf/master]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Rodriguez-Reboredo/scripts-Exclude-Rust-CUs-with-pahole/20221221-112806
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
>> patch link:    https://lore.kernel.org/r/20221220203901.1333304-1-yakoyoku%40gmail.com
>> patch subject: [PATCH bpf] scripts: Exclude Rust CUs with pahole
>> config: sh-se7724_defconfig
>> compiler: sh4-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/intel-lab-lkp/linux/commit/24aac5fd4ea59e02e9c203d3a59be6f13c5e702f
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Martin-Rodriguez-Reboredo/scripts-Exclude-Rust-CUs-with-pahole/20221221-112806
>>         git checkout 24aac5fd4ea59e02e9c203d3a59be6f13c5e702f
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh distclean
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> grep: include/config/auto.conf: No such file or directory
>> --
>>>> grep: include/config/auto.conf: No such file or directory
>>>> grep: include/config/auto.conf: No such file or directory
>>>> grep: include/config/auto.conf: No such file or directory
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> 

I see, I was making a dependency on `auto.conf` in `pahole-flags.sh` but
the former gets generated after the latter is called, so that's the
reason behind the `grep` errors. Sent a new version of the patch.
