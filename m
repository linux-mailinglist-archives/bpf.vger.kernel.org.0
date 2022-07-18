Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D16577E23
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiGRI6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiGRI6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 04:58:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4941EE12
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 01:58:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e15so10778446wro.5
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E5qdVtAhGRk9dSRPIpuKvbfIP1OxLhlEWe0abgwTtSA=;
        b=4nxDEs2aiLrsLpvWR3HrH4FNVSVRUnjBFLcpzM52zETeC5jvrDgxU61orz8kH6U0cQ
         tGoULePrb1J9FS+z0psoRnbYjXF0cHN1s6Q6/7ckh/Q3iuzXAzYo1zuLZhdyLBEK+DrN
         H3YNEFnn+YcumstvNVbVZA8bifj7W/DaUUE/MYo+HP72LvPf8Wv6VDUhkFRuDU5fDLOW
         0LJKbHDOpUDREOY73BbHNmkqou8WMFsMZc/VQYPR6CrZ+RjHnrV97JDv+D46SO1+2Ayb
         4dEZw++GWyOwx1T7yjNjLoPoMv3mq2YMFT9l+BVk+8aNW0gP2CXZD45Gk4tBY7s2za+e
         p2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E5qdVtAhGRk9dSRPIpuKvbfIP1OxLhlEWe0abgwTtSA=;
        b=WTmCCpYJ5lOfd6RuTtuZWHcCy7hh7n44pZ6FsTGylg0w3I+Ct+AMjccDv2j+2qxCec
         n7IeaEh4NmeUkCLbhSoEuKEsShUeFMhFxcoqD7deELFVMj7Vw0aWR+e/U7Hm1rVDk2QE
         YxDZQ4XQbh8vYhfsJgofNmF4hzrJvq7fjazVVTdjEBTqTQUOuauz2kGYUUXioXk5n318
         UF437M/Rn9yngkxObE9KKNtqvTbpnahMnopSgokLyFQ5jvk0LpA9m4t2hL90HnMYZTpM
         8UghIvhdY4TErYkVzF4oQ4ZTai0HGS7TxBv5wW5jjWvgz1Sl0I7/ASjspjM+9DGcOzFG
         HXdA==
X-Gm-Message-State: AJIora/tSTABMQwNUn3fq2+QtW/e/Rxp5oMlY4BzG0g2VU2aqgdZnPse
        u62oJYGukbABjM7N+U8IFiqa9Q==
X-Google-Smtp-Source: AGRyM1vc8DxxCp7n8iwjDgenX88lzvKjHTVcXeqNlOd7CHRhQwQPdM0ASkYMRKPA3NBNbLsmA6bhlw==
X-Received: by 2002:a5d:414b:0:b0:21d:6e93:59c8 with SMTP id c11-20020a5d414b000000b0021d6e9359c8mr22359056wrq.290.1658134723332;
        Mon, 18 Jul 2022 01:58:43 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b003a31d200a7dsm1750376wmq.9.2022.07.18.01.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:58:42 -0700 (PDT)
Message-ID: <2d2e60d9-f340-4c2d-e123-a858c46fae16@isovalent.com>
Date:   Mon, 18 Jul 2022 09:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2 2/5] tools include: add dis-asm-compat.h to handle
 version differences
Content-Language: en-GB
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <20220703212551.1114923-3-andres@anarazel.de>
 <fc1be6d4-446b-2b34-21cb-5e364742c3a2@isovalent.com>
 <20220715193927.x6xy4h7n5rrh2ndc@awork3.anarazel.de>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220715193927.x6xy4h7n5rrh2ndc@awork3.anarazel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/07/2022 20:39, Andres Freund wrote:
> Hi,
> 
> On 2022-07-05 14:44:07 +0100, Quentin Monnet wrote:
>>> diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
>>> new file mode 100644
>>> index 000000000000..d1d003ee3e2f
>>> --- /dev/null
>>> +++ b/tools/include/tools/dis-asm-compat.h
>>> @@ -0,0 +1,53 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>
>> Any chance you could contribute this wrapper as dual-licenced
>> (GPL-2.0-only OR BSD-2-Clause), for better compatibility with the rest
>> of bpftool's code?
> 
> Happy to do that from my end - however, right now it includes
> linux/compiler.h, which is GPL-2.0. I don't know what the policy around that
> is - is it just a statement about the licence of the header itself, or does it
> effectively include its dependencies?

My understanding is that programs using a GPL header need to be released
as GPL, but I don't believe they have to be only GPL, the dual-license
should cover the requirements. If someone wanted to redistribute the
code from the new header dis-asm-compat.h as BSD only, they would
probably have to get rid of the GPL-only dependencies though. But again,
this is only my understanding, and “I am not a lawyer”.

> 
> FWIW, linux/compiler.h is also included from bpftool.
> 
> If preferrable, I can replace the linux/compiler.h include by just using
> __attribute__((__unused__)) directly or by using a (void) cast to avoid the
> unused-parameter pedantry.

If compiler.h is just needed for the “unused” attribute, I wouldn't mind
doing that.

Thanks,
Quentin
