Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75BF59F7A6
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiHXK1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiHXK0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513AD80B75;
        Wed, 24 Aug 2022 03:25:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k9so20211435wri.0;
        Wed, 24 Aug 2022 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc;
        bh=eKQZ/ehv1MwWOxO6OkjgFxZ52KEITsygp+TljaaBnnk=;
        b=GSDHHAF86YGL1reVUTRrqe+R35sB4YmjMRUrm+/6Qi9YrvBJi2QNjNXD07sw00O4RH
         83bdXmCGKoGUdIJ0/+HaM/UCQujcjDdn+H6Zz6u4qxufyOW+iNikAMDnprMYEfznr0lh
         9sXxVtg5Cu9nXnNj0cVD9wYFmG/Pg8Ll4zRAPcljrCpjdlOmCxTnuwbRbbygs909t5+T
         lkCmMeaTKd7fBWyZItZfTVWj1waF/XkDWaBJlWzEdQNYS4M6kDwBqB+uJwsBiktyrXS+
         MaLpV3ZWuI2iyvltar4GtzDNJJwmWbHxVGuPLp15ghmtSi7kMuWOC7ZEK4ZyiFo2NnQ9
         CjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eKQZ/ehv1MwWOxO6OkjgFxZ52KEITsygp+TljaaBnnk=;
        b=4/YMugYbA/y6vQ0UlBENQv/zOMuYqbqRFlnZLnxjBOWhIz6JMhUhz5EDRP+W1zT4z4
         OZbCCH8/eyCS2LLtADkJsbrmtPa5bJDaJlLSAj/gUPdeIH60rrth04hTL9AjgRj6VYE8
         lqXSI1z0V10/cAZBBseUX/sCr6q6djto6Mj38YeV6JSETY0UnH2GfBkTTcjAvPbmy3xZ
         U60poV4oSA0VIsG4AQAr0JJnsbR5Kr5f4IN5osbWNhqSzH56wPSLiEzzq00miDfHIzy1
         9OKGkhzN4XNmnPmdmjhvimHGTG5r3wHS9RERHc8KX5uHQ1mv9f5IFGYouKgKcPDEMo1Q
         gwGg==
X-Gm-Message-State: ACgBeo3kWXKAzt6Xnm9Kx/TJlajf7urMLZoKB+3dYJqwSrajtuT8rpVq
        7cXCyrElxJpg4YaHdAsn2zk=
X-Google-Smtp-Source: AA6agR46/A44ZFx6NCeOYijK+sSh5+yYxjWCQL7ynSDaeXLOQ9PqUEl6pUGtpxulEz4AaRRTWgBqXA==
X-Received: by 2002:a5d:4f82:0:b0:225:32c6:7e59 with SMTP id d2-20020a5d4f82000000b0022532c67e59mr14249968wru.366.1661336733519;
        Wed, 24 Aug 2022 03:25:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:55a7:d3:b36c:e4f1])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c502700b003a60bc8ae8fsm1538773wmr.21.2022.08.24.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 03:25:32 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        grantseltzer <grantseltzer@gmail.com>
Subject: Re: [PATCH bpf-next] Add table of BPF program types to docs
In-Reply-To: <CAEf4BzaujwgDXm+05MuGr_ouAseGGFg50Cxb83hHeWHX7bCk6A@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 23 Aug 2022 15:53:36 -0700")
Date:   Wed, 24 Aug 2022 11:24:41 +0100
Message-ID: <m2fshmym52.fsf@gmail.com>
References: <20220823132236.65122-1-donald.hunter@gmail.com>
        <CAEf4BzaujwgDXm+05MuGr_ouAseGGFg50Cxb83hHeWHX7bCk6A@mail.gmail.com>
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

> On Tue, Aug 23, 2022 at 9:56 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>>
>> Extend the BPF program types documentation with a table of
>> program types, attach points and ELF section names.
>>
>> The program_types.csv file is generated from tools/lib/bpf/libbpf.c
>> and a script is included for regenerating the .csv file.
>>
>> I have not integrated the script into the doc build but if that
>> is desirable then please suggest the preferred way to do so.
>>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>
> It does seem cleaner to generate this .csv during docs build, instead
> of having to manually regenerate it all the time? Should we also put
> it under Documentation/bpf/libbpf/ as it's libbpf-specific? Having it
> under libbpf subdir would also make it simpler to expose it in libbpf
> docs at libbpf.readthedocs.io/

Agreed about generating the .csv as part of the doc build. I will look
at adding it to the docs Makefile.

I'm happy to put it in Documentation/bpf/libbpf and link to it from
Documentation/bpf/programs.rst.

> We can probably also establish some special comment format next to
> SEC_DEF() to specify the format of those "extras", I think it would be
> useful for users. WDYT?

Yes this would be a useful addition. Are the extras always for
auto-attach? If so, then I can add that to the rules.

I'd prefer to modify the existing ELF section name column to replace '+'
with extras since the table is already wide.

> CC'ing Grant as well, who worked on building libbpf docs.
