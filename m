Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9F6CD77E
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC2KRl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjC2KRk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 06:17:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A140E4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 03:17:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er13so20064869edb.9
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680085057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUsoW3RlDeSmLirfd4zdIVDvyInwt676ScrlQB20LgM=;
        b=D0V5ovhW7UgHFZJCKb6bYyN5Ue78NZfgYtdfyz/eRNneexCP31KbyRThWngrOxky+u
         JzI49xkHy81UT43remlwGKInYAfwE9fzlkWEIyfGtlurom98KkTjuICCq3xA+xWVPZxt
         O2Iyfe0C1Tk6VOYd6oghst8CaRYpvwTPvaBN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680085057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUsoW3RlDeSmLirfd4zdIVDvyInwt676ScrlQB20LgM=;
        b=A5aYDoUD49bh3460NGGDBvjp8I/BABrlPEPn8OJ+uLGKSxTO8o4kY1dPoJUfT3rqju
         YtmfCLXy3pX2oyhcmvCZmvvD83DPn1/TH4yyEPYd9ow5rDBvtuOfISUAN7qqaWTAkYHb
         euigzovAXSridLNsXCILx4rfmaIFytZotKgAqCdr3t7WmRG2xwJ8KU47Q59hBC+VXrU7
         UYlaRoJPAz3tD0rCy+Kpj0+p5sTNsoJ2hE1Ngglu6+pYbRGDs4VOyfcksbrlAtiRfxoa
         YDlJVnLpk1itrcM3AAOdzbnRfPNCPhisB4NR5IgEIJvzRX0aARPoN6kFu0x7yrul4TY5
         vchw==
X-Gm-Message-State: AAQBX9c7lre+Vhfk1FjeOpcBotC+O3NRczuizUe+bFp51mQ6eL6+g5YZ
        +rHsOfqOXh2cvNTx5s4N8tAULCNW779dmZdBjMIfow==
X-Google-Smtp-Source: AKy350Y8NG0s5Z/5d9gdlVxvU7Msgnu2oy2gX5boMxVFrPZW86La0+oZ0FsIORIVfSj4lMWGgAmC5+ikl/rBxMM1x7s=
X-Received: by 2002:a17:907:3f96:b0:8f1:4cc5:f14c with SMTP id
 hr22-20020a1709073f9600b008f14cc5f14cmr10512672ejc.0.1680085057245; Wed, 29
 Mar 2023 03:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230319195656.326701-1-kal.conley@dectris.com>
 <20230319195656.326701-4-kal.conley@dectris.com> <CAJ8uoz3F-gWzB9vYm-8MtonAv3aBcerJDxPpEDCNfmNkwJFY=A@mail.gmail.com>
 <CAJ8uoz2LU14oCAGSmUMfxMytF0KsiBGK55n+A7qPBuxpXBz6gA@mail.gmail.com>
In-Reply-To: <CAJ8uoz2LU14oCAGSmUMfxMytF0KsiBGK55n+A7qPBuxpXBz6gA@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 29 Mar 2023 12:22:12 +0200
Message-ID: <CAHApi-n8UKmM4kkbS8QQnwiqdKSKTYNpHwZ4eS=HCVMnGeZNTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests: xsk: Add tests for 8K and 9K
 frame sizes
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > TEST_TYPE_UNALIGNED_9K_FRAME
> >
> > > +               if (!hugepages_present(test->ifobj_tx)) {
> > > +                       ksft_test_result_skip("No 2M huge pages present.\n");
> > > +                       return;
> > > +               }
> > > +               test_spec_set_name(test, "RUN_TO_COMPLETION_9K_FRAME_SIZE");
> >
> > UNALIGNED_MODE_9K
>
> _9K_FRAME_SIZE it should have been. Hit send too early.
>

Fixed in the v2 patchset (coming soon).

Kal
