Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46EA5A3E0A
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH1O3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiH1O3V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 10:29:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0E1D304;
        Sun, 28 Aug 2022 07:29:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s199so7746292oie.3;
        Sun, 28 Aug 2022 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3avCbfvZdoE1ib3BBn4Yj1SFoc8ZfcI+yju4hXTdg8w=;
        b=hDnACDUvVLjbdaNT5D/WFt+OMyo51EnTEsYmkoYYSXjoDOwUZ3Dyoj2r9FuiMXWmre
         /nVi8b5AJvOtpyZB2q0xHSESOznsbeLmQCgdp1mc1ETDpYqD3pB16oA+mDVtC+lRxXY0
         jE/DPiFTKfs9eyfn89zEQByQmv32+0a2vfpPJhykp6Fay9rhan5Ox9Acj1uYRTG7fi2/
         qZgxhPDbs1V2MkTAclskZGC8bweH8yDqKiESgzxwImsXLTy1ZjSMzfJeHJW6uJ4/RFbg
         PPxopp+NYEeFtBtvFzTbSlsiHqX3DvRMGQcCVa5KhcCTdeqjH7tMW8mF0jgatcU6fyjP
         fDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3avCbfvZdoE1ib3BBn4Yj1SFoc8ZfcI+yju4hXTdg8w=;
        b=cxLe+b2k66NjVZcTaxiiPuMet7ynfjFBprl5g+TTzsYYA9bZYST36ePunftl55zSzp
         a/j4Q2790afGxsFK0KDqAkHr/a/Dj2jMCjzG4wa5yXe2Sz8NLxYc6y4z12+OlFAwu3aY
         iGpM8+v47kY2zcRCEfUrNE4QKeEvTp4erJhfWM50SCiB3O3GFNy6frF8li5IvCASdzqj
         wgPtLGOroYQBGVi+1BpBXo4T+o8q7BLuGYVLbociifH+ppzhDK5uR6ce5yUTe19EBYSb
         k3aOH6Z2xbYwTyNBg0C1TB2fCK3jBadBu21B6sX/nDYRuQ7XEtVTcQ8mB1GMzRwz+wtE
         useQ==
X-Gm-Message-State: ACgBeo2LV/GgZoBBFep4mHfn2MBeBE/12Z4HjFkuv72QXH4dA0qrwRWY
        65ZeTDtSXkroE7aJKpnWZoM=
X-Google-Smtp-Source: AA6agR6sZ8/0DWNP9brI9oAK91gSvRP1pMGJzrptEBvQ4knNPrkwfvbFrj+vZVdTWJfhQFoT2VmkgA==
X-Received: by 2002:a05:6808:1d9:b0:344:a080:7e83 with SMTP id x25-20020a05680801d900b00344a0807e83mr5738894oic.86.1661696959894;
        Sun, 28 Aug 2022 07:29:19 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q22-20020a056870e61600b0011c65559b04sm4795065oag.34.2022.08.28.07.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:29:19 -0700 (PDT)
Message-ID: <b783998f-366b-5643-7347-3cf47269ffc8@gmail.com>
Date:   Sun, 28 Aug 2022 11:29:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luna Jernberg <droidbittin@gmail.com>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
 <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
 <YwY3qEa2gFsPg2jz@kernel.org>
 <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
 <538ebda0-0f8a-ebae-f02f-c8f8736ca12b@gmail.com> <YwsbYX3g5dvaRABt@krava>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <YwsbYX3g5dvaRABt@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/22 04:38, Jiri Olsa wrote:
> On Wed, Aug 24, 2022 at 07:50:39PM -0300, Martin Reboredo wrote:
>> On 8/24/22 11:38, Luna Jernberg wrote:
>>> https://forum.endeavouros.com/t/failed-to-start-load-kernel-modules-on-boot-after-system-update-nvidia/30584/17?u=sradjoker
>>>
>>> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>>>> Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:
> 
> SNIP
> 
>>
>> Can you try a build of the kernel or the by passing the
>> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> 
> Martin,
> could you please send formal patch this?
> 
> thanks,
> jirka

Sure, sure! Though it might take a bit of time due to being my first
contribution submitted by me (I've already contributed through the Rust
patches though), I'll add Kconfig entries for this, one for the
availability to skip the enum64 encoding and another for toggle the
flag. Stay tuned.

- Martin Rodriguez Reboredo
