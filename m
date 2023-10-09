Return-Path: <bpf+bounces-11727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD797BE541
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EF61C209F7
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407D374DF;
	Mon,  9 Oct 2023 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1T9y0OuY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E235887
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 15:45:41 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DFC6
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 08:45:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5032a508e74so6514e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696866337; x=1697471137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfVtaRDig7D+Ty8+FieODZ141554VQ+ssPrPXjaViV4=;
        b=1T9y0OuY4Di/oPxX0WRkVnisYCrqkSCYzZQq9xCp9RXvy8nqDtVzKAulHk6kp6Gy4L
         jYG3SH1aWScJg70xupLLk15aUiHX2iyKQk6I0qIR0kqlbPHRVaaLdEiVYd2gpXxd39MH
         UZ1cVpStnD8B78VPKr+IxYOgHbEJtdGm3EoJa81rt7wAcdtsmwypTl3iwKmHkmOWFJc5
         CEc8eDEt00CKygbmJ/fx0qLgo0v48EquWrGZ+OuM0TTLLjMzAk+CkXpkNidUIteeTSR+
         /R8OKSWgPvo5NPagTC10rzoMaYImlJb4ccp+cxKpinSBIZaj9jy0nRQFov2hG6hueQMF
         2JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866337; x=1697471137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfVtaRDig7D+Ty8+FieODZ141554VQ+ssPrPXjaViV4=;
        b=Q7EvCVE6pmnNd+GCee+e9BeZ1kkKPKe+YOPx4Uip8cmKH8lZXh3kMZDct0RQ1+OOLp
         Hipx4UlFzLs9NDxsCPfqnu/7QDnjNCyWq8I12XZ3JBfo7zZcnrD+4I8ADZb+Somw4GLD
         JhzBGCaRLL7OD+L4joHwLj5pGL8HuXCzwF0uCPNq6ZIrNZ+SqPZi6/r97irBQsiJK8u7
         D/oZ569yxOZCAY0O+JipM3S/2cItJmsn/HIIO3nvsMG20lFgKgOA5hpy3++eyoDESVB9
         AhOlWEl2v0YRcklJur0NBf65GxAvSJS8T4+GuT0fdnSMVmWx3ksCfyVZah+GIlEu+tLZ
         Ty3A==
X-Gm-Message-State: AOJu0YwVKmeKKDuXht89vGGHz+KFrqeRFCZ2ODhJ4ju6peJgOT8Vxlqi
	hCLJdKpvVLnm9hV1FV78I6BGMY020EnAEU4LFqR5TQ==
X-Google-Smtp-Source: AGHT+IHyqimkAN/ZGin5q4+q2QxBs1Lei/HTv3/YCpCfU6KTN/Jvvy/WxyiYZnOsxUwM84s6ifYLH255oUoVtofxu+M=
X-Received: by 2002:ac2:51a5:0:b0:501:a2b9:6046 with SMTP id
 f5-20020ac251a5000000b00501a2b96046mr220584lfk.7.1696866336692; Mon, 09 Oct
 2023 08:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-5-irogers@google.com>
 <CAM9d7ch4SLLbORdhkanCoPQZX=f-p-HxsYX2YWYbtLR4beD4wg@mail.gmail.com>
In-Reply-To: <CAM9d7ch4SLLbORdhkanCoPQZX=f-p-HxsYX2YWYbtLR4beD4wg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 08:45:25 -0700
Message-ID: <CAP-5=fXtx20VWAVpxAB-HHONx-8MUQKyFm9iSf7ohNBhoESoYg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] perf hisi-ptt: Fix potential memory leak
To: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 10:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Fix clang-tidy found potential memory leak and unread value:
> > ```
> > tools/perf/util/hisi-ptt.c:108:3: warning: Value stored to 'data_offset=
' is never read [clang-analyzer-deadcode.DeadStores]
> >                 data_offset =3D 0;
> >                 ^             ~
> > tools/perf/util/hisi-ptt.c:108:3: note: Value stored to 'data_offset' i=
s never read
> >                 data_offset =3D 0;
> >                 ^             ~
> > tools/perf/util/hisi-ptt.c:112:12: warning: Potential leak of memory po=
inted to by 'data' [clang-analyzer-unix.Malloc]
> >                         return -errno;
> >                                 ^
> > /usr/include/errno.h:38:18: note: expanded from macro 'errno'
> >                  ^
> > tools/perf/util/hisi-ptt.c:100:15: note: Memory is allocated
> >         void *data =3D malloc(size);
> >                      ^~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:104:6: note: Assuming 'data' is non-null
> >         if (!data)
> >             ^~~~~
> > tools/perf/util/hisi-ptt.c:104:2: note: Taking false branch
> >         if (!data)
> >         ^
> > tools/perf/util/hisi-ptt.c:107:6: note: Assuming the condition is false
> >         if (perf_data__is_pipe(session->data)) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:107:2: note: Taking false branch
> >         if (perf_data__is_pipe(session->data)) {
> >         ^
> > tools/perf/util/hisi-ptt.c:111:7: note: Assuming the condition is true
> >                 if (data_offset =3D=3D -1)
> >                     ^~~~~~~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:111:3: note: Taking true branch
> >                 if (data_offset =3D=3D -1)
> >                 ^
> > tools/perf/util/hisi-ptt.c:112:12: note: Potential leak of memory point=
ed to by 'data'
> >                         return -errno;
> >                                 ^
> > /usr/include/errno.h:38:18: note: expanded from macro 'errno'
> > ```
>
> We already have
>
>   https://lore.kernel.org/r/20230930072719.1267784-1-visitorckw@gmail.com

Agreed. There is a written to but not read addressed in this one, but
I think that is okay to clean up later and to drop this patch.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/hisi-ptt.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> > index 45b614bb73bf..ea297329c526 100644
> > --- a/tools/perf/util/hisi-ptt.c
> > +++ b/tools/perf/util/hisi-ptt.c
> > @@ -98,18 +98,18 @@ static int hisi_ptt_process_auxtrace_event(struct p=
erf_session *session,
> >         int fd =3D perf_data__fd(session->data);
> >         int size =3D event->auxtrace.size;
> >         void *data =3D malloc(size);
> > -       off_t data_offset;
> >         int err;
> >
> >         if (!data)
> >                 return -errno;
> >
> > -       if (perf_data__is_pipe(session->data)) {
> > -               data_offset =3D 0;
> > -       } else {
> > -               data_offset =3D lseek(fd, 0, SEEK_CUR);
> > -               if (data_offset =3D=3D -1)
> > +       if (!perf_data__is_pipe(session->data)) {
> > +               off_t data_offset =3D lseek(fd, 0, SEEK_CUR);
> > +
> > +               if (data_offset =3D=3D -1) {
> > +                       free(data);
> >                         return -errno;
> > +               }
> >         }
> >
> >         err =3D readn(fd, data, size);
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

