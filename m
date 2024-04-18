Return-Path: <bpf+bounces-27176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB778AA49A
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3955EB212B6
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C35194C7C;
	Thu, 18 Apr 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vi4EFwlF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC4180A7E
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474468; cv=none; b=fG4AfeE5vCuu83LHCEk6yITqL+jKey1P+Ju+pqam/bk3u/SH/YEmX8KKbcGwF+uwWJ1fw+y8/V6kL1ZdXWR7RVg2i05GyhwEYHspD+f0FHHsU11v/WquNGjQP4qKgbegr7sK7J6hPUtd5QqkZ01Hw67Oh9pQNfi3RjJrgREPNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474468; c=relaxed/simple;
	bh=Al81Wp+BoxuxKClZlHKjCIreDgKIXroUMDGs1QrF9Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aswq9hoHOt6lXgm/IJcyfMtIs1NV4bh2wCs0O87zCTkl6oOnEl2S8WgEGnPNDstxbJVzJWBKptY3usGy2nQ7VRqxiELRwbXOrtjGFb0aMmr8xVJcHwfr28Al1jwnb8XZXpg6yk03Z0gSCCm0NXM11urkinOZLSLB0lUkJFHTfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vi4EFwlF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e44f82ff9cso14895ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713474466; x=1714079266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJVJe5DYIGKiqAkh914q9HNHt4cBXtTHQHGV+XEJwYc=;
        b=Vi4EFwlFM28ybRcnmn6VX/igBn/i4iP7gH0VzlPArBTFNtYthliIkagoM3eWVr5wNL
         dKIjpw0+Rqi2dsxdLFQKAsisbWf6iF7yl3X9OmLAlKqvHy4Eqa35086Y3SQJJ8gI8Uwb
         C/93Nf8YvmCRiLE8jFT2yxFu+RuQ2BPz+XRCPvPtc7RZuDJ3SYu5P50izSJVwk501uYO
         ATv6gmV/8Mx2s+3DdMBQikwxa1RRMSFuQ6dFLm/xMC1TGQ+w0+IvNtgd1yO+ZUECxquz
         EXqcuLqFaWz6m9XPvfIwUkaed0opc/HfsG8YyMHeSaRtdVHn6c5TVh7wdY7lceVlepDK
         jbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713474466; x=1714079266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJVJe5DYIGKiqAkh914q9HNHt4cBXtTHQHGV+XEJwYc=;
        b=TRTC9w+H3S8A0HIA9UA4KxUpVSPItFM3EfsmEOGn+CnIhd6/mqGLjZt3oN6iPLOCPj
         i6XeLPzqWyBt/I6RMSdTV8Xz8GNPgOtrqRQ7dNSM4RLC8bXpvxHuBwJAlrxQmS+5jsfa
         GpdO2J+X6g72gy3r+T+essia4nPd44oabFxOkJakEopawdf0IB/8iUtRJaDji3J7zDy2
         6QzCMLjZJnO/CN1IrlvU2zfhcZ/Bsyrvm+IWPKoY656fa6n01J1f7pBsJUxjG4BDMtV9
         DMsZTcptq/7x7GdyKSh+84gAl8f00Vy9EpBIdgDNG1USegqlDgGzfQWknBlV6tGi8yyl
         pzIw==
X-Forwarded-Encrypted: i=1; AJvYcCU7C0iKpOkLx0y39iZGWZxK4Hg/7Ymq7jl81plEn9gvnywRIg/ovmxb8Vyw5s61VoWfAs0qPvmZJwCp4FATPqHHwzHD
X-Gm-Message-State: AOJu0YxI2BoQTUeaAx76zs2U8R+R8nDB/dRhiQiQG9Gr7rtJZcdPwuIz
	xm/OUFRWqe+4hhj34pfgFeNFSdAGP3wpVt9QxDDgAh5XbOOzcVBet9+AOYwmasQIHF1bbUMCL9S
	CY2zRlxrb8LNiRPOQO6R1xVHJrGAnfnfg7NQa
X-Google-Smtp-Source: AGHT+IGllCxp65eQfyYK3/aoRyDs6LzYbT60FkRzl2fi4BM0xmIMleEppw8pZ1EJkTt6eSUC/kh6f8ZA8Pc/FzTdMig=
X-Received: by 2002:a17:902:680c:b0:1e3:cb9b:d29c with SMTP id
 h12-20020a170902680c00b001e3cb9bd29cmr15441plk.23.1713474465710; Thu, 18 Apr
 2024 14:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <20240416061533.921723-12-irogers@google.com>
 <ac8835f8-0ea5-4f28-941c-aa43f0da92fd@linux.intel.com>
