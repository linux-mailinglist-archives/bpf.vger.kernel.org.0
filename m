Return-Path: <bpf+bounces-4829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74C574FE8B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 07:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740E5281673
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C81C2F;
	Wed, 12 Jul 2023 05:01:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDE644
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 05:01:21 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89110CF
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:01:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so119331cf.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689138079; x=1691730079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq6HoCSWjJULrdBpQtK0v2hxm5oXIHwNlZA0C4uPeBU=;
        b=ID+pt3M5dxPQ0dOTdaZzCnWtxvadEc68M8WuUOiQvrp6cqAgLMyWMHflQRO+NuFWTp
         hMf7AePC3v3q7yCgEe2+YH+6OJIQ2TDkaklLIA0/ZsB1Y4qp9jbfDu0Vwzftck/3LIqK
         9VrdP97s/QFE6azV3dtvUXIJPqHxir/c/lJJRdbr46ebfeAp3TUugVjZs5pEi/RCePab
         rAy/DOvW1GlqN01UrTG4z8PyCnLNZHit9b08lF3A+sVIYkN8gQD3QdiDsa9kbWIrko7f
         go8nnGaajCo+Ipsm4CbWGiv0Ww8JSwwbxT6/vaNApc2J3MOLGuN/CIW7BSOFR6NtKsVd
         ahrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689138079; x=1691730079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq6HoCSWjJULrdBpQtK0v2hxm5oXIHwNlZA0C4uPeBU=;
        b=XJrPXIMMOfGPp1cwirvAEiCq/0Kl0vtn2mY7xieNrChkVuYBrMyPZxDa+IPi3mx4fZ
         jbgsf5z68E7mILMfRyVs1kdJHugV7eEKuQ/fTjEETVkr6XkWlPMQhGSCoq6V1CgxQ8BM
         Y2HyT2SNwck0g8OtzdvJfFk9tl4lOmx0trGiZlxO9riSrYdxUG2CllO5XgHdgHl+rS4D
         /wtbrDMalR/cTyaUyka5J2jmTOnzBYpd0d/Zftjc+Klhx6yKdxHiqYrwhcsLz5Tt6pJZ
         sbWoUWXscRM5XM1cNvKEdbjUH/2uDWltqM4vm1qIbGBsqHPZgW7i6YHoKypGJuhnO2Xg
         gfiA==
X-Gm-Message-State: ABy/qLbviGw8GYQ5bHssCl4mqQ1M8st4f1EkiSHAKniSaq4Y1eWBDFL6
	45b8hSwod5fDfEe6Ax0/DzORdgUe5F65AjImBaPSpA==
X-Google-Smtp-Source: APBJJlGU6Nukf5As48WPLawiQMYSbuwj91pmIJglX7Sb8ujG53kmMMf17tXAWc4imyJbkR4zsit8jCHHoRgMWidjL0I=
X-Received: by 2002:a05:622a:241:b0:403:a43d:be41 with SMTP id
 c1-20020a05622a024100b00403a43dbe41mr164760qtx.20.1689138078630; Tue, 11 Jul
 2023 22:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com> <20230627181030.95608-14-irogers@google.com>
 <CAM9d7cjxrNTOUGxmTAycko_Gn_uY5aX8cBWTa-jrhLoc-Bur1g@mail.gmail.com>
 <CAP-5=fWdOQR0MvpJM2aW5Cc=GS86h2Kmh9zD2k5--K=8BNyVgw@mail.gmail.com> <CAM9d7ciBPUiM0QhfP=_EJXqZ=SgEkHii0Jc2J-MBkZr7k1wKUA@mail.gmail.com>
In-Reply-To: <CAM9d7ciBPUiM0QhfP=_EJXqZ=SgEkHii0Jc2J-MBkZr7k1wKUA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Jul 2023 22:01:07 -0700
Message-ID: <CAP-5=fWMKjfDYOjDzDZgaNdujz-eMCpXiBvp1=EYfeHzKoiWTw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 1, 2023 at 11:43=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Jun 30, 2023 at 8:14=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jun 29, 2023 at 2:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Tue, Jun 27, 2023 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Prefer informative messages rather than none with ABORT_ON. Documen=
t
> > > > one failure mode and add an error message for another.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/parse-events.y | 22 ++++++++++++++--------
> > > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse=
-events.y
> > > > index 844646752462..454577f7aff6 100644
> > > > --- a/tools/perf/util/parse-events.y
> > > > +++ b/tools/perf/util/parse-events.y
> > > > @@ -22,12 +22,6 @@
> > > >
> > > >  void parse_events_error(YYLTYPE *loc, void *parse_state, void *sca=
nner, char const *msg);
> > > >
> > > > -#define ABORT_ON(val) \
> > > > -do { \
> > > > -       if (val) \
> > > > -               YYABORT; \
> > > > -} while (0)
> > > > -
> > > >  #define PE_ABORT(val) \
> > > >  do { \
> > > >         if (val =3D=3D -ENOMEM) \
> > > > @@ -618,7 +612,9 @@ PE_RAW opt_event_config
> > > >                 YYNOMEM;
> > > >         errno =3D 0;
> > > >         num =3D strtoull($1 + 1, NULL, 16);
> > > > -       ABORT_ON(errno);
> > > > +       /* Given the lexer will only give [a-fA-F0-9]+ a failure he=
re should be impossible. */
> > > > +       if (errno)
> > > > +               YYABORT;
> > > >         free($1);
> > > >         err =3D parse_events_add_numeric(_parse_state, list, PERF_T=
YPE_RAW, num, $2,
> > > >                                        /*wildcard=3D*/false);
> > > > @@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
> > > >  {
> > > >         struct parse_events_array array;
> > > >
> > > > -       ABORT_ON($3 < $1);
> > > > +       if ($3 < $1) {
> > > > +               struct parse_events_state *parse_state =3D _parse_s=
tate;
> > > > +               struct parse_events_error *error =3D parse_state->e=
rror;
> > > > +               char *err_str;
> > > > +
> > > > +               if (asprintf(&err_str, "Expected '%ld' to be less-t=
han '%ld'", $3, $1) < 0)
> > >
> > > Isn't it to be "greater-than or equal" ?
> >
> > I think the order is right. From the man page:
> >
> >        When  successful,  these  functions return the number of bytes p=
rinted,
> >        just like sprintf(3).  If memory allocation wasn't  possible,  o=
r  some
> >        other error occurs, these functions will return -1, and the cont=
ents of
> >        strp are undefined.
> >
> > So here we need to catch -1 and ensure strp (&err_str) is NULL before
> > passing it to parse_events_error__handle.
>
> Oh, I meant the message not the condition in the if statement.
> It seems it aborts if $3 < $1, then it expects $3 >=3D $1 in the
> normal condition, right?

In the old code with the macro expanded it did:
if ($3 < $1) YYABORT

in the new code it fills in parse_state->error if the same error
condition applies. The change is to get rid of the macro and add an
error message. The asprintf is just added to make the error message
more informative.

Thanks,
Ian

> Thanks,
> Namhyung

