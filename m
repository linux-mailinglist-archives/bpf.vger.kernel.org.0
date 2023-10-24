Return-Path: <bpf+bounces-13154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F537D5B65
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BECB1C20D38
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6AE3CD0C;
	Tue, 24 Oct 2023 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwfGD6xH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910E3CD02
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 19:21:40 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DD10CF
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 12:21:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so2614a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698175296; x=1698780096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhFkfWG3vGEeLM7vOQJLZJ3KgIqwnn5bowVUsiKiagA=;
        b=GwfGD6xHoluNOSsgFx0TMnT4q/vv26uUoDRefxjGctv2OlMRBWDWCMB+elsXfb525n
         zR6k3ZBfkHjbiBsBryqDZywk9tLEWQYe7kpYsaCi5wqZcTjFkaDkKIROTBnJUDAui+Nj
         03amdqCgVyTGMYUfXcWYRKf0CCIeLpazt1ZrNM5jWHnzVsKPWhs9gwcldyzTIgdf6paz
         7Eztr+A43SkYaU/RNJrjhVgKrdKyrs+XL7T2k7Meorw3AnsiUSq17evPYtruPWEQtzqx
         wcRXBabHToQIa2jBn6yKZtJBGdTvO3hCfPgu749g8TMxZv+dPmmZvunytz94CbHHos7u
         D60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698175296; x=1698780096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhFkfWG3vGEeLM7vOQJLZJ3KgIqwnn5bowVUsiKiagA=;
        b=qnnVVx9Ij78BkM+/R8y+AyR9WyYkWrPjzvFkbyjkXWry8S2fRufAqfE5YZASoz28+Q
         MgBX4Ax0MP8IrlXM65O+WqzzH0HOXq0RfzCX0Aw6r5RsA7VNm2VS/UZtHuymrgBLOMV5
         BhKsXCB8atxVowockVd+46GORImbr2jUsacsiCgwfiS5UKGlMQ45IzUDjH7gR4JkBsja
         C71bgg6STuHaVq7P2wzMpBXQscrmHblLnMm1PWxOg/RGxOzPiCaiAneal5G6E9ZL3dpa
         R2gszGywnInMPR4Z/0N8H3z+kCW9dY2ToMKLC5SSk7sNkPyARQ8eA3vPw7EcFBG/lgK6
         1w1g==
X-Gm-Message-State: AOJu0Yw5eMkCDVgnP2DLX3EPjPQa+dmX6V+wlk0tvBtafXVjRa90Nxc0
	/rnvW+Bam7BWYIB4CUXBWfS4i+87LyJn/sb5XkmovQ==
X-Google-Smtp-Source: AGHT+IFGcCboRwqUCDY93lGlGItSSyexcFRFTreeWIsuzBJZ2oNk7r2KYeJ4W2+TFOfiDK5RzlI8c33HHtTCyQfFUUo=
X-Received: by 2002:a50:950b:0:b0:53f:c4d4:6a14 with SMTP id
 u11-20020a50950b000000b0053fc4d46a14mr142452eda.5.1698175295633; Tue, 24 Oct
 2023 12:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-13-irogers@google.com>
 <CAM9d7cgehgF0pXm_7VME0jUo=8dHwRH7_EruGqP7D-CVaj5sEw@mail.gmail.com>
In-Reply-To: <CAM9d7cgehgF0pXm_7VME0jUo=8dHwRH7_EruGqP7D-CVaj5sEw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 12:21:23 -0700
Message-ID: <CAP-5=fULcy+9pY5U_S_19AvSQWKf-y28R9T6G4d6Xw7C3ENM8g@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] perf mmap: Lazily initialize zstd streams
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
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

