Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E920161F2CA
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiKGMUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 07:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKGMUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 07:20:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971BD62;
        Mon,  7 Nov 2022 04:20:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso7017667wmp.5;
        Mon, 07 Nov 2022 04:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpO1ES1DT9VB2Pc2bbJXPCltOGfFXJglqqrpyjrXtK8=;
        b=Y1LpakEB5SGdSNuJfeOjuV1WjbL536FkfPZguA1c5W2WHxopXHj89W9ZTxsgx7F8tv
         po7pgEfTXTYT+0AJ7WAxGJwkktW2oEbHYrxct1Dlda+MVlv6L/2suzgYQHDmdnYAjY1u
         eV89nkxa+g9NLG65nXuAfwL7dJkONH483k79jXz+m9xxz8w1Dtxn1F/hbBLD1N4yphPL
         vqTohbjFrzcmHU9yY+gCA03ZWQe2udLqtHddPYInHw4d756CBM/zbMBlqFhLZgi/PwTs
         Tf4g4QGDKp8X+81do68DTyC5qhUXpP+ubDUxWnfEOm3Y3/pyPmxC85dlc14Zcf0O7zSY
         YV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpO1ES1DT9VB2Pc2bbJXPCltOGfFXJglqqrpyjrXtK8=;
        b=mYdC7DBztPkQxqy9HvezqGK9skguvpytsHJC4Kmg24NRmKYINkLfVjviiC8aeatEVp
         DrjmV6+pY73eXyKe5WM3rVdkjKIXksfg4/6PpDHk6nclGW6v47p02xzdX4/4entsRgKk
         HVs2k13QHHZUXTAcndwWZNuCWsrZOGEwXeGNq4xV4u5b6SYt58Hnl2LNbe3e0/Zyvjgj
         Tg4i/Zv0K1RNZgc+MDUAxZnk58umAfU17J+Ij6cOFOEqCEWXTetngnsvEbjHJdebHTtT
         Si03obpVdTCD2Thbf0q96sBVSBFC/qnk3HIqr6KLj6wWQ20lTluur2mllP9eBbJP/wzL
         jfjA==
X-Gm-Message-State: ACrzQf1HBaUMv7AyXpdicfFvm5NwFjtTBN9UBgJyWPpw69jDM2s9UisP
        jKCYrbnlR7iSkwRkmOIHnW0=
X-Google-Smtp-Source: AMsMyM4uI0V2M+QW8ibD8ONg8BiYxQeVPVRSbIejoYJ9gjoyye/xqfEBSqmLITjKvasG04aeIOUlmA==
X-Received: by 2002:a1c:6a17:0:b0:3cf:9d32:db2e with SMTP id f23-20020a1c6a17000000b003cf9d32db2emr9181101wmc.62.1667823609700;
        Mon, 07 Nov 2022 04:20:09 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:5c58:5d45:1992:a386])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003b4a68645e9sm12724471wmq.34.2022.11.07.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:20:08 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v1] docs/bpf: Document BPF map types QUEUE and
 STACK
In-Reply-To: <CAEf4BzYpNd_oM6n4eW6UqF5n60xkvTarhbcyCgJSCDFtg1rm4g@mail.gmail.com>
        (Andrii Nakryiko's message of "Fri, 4 Nov 2022 16:00:59 -0700")
Date:   Mon, 07 Nov 2022 09:17:29 +0000
Message-ID: <m2v8nrrumu.fsf@gmail.com>
References: <20221104172140.19762-1-donald.hunter@gmail.com>
        <CAEf4BzYpNd_oM6n4eW6UqF5n60xkvTarhbcyCgJSCDFtg1rm4g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 4, 2022 at 10:21 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> +
>> +Userspace
>> +---------
>> +
>> +This snippet shows how to use libbpf to create a queue from userspace:
>
> I'd prefer "how to use libbpf's low-level API to create a queue".
> Because ideally people use the declarative way shown above, which is
> also "use libbpf to create", but is simpler and preserves all the BTF
> type information (if map supports it).

I'll incorporate this and also see if I can reword to highlight the
preferred declarative approach.

>> +
>> +.. code-block:: c
>> +
>> +    int create_queue()
>> +    {
>> +            return bpf_map_create(BPF_MAP_TYPE_QUEUE,
>> +                                  "sample_queue", /* name */
>> +                                  0,              /* key size, must be zero */
>> +                                  sizeof(__u32),  /* value size */
>> +                                  10,             /* max entries */
>> +                                  0);             /* create options */
>
> NULL, it's a pointer

Good catch, thanks!
