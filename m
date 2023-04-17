Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DCD6E4A24
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDQNmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjDQNmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 09:42:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5B1FEE
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 06:42:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f32588c13so93591266b.2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681738924; x=1684330924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7q804lvwVfzVDb04S7d3arCFTMYVaFz/3CbX2I4M+g=;
        b=PTdEhXsvOAH0NPbH1KvjkZ30CxIHea9a8M5x6iGhsGoklYTu1JOGyiFtJX7SBQ6/Pa
         vs4nXR2w66a9tH/pLotuNt1vTLJLChWL7bCGco6Fn2ot9MZG+7dX8RuPqp9zuVeJTuKS
         zd8m4H8fbbi2iI4HKkjtQsJIC/p0yj4RM+OsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738924; x=1684330924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7q804lvwVfzVDb04S7d3arCFTMYVaFz/3CbX2I4M+g=;
        b=FmYZ6gzsuDA6hkw3K15rTD/4vrAQGdtyojcoZeBSaRRclPE00/flBiIPdsOxjDcMrw
         KNVPJuZski5ubwBELLhWP26NkDm4oCzDbgsxukdFq4b4XdPPexbvXAFOSPin7lUF/UrP
         l5xEfOF6spqbByBj43YPP2PBPfE78cFFVGvYh2yJQ7DoIEZs4AwwWjGzNJ7EN6Ee9oih
         6CFsRxhvm3i0YOjnASsRposYnRUbhq6KkKoCiBgUo55hSp6AHErBDJy/AQvIsiQw9ZTO
         J5nOdAyudOmws5q+XilLGAS4P0FDFySmx3C9k3viMl+9UQ9gPMy0CQLGlbpBUUQSJX76
         uITA==
X-Gm-Message-State: AAQBX9fHIjEkyFTDp1r8B1m4VGbVSoqo796+ViAa7vEZAI+I3CsiHgJL
        Vv8kzPvCa6hZwKUk1PGCuNv2Xq2U0CAV3xKVOCC2nvynGneITSoh
X-Google-Smtp-Source: AKy350Zg3QLHvnw/95Q6vTliZqLHidyDkByatnyFjttjBqUdRRoocqimA7oznXx8BAS5QIBs7O/4aw1cWeaH5bWr/TA=
X-Received: by 2002:a50:9f88:0:b0:4fb:7e7a:ebf1 with SMTP id
 c8-20020a509f88000000b004fb7e7aebf1mr7231823edf.6.1681738922075; Mon, 17 Apr
 2023 06:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk> <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk> <CAHApi-m4gu8SX_1rBtUwrw+1-Q3ERFEX-HPMcwcCK1OceirwuA@mail.gmail.com>
 <87o7nrzeww.fsf@toke.dk> <CAJ8uoz3Rts2Xfhqq+0cm3GES=dMb2hTqPzGm515oG_nmt=-Nbg@mail.gmail.com>
 <87o7nmwul7.fsf@toke.dk>
In-Reply-To: <87o7nmwul7.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 17 Apr 2023 15:46:46 +0200
Message-ID: <CAHApi-nSpUSVjeAX=UQEYGd2=H+DJ+xQYPvP8yQMuosGq22-Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > We will measure it and get back to you. Would be good with some
> > numbers.
>
> Sounds good, thanks! :)
>
> -Toke
>

+1. Thanks a lot for doing this! :-)
