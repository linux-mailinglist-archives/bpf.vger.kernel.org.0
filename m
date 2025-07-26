Return-Path: <bpf+bounces-64427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC2B12840
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8933ADBC6
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663A7DA73;
	Sat, 26 Jul 2025 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoSCg8zN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12E4A11
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490732; cv=none; b=MdIhBOM7sqYts6NDe11pcaf0pQYt77dJ6cN42yCg2pN0BorDhtTuQgTT3LSy6Fk2YwQAUP1R+beyx80U6hK5D6QggA4AqiCYnzfV3RbPndK1+rDO1+TOYZzgHr2RedqwdXIKXibk3pPIDO6caAemjhbXldg7utz4/2KFKW6uKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490732; c=relaxed/simple;
	bh=pxg2xmAtW+OVA7ABSm7SU28mz1UKZOLH76wzUQ4/Ls8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWTnXfzTd06TML6HWhmKuZBaePW3d41qg/Ma88JfAuT7gBt0p8yEHQbvZeYoOKAXdLt9O7Pv9CdpaMnG+hf+LIdZbh/HB65IV9HKBZE/8G8rh5lYJW2fdyR8/L09VK9pTH8gc9V3Mq2nVxjw4yti977wiMZHDCkk30reC+O1A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoSCg8zN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so42885ab.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490729; x=1754095529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=SoSCg8zNJnOkOmVQK/nnZbmlCb9uvS96/TWhGFMSNh2uvbBECsZ3eWnUD1sVj//sUl
         kiQkdKQKZ2FeVFKUoVfJ5hPAQsxKQ4H/JDgmIRjuvpuft53APdblE4cKXHT6vj2I106M
         fkPtE2d9y+MpCfd3lUcLIpmX25IHWg622TpfqCPGOed61J6j8qtzR18xvpoh09Fx+SYA
         FLsGBIeH9StLhwv3oUpl4bMERm89k9TshCTrlxk2QcM3TG1CC+niwrOMh1TKICqWCxod
         v7NL0t07Z2B2l7AqVoJ3PUTIvt+6aSTo9gdO8iltcW1Bnu4v6ZNZIFeG90GNC4ec+cxE
         4AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490729; x=1754095529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=oR//81kH3wN8fo2JWnIG41DcX9Mgd1nwRAoepWbsTxxW1mIf6kIj+iyvE2hensH1KY
         fIHyh8rLEW8xfoptiSMJOfKax6M1oem1enddyAuCgNiqW5+Jd+IxgZlo5D3VGr7Ci6GB
         Vvhh+kfi6YWqq3AiQl21t3R1/sJo/oNqgMLcsvui4aKQ6FCfiqoSbp12sWidvD0f4FCK
         CrMQDSWLg0lZc5toPt76RGpPZol6se95MOZ0w4/ibx418I4t2Ii/DlFM6k93pP3SyVaB
         IgtYBb0RExRymSPgbrBDC9wCNnRbKgGWhPAiBCwJ+JsJgLad3uIFXx1UO07k3ARkeURC
         nuKA==
X-Forwarded-Encrypted: i=1; AJvYcCUQwhOXzGomvSoJdd7SR5jXFEmqCb5VrIJlJ2Rga3eacXMfw5f/JDKAcxjF5x6x7htuN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNgt4pmdUREBhHnLu/ePSDJzSpjKkjOUNGBQ0/ER5apTzQb9c
	WSr4ZTwBdP1H/amdegn1l5Dihi4vIIxub2ebDb30eittBRpT8gAK9aqUp5uBrt2BW8vHS+uzqP/
	7BBJjJBj3/a1rfZywhBQXtmUDkIupbSaDIli7v4dr
X-Gm-Gg: ASbGncvEUNo/j19CffgpRou8jWFpPvLKGUdFmiAVextA1zWyEJ56LQlU5r10aGAgzX+
	N7bH4oAPIi6OkCWGrv6vxprhBDbPB8oAY/j7sK+YVrRs3W/wfI9fxMzUshj1SGc1X5OjGt2mHBE
	jF+Nx8zrV0BeD/Mv7U3KVaZF/u11tooQvRhbowTv2jGMcYPI92zQz8jvJtzPuZ+MYCQNdBkY93T
	DY5kFA4
X-Google-Smtp-Source: AGHT+IGN6wOzatqvy/OpRoHOW2RLac4VBB3V05rQp+gk4PFfomyB5gIzPstXPdr5ruJ8rl4Jxzlz2syi3jTHQ8DVvOc=
X-Received: by 2002:a05:6e02:2167:b0:3dd:c9e4:d475 with SMTP id
 e9e14a558f8ab-3e3cbfe104amr1623005ab.22.1753490728894; Fri, 25 Jul 2025
 17:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726004023.3466563-1-blakejones@google.com>
In-Reply-To: <20250726004023.3466563-1-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:45:15 -0700
X-Gm-Features: Ac12FXwghoIBGejz3QD5ztrbBqVaqe3VNiAirRjc2_3fAscr-xIW4oR3aZ07LEg
Message-ID: <CAP-5=fWjq-6MbYt93FOBWqV_1VNjAq0FCqxm4B1W4KXCyBZf6w@mail.gmail.com>
Subject: Re: [PATCH] Fix comment ordering.
To: Blake Jones <blakejones@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:40=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
> BPF metadata collection") overlooked a behavior of "perf test list",
> causing it to print "SPDX-License-Identifier: GPL-2.0" as a description f=
or
> that test. This reorders the comments to fix that issue.
>
> Signed-off-by: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index bc9aef161664..69e3c2055134 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# BPF metadata collection test
>  #
> -# BPF metadata collection test.
> +# SPDX-License-Identifier: GPL-2.0
>
>  set -e
>
> --
> 2.50.1.470.g6ba607880d-goog
>

