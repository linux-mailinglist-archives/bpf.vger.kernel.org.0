Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0415E56E9
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIVAF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIVAF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 20:05:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A09C2D6
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:05:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so4117920edd.11
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FjAhVAJFJjpN3PIk+ile+Y8qjq7zS6AoWFkP3QpYDJ0=;
        b=VeZSy/M5rkBQ6xsxownKl5hbWDX0RB3ix6S9IxyOPjdJDEnT+H+fX06dPFbG8c5i5u
         rkxxQlGvEBWvlu0UTfYwNmGWeRrY9ZxYHRDyNJhCGbJI6Hw8TV6SIeNei6k7MK7GKZgg
         OIKc2bukenSo0pcTKEKKhWIVxAuBbOiTYMfZnSXO5nUtvCcdl1qHDoNQEjtlDhMPTo1D
         v5J1IgqNeuUV6l6kLPpR+CJUbJD0ZxI2r4tzNX17hvU43tEQ3QmNV47eX0SLgh6x60V8
         Y6eIcRfp+ia8x6TNKw5HtVDMx8+3n36ss3PHlq+310Q+fgUy0e5RB5dpH9sZyybUE38t
         giOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FjAhVAJFJjpN3PIk+ile+Y8qjq7zS6AoWFkP3QpYDJ0=;
        b=qJDKq3bzZR7xN55qP3EYRBdgGpr3f2iJ0+xZqJvZ01+d4jjpyMTXD/AdAyG+XvK3q+
         VYlAFR5PIx0eE9I+CrbE3HaU5v8lXlGkieKY+/m4j8wlu3rwC+UhZbVn9RSZLf4QymZX
         7P9h2JCz642wWDuyTc09GCUZUK+zNBEwQFL228fW7B8UiulAKQjEWn1q4AKz1Y2BJ4YN
         xlwgHx4odkHr8zUlhfEjgGS/LT6OAQ3Oku+iBLdk1YxyqMd2yGNYdSHXt9sQbSJ9SwDT
         /IFUx/yg2kkUJjFT3aDCVvc6dAZJ4CXzQGzqcS6grasn97bPId1GLyWO2nfiFKkQ/H0P
         80+g==
X-Gm-Message-State: ACrzQf2i14ogmPSYqIUoqob8YM8dWsoSTtfkDlpnYM3v45t5gcUd10Lp
        BjMMfSnXG2+DUHFP7eisJ1V38rqDM2PghuQxBR8=
X-Google-Smtp-Source: AMsMyM4u81lnWtCSSj8nqW1ZvDzhFkh1mcPcXhTDflQ1Ig3Qy4ZsVsL6M3oZtbj41nhKmSl+8vGlt108AWxz9B8AMOY=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr579301edb.333.1663805154222; Wed, 21
 Sep 2022 17:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220910025214.1536510-1-yhs@fb.com> <Yxz1GvdTlVKrN6Aq@google.com>
In-Reply-To: <Yxz1GvdTlVKrN6Aq@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Sep 2022 17:05:43 -0700
Message-ID: <CAEf4BzaFCSU-yw_ybcsLG7kLdt_mWYrfgV688io-Gdw0bxW_dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Improve BPF_PROG2 macro code quality and description
To:     sdf@google.com
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 10, 2022 at 1:35 PM <sdf@google.com> wrote:
>
> On 09/09, Yonghong Song wrote:
> > Commit 34586d29f8df ("libbpf: Add new BPF_PROG2 macro") added BPF_PROG2
> > macro for trampoline based programs with struct arguments. Andrii
> > made a few suggestions to improve code quality and description.
> > This patch implemented these suggestions including better internal
> > macro name, consistent usage pattern for __builtin_choose_expr(),
> > simpler macro definition for always-inline func arguments and
> > better macro description.
>
> Not sure if Andrii wants to take a look, if not feel free to use:
>

Andrii wanted to :) But thanks for looking and acking as well.

I've slightly reformatted the "doccomment" for BPF_PROG2 and also
removed other uses of quadruple underscore for consistency. Thanks.
Applied to bpf-next.


> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >   tools/lib/bpf/bpf_tracing.h | 77 ++++++++++++++++++++++---------------
> >   1 file changed, 47 insertions(+), 30 deletions(-)
>
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index 8d4bdd18cb3d..a71ca48ea479 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -438,39 +438,45 @@ typeof(name(0)) name(unsigned long long *ctx)
> >           \
> >   static __always_inline typeof(name(0))                                          \
> >   ____##name(unsigned long long *ctx, ##args)
>
