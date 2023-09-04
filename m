Return-Path: <bpf+bounces-9192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2C791A22
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C611280FA1
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9DC140;
	Mon,  4 Sep 2023 14:56:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53633D99
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 14:56:43 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36A3AD
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 07:56:38 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40a47e8e38dso397421cf.1
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693839398; x=1694444198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8dnXbe6GgMXG/QAPAnuqzyd8DFJuI3wGF/AqzBGZE0=;
        b=s6X7ErhMRXTxoRPswpczGG9BLMbuT0YcrHfTJ3G0tQyLyV6kCdFCaACG3qGqmKF4Jj
         NFvNDnr569GPJ5Ex+lJb5T2L4VtXcH7OiJUBeKFsE2qD1IBZaf6rnS85R6lEs/YaMMtf
         wLcpyQ+LEn6R3X6juCzqz4KBDDXS8aITdMsOW9ZdwxIM/Q916SYcztZw6xEQdxTCv2g0
         bmJUZ5lIbxwOo+OdG3OOSNnPhtWRU4W2OE6xwOOxjSIkNLuv4OETadq+KDGH3XzxyshE
         Cyl4VuhgoysYa+18+dZhp+uaLbn3LWWYoOimKuFh0IF1STmtg4PqIWv2yiIFtRj3HVN4
         StRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839398; x=1694444198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8dnXbe6GgMXG/QAPAnuqzyd8DFJuI3wGF/AqzBGZE0=;
        b=Iqf847e+vXrgBpKhu2+WXcPY4biAiBQCYjmMM1tq8EeKvWuUGFvd8uqAhkp6AAq7We
         snhq1ylXQRhlIh8Iady6eDcAKvdihIP1nOFFl0q8NFpp4Tvd4j5+sSaby05ef9uInvv3
         r6DpdVtcf6yu9bXkU+qz2scM1NJjoq6DxmyL4IWVvGS80CzreXm0wxZCnyYB4KVG+E9M
         5H4sBziX57bE51NcNDkxjWBF6FyVg8xOwn5Gy2fEiQhz10jBZgOdCHMGUdgdf62B1XjP
         YOCJo9HIS6kauODR8GaCwTEEmUSLRv+eN0L/4RgbDnb5jKD9vYEGziBAVrozL5XqXW6g
         lRwQ==
X-Gm-Message-State: AOJu0Yx5cEZLYcRBC7qrS2otJjBTp72cw/O3/PCH+LioiJylLQXfz7GU
	TkY8+Z3SBsM3e5H7HxlNx81UMX728Cg1KqB9MOIZgg==
X-Google-Smtp-Source: AGHT+IFpe3Dvh7nmW/wCBzxTCHHMjcosW4dHk2wlflmIKdWhbxuKM+OmTZAODzw5dGa6Jt+tJikYPOCFPIxRkzy2Ck8=
X-Received: by 2002:a05:622a:1d0:b0:410:8ba3:21c7 with SMTP id
 t16-20020a05622a01d000b004108ba321c7mr368058qtw.18.1693839397645; Mon, 04 Sep
 2023 07:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com> <20230728001212.457900-3-irogers@google.com>
 <77361428-5970-5031-e204-7aefcd9cbebc@arm.com>
In-Reply-To: <77361428-5970-5031-e204-7aefcd9cbebc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Sep 2023 07:56:25 -0700
Message-ID: <CAP-5=fVATGaoeaSEk5jjoGDY=pJkFThU2t2sixfwjouxisor=w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf tools: Revert enable indices setting syntax
 for BPF map
To: James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Wang Nan <wangnan0@huawei.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, 
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 4, 2023 at 4:02=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 28/07/2023 01:12, Ian Rogers wrote:
> > This reverts commit e571e029bdbf ("perf tools: Enable indices setting
> > syntax for BPF map").
> >
> > The reverted commit added a notion of arrays that could be set as
> > event terms for BPF events. The parsing hasn't worked over multiple
> > Linux releases. Given the broken nature of the parsing it appears the
> > code isn't in use, nor could I find a way for it to be used to add a
> > test.
> >
> > The original commit contains a test in the commit message,
> > however, running it yields:
> > ```
> > $ perf record -e './test_bpf_map_3.c/map:channel.value[0,1,2,3...5]=3D1=
01/' usleep 2
> > event syntax error: '..pf_map_3.c/map:channel.value[0,1,2,3...5]=3D101/=
'
> >                                   \___ parser error
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > ```
> >
> > Given the code can't be used this commit reverts and removes it.
> >
>
> Hi Ian,
>
> Unfortunately this revert breaks Coresight sink argument parsing.
>
> Before:
>
>   $ perf record -e cs_etm/@tmc_etr0/ -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 4.008 MB perf.data ]
>
> After:
>
>   $ perf record -e cs_etm/@tmc_etr0/ -- true
>   event syntax error: 'cs_etm/@tmc_etr0/'
>                            \___ parser error
>
> I can't really see how it's related to the array syntax that the commit
> messages mention, but it could either be that the revert wasn't applied
> cleanly or just some unintended side effect.
>
> We should probably add a cross platform parsing test for Coresight
> arguments, but I don't know whether we should just blindly revert the
> revert for now, or work on a new change that explicitly fixes the
> Coresight case.

