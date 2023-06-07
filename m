Return-Path: <bpf+bounces-2047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B17271D4
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F4228160E
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF23B3ED;
	Wed,  7 Jun 2023 22:38:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAB3B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 22:38:08 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7D9E
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 15:38:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso98039a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686177481; x=1688769481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUFyqZMmusJrr0+ash9sZJH7RAq/x8BCibei5JLpKaQ=;
        b=HlJGFyqQXr01t0DwwPqXKj0Lb6LZRckSAvV4f350RcqyCU4RWTzf8xn2pezNKrFsh2
         Op8U4wBZcw2Dc24o9/DbZPnXQnDvRzn45RPpVDN5CQcctYV9DL4rjhIzcPX3NA5RM+6B
         KSoRd5RwRi/V00EUgbK/duzfyEf6UjbFY4+P9Qa3kUV3H2Bv5jaA505T1H3yvpEps3Cd
         IkKb1dH11O9iJMCPTQj9vO6vPTyKSNDmLVi0gIX5lILzmwJ7P9vrbtMTKmmvozRaWU4p
         uPKMrj+g96fK0dAEQT1JiV/bRTP3WesgnsNiKKf0GLT3+4xIJOKCh8jrmRMD5Awzj+G0
         2EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177481; x=1688769481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUFyqZMmusJrr0+ash9sZJH7RAq/x8BCibei5JLpKaQ=;
        b=V/wwoz8ahswRClD+O/YZuFOm+1l+eD3zpN7WzOVL4sibKOfTMfVTMmEUSOlQ9MfENu
         cPKu/BF5MOPIQp6iTl939BJc+n8ATSVVauPuCWH+VjXs476vZS2MmGlgk7ZIcUs06XQ6
         snFC01vq/W77lry0tFP44qJJ/Mj+Vg2btTI60327Gb5vJq2/KiO49tdJWRGq08jHtzpm
         8ogNU25jYAAADFl3IZWCXtnbKjCg7j5wvwvk3VP+EJshDInCU9/9IEBhwYPXKjJNxps6
         kWUoXdlb+7FGWa5gf2pMJZWpeU1tFcjplr9XJvFq8TgdvKUWt5vP0TH6PR8ibcK7U/qv
         8FiA==
X-Gm-Message-State: AC+VfDxd7Zbj3NgjRyfvA263NDn2uCU37hEbgfQH3QU0aIbRWF979sUs
	Rw1BUwC9X+EhhBzlyOyYbJ+tYcYbZbXP6T+/Vhg=
X-Google-Smtp-Source: ACHHUZ4l4gAI0N/AXg/bQ5Yt29xIYayatU3aF9WsyWWLR+0KN57meH3is/xfLIshgS1dblhf5D7HXrV43YGO1nfIOdQ=
X-Received: by 2002:aa7:d3c8:0:b0:50b:c456:a72a with SMTP id
 o8-20020aa7d3c8000000b0050bc456a72amr385171edr.19.1686177481516; Wed, 07 Jun
 2023 15:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZG8f7ffghG7mLUhR@krava> <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev> <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
 <77d8aaef-5c63-641e-6019-dec1f3f078d8@linux.dev>
In-Reply-To: <77d8aaef-5c63-641e-6019-dec1f3f078d8@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 15:37:49 -0700
Message-ID: <CAEf4BzbxEzfO4vJn7e6xGUPCdTxpGVdwc7eXOUNpYxb9mpAjNw@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with available_filter_functions
To: Jackie Liu <liu.yun@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 11:01=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wrot=
e:
>
> Hi Andrii.
>
> =E5=9C=A8 2023/6/3 01:27, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, May 25, 2023 at 6:38=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> =
wrote:
> >>
> >> Hi Andrii.
> >>
> >> =E5=9C=A8 2023/5/26 04:43, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Thu, May 25, 2023 at 3:28=E2=80=AFAM Jackie Liu <liu.yun@linux.dev=
> wrote:
> >>>>
> >>>> From: Jackie Liu <liuyun01@kylinos.cn>
> >>>>
> >>>> When using regular expression matching with "kprobe multi", it scans=
 all
