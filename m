Return-Path: <bpf+bounces-10338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42637A574B
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 04:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A170281902
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2546FBF;
	Tue, 19 Sep 2023 02:15:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02826ABC
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:15:19 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A5D125
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 19:15:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-414ba610766so210481cf.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695089716; x=1695694516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quPggTFwi0XTpntnGHPGihRCg7HVdEcvKNxZf56FGgw=;
        b=vxEIIpYrug5u43l70R8bkYvN7SMAwxQWtYO2OAcRY7uL4wXC/njoqWpRWh1Y2pmyfS
         ZlGN44YPisgptekSL3/HOtnPyBqQoNII0YpXxtOo2en7//043svnsFjAfo/jkqDQRfVS
         JevOYEV9conmfyD4a7wXNUCIyWOUIW2fmBuv8DIirCcsxS5kqkZFpTK+n3ULLqgBSPNl
         ii6wYq1vyYXPa6DwgaLl+KVqngwxeMta/7v/bLqz7HmyYH4ZCIveutFGgZfa4o00LP+3
         4YCwkNZtpyyVm0ZSbyv2ZPbq/4b6m1oz0v0kxgaHZz4JOo2hHXIkWzW/yAWUimuJbYfT
         4oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695089716; x=1695694516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quPggTFwi0XTpntnGHPGihRCg7HVdEcvKNxZf56FGgw=;
        b=DLoUg5t2+FPzoul0HmQ5oFIDpY1VHminHBRqXEBa09Wdzn6ajmcURuJHYtq7KnyVmc
         fuRfiRnZOLh21mmxwctGoco26KGRzZKnkbmOzJxmbY/4ynKmYTe3avo8MhkKrn0erAcd
         tehLg2yrq445Gn3Uskdcnq82LZa+8ASLwzxJCsykGMNr0XHplNv2TlT+DblJ7fiQ4v4J
         ISIi/c/j+lf9Q+07zedypKG5YOnwJ5jh9y6m+uqz4SsTYXg5XLhIFV66qrDrarIhas8S
         TCYapI1HDxQIcOseTjPdOkYiEnpHYcep7QGxoUcrm8S8rk2kuhBKZ5AHte5a3aL4sifx
         4OSQ==
X-Gm-Message-State: AOJu0YwDFHPnjqzTFkFUMtxMnyO6+Cyg6gXOkRmYsYJ7KDinYJvzuVKa
	BAP5MY3vh8eXaDgyHGf3vFxSm3m7ST1dwnKAUtVLoA==
X-Google-Smtp-Source: AGHT+IHoBSJFRxW0g2Vvg66ZyOabyfndhAOtH+QMKpyq3zzNhS3e3yt+3MKN21XQ9/koIthaqFEP3eTmXB3B3rh2hQg=
X-Received: by 2002:a05:622a:188d:b0:3f2:1441:3c11 with SMTP id
 v13-20020a05622a188d00b003f214413c11mr145770qtc.2.1695089716163; Mon, 18 Sep
 2023 19:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <20230914211948.814999-5-irogers@google.com>
 <CAM9d7ci3JPZ8ABamXUCRrAEV3jE=twPLSByOU_LC8LdzPedP2w@mail.gmail.com>
In-Reply-To: <CAM9d7ci3JPZ8ABamXUCRrAEV3jE=twPLSByOU_LC8LdzPedP2w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Sep 2023 19:15:04 -0700
Message-ID: <CAP-5=fWTr9f79k=AqGtE0BtwtXBygp6PKtqJGu8dH2W8p0Gs2A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf test: Ensure EXTRA_TESTS is covered in build test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Patrice Duroux <patrice.duroux@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 4:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Sep 14, 2023 at 2:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add to run variable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/make | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index a3a0f2a8bba0..d9945ed25bc5 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -138,6 +138,7 @@ endif
> >  run +=3D make_python_perf_so
> >  run +=3D make_debug
> >  run +=3D make_nondistro
> > +run +=3D make_extra_tests
>
> I'm curious why it's missed.. I couldn't find a commit to delete it.
> Maybe due to an incorrect resolution of a merge conflict?

I think it was just a mistake in the original patch:
https://lore.kernel.org/lkml/683fea7c-f5e9-fa20-f96b-f6233ed5d2a7@intel.com=
/

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  run +=3D make_no_bpf_skel
> >  run +=3D make_gen_vmlinux_h
> >  run +=3D make_no_libperl
> > --
> > 2.42.0.459.ge4e396fd5e-goog
> >

