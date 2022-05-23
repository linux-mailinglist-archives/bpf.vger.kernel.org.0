Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43B531C46
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiEWScG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 14:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbiEWSas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 14:30:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4F149165
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 11:05:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s23so16079798iog.13
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hEZ0SLZqkb+4njl47hhZJ/bl4+/t9hX6T5xlTxC0ecc=;
        b=DDMSWjmjwqQ0UMhcR4HjDsvUczf7UcBxHR0ux1zr0zhtg0jlFq1oAJR0iV8PxMRwox
         uliiHQdOoi45cUhauwlcYmV+w8xM2DX7D+MAsG5K/ufRLFkRuzUc7ldF3B7hBomTKGnO
         GlqSJF2Vgrgm7cVQLnU40DI5e/gCJ7DjQ0rt00tNuDJJNorO7JCPH4yVW2Cgp1IniiwB
         /9uHv6qQTH2p0XoY27UyiGOCtdK7JCeXCsF/iK2kdjMNda0jr58T73td/r73qzHEvZ3N
         YCJokL75nLn+TBRaT9qaIwYzPDOA3dDPNt3xTDRSfoSNx3X8psem86ERHpd4i2P1Y/Aj
         8n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hEZ0SLZqkb+4njl47hhZJ/bl4+/t9hX6T5xlTxC0ecc=;
        b=sXXZ8TN6R+FTCd4iGNcG6g7F2MQlcb5rbqNwYvMj6bxDx0pHVSC09as2F2x1kF2rb7
         RP22Y125VBHVaGEBbryCAsPXkEN0maB9NbnbdAGNXbbyPyO0r/YN1/ZRzLpwM6HxkFml
         BjOUpS8psGpI4+u9+M40xKbZlzNhS6oyLE7ImeXstXF/Ay56p1g1RhbJ3IeJ19ibPt6A
         d02eYSb8yyxM9V3yp7ogPzS8uqzzpYy7zGbkFaRmrsA+uK7qSYcCP2yqpvnukwpNF8NZ
         JJvSRGiXmuN3yGMlIIq3p3x+AuvD+d+6w4f+gJ/3Zmw4yt+lOaRKFi85jjC25cU08Q30
         oBBw==
X-Gm-Message-State: AOAM532F/+z1DY/azyub8zExIUSeNw55eLAOgpgYa2Dr+doXaDZNrlnQ
        QWUJ5UW6PLCCZqiE546nfA3IyvmxI1yvcRfsU+3/DPES
X-Google-Smtp-Source: ABdhPJyo3EkNA44bxYmONsTiz0GC+dG2DyIqsBXdzQqv0Z0amX8S3jenUsVwatGhlqilURNTFbNQo9vW/rUuKLq6rTk=
X-Received: by 2002:a05:6638:2393:b0:32e:319d:c7cc with SMTP id
 q19-20020a056638239300b0032e319dc7ccmr12030471jat.103.1653329118914; Mon, 23
 May 2022 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220519213001.729261-1-deso@posteo.net> <20220519213001.729261-10-deso@posteo.net>
 <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
In-Reply-To: <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 May 2022 11:05:08 -0700
Message-ID: <CAEf4BzYr1Bi4QGXHH2zYQO-tGNw=08vJnfHE1mogS+jAUka6Ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/12] bpftool: Use libbpf_bpf_attach_type_str
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Mon, May 23, 2022 at 4:48 AM Quentin Monnet <quentin@isovalent.com> wrot=
e:
>
> 2022-05-19 21:29 UTC+0000 ~ Daniel M=C3=BCller <deso@posteo.net>
> > This change switches bpftool over to using the recently introduced
> > libbpf_bpf_attach_type_str function instead of maintaining its own
> > string representation for the bpf_attach_type enum.
> >
> > Note that contrary to other enum types, the variant names that bpftool
> > maps bpf_attach_type to do not follow a simple to follow rule. With
> > bpf_prog_type, for example, the textual representation can easily be
> > inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> > remaining string. bpf_attach_type violates this rule for various
> > variants.
> > We decided to fix up this deficiency with this change, meaning that
> > bpftool uses the same textual representations as libbpf. Supporting
> > test, completion scripts, and man pages have been adjusted accordingly.
> > However, we did add support for accepting (the now undocumented)
> > original attach type names when they are provided by users.
> >
> > For the test (test_bpftool_synctypes.py), I have removed the enum
> > representation checks, because we no longer mirror the various enum
> > variant names in bpftool source code. For the man page, help text, and
> > completion script checks we are now using enum definitions from
> > uapi/linux/bpf.h as the source of truth directly.
> >
> > Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> > ---
> >  .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
> >  .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
> >  tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
> >  tools/bpf/bpftool/cgroup.c                    |  49 ++++--
> >  tools/bpf/bpftool/common.c                    |  82 ++++-----
> >  tools/bpf/bpftool/link.c                      |  15 +-
> >  tools/bpf/bpftool/main.h                      |  17 ++
> >  tools/bpf/bpftool/prog.c                      |  26 ++-
> >  .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++++----------
> >  9 files changed, 213 insertions(+), 178 deletions(-)

[...]

> >  static enum bpf_attach_type parse_attach_type(const char *str)
> >  {
> > +     const char *attach_type_str;
> >       enum bpf_attach_type type;
> >
> > -     for (type =3D 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> > -             if (attach_type_name[type] &&
> > -                 is_prefix(str, attach_type_name[type]))
> > +     for (type =3D 0; ; type++) {
> > +             attach_type_str =3D libbpf_bpf_attach_type_str(type);
> > +             if (!attach_type_str)
> > +                     break;
> > +             if (is_prefix(str, attach_type_str))
>
> With so many shared prefixes here, I'm wondering if it would make more
> sense to compare the whole string instead? Otherwise it's hard to guess
> which type =E2=80=9Cbpftool c a <cgroup> cgroup_ <prog>=E2=80=9D will use=
. At the same
> time we allow prefixing arguments everywhere else, so maybe not worth
> changing it here. Or we could maybe error out if the string length is <=
=3D
> strlen("cgroup_")? Let's see for a follow-up maybe.
>

Let's make string match exact for new strings and keep is_prefix()
logic for legacy values? It's better to split this loop into two then,
one over new-style strings and then over legacy strings.

> > +                     return type;
> > +
> > +             /* Also check traditionally used attach type strings. */
> > +             attach_type_str =3D bpf_attach_type_input_str(type);
> > +             if (!attach_type_str)
> > +                     continue;
> > +             if (is_prefix(str, attach_type_str))
> >                       return type;
> >       }
> >
>

[...]
