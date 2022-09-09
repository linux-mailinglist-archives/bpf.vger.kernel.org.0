Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3B5B3DEF
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiIIR13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIIR13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 13:27:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1511B00E
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:27:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k19-20020a056a00135300b0054096343fc6so1399597pfu.10
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4U0Cv792MiLLT3xqs4tLXzlENCdHaXq6QFZB5ccoybY=;
        b=sk4rX+o2kF0PpS+GapykbME7V/iKflBOVs5DX+no6UBgfZ0GCN+R1gzNqcy20y9TY6
         lk6gQA9BXhHQZZL+/+gtkgVU3TFNsJDcOykvHYigFcUOWqN3vbirbeZ1fUqT9TEuWzAq
         TXNCfaLVHN8jt6rqMwOMc3685zlnJkAT00C0eO6sfKHl4X30DJ8AdNs4fIF1kRsLp4Jp
         joiA7TjSYfdVOCMpAm2vQo1REHjVoVpaqACOBUiFeiqyCw/jgQAU0/22xJj95dpDgR52
         wGa9xhd84e3+8uooFqK2fMNGnpO/YcMtS3qVMjByFzfE2COMYHUwNldDVAkPXwpq8HZW
         151Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4U0Cv792MiLLT3xqs4tLXzlENCdHaXq6QFZB5ccoybY=;
        b=I5doHDU9Ildjtz3aEfCGgOJnyzeJ2/89xPgZBcX4u4aUQH6BbxzNLsLcrLtbFyV93L
         DZ2Ytw0Im09DyaBTw+v+2Wh0npRCXYmD9T/m2czkstF9bxDpuGAmgBRSc7bbq5ErjEEt
         QlOpJB+SBy5ddSJMmhHkQKKdjGYaX5i3tTvvedWJu89xKYwBJ8vehAGNlqalWnemiMcP
         BeBeFqcYg6vvjIT0tGfw1bIigrK5U/XT7z65RvajU66d10qVl2SJ9dcov6YNUyZcEsro
         lj8rO6SAxVdfi0s0s5ctbnV9HPua6HLvX10RQOOPb+4G+QuaKgZpcZRSmobkAv8Fv+jG
         aJMw==
X-Gm-Message-State: ACgBeo2EVX1ZomZ2spvqywX3kSKbCuWBn315BlnwbmOSucPD2uU3vIqo
        STX/MB3i6sW28ajP+omDEv0lEH4=
X-Google-Smtp-Source: AA6agR4/1v8k4P0tIGrMaKelSGXTF4hBGJOJrswI6GLsXRjbKUupDQjGRlD+EMWMrHFnGqLJszd59GI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4b11:b0:202:998b:71b1 with SMTP id
 lx17-20020a17090b4b1100b00202998b71b1mr1706703pjb.208.1662744447776; Fri, 09
 Sep 2022 10:27:27 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:27:26 -0700
In-Reply-To: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Yxt3fnUdzDTJzUTt@google.com>
Subject: Re: [bpf-next] bpf: use kvmemdup_bpfptr helper
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/09, Wang Yufen wrote:
> Use kvmemdup_bpfptr helper instead of open-coding to
> simplify the code.

> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>   kernel/bpf/syscall.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4e9d4622aef7..13ce28081982 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1413,20 +1413,14 @@ static int map_update_elem(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	}

>   	value_size = bpf_map_value_size(map);
> -
> -	err = -ENOMEM;
> -	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> -	if (!value)
> +	value = kvmemdup_bpfptr(uvalue, value_size);
> +	if (IS_ERR(value)) {
> +		err = PTR_ERR(value);
>   		goto free_key;
> -
> -	err = -EFAULT;
> -	if (copy_from_bpfptr(value, uvalue, value_size) != 0)
> -		goto free_value;
> +	}

>   	err = bpf_map_update_value(map, f, key, value, attr->flags);


[..]

> -free_value:
> -	kvfree(value);

And here you leak the value. We need to free it after update regardless
of error/success. That's why it is coded like that.

>   free_key:
>   	kvfree(key);
>   err_put:
> --
> 2.25.1

