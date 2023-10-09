Return-Path: <bpf+bounces-11674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF717BD2DA
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27C32814A3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 05:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FFB661;
	Mon,  9 Oct 2023 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F9A952;
	Mon,  9 Oct 2023 05:41:53 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00216A4;
	Sun,  8 Oct 2023 22:41:51 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-27b0d0c0ba0so3182964a91.1;
        Sun, 08 Oct 2023 22:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696830111; x=1697434911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RX7tLaR5cxlZGvCt5yVuBVmtnOHN5nH9geYt6ELosk=;
        b=RbIkAhdpuztmdKVcGKcTgLthZGnxPL+FRcI0hUinWt9wr4eseRCbUXHPwmxBfJnbJm
         APbrSyZNxyFpVNvjfJA7sjyfeX7N39m6ZkG9tLgQDQDEpMlL1J7CVGVuRh76+/S9kU+C
         c/Y7k4cYW5DULmDssO8L7FpAPJ2tfJLdkH2CK6KeX8dm/Z6yR1i/xCTDuQHqH1tTPO8x
         Hj3sA5CirILXI2vBP1D+ze4eD81nzIdjvQYLJYZgca7o5UP0So95pvHeS/j64+Qu93og
         XvlfkNnlxCzneSILTpmCCxscXGPmUTnTSRG9svx/2zzrEicsGX25/3DfdAHLWcHTVPw3
         gEhQ==
X-Gm-Message-State: AOJu0YyC9H2Yv2J/tDcQm9wsy5oIeZOFOD7Q8Lr9fIfxFifXoXb/HYqV
	JypJSwxYnOhnfbr4qbRqIlB3XiNnaVkffYLF2Pc=
X-Google-Smtp-Source: AGHT+IGE0tedBFfLbmKhVN5DwRDxqT1mpIyYE7VWdPjl5uPqunimpunTgmJdNT28U9fMQdA+O0b56HxncBIqBMuQf5M=
X-Received: by 2002:a17:90b:3e87:b0:274:755b:63b8 with SMTP id
 rj7-20020a17090b3e8700b00274755b63b8mr14069468pjb.43.1696830111351; Sun, 08
 Oct 2023 22:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-5-irogers@google.com>
In-Reply-To: <20231005230851.3666908-5-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:41:40 -0700
Message-ID: <CAM9d7ch4SLLbORdhkanCoPQZX=f-p-HxsYX2YWYbtLR4beD4wg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] perf hisi-ptt: Fix potential memory leak
To: Ian Rogers <irogers@google.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Fix clang-tidy found potential memory leak and unread value:
> ```
> tools/perf/util/hisi-ptt.c:108:3: warning: Value stored to 'data_offset' =
is never read [clang-analyzer-deadcode.DeadStores]
>                 data_offset =3D 0;
>                 ^             ~
> tools/perf/util/hisi-ptt.c:108:3: note: Value stored to 'data_offset' is =
never read
>                 data_offset =3D 0;
>                 ^             ~
> tools/perf/util/hisi-ptt.c:112:12: warning: Potential leak of memory poin=
ted to by 'data' [clang-analyzer-unix.Malloc]
>                         return -errno;
>                                 ^
> /usr/include/errno.h:38:18: note: expanded from macro 'errno'
>                  ^
> tools/perf/util/hisi-ptt.c:100:15: note: Memory is allocated
>         void *data =3D malloc(size);
>                      ^~~~~~~~~~~~
> tools/perf/util/hisi-ptt.c:104:6: note: Assuming 'data' is non-null
>         if (!data)
>             ^~~~~
> tools/perf/util/hisi-ptt.c:104:2: note: Taking false branch
>         if (!data)
>         ^
> tools/perf/util/hisi-ptt.c:107:6: note: Assuming the condition is false
>         if (perf_data__is_pipe(session->data)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/perf/util/hisi-ptt.c:107:2: note: Taking false branch
>         if (perf_data__is_pipe(session->data)) {
>         ^
> tools/perf/util/hisi-ptt.c:111:7: note: Assuming the condition is true
>                 if (data_offset =3D=3D -1)
>                     ^~~~~~~~~~~~~~~~~
> tools/perf/util/hisi-ptt.c:111:3: note: Taking true branch
>                 if (data_offset =3D=3D -1)
>                 ^
> tools/perf/util/hisi-ptt.c:112:12: note: Potential leak of memory pointed=
 to by 'data'
>                         return -errno;
>                                 ^
> /usr/include/errno.h:38:18: note: expanded from macro 'errno'
> ```

We already have

  https://lore.kernel.org/r/20230930072719.1267784-1-visitorckw@gmail.com

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hisi-ptt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 45b614bb73bf..ea297329c526 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -98,18 +98,18 @@ static int hisi_ptt_process_auxtrace_event(struct per=
f_session *session,
>         int fd =3D perf_data__fd(session->data);
>         int size =3D event->auxtrace.size;
>         void *data =3D malloc(size);
> -       off_t data_offset;
>         int err;
>
>         if (!data)
>                 return -errno;
>
> -       if (perf_data__is_pipe(session->data)) {
> -               data_offset =3D 0;
> -       } else {
> -               data_offset =3D lseek(fd, 0, SEEK_CUR);
> -               if (data_offset =3D=3D -1)
> +       if (!perf_data__is_pipe(session->data)) {
> +               off_t data_offset =3D lseek(fd, 0, SEEK_CUR);
> +
> +               if (data_offset =3D=3D -1) {
> +                       free(data);
>                         return -errno;
> +               }
>         }
>
>         err =3D readn(fd, data, size);
> --
> 2.42.0.609.gbb76f46606-goog
>

