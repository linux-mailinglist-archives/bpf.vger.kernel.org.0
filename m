Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF76C8F5E
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 17:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCYQQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYQQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 12:16:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC64C01
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 09:16:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y35so2792880pgl.4
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679760998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr+o4eZNSVkG5Ipy9yDl4J7AUwzMnf/Oth7la+us8IM=;
        b=GmE5c6MTJx5XcxEpx51q2/svkheG5p//tpCynK3Vx4iacdtUc8J0mB4fWbOU27z+yi
         9L1GPgKMLOZO62AU6PXiD4znGtb+j1eTkKI4MlnJjYpiUdrxyUcglfAMW5I48kRn1u3L
         6EkO936RIjBmgQm53vT44aTwoaN8NraX3ZrzvDkiLrAdsQkhhr9o+nK2Uo9LtjSnTy3P
         tfwBsZI2Oif/R0ePkGMpoD34eLlUPxE7mt4Fb0Y/PvRqC6RI0qdf62ykZHcsWSOgcO0F
         heMhJfAXbI6Qk+dl0HbgT/sd7LaqOjwh66mvS0WgfsaKG1aLdEEhZAJwicviGwEX5TMM
         ELyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679760998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr+o4eZNSVkG5Ipy9yDl4J7AUwzMnf/Oth7la+us8IM=;
        b=aLrbT59BjpDYeHGqbJNVcvXvclFWL07DDZF2JJzyCXQCobTdbvxv+MD21F59+BeB6/
         GoWVaWuwin9h3MT1xITOIWNX/tpKAjPY+HlX6MzpKGN0pKIG6QXbVSHMteFU/HqG5Kta
         QkfBQKSqgv07ZpIhBNXa7/cUhvp/Ps/xnNdbJCHXFRyo2qTJ/l1WjuLrmMwpXX0lu3He
         L2Ptb+h0ttxF46topAapSe5u1Uq0QIpUsn36HvRrttbkBKM2iY/llvFgfqiR0sfHbS6t
         5Rv1mfc+20JpwVi2+cjIVuPy9mtk4fSO/+djnGiu4usAOK9WIoO/zIPYXPrglmSfW5Vc
         h49w==
X-Gm-Message-State: AAQBX9fERdTTqnLgxqeC++Z0mGLGY16kD9b4F9m+sFEoSUAjTVtgFGwa
        X2Xv8ktunvEKnKUbdWVNiV1MTXLZ3+ikRm4DGEcXRg==
X-Google-Smtp-Source: AKy350Yg0185+4fEBRr8RhOB9BbHgMh7b40e9aluRerM8HdUTr8Cwb2iJ1847V+YKQZbVXipreUpKpo18C4KwAFNQjY=
X-Received: by 2002:a63:5201:0:b0:4fc:2058:fa29 with SMTP id
 g1-20020a635201000000b004fc2058fa29mr1649572pgb.1.1679760997808; Sat, 25 Mar
 2023 09:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
In-Reply-To: <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Sat, 25 Mar 2023 09:16:26 -0700
Message-ID: <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 5:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-03-24 at 20:23 -0700, Stanislav Fomichev wrote:
> > On 03/25, Eduard Zingerman wrote:
> > > This is a follow up for RFC [1]. It migrates a first batch of 38
> > > verifier/*.c tests to inline assembly and use of ./test_progs for
> > > actual execution. The migration is done by a python script (see [2]).
> >
> > Jesus Christ, 43 patches on a Friday night (^_^)
> > Unless I get bored on the weekend, will get to them Monday morning
> > (or unless Alexei/Andrii beat me to it; I see they were commenting
> > on the RFC).
>
> Alexei and Andrii wanted this to be organized like one patch-set with
> patch per migrated file. I actually found the side-by-side comparison
> process to be quite painful, took me ~1.5 days to go through all
> migrated files. So, I can split this in smaller batches if that would
> make others life easier.
>
> Also the last patch:
>
>   selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline =
assembly
>
> was blocked because it is too large. I'll split it in two in the v2
> (but will wait for some feedback first).

Oh, sorry, I was joking and didn't mean this as a call to split it up.
Was mostly trying to set the expectation that I'll be slacking off on
the weekend :-)
(plus it seems like Alexei/Andrii would like a take a look anyway)

> [...]
>
> > Are those '\' at the end required? Can we do regular string coalescing
> > like the following below?
> >
> > asm volatile(
> >       "r2 =3D *(u32*)(r1 + %[xdp_md_data]);"
> >       "r3 =3D *(u32*)(r1 + %[xdp_md_data_end]);"
> >       "r1 =3D r2;"
> >       ...
> > );
> >
> > Or is asm directive somehow special?
>
> Strings coalescing would work, I updated the script to support both
> modes, here is an example of verifier/and.c converted this way
> (caution, that test missuses BPF_ST_MEM and has a wrong jump, the
>  translation is fine):
>
> https://gist.github.com/eddyz87/8725b9140098e1311ca5186c6ee73855
>
> It was my understanding from the RFC feedback that this "lighter" way
> is preferable and we already have some tests written like that.
> Don't have a strong opinion on this topic.

Ack, I'm obviously losing a bunch of context here :-(
I like coalescing better, but if the original suggestion was to use
this lighter way, I'll keep that in mind while reviewing.

> Pros for '\':
> - it indeed looks lighter;
> - labels could be "inline", like in the example above "l0_%=3D: r0 =3D 0;=
".
> Cons for '\':
> - harder to edit (although, at-least for emacs, I plan to solve this
>   using https://github.com/twlz0ne/separedit.el);
> - no syntax highlighting for comments.
>
> Pros for string coalescing:
> - easier to edit w/o special editor support;
> - syntax highlighting for comments.
> Cons for string coalescing:
> - a bit harder to read;
> - "inline" labels look super weird, so each labels takes a full line.
>
> [...]
