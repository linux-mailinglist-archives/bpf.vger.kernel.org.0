Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDC6920F7
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 15:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBJOl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBJOlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 09:41:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22633901A
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:41:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o36so3995849wms.1
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIivKTkMxv+6uN46REaHc9kp5hcGge4d+YKfiDX2gGw=;
        b=Td8MnJXiMffRoMxJ8WGLKGfr0tjtKavnDXo6Cwmc31bFTujSmrhbwLvbmJzjFnwogZ
         maqdw0oH5YVeeorLpTybCP6Wsv1bmHt05bIrrB+TgLpi99MKwDZLJMGj5N7kbHDY7iip
         U2jRE9t4Y29sNiszo+ybnTia3jN+FfmYQMQIWKVC0QgwDmEMeBwgu6DCR/vH606x5AQp
         jad5FuwySRYMX5ty8qLh3c5Mto8XFkKIMTc2x10LPW0u0Qod6jUSZS0XM4jVx+qhoOny
         /4Wmu3JY8CGkRkWIeKIHZaCp2Xds8Ag86tMB7hF3TSJwS7m5Ii7Awc49ERW0BXJSkGVS
         pDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIivKTkMxv+6uN46REaHc9kp5hcGge4d+YKfiDX2gGw=;
        b=DLQ/jTdv9o1iX2fyf9bL+S/GCzEvTtDab41z0Ots/V/DQ7j0iDH3c/Wvc+EPRleJYq
         +RoHVzsyndTjjxE8du5w7a0DzrKhUJYPajO5H2ibRIG5OIAzev8w+kAK0ChG1byfNJVs
         FTOI9AqvGH12PDirVBHoKbiSOKvIr6K2msZIZaED+eeLq71CfNL2yNI5gDBk5meKvgq7
         aVL/MIAhakyJ/faGnFjzgHd1k3xQQFDcwY6XoONvIOyJN2uSFRtewVs+XP9xEE7Xuxc/
         rKQfZfs6EhLlMa1tktMG4tVBE708Po+mI6j0315vqDrK0mtM6V5TmOfuIfINun3fREq4
         XE8w==
X-Gm-Message-State: AO0yUKXjlGi7OYiArrnVC41vOmkfA6cdZo7JaDwxMPFw5dPS7/BJ5uSw
        kS9HnPmCy2w0gI2RN1BePDGGnQ==
X-Google-Smtp-Source: AK7set+5ICu3ekI8mppJkNAdrO1O9iEKAWx1IrZygDAR93zBQroLvbEcckXlaaskhm2EXjVWr2CvEg==
X-Received: by 2002:a05:600c:2b46:b0:3cf:85f7:bbc4 with SMTP id e6-20020a05600c2b4600b003cf85f7bbc4mr12836472wmf.2.1676040107683;
        Fri, 10 Feb 2023 06:41:47 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:217b:e46a:f7d9:ebde? ([2a02:8011:e80c:0:217b:e46a:f7d9:ebde])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003dc0cb5e3f1sm4791200wmp.46.2023.02.10.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:41:47 -0800 (PST)
Message-ID: <d5168e6e-701f-a0f6-e504-ff45d7657832@isovalent.com>
Date:   Fri, 10 Feb 2023 14:41:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v2 10/16] bpftool: Use
 bpf_{btf,link,map,prog}_get_info_by_fd()
Content-Language: en-GB
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
 <20230210001210.395194-11-iii@linux.ibm.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230210001210.395194-11-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-02-10 01:12 UTC+0100 ~ Ilya Leoshkevich <iii@linux.ibm.com>
> Use the new type-safe wrappers around bpf_obj_get_info_by_fd().
> lease enter the commit message for your changes. Lines starting
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Hi, here are a few comments from my side inline below. Other than these,
the patch looks good to me, thanks.

> ---
>  tools/bpf/bpftool/btf.c        | 13 ++++++++-----
>  tools/bpf/bpftool/btf_dumper.c |  4 ++--
>  tools/bpf/bpftool/cgroup.c     |  4 ++--
>  tools/bpf/bpftool/common.c     | 13 +++++++------
>  tools/bpf/bpftool/link.c       |  4 ++--
>  tools/bpf/bpftool/main.h       |  3 ++-
>  tools/bpf/bpftool/map.c        |  8 ++++----
>  tools/bpf/bpftool/prog.c       | 24 +++++++++++++-----------
>  tools/bpf/bpftool/struct_ops.c |  6 +++---
>  9 files changed, 43 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 352290ba7b29..91fcb75babe3 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[...]

> @@ -789,7 +789,10 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>  		}
>  
>  		memset(info, 0, *len);
> -		err = bpf_obj_get_info_by_fd(fd, info, len);
> +		if (type == BPF_OBJ_PROG)
> +			err = bpf_prog_get_info_by_fd(fd, info, len);
> +		else
> +			err = bpf_map_get_info_by_fd(fd, info, len);

Not obvious to me why we should change this one, I suppose knowing the
type helps with the Memory Sanitizer?

[...]

> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 620032042576..5a73ccf14332 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c

[...]

> @@ -1026,7 +1026,8 @@ int map_parse_fd(int *argc, char ***argv)
>  	return fd;
>  }
>  
> -int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
> +int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
> +			  __u32 *info_len)

This is not strictly related to the other changes, please don't forget
to mention it when you fix the commit description.

>  {
>  	int err;
>  	int fd;

[...]

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index e87738dbffc1..1944d000038c 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[...]

> @@ -2170,9 +2170,10 @@ static char *profile_target_name(int tgt_fd)
>  	char *name = NULL;
>  	int err;
>  
> -	err = bpf_obj_get_info_by_fd(tgt_fd, &info, &info_len);
> +	err = bpf_prog_get_info_by_fd(tgt_fd, &info, &info_len);
>  	if (err) {
> -		p_err("failed to bpf_obj_get_info_by_fd for prog FD %d", tgt_fd);
> +		p_err("failed to bpf_prog_get_info_by_fd for prog FD %d",
> +		      tgt_fd);

Nit: Maybe just drop the function name here, and keep "failed to get
info for prog FD [...]"? Same below.

>  		goto out;
>  	}
>  
> @@ -2183,7 +2184,8 @@ static char *profile_target_name(int tgt_fd)
>  
>  	func_info_rec_size = info.func_info_rec_size;
>  	if (info.nr_func_info == 0) {
> -		p_err("bpf_obj_get_info_by_fd for prog FD %d found 0 func_info", tgt_fd);
> +		p_err("bpf_prog_get_info_by_fd for prog FD %d found 0 func_info",
> +		      tgt_fd);
>  		goto out;
>  	}
>  

[...]
