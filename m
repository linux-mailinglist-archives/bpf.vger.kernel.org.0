Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307AC6C85C2
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCXTUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCXTUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 15:20:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A17D82
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:20:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g7so1931316pfu.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679685614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FnezTOESwgnOjS/SbRyc1cainTv/No82woDUGPF6lQ=;
        b=ZufGXj34pVVr09MxKPScST6SqGHGu9YU7LTdh1W+MWJ5pE7tV5BhZfIj6ePBLEsc3c
         FJsOCZKW6YBLrJe+C6q/f/1vMtVuFVaJNVimt/bAnQbcih3Afwft40/NmD2f/8eHBshB
         38JCEErbCs33heVtXRnZVPXXLDicPD1h9JceFkwUW80g4YpkWU2LTyxAJMRdS8v1xJAV
         dcD/goPSw1I9UAPut08lG8myIz96EVOL9toNFvSZow48uXhHZ8dhsPSszJFRqQuBVUcS
         fAPiZo4e2PBLuto0pRAf67mQsxpMcXv4O74XC/AU8VxVqhkm2gk/b3LPXHIc3NssDhzj
         +G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FnezTOESwgnOjS/SbRyc1cainTv/No82woDUGPF6lQ=;
        b=mia3XMrj9jhL+4vKjymWVs5f3C7ttHOcxGLbRvhA+LJsMG0nQyMBTT/FMUPaFEbkUx
         5eO+wsHYBblAHmsGm/d8htL+CVHdWOIrPhtvpApkKungTVQULjls2lJt4grrS7gGJv63
         4D0BPo9kcQbrsm82dLRuj+qPU3m7jUgDVX3rdkPCVK6Q27JO96ztvRTXVbskhP1p/jXK
         CWU5+djyYJ/mLUZI2TDIKqXxeRyW99yEfO5Zq3fjX/Dyd7cULWTyIJmVGE3t1jdrf7dy
         cHn6HMAla16qJzU1ZFaJQJvJzhw1ZEmYzdDeQU9F6MSBXmRghKhpx4fuSskmNZhV0cA8
         Uj5A==
X-Gm-Message-State: AAQBX9exXmG/mIQbkbNYsGFAbYDVqDey9OJd7KGHOsRwYtvwmQpYiooY
        BCSSB7WJMYQ3BM9862qicj6VuW2ffaY=
X-Google-Smtp-Source: AKy350a+CjMg8ZD1GuC27pRaxXZGEorJFgDhzRm8Ag1a3q8PR0x/vZe5CUATga2wcbQUVJpo6LPE1Q==
X-Received: by 2002:aa7:98db:0:b0:62a:4fb1:3dea with SMTP id e27-20020aa798db000000b0062a4fb13deamr3702796pfm.24.1679685614192;
        Fri, 24 Mar 2023 12:20:14 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1155? ([2620:10d:c090:400::5:f77c])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78391000000b005dea362ed18sm14247523pfm.27.2023.03.24.12.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:20:13 -0700 (PDT)
Message-ID: <eeae3210-617a-298d-0d0e-f1c19f033c02@gmail.com>
Date:   Fri, 24 Mar 2023 12:20:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next] bpf: Check IS_ERR for the bpf_map_get() return
 value
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
References: <20230324184241.1387437-1-martin.lau@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230324184241.1387437-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This fix makes sense to me.
Thank you for fixing this.

Acked-by: Kui-Feng Lee <kuifeng@meta.com>


On 3/24/23 11:42, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch fixes a mistake in checking NULL instead of
> checking IS_ERR for the bpf_map_get() return value.
> 
> It also fixes the return value in link_update_map() from -EINVAL
> to PTR_ERR(*_map).
> 
> Reported-by: syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
> Fixes: 68b04864ca42 ("bpf: Create links for BPF struct_ops maps.")
> Fixes: aef56f2e918b ("bpf: Update the struct_ops of a bpf_link.")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   kernel/bpf/bpf_struct_ops.c | 4 ++--
>   kernel/bpf/syscall.c        | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 6401deca3b56..d3f0a4825fa6 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -871,8 +871,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	int err;
>   
>   	map = bpf_map_get(attr->link_create.map_fd);
> -	if (!map)
> -		return -EINVAL;
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
>   
>   	st_map = (struct bpf_struct_ops_map *)map;
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b4d758fa5981..a09597c95029 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4689,12 +4689,12 @@ static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
>   
>   	new_map = bpf_map_get(attr->link_update.new_map_fd);
>   	if (IS_ERR(new_map))
> -		return -EINVAL;
> +		return PTR_ERR(new_map);
>   
>   	if (attr->link_update.flags & BPF_F_REPLACE) {
>   		old_map = bpf_map_get(attr->link_update.old_map_fd);
>   		if (IS_ERR(old_map)) {
> -			ret = -EINVAL;
> +			ret = PTR_ERR(old_map);
>   			goto out_put;
>   		}
>   	} else if (attr->link_update.old_map_fd) {
