Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEE5B34EF
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIIKOh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIIKOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:14:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA431167;
        Fri,  9 Sep 2022 03:14:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so1925533wrr.5;
        Fri, 09 Sep 2022 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=02N4B3uo/LK8nlmi+RnMMB9q8gQKWvRe4GM8PGErHWs=;
        b=qjcvcPhwfQa4ir/ripxGmcWvbeaxDckFoNQ2IiWrKi+XzkWAVTWXugWvxn0dcq8ovQ
         HPSWNESlSJ0PCjGe+ndkFdWN8r1yO9rT/unLn5usp8vFSlrD2x/8l/Y8CSeq2UroFRrI
         QeMsh6uraVua+z0Q1shVCvcsSkn4RHjYwrTjkr7KPTa53fX8VEqGCuOxdrdTiV8C3DZp
         wsWUYKyDOpK0BXHjFkS1A1JrqJ5F2TX9LL2fYXy/rWsGJNKFeMmLnB1q0wU9AnE00SNo
         He6skvIenhYuwnR5a75QVBYpD7kHxbzHDu1B2m8pEfmhLEeurhplOU8HnqVvdtyDnrp1
         qHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=02N4B3uo/LK8nlmi+RnMMB9q8gQKWvRe4GM8PGErHWs=;
        b=aqEpI5sQNoCIcy43Wb8WrGAR4glTNSeR/FWe/+SPaWJeTwff+gFSxYMdJVX+uFysiZ
         Jjo2vZ+MSkDY7281s1nn5gorjvXm86WTo/S6Hfd6Uir0I5il4Itd6LyVSuFEZ/Rm9XuF
         a4QM4IQBNDQ3PUgmzTxmcIqmMu7fRmUaXGyLfqtx3GS4jf5YsN+9dyRRRrX7jFus3YYF
         n6LMcVK0Qv/ayHffjdZhrguT87Gy2cJXipYHqJb0gSYGKQS7sPdqgLwsjsrekGXI7WN1
         tL3uFylWejjP4Y3XU+ebyO6sABNKJEsJ9fz15AKtwQwf2NFn5jrTz8edJNHvSX+xj8w7
         tbdg==
X-Gm-Message-State: ACgBeo1q8s2QbPEdCb7HzO921tslyo3ThqgKOuTUpmwNa7Qz1Ny4npAv
        xXdnOkGwe5gvXWG4HxVUSZY5ddC/pO4=
X-Google-Smtp-Source: AA6agR7lNCXLIBMUU1cUNouP2uyCSi4R0CP+r06yQih+mYJHjNuPXI5zn0if7JNb6JmQpuOYEwEjwg==
X-Received: by 2002:adf:f80b:0:b0:228:dbb9:5bdf with SMTP id s11-20020adff80b000000b00228dbb95bdfmr7489884wrp.327.1662718464885;
        Fri, 09 Sep 2022 03:14:24 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d41-20020a05600c4c2900b003a5c999cd1asm206389wmp.14.2022.09.09.03.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:14:24 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <CAEf4BzZ_2wCVTjhAe0XzJ5qfbVhV0pfZeJ=z9Jg_fj_fzD1JFw@mail.gmail.com>
        (Andrii Nakryiko's message of "Thu, 8 Sep 2022 16:29:55 -0700")
Date:   Fri, 09 Sep 2022 11:12:22 +0100
Message-ID: <m2bkro3lh5.fsf@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <20220829091500.24115-2-donald.hunter@gmail.com>
        <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
        <m2h71k6bw8.fsf@gmail.com>
        <CAEf4BzZ_2wCVTjhAe0XzJ5qfbVhV0pfZeJ=z9Jg_fj_fzD1JFw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Sep 6, 2022 at 3:50 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>
>> > On 8/29/22 11:14 AM, Donald Hunter wrote:
>> >> Run make in list of subdirs to build generated sources and migrate
>> >> userspace-api/media to use this instead of being a special case.
>> >> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> >
>> > Jonathan, given this touches Documentation/Makefile, could you ACK if
>> > it looks good to you? Noticed both patches don't have doc: $subj prefix,
>> > but that's something we could fix up.
>> >
>> > Maybe one small request, would be nice to build Documentation/bpf/libbpf/
>> > also with every BPF CI run to avoid breakage of program_types.csv. Donald
>> > could you check if feasible? Follow-up might be ok too, but up to Andrii.
>>
>> Sure, I can look at what is needed for the BPF CI run.
>>
>
> Daniel (Mueller, not Borkmann), is this something that can be added to BPF CI?

It looks to me like it can be added to BPF CI if we change docs/conf.py
to call a new make target in docs/sphinx/Makefile. Hopefully Daniel can
confirm whether this is the case.

Given that the tree layouts of the kernel and libbpf are very different
I think we need to do one of:

1. Use a separate a .csv generator script with dedicated makefiles per
project.

2. Move this entirely to libbpf and include a readthedocs URL in
index.rst in the same way as currently done for the API docs.

I think my preference would be for 2.

Thanks
Donald.
