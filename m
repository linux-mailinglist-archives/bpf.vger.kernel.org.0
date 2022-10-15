Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB05FFBA7
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJOScl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOSck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 14:32:40 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8584CA01
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 11:32:39 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-131dda37dddso9474965fac.0
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBOd8I2xebBh4gaXcfn4JloiF2jE4gZV7pvsHD8EQvI=;
        b=gh8KjtpzU5iqb4rF5UiaGnwNeXEcdHSYuOURVW23wwHYMLL442Pqx/u8t//2nmUpmf
         hE8/ja8sB7eOE+N4VcZb2I2pnonMP9ZmoFljolpfF32RF3yM7Z0610uGHdjfuj2AJxn/
         ock/cXF2pRElCo/XcTASBYTT0KGm80+crAsjsqumBvR7OF+LNO6IIu40mDtAzqgspFvn
         iD3nzR9nPBToB3gOSJIaGfRQwb3uP/L0cUvKvtnj32UFLAV4PhuHOYWXVjx336WWNhGU
         V/Fv9beiXWQksgermu+CPKRS/EqscEpEcJe12pA7Y9NAEnC0ClR5Rx/1rZIGs9GZREi9
         sEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBOd8I2xebBh4gaXcfn4JloiF2jE4gZV7pvsHD8EQvI=;
        b=Xijj4yMwi42Pmn9tLl7JMqhqZkoK92IAqrJUVSPm04OitlG9WyB8qKgtinbjUf0Pvn
         wPeXckNSVUZocWrkAWf3fCCBs3jlzl1pW8weSIvga/4z7j0JyQlbbEukb6WdQ50WE6L3
         aY7tXZSGMcE0Glpv6uB8Ywnc8qbb5No7to8z2sDkJiKXbRqPajHeFhQxK5EeUpVzNlpO
         VHGBmcNO0A18UBa2viX1U/zjuiC3Yw6lS1h1EHIbHAEEFeVFImAQ0YF/zKzqs2wFF0pu
         k/SV4WQLwcHgQiQNNl7AGb/acvCMn2G7Th148bYMdJYSKhhNVd+WxCMStwNVqIMCKwZ0
         1YXw==
X-Gm-Message-State: ACrzQf1xLNrnV5ULRqKToKi9v9t4fuADOFga8wdFaKlxM94sQJu6sJj4
        Y8g3K39HoF6n6fXOHlWPDBQ=
X-Google-Smtp-Source: AMsMyM7ZS3Jkw43Rl15ioaLIGNNP61QGuxZZSTpMik2UPVx+jpS4hKmV1NA+C8HFGjRtfiDeFIh5ww==
X-Received: by 2002:a05:6870:889f:b0:137:551d:4742 with SMTP id m31-20020a056870889f00b00137551d4742mr1864915oam.39.1665858758506;
        Sat, 15 Oct 2022 11:32:38 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z139-20020a4a4991000000b004767b38dbf4sm2373014ooa.24.2022.10.15.11.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 11:32:37 -0700 (PDT)
Message-ID: <597a1300-d29f-1daa-31f3-aaeee944105a@gmail.com>
Date:   Sat, 15 Oct 2022 15:33:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [kernel] 5.10.148 / 5.19.16 - pahole 1.24: BTFIDS vmlinux,FAILED:
 load BTF from vmlinux: Invalid argument
Content-Language: en-US
To:     =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>,
        bpf@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Bernhard Landauer <bernhard@manjaro.org>
References: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/15/22 13:48, Philip Müller wrote:
> Hi all,
> 
> I just got the following error for 5.10.148 and 5.19.16 when compiling
> with pahole 1.24 on CONFIG_DEBUG_INFO_BTF=y:
> 
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> make: *** [Makefile:1168: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'
> 
> similar to:
> https://lore.kernel.org/bpf/20220825171620.cioobudss6ovyrkc@altlinux.org/t/
> 
> For 5.19 I applied the following patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/plain/releases/5.15.66/kbuild-add-skip_encoding_btf_enum64-option-to-pahole.patch
> 
> I wonder what is needed to get 5.10 kernel series compiled and if 5.19
> really doesn't support enum64.
> 

This was buried for a month or so but I think it might fix the issue for
5.19

https://lore.kernel.org/bpf/20220916171234.841556-1-yakoyoku@gmail.com/
