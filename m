Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12357465C
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiGNILF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 04:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGNILE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 04:11:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24622B190;
        Thu, 14 Jul 2022 01:11:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so7752254pjr.4;
        Thu, 14 Jul 2022 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bIXAVB8I8ROQODsmmKeLMFK2VbCiCoPk46ijuVpDRLE=;
        b=bX/PvdK0iWhA+6NrxXrInHRc+qvbiEfelilGWWqwQjgQzMUnoF6NDAl5D807Ve77B8
         vNlv6KbmzTRLAFCI8E02lbSESfHJ2dkY3+/S3bhdJTSLwUh7tCD5q81AxFnUlPlRySgn
         hb0wYd7/WjGXskym9dizQ6VGYBjjEqUn+5XrfQx6lGgVlwY0DGGCdFv/hdRoc0mQUl4N
         Reo+afrxFqVT5fWgPrzXUxWZmYWqrvxTaKnmciqYcBh422pbBU9mvV4ULVmXpDSTii3h
         qjGWuwwYwmDAbU8/Icd7v/qYvl7oHmvO8w5g9+JYqatli5vpkfkMlhFI6WoMWQ/hWyoZ
         EIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bIXAVB8I8ROQODsmmKeLMFK2VbCiCoPk46ijuVpDRLE=;
        b=Vq9p8XryEtX3Z3bI0e6HwFmGl3skhALvCBwCbMAw6r6fYNSZJyLmG0fCkQ5Ef19ES+
         /t4OGwek5zxvQKyN2MfdhBzNiN2Tf7Lfck1sdJRQQeyKCmdOTVJipNp73cww2Y8ipycl
         yz/EroOXKsAItEoXcqeOxMT5oAEK3nsBx1ltoafpKbdmunkVqS+JSvaIEd4+06V8v4dJ
         uP8Aer7N6LefPJHk2zayWoYzCGVebLlMSNH1iao1rHr4rFv2oqcRqGyd7mPl6oVVvLr3
         sAOuH9WDo5mZvaP/tFSyUK4AYngErtLc62VQ/7e3P1wiSiv1o9AlvU8Lpe/GCGGtB8qw
         ZNRA==
X-Gm-Message-State: AJIora9XsSVINirX8xbiKJrV3Mnc6R3tCfKok0DFXlJpYw6e3wAn0q/J
        lkRw4agIn32ihSkqQYUfbkg=
X-Google-Smtp-Source: AGRyM1uMe9azVMy5q0a4JiCqLwq96lNXH8Ahpxp6f6cPLXc5EIeN0yWDUF3bPx9Bi0Pw8M3yIt1/aw==
X-Received: by 2002:a17:903:40cf:b0:16c:6c93:9734 with SMTP id t15-20020a17090340cf00b0016c6c939734mr7720124pld.98.1657786263436;
        Thu, 14 Jul 2022 01:11:03 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-29.three.co.id. [180.214.232.29])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a784500b001ef84cd54b2sm2988734pjl.19.2022.07.14.01.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:11:02 -0700 (PDT)
Message-ID: <5fd3bc40-61f5-e7bc-6178-cb50b3af4042@gmail.com>
Date:   Thu, 14 Jul 2022 15:10:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20220713211612.84782-1-donald.hunter@gmail.com>
 <99351eee-17b4-66e0-1b9e-7f798756780a@gmail.com>
 <20220714055137.dsatpuyrwdlel2ck@vaio>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220714055137.dsatpuyrwdlel2ck@vaio>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/14/22 12:51, Daniel Müller wrote:
> On Thu, Jul 14, 2022 at 08:12:57AM +0700, Bagas Sanjaya wrote:
>> On 7/14/22 04:16, Donald Hunter wrote:
>>> This commit adds documentation for BPF_MAP_TYPE_HASH including kernel
>>> version introduced, usage and examples. It also documents
>>> BPF_MAP_TYPE_PERCPU_HASH, BPF_MAP_TYPE_LRU_HASH and
>>> BPF_MAP_TYPE_LRU_PERCPU_HASH which are similar.
>>>
>>
>> Please, please use imperative mood instead for patch description
>> (that is, better write like "document BPF_MAP_TYPE_* types").
> 
> Can you elaborate why you make that recommendation, please?
> 

From Documentation/process/submitting-patches.rst:

> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.

The recommendation above is from commit 74a475acea4945
("SubmittingPatches: add style recommendation to use imperative descriptions")

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
