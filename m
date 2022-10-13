Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D45FD33A
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMC1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMC1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 22:27:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC9115400
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 19:27:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y191so722706pfb.2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gKYRZDDM90Di93CvJKt2gp7x873nH3xFGWEnv5tNnk=;
        b=idd+IDgFuT97y5XHKYyQdT2D1mbNkr0iIBw5OjhnEaH4fcxjb6PJcHbvWq8dFxvfYM
         E6PYnyZDRzvMarYaY9mAm0X2Wks+9IX+tEYpvnhPFPDMsmR7tkj6m4e5f/7aDJy5VKMo
         cdnk9Brj4dPk5aJ5NJ+R55CnjQPTk7lmSo/6KIcWpTTYGOux3U3htRJclqX73rtk12rf
         VXmpz6oL5IAk/s68rG0Ed8BSIX2+1FoDitVE3fNbQqauqXxE9KQlIQZmIBaXJ5xgr2LI
         +n01UInQHME/GVow9d+pqzyjoAbGkEOQvjRaB673uJfbpa/ksDH1FOfH3/t8RZCeVp/M
         NjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gKYRZDDM90Di93CvJKt2gp7x873nH3xFGWEnv5tNnk=;
        b=H/Gsk5kxbGNdFM7hEtgesEPMZK4EHVLngAltWzZvhOrSP4CfgMl+Mur/fcGRuDBfi7
         KRi8cNtKcEmaOqHcyiyrVGPsww3ZJNFsf59DjC9rG2qOr32EuKtl4c2jqwkCj3LfoCKi
         7qQtu3vpkdgE0fMvL/1e8fdqVxl3Rd2rBhDvegRTcxGu5x3EfXKCRQrTfNMIKpO+pS3O
         DkHtREN3L+OI3MvlCCaKzarBO4UCRsh2f5vY3ThBZIgyMnA8L0U7eFpvD1rGEkb8oCdb
         0Oqi/E5bmLBWbJbqJ1uq3gryS0099wUT3kfjpdFZNaOoNpHhwAC/nHtgOCDPbj98Q3If
         XiWw==
X-Gm-Message-State: ACrzQf1vsN63Y/PwT7L0gWyIRqNC/Y0wTTGwdH/f5rN/TxshIlsGxsyd
        0uKA+beinKAuiUSGu/dmtONs1w==
X-Google-Smtp-Source: AMsMyM7KPCJeeqJDtF19rxNp6rJSIbjdUQUoSJbXW7zXW/LF9FLidVM+yKS+2bmlJn3pw1+GTVJ/vQ==
X-Received: by 2002:a63:20f:0:b0:43c:1ef6:ebd6 with SMTP id 15-20020a63020f000000b0043c1ef6ebd6mr28190029pgc.217.1665628057933;
        Wed, 12 Oct 2022 19:27:37 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090a170c00b00206023cbcc7sm2046281pjd.15.2022.10.12.19.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 19:27:37 -0700 (PDT)
Message-ID: <ae81b620-e9c8-563a-8c54-2235164624dc@bytedance.com>
Date:   Thu, 13 Oct 2022 10:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] bpf/btf: Fix is_int_ptr()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20221012125815.76120-1-zhouchengming@bytedance.com>
 <1e01ab5a-c171-0b7a-751a-9ba7da4cd5dd@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <1e01ab5a-c171-0b7a-751a-9ba7da4cd5dd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/10/13 08:50, Martin KaFai Lau wrote:
> On 10/12/22 5:58 AM, Chengming Zhou wrote:
>> When tracing a kernel function with arg type is u32*, btf_ctx_access()
>> would report error: arg2 type INT is not a struct.
>>
>> The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
>> in tracing programs") added support for int pointer, but don't skip
>> modifiers before checking it's type. This patch fixes it.
> 
> A selftest is needed.  You can refer to the selftest added in the patch set [0] of the commit bb6728d75611.
> 
> This belongs to bpf-next.  Please tag it as bpf-next and also v2 in the next revision:
> Documentation/bpf/bpf_devel_QA.rst  (Q: How do I indicate which tree....)
> 
> [0]: https://lore.kernel.org/bpf/20211208193245.172141-2-jolsa@kernel.org/

Thanks for these helpful references, will do.

> 
>>
>> Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>   kernel/bpf/btf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index eba603cec2c5..2b343c42ed10 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5316,8 +5316,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>>       /* t comes in already as a pointer */
>>       t = btf_type_by_id(btf, t->type);
>>   -    /* allow const */
>> -    if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
>> +    /* skip modifiers */
>> +    while (btf_type_is_modifier(t))
> 
> There is btf_type_skip_modifiers() that should be useful here.

Ok, will change to use this.

> 
>>           t = btf_type_by_id(btf, t->type);
>>         return btf_type_is_int(t);
> 
