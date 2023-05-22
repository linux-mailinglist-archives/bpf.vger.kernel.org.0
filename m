Return-Path: <bpf+bounces-1054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49AA70CEB5
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 01:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A541C20974
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472D17736;
	Mon, 22 May 2023 23:35:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB21772A
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 23:35:32 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE1173D;
	Mon, 22 May 2023 16:35:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d8ead2f1so295200a12.3;
        Mon, 22 May 2023 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684798529; x=1687390529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VotVH7DG8ufofu7FwiCmchyX5+I82ZeYrFOs3jDvenI=;
        b=jSKSNoY7Q0o/FX/zQftnhRD1701iNyP8zQnaHrvNK6bOhHVeEqoz3tBT+gkEnHOqZW
         AQZ6Dv6V2ofGxlmb5xVvKgu9gYDOvyilqMDZwAyAr1ACyuP57WmVjQczfRO2VbcqNg5+
         s5nVzFEG16bmn4cY/6GDa0bGcUK6xbBLAzOBPS/zdtJPUpzAKAByIrdcA6ejSc7UeEoZ
         2uXNnHjt+1fBW5Sbox5zRAHAoNqkQ+QeXejiPfW/RY1RO1h0jhgpX5khuQenES99xzXv
         hZsfoO5OsiXXkJSOOwAHyFV4pKUVXouj6o/fnZIulzp3aWN3buPzWPLy3oXxcg0MKt4O
         M/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684798529; x=1687390529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VotVH7DG8ufofu7FwiCmchyX5+I82ZeYrFOs3jDvenI=;
        b=AtSYpbx2Te2mSK4Ho0dgr182CTdFf0UqX6Ott1HgS4KyGEtdV9jtAfE66bG572i4eA
         OzvdG7/TjHGyjPA50sHFbLBbadRr4t2lpuCK3R21ydoMtaXHUnqk6+S5xRKY/L8aJx+N
         i4gETDyfysL4SnuayjViblowK9dGTU9lhCEO5qy89S9Ff/xXusyUcdHgNDZrQBBiiCFq
         //ACQWcZIgh5ZCfSCcBxijxyTj4G5DZQkNBQ6boTDnq7i7Dz8Z0i2CidPsZF/FZQrX+l
         sR6OJlH8M+WE5j5GoyOY7pQWs6f6ihscaikLDOQ+Gy985YTnKZKBhNGphl9cjA8ZQUvK
         J4Bw==
X-Gm-Message-State: AC+VfDy3Mpdi45Zoci2glI1deW+zBEd1jsUVZq+vSpTugasb/KJTXI4I
	nPMgf4CSj/e7yxZ4ikiLZreV4HgGqwYYbdyo0zI=
X-Google-Smtp-Source: ACHHUZ7mtfuDOCElFvNq3nUkWqMzZyRVApBCusLe5ZyJVQE2ZsHeO/c1d0Ni3dU7vqwqaybNJj6BRwOEJMkE3oQMpRg=
X-Received: by 2002:a17:907:c21:b0:967:5c5f:e45c with SMTP id
 ga33-20020a1709070c2100b009675c5fe45cmr13647491ejc.0.1684798528988; Mon, 22
 May 2023 16:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 May 2023 16:35:16 -0700
Message-ID: <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> satisfy libbpf 'runqueue' type verification") inadvertently created a
> declaration of 'struct rq' that conflicted with a generated
> vmlinux.h's:
>
> ```
> util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> struct rq {};
>        ^
> /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definit=
ion is here
> struct rq {
>        ^
> 1 error generated.
> ```
>
> Fix the issue by moving the declaration to vmlinux.h. So this can't
> happen again, bring back build support for generating vmlinux.h then
> add build tests.
>
> Ian Rogers (3):
>   perf build: Add ability to build with a generated vmlinux.h
>   perf bpf: Move the declaration of struct rq
>   perf test: Add build tests for BUILD_BPF_SKEL
>
>  tools/perf/Makefile.config                       |  4 ++++
>  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
>  tools/perf/tests/make                            |  4 ++++
>  tools/perf/util/bpf_skel/.gitignore              |  1 +
>  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
>  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
>  6 files changed, 34 insertions(+), 3 deletions(-)
>  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
>
> --
> 2.40.1.698.g37aff9b760-goog
>
>

LGTM, for the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

