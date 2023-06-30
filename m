Return-Path: <bpf+bounces-3810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F27440CA
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC02811BD
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B2171AF;
	Fri, 30 Jun 2023 17:05:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6914ABE
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:05:35 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C4183
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40345bf4875so14131cf.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=GYacckAkcPnWUplTlaekkOtdSFaf+lNU/SG0cw+5dp7yjaMMg9+c4+ymm4dQCO38Dz
         PdeHc8X6R5JAfcDF9pEpC+6ajTif3DHmMt3oQ1pnGmB4z6t4fZVtcvQDOywzhYQjNY4N
         ZrsLZi88nhs+AOGpef+VHTEBPVP+iJGc7S8ob7082O/VQlMOcC/mPJNjmHtq7Uxhg12+
         y1/8ti9u6rVypzIy6UFRV8AuNWz4nuRxB/b4IEi4uWs6Sj6ETn2sFI+QWnZNX9r+PsIY
         BgyRUFrSoyM296nO3MvEJ1qKgV7N6SlOdXyMnqVHJ9ROIGBfM5BXuc6Z2zFdnGTqm3As
         OZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=gQg65uaz3y3+krdOgK+CjLPz/UMRoyDjmBebTntUXKu1PYxYxcnCzZTPm+o+rUQqai
         ihmGCo4aZCcTAs7cet4h/gB3usCUHsLRolpR3DvIexqOujw+BOwGK0kDMtGq5VPqMPz+
         Ek8rcfXuuK0S4/YqStd7dXn2MpJA5lbFMMGI2yNCEJgSc0bO4As/+itsz09ImnVFQOEq
         4QPkS/NEXZyfycEms+ziFQNbKhfapLMlUTCC4Scs+H0XQyN3NnW3A2KMHGrgwmUOKw2k
         V3HWQ6qfT3bVxjlQWMLRF2l+KK5wZuMd2tYCn1ehGjdsvyan2PzrgwcMtCYeZfeU9aQL
         gj0A==
X-Gm-Message-State: ABy/qLbHDu81AWiakJIfdr6IbBIMqbkXjaTSlW11PeVt9tvKimI4i3+x
	5ys9MSrEb8Hqvgh96Ll0vT+A/1Bw4LBnYTjnV2KGYQ==
X-Google-Smtp-Source: APBJJlGFZH6uDfeEmQHjFg3l+Gr3kdJYkA2pz6Pf7n9i4u6wu+eAR+6jecdfSxzaXV6WzHsdQukovl+kgImmO77aQTU=
X-Received: by 2002:a05:622a:208:b0:3f7:ff4a:eae5 with SMTP id
 b8-20020a05622a020800b003f7ff4aeae5mr3290qtx.12.1688144733661; Fri, 30 Jun
 2023 10:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
In-Reply-To: <8dab7522-31de-2137-7474-991885932308@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 10:05:22 -0700
Message-ID: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 9:35=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > PMUs before parsing").
>
> Will the chances ever grow to add another imperative change suggestion?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n94


Sorry, I can't parse this.

Thanks,
Ian

> Regards,
> Markus

