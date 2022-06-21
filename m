Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFF553D91
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 23:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355424AbiFUVXu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355875AbiFUVXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 17:23:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4331DEB
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:14:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so30052051ejj.12
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gtNpvBodxJLGFXOn/6QntCv7vuXWcF8AOvEH+2zCoyg=;
        b=T2Gp8d+QQEN/XGST7v1qMp5ASnEnY7efs7emU+CQq0g5Au679t+dG0GXl0IuxPcv2U
         AH6GENi+iI321dJ8u5vVEAaEaDTqyFm+peg2r9Bfte8bbOtz1t0rGsid9whFzN+0eJFk
         JG1N3PgSKvLB0rj9QovIMFd9452aRZ0tQ6PkwYB+j2XfD0Uek9LrDWaAOqjcZERQQWPi
         QfhMYSN3AbeIaMFPVLJA4ReUFLoInKvmKNt7N5zgik8NaInxdiI39u6IEwLSvQmUk/e/
         vhHFvg6C+/nbYk6ZMeHDnowywnskn+X5iNP9chSb7uutWlUTpvWBDhAk3+8b939Tlfi9
         wiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gtNpvBodxJLGFXOn/6QntCv7vuXWcF8AOvEH+2zCoyg=;
        b=js3iifPe8El45DIiI6NG+xZ12/aafZrpAsEhigLAw4jYJJIxrKr2yG1Dh3MH3JwQTW
         n4oS//1bqP6g9pJBGwJX3/IwnZ+fSfvlecK67fRnJF8kZipclso9DCpgY0NNVOiUPmuI
         RNOl10Y0egEtPmJn6K3p+n5GRDkc/IYYKWLkPhojf7S/JtTkNSWcn4iSzVzFknFPdDyl
         4G3UfS6j6r144YDr2+DDUFtlbNFumW0eDmDfRleXoNlJiZUkw4tVRJ/avE2nlhXkOXdd
         m+dwxI2QJ1AzDDCIgwjxxZx1SLNRPVzO45/iy9c+AXTpEOdqx+YRMNuTgMFdLNrWr6Xp
         5tQg==
X-Gm-Message-State: AJIora/t+7aO/LIa8UC851sqPYSRd9pjsBX8jgn0UAH6RepddyGbrdMV
        HPzA7lYcEb/4AFWxICT335gShukilIpnB6dnWv4=
X-Google-Smtp-Source: AGRyM1tCmgqHmCXqE1V4S08YYZDMApsYCrHIjGpJH+p4OSucTyBSEvq7EY8Bw5yKi2j4xVWMdXbC09W9JZW6f+migy0=
X-Received: by 2002:a17:906:530b:b0:722:e9ad:e90 with SMTP id
 h11-20020a170906530b00b00722e9ad0e90mr43125ejo.676.1655846074509; Tue, 21 Jun
 2022 14:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220620231713.2143355-1-deso@posteo.net> <20220620231713.2143355-5-deso@posteo.net>
 <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com>
 <20220621164556.4zh5yajzlvf6mglo@muellerd-fedora-MJ0AC3F3>
 <CAADnVQJKiiFafS5R3-3RmKCRNxWzLuqhqyahRN=eyM4dsg07-A@mail.gmail.com> <20220621211058.urhntwkf64yn546a@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220621211058.urhntwkf64yn546a@muellerd-fedora-MJ0AC3F3>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jun 2022 14:14:22 -0700
Message-ID: <CAADnVQKbWR7oarBdewgOBZUPzryhRYvEbkhyPJQHHuxq=0K1gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 2:11 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Tue, Jun 21, 2022 at 11:44:17AM -0700, Alexei Starovoitov wrote:
> > On Tue, Jun 21, 2022 at 9:46 AM Daniel M=C3=BCller <deso@posteo.net> wr=
ote:
> > >
> > > On Mon, Jun 20, 2022 at 04:59:19PM -0700, Alexei Starovoitov wrote:
> > > > On Mon, Jun 20, 2022 at 11:17:10PM +0000, Daniel M=C3=BCller wrote:
> > > > > +int bpf_core_types_match(const struct btf *local_btf, __u32 loca=
l_id,
> > > > > +                    const struct btf *targ_btf, __u32 targ_id)
> > > > > +{
> > > >
> > > > The libbpf and kernel support for types_match looks nearly identica=
l.
> > > > Maybe put in tools/lib/bpf/relo_core.c so it's one copy for both?
> > >
> > > Thanks for the suggestion. Yes, at least for parts we should probably=
 do it.
> > >
> > > Would you happen to know why that has not been done for
> > > bpf_core_types_are_compat equally? Is it because of the recursion lev=
el
> > > tracking that is only present in the kernel? I'd think that similar r=
easoning
> > > applies here.
> >
> > Historical. Probably should be combined.
> > Code duplication is the source of all kinds of maintenance issues
> > and subtle bugs.
>
> Certainly. I noticed that btf.c's bpf_core_types_are_compat uses direct e=
quality
> check of the local and target kind while libbpf.c's version utilizes
> btf_kind_core_compat, which treats enum and enum64 as compatible. I suspe=
ct that
> may be a bug in the former.

Great catch. Indeed that does look like a bug that slipped in
due to code duplication :(

> Will move the implementation then. Thanks!
>
> Cc: Yonghong Song <yhs@fb.com>
