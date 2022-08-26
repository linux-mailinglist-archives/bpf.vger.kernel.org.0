Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1025A2594
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbiHZKLs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiHZKLn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:11:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE0B2D80
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:11:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so4145142wme.1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bASVX8UhXj4/42VcYiNp5DDr1+lNkh8M0LBAfOH7frk=;
        b=dlvHnqyCIVsRTQeIhg9LEJftX3h/Asmp2bQEBR6ERMiKC0pGvLAQRpMBIzjN3RdpBF
         PTIc0++YCtYe2RRKOCM7J6XjlY4q1BXnKv5dXolAySh4HpO+GUgkW06asXUMHlonU1Z+
         NSVOgh3uPBHGCUBgw+2i9s9R56YmV7W/gQLPiQRG44MBiZ/Y1N1bbRUtYxDt9DsLa8bv
         oA0Oet4s5MP5LV0PDm7KfUaCoi5AJPKDhwX2XMzC37SEdJoxy+qdA9LUxlJO6/xOeBgg
         v19tmBoFtKaPOdpKBoLAU69PYj9v36a7M6HhNW9EQOxzb76IGqszkXeDaomh5GnoBM6E
         ayQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bASVX8UhXj4/42VcYiNp5DDr1+lNkh8M0LBAfOH7frk=;
        b=AsDVv4w7xsDjpihOxZ/Sh+xelqHjc8R75WqAyXz0YSD1JLq7BqKF9u7d4+R0Q11EYn
         XOzEJtow/rR3PNOojPO2Us25An1/pNWidksh0vnhK7ZPEiZPLaELMdJPGnKedRel+5BA
         HdgSpowtue4t0VT335dA4ScjDID9ZjcmV72hpU340aF7Th5uPYuSpZ8IjjNL0Rhbu4hz
         ZWXKMLYsiibeC2k7Umfd7DiatY3+IMSLKBuF9Y8s2C3X36OovtkPfl3mMOvDb7mepfii
         sL5fyivwIqRD/iEojxCx7lQ1UcoJnmP7FgPizf3OdNpYdMD14OIl4w0mUOg1Ek6q2Hla
         NsJg==
X-Gm-Message-State: ACgBeo0SpDV52veyYEZtMZXBy416DpYoI1v3o/pcOc1jy2gEOOUD/J1w
        8dnGTcrJdjoVofJud2nl4WJ4rA==
X-Google-Smtp-Source: AA6agR5OFNYijeczl9Srsdu4/20bS7UddeRlnodo7RImaCqpYlDMQt5Nl5RkLPyRAW4tUv7f8nmjJw==
X-Received: by 2002:a05:600c:474c:b0:3a7:3954:8818 with SMTP id w12-20020a05600c474c00b003a739548818mr1563356wmo.124.1661508700502;
        Fri, 26 Aug 2022 03:11:40 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4986000000b0021e4829d359sm1456340wrq.39.2022.08.26.03.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:11:40 -0700 (PDT)
Message-ID: <38420750-3039-f523-5ee7-24ae6b762dd7@isovalent.com>
Date:   Fri, 26 Aug 2022 11:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next,v4] bpf/scripts: assert helper enum value is
 aligned with comment order
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eyal Birger <eyal.birger@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20220824181043.1601429-1-eyal.birger@gmail.com>
 <CAEf4BzaQ9ZS0a4Y_nTaXUX6m5PM0VC9B92o9uhGxwydZkocMXw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzaQ9ZS0a4Y_nTaXUX6m5PM0VC9B92o9uhGxwydZkocMXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/2022 19:53, Andrii Nakryiko wrote:
> On Wed, Aug 24, 2022 at 11:11 AM Eyal Birger <eyal.birger@gmail.com> wrote:
>>
>> The helper value is ABI as defined by enum bpf_func_id.
>> As bpf_helper_defs.h is used for the userpace part, it must be consistent
>> with this enum.
> 
> I think the way we implicitly define the value of those BPF_FUNC_
> enums is also suboptimal. It makes it much harder to cherry-pick and
> backport only few latest helpers onto old kernels (there was a case
> backporting one of the pretty trivial timestamp fetching helpers
> without backporting other stuff). It's also quite hard to correlate
> llvm-objdump output with just `call 123;` instruction into which
> helper it is.
> 
> If each FN(xxx) definition in __BPF_FUNC_MAPPER was taking explicit
> integer number, I think it would be a big win and make things better
> all around.
> 
> Is there any opposition to doing that?

No objection from my side, for what it's worth.

As a side note, and in case it's useful to anyone, I've played a bit in
the past with clang from Python to parse the UAPI header:


    #!/usr/bin/env python3

    from clang.cindex import Index, CursorKind

    index = Index.create()
    translation_unit = index.parse(None, ['include/uapi/linux/bpf.h'])
    if not translation_unit:
        raise Exception("unable to load input")

    elements = []
    for node in translation_unit.cursor.get_children():
        if node.type.spelling == "enum bpf_func_id":
            for val in node.get_children():
                elements.append(val.spelling)

    print(elements)
    print(elements.index('BPF_FUNC_trace_printk'))


    $ python3 script.py
    ['BPF_FUNC_unspec', 'BPF_FUNC_map_lookup_elem', [...],
    'BPF_FUNC_ktime_get_tai_ns', '__BPF_FUNC_MAX_ID']
    6

I'd love to use something like this to make scripts/bpf_doc.py more
robust, but I've refrained because of the dependency on the clang library.

Quentin
