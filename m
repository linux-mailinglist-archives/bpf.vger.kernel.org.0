Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F056F0E54
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjD0W2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjD0W2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:28:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED935BD
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:28:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so11287195a12.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634528; x=1685226528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7ooR+mmzJmti7b/0suxo47dopLeFknPmNBcCRGVJ1g=;
        b=KSDBFd/OI4Fk7eNZleTBWqVZEiav3iW8SjNHOIMyizyJy/XjNg2U+mlUIy/nIsJF3m
         eTWJF0FcizLTj4w4J02ef3cRx58q6fEbnb1DJSZf8RFvSDUzGyZtkET7ZmKKHEj76FSu
         /9YOTP0au+K9Zh80q+O0H4MEpSvz7NaqjaUvFbdESGpTfW1Hbn/9nXzAS6E6brnNOIyv
         1Mud5vEWbr5rVEddyio4Wpz/JWdhc8wRph3gfAqC4n9A3XjKJ9yGY9BuHPXHj+d4o4Db
         mb2S5ULLrDByMEHRnseT2pK5p4Dn8I0LrowMhNk8oGqGTervVK7AWWbY1x7gQ42P4u5/
         Lb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634528; x=1685226528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7ooR+mmzJmti7b/0suxo47dopLeFknPmNBcCRGVJ1g=;
        b=JCrpdvFLBOdoIZsJzg3P0C29urHI5kHkmPgCOhnhTzQIvKPzukBLpPjInw6XpDr7bV
         1hEDfieuZJkF9Yf4gLz9yYrIJOV1ytVjpuhxMAEobs2ICO1ASGWlsqiN/Szqzg52tofq
         94/FmQWLpaj49o/1vHuASnro7oDz6HlUdZf4M6r5ffuleRiwQEXHDLSM4tHnv6pE89O4
         IPp0ZSvl5IMZ2fmDiKiginvKio42yFzOT52xVz9DUhWHVavu/o4ODHi85eHjPWTEGZZx
         an+uLOIDLO3xh5V8warr2znS4UoMerE6yqmgHuUqTAgaWcduPz5O6qPOty2Q8lwiWkfa
         F21w==
X-Gm-Message-State: AC+VfDx1n30PFgNm6S042cUF+zZZVwKZIvqdOuSscP1eXOyEc7BX5qvD
        x7fZe0cFR11obwEwMeKgIdxgjfk663NtJ0UF9gE=
X-Google-Smtp-Source: ACHHUZ6DkarN1+tQGFEJYWXoZvsFxc+Evd/vjrPKWNyNb0k01Yk5/QFCU4EEu4asksciUPYthNadJNkYWIdjxbRlvbc=
X-Received: by 2002:a05:6402:42c8:b0:506:71bd:3931 with SMTP id
 i8-20020a05640242c800b0050671bd3931mr8230224edc.2.1682634528226; Thu, 27 Apr
 2023 15:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-7-jolsa@kernel.org>
 <CAEf4Bza8L7YKbVvNAsRn_RDKx8PuHYZpO7HSWuZuubioEsEmbQ@mail.gmail.com> <ZEp3bfmJG2HBe2rK@krava>
In-Reply-To: <ZEp3bfmJG2HBe2rK@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 15:28:36 -0700
Message-ID: <CAEf4BzZu7nnviv1KHUNBRCEufzLiE9NV+oDZ41VRU0M3acWRrg@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 06/20] libbpf: Factor elf_for_each_symbol function
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Thu, Apr 27, 2023 at 6:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Apr 26, 2023 at 12:27:31PM -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Currently we have elf_find_func_offset function that looks up
> > > symbol in the binary and returns its offset to be used for uprobe
> > > attachment.
> > >
> > > For attaching multiple uprobes we will need interface that allows
> > > us to get offsets for multiple symbols specified either by name or
> > > regular expression.
> > >
> > > Factoring out elf_for_each_symbol helper function that iterates
> > > all symbols in binary and calls following callbacks:
> > >
> > >   fn_match - on each symbol
> > >              if it returns error < 0, we bail out with that error
> > >   fn_done  - when we finish iterating symbol section,
> > >              if it returns true, we don't iterate next section
> > >
> > > It will be used in following changes to lookup multiple symbols
> > > and their offsets.
> > >
> > > Changing elf_find_func_offset to use elf_for_each_symbol with
> > > single_match callback that's looking to match single function.
> > >
> >
> > Given we have multiple uses for this for_each_elf_symbol, would it
> > make sense to implement it as an iterator (following essentially the
> > same pattern that BPF open-coded iterator is doing, where state is in
> > a small struct, and then we call next() until we get back NULL?)
> >
> > This will lead to cleaner code overall, I think. And it does seem func
> > to implement it this (composable) way.
>
> ok, I'll check the open-coded iterator for this

Do check it, as it's a useful thing on BPF side. But tl;dr for libbpf
internal use we could do something like:

struct elf_iter {
    Elf *elf;
    size_t next_sym_idx;
};

and in the code the use will be something like

struct elf_iter;
elf_iter_init(*iter, elf); /* sets next_sym_idx to 0 */

while ((sym =3D elf_iter_next(&iter))) {
   /* use sym */
}


And we can tune the returned result to have symbol index, etc, of course.



>
> >
> > Also, I think we are at the point where libbpf.c is becoming pretty
> > bloated, so we should try to split out coherent subsets of
> > functionality into separate files. ELF helpers seem like a good group
> > of functionality  to move to a separate file? Maybe as a separate
> > patch set and/or follow up, but think about whether you can do part of
> > that during refactoring?
>
> right, sounds good, will check
>
> thanks,
> jirka
>
> >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 185 +++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 114 insertions(+), 71 deletions(-)
> > >
> >
> > [...]