In-Reply-To: <ac8835f8-0ea5-4f28-941c-aa43f0da92fd@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Apr 2024 14:07:31 -0700
Message-ID: <CAP-5=fXkn-nFTqGEqBYt6NUvoXU7OyLJeSCnWdD3taLHyK-xtQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] perf parse-events: Improve error message for bad numbers
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:27=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-16 2:15 a.m., Ian Rogers wrote:
> > Use the error handler from the parse_state to give a more informative
> > error message.
> >
> > Before:
> > ```
> > $ perf stat -e 'cycles/period=3D99999999999999999999/' true
> > event syntax error: 'cycles/period=3D99999999999999999999/'
> >                                   \___ parser error
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > ```
> >
> > After:
> > ```
> > $ perf stat -e 'cycles/period=3D99999999999999999999/' true
> > event syntax error: 'cycles/period=3D99999999999999999999/'
> >                                   \___ parser error
> >
> > event syntax error: '..les/period=3D99999999999999999999/'
> >                                   \___ Bad base 10 number "999999999999=
99999999"
>
>
> It seems the patch only works for decimal?
>
> ./perf stat -e 'cycles/period=3D0xaaaaaaaaaaaaaaaaaaaaaa/' true
> event syntax error: '..les/period=3D0xaaaaaaaaaaaaaaaaaaaaaa/'
>                                    \___ parser error
>  Run 'perf list' for a list of valid events
>
>   Usage: perf stat [<options>] [<command>]
>
>      -e, --event <event>   event selector. use 'perf list' to list
> available events
>
> Thanks,
> Kan

Right, for hexadecimal we say the number of digits is at most 16, so
when you exceed this the token is no longer recognized. It just
becomes input that can't be parsed, hence parser error. Doing this
means we can simplify other strtoull checks, but I agree having a
better error message for hexadecimal would be good. Let's do it as
follow up.

Thanks,
Ian

> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.l | 40 ++++++++++++++++++++--------------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 6fe37003ab7b..0cd68c9f0d4f 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -18,26 +18,34 @@
> >
> >  char *parse_events_get_text(yyscan_t yyscanner);
> >  YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
> > +int parse_events_get_column(yyscan_t yyscanner);
> > +int parse_events_get_leng(yyscan_t yyscanner);
> >
> > -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> > +static int get_column(yyscan_t scanner)
> >  {
> > -     u64 num;
> > -
> > -     errno =3D 0;
> > -     num =3D strtoull(str, NULL, base);
> > -     if (errno)
> > -             return PE_ERROR;
> > -
> > -     yylval->num =3D num;
> > -     return token;
> > +     return parse_events_get_column(scanner) - parse_events_get_leng(s=
canner);
> >  }
> >
> > -static int value(yyscan_t scanner, int base)
> > +static int value(struct parse_events_state *parse_state, yyscan_t scan=
ner, int base)
> >  {
> >       YYSTYPE *yylval =3D parse_events_get_lval(scanner);
> >       char *text =3D parse_events_get_text(scanner);
> > +     u64 num;
> >
> > -     return __value(yylval, text, base, PE_VALUE);
> > +     errno =3D 0;
> > +     num =3D strtoull(text, NULL, base);
> > +     if (errno) {
> > +             struct parse_events_error *error =3D parse_state->error;
> > +             char *help =3D NULL;
> > +
> > +             if (asprintf(&help, "Bad base %d number \"%s\"", base, te=
xt) > 0)
> > +                     parse_events_error__handle(error, get_column(scan=
ner), help , NULL);
> > +
> > +             return PE_ERROR;
> > +     }
> > +
> > +     yylval->num =3D num;
> > +     return PE_VALUE;
> >  }
> >
> >  static int str(yyscan_t scanner, int token)
> > @@ -283,8 +291,8 @@ r0x{num_raw_hex}  { return str(yyscanner, PE_RAW); =
}
> >        */
> >  "/"/{digit}          { return PE_BP_SLASH; }
> >  "/"/{non_digit}              { BEGIN(config); return '/'; }
> > -{num_dec}            { return value(yyscanner, 10); }
> > -{num_hex}            { return value(yyscanner, 16); }
> > +{num_dec}            { return value(_parse_state, yyscanner, 10); }
> > +{num_hex}            { return value(_parse_state, yyscanner, 16); }
> >       /*
> >        * We need to separate 'mem:' scanner part, in order to get speci=
fic
> >        * modifier bits parsed out. Otherwise we would need to handle PE=
_NAME
> > @@ -330,8 +338,8 @@ cgroup-switches                                   {=
 return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
> >  {lc_type}-{lc_op_result}-{lc_op_result}      { return str(yyscanner, P=
E_LEGACY_CACHE); }
> >  mem:                 { BEGIN(mem); return PE_PREFIX_MEM; }
> >  r{num_raw_hex}               { return str(yyscanner, PE_RAW); }
> > -{num_dec}            { return value(yyscanner, 10); }
> > -{num_hex}            { return value(yyscanner, 16); }
> > +{num_dec}            { return value(_parse_state, yyscanner, 10); }
> > +{num_hex}            { return value(_parse_state, yyscanner, 16); }
> >
> >  {modifier_event}     { return str(yyscanner, PE_MODIFIER_EVENT); }
> >  {name}                       { return str(yyscanner, PE_NAME); }

