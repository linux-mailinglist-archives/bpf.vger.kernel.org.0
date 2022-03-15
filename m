Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578314DA44A
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiCOVC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbiCOVC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 17:02:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA85548A
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 14:01:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r64so172867wmr.4
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=IGbK0m+NxxGIcQ8MrdXBXHZDTpj75W1cLsS+maz3bCY=;
        b=u1iQ5V+S9wmpQGFcdm799AmSZfl6v14oL8500N4JdXwpP015PH4yvGz0l4jADhyhY/
         Vu9RcIjKXC7RqhILJG3kYOlnBHaopqbM4Mq/rJftodch/7j3AUNLXlfwljB7Lcupm1wP
         qoTYLjwhCATSxvyVciA3Jb4sGLeA0qW97qpShspaT4mM2MiQLO8Uwgqaj2fTT8FazL99
         Vtmk5xdWD308i0aHWDwjCZTk7eDP6lwU2e5zyL4YJppbt6Kgo5KU9uA9vR3GTxRpOjJH
         hib+QnSRRzlNqkMhCL7uhAVMn5BbXSYJNm162lWGlkoQoqiep6X4H7p7ulQly9Qpdm3S
         QaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=IGbK0m+NxxGIcQ8MrdXBXHZDTpj75W1cLsS+maz3bCY=;
        b=MludInDGK/SFDZh19uDAaU6MH5aFqRzNVJfLx7wN+nz7hCIpo69Ztwld6s1necnR8c
         rQe/wqIfZnZPZb54e7EJ5Gkjtp8P5wKAd7FShQWuXHYJU5Z6SqL3AknIGU27l4kmm8ry
         9Udzbta8h7dkrt0ZK7VcHgRgIsrU6CgY7z0tGxgtnk71jfGwv+cg8Q3CTPHGuiipYbrc
         h9HYczA09ljCm88V5rWHpo6ZCLT7DZunY++/BkMY0qnr6QKCXbwrDwaDKaCoJx4ZKcsw
         295FuRPkbvCgsfMW4jpDE8vLQyyEPGK6SqqLrdKXY52qnAL1zyeieEVdu/hdHfeJMxyq
         hucg==
X-Gm-Message-State: AOAM532jQk+w64GHbBmY965L3dJ9DUhIojUw10tF1cV+Tyt/opv76EFG
        IH0vNS9HzSPw8o7STU0UWZPas8rUTtPTs2dXV/0=
X-Google-Smtp-Source: ABdhPJz6nsLbqzVlwot2IoOOHaQV9vV5OXJot4HephXLBN6RYaaTNpq0Y2DkCLkYgrnlT/LuAIxnuQ==
X-Received: by 2002:a05:600c:3b13:b0:389:cf43:da5f with SMTP id m19-20020a05600c3b1300b00389cf43da5fmr4755394wms.201.1647378069877;
        Tue, 15 Mar 2022 14:01:09 -0700 (PDT)
Received: from [127.0.0.1] ([37.173.145.191])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c108100b00389cdb3372csm496wmd.26.2022.03.15.14.01.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Mar 2022 14:01:09 -0700 (PDT)
Date:   Tue, 15 Mar 2022 21:01:03 +0000
From:   Quentin Monnet <quentin@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4Bzb0D=txKjrRu5mJczdfBde3v6HzY_XpbP=5JB5NwGRM9w@mail.gmail.com>
References: <20220309163112.24141-1-9erthalion6@gmail.com> <CAEf4BzZJ1DBuhHi400ObWoEQA7nLMT8TD4cVmhea_g4tdRFzoA@mail.gmail.com> <CACdoK4Kviw5UiBCgP=3PFGRippmP1U3yXp-9vM8WwAB_-aRmeA@mail.gmail.com> <CAEf4Bzb0D=txKjrRu5mJczdfBde3v6HzY_XpbP=5JB5NwGRM9w@mail.gmail.com>
Message-ID: <1EC1C8F1-2A10-4D12-BB50-2197ADEAA062@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 15 mars 2022 18:33:02 GMT+00:00, Andrii Nakryiko <andrii=2Enakryiko@gma=
il=2Ecom> a =C3=A9crit=C2=A0:
>On Sat, Mar 12, 2022 at 2:59 PM Quentin Monnet <quentin@isovalent=2Ecom> =
wrote:
>>
>> On Fri, 11 Mar 2022 at 22:25, Andrii Nakryiko <andrii=2Enakryiko@gmail=
=2Ecom> wrote:
>> >
>> > On Wed, Mar 9, 2022 at 8:33 AM Dmitrii Dolgov <9erthalion6@gmail=2Eco=
m> wrote:
>> > >
>> > > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cooki=
e for
>> > > BPF perf links") introduced the concept of user specified bpf_cooki=
e,
>> > > which could be accessed by BPF programs using bpf_get_attach_cookie=
()=2E
>> > > For troubleshooting purposes it is convenient to expose bpf_cookie =
via
>> > > bpftool as well, so there is no need to meddle with the target BPF
>> > > program itself=2E
>> > >
>> > > Implemented using the pid iterator BPF program to actually fetch
>> > > bpf_cookies, which allows constraining code changes only to bpftool=
=2E
>> > >
>> > > $ bpftool link
>> > > 1: type 7  prog 5
>> > >         bpf_cookie 123
>> > >         pids bootstrap(81)
>> > >
>> > > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail=2Ecom>
>> > > Acked-by: Yonghong Song <yhs@fb=2Ecom>
>> > > ---
>> >
>> > Quentin, any opinion on this feature? The implementation seems
>> > straightforward enough=2E We'll need to not forget to expand the supp=
ort
>> > to other types that support bpf_cookies (and multi-attach kprobes and
>> > fentries will be problematic, potentially), but this might be useful
>> > for debugging purposes=2E
>>
>> No strong opinion=2E I'm generally in favour of adding more useful info
>> to bpftool's output; I've not found myself in need for the bpf_cookie
>> so far, but if it's helpful for debugging, then it makes sense to me
>> that bpftool be the tool to provide the info=2E The change looks clean
>
>Can I get your ack for this change, then?

Acked-by: Quentin Monnet <quentin@isovalent=2Ecom>

>
>> indeed=2E Agreed also that this will require us to think of updating
>> bpftool when new types gain support for the cookies=2E What would be th=
e
>> problem with multi-attach, the kprobes/fentries would have several
>> cookies?
>
>Yes, multi-attach links will have one cookie for each attach target,
>so there will be, in general, a multitude of cookie values=2E

OK thank you
Quant in