Agreed, I'll take a look. Any chance you could post the full error
message? I suspect there's a first error hiding in there too.

Thanks,
Ian

> Thanks
> James
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c |   8 +--
> >  tools/perf/util/parse-events.l |  11 ---
> >  tools/perf/util/parse-events.y | 122 ---------------------------------
> >  3 files changed, 1 insertion(+), 140 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 02647313c918..0e2004511cf5 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -800,13 +800,7 @@ parse_events_config_bpf(struct parse_events_state =
*parse_state,
> >
> >                       parse_events_error__handle(parse_state->error, id=
x,
> >                                               strdup(errbuf),
> > -                                             strdup(
> > -"Hint:\tValid config terms:\n"
> > -"     \tmap:[<arraymap>].value<indices>=3D[value]\n"
> > -"     \tmap:[<eventmap>].event<indices>=3D[event]\n"
> > -"\n"
> > -"     \twhere <indices> is something like [0,3...5] or [all]\n"
> > -"     \t(add -v to see detail)"));
> > +                                             NULL);
> >                       return err;
> >               }
> >       }
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 99335ec586ae..d7d084cc4140 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -175,7 +175,6 @@ do {                                               =
       \
> >  %x mem
> >  %s config
> >  %x event
> > -%x array
> >
> >  group                [^,{}/]*[{][^}]*[}][^,{}/]*
> >  event_pmu    [^,{}/]+[/][^/]*[/][^,{}/]*
> > @@ -251,14 +250,6 @@ non_digit        [^0-9]
> >               }
> >  }
> >
> > -<array>{
> > -"]"                  { BEGIN(config); return ']'; }
> > -{num_dec}            { return value(yyscanner, 10); }
> > -{num_hex}            { return value(yyscanner, 16); }
> > -,                    { return ','; }
> > -"\.\.\."             { return PE_ARRAY_RANGE; }
> > -}
> > -
> >  <config>{
> >       /*
> >        * Please update config_term_names when new static term is added.
> > @@ -302,8 +293,6 @@ r0x{num_raw_hex}  { return str(yyscanner, PE_RAW); =
}
> >  {lc_type}-{lc_op_result}     { return lc_str(yyscanner, _parse_state);=
 }
> >  {lc_type}-{lc_op_result}-{lc_op_result}      { return lc_str(yyscanner=
, _parse_state); }
> >  {name_minus}         { return str(yyscanner, PE_NAME); }
> > -\[all\]                      { return PE_ARRAY_ALL; }
> > -"["                  { BEGIN(array); return '['; }
> >  @{drv_cfg_term}              { return drv_str(yyscanner, PE_DRV_CFG_TE=
RM); }
> >  }
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 454577f7aff6..5a90e7874c59 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -64,7 +64,6 @@ static void free_list_evsel(struct list_head* list_ev=
sel)
> >  %token PE_LEGACY_CACHE
> >  %token PE_PREFIX_MEM
> >  %token PE_ERROR
> > -%token PE_ARRAY_ALL PE_ARRAY_RANGE
> >  %token PE_DRV_CFG_TERM
> >  %token PE_TERM_HW
> >  %type <num> PE_VALUE
> > @@ -108,11 +107,6 @@ static void free_list_evsel(struct list_head* list=
_evsel)
> >  %type <list_evsel> groups
> >  %destructor { free_list_evsel ($$); } <list_evsel>
> >  %type <tracepoint_name> tracepoint_name
> > -%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
> > -%type <array> array
> > -%type <array> array_term
> > -%type <array> array_terms
> > -%destructor { free ($$.ranges); } <array>
> >  %type <hardware_term> PE_TERM_HW
> >  %destructor { free ($$.str); } <hardware_term>
> >
> > @@ -127,7 +121,6 @@ static void free_list_evsel(struct list_head* list_=
evsel)
> >               char *sys;
> >               char *event;
> >       } tracepoint_name;
> > -     struct parse_events_array array;
> >       struct hardware_term {
> >               char *str;
> >               u64 num;
> > @@ -878,121 +871,6 @@ PE_TERM
> >
> >       $$ =3D term;
> >  }
> > -|
> > -name_or_raw array '=3D' name_or_legacy
> > -{
> > -     struct parse_events_term *term;
> > -     int err =3D parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE=
_USER, $1, $4, &@1, &@4);
> > -
> > -     if (err) {
> > -             free($1);
> > -             free($4);
> > -             free($2.ranges);
> > -             PE_ABORT(err);
> > -     }
> > -     term->array =3D $2;
> > -     $$ =3D term;
> > -}
> > -|
> > -name_or_raw array '=3D' PE_VALUE
> > -{
> > -     struct parse_events_term *term;
> > -     int err =3D parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE=
_USER, $1, $4, false, &@1, &@4);
> > -
> > -     if (err) {
> > -             free($1);
> > -             free($2.ranges);
> > -             PE_ABORT(err);
> > -     }
> > -     term->array =3D $2;
> > -     $$ =3D term;
> > -}
> > -|
> > -PE_DRV_CFG_TERM
> > -{
> > -     struct parse_events_term *term;
> > -     char *config =3D strdup($1);
> > -     int err;
> > -
> > -     if (!config)
> > -             YYNOMEM;
> > -     err =3D parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV=
_CFG, config, $1, &@1, NULL);
> > -     if (err) {
> > -             free($1);
> > -             free(config);
> > -             PE_ABORT(err);
> > -     }
> > -     $$ =3D term;
> > -}
> > -
> > -array:
> > -'[' array_terms ']'
> > -{
> > -     $$ =3D $2;
> > -}
> > -|
> > -PE_ARRAY_ALL
> > -{
> > -     $$.nr_ranges =3D 0;
> > -     $$.ranges =3D NULL;
> > -}
> > -
> > -array_terms:
> > -array_terms ',' array_term
> > -{
> > -     struct parse_events_array new_array;
> > -
> > -     new_array.nr_ranges =3D $1.nr_ranges + $3.nr_ranges;
> > -     new_array.ranges =3D realloc($1.ranges,
> > -                             sizeof(new_array.ranges[0]) *
> > -                             new_array.nr_ranges);
> > -     if (!new_array.ranges)
> > -             YYNOMEM;
> > -     memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
> > -            $3.nr_ranges * sizeof(new_array.ranges[0]));
> > -     free($3.ranges);
> > -     $$ =3D new_array;
> > -}
> > -|
> > -array_term
> > -
> > -array_term:
> > -PE_VALUE
> > -{
> > -     struct parse_events_array array;
> > -
> > -     array.nr_ranges =3D 1;
> > -     array.ranges =3D malloc(sizeof(array.ranges[0]));
> > -     if (!array.ranges)
> > -             YYNOMEM;
> > -     array.ranges[0].start =3D $1;
> > -     array.ranges[0].length =3D 1;
> > -     $$ =3D array;
> > -}
> > -|
> > -PE_VALUE PE_ARRAY_RANGE PE_VALUE
> > -{
> > -     struct parse_events_array array;
> > -
> > -     if ($3 < $1) {
> > -             struct parse_events_state *parse_state =3D _parse_state;
> > -             struct parse_events_error *error =3D parse_state->error;
> > -             char *err_str;
> > -
> > -             if (asprintf(&err_str, "Expected '%ld' to be less-than '%=
ld'", $3, $1) < 0)
> > -                     err_str =3D NULL;
> > -
> > -             parse_events_error__handle(error, @1.first_column, err_st=
r, NULL);
> > -             YYABORT;
> > -     }
> > -     array.nr_ranges =3D 1;
> > -     array.ranges =3D malloc(sizeof(array.ranges[0]));
> > -     if (!array.ranges)
> > -             YYNOMEM;
> > -     array.ranges[0].start =3D $1;
> > -     array.ranges[0].length =3D $3 - $1 + 1;
> > -     $$ =3D array;
> > -}
> >
> >  sep_dc: ':' |
> >