> >>>> the functions under "/proc/kallsyms" that can be matched. However, n=
ot all
> >>>> of them can be traced by kprobe.multi. If any one of the functions f=
ails
> >>>> to be traced, it will result in the failure of all functions. The be=
st
> >>>> approach is to filter out the functions that cannot be traced to ens=
ure
> >>>> proper tracking of the functions.
> >>>>
> >>>> Use available_filter_functions check first, if failed, fallback to
> >>>> kallsyms.
> >>>>
> >>>> Here is the test eBPF program [1].
> >>>> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b=
8b3eadde97f7a4535e867
> >>>>
> >>>> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> >>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >>>> ---
> >>>>    tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++=
-----
> >>>>    1 file changed, 83 insertions(+), 9 deletions(-)
> >>>>
> >>>
> >>> Question to you and Jiri: what happens when multi-kprobe's syms has
> >>> duplicates? Will the program be attached multiple times? If yes, then
> >>> it sounds like a problem? Both available_filters and kallsyms can hav=
e
> >>> duplicate function names in them, right?
>
> I don't have any idea, I tested it on my own device, and they don't have
> duplicate functions.
>
> =E2=95=AD=E2=94=80jackieliu@jackieliu-PC ~/gitee/ketones/src
> =E2=95=B0=E2=94=80=E2=9E=A4 sudo cat /sys/kernel/debug/tracing/available_=
filter_functions | awk
> -F' ' '{print $1}' | wc -l
>
> 81882
> =E2=95=AD=E2=94=80jackieliu@jackieliu-PC ~/gitee/ketones/src
> =E2=95=B0=E2=94=80=E2=9E=A4 sudo cat /sys/kernel/debug/tracing/available_=
filter_functions | awk
> -F' ' '{print $1}' | uniq | wc -l
>
> 81882

hm... I'm pretty sure there are plenty:

$ sudo cat /sys/kernel/debug/tracing/available_filter_functions | grep
-v __ftrace_invalid_address | sort | uniq -c | sort -nr | head -n10
     14 type_show
     12 init_once
     11 modalias_show
      8 event_show
      7 name_show
      6 enabled_show
      5 version_show
      5 size_show
      5 offset_show
      5 numa_node_show


>
> >>
> >> If I understand correctly, there should be no problem with repeated
> >> function registration, because the bottom layer is done through fprobe
> >> registration addrs, kprobe.multi itself does not do this work, but
> >> fprobe is based on ftrace, it will register addr by makes a hash,
> >> that is, if it is the same address, it should be filtered out.
> >>
> >
> > Looking at kernel code, it seems kernel will actually return error if
> > user specifies multiple duplicated names. Because kernel will
> > bsearch() to the first instance, and never resolve the second
> > duplicated instance. And then will assume that not all symbols are
> > resolved.
>
> I wrote a test program myself, but it cannot be attached normally, and
> an error will be reported.
>
> const char *sysms[] =3D {
>      "vfs_read",
>      "vfs_write",
>      "vfs_read",
> };
>
> when attach_kprobe_multi, -3 returned.
>
> >
> > So, it worries me that we'll switch from kallsyms to available_filters
> > by default, because that introduces new failure modes.
>
> In fact, this is not a new problem introduced by switching from kallsyms
> to available_filters. If kallsyms also has duplicate functions, then
> this problem will also exist before.

It is, because currently when we parse kallsyms we remember function
addresses, which are unique. We don't rely on kernel string -> addr
resolution.

>
> >
> > Either way, let's add a selftest that uses a duplicate function name
> > and see what happens?
>
> Hi Jiri, Do you mind write a self-test program for duplicate function? I
> saw that it has been written before.
> for some reason, I failed to compile kselftest/bpf successfully on
> fedora38 and Ubuntu2004. :<
>
>
> >
> >> The main problem here is not the problem of repeated registration of
> >> functions, but some functions are not allowed to hook. For example, wh=
en
> >> I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid a=
re
> >> not allowed to hook. These exist under kallsyms, but
> >> available_filter_functions does not, I have observed for a while,
> >> matching through available_filter_functions can effectively prevent th=
is
> >> from happening.
> >
> > Yeah, I understand that. My point above is that a)
> > available_filter_functions contains duplicates and b) doesn't contain
> > addresses. So we are forced to rely on kernel string -> addr
> > resolution, which doesn't seem to handle duplicate entries well (let's
> > test).
>
> Yes, the test for repeated functions reports errors. If there is an
> interface similar to available_filter_functions, which contains the
> function name and function address, and ensures that it is not
> duplicate, then it is a good speedup for eBPF program, because using
> 'strdup' to record the function name consumes a certain amount of
> startup time.
>
> >
> > So it's a regression to switch to that without taking any other precaut=
ions.
> >
>
> Yes, agree.
>
> --
> BR, Jackie Liu
> >>
> >>>
> >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>>> index ad1ec893b41b..3dd72d69cdf7 100644
> >>>> --- a/tools/lib/bpf/libbpf.c
> >>>> +++ b/tools/lib/bpf/libbpf.c
> >>>> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, co=
nst char *pat)
> >>>>    struct kprobe_multi_resolve {
> >>>>           const char *pattern;
> >>>>           unsigned long *addrs;
> >>>> +       const char **syms;
> >>>>           size_t cap;
> >>>>           size_t cnt;
> >>>>    };
> >>>>
> >
> > [...]

