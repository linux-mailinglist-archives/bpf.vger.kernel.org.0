Return-Path: <bpf+bounces-3755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAC742FB0
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 23:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706891C20B8D
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2125FC18;
	Thu, 29 Jun 2023 21:49:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CA101C4
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 21:49:42 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A2730C4;
	Thu, 29 Jun 2023 14:49:40 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5634d8d1db0so816840eaf.0;
        Thu, 29 Jun 2023 14:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688075380; x=1690667380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l23JP6S9GF/LAJfWcHkkcP43ONSxdFrMmfEO7H0kkE=;
        b=Gk90oRB+UAgMNfNRfbBae4fhx0Mtg0JN+CZujOejRaDwVfEoAn0yqUhYQ/HaJwJmpY
         QkQp0hkHPtsKbte00flgZBwneXD+hlSLrSHOMRPK4WLALkEwJBbO7fk/wXhF+yBZGRWV
         ZTQwp6dxQLLk6GTSJLVIf08BI96f9Wa4CT8554OG4qTV7tgDx3NBUSRWrpDbPJJVnQ/H
         0mj/YGm4N3VZFJaa1QUBD4dH5TF/hpP6CqRHISeNJ29NxgGoM8FTj04gFyvuQ1jdOe3t
         fKeef94nKQMtu9j5K3NxlG60Fv0v+/sASlIpafqAAPpLTPk3jpwXZWfYpy15l7wFojaQ
         Cd9Q==
X-Gm-Message-State: ABy/qLaxl1HN7r/FSUDMB3HGixrppHVVnHLqn91AU6b8DUyPdkGkPRtY
	4oKbBt1GB4pMC+QSLMugCsH2+y+AJkpe40jNujCYiKiz
X-Google-Smtp-Source: APBJJlHlXlntMH5DzeJI8yA4KDyrBXcKEoP2+taRKkbY3XHfuf2wz3KNvVIpxBG8F2/r6sGSfWxsetWTCuw8LQI1VMk=
X-Received: by 2002:a05:6358:e907:b0:134:e34e:ec49 with SMTP id
 gk7-20020a056358e90700b00134e34eec49mr891794rwb.2.1688075380126; Thu, 29 Jun
 2023 14:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com> <20230627181030.95608-14-irogers@google.com>
In-Reply-To: <20230627181030.95608-14-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Jun 2023 14:49:29 -0700
Message-ID: <CAM9d7cjxrNTOUGxmTAycko_Gn_uY5aX8cBWTa-jrhLoc-Bur1g@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 11:11=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Prefer informative messages rather than none with ABORT_ON. Document
> one failure mode and add an error message for another.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 844646752462..454577f7aff6 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -22,12 +22,6 @@
>
>  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, =
char const *msg);
>
> -#define ABORT_ON(val) \
> -do { \
> -       if (val) \
> -               YYABORT; \
> -} while (0)
> -
>  #define PE_ABORT(val) \
>  do { \
>         if (val =3D=3D -ENOMEM) \
> @@ -618,7 +612,9 @@ PE_RAW opt_event_config
>                 YYNOMEM;
>         errno =3D 0;
>         num =3D strtoull($1 + 1, NULL, 16);
> -       ABORT_ON(errno);
> +       /* Given the lexer will only give [a-fA-F0-9]+ a failure here sho=
uld be impossible. */
> +       if (errno)
> +               YYABORT;
>         free($1);
>         err =3D parse_events_add_numeric(_parse_state, list, PERF_TYPE_RA=
W, num, $2,
>                                        /*wildcard=3D*/false);
> @@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
>  {
>         struct parse_events_array array;
>
> -       ABORT_ON($3 < $1);
> +       if ($3 < $1) {
> +               struct parse_events_state *parse_state =3D _parse_state;
> +               struct parse_events_error *error =3D parse_state->error;
> +               char *err_str;
> +
> +               if (asprintf(&err_str, "Expected '%ld' to be less-than '%=
ld'", $3, $1) < 0)

Isn't it to be "greater-than or equal" ?

Thanks,
Namhyung


> +                       err_str =3D NULL;
> +
> +               parse_events_error__handle(error, @1.first_column, err_st=
r, NULL);
> +               YYABORT;
> +       }
>         array.nr_ranges =3D 1;
>         array.ranges =3D malloc(sizeof(array.ranges[0]));
>         if (!array.ranges)
> --
> 2.41.0.162.gfafddb0af9-goog
>

