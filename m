Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F2531A57
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiEWUR0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 16:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiEWURW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 16:17:22 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23F65D28
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:17:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4A4F7240027
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653337039; bh=sCm5IksyEXZTaZQ2tPSM92cYrTP7N02vKT7yfiCiGH8=;
        h=Date:From:To:Cc:Subject:From;
        b=mIdDsQ/+QLwB5+ZIl4HszGfbZBxq3nAqDMXiAncOXdu/LSwl8L0v/ckMYGIRB6sJX
         0SrNiTbBlfDZZpA9tcYIARjvSLdYzu+9IwyyjAsmKUlblTpTsCk4FfHK9oI+MLmKhm
         7HR0YLkQsDm2C5R4mgL9E3730wJXFBxujFc26ukjVXuYM2+ziEqphnYI79pMXyOJyS
         73QsJ+aHU2gQueEqWzz2PvD3ofjy3CAO8070e+wdxYjRXEO4FRpUs0t6dXXCHD4kq5
         m1+pQTP9Sk7Er9iusM9/l+FlK4DJtGjbVUAaUUocAwwkfYn7UoxHm8LCWvNguCKfL0
         Xg7F1vgZJZWBQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6TBz5KYnz6tmS;
        Mon, 23 May 2022 22:17:14 +0200 (CEST)
Date:   Mon, 23 May 2022 20:17:11 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v3 09/12] bpftool: Use libbpf_bpf_attach_type_str
Message-ID: <20220523201711.rqgvvxzqspy2lcgw@muellerd-fedora-MJ0AC3F3>
References: <20220519213001.729261-1-deso@posteo.net>
 <20220519213001.729261-10-deso@posteo.net>
 <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
 <CAEf4BzYr1Bi4QGXHH2zYQO-tGNw=08vJnfHE1mogS+jAUka6Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYr1Bi4QGXHH2zYQO-tGNw=08vJnfHE1mogS+jAUka6Ow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 11:05:08AM -0700, Andrii Nakryiko wrote:
> On Mon, May 23, 2022 at 4:48 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2022-05-19 21:29 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> > > This change switches bpftool over to using the recently introduced
> > > libbpf_bpf_attach_type_str function instead of maintaining its own
> > > string representation for the bpf_attach_type enum.
> > >
> > > Note that contrary to other enum types, the variant names that bpftool
> > > maps bpf_attach_type to do not follow a simple to follow rule. With
> > > bpf_prog_type, for example, the textual representation can easily be
> > > inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> > > remaining string. bpf_attach_type violates this rule for various
> > > variants.
> > > We decided to fix up this deficiency with this change, meaning that
> > > bpftool uses the same textual representations as libbpf. Supporting
> > > test, completion scripts, and man pages have been adjusted accordingly.
> > > However, we did add support for accepting (the now undocumented)
> > > original attach type names when they are provided by users.
> > >
> > > For the test (test_bpftool_synctypes.py), I have removed the enum
> > > representation checks, because we no longer mirror the various enum
> > > variant names in bpftool source code. For the man page, help text, and
> > > completion script checks we are now using enum definitions from
> > > uapi/linux/bpf.h as the source of truth directly.
> > >
> > > Signed-off-by: Daniel Müller <deso@posteo.net>
> > > ---
> > >  .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
> > >  .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
> > >  tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
> > >  tools/bpf/bpftool/cgroup.c                    |  49 ++++--
> > >  tools/bpf/bpftool/common.c                    |  82 ++++-----
> > >  tools/bpf/bpftool/link.c                      |  15 +-
> > >  tools/bpf/bpftool/main.h                      |  17 ++
> > >  tools/bpf/bpftool/prog.c                      |  26 ++-
> > >  .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++++----------
> > >  9 files changed, 213 insertions(+), 178 deletions(-)
> 
> [...]
> 
> > >  static enum bpf_attach_type parse_attach_type(const char *str)
> > >  {
> > > +     const char *attach_type_str;
> > >       enum bpf_attach_type type;
> > >
> > > -     for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> > > -             if (attach_type_name[type] &&
> > > -                 is_prefix(str, attach_type_name[type]))
> > > +     for (type = 0; ; type++) {
> > > +             attach_type_str = libbpf_bpf_attach_type_str(type);
> > > +             if (!attach_type_str)
> > > +                     break;
> > > +             if (is_prefix(str, attach_type_str))
> >
> > With so many shared prefixes here, I'm wondering if it would make more
> > sense to compare the whole string instead? Otherwise it's hard to guess
> > which type “bpftool c a <cgroup> cgroup_ <prog>” will use. At the same
> > time we allow prefixing arguments everywhere else, so maybe not worth
> > changing it here. Or we could maybe error out if the string length is <=
> > strlen("cgroup_")? Let's see for a follow-up maybe.
> >
> 
> Let's make string match exact for new strings and keep is_prefix()
> logic for legacy values? It's better to split this loop into two then,
> one over new-style strings and then over legacy strings.

Okay, let's do that then.

Thanks,
Daniel
