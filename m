Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BF6E8647
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDTAUf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDTAUe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:20:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBE19BE
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:20:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-246f856d751so269050a91.0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950033; x=1684542033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heYMR9HXQ50EHdAXmkUKd8ThadlQLxXxtEaOPos5gSw=;
        b=T6s6ap6mFeCI6EynKGlYhkEJn7/jrHa5v4wL2kPxifL2OXcA8vAeN0fIC7BLKcLu4d
         O0jjqoMK88l9Z/K1IJTTbdOhR0A4qjqpTzkhJ6ewmxk25Z+r3YujJMedDXphb/c//J1H
         y647iIhj9FNFu+Fo2NS/0Qd4FhMz+ivtsO52fk8JoDKkkV7+PiVkK+EoAyjve35QTLiL
         WoixaszUJYgqcS6YpPbDvRxoCi8V5zvFg+oG0ZEwHJAz+21CchvnOPRyKXREsm12mlwl
         SpCZNLWoPeCq19qt8/pIWeIlnP8nkrApGfHDvNaKtIKdjjpN4fkwkHtMkdZvNkosC1q9
         glJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950033; x=1684542033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heYMR9HXQ50EHdAXmkUKd8ThadlQLxXxtEaOPos5gSw=;
        b=igHbnrFOuywzAKyTjqiQDpkv6Awd8d1u1itP4oEekWmvDlOgZlSGwd/VmnUWhdCcsX
         Q9Qj0fX97Y+V0tmwv8QK5rfJMot4h3Nc6VMG+sZl5GIOjfw6Cu3VwrsnylAUFk2ukGxU
         IajIHmjg4V20heWfBYHJGgDj5vQ/4x4EKJfPzdyLO9E1fSfjcXHwc6nbl4aQ8fUplimG
         paNIwJu+5tWLndc1rgHBb2RATBlcZC4sZz0zetzKFTI5kgK+8SJYu/tRuWf6gl17CduV
         1lr1cH8FlZ1JmZmq0mCaGSBxEWmhfG+r/qBL80tvBHTqoGjSNx7h1RAi7mhGKX/b6Tn4
         WA6g==
X-Gm-Message-State: AAQBX9cKvvoGEi9BH1CO2MsedcFnjFEiXfnbY2wB5nsSUk3T550TODoc
        /kI+vki/D5h/XEzHaoJ/Frg=
X-Google-Smtp-Source: AKy350YlAfQakwSv9jGJ7umJ2tqGlPzng0WIz0mJFIfzDQ8tK31fUol/vzWB3ilo+8v+wgWdJ3ueKg==
X-Received: by 2002:a17:90a:ee86:b0:249:8963:c6b with SMTP id i6-20020a17090aee8600b0024989630c6bmr3218872pjz.18.1681950032896;
        Wed, 19 Apr 2023 17:20:32 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::11e9? ([2620:10d:c090:400::5:b0fd])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090a638900b00246fbf416dasm95200pjj.14.2023.04.19.17.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:20:32 -0700 (PDT)
Message-ID: <9561fe37-27a5-6a89-46e9-7b49b5afd334@gmail.com>
Date:   Wed, 19 Apr 2023 17:20:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Update doc to explain struct_ops
 register subcommand.
To:     Quentin Monnet <quentin@isovalent.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
References: <20230419025625.1289594-1-kuifeng@meta.com>
 <20230419025625.1289594-2-kuifeng@meta.com>
 <CACdoK4JFQFdFwXXq9UTwfEXGPEDaUjE0FYFAqQDkRt2Rs_b6NQ@mail.gmail.com>
Content-Language: en-US, en-ZW
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACdoK4JFQFdFwXXq9UTwfEXGPEDaUjE0FYFAqQDkRt2Rs_b6NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/19/23 16:44, Quentin Monnet wrote:
> On Wed, 19 Apr 2023 at 03:56, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> The "struct_ops register" subcommand now allows for an optional *LINK_DIR*
>> to be included. This specifies the directory path where bpftool will pin
>> struct_ops links with the same name as their corresponding map names.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
>> index ee53a122c0c7..2111c9550938 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
>> @@ -51,10 +51,14 @@ DESCRIPTION
>>                    for the given struct_ops.  Otherwise, it dumps all struct_ops
>>                    currently existing in the system.
>>
>> -       **bpftool struct_ops register** *OBJ*
>> +       **bpftool struct_ops register** *OBJ* [*LINK_DIR*]
>>                    Register bpf struct_ops from *OBJ*.  All struct_ops under
>> -                 the ELF section ".struct_ops" will be registered to
>> -                 its kernel subsystem.
>> +                 the ELF section ".struct_ops" and ".struct_ops.link" will
>> +                 be registered to its kernel subsystem.  For each
>> +                 struct_ops in the ".struct_ops.link" section, a link
>> +                 will be created.  You can give *LINK_DIR* to provide a
>> +                 directory path where these links will be pinned with the
>> +                 same name as their corresponding map name.
>>
>>          **bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
>>                    Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.
> 
> Thanks! Since there are some nits to address on the first patch
> anyway, would you mind updating the command summary earlier in this
> file as well, please? In section "STRUCT_OPS COMMANDS".

Sure!
> 
> Thanks,
> Quentin
