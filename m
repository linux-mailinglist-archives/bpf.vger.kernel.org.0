Return-Path: <bpf+bounces-2248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF072A235
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A884D1C21179
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990E17AC4;
	Fri,  9 Jun 2023 18:30:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2D21CD4
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 18:30:14 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91F3A81;
	Fri,  9 Jun 2023 11:30:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so3509644a12.0;
        Fri, 09 Jun 2023 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686335411; x=1688927411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQo5qsgPUcGmlyO2rsvI2X/zOsK6NI/XGYG2Pjs5ocQ=;
        b=PBfGgDhGmwDrb3XoBCsHhl1vgR0qXNPyBZOCH0smqKcmnUxY3qoafT5S+OBe3EvfPJ
         JcsuczB/nksBDdysKtvq/YQjIprYBv8pKopIWmBb9lRj/z9UuunQ91hpld1ybv1yzZw7
         sIW/wympb6rkv4YEarGkw7fJDB3zS+gssOBv1AXzrd8iJeDVKKHFAGuJrrGHjowDN8/u
         /ehZGM7ASvyZeZ/eV1isDwlmkRXczPgizAgaRgj7kwuckZA+j1BZXkRDNJtBUDn4yHDV
         opJNYf2OIwhgU0xQeJYu5TfmW+iQ387X3BuaD8mS2eqGB2rX0H//adVaFKFw16UQPGE1
         mkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335411; x=1688927411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQo5qsgPUcGmlyO2rsvI2X/zOsK6NI/XGYG2Pjs5ocQ=;
        b=DFIaZZE/Kmz4Yh9yqVnA1GL+MIsKb2cSfzf5Oo78zAHkw9xbPreTqjsjMNifrrXpwh
         FzKUhlhGIzFum1Cy0BpElfs4DE4u8UvHopiPOnefAEgnK8PoFzprNkEv1HLS+7VLarH5
         wOBwOJheFjpz2uYnARF+VWlCWkRciLWl/hWUgm8PG36PmzPNUz4Eq8J7V/Uvl1/FWE8w
         fol2cwlzkwJisz144UOvC5SzUJi9okcK2Fz0c8Hc2vxj1836aY2OA4Pn4JAmBUMg2qlB
         idxkn/4enLIy2jB9yQ4ntbLYbL1s65LUiO3+WjFHhrbQa/y6HTU6Aa3gACAS2u7shIKO
         rs0g==
X-Gm-Message-State: AC+VfDwSr8WGN90Az4SHDx8pp2kew3Mtp2a2obdmDhCEZoPKgRQOn1+a
	UxXyMDa2oiXQuOuv7zAXDADgYOo7cT3ELYNY+4HmVX3RmUM=
X-Google-Smtp-Source: ACHHUZ7P/m3FTYaf26T03r8XIjRSHEPKt+H8rxF2AlOg8srGmGahQc1w2H60obas9zD3lQxQxFkWqbYdkVFC4ASERmw=
X-Received: by 2002:a17:906:fe4d:b0:973:93e3:bc9a with SMTP id
 wz13-20020a170906fe4d00b0097393e3bc9amr2292627ejb.6.1686335411415; Fri, 09
 Jun 2023 11:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608212613.424070-1-jolsa@kernel.org> <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home> <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
 <ZILhqvrjeFIPHauy@FVFF77S0Q05N> <ZINW9FqIoja76DRa@krava>
In-Reply-To: <ZINW9FqIoja76DRa@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 11:29:59 -0700
Message-ID: <CAEf4BzbgsLOoLKyscq6S95QeehVoAzOnQ=xmsFz8dfEUAnhObw@mail.gmail.com>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in available_filter_functions_addrs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jackie Liu <liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 9:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Jun 09, 2023 at 09:24:10AM +0100, Mark Rutland wrote:
> > On Thu, Jun 08, 2023 at 04:55:40PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Jun 8, 2023 at 4:27=E2=80=AFPM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > > > On Thu, 8 Jun 2023 15:43:03 -0700 Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
> > > > > On Thu, Jun 8, 2023 at 2:26=E2=80=AFPM Jiri Olsa <jolsa@kernel.or=
g> wrote:
> >
> > > There are BPF tools that allow user to specify regex/glob of kernel
> > > functions to attach to. This regex/glob is checked against
> > > available_filter_functions to check which functions are traceable. Al=
l
> > > good. But then also it's important to have corresponding memory
> > > addresses for selected functions (for many reasons, e.g., to have
> > > non-ambiguous and fast attachment by address instead of by name, or
> > > for some post-processing based on captured IP addresses, etc). And
> > > that means that now we need to also parse /proc/kallsyms and
> > > cross-join it with data fetched from available_filter_functions.
> > >
> > > All this is unnecessary if avalable_filter_functions would just
> > > provide function address in the first place. It's a huge
> > > simplification. And saves memory and CPU.
> >
> > Do you need the address of the function entry-point or the address of t=
he
> > patch-site within the function? Those can differ, and the rec->ip addre=
ss won't
> > necessarily equal the address in /proc/kallsyms, so the pointer in
> > /proc/kallsyms won't (always) match the address we could print for the =
ftrace site.
> >
> > On arm64, today we can have offsets of +0, +4, and +8, and within a sin=
gle
> > kernel image different functions can have different offsets. I suspect =
in
> > future that we may have more potential offsets (e.g. due to changes for=
 HW/SW
> > CFI).
>
> so we need that for kprobe_multi bpf link, which is based on fprobe,
> and that uses ftrace_set_filter_ips to setup the ftrace_ops filter
>
> and ftrace_set_filter_ips works fine with ip address being the address
> of the patched instruction (it's matched in ftrace_location)
>
> but right, I did not realize this.. it might cause confusion if people
> don't know it's patch-side addresses..  not sure if there's easy way to
> get real function address out of rec->ip, but it will also get more
> complicated on x86 when IBT is enabled, will check

ok, sorry, I'm confused. Two questions:

1. when attaching kprobe_multi, does bpf() syscall expect function
address or (func+offset_of_mcount) address? I hope it's the former,
just function's address?

2. If rec->ip is not function's address, can we somehow adjust the
value to be a function address before printing it?

In short, I think it's confusing to have addresses with +0 or +4 or +8
offsets. It would be great if we can just keep it +0 at the interface
level (when attach and in available_filter_functions_addrs).

>
> or we could just use patch-side addresses and reflect that in the file's
> name like 'available_filter_functions_patch_addrs' .. it's already long
> name ;-)
>
> jirka

