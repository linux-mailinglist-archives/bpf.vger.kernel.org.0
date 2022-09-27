Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A95EC476
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiI0NaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiI0N3u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 09:29:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926C3A17B
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 06:25:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r10-20020a1c440a000000b003b494ffc00bso1307903wma.0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eL2LIbrZcXYmMirAxjDn3ei7GKydK6GgEgWaueNtzEM=;
        b=SdHvbODbVznGMB+Gcmxf3LX53CNKTgr9AUuz3Iqk6kRc8/uTejguyZg9SFvxCplA22
         sfGDSsaSoSdnJuP/h854+1wJPeUjoYq/X7sFRhVSGA9QUDMYdUmzyHkCSwUNG21d1Z2J
         6l0fm2o7zEP1l4wEJZAuTc3+zF6S7vdHJLv9AP72eu03Mz4BAkWmz6VM8136YYiNTF4N
         THJVGePG9EMu/NkFA7Ojf58vE26RvGkUCfhl/GKOAlJQhw/5xjx5SjX6Drv6hsyHs6Uz
         Gq5Tzon0kuJt1g7Sq5RyWvXeYEHDSgGZ5gdbKRzPjdZBUNGcDb5hc96YaUy0hu6wH8M0
         Y0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eL2LIbrZcXYmMirAxjDn3ei7GKydK6GgEgWaueNtzEM=;
        b=xv9jSYpN67b1EzSwLXbkI4wNfQz9/Is/wF3HtvGqwTULmGusfcvM2M3StcjUV1RNYZ
         p2X6Qgf0rvjiylLf3mH8ENCSuC0AXkbWffr8igBCM5Q6zHSDBflsgKn8Ih+yLI7leGXU
         guUfegS96D5SrlsY5BiIgaY97QI268BMQKgqpWBFtn5qt5RdNQRhmYBZ8WK6aWK2hxFL
         dTVt6qCQCAwHrpWyTmxiFq3yga4TGh0lAKrigKlCF8GC2ujxYRvmjkaLZcjaKq0dwBw3
         YHrRwLYCj4bB6m092Vzuy9TUgiPg9QD4mQAsZV3EDRX0npfGP58xgpLKzgaVb6DhbaCY
         lm8A==
X-Gm-Message-State: ACrzQf1NZasuRmkavAR6xyuITm0pJF6YkHHKySimT+66SG5UMi9fDsic
        F2CCEir5eljb+ZbQU0+PckolhA==
X-Google-Smtp-Source: AMsMyM6Z956HEU/BOWsM16KlRty4TDUMOirmA4lMzBBTmjlPMJShldhPUFjsJwbLrPnrjMWeSD5GOA==
X-Received: by 2002:a05:600c:1694:b0:3b4:6205:1f95 with SMTP id k20-20020a05600c169400b003b462051f95mr2787840wmn.151.1664285068837;
        Tue, 27 Sep 2022 06:24:28 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b0022ae59d472esm1743554wrq.112.2022.09.27.06.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:24:28 -0700 (PDT)
Message-ID: <a220f2d5-5f00-4bbc-0fd7-68404a6027cd@isovalent.com>
Date:   Tue, 27 Sep 2022 14:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        Jiri Olsa <olsajiri@gmail.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
 <YwNhabqHEq3PfNM8@krava>
 <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
 <75986095d7ada2b24784ef356abc6ce17307575d.camel@huaweicloud.com>
 <YzLq5uar4dZlT1s6@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YzLq5uar4dZlT1s6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tue Sep 27 2022 13:21:58 GMT+0100 ~ Arnaldo Carvalho de Melo
<acme@kernel.org>
> Em Tue, Sep 27, 2022 at 09:14:34AM +0200, Roberto Sassu escreveu:
>> On Mon, 2022-08-22 at 13:24 +0200, Roberto Sassu wrote:
>>> On Mon, 2022-08-22 at 12:58 +0200, Jiri Olsa wrote:
>>>> On Thu, Aug 18, 2022 at 02:09:57PM +0200, 
>>>
>>> [...]
>>>
>>>>> In verbose mode, of if no group is defined for a feature, show
>>>>> the
>>>>> feature
>>>>> detection result as before.
>>>
>>> Thanks Jiri.
>>>
>>> 'or' instead of 'of', if the patch can be edited.
>>
>> Hi Arnaldo
>>
>> will you take these patches?
> 
> The tools/build one I have in my perf/core branch, for v6.1.
> 
> ⬢[acme@toolbox perf]$ git log --oneline --author roberto.sassu@huawei.com tools/{build,perf,lib}
> 924b0da1154fa814 tools build: Display logical OR of a feature flavors
> 1903f4ac2f3a6d33 tools build: Increment room for feature name in feature detection output
> 48ab65e0fec644b4 tools build: Fix feature detection output due to eval expansion
> 5b245985a6de5ac1 tools build: Switch to new openssl API for test-libcrypto
> dd6775f986144a9e perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
> 629b98e2b1c6efcf tools, build: Retry detection of bfd-related features
> ⬢[acme@toolbox perf]$
> 
> Quentin, may I pick the ones that touch bpftool?

Would be fine by me, although I'm not the one merging bpftool patches to
bpf-next (Alexei, Andrii or Daniel do it).

But for the current patchset I think there's nothing touching bpftool
directly, you already have all three patches in your tree as far as I
can tell

Quentin

