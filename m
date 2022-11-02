Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84F61613D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 11:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKBKwB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKBKwB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 06:52:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB8B29362
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 03:51:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so986252wmb.3
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3t89BApMC9GV5pVw6Uj+C2lxdZ+0mjrFrpyj0nVCJ0=;
        b=RoStPn3f7qNAjvTlBT5i0I+o3K99wdi9ACnHtuu3av0GiNmY4mcgzTnVJqyfMYeYfK
         ZX8Yx0MNU24vwcb2srYLsOIynFFGxbuHs8/u3lXUWSV9ZZF+q5BzjziXt7svqTA74XPj
         fPV5U3P284lsqBrZh6SaPmA6Z2P5UsydrE9FBMuxe2CrXpT5EnECWBM+EsgNWkl8GHlJ
         SJQT+TL9nrT7t60ImXuyEnulYHAqJh6YTP8cqlGZZGDYt+s2fSFZZ23wsJkArQccM3bK
         hA+lffNiVZ+w8/woU60YXfgDMn1i7pjGQNlVn/wMoImgZhdOZ59e56c/5YIhJOoPRtP4
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3t89BApMC9GV5pVw6Uj+C2lxdZ+0mjrFrpyj0nVCJ0=;
        b=yecUEbmq4MJ8t7kGpqPYtxt98SUY2TI+weoX+bssdVFuXkOXcaFZstLz4aJL7KBv5u
         9tS20okuL7Ntu9vXhpltwEnuAWcuH//126YSWXZst9uH9Y4DL71OjWm+fQ8DYNXm9kRg
         xKnTEK65ZMsCAtxu1WrQjg3bgM7DsaKSj64Q6CAjsUwQQh5kddkoGr4IwGLzMU0Yg+tu
         +7EqoPDi1eu3qcxV3io/IosqIxo+o4cxjTgXBUw8DFuiPlKjyCWIuUEjMVky+Q1bvZk9
         NFWrLUuyjjn7vyhsnD4uXpY7/Y/Zr+3RtEdQoGRNaDauFkQdzQzmCIo8WgIZK6ft4YWS
         kM9g==
X-Gm-Message-State: ACrzQf2AA/ihh5SW6gIllRLOoN6dgOZJhJH14qeIKOlynF0TJKMJupFs
        q/iiFTrWQIviwbrPH/KuWIbSYw==
X-Google-Smtp-Source: AMsMyM5BM7WyTIpyAwNqmgJuMpcJ9L39yP3gmgFPQqONbA9X+8z7GKjHpV7nkv21MwfpIaJWjP0Otg==
X-Received: by 2002:a05:600c:198e:b0:3c6:e7e6:490 with SMTP id t14-20020a05600c198e00b003c6e7e60490mr15296534wmq.79.1667386318373;
        Wed, 02 Nov 2022 03:51:58 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4ff30e566sm1898157wmq.3.2022.11.02.03.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 03:51:57 -0700 (PDT)
Message-ID: <c4948e58-0666-5d4b-3436-7672f98fe1e3@isovalent.com>
Date:   Wed, 2 Nov 2022 10:51:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf] bpftool: Fix NULL pointer dereference when pin {PROG,
 MAP, LINK} without FILE
Content-Language: en-GB
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20221102084034.3342995-1-pulehui@huaweicloud.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221102084034.3342995-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-11-02 16:40 UTC+0800 ~ Pu Lehui <pulehui@huaweicloud.com>
> From: Pu Lehui <pulehui@huawei.com>
> 
> When using bpftool to pin {PROG, MAP, LINK} without FILE,
> segmentation fault will occur. The reson is that the lack
> of FILE will cause strlen to trigger NULL pointer dereference.
> The corresponding stacktrace is shown below:
> 
> do_pin
>   do_pin_any
>     do_pin_fd
>       mount_bpffs_for_pin
>         strlen(name) <- NULL pointer dereference
> 
> Fix it by adding validation to the common process.
> 
> Fixes: 75a1e792c335 ("tools: bpftool: Allow all prog/map handles for pinning objects")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/bpf/bpftool/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index e4d33bc8bbbf..653c130a0aaa 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -302,6 +302,9 @@ int do_pin_any(int argc, char **argv, int (*get_fd)(int *, char ***))
>  	int err;
>  	int fd;
>  
> +	if (!REQ_ARGS(3))
> +		return -EINVAL;
> +
>  	fd = get_fd(&argc, &argv);
>  	if (fd < 0)
>  		return fd;

Good catch, and thanks for the fix!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
