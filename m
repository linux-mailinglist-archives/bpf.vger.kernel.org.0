Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D967D44F
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjAZShW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 13:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAZShW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 13:37:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5A4CE47
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 10:37:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 143so1655868pgg.6
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFAiPLiFU/rodTkORQwWQ/q6KaNDoWVYL8A/bvpkF8I=;
        b=mc+8vJWxCiiM1C7mq4oN1E29RSQQbB0sXRmHHhhgbzPennDAnlyNWqOzietyqGyYKz
         JsHdFLjLrTN7cgLqacFJeHabmWGw3zK8AESopU56GBSLtyR2YAzAKAeRMBg3F04H8i8J
         feXzH40csKoRkYAkG3uTftHdyGBFSKOzBAlnI2LJRv8e7BD9BxUbgpm7aL0z/d/+FMaS
         5lPL4nheShvkrtavIejyxgf426f4gqHaW3avvrYWYhXzoL75bvyIwjlGLM6V89FP2Jwy
         zewUbVHWR746AR55CkIQyYsHBWKjNcmJnApMsBim+mPq2be5fmfdqKLdMcVJhCwNiHwl
         AYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFAiPLiFU/rodTkORQwWQ/q6KaNDoWVYL8A/bvpkF8I=;
        b=cydeA4n11ztof9923RIlsRnns4CD+MAiMBnBBJQLJTlhDpGoVyvgbHIwr0bSX4R1oF
         QRRMcjPXIVe4S+9ns5pmu9CzV/j/cZhqu5Zf15Rj79lWR/9QtM2RZzjifvXcImDTPrJO
         wUzZCuvxiBbYUDL9G6XlaBK7/5BNBRpM+/lixirQOt9atr7E2kvZJ3oWTYIJzDgoXlol
         EKG27iNz+g1KMGxK800lHzmpPFYSXEoxpQpibiHbhVlhekyeztiy02vTAS3Qn2W/MV2c
         6hd9daApkqoisOpacXBvQRRobURgguOvvtQvZlFlLTBi8JiD9mbsVeXxIia0rUvQDRc0
         XbxQ==
X-Gm-Message-State: AFqh2koGm9Yj33cIjTW12WHgUl3+Heksh77odeyIj8RrSQFcc6WIlnT+
        VTUf9y62yfKMF4bH4iPB0n4=
X-Google-Smtp-Source: AMrXdXu6bGTX71WFaSkSu5ihgGmyxHh1ZJMXlc+vwXxXu2Uh3Z6GZqEhK8aLdwMDpTbTJqpI/BgZbw==
X-Received: by 2002:aa7:8650:0:b0:574:cc3d:a24e with SMTP id a16-20020aa78650000000b00574cc3da24emr34526133pfo.5.1674758234002;
        Thu, 26 Jan 2023 10:37:14 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::13de? ([2620:10d:c090:400::5:80e4])
        by smtp.gmail.com with ESMTPSA id c74-20020a621c4d000000b005895f9657ebsm1152399pfc.70.2023.01.26.10.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:37:13 -0800 (PST)
Message-ID: <fab6cb2d-88e2-fe4e-4880-b26ebea041d0@gmail.com>
Date:   Thu, 26 Jan 2023 10:37:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH dwarves 4/5] btf_encoder: represent "."-suffixed optimized
 functions (".isra.0") in BTF
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, yhs@fb.com, ast@kernel.org,
        olsajiri@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
 <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
 <Y9F7Xt7Kt463kh6L@kernel.org>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Y9F7Xt7Kt463kh6L@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/25/23 10:56, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 25, 2023 at 09:54:26AM -0800, Kui-Feng Lee escreveu:
>> On 1/24/23 05:45, Alan Maguire wrote:
>>
>   ... skip ...
>> If the number of static functions with suffices is high, the contention of
>> the lock would be an issue.
>>
>> Is it possible to keep a local pool of static functions with suffices? The
>> pool will be combined with its parent either at the completion of a CU,
>> before ending the thread or when merging into the main thread.
> May help, but I think maybe premature optimization is the root of... :-)


It is true.  However, we already encountered the lock contention issue

when doing parallelization previously.  It is very likely to have the same

issue here.


FYI, I did some tests and had numbers in another thread.

https://lore.kernel.org/bpf/9d2a5966-7cef-0c35-8990-368fc6de930d@gmail.com/


