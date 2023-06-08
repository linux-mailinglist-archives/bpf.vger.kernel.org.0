Return-Path: <bpf+bounces-2073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1E727390
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30D72812F1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D37ED0;
	Thu,  8 Jun 2023 00:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03411EA3
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 00:00:36 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06912126
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 17:00:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9768fd99c0cso243267266b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686182433; x=1688774433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM5i03jiG99SrvQyFRcDMqNDNnf9ezu/SBgCLTrxEaM=;
        b=CBkjW1r3mUGyC0B4hNaW0hqpv1wWuNdN2O8vCaa+CXu7md9IY7OnPw98nmeX0aCnGs
         PxtD5uxsKgnh8aE65VB4qKMxsNZHrLush1urlMfWkC5OzYlEiKWE3OS0KvIqd4G0h4fZ
         0RjI0YrFLis2XZqoosV36kBbLwLEKJQ64Io9FTLnF4JSfUAaBZObTEHuRFdlbfUGQITc
         89j2WrzSTJP9uorsdFUBB3g2ezlaRyACD0D/ovoHVVnkO7CeMWTn49e4QOQ2K1PqaHXu
         52GWH2n4F5TMnNgrPlpwlrNgYj9+VrhwcDG7JbU/sthAXCiZK9725Co7AzM/9LydamPN
         WGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686182433; x=1688774433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM5i03jiG99SrvQyFRcDMqNDNnf9ezu/SBgCLTrxEaM=;
        b=Q5aiKrQUCgc/4pFoHGAatl14VLdWTMs/Jw1w58q/oWWt/fnlciR4XydRdIABAcckPK
         sMioRH7gEsp1IcDjrWd8SzK4upVnpie+p53eUVNpCJ8Wjiv8qRYs5nUcP3izX1hyugtp
         BE5X0SRDAGoxzKo8ADJSl+GYCVCbsmSfcDxLgyq/14ykQeHRY0y2kkGcMBzpk6k4osYx
         R6FWNEpf5e5Q4TWxSbuDwAP5USc+OUDJBY80vcfLhJtrM4wH5b+P9JbT4E1UF6SmZwqP
         nB5HFQAVofVnvgvdyqFlk0CGiMa+O/ITVXX8gTMhqM2DTexa1WCdzR9JaTu/RVu04Yfw
         9ImQ==
X-Gm-Message-State: AC+VfDyy1JnTbAjWazbTJXPWFMbqgojJY2bf5UU1uE7VDommwnhnUGpE
	2ZqzeA8SPJGfuMnP4VneYdeQy9QORq4BQXI2is2mK6EWUnw=
X-Google-Smtp-Source: ACHHUZ7EYWxGvXwNrRdrxvdOJXFDlwLkV7KQ5+yAVXHLTXvaJkGDV4BkTza2c8CH2qWH6jHBgdDGZ2J3A7lcQv+nkqc=
X-Received: by 2002:a17:907:7eaa:b0:965:aa65:233f with SMTP id
 qb42-20020a1709077eaa00b00965aa65233fmr557516ejc.2.1686182433033; Wed, 07 Jun
 2023 17:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZG8f7ffghG7mLUhR@krava> <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev> <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
 <ZIERQNxgXWvgxHNO@krava>
In-Reply-To: <ZIERQNxgXWvgxHNO@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 17:00:21 -0700
Message-ID: <CAEf4BzaNpxNZ12N1JY4=EijXv14oWQMQpjF8t4zt-ZaYNp+U=Q@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with available_filter_functions
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 4:22=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Jun 02, 2023 at 10:27:31AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 25, 2023 at 6:38=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> =
wrote:
> > >
> > > Hi Andrii.
> > >
> > > =E5=9C=A8 2023/5/26 04:43, Andrii Nakryiko =E5=86=99=E9=81=93:
> > > > On Thu, May 25, 2023 at 3:28=E2=80=AFAM Jackie Liu <liu.yun@linux.d=
ev> wrote:
> > > >>
> > > >> From: Jackie Liu <liuyun01@kylinos.cn>
> > > >>
> > > >> When using regular expression matching with "kprobe multi", it sca=
ns all
> > > >> the functions under "/proc/kallsyms" that can be matched. However,=
 not all
