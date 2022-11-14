Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19D627B22
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 11:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiKNK5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 05:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNK5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 05:57:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22301A207;
        Mon, 14 Nov 2022 02:57:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z14so17315957wrn.7;
        Mon, 14 Nov 2022 02:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WjFufgdkg/OkYWcIaQRnwXicBL1zcGqAln66oAXCb8=;
        b=IOHD6TkkM8jJW1lWBwzRJ+XOJPBdntJ3gje1DWAKn0tKNsIVypUozdO7F1tPI6XclJ
         phOcu5JlJPmOOm9qjcuSIYnCSkBAzz56R7kMNQIY1kx/kdHvKgE8smpBHgf9BBlKNDkY
         wZ/Q2PF/CHyrp/DfekjEqJ7DWwLaFrmnw/wyJOC50+8cjLif0HQRYPN2qZq5BTcd2oNi
         Trxjuq4ZAuaWV/vpfvvHcNR7lUA7Dwe+N1DymWTQ7SjAycBIwY0bLE9yAWLWSRExGdNs
         +tRnvCMSJiSakDTYAyDNtkKfA1y+vcaNaCUima1R6QyrEHPB6O3wCmkxpt5zYT7c96JQ
         NwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WjFufgdkg/OkYWcIaQRnwXicBL1zcGqAln66oAXCb8=;
        b=FpSn/Sdtx20kZXL5qVx+AgtnFs6qxzM5ahIrFFrMo1CIiSzvs1lxMbYPl6PVra02Dx
         d7/25FuL2z344MagWyqBkLXlsjmyHuvxU7qkVddBt6qnmYvImNKvRJWVx129vZO1RPIo
         e7GDAsY06Lejz+p/aoASfK91naPVTQOpwnRxdIHcfttGYXy3+h3fwkYfQ5I/+UrDY0Mu
         6hLT1PNGKYPBYtmN2ny1Lok9HhNeItfmCX0LsEgh9SMVffE3UTatwNkdpTV6Znb10/cp
         wb3Fm3BH4rPw0gZxb1v63sV5FE7rru4p40JMemv+63g+X9dj+IXld9/oxWi6tmOPWwBu
         Ijxg==
X-Gm-Message-State: ANoB5pkfCWGLnMZDBHu/3eusSIiMrrTA7RGIyJ4zTwy3JeLEJ0Oqo6hn
        WWQF9abHesTghERgtt6g6ZU=
X-Google-Smtp-Source: AA0mqf4WeoJGh9UpaiS0ZkbteiHw+SNHbGFL2jdaBsDx/ANXC8uS0rBqB7yo48ZbBV0/pCVspdwFPg==
X-Received: by 2002:adf:ef8b:0:b0:236:5700:d4cb with SMTP id d11-20020adfef8b000000b002365700d4cbmr7361348wro.597.1668423434278;
        Mon, 14 Nov 2022 02:57:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:6942:6e2a:2257:aa49])
        by smtp.gmail.com with ESMTPSA id p16-20020adfe610000000b002364c77bc96sm9276977wrm.33.2022.11.14.02.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:57:13 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Tucker <dave@dtucker.co.uk>,
        Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v10 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <CAEf4Bzak4A-vP=NeJheA0poiu_8fK53cvbq1EnnSHC78FB7mtQ@mail.gmail.com>
        (Andrii Nakryiko's message of "Fri, 11 Nov 2022 11:39:51 -0800")
Date:   Mon, 14 Nov 2022 10:18:04 +0000
Message-ID: <m24jv17sbn.fsf@gmail.com>
References: <20221109174604.31673-1-donald.hunter@gmail.com>
        <20221109174604.31673-2-donald.hunter@gmail.com>
        <CAEf4Bzak4A-vP=NeJheA0poiu_8fK53cvbq1EnnSHC78FB7mtQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 9, 2022 at 9:46 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> +This example BPF program shows how to access an array element.
>> +
>> +.. code-block:: c
>> +
>> +    int bpf_prog(struct __sk_buff *skb)
>> +    {
>> +            struct iphdr ip;
>> +            int index;
>> +            long *value;
>> +
>> +            if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip, sizeof(ip)) < 0)
>> +                    return 0;
>> +
>> +            index = ip.protocol;
>> +            value = bpf_map_lookup_elem(&my_map, &index);
>> +            if (value)
>> +                    __sync_fetch_and_add(value, skb->len);
>
> should be &value
>
> I fixed it up and applied to bpf-next, thanks.

I double checked and it really should be value, which is already a
pointer.

Do you want me to send a patch to fix it up?
