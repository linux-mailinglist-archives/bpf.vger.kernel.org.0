Return-Path: <bpf+bounces-3493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF973ECEF
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1C0280E5A
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4E1548E;
	Mon, 26 Jun 2023 21:31:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5014AB1;
	Mon, 26 Jun 2023 21:31:54 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1FC2;
	Mon, 26 Jun 2023 14:31:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso2381908276.3;
        Mon, 26 Jun 2023 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815111; x=1690407111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S40Y266AiNifvKcLR/GFxkOqHbXnpeu04o5P2LTCRk=;
        b=A3GIGx7uWFJZNxuFfcg7x/A1+Gacucc3zBL7nI73PFMf94gvFHjJDN5WORY/DPxOKD
         jnljaTxbddBtKXzt6f6GlG2+tZHODJn8tsDpebvlLAHE4mR/tGFaXOiHCIeVBDgFgfK4
         vzAFEL210FWGNVZDNCLpQqU9c9TRpiOida/vttO8jlLvipu/DuRSngsHRygqfCpJAw+q
         UfV8xqbf+GfvGAj9/WTwQNCFUQ9NBy8aPiJbMC2xqTbtry2cuuUt2DPhJnoSa2626caL
         ml/fkZQpHfml0PD7rV7Bchlw2XRgMLG7rV0kPhUk8MLq4uHlDF+X7EqGvg8ORN3dvmP7
         SUFw==
X-Gm-Message-State: AC+VfDxeM+hcgsQ4OyCnNU81qa4oBBkGMXvZITC4v2FjBPYlMbtNed9h
	7t2eBJPuNyeZkSeOwHPMyY7hUM5ALSQsx0QVW/4=
X-Google-Smtp-Source: ACHHUZ44O5zRZn83lWSiAcf86BBHZ9JUkrCLaTbinBhIwiNQwI1gNJAX3DZDo7ZJJjM3mSSA8dYoRXUx/M/Tu6y7zcM=
X-Received: by 2002:a25:ae4b:0:b0:bac:f8ae:384b with SMTP id
 g11-20020a25ae4b000000b00bacf8ae384bmr17012487ybe.5.1687815111347; Mon, 26
 Jun 2023 14:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
 <3065880.1687785614@warthog.procyon.org.uk> <3067876.1687787456@warthog.procyon.org.uk>
 <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net>
In-Reply-To: <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 26 Jun 2023 14:31:39 -0700
Message-ID: <CAM9d7ch_mWUQGW8G221bZmCPn3wB2mjZm=ZdmhDkczhich9xZA@mail.gmail.com>
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace tools
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Sorry I missed the conversation and the original change.

On Mon, Jun 26, 2023 at 6:56=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> On 26/06/2023 15:50, David Howells wrote:
> > Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> >
> >> So another issue. When checking the differences between the two files,=
 I
> >> see there are still also other modifications to import, e.g. it looks
> >> like you also added MSG_INTERNAL_SENDMSG_FLAGS macro in socket.h. Do y=
ou
> >> plan to fix that too?
> >
> > That's just a list of other flags that we need to prevent userspace pas=
sing
> > in - it's not a flag in its own right.
>
> I agree. This file is not even used by C files, only by scripts parsing
> it if I'm not mistaken.
>
> But if there are differences with include/linux/socket.h, the warning I
> mentioned will be visible when compiling Perf.

Right, we want to keep the headers files in the tools in sync with
the kernel ones.  And they are used to generate some tables.
Full explanation from Arnaldo below.

So I'm ok for the msg_flags.c changes, but please refrain from
changing the header directly.  We will update it later.

With that,
  Acked-by: Namhyung Kim <namhyung@kernel.org>

Also I wonder if the tool needs to keep the original flag
(SENDPAGE_NOTLAST) for the older kernels.


In Arnaldo's explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

They are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] =3D {
        [0] =3D "NORMAL",
        [1] =3D "RANDOM",
        [2] =3D "SEQUENTIAL",
        [3] =3D "WILLNEED",
        [4] =3D "DONTNEED",
        [5] =3D "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

