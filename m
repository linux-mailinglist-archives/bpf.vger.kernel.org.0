Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4D6C6B8F
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 15:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjCWOut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjCWOuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 10:50:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39846231C3
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 07:50:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13so21722897pjh.0
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679583020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZy+70BV5n4z9+gRA5AXuUdtWkCYobsdHEBs6+zexr4=;
        b=IMFSLq/bDjv4FxJdMQC7L84FdqSF2rv5t6zEYtaIxUqd253aeuyGLo2KwIFLUN1Mnr
         WiQR2AsConY9ny4oPn2m+laYiykxgf5Kf68G0PUiDQtJfwaw9dBDC8EFYMmi9xTKUDYe
         KlzWyVgN14zfRPe9NF20/kmYxsutEghmRp+YldQtEOb1l4eo5kKoE5uzfPlg9dw/MEhg
         omnXH49gr3D+1O4r0ZntEs5N/GX4FQ1xNqOycogVxyDkUwbvdqjp6yEaiO3Kb62RFxJ4
         scHcTRm8s4/aCxHFjhKED94omCCUZGAg4SFD8+a0MSteMI4yXHt8vgcsZhpaF8Cz8UZz
         63qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679583020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZy+70BV5n4z9+gRA5AXuUdtWkCYobsdHEBs6+zexr4=;
        b=pfqDapqT9Gn5k6JbT7P33V3A9Q5iEkqqhoYKno6vQQmG5GrwJg3UZfytq13tFn/ZQt
         xRag7LY+buCv7AUo8fe1aawGIBfDwUtoPH9ZKXqbCqjWE6Dym5B+VobJCrnMn8BBX9zI
         e5KI3vIzzd7HaHM9NCo0WB3ZB0x8LPSCrieFlXVtiiu8Ps/yvUGsBfoCSsyzv+BgItBJ
         hYLfpFiQRw+1iygRgr/G6xqKRfKPP15VQNiGn4tvETIwNNGJmos/b70vSAWvjinR2pyU
         z6n46lIBZtDcRwua18yKwZX1NnoA0E0lGYbmkAPOCtv6ZFT/Jvn73lPPCf41IsLR7Vlu
         Sypw==
X-Gm-Message-State: AO0yUKVxf8IVtSZE+h4gfo3Q2PDtuTrgi249ZJHkTysGqKdwhxJWwNsc
        g9LABgUos4vKQ//HcvioNFI=
X-Google-Smtp-Source: AK7set9fs1x0r+im0tB7wD/LJUk68130XQyLYDuDr1NUKpblV986ffuoS4zJ8WrDZVHFyahYxNWDqA==
X-Received: by 2002:a17:902:d413:b0:19e:d60a:e9e with SMTP id b19-20020a170902d41300b0019ed60a0e9emr5375113ple.42.1679583020627;
        Thu, 23 Mar 2023 07:50:20 -0700 (PDT)
Received: from [10.90.154.153] ([12.40.223.168])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b0019f1222b9f6sm12480110plb.154.2023.03.23.07.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:50:20 -0700 (PDT)
Message-ID: <5eff5077-9437-be24-3f5c-257190e772d4@gmail.com>
Date:   Thu, 23 Mar 2023 07:50:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v12 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230323032405.3735486-1-kuifeng@meta.com>
 <20230323032405.3735486-9-kuifeng@meta.com>
 <66f97e66-895c-1cb3-91e3-ac960ef098dd@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <66f97e66-895c-1cb3-91e3-ac960ef098dd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/23 23:05, Martin KaFai Lau wrote:
> On 3/22/23 8:24 PM, Kui-Feng Lee wrote:
>> +static void test_link_replace(void)
>> +{
>> +    DECLARE_LIBBPF_OPTS(bpf_link_update_opts, opts);
>> +    struct tcp_ca_update *skel;
>> +    struct bpf_link *link;
>> +    int err;
>> +
>> +    skel = tcp_ca_update__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open"))
>> +        return;
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
>> +    ASSERT_OK_PTR(link, "attach_struct_ops_1st");
>> +    bpf_link__destroy(link);
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
>> +    ASSERT_OK_PTR(link, "attach_struct_ops_1st");
> I fixed this up s/1st/2nd/. Also,
> added a 'if (!ret)' check before synchronize_rcu() in patch 2.
> massaged the comment in bpf_struct_ops_map_free in patch1.
> 
> The set is applied. Thanks.
> 
Thank you a lot!

