Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E861A6FF
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 03:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKECtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 22:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKECtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 22:49:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E332BA7;
        Fri,  4 Nov 2022 19:49:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p21so6485024plr.7;
        Fri, 04 Nov 2022 19:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pCZUtImMP6Y9v8RvQgK/gK5IankekxGbe+sVwjQCcA=;
        b=ERSC7+xBTi2ym32kVnWb1NgDWhe1sT9pXaSukeevromfc69yq1AOQ61rDDC/7+UqJi
         maCYKRf+LiD6PS+SBU+K1F+ka8L64VMD+ivV++mDLtBsP4/+/d6+u55qaoET9ucBqsgn
         dEEv+2LsCSVv36o+N5UcwgIaG+0f1fKcZnpCWAdSaAxMY7Z0z20oDb7gbzCPXQ4sRwMb
         h2+FvailYiUvNp9Cj1bR7PyoFUhdrNHdxw8N3f/r6iqQHKBQMcovtHBrausse07q5Au5
         yNri+GirVBEVaoBgEo2lpEwLKpEP592Us38n0n5CwA6iu4+ngTD+30vSxMWT3tNC0Hw6
         UbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pCZUtImMP6Y9v8RvQgK/gK5IankekxGbe+sVwjQCcA=;
        b=toi8ZsRJNIodGeMuvPDAsgUwoA0ihBF1sPev8ytep4GoIXHApM8fSqxCPyzj2PWZHd
         AyRJqh6Lbpmh1wmVWpBj0vn7zax7NBsez0nciTpTDfDMP1T5ip8myj8a3Qo2mPEBrCsp
         dlI3dkoje4S493GWsnnzTxlQ+CIf2Ju0J63nZhrXxoa4zawFVJuUNYol4ToDSJx+d4ET
         r0Erdrc5IXPwqCTNDInJUFUD3m54BBjDQojBMf9ej4CjZGazDoYBOHW1ZAqg0IO4bKj8
         02LWA56m5VUldwLIxBb5SddOJy1vzl8Srdbv1xWRSJKOcOqh/7pOwdoY1avEi29Gl1Fe
         5vSg==
X-Gm-Message-State: ACrzQf2AtdDaU8NlgjRNI4ldj3YbdwohH+qbHQLCcfC9gr/ULVirLLM4
        +KYzpH+turHKS5wQKaS2zDs=
X-Google-Smtp-Source: AMsMyM6DKr9bfVtIOkix/5xJSQPGTXgi68HuZ2lt8a3EuSOWUEBZw6YKb4MUAELDG65Ml3fJNuHodg==
X-Received: by 2002:a17:902:e54e:b0:187:ba9:4305 with SMTP id n14-20020a170902e54e00b001870ba94305mr34667373plf.167.1667616549618;
        Fri, 04 Nov 2022 19:49:09 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-85.three.co.id. [180.214.232.85])
        by smtp.gmail.com with ESMTPSA id y13-20020a63fa0d000000b00460c67afbd5sm411091pgh.7.2022.11.04.19.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 19:49:09 -0700 (PDT)
Message-ID: <71f54713-4cce-9da8-e73d-9f5e78346971@gmail.com>
Date:   Sat, 5 Nov 2022 09:49:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF
 type name prefix
To:     Akira Yokosawa <akiyks@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, sdf@google.com,
        song@kernel.org, void@manifault.com, yhs@fb.com
References: <CAEf4Bzau0QuBiNsXoMq_QRV+_MTyodQsvW7O2kbScgmVmbuXkQ@mail.gmail.com>
 <1c8a0445-ee7d-991a-2ec8-cdc29204c68a@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1c8a0445-ee7d-991a-2ec8-cdc29204c68a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/5/22 07:05, Akira Yokosawa wrote:
> Hi,
> 
> On Fri, 4 Nov 2022 16:11:10 -0700, Andrii Nakryiko wrote:
> [...]
>> Applied, thanks. But would the other similar case be problematic?
>>
>> $ rg 'bpf_\b'
>> bpf_design_QA.rst
>> 329:NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
>> 331:avoid defining types with 'bpf_' prefix to not be broken in future
>> releases. In
>> 333:with 'bpf_' prefix.
>>
>> libbpf/libbpf_naming_convention.rst
>> 12:following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``btf_dump_``,
>> 59:described above should have ``libbpf_`` prefix, e.g.
> 
> Those other cases are all inside double back quotes and
> construct "inline literal" strings. So they are fine.
> 
> Which means Bagas could have used the "inline literal" approach
> instead.
> 

Ah! I was oversighted (not seeing these other cases). Should I convert
fixed 'bpf_' to inline literals?

-- 
An old man doll... just what I always wanted! - Clara

