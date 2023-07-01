Return-Path: <bpf+bounces-3848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE8744ADD
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5851C208F0
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C244D305;
	Sat,  1 Jul 2023 18:43:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A780257B
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 18:43:37 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956AD10DC;
	Sat,  1 Jul 2023 11:43:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bd6446528dcso3151571276.2;
        Sat, 01 Jul 2023 11:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688237016; x=1690829016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud6MKoHeXX6wSSB/d4LZ7XuJvAk8dvqDV0C73OcReOs=;
        b=bYJcxufPebRBR9GoZSnPIqLHazenqr+eg5/khQtxx5IFt+xM/+1BYQR5t9lV7AqqMh
         YeLoC1QlSVe4sUYKD/uy9e//8jO+CorfOfsGSYsE3r0RBW9C/hByPGSBcyKAPcsWh2M7
         HjXHx0xEFpdaNCcfnNWxw4Bs4wp9z91P/0k81d2JLWght+IcZMIHZ20Zc4smQ/aOvw9V
         WkAKsg19WwBjzwY9PlNV6ySdTXbJzm5BuuaTVl7Nso/BPTTAaL2V2ytTLRxtLrzxgl/b
         eDy48ENHtEFxxneM67r1ZplgI1cOdL1Lui94OgBpO9D654+DZ2QTSJtDnYOuroiDQ7QT
         8unw==
X-Gm-Message-State: ABy/qLbMpbs35QuJoovRsE9YMhoYzPKrCQ9lYGtwBiET0rp/bcWs4lmS
	tSA/s+OgUtZcYVYmoblxgTY+VRUd1TPw+kFF/I0=
X-Google-Smtp-Source: APBJJlHvXbnPHJsRT+lR/KmhBsIrOqn8EmHLaVsZLlL0YI2ke3WVUA11ToiuRIPIjJUCTQPMhYsZmtgHbHk0FdQbRQQ=
X-Received: by 2002:a25:aaf0:0:b0:be8:1aab:b3fb with SMTP id
 t103-20020a25aaf0000000b00be81aabb3fbmr6383151ybi.21.1688237015704; Sat, 01
 Jul 2023 11:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com> <20230627181030.95608-14-irogers@google.com>
 <CAM9d7cjxrNTOUGxmTAycko_Gn_uY5aX8cBWTa-jrhLoc-Bur1g@mail.gmail.com> <CAP-5=fWdOQR0MvpJM2aW5Cc=GS86h2Kmh9zD2k5--K=8BNyVgw@mail.gmail.com>
In-Reply-To: <CAP-5=fWdOQR0MvpJM2aW5Cc=GS86h2Kmh9zD2k5--K=8BNyVgw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 1 Jul 2023 11:43:24 -0700
Message-ID: <CAM9d7ciBPUiM0QhfP=_EJXqZ=SgEkHii0Jc2J-MBkZr7k1wKUA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 8:14=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jun 29, 2023 at 2:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Tue, Jun 27, 2023 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Prefer informative messages rather than none with ABORT_ON. Document
> > > one failure mode and add an error message for another.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events.y | 22 ++++++++++++++--------
> > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-e=
vents.y
> > > index 844646752462..454577f7aff6 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -22,12 +22,6 @@
> > >
> > >  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scann=
er, char const *msg);
> > >
> > > -#define ABORT_ON(val) \
> > > -do { \
> > > -       if (val) \
> > > -               YYABORT; \
> > > -} while (0)
> > > -
> > >  #define PE_ABORT(val) \
> > >  do { \
> > >         if (val =3D=3D -ENOMEM) \
> > > @@ -618,7 +612,9 @@ PE_RAW opt_event_config
> > >                 YYNOMEM;
> > >         errno =3D 0;
> > >         num =3D strtoull($1 + 1, NULL, 16);
> > > -       ABORT_ON(errno);
> > > +       /* Given the lexer will only give [a-fA-F0-9]+ a failure here=
 should be impossible. */
> > > +       if (errno)
> > > +               YYABORT;
> > >         free($1);
> > >         err =3D parse_events_add_numeric(_parse_state, list, PERF_TYP=
E_RAW, num, $2,
> > >                                        /*wildcard=3D*/false);
> > > @@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
> > >  {
> > >         struct parse_events_array array;
> > >
> > > -       ABORT_ON($3 < $1);
> > > +       if ($3 < $1) {
> > > +               struct parse_events_state *parse_state =3D _parse_sta=
te;
> > > +               struct parse_events_error *error =3D parse_state->err=
or;
> > > +               char *err_str;
> > > +
> > > +               if (asprintf(&err_str, "Expected '%ld' to be less-tha=
n '%ld'", $3, $1) < 0)
> >
> > Isn't it to be "greater-than or equal" ?
>
> I think the order is right. From the man page:
>
>        When  successful,  these  functions return the number of bytes pri=
nted,
>        just like sprintf(3).  If memory allocation wasn't  possible,  or =
 some
>        other error occurs, these functions will return -1, and the conten=
ts of
>        strp are undefined.
>
> So here we need to catch -1 and ensure strp (&err_str) is NULL before
> passing it to parse_events_error__handle.

Oh, I meant the message not the condition in the if statement.
It seems it aborts if $3 < $1, then it expects $3 >=3D $1 in the
normal condition, right?

Thanks,
Namhyung