> > > >> of them can be traced by kprobe.multi. If any one of the functions=
 fails
> > > >> to be traced, it will result in the failure of all functions. The =
best
> > > >> approach is to filter out the functions that cannot be traced to e=
nsure
> > > >> proper tracking of the functions.
> > > >>
> > > >> Use available_filter_functions check first, if failed, fallback to
> > > >> kallsyms.
> > > >>
> > > >> Here is the test eBPF program [1].
> > > >> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e53=
3b8b3eadde97f7a4535e867
> > > >>
> > > >> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > > >> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > >> ---
> > > >>   tools/lib/bpf/libbpf.c | 92 ++++++++++++++++++++++++++++++++++++=
+-----
> > > >>   1 file changed, 83 insertions(+), 9 deletions(-)
> > > >>
> > > >
> > > > Question to you and Jiri: what happens when multi-kprobe's syms has
> > > > duplicates? Will the program be attached multiple times? If yes, th=
en
> > > > it sounds like a problem? Both available_filters and kallsyms can h=
ave
> > > > duplicate function names in them, right?
> > >
> > > If I understand correctly, there should be no problem with repeated
> > > function registration, because the bottom layer is done through fprob=
e
> > > registration addrs, kprobe.multi itself does not do this work, but
> > > fprobe is based on ftrace, it will register addr by makes a hash,
> > > that is, if it is the same address, it should be filtered out.
> > >
> >
> > Looking at kernel code, it seems kernel will actually return error if
> > user specifies multiple duplicated names. Because kernel will
> > bsearch() to the first instance, and never resolve the second
> > duplicated instance. And then will assume that not all symbols are
> > resolved.
>
> right, as I wrote in here [1] it will fail
>
> [1] https://lore.kernel.org/bpf/ZHB0xNEbjmwHv18d@krava/
>
> >
> > So, it worries me that we'll switch from kallsyms to available_filters
> > by default, because that introduces new failure modes.
>
> we did not care about duplicate with kallsyms because we used addresses,
> and I think with duplicate addresss the kprobe_multi link will probably
> attach (need to check) while with duplicate symbols it won't..
>
> perhaps we could make sure we don't pass duplicate symbols?

I think we have to stick to kallsyms and addresses. What if I actually
want to attach to all instances of type_show? We should take into
account available_filter_functions, but still use addresses from
kallsyms.

I'd also advocate working on having an available_filter_functions
version reporting not just function names, but also its associated
address. That would actually eliminate the need for kallsyms.

I chatted with Steven Rostedt about this at the last LSF/MM/BPF
conference, and I think we both agreed that we both a) have all the
information in the kernel to implement this and b) it's a good idea to
expose all that to user space. For backwards compat reasons it will
have to be a separate file, but it's generated on the fly, so it's not
a big deal in terms of resource usage.


>
> we do the kprobe_multi bench with symbol names read from available_filter=
_functions
> and we filter out duplicates
>
> jirka
>
> >
> > Either way, let's add a selftest that uses a duplicate function name
> > and see what happens?
> >
> > > The main problem here is not the problem of repeated registration of
> > > functions, but some functions are not allowed to hook. For example, w=
hen
> > > I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid =
are
> > > not allowed to hook. These exist under kallsyms, but
> > > available_filter_functions does not, I have observed for a while,
> > > matching through available_filter_functions can effectively prevent t=
his
> > > from happening.
> >
> > Yeah, I understand that. My point above is that a)
> > available_filter_functions contains duplicates and b) doesn't contain
> > addresses. So we are forced to rely on kernel string -> addr
> > resolution, which doesn't seem to handle duplicate entries well (let's
> > test).
> >
> > So it's a regression to switch to that without taking any other precaut=
ions.
> >
> > >
> > > >
> > > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > >> index ad1ec893b41b..3dd72d69cdf7 100644
> > > >> --- a/tools/lib/bpf/libbpf.c
> > > >> +++ b/tools/lib/bpf/libbpf.c
> > > >> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, =
const char *pat)
> > > >>   struct kprobe_multi_resolve {
> > > >>          const char *pattern;
> > > >>          unsigned long *addrs;
> > > >> +       const char **syms;
> > > >>          size_t cap;
> > > >>          size_t cnt;
> > > >>   };
> > > >>
> >
> > [...]