On Wed, Oct 18, 2023 at 4:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Zstd streams create dictionaries that can require significant RAM,
> > especially when there is one per-CPU. Tools like perf record won't use
> > the streams without the -z option, and so the creation of the streams
> > is pure overhead. Switch to creating the streams on first use.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/compress.h |  1 +
> >  tools/perf/util/mmap.c     |  5 ++--
> >  tools/perf/util/mmap.h     |  1 -
> >  tools/perf/util/zstd.c     | 61 ++++++++++++++++++++------------------
> >  4 files changed, 35 insertions(+), 33 deletions(-)
> >
> > diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
> > index 0cd3369af2a4..9391850f1a7e 100644
> > --- a/tools/perf/util/compress.h
> > +++ b/tools/perf/util/compress.h
> > @@ -21,6 +21,7 @@ struct zstd_data {
> >  #ifdef HAVE_ZSTD_SUPPORT
> >         ZSTD_CStream    *cstream;
> >         ZSTD_DStream    *dstream;
> > +       int comp_level;
> >  #endif
> >  };
> >
> > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > index 49093b21ee2d..122ee198a86e 100644
> > --- a/tools/perf/util/mmap.c
> > +++ b/tools/perf/util/mmap.c
> > @@ -295,15 +295,14 @@ int mmap__mmap(struct mmap *map, struct mmap_para=
ms *mp, int fd, struct perf_cpu
> >
> >         map->core.flush =3D mp->flush;
> >
> > -       map->comp_level =3D mp->comp_level;
> >  #ifndef PYTHON_PERF
> > -       if (zstd_init(&map->zstd_data, map->comp_level)) {
> > +       if (zstd_init(&map->zstd_data, mp->comp_level)) {
> >                 pr_debug2("failed to init mmap compressor, error %d\n",=
 errno);
> >                 return -1;
> >         }
> >  #endif
> >
> > -       if (map->comp_level && !perf_mmap__aio_enabled(map)) {
> > +       if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
> >                 map->data =3D mmap(NULL, mmap__mmap_len(map), PROT_READ=
|PROT_WRITE,
> >                                  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> >                 if (map->data =3D=3D MAP_FAILED) {
> > diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> > index f944c3cd5efa..0df6e1621c7e 100644
> > --- a/tools/perf/util/mmap.h
> > +++ b/tools/perf/util/mmap.h
> > @@ -39,7 +39,6 @@ struct mmap {
> >  #endif
> >         struct mmap_cpu_mask    affinity_mask;
> >         void            *data;
> > -       int             comp_level;
> >         struct perf_data_file *file;
> >         struct zstd_data      zstd_data;
> >  };
> > diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> > index 48dd2b018c47..60f2d749b1c0 100644
> > --- a/tools/perf/util/zstd.c
> > +++ b/tools/perf/util/zstd.c
> > @@ -7,35 +7,9 @@
> >
> >  int zstd_init(struct zstd_data *data, int level)
> >  {
> > -       size_t ret;
> > -
> > -       data->dstream =3D ZSTD_createDStream();
> > -       if (data->dstream =3D=3D NULL) {
> > -               pr_err("Couldn't create decompression stream.\n");
> > -               return -1;
> > -       }
> > -
> > -       ret =3D ZSTD_initDStream(data->dstream);
> > -       if (ZSTD_isError(ret)) {
> > -               pr_err("Failed to initialize decompression stream: %s\n=
", ZSTD_getErrorName(ret));
> > -               return -1;
> > -       }
> > -
> > -       if (!level)
> > -               return 0;
> > -
> > -       data->cstream =3D ZSTD_createCStream();
> > -       if (data->cstream =3D=3D NULL) {
> > -               pr_err("Couldn't create compression stream.\n");
> > -               return -1;
> > -       }
> > -
> > -       ret =3D ZSTD_initCStream(data->cstream, level);
> > -       if (ZSTD_isError(ret)) {
> > -               pr_err("Failed to initialize compression stream: %s\n",=
 ZSTD_getErrorName(ret));
> > -               return -1;
> > -       }
> > -
> > +       data->comp_level =3D level;
> > +       data->dstream =3D NULL;
> > +       data->cstream =3D NULL;
> >         return 0;
> >  }
> >
> > @@ -63,6 +37,21 @@ size_t zstd_compress_stream_to_records(struct zstd_d=
ata *data, void *dst, size_t
> >         ZSTD_outBuffer output;
> >         void *record;
> >
> > +       if (!data->cstream) {
> > +               data->cstream =3D ZSTD_createCStream();
> > +               if (data->cstream =3D=3D NULL) {
> > +                       pr_err("Couldn't create compression stream.\n")=
;
> > +                       return -1;
> > +               }
> > +
> > +               ret =3D ZSTD_initCStream(data->cstream, data->comp_leve=
l);
> > +               if (ZSTD_isError(ret)) {
> > +                       pr_err("Failed to initialize compression stream=
: %s\n",
> > +                               ZSTD_getErrorName(ret));
> > +                       return -1;
>
> I'm not sure if the callers are ready to handle the failure.

Thanks, fixed in v3.

Ian

> Thanks,
> Namhyung
>
>
> > +               }
> > +       }
> > +
> >         while (input.pos < input.size) {
> >                 record =3D dst;
> >                 size =3D process_header(record, 0);
> > @@ -96,6 +85,20 @@ size_t zstd_decompress_stream(struct zstd_data *data=
, void *src, size_t src_size
> >         ZSTD_inBuffer input =3D { src, src_size, 0 };
> >         ZSTD_outBuffer output =3D { dst, dst_size, 0 };
> >
> > +       if (!data->dstream) {
> > +               data->dstream =3D ZSTD_createDStream();
> > +               if (data->dstream =3D=3D NULL) {
> > +                       pr_err("Couldn't create decompression stream.\n=
");
> > +                       return -1;
> > +               }
> > +
> > +               ret =3D ZSTD_initDStream(data->dstream);
> > +               if (ZSTD_isError(ret)) {
> > +                       pr_err("Failed to initialize decompression stre=
am: %s\n",
> > +                               ZSTD_getErrorName(ret));
> > +                       return -1;
> > +               }
> > +       }
> >         while (input.pos < input.size) {
> >                 ret =3D ZSTD_decompressStream(data->dstream, &output, &=
input);
> >                 if (ZSTD_isError(ret)) {
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

