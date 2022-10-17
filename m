Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09B600C62
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJQK0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJQK0r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 06:26:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8291AD99
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 03:26:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk15so17701953wrb.13
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqFH7fkSzlUJ/2W1iruZbB5EzbPt5ER8Dh62DWRIYdY=;
        b=JRDTY2RTwyOQQmuytKiWjx2boNd+SABeKuq+ABi66sXY5PFS0H8xS/uPnSN39DlzS6
         IVn7rfA1hpEc4dAuz77AU5vd9t6v7ooM352hZpE5aq5RFkuQ7WSBK+yb4FUl+PJ1ArRD
         WL0trHkopfAvptuzYw96Dclnw2TvgorwrG1AmMnPQkAe7UnVQmLPZnHTOh7UyyHIT9iw
         BG3qMNsIgpzKdUC6b1f4oyFdWJQvQj6Jo4xdUA2iM+2yTH8iICd3HMHnVawPNlrcEVYz
         h0Uu4NfepETfRQXB+o6jafKNCecPeYswSTWKIcJVniGRZSgscR6XrcdMtquhaQN5Wif1
         7TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqFH7fkSzlUJ/2W1iruZbB5EzbPt5ER8Dh62DWRIYdY=;
        b=L11NB+WEt3O+VdKahfmxHcD4osR1JhP8ht48CF1HDkZJRt88JgjGFQaphDnOM3N1mT
         g+8VVVhRtPFikI98M/cdozlpH8CIBYBr0p0X3MU8oao8sdOWrFF3xH8qB1oqClK0vrcH
         U0Mx6odWItol60tZspsG8DJ/VMuPosK2Yeljc6R9OT/qAXyUZqnnXfTE3+I7cNFDSRvy
         RTpzARm5z9hUtBrFRdCadrfh2QaO/sL7W24vWem4zA1hvqCQZ/MoR4p8ss1cu66Wq5Zd
         BPJ+uFIW9woYYQq2njIOHFe6Z9n6LDE0vktuaO4FNUyKL5aHjRuSHg3hMS0YdUDAowz0
         nr4Q==
X-Gm-Message-State: ACrzQf3ZHZRHzuJECdyMQz2FFEK7FkmcAXWEeWUMIvkOHrKxhB4DVH9Y
        3eFAG+m7tAVnMzAxfBQU4MGQ8Q==
X-Google-Smtp-Source: AMsMyM4ctyyhYc8QFz0sg15O9CiZwSBb25ZxTDHt8Hj490+lur42i8LA6AMPZx+cmpAWwRMFpmTfng==
X-Received: by 2002:adf:fc88:0:b0:22e:764a:9762 with SMTP id g8-20020adffc88000000b0022e764a9762mr5745184wrr.318.1666002400659;
        Mon, 17 Oct 2022 03:26:40 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm10004798wrq.72.2022.10.17.03.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 03:26:40 -0700 (PDT)
Message-ID: <01966876-c242-9533-9305-ef3cbf2e7a94@isovalent.com>
Date:   Mon, 17 Oct 2022 11:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 4/5] bpftool: Support new cgroup local storage
Content-Language: en-GB
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045640.3313008-1-yhs@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221014045640.3313008-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-13 21:56 UTC-0700 ~ Yonghong Song <yhs@fb.com>
> Add support for new cgroup local storage
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
>  tools/bpf/bpftool/map.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 7f3b67a8b48f..4c591b10961e 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -55,7 +55,7 @@ MAP COMMANDS
>  |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
>  |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
>  |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> -|		| **task_storage** | **bloom_filter** | **user_ringbuf** }
> +|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **cgroup_local_storage** }
>  
>  DESCRIPTION
>  ===========
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 9a6ca9f31133..ab681dc65316 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1459,7 +1459,7 @@ static int do_help(int argc, char **argv)
>  		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
>  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
>  		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> -		"                 task_storage | bloom_filter | user_ringbuf }\n"
> +		"                 task_storage | bloom_filter | user_ringbuf | cgroup_local_storage }\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
>  		"                    {-f|--bpffs} | {-n|--nomount} }\n"
>  		"",

Thanks for the bpftool update!

Acked-by: Quentin Monnet <quentin@isovalent.com>
