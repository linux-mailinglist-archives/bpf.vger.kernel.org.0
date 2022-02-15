Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5BA4B7206
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 17:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiBOPr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 10:47:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbiBOPrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 10:47:17 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C5CC538
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 07:46:09 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o10so15146588ilh.0
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQs21yv2f+We8y2ER6IR8G/EJEy1JELXcGjZReUP8ME=;
        b=UjT5GW/IvoqiKyKL8/Wl5k3GSDeoRbZKenU7cV9xB29VZJr/+VmO7z3nPvExTJ6cb3
         RYCsVfzRFtabEK+bcZGvIIJey/nm/15EfDpaXq8hFFeX91x+S8HmLkfsRdIzXahDn7IY
         qUm4N4kSN4imaKgCjD323SsyZiAU1WhgCWiD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQs21yv2f+We8y2ER6IR8G/EJEy1JELXcGjZReUP8ME=;
        b=BHNdy6RPCKaUJyZGSrnQ+lHiLizrJKF6P/UKD789CRHraIcIJgcnDWXEtMUTrp4QBD
         m1ocVXZc3qQGXs6r/b3AyBDzWiTRD/3BzuvrMW0wqCNQOV28KVROh7qEvLlUG7KwNqw8
         K6KZyrAVikIsAAxdQWQnrS9S9upv6vcObV0xwKdY6qoSk/e4OGXgb9wGsnBRrz7soG7S
         KDh+Vr7FwuljPabPANXJzLt1I14A/rAFB8ImsnFNzEgUp/SRdxCvWgTrxpLfWyXLhJvG
         06MquVJpc2YJ3NXcM05S8rNJmZjTOl7oud9p8wVDwhJjvnOpPtpvtxSFhKZl7uH+4yko
         LUDA==
X-Gm-Message-State: AOAM530j5QeShaYG+mADSqlGvqCJhyaVJCyQa7ijyw+e6CRQb71LBD8Q
        cJZzbrGEsGBk2ob9pAoZL+TbkQ==
X-Google-Smtp-Source: ABdhPJwzLkAFx8rhlhLaDU9FF8txtiwWC2frhOjc/xUT8iwtOAyMUlXov0SQjOW9BE8EqiULkIY4IQ==
X-Received: by 2002:a92:db0e:: with SMTP id b14mr2943259iln.153.1644939968545;
        Tue, 15 Feb 2022 07:46:08 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 12sm13323337ilx.20.2022.02.15.07.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:46:08 -0800 (PST)
Subject: Re: [PATCH v2 1/6] ima: Fix documentation-related warnings in
 ima_main.c
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, revest@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220215124042.186506-1-roberto.sassu@huawei.com>
 <20220215124042.186506-2-roberto.sassu@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <759a70de-a06b-592c-de4a-f7c74fbe4619@linuxfoundation.org>
Date:   Tue, 15 Feb 2022 08:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220215124042.186506-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/22 5:40 AM, Roberto Sassu wrote:
> Fix some warnings in ima_main.c, displayed with W=n make argument.
> 

Thank you for fixing these. Doc builds are full of them and few less
is welcome.

Adding the warns or summary of them to change log will be good.

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/ima/ima_main.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8c6e4514d494..946ba8a12eab 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -418,6 +418,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>   
>   /**
>    * ima_file_mprotect - based on policy, limit mprotect change
> + * @vma: vm_area_struct protection is set to
>    * @prot: contains the protection that will be applied by the kernel.
>    *


Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
