Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB2161F2CC
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGMUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 07:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiKGMUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 07:20:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1AE62DF;
        Mon,  7 Nov 2022 04:20:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v7so6774466wmn.0;
        Mon, 07 Nov 2022 04:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoLI3U1WVnPhAczgDn3YmTPplH4mN49yQEHTg2jEwe0=;
        b=p5scd/zuJFtUC2MaytxT5KcwnRqUQVJAk1gLUrkS+N8dp3m5IKxk6bFuVykUDIPfnz
         fU2S4DeBvfOgEjGoWcQ1PirSBnsdzssrQLx/LDn7pM2Xfo0tGVyOTk4YLNCumL4iBkQa
         JovIiyd1CLQ5cQEm2lrE5n9vRn3UELWW9vIzb90A3PAJqXan/niaG8zayQmkd0KkA9l/
         KpTO7Yp66qHRPK8MAvp5YJLNkKukhZiqaA68FAyAPbPUm80NbiMDgZ0DLx+2t3Numk5U
         G3fb4aYSi7mA9Q43zoLVjOUTUCCiu7GrNz1xzzYwWTi8jx6G17oyAPCkFkGO1gxHh5il
         dqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoLI3U1WVnPhAczgDn3YmTPplH4mN49yQEHTg2jEwe0=;
        b=actVxP1//dMDew8nNjyEkiyFdECEEYflkFrVkBMAMajvscoLk7UL2BSYv6y7r8myDY
         0B6gx7hwCV4GoeiRRowwOfTsF0RzMADYKEQP0Mkw+x0OFVYFJk+LWFcHDl5rckHR6jKr
         KKtYDOom9soWDLSUKsOJbji2f6AL6VfCf7wQdeMX5XO0tIREqyfcCqkzYvPJhRpM0Ku5
         QJRg211O2ZgjtLV/cFGIUQlrHJRwtDz733n4mUK5t2joIe2vpWGlhXSGJuad93jvC9q7
         Nncur/joqDeYWGkjZr1cskzvlZQjGzmy8ATv7VZp3xuJAqh5DZH/9wSY/7wBuXvkrc7V
         C09Q==
X-Gm-Message-State: ACrzQf1uQt7KKFEwZhW6751+pyHBJxPKzy4F+OFcxpm+NYIPKlZ0nTuI
        AEb+OaIlpW3a85k1ncVrvbKrN/lEPEA9UA==
X-Google-Smtp-Source: AMsMyM4eh/W2xbyCsfIom4ZVUN3r5j7HjgFgmv17tiKE5MHQcfGC0ItE97zOF8hj3oNvM+aJYzq5nA==
X-Received: by 2002:a05:600c:1508:b0:3cf:6cc1:c3b4 with SMTP id b8-20020a05600c150800b003cf6cc1c3b4mr30216373wmg.156.1667823611258;
        Mon, 07 Nov 2022 04:20:11 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:5c58:5d45:1992:a386])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0022e3538d305sm8494058wri.117.2022.11.07.04.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:20:10 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, docs: document
 BPF_MAP_TYPE_ARRAY_OF_MAPS and *_HASH_OF_MAPS
In-Reply-To: <CAEf4BzYiSyps09esMH407WnzPvND+c56EQHeooLUF9RKcs-Y3Q@mail.gmail.com>
        (Andrii Nakryiko's message of "Fri, 4 Nov 2022 14:26:33 -0700")
Date:   Mon, 07 Nov 2022 11:41:49 +0000
Message-ID: <m2r0yfrnya.fsf@gmail.com>
References: <20221010112154.39494-1-donald.hunter@gmail.com>
        <CAEf4BzYiSyps09esMH407WnzPvND+c56EQHeooLUF9RKcs-Y3Q@mail.gmail.com>
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

> On Mon, Oct 10, 2022 at 4:32 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
>> including usage and examples.
>>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>
> subject suggestion (as it's pretty long):
>
> bpf, docs: document BPF_MAP_TYPE_{ARRAY,HASH}_OF_MAPS

Thanks for the tip. Hopefully already resolved well enough in v2+.

>> +Examples
>> +========
>> +
>> +Kernel BPF
>> +----------
>> +
>> +This snippet shows how to create an array of devmaps in a BPF program. Note that
>> +the outer array can only be modified from user space using the syscall API.
>> +
>> +.. code-block:: c
>> +
>> +    struct redirect_map {
>> +            __uint(type, BPF_MAP_TYPE_DEVMAP);
>> +            __uint(max_entries, 32);
>> +            __type(key, enum skb_drop_reason);
>> +            __type(value, __u64);
>> +    } redirect_map SEC(".maps");
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +            __uint(max_entries, 2);
>> +            __uint(key_size, sizeof(int));
>> +            __uint(value_size, sizeof(int));
>> +            __array(values, struct redirect_map);
>> +    } outer_map SEC(".maps");
>> +
>
> Let's also demonstrate libbpf's declarative way to initialize entries
> in outer map? See progs/test_btf_map_in_map.c under selftests/bpf for
> various examples.

Will do, thanks!

>> +This snippet shows how to lookup an outer map to retrieve an inner map.
>> +
>> +.. code-block:: c
>> +
>> +    SEC("xdp")
>> +    int redirect_by_priority(struct xdp_md *ctx) {
>> +            struct bpf_map *devmap;
>> +            int action = XDP_PASS;
>> +            int index = 0;
>> +
>> +            devmap = bpf_map_lookup_elem(&outer_arr, &index);
>> +            if (!devmap)
>> +                    return XDP_PASS;
>> +
>> +            /* use inner devmap here */
>> +
>> +            return action;
>> +    }
>> +
>> +User Space
>> +----------
>> +
>> +This snippet shows how to create an array based outer map:
>> +
>> +.. code-block:: c
>> +
>> +    int create_outer_array(int inner_fd) {
>> +            int fd;
>> +            LIBBPF_OPTS(bpf_map_create_opts, opts);
>> +            opts.inner_map_fd = inner_fd;
>
> LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = inner_fd);

+1, thanks.
