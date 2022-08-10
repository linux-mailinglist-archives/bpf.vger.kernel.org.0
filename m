Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6758E44E
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiHJA6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJA6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:58:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478847E83E
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:58:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i14so25088768ejg.6
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZUcobGidrex6BhHOo/kMgHAezmMq+DZ/uLamG0WyS4g=;
        b=duEDcrijZhQJaUkhOOEMPKJJWzLlTheZGQaANB8pA/z8mMkZOnwyOPibExvaD6XiDu
         XIF4NhtpY2LSVTSkLNd5+d0z5mjiE5cWAsaE4b1AHLtFXiLiBs5jbtZuhpUT/nf7B6yO
         Ozw41iXNRTrrL+LUJ42QiHclit4JvrLx45PnGeIrePU4OZ+tU/iVfBwCcM0KlGbozfmD
         5f+Hi7cZLo0n4qlB9oIr95O6G1lojtFX4f7aSmma6LZOQBpLjfm0rxyZSJTMU8gDVS3H
         k7wThHVxlX8OKwHQr9B9Aupah6sKtHmfapfggMMzX2OhmzcCZrB4OyHTFrG/3GU8HO7Q
         XTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZUcobGidrex6BhHOo/kMgHAezmMq+DZ/uLamG0WyS4g=;
        b=DDkg9z5oJFakCWT7qLiLcafjofdu6tlpq2cJpLTTouQ0cvGkPEvuZjMUKpp8YFoWvu
         N8xe6c0/z9g5J/aDmB0DsksvPlTcZE0ZE2UtxdNTgtBkzkKLVqEqW+4pXBLOGeHCSWc2
         gwz21sEP9IwRz5YtGecuoPSM4e1ud2XPir+/BOXWTDANW4vgAJooD3UA5H+TvHzBsul5
         IcRook3ZE5I4uW5UgqFZ8c4ADUfPDlqghTYMBmPWwNTNgcHDpi6QwoK+3ujMYxBf0vZp
         MxX5p1GUnz9t9q/VRJvJTEChyqNW94nj2XoNfp5HsZ+yfiiT4jYhfs3hlGSij1eWtD3J
         5VjQ==
X-Gm-Message-State: ACgBeo1ankxdcEelhOC1c71F/f5fghx8J3qftH8S+uRBqvbgeIZ8y653
        ZXg5GPIV5nyl279RiBU55gC63V5ZwXnMvOmiRac=
X-Google-Smtp-Source: AA6agR4ECLpI+FoDmKL0RpBWMyJgC5k0wSDhnCjCyaksKmpMz2m1OsEL+IzYJ9lkxXKh6Hf2X7uARA8UgfRpD0LFKBU=
X-Received: by 2002:a17:907:272a:b0:731:4699:b375 with SMTP id
 d10-20020a170907272a00b007314699b375mr10042733ejl.633.1660093117724; Tue, 09
 Aug 2022 17:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220809213033.24147-1-memxor@gmail.com> <20220809213033.24147-3-memxor@gmail.com>
 <20220809222908.hmy4pz3ai6howqhm@kafai-mbp> <CAADnVQ+X3qxf2ksRSLT0ZK792Pz4LA5xc3G+EPL8cAQEUS=tGA@mail.gmail.com>
 <CAP01T742w_xbDU6muUbPjT11noVgL8ofR5m-7wbjaH-FxXRi3w@mail.gmail.com>
In-Reply-To: <CAP01T742w_xbDU6muUbPjT11noVgL8ofR5m-7wbjaH-FxXRi3w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 17:58:26 -0700
Message-ID: <CAADnVQKr3DMiiKtbABVNV4J4xZx4hH39mx=k8EK06Y8Dv6B5QQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 9, 2022 at 5:52 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 10 Aug 2022 at 02:50, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 9, 2022 at 3:29 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Aug 09, 2022 at 11:30:32PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > The LRU map that is preallocated may have its elements reused while
> > > > another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> > > > only check_and_free_fields is appropriate when the element is being
> > > > deleted, as it ensures proper synchronization against concurrent access
> > > > of the map value. After that, we cannot call check_and_init_map_value
> > > > again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> > > > they can be concurrently accessed from a BPF program.
> > > >
> > > > This is safe to do as when the map entry is deleted, concurrent access
> > > > is protected against by check_and_free_fields, i.e. an existing timer
> > > > would be freed, and any existing kptr will be released by it. The
> > > > program can create further timers and kptrs after check_and_free_fields,
> > > > but they will eventually be released once the preallocated items are
> > > > freed on map destruction, even if the item is never reused again. Hence,
> > > > the deleted item sitting in the free list can still have resources
> > > > attached to it, and they would never leak.
> > > >
> > > > With spin_lock, we never touch the field at all on delete or update, as
> > > > we may end up modifying the state of the lock. Since the verifier
> > > > ensures that a bpf_spin_lock call is always paired with bpf_spin_unlock
> > > > call, the program will eventually release the lock so that on reuse the
> > > > new user of the value can take the lock.
> > > The bpf_spin_lock's verifier description makes sense.  Note that
> > > the lru map does not support spin lock for now.
> >
> > ahh. then it's not a bpf tree material.
> > It's a minor cleanup for bpf-next?
> >
>
> I was just describing what we do for each of the three types in the
> commit log. It still affects timers and kptrs, which lru map supports.

got it.
The uaf-ing cpu can use kptr field of deleted elem
and things go bad it lru_pop-ing cpu will clear it.
