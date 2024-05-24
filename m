Return-Path: <bpf+bounces-30525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2758CEACD
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769C7B216F2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53474E2E;
	Fri, 24 May 2024 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJaLqKif"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4057CBA
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582178; cv=none; b=BGQbvGVoZ6YpyjPHnoWR+dHHUT3G/6Yzl+WYsYq4JBkP0N6mdH6GxUP2V5EXlRP4QqwW2tPzLfCs+BetEikJRJTmZrls+2dRuSbqyHmrCAhIFDSZcYX/WyEIikihoku4jCzDYqmHMcgQKhbXUyhj/tMGYRqb2WB5F+D2c8Znvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582178; c=relaxed/simple;
	bh=DN5DiwrRd5qbw3sclKQ+zjoZIjY62xjvwfTAj7+2NkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAbnyYyix5qVYZzxQnVdYEQrVFsnzWueQbURMRGFPh6J9zWczn9kfwUdl7KH3BeMLSH2k3e2GYJwWo2IRGSLBo+WhMg7nAKrF9KAPDQ7WZtJdMU0cZqF3+ZGW16qRq43wMPXmNqCzjAXjDDV1wsBak4UPIsyr4cMa7DF3QRw60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJaLqKif; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so120441cf.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716582175; x=1717186975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+IQkIDsWv6TAoxlWNpgArjw1bM2St+LuCkqXoQSIsY=;
        b=QJaLqKif2mVg0g3Xd1/jW0UV2qDjoIfbjuU73axBV2gHhOMI7qwbq60LITDZgIOecS
         +5mFpnmXvzLyrBmAGH2UTyh6TrPE/xEI5+RoV9MuEHPsBk5XyCykZ58SEs43eo7lQ6FY
         kh1eLU7okNrNFyrhVwo+RNa1T/k7Is0Rt3MT7H/BQIaXG3qnY2Z3yUZBsUgyuiiWkL6F
         U5iPZwCmRWS01tmqGWJ1q0Njnn4miB1PfLuOAf+egbI3xdzYhJOVtqs6JVSjESvQpWmW
         6ybKtSSLefGtJoTaEopFSOY14riW5JLiHtlDyGEUc1s5tVjc7EeDX+0V87UpoeGOrN6l
         3kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582175; x=1717186975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+IQkIDsWv6TAoxlWNpgArjw1bM2St+LuCkqXoQSIsY=;
        b=nkJEgQcajz/ggNvmI2xX8AdY+tVxJrNrDwyBngO9yzegGrYAjGNlpAkPbFA38QsbKL
         qbiCfj6jO0hzBaUJABe/tLlJgZxxu+KCukMtAle8SR51T9PfRTv3+6uU2ur8EEbP+uOY
         tRvN784I4hj4lQRPAqXsAzohbtdV0rc3O6tFTAlEztNDx6NG2LCPDDDOdXl2abx82d3t
         x0FBYUAWBBwuHgN19EJ8VaKvfi5oavhmAqdPm7zSXUVEF8bK6I4pC6XCEwj52Bi3d3j+
         KA0TmZOqHPro2otqwa92M1AHOSdIrsVSKGDL9cH84EOyp7xU62hVXlAGOqAIEbERJOUM
         qW+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8foKxFZUjqud8wcyJkHQygXn80eJW19UX6sL+MQOtMboe0/oouu9do2gZciSpvRWhqHGHrqzcaUzRfZKiJshoiXPG
X-Gm-Message-State: AOJu0YzTVip37mld8wKRn2LWlVlt902jJ+xl+S5gtNlZLknNCU/Ll31j
	GpC7j6Xjx6f6jthQZHlk6RcTu8MY2CTwNAxMcJGKtb03GBc3TaYKmBsVgKQOWnWiLqW6lg+t+IF
	awjYUs1s8aZ+Ut1HhcQvZIQ6u21NjBlwEX5Ot
X-Google-Smtp-Source: AGHT+IFFPcfGdxOrdcHvod/jp84idSmv6cCfzgRiNBHd0VVYzw2Z7nXtwv8+I08eWG4GLmUC40YrJO4Via/IOcXVrWE=
X-Received: by 2002:a05:622a:2507:b0:43e:143f:d184 with SMTP id
 d75a77b69052e-43fb9f9acb5mr651011cf.20.1716582175215; Fri, 24 May 2024
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com> <CAM9d7cibAi-Xnr5HTCT6HB0sat=w5qicDrr+pcMuUF0OfNQRPQ@mail.gmail.com>
 <ZlDVLBQ84O7fN9K4@google.com>
In-Reply-To: <ZlDVLBQ84O7fN9K4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 May 2024 13:22:43 -0700
Message-ID: <CAP-5=fU7V9F2vq=E=vHyD2E=ijx61UCsE=oywd3mTG7mnO3ttA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, May 22, 2024 at 09:38:57PM -0700, Namhyung Kim wrote:
> > On Mon, May 20, 2024 at 6:04=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Allow uid and gid to be terms in BPF filters by first breaking the
> > > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > > from a value in the sample. Allow filters to be passed to perf top, t=
his allows:
> > >
> > > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> > >
> > > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > > due to processes/threads terminating between the /proc scan and the
> > > perf_event_open.
> > >
> > > v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
> > >     using a shift as requested by Namhyung.
> > >
> > > Ian Rogers (3):
> > >   perf bpf filter: Give terms their own enum
> > >   perf bpf filter: Add uid and gid terms
> > >   perf top: Allow filters on events
>
> Hmm.. I'm seeing this.
>
>   $ make build-test
>   ...
>   cd . && make GEN_VMLINUX_H=3D1 FEATURES_DUMP=3D/home/namhyung/project/l=
inux/tools/perf/BUILD_TEST_FEATURE_DUMP -j64 O=3D/tmp/tmp.EeXFOfLPt5 DESTDI=
R=3D/tmp/tmp.Y0eiZKvc9D
>   ...
>     CLANG   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/sample_filter.bpf.o
>   In file included from util/bpf_skel/sample_filter.bpf.c:8:
>   In file included from util/bpf_skel/sample-filter.h:4:
>   /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:29:6=
: error: redefinition of 'perf_type_id'
>   enum perf_type_id {
>        ^
>   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54086:6: note: prev=
ious definition is here
>   enum perf_type_id {
>        ^
>   In file included from util/bpf_skel/sample_filter.bpf.c:8:
>   In file included from util/bpf_skel/sample-filter.h:4:
>   /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:30:2=
: error: redefinition of enumerator 'PERF_TYPE_HARDWARE'
>           PERF_TYPE_HARDWARE                      =3D 0,
>           ^
>   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54087:2: note: prev=
ious definition is here
>           PERF_TYPE_HARDWARE =3D 0,
>           ^
>   ...
>   make[3]: *** [Makefile.perf:264: sub-make] Error 2
>   make[2]: *** [Makefile:70: all] Error 2
>   make[1]: *** [tests/make:340: make_gen_vmlinux_h_O] Error 1
>   make: *** [Makefile:103: build-test] Error 2

IIRC this only exists for the sake of asserts. I can move the asserts
to placate the generated vmlinux.h. I'll send a v3.

Thanks,
Ian

> Thanks,
> Namhyung
>

