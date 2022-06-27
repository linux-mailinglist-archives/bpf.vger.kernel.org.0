Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD455CA15
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiF0VMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiF0VMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:12:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E9DF39
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:12:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so21733482ejb.6
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fzQy6VDS9PEVy2A635xxoQzG14fo94e8sFrSXZgYG0I=;
        b=bFdWaehpTA/K7L57sD/qfsi1FQ8ltXI16Ji2UJc12cIYQH/JO68Dv+VvFfUJgmkNFY
         nnCWic2IWhinfcka+uIUa6XMOFK2n3X3pIVqVPhAEGXHsjx5PJ9vqgz2vknDwemdG21S
         AVAGTNMCPLUXTnG8I9PmIuaE7Pb2rXS7B72mCm1K4tqT8/2fT/JKcKO5f6CYheTA791l
         lgh9SSNU6hwQkzVraK2bb5NEGtatUGZydiJV0TGUcgfcu6BvR866xRYb4UrKnkWRhrhM
         tjRbk2ATOfQnYJ64zILWOKgmrvx0gCDXCFmxzGbxdCmCXl9IeD5b9Jokbw/9Rl/Jx4Pt
         GW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fzQy6VDS9PEVy2A635xxoQzG14fo94e8sFrSXZgYG0I=;
        b=WRl15CsFXIAwXRLt2tf+SNjqjuZoI1yORRyySowx/brVHixTsrl/W/Lu1Vx91Uu6/p
         Pb+YlVwr95dahnJAF2zb8EgmuFJOXacvIZdnkGv+9o7awN5DziJUuh8z2sFKdV8R+8Jd
         E/8sL1ZVXwZnn0w1znpF/azikUYH81zGgOV3h3L/1tDi0OTia57pS55YIAGq4tIWEMVX
         mPNQx4yVH4n7gltspO8g1nFh/qjxZFoZwsduOc2Hp6hTDBOBC3HrPXhSwbo0o3wVwWi6
         4Tj7B2qMWyq6D4bEri5D9RRsCddH3p2HMSqHzKAVUxpP2tMOFwWWjkOFCAWAs5ZNdM/1
         jT4g==
X-Gm-Message-State: AJIora+iT63f52YSxIwdn9A7N2IdXa6CHivppmFYgUe//A+IuGVQJQ9D
        DrP6y4ApOLL8nT0a/BmR8FNu4dl08cMGQLumbdc=
X-Google-Smtp-Source: AGRyM1sTjejAk/y+YfpDRwqaaNXDXnnVcn7c/ZgPIpK1m/wdbDaiIT7Rq+4EIscZkw/Wux39gYBrwaGunthbK327Jn8=
X-Received: by 2002:a17:907:6eac:b0:726:94ef:5ff3 with SMTP id
 sh44-20020a1709076eac00b0072694ef5ff3mr10944907ejc.545.1656364333339; Mon, 27
 Jun 2022 14:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220620231713.2143355-1-deso@posteo.net> <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
 <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
 <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com> <20220627210305.ugktft5q35fnjpou@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220627210305.ugktft5q35fnjpou@muellerd-fedora-MJ0AC3F3>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jun 2022 14:12:01 -0700
Message-ID: <CAEf4BzaLCh8B6+j4qXk3V2vFVyufax=rzDSwXHBXVgLgpAMNOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Jun 27, 2022 at 2:03 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Fri, Jun 24, 2022 at 02:09:33PM -0700, Andrii Nakryiko wrote:
> > On Wed, Jun 22, 2022 at 10:22 AM Daniel M=C3=BCller <deso@posteo.net> w=
rote:
> > >
> > > On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
> > > > Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?
> > >
> > > Lack of BTF_KIND_TYPEDEF is a good question. I don't know why it's mi=
ssing from
> > > bpf_core_types_are_compat() as well, which I took as a template. I wi=
ll do some
> > > testing to better understand if we can hit this case or whether there=
 is some
> > > magic going on that would have resolved typedefs already at this poin=
t (which is
> > > my suspicion).
> > > My understanding why we don't cover floats is because we do not allow=
 floating
> > > point operations in kernel code (right?).
> >
> > FLOAT is an omission, we need to add it (kernel types do have floats).
>
> [...]
>
> Thanks for clarifying. Let's leave FLOAT support for follow-on changes, t=
hough,
> and not bloat this patch set unnecessarily. It's not currently support by=
 the
> existing libbpf/kernel checks or by bpftool's BTF minimization logic from=
 what I

it seems to be handled by bpf_core_fields_are_compat(), but yeah, we
can do a follow up for this


> can tell -- preferably all of which would need to be updated, tests be ad=
ded,
> etc. This is entirely orthogonal to what is being added here from my
> perspective.
>
> Thanks,
> Daniel
