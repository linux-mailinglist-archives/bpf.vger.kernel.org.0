Return-Path: <bpf+bounces-12209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997D7C9160
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 01:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5183282DC6
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D62C876;
	Fri, 13 Oct 2023 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1E2C869;
	Fri, 13 Oct 2023 23:40:17 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DFB7;
	Fri, 13 Oct 2023 16:40:16 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d4b280e4eso598460a91.1;
        Fri, 13 Oct 2023 16:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240415; x=1697845215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVNwQqiVkrXjE6Ai1N/131eZHMwXAneNV9c8J7fw4cE=;
        b=P+f/IVMG0eCNDesMou5YKY6mjKPFjHy6liEHqMjKD4ZX6+/00rxMkaJ7W//fbwlKHk
         vH/9sSrcSXw5o/k4r2VnI6hstgZVoTnKdVvhKwJ0pAQ6VqgmlK+17sH0ucDB27robipU
         Ahq/0lcXw/B6hRPT8oTedSLBrdVK3J6aS2RJ57xAXHTrjdB/pvpKQ238iBSUAY2bpDFQ
         0L+qdpmWf0GlPACYThlqlVjYlAt894nVnXtfppaTsSU7AqEXVGpNWjhjeY5yKzhpt7Ep
         QwCpoUDVArKaGOTsKGvl7OclX+O6NbDoOVENkQJ5fP8bZ93oJTqSnw+0/f1gMfqCkhYd
         eWuw==
X-Gm-Message-State: AOJu0Yxx9lLpefY88PGNtHckYvS7NUgyshOqVX/ZRuJ9LUh6/HT7dQH/
	tydbsmLC6Krhsv4W7kHnPvLLHBcX8TWrU5UECP4=
X-Google-Smtp-Source: AGHT+IG52rm3IVfLMN35j2TYSaIhI/qMeORhDVxK7PIltzo83RAIDMe7x9kH6keiuKXKVTyBhVxASEmRPyHTSwHgGxA=
X-Received: by 2002:a17:90a:5ac6:b0:27d:2db5:62c9 with SMTP id
 n64-20020a17090a5ac600b0027d2db562c9mr2324253pji.0.1697240415439; Fri, 13 Oct
 2023 16:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928235018.2136-1-namhyung@kernel.org> <ZSnMGwlppacZGaXf@kernel.org>
In-Reply-To: <ZSnMGwlppacZGaXf@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 13 Oct 2023 16:40:04 -0700
Message-ID: <CAM9d7cg7NgDZz_QAa8=rVp7B2AOPzWkLgTZyxndTgfDVbYL-BQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Clear lock addr after use
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 4:00=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 28, 2023 at 04:50:18PM -0700, Namhyung Kim escreveu:
> > It checks the current lock to calculated the delta of contention time.
>
> > The address is saved in the tstamp map which is allocated at begining o=
f
> > contention and released at end of contention.
> >
> > But it's possible for bpf_map_delete_elem() to fail.  In that case, the
>
> How can it fail?
>
> You do:
>
>         pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
>         if (!pelem || pelem->lock !=3D ctx[0])
>                 return 0;
>
> So it is there, why would the removal using the same key fail?

It can fail when it doesn't get a lock for the internal bucket.
See kernel/bpf/hashtab.c::htab_map_delete_elem().

But I'm not sure whether that's actually possible in this case.

>
> The patch should work as-is, I'm just curious about what would make
> there removal of a map entry that was successfully looked up on the same
> contention_end prog to fail when being removed...

Now I'm seeing some rare error cases like a spinlock wait
is longer than a minute.  I suspect a bug in this code and
try to be more defensive.

Thanks,
Namhyung

