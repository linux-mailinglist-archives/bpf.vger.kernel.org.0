Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755A44CB213
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiCBWO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:14:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B6BE1CD
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:14:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso6026406pjj.2
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1jMb9GFqwTZ8CqJP67nwzhSXDolz0RQo6OOa7SL1lg=;
        b=d+e7ZLHAzijoqCeDwrgJRD2RI3Ou+E2tLmj2TkN+sC2kralf4vBan+ubpRvPco/Orw
         BOnhrPp1006cGGEcglFX4CjtZ4i+sPlc7TTamphnau6bja/w388XWwXsc2JDtN1ByL0m
         cUCMEr7GMRFh6Py7TPefvAChYlCnywMFiiDe1TZl9bqCPWtobFOu5494KnuSOitxSCd8
         dO2NKsef//yj9IayBZkMxaX30+kt14yCr9la2nCocOdCaW+gD8p62Sb2u+uEIvHZo4zW
         7Cy6hXaFfhEOGStGlcdp4KIycaEIW/Np9IjLRFx80J+nD9RKtNYrj8MQyQK2RfChIsJs
         6nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1jMb9GFqwTZ8CqJP67nwzhSXDolz0RQo6OOa7SL1lg=;
        b=5Ed1VBG4wK5W525/txgkFN1BD2wiZgz8jDG8Gltm0rDm2Pvc2Exm4TBHU+LW9D7OWH
         mABIY7fbfFSyKcla7/iiISBhYJySw+H7/eL+kJ++FJ9Qmz0HvNdK+MC8lQ3w1iKwdfvF
         lxjWlmZJeI/Kz5kBYg9mGheEd5UXU44YSJZbvxhxBMre4eI7sqm8yQ3e1M8diqMbTOiF
         GyvM9AUTWh2zDDHIOsXFKE63hbsdqH1n04osK9FxGK80kJqYgaTtdaNTdKq/A3kBP9kb
         5TJZ4bKxy8Bjv1jkDzMWcSdzPkE7DQoR5QbrYv2PlfY9FCSfzWCBLVXCtcXHrrOklb02
         4IoQ==
X-Gm-Message-State: AOAM531GXhIcKg7ttZ+jg2BFMC5xLF1HXWQptB8NjDyZ6YEZLEHrIju7
        EFX/NQd57VZ8RPzQPfc9dq1t03h1b6oHpRJR3Oj0qBOy
X-Google-Smtp-Source: ABdhPJwaoghPJcx19FMD10trrkOLL9oyhdIpFPScbTiIgLCFXDg9jGiGlZeTQJkgPdtVI2FFe3C0As67wMpVb4dOKnM=
X-Received: by 2002:a17:903:32c1:b0:14f:8ba2:2326 with SMTP id
 i1-20020a17090332c100b0014f8ba22326mr32754983plr.34.1646259248205; Wed, 02
 Mar 2022 14:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20220301222745.1667206-1-mykolal@fb.com> <20220302212302.y7ct3xgkpwu4dto3@ast-mbp.dhcp.thefacebook.com>
 <d4e589ac-db4d-b721-580c-120ee524084d@iogearbox.net>
In-Reply-To: <d4e589ac-db4d-b721-580c-120ee524084d@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 14:13:56 -0800
Message-ID: <CAADnVQLEbDrKt-ehyR=FqMfxcWLL0Tg6i7cKY+jjybBJLn+E0w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next] Small BPF verifier log improvements
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Mar 2, 2022 at 1:46 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 3/2/22 10:23 PM, Alexei Starovoitov wrote:
> > On Tue, Mar 01, 2022 at 02:27:45PM -0800, Mykola Lysenko wrote:
> >>              .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >>              .matches = {
> >> -                    {6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {7, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {8, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {9, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {10, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> >> -                    {11, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {12, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> >> -                    {13, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> >> -                    {14, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> >> -                    {15, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> >> +                    {6, "R3_w=scalar(umax=255,var_off=(0x0; 0xff))"},
> >> +                    {7, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> >> +                    {8, "R4_w=scalar(umax=255,var_off=(0x0; 0xff))"},
> >> +                    {9, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> >> +                    {10, "R4_w=scalar(umax=510,var_off=(0x0; 0x1fe))"},
> >> +                    {11, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> >> +                    {12, "R4_w=scalar(umax=1020,var_off=(0x0; 0x3fc))"},
> >> +                    {13, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> >> +                    {14, "R4_w=scalar(umax=2040,var_off=(0x0; 0x7f8))"},
> >> +                    {15, "R4_w=scalar(umax=4080,var_off=(0x0; 0xff0))"},
> >
> > Sorry for the later review.
> > Would "int" be more precise and less verbose than "scalar"?
>
> Could work as well, although in many places today we make use of the term "scalar",
> so developers might be more familiar with it (and more consistent towards the
> verifier type internals).

I was focusing more on users who will see these logs and
would have to interpret them.
I suspect the ratio is 1 developer to 1000 users.
The users have to fight the verifier quite a bit to make the program pass.
I was thinking about "i64" too. That's what llvm is using,
but it's less clear than "int", which should be obvious
for users since they write progs in C.
It's also shorter.

I can live with "scalar" though.
