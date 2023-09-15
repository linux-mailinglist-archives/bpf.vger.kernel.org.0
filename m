Return-Path: <bpf+bounces-10158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130F7A23DB
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DC91C20D54
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B78125B2;
	Fri, 15 Sep 2023 16:47:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1611CAF
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:47:35 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CDE69
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:47:34 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ab2436b57dso1422385b6e.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694796453; x=1695401253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF9YS+ehaF+t5NpFvOnVvaBghLCf/gM6bVST9fQJ4mY=;
        b=u3QdTJHR09KzqRSIGHVE2aHDlpNujKI6o+DvV2kifsIu7VESfhAMGu+Bl67fuwwMUY
         2ukS1Z/ybHbecXe0AME1btEheLPx3NtWIq1P7fGrJgHSC2zz9h5YSmwQDpQ7auu0Fl19
         wBEQKv6twZfIhrHcNIoY9uMBtvyhVC9bO0IdkC9Y+/smOEP8HjPj5b86pi5MJfxMCyWE
         Reihae5yB/hej5iW4FWQItW+zgqDoDDnrJMkV/xp971IQmUhEnojGRFlc2hL2tZsaat+
         9ZaPOKBXhIOmdfJ0qgpTG4B/PbL7dt6TtBrf7BPkz0fq3OvSrdfA3KKh7uzXUKx+JSeq
         KB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796453; x=1695401253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF9YS+ehaF+t5NpFvOnVvaBghLCf/gM6bVST9fQJ4mY=;
        b=SzSVhVCFRhIGy6rUEXQBR4tiF4EI9xF3r8M21IjYNDTdGx7DaiwfUCjUaKMDRJAuZ4
         HROGeVUUuk4VaQANlu+NxU/kJls57/4X1R+aKAMWctg9Ud2FfLS8lcu4o48PGFkhREgE
         fNx4w0MHcg7cmb0bnGbC9UFOMnJp32p8bUhO/vc7bmRXZpLGdur09Sct/qbZuKjf/mZb
         +6j5WpEhkn2drev5AWWXGRRK7+AT9MDckuJK61OJ8/YdObeLC8iBBtwBjndqTa/kOHg4
         HjNOjGA8xzQwjeWGr4robcNH6Me4SwrM+gLR/AUMF8a+0Bcm0wKn9tUpXLRaNFCdrWwF
         j7sA==
X-Gm-Message-State: AOJu0Yy9pTWqH7yEhzXLrL8gX5NjK9+tSpv8R+KUq4p2kELKR0zlKcEI
	3jsdjYLWPaQuNVQDstTMhpO81U0pxiOJVAzBQDqQ5g==
X-Google-Smtp-Source: AGHT+IFvL2eD//es1+Vlrx72iJXEbG1iWd4k5Qmr5WyFLT5JxMTHytrk/S/0QC6X0oR8TKe+Okc61Jc/op6Uj4KT4Zc=
X-Received: by 2002:a05:6871:281:b0:1c0:937:455d with SMTP id
 i1-20020a056871028100b001c00937455dmr2658921oae.47.1694796453154; Fri, 15 Sep
 2023 09:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava> <ZQLBm8sC+V53CIzD@krava> <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
 <ZQLX3oSCk95Qf4Ma@krava> <CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com>
 <ZQQVr35crUtN1quS@krava>
In-Reply-To: <ZQQVr35crUtN1quS@krava>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Sep 2023 09:47:18 -0700
Message-ID: <CAKwvOdk0i5fXACA5ZBn0ZLK4jvoXn6X3VjSjfOTc6R=+owNB1g@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 1:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 14, 2023 at 11:14:19AM -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 14, 2023 at 2:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Sep 14, 2023 at 05:30:51PM +0900, Masahiro Yamada wrote:
> > >
> > > SNIP
> > >
> > > > > > so the change is about adding unique id that's basically path o=
f
> > > > > > the object stored in base32 so it could be used as symbol, so w=
e
> > > > > > don't really need to read the actual file
> > > > > >
> > > > > > the problem is when BTF_ID definition like:
> > > > > >
> > > > > > BTF_ID(struct, cgroup)
> > > > > >
> > > > > > translates in 2 separate objects into same symbol name because =
of
> > > > > > the matching __COUNTER__ macro values (like 380 below)
> > > > > >
> > > > > >   __BTF_ID__struct__cgroup__380
> > > > > >
> > > > > > this change just adds unique id of the path name at the end of =
the
> > > > > > symbol with:
> > > > > >
> > > > > >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4D=
GF5UGK3DQMVZHG
> > > > > >
> > > > > > so the symbol looks like:
> > > > > >
> > > > > >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > > > > >
> > > > > > and is unique over the sources
> > > > > >
> > > > > > but I still hope we could come up with some better solution ;-)
> > > > >
> > > > > so far the only better solution I could come up with is to use
> > > > > cksum (also from coreutils) instead of base32, which makes the
> > > > > BTF_ID_BASE value compact
> > > > >
> > > > > I'll run test to find out how much it hurts the build time
> > > > >
> > > > > jirka
> > > >
> > > >
> > > >
> > > > Seems a bad idea to me.
> > > >
> > > > It would fork a new shell and chsum for all files,
> > > > while only a few of them need it.
> > >
> > > right, I have a change to limit this on kernel and net directories,
> > > but it's still bad
> > >
> > > >
> > > > Better to consult BTF forks.
> > >
> > > perhaps there's better way within kbuild to get unique id/value
> > > for each object file?
> >
> > let's just use __LINE__ + __COUNTER__ for now and teach resolve_btfids
> > to fail and complain loudly about duplicate symbols?
>
> ok, will send that.. but it fails during link before resolve_btfids
> takes place
>
> >
> >
> > This will give us time and opportunity to implement a better approach
> > to .BTF_ids overall. Encoding the desired type name in the symbol name
> > always felt off. Maybe it's better to encode type + name as data,
> > which is discarded at the latest stage during vmlinux linking? Either
>
> hum, so maybe having a special section (.BTF_ids_desc below)
> that would have record for each ID placed in .BTF_ids section:
>
> asm(                                           \
> ".pushsection .BTF_ids,\"a\";        \n"       \
> "1:                                  \n"       \
> ".zero 4                             \n"       \
> ".popsection;                        \n"       \
> ".pushsection .BTF_ids_desc,\"a\";   \n"       \
> ".long 1b                            \n"       \
>
> and somehow get prefix and name pointers in here:
>
> ".long prefix
> ".long name
>
> ".popsection;                        \n");
>
> so resolve_btfids would iterate .BTF_ids_desc records and fix
> up .BTF_ids data..
>
> we might need to do one extra link phase to get rid of the
> .BTF_ids_desc secion

It should be ok to keep it in vmlinux as we do for DWARF debug info.

We'd want to make sure it's not retained in the compressed image
though. Pretty sure `strip` is used to drop DWARF from the compressed
image, but `strip` isn't going to recognize the semantics of some new
ad-hoc ELF section.  Pretty sure `objcopy` can be used to drop ELF
sections; we'd need to probably invoke `objcopy` explicitly to drop
that section (or add any new section to any pre-existing list of
sections to drop).

>
> > way, this baseid hack seems worse and unnecessary.
>
> yes, it's bad
>
> jirka



--=20
Thanks,
~Nick Desaulniers

