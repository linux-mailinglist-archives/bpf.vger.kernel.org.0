Return-Path: <bpf+bounces-3817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069B744150
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11501C20BF1
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304CA174C9;
	Fri, 30 Jun 2023 17:34:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F392171DA
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:34:25 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136849CB
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:33:51 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4007b5bafceso19261cf.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688146422; x=1690738422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncRHJ/UjJWTzqrYWhnAQ1Z9WL/dnndbkb23KvFYFj98=;
        b=13KZgM3bZReYnp+zOtCRTMwq6znHdRzyNpuw2EhU6x6AQh/Fijhf2oEQUsl4Yp56j7
         g7H9t/Rhkxb+wiC85UNdsnTRJ2UMs+3WirehMCQO5un7lXy4PQZsvqvdp1d696RbtO1d
         v08UtmF2JugycqatrqL8deE/ZbUZlTL/OZmDgF3iUVqg27fv8cM9OpOKgx3eap0JId6B
         0XV+UdR48exs/vgI1mP66mgQQ6ICA1FxzRGozGzyyo7ZEsipPffmn2koTfb+pAKfHYst
         ysyrNrM5NpZgPAmvEa+oS74M+gXicqCXywZAcqRRCeYtx4MfoYMS20UkW9geSEHJbm6g
         rheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146422; x=1690738422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncRHJ/UjJWTzqrYWhnAQ1Z9WL/dnndbkb23KvFYFj98=;
        b=kbAbiA7Shv0IXUUCgDXoU9MqzX6+464TXIclqDpUGZGn2SN85tIbkNHzv8TWMDWiC2
         1dD0H1F321vGJ48m1X+hDiZbSN3OgygtnyI6w/hQrtZrQen3GV1PvvwyvxB40Mgvqcy5
         urcUyCvfcvgOc361Hi2lDw+C2zk96B/s2sl2m7hAjDDwPEP2EqTf9PNJbM7I99/otpws
         xqUaqxqBXzvTsc0BavK8yPaDc5AeZoLFm1amoSp3kW9mIlCfceiLnMuncvHoTjn+eePX
         G+QeBMKCyKQJyIqtQnL5wr9YMXKGJWhRgFq5MMwHBshzRny6PCEW3+Jb7Qq2nZa2PR3/
         9GOg==
X-Gm-Message-State: ABy/qLbnOFNsWVddCy2k3fgYGxkQ+fg7aUTqOQhA+iwuRVf2Fme1RwkL
	GwmamFetgFG07QfzjoujjNJCj84MnhrDLPb6FdI8xg==
X-Google-Smtp-Source: APBJJlFblHu7nuYcdkIa70v0NVLCYtL+USy8nv1lip1niNa3ugQEr7gvuJTaaG87EHBpbYmr/6JI0Muoa3EKO3w9IjU=
X-Received: by 2002:ac8:5a05:0:b0:3f9:a73b:57bb with SMTP id
 n5-20020ac85a05000000b003f9a73b57bbmr8915qta.4.1688146422404; Fri, 30 Jun
 2023 10:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
 <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de> <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
 <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
In-Reply-To: <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 10:33:31 -0700
Message-ID: <CAP-5=fXjXBSFVDYXw6fXUf35hLDMqS-C4DRC4LWXUcsMNP6gdw@mail.gmail.com>
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

On Fri, Jun 30, 2023 at 10:23=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>>>> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> >>>>> PMUs before parsing").
> >>>>
> >>>> Will the chances ever grow to add another imperative change suggesti=
on?
> >>>>
> >>>> See also:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
> >>>
> >>>
> >>> Sorry, I can't parse this.
> >>
> >> Can you take the requirement =E2=80=9CDescribe your changes in imperat=
ive mood=E2=80=9D
> >> into account for any more descriptions?
> >
> > Yep, still doesn't parse.
>
> Does this feedback really indicate that you stumble still on understandin=
g difficulties
> for the linked development documentation?
>
> Can the mentioned patch review concern be adjusted with wording alternati=
ves
> for improved commit messages?

Sorry, checked with a colleague and kernel contributor, we don't know
what is being requested here, "imperative mood" makes no sense, as
such I don't have a fix for what you're requesting.

Thanks,
Ian

> Regards,
> Markus

