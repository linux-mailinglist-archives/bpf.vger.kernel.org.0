Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F38546EE3
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiFJU5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiFJU5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 16:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8139A649
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D265B61A4D
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43343C34114
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654894660;
        bh=tONv7Qq1252XU1CTpWEtzbmzYOyTRnGmubKhiX3BSZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AQPoiOm8mGWMBApGNz++qTFQNbJ9Hl6eTbo3HG0/R365RBpVjsYzQyKvDBofVuM4s
         +lZ3/0RU3HiSEIIuJUnfBZEZIW74KxdTK1A84twhU8rat7DiluDgBAnWPLTrYE7nB4
         q2XkeQsOlJeyzHdczXQz/f++vlF3ewe9qxn7Ql/a4Dp8hTyNgVBzKBa/eyDzGWbn/O
         icsI03ErKstjPhdM1Wk2OkKzvCza6R3uPhwRtpcFSxc/a3XAwo1i2dwZkn6saNU0Ud
         C4q0usHgMCVHs/Pjd7HueJiLr5MH7zgJYdQ4drwJy3eqN/6zn4GuvPQmxku4trAXGB
         2XOnicZOhCJ4A==
Received: by mail-yb1-f176.google.com with SMTP id u99so566246ybi.11
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:57:40 -0700 (PDT)
X-Gm-Message-State: AOAM533frfIxhgkiClebVpJ4BZfq8vr5MxP7ITnJb/NqrkBGTVpo2G2R
        aCr6kMcrZyXlVLF984C9TxZmcR8Dpknlb01+zL8=
X-Google-Smtp-Source: ABdhPJy3kiqAZtBSOVpMhOYVORbXFTmqO7u1QZ66mzK5gwiua6QJYJtwVXdEFTwmht3Jlj+/V/EHHN2hiMqvmL/0tTo=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr45706764yba.389.1654894659390; Fri, 10
 Jun 2022 13:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-5-eddyz87@gmail.com>
 <CAPhsuW5OX43wjLqVppe8_NGEEkJWMpmX9QXGMQ0gMCVHNKLf_g@mail.gmail.com> <a99bc1ffd716ee5ba4f84043e75fdd5a45e11977.camel@gmail.com>
In-Reply-To: <a99bc1ffd716ee5ba4f84043e75fdd5a45e11977.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 13:57:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7UcnTz3k=nPkGtEHshPC-fAPEoGp=fKkwKxQvMOfqrzw@mail.gmail.com>
Message-ID: <CAPhsuW7UcnTz3k=nPkGtEHshPC-fAPEoGp=fKkwKxQvMOfqrzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] selftests/bpf: BPF test_verifier
 selftests for bpf_loop inlining
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 10, 2022 at 12:20 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Fri, 2022-06-10 at 11:14 -0700, Song Liu wrote:
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> > PS: I already acked v3, so you can include it in v4.
>
> Sorry, my first patch, wasn't sure what to do with the ack. Should I
> put it in the changelog or in the commit message?

You can just add it to the commit message, right next to your
Signed-of-by tag.

Thanks,
Song
