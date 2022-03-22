Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E14E481D
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiCVVJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiCVVJp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:09:45 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666745513
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:08:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e22so21668308ioe.11
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BEWIiGK1tCJ2lS8RS72fhv7dzDEzgFSz/TvXE7x02w=;
        b=WoKT6g4TefBSmyvbSqxyWtXMin7Fpo25Rf30ACmprM3gF2T7jgAb/+k83w2PfsT8hr
         FnJo6Jabid+Z8LpyanvfU0J78B2v2Maca6mL0b5U8rSAGNkUVC1dnjKDCeazVv/PqirI
         bemE9muQsdQeVRMWrtWZW8gQEB5B5O0DuvKxVD0/wBvVJ7eiZBe7FIR0GOk2zGVtJKbP
         Kp2RjVrdq4Hy32X7hghq5Jd4cYc4t3aRxhqbHP60q4qCIN/COJ/9JsQL3mef93IRPcdm
         54xMHibyBg/wpj2AAx7zteCZUJIQqBJVMsqhaJzzIV64GNt3m0ond60V6kq2cemQ6i2D
         eiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BEWIiGK1tCJ2lS8RS72fhv7dzDEzgFSz/TvXE7x02w=;
        b=LWFYOp7QktTHT0RYnpANn5ioflwcBy0hc7xK5jIuzYwJdPAUiM9ndZh5Ynf0uxf2fG
         76yFIoPRPhRSfV+UDNMmT+a/PklVyZsxXFry9SgGOx7vfkt2CmF8tNe2wZNcF5LqBGJU
         DY7oR0otzaCvRj5xv7nNxRX3t7SQ8gjyb51s7mO6RLISFaA9n5bBEYj+CDZQEIRh3I4/
         QW8O2c06D2qpW7a5tGBKKlpXM1AkWM6AhkQS5UUWrBBqdyk5Je92ybacLuMMVgzVXedG
         jim50Zf1UQJ2DGLaiJyIoeJAOTWYjJK17wNCJAu9Atbi0B+5jE+bvmhqoYmacHp0LjaM
         I/Dw==
X-Gm-Message-State: AOAM532yw5BjRkrdW4krAKAyjPdQnNpYolx7cq2LuXKy9fYas3yosjOe
        HDDkXiUvkA9XIHj6rnLc1rlhvTOICnbBSUvl66Qr9xUv
X-Google-Smtp-Source: ABdhPJxtMWspU1qSvCemzKnhMM3MjkVYkUFL5X2s4D8y14W4OV6a9dxGtPehicuLEIHj/msXB5j2adoJ6bE0uYWRCc4=
X-Received: by 2002:a5d:948a:0:b0:645:b742:87c0 with SMTP id
 v10-20020a5d948a000000b00645b74287c0mr12871001ioj.79.1647983295930; Tue, 22
 Mar 2022 14:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
 <CAEf4Bzbtcyj-ciXzJVL3QV6mbbyA_6Nec8m_8rgz190dcxH4Yg@mail.gmail.com> <47c30c3f2f1a149e343252c6a84f219b552bba4f.camel@fb.com>
In-Reply-To: <47c30c3f2f1a149e343252c6a84f219b552bba4f.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 14:08:04 -0700
Message-ID: <CAEf4BzZo7QPPAUXaO=8xwt3kE1yCbYgbfGu3TrQJvCiy83FP1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 8:30 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-03-21 at 16:08 -0700, Andrii Nakryiko wrote:
> > On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > @@ -1291,6 +1294,7 @@ struct bpf_cg_run_ctx {
> > >  struct bpf_trace_run_ctx {
> > >         struct bpf_run_ctx run_ctx;
> > >         u64 bpf_cookie;
> > > +       struct bpf_run_ctx *saved_run_ctx;
> > >  };
> >
> > oh, and bpf_trace_run_ctx is used for kprobe/uprobe/tracepoint, let's
> > add a new struct bpf_tramp_run_ctx which would reflect that it is
> > used
> > for BPF trampoline-based BPF programs. Otherwise it's confusing to
> > have saved_run_ctx for kprobe where we don't use that. Similarly, if
> > we move "start" timestamp, it will be a bit off. Not end of the
> > world,
> > but I think keeping them separate would make sense over long run.
>
> Ok!
>

We discussed this start timestamp with Alexei offline and concluded
that it's better to leave start as is, as we don't really store start
on the stack (we keep it in register), so moving it into run_ctx won't
give us any benefits.
