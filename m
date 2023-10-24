Return-Path: <bpf+bounces-13153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC87D5AD1
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626B71C20BA3
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE23A299;
	Tue, 24 Oct 2023 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kqj8MJYk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206D3588A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 18:42:52 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EBB10CB
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:42:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so2146a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698172968; x=1698777768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09epGMxkhhjkdYiw8KiYrXokGkqZWFd0a0WWXHQ6/zM=;
        b=Kqj8MJYkyul1ZOwP802BG3+Y4g+ksBOBskIt2PCkuuMJ0aBkI+mNNLyvhwukZHtiXM
         VkseY0e4JT3qAAvdMZ1KNT4RoAPIHanq1/lRmyPtmNBM0d9JHmQQLX6wU9SCyehfdS73
         eUXT55LTUccCYf32OBfv8/QUqLo42fJfX98r1OM4/1MDeCvhacT8vs0r0WxcC7Dj4UsD
         rTvYnKrx4hz0ZbehcXiSe4A32Res0OT6QPB7QreN7J6zFOJ775X6bGbT5PcRQL3gdkqm
         R3+UYIiOR5UB/Ux3ugwubMKPVTw6PEoYKujILK3mxDwuX4jF4apxevKArViMSmVRqAvh
         FBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172968; x=1698777768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09epGMxkhhjkdYiw8KiYrXokGkqZWFd0a0WWXHQ6/zM=;
        b=A/aqNYadSobNJu4ZsqRAr5ftLQeHLEBmsubf2BQMGa0oVAnDp7gMRXg2LaSMcMJ/s9
         MBy/qlO9QcMnZ9QQ/N2NJNXPt68tlYVinYB9rEAU07DWj5sIE8ZmCfoE1YUhfmf9aAWx
         2RSRIAuKoCyuvpUvvw6Kysz8ftfmojSrn6Fca8LuHkZ3MycGJgNAKzIb5kMUFezALc+i
         N5UiPh80F+bnBhvE8IvlRsZoaCwB3xI4PHJVkGlhoK9hpUHD88O3cngOoaBLYJCEK0tp
         gfofXcm9c3xHxGLw4AQZ67cSkKe6JzkDVrJ3+TLL+lSa0VwtIJeZn9WEcGe6Ba2HXw9v
         9+dg==
X-Gm-Message-State: AOJu0Yz3g9UDs9aixMtYgYSlckFh8bkpjO4Hu/dv3yTKsbvGgWS8snox
	6BMBW0y0kfBcLvgnE1aAzxa5xptT0sAXMLMTBkEFdg==
X-Google-Smtp-Source: AGHT+IE5v1BzRWSVw3HW3sQr5xbR/mk1XD9T6KKRACBF8MxbgyF/bGD65mmBKo24Nf0gi8DonjtanmEogkSujhKR/0k=
X-Received: by 2002:a05:6402:288e:b0:540:9e44:483f with SMTP id
 eg14-20020a056402288e00b005409e44483fmr115978edb.4.1698172967814; Tue, 24 Oct
 2023 11:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-11-irogers@google.com>
 <f184e872-4673-419d-9ea8-2d449d9cfd5b@intel.com>
In-Reply-To: <f184e872-4673-419d-9ea8-2d449d9cfd5b@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 11:42:33 -0700
Message-ID: <CAP-5=fXcQwBk=JBof=MMB7LDoutXEvAkB2FbF46jo2xk3tS6QQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] perf record: Lazy load kernel symbols
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 4:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 12/10/23 09:23, Ian Rogers wrote:
> > Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> > changed it so that loading a kernel dso would cause the symbols for
> > the dso to be eagerly loaded. For perf record this is overhead as the
> > symbols won't be used. Add a symbol_conf to control the behavior and
> > disable it for perf record and perf inject.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-inject.c   | 4 ++++
> >  tools/perf/builtin-record.c   | 2 ++
> >  tools/perf/util/event.c       | 4 ++--
> >  tools/perf/util/symbol_conf.h | 3 ++-
> >  4 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index c8cf2fdd9cff..1539fb18c749 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -2265,6 +2265,10 @@ int cmd_inject(int argc, const char **argv)
> >               "perf inject [<options>]",
> >               NULL
> >       };
> > +
> > +     /* Disable eager loading of kernel symbols that adds overhead to =
perf inject. */
> > +     symbol_conf.lazy_load_kernel_maps =3D true;
>
> Possibly not for itrace kernel decoding, so:
>
>         if (!inject->itrace_synth_opts.set)
>                 symbol_conf.lazy_load_kernel_maps =3D true;

Thanks, added to v3.

Ian

> > +
> >  #ifndef HAVE_JITDUMP
> >       set_option_nobuild(options, 'j', "jit", "NO_LIBELF=3D1", true);
> >  #endif
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index dcf288a4fb9a..8ec818568662 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
> >  # undef set_nobuild
> >  #endif
> >
> > +     /* Disable eager loading of kernel symbols that adds overhead to =
perf record. */
> > +     symbol_conf.lazy_load_kernel_maps =3D true;
> >       rec->opts.affinity =3D PERF_AFFINITY_SYS;
> >
> >       rec->evlist =3D evlist__new();
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index 923c0fb15122..68f45e9e63b6 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *threa=
d, u8 cpumode, u64 addr,
> >       if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL && perf_host) {
> >               al->level =3D 'k';
> >               maps =3D machine__kernel_maps(machine);
> > -             load_map =3D true;
> > +             load_map =3D !symbol_conf.lazy_load_kernel_maps;
> >       } else if (cpumode =3D=3D PERF_RECORD_MISC_USER && perf_host) {
> >               al->level =3D '.';
> >       } else if (cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL && perf_g=
uest) {
> >               al->level =3D 'g';
> >               maps =3D machine__kernel_maps(machine);
> > -             load_map =3D true;
> > +             load_map =3D !symbol_conf.lazy_load_kernel_maps;
> >       } else if (cpumode =3D=3D PERF_RECORD_MISC_GUEST_USER && perf_gue=
st) {
> >               al->level =3D 'u';
> >       } else {
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 0b589570d1d0..2b2fb9e224b0 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -42,7 +42,8 @@ struct symbol_conf {
> >                       inline_name,
> >                       disable_add2line_warn,
> >                       buildid_mmap2,
> > -                     guest_code;
> > +                     guest_code,
> > +                     lazy_load_kernel_maps;
> >       const char      *vmlinux_name,
> >                       *kallsyms_name,
> >                       *source_prefix,
>

