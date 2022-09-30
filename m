Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7F5F0811
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiI3J6D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiI3J6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 05:58:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBBD170B2F;
        Fri, 30 Sep 2022 02:58:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x15so5546668wrv.1;
        Fri, 30 Sep 2022 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=HSZ+aShXll8KmOveyBg86lsdBKYjb2hPRP55VOw49Gk=;
        b=pZEkWxGHz8d5zcLFiDkZXko04pUUEbduI9KD2/QeocZQr5M1usThwTNi3lU0EoGXrP
         1M+sVVtAslSVXhTrV2yN95gxeDmRw3QcAezp2KFBh3tRUa9Ke4AXqqfh2PKTxtTLcUKw
         PppixegxJUyc5JCH9WDJq7zlhMCGM12V/tn0Hj3ifp4evzWQilNjP/RZORePoAndbzSf
         zyK2K1aQ0EGvlHhTak+FVg0EVTV9cKonII3WzS2Px6CUnZoCSHzkMDWxHNTq+IG3VnbM
         h4humYaHNssn5gTrpu9WG90DmKum12qNuVnA4FhsDeVdMf1pTBDFH/xOr+3eMmNpbh5H
         NNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HSZ+aShXll8KmOveyBg86lsdBKYjb2hPRP55VOw49Gk=;
        b=zvYd8eHVXhV8I7WwZ5D7ELROso2ZBqb942msfR+59sV9s/DblbM7KDxHuxQWY3K2Ud
         q/MCEIX1jQzyibcHTJ/uAD8yKCmEjHMs2HS8fLN9Vw7IDCAlIAZUQiz14Y/DsittG5Jq
         ZEGNU3sZcZg+fdNdE91n4tezECA994Fy4CU/VSgNrA5RYVeIkCn9hInZkTib/0pS6fTf
         5B2mgqnXmdGPbicGehDyjqN4QRrbG39nddbeQRHQdxANXCCczs6jOlq2iBr3sXaib04G
         kUNK+6eFNqsmeOnOsWwuIhe5CFbru3JDXq9+5582zhpzfn7aDNs+zJiz8tY9s5/bvZRy
         iJqg==
X-Gm-Message-State: ACrzQf1Dxb2C1VYB50dejJ0fdw1GKl+qKZhBC8JRmcyUVqcSYEG8n2yC
        59VBivbGQEC2ht5UmBE0q7W/R9DQbum34Q==
X-Google-Smtp-Source: AMsMyM5jEtN/6B332W/0nOTxkfOUOJ8jDZU9Imj2tm1QPGrx6MU3cPaBNJWnrXxP3jExyNL84q4G4w==
X-Received: by 2002:a5d:50c3:0:b0:22c:c234:7d96 with SMTP id f3-20020a5d50c3000000b0022cc2347d96mr5256486wrt.192.1664531879987;
        Fri, 30 Sep 2022 02:57:59 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:480e:2385:926c:bbb7])
        by smtp.gmail.com with ESMTPSA id bu21-20020a056000079500b0022cdcad0d21sm1519123wrb.8.2022.09.30.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:57:59 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <m2h70y87eh.fsf@gmail.com> (Donald Hunter's message of "Fri, 23
        Sep 2022 15:58:14 +0100")
Date:   Fri, 30 Sep 2022 10:57:25 +0100
Message-ID: <m2wn9l6v7e.fsf@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
        <20220922115257.99815-2-donald.hunter@gmail.com>
        <87tu4zsfse.fsf@meer.lwn.net> <m2h70y87eh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
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

Donald Hunter <donald.hunter@gmail.com> writes:

> Jonathan Corbet <corbet@lwn.net> writes:
>
>> Beyond that, I would *really* like to see more use of Sphinx extensions
>> for this kind of special-case build rather than hacking in more
>> special-purpose scripts.  Is there a reason why it couldn't be done that
>> way?
>
> I looked at writing the BPF program types as a Sphinx extension but
> found that approach problematic for the following reasons:
>
> - This needs to run both in the kernel tree and the libbpf Github
>   project. The tree layouts are different so the relative paths to
>   source files are different. I don't see an elegant way to handle this
>   inline in a .rst file. This can easily be handled in Makefiles
>   that are specific to each project.
>
> - It makes use of csv-table which does all the heavy lifting to produce
>   the desired output.
>
> - I have zero experience of extending Sphinx.
>
> I thought about submitting this directly to the libbpf Github project
> and then just linking from the kernel docs to the page about program
> types in the libbpf project docs. But I think it is preferable to master
> the gen-bpf-progtypes.sh script in the kernel tree where it can be
> maintained in the same repo as the libbpf.c source file it parses.

Given the pushback on Makefile changes and the need for this patch to be
compatible with both the kernel tree and the libbpf repo, can I suggest
a pragmatic way forward.

I suggest that I drop the gen-bpf-progtypes.sh script and Makefile
changes from the patchset and just submit static documentation contents
for the table of BPF program types. This would avoid any downstream
breakage when syncing from the kernel tree to the libbpf github
repo. The table of BPF program types can be maintained manually which
should not be a burden going forward. Another benefit would be that the
resulting documentation can be curated more easily than if it were
auto-generated.
