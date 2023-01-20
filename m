Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0D675CCF
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjATSfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 13:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjATSfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 13:35:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB67A19A9;
        Fri, 20 Jan 2023 10:35:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so9911120pjm.1;
        Fri, 20 Jan 2023 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hAZdbE/uN4m+/i3D24ZXZKDjXUWi616Ji8kVqBjQ08=;
        b=o85/ykBqIKazV0F0R8e7F042HSqj+iNcf6IEg6SnRPd7W+9jYtoP93D+9ii8cRURlZ
         HLh8sjop+jruR4JIyAJ6C+uqYdtNfDPmL0laOR8TB9WtsIAB1W/5MfH1ew9TKUu82QLP
         ZPcGsI/3V8J82ZhfpnFCVvu1aLwvgFJvC2lzZMV+EkxyENJRdQTnWPP2zZEiwH2H71tj
         481H6EmvzdOuSnbgeivGfqnBLI3YSG711TaCWrAUj/ZcyPzutNZv4hb7P35HezH/alWg
         NS80v+0PNVBWhOYKotXZ+UXJgvdMPFSS3os2m2DeO7Icd/ISTcC+VpHKq8ZL6aMlSKZZ
         LX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hAZdbE/uN4m+/i3D24ZXZKDjXUWi616Ji8kVqBjQ08=;
        b=H94+3o9FPJGdUHCQVyHkUUNVIU18uwasb3ro4u4R/yMHxtOR35+5c1M70aPMewRCV2
         yZgO1eENDIEoPnVMhIXg+LUGjnJa96Z5+BPbQ6AYdtV8WWXKYu7ZeKoV02YjImEqHNp6
         uS4lylQkDllvG74cqKymVtHr+wzyPWUX7XdaEJo5MZwpwX3TakwurvG97SQGdBnOaWX7
         gY3zV+E091m+8OcXGlexMPU1gS1EQlZS5GukSJHgc51plkbeQUPmpTixs8X3NbaQOgLg
         S40iDxd7EhhSldk9nXaMLK0HQfM+hXSb0xIcSMju/8H0iUlYBhHCo+M38ki/dlh3Svvm
         ebZQ==
X-Gm-Message-State: AFqh2kqYlpjQnhF8hhx8e3oXf7hdl/uJEYpGmeZajyUhmsuDnBfZ8tG5
        QGUMFmuMBs9DHgwuXXKMK54=
X-Google-Smtp-Source: AMrXdXsZ1g5OZwLjXfHmaIkwrVMSy8wBTsedCYDL8PbG0/g5L1dXnZdIqI+Yw0PL8DsVlHjKF1XZAw==
X-Received: by 2002:a17:90a:4e4c:b0:228:cf57:32c1 with SMTP id t12-20020a17090a4e4c00b00228cf5732c1mr16855921pjl.0.1674239704861;
        Fri, 20 Jan 2023 10:35:04 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::13b1? ([2620:10d:c090:400::5:c08d])
        by smtp.gmail.com with ESMTPSA id a4-20020a63e844000000b004b6c3d7aa21sm15961206pgk.8.2023.01.20.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 10:35:04 -0800 (PST)
Message-ID: <9bf988ba-3f16-a402-2110-107cebfa7025@gmail.com>
Date:   Fri, 20 Jan 2023 10:35:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 2/4] security: Generate a header with the count
 of enabled LSMs
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <20230119231033.1307221-3-kpsingh@kernel.org>
 <5e99e2d6-30a8-ea94-d911-de272a2a0a69@schaufler-ca.com>
 <CACYkzJ5LwLD_yo=b5MMvpDUBGJ_puzr2TLYEK-DR3NRDRwgSLw@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACYkzJ5LwLD_yo=b5MMvpDUBGJ_puzr2TLYEK-DR3NRDRwgSLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following idea should work with the use case here.

#define COUNT_8(x, y...) 8
#define COUNT_7(x, y...) 7
#define COUNT_6(x, y...) 6
#define COUNT_5(x, y...) 5
#define COUNT_4(x, y...) 4
#define COUNT_3(x, y...) 3
#define COUNT_2(x, y...) 2
#define COUNT_1(x, y...) 1
#define COUNT_0(x, y...) 0
#define COUNT1_8(x, y...) COUNT ## x ## _9(y)
#define COUNT1_7(x, y...) COUNT ## x ## _8(y)
#define COUNT1_6(x, y...) COUNT ## x ## _7(y)
#define COUNT1_5(x, y...) COUNT ## x ## _6(y)
#define COUNT1_4(x, y...) COUNT ## x ## _5(y)
#define COUNT1_3(x, y...) COUNT ## x ## _4(y)
#define COUNT1_2(x, y...) COUNT ## x ## _3(y)
#define COUNT1_1(x, y...) COUNT ## x ## _2(y)
#define COUNT1_0(x, y...) COUNT ## x ## _1(y)
#define COUNT(x, y...) COUNT ## x ## _0(y)

#define COUNT_EXPAND(x...) COUNT(x)


#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
#define SELINUX_ENABLE 1,
#else
#define SELINUX_ENABLE
#endif
#if IS_ENABLED(CONFIG_SECURITY_XXXX)
#define XXX_ENABLE 1,
#else
#define XXX_ENABLE
#endif
....

#define MAX_LSM_COUNT COUNT_EXPAND(SELINUX_ENABLE XXX_ENABLE ......)

On 1/19/23 18:15, KP Singh wrote:
> On Fri, Jan 20, 2023 at 2:32 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/19/2023 3:10 PM, KP Singh wrote:
>>> The header defines a MAX_LSM_COUNT constant which is used in a
>>> subsequent patch to generate the static calls for each LSM hook which
>>> are named using preprocessor token pasting. Since token pasting does not
>>> work with arithmetic expressions, generate a simple lsm_count.h header
>>> which represents the subset of LSMs that can be enabled on a given
>>> kernel based on the config.
>>>
>>> While one can generate static calls for all the possible LSMs that the
>>> kernel has, this is actually wasteful as most kernels only enable a
>>> handful of LSMs.
>> Why "generate" anything? Why not include your GEN_MAX_LSM_COUNT macro
>> in security.h and be done with it? I've proposed doing just that in the
>> stacking patch set for some time. This seems to be much more complicated
>> than it needs to be.
> The answer is in the commit description, the count is used in token
> pasting and you cannot have arithmetic in when you generate tokens in
> preprocessor macros.
>
> you cannot generate bprm_check_security_call_1 + 1 + 1 this does not
> get resolved by preprocessor.
