Return-Path: <bpf+bounces-3813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F67440FF
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962951C20C06
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF8171CD;
	Fri, 30 Jun 2023 17:16:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34371168B4
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:16:36 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996FA3AB1
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:16:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40345bf4875so18931cf.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688145394; x=1690737394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHJRhOeYdjZGJtK0kiELfpJOpqjlUoQdA4uo5jTiZng=;
        b=tOTGvjcjXsPjf2kpF4cHDyeCHK9ePpk88UqY/w/MiSd9yS9PKXDjrtNmUABRNyN/v2
         BngxrK9UzFWDamrZwzqQOKChngOCgN5qGex4zu2IQOdBCker/AkoB/L1q/VAi6/dc4gW
         bkjxm7s8I1GTgbnkJwdmlOcPrYCz8hOVOLLT+MZLuRaHpsc5tp5jp85iIf7UeKRaitye
         5iYXhKgX23/Fa0dTZA8u6aTdN+Gdk7rbCp+ZOtEqpecBf83K5xuynaRU16nCNdx0+CbZ
         jszTQV/Q1KDVEsSxpHST0kVodPMAzCsNMpjwuQQHLrZAKkRPbIv/7gGuwgysElhjfkfS
         vRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145394; x=1690737394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHJRhOeYdjZGJtK0kiELfpJOpqjlUoQdA4uo5jTiZng=;
        b=G1BPan6RjJe7Lum6bb9oem9k7ILVdEEAVhVLWiXz1zRA+fgZoTqWCfJAyLjUfTL+Q+
         qBGhpMXeUvYcWjsJ20VcnbiHpdD3Hl72+Ay1B23ge82M1hY7ElxXdWqodTpy4ZJtA9Uk
         Ew1DH01exBEHIRsTVAGDpcyS4K31GTBBr3Qkve74VHC+MZa8U1OhJVSWxxj/l4OgaUqc
         9mo/NLfssux6jZJNFNmnSWUQag9oGE/T8U0m0nM/84ZKlRC6tgNYHI9v4/axcDWaKwnh
         rnrZQsl6kdP+GVGTRAqVQn4LUvnrsw4Gn62i8lR+FPVa7k0i0BGoeGrc1/HHVpGCZR2J
         VzLw==
X-Gm-Message-State: AC+VfDw2f/sHlSwyo7mAXDIGfV+DNQW9W954zf2MV/Ag2pbJL8XDtL2l
	vz+rixhw7/FA3X0MpDqflXr1pZ2YHYPcSzRRFlwYTA==
X-Google-Smtp-Source: ACHHUZ5EIkHjSZ+sBqsk0o0f0HnhEV8nIj03CJE4DHEpGgn+INV+q28RDEvFbo7jIBrPpTNKPbpR3as1EqH0XNQ4gDI=
X-Received: by 2002:ac8:5bc5:0:b0:3f9:f877:1129 with SMTP id
 b5-20020ac85bc5000000b003f9f8771129mr806787qtb.29.1688145393558; Fri, 30 Jun
 2023 10:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com> <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de>
In-Reply-To: <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 10:16:22 -0700
Message-ID: <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
Subject: Re: [v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 10:15=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> >>> PMUs before parsing").
> >>
> >> Will the chances ever grow to add another imperative change suggestion=
?
> >>
> >> See also:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
> >
> >
> > Sorry, I can't parse this.
>
> Can you take the requirement =E2=80=9CDescribe your changes in imperative=
 mood=E2=80=9D
> into account for any more descriptions?

Yep, still doesn't parse.

Thanks,
Ian

> Regards,
> Markus

