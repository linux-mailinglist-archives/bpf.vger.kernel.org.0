Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3F6BA3CD
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCNX4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCNX4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:56:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA04B824;
        Tue, 14 Mar 2023 16:56:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so68867633edb.10;
        Tue, 14 Mar 2023 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678838187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOphAHu7gszrVso7T+oh2ToFCR0kix6VtyaG3U2anX0=;
        b=CUHh5xUOFWm8ch6GdQbBV0NOt6vqTaXGfkK4OumKrVEVRX5BietJeKqFjFN0HPArZE
         q1BumjNZWHzEusSR5pSgHMc4p8ZZAgNYwHm/gG++qwWaOnWTL9dvDL6CwrYLHRrEd4A/
         FeHzVELlteckyRtC2Wg2HlrnhQOTjVuzGqPhjlf9Bup1jq9Yj4qIpLvY8eKwVjF+69O/
         JRGZR86PA07cXpITK9RW1MQQ6CP0hh0nfkNf5pAB/UO5cwEjgnUXJFGlN3TXFs/d+x1j
         +LiOB/qpofv55ag4/YoDr5D/Y22E0jZScvyAA5XDHF7QBI0yBkKvV3nyITjKZR4RYMIQ
         o7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOphAHu7gszrVso7T+oh2ToFCR0kix6VtyaG3U2anX0=;
        b=FMZ7FE7REiXk2lZlFPr9fck5+ZYn5uu4eqRfXRSAdToZigKEeauq9lWO+Uv2Sxx7Sf
         SG+wTYDRt6Gd7VKDf5JGcWfqDrccb30etqhl9+Ym6JT2+Qh8ehkMZD9jFPN9PR/Gq7Go
         RjMKfBoCW0epb0GQ3WUkGZ7f+W1K3ePw1pS6pEyRzT5n1m1YiOp2BosdsoCrQsDkmvDF
         5KrmokKaPf5kOOisTzemfnAiYPZYit+IN6LmHorm+rHNVIu14LJd/BpxfqBqzg4bvxHj
         IewaF84VLGvDYtbY/41lHnXm8PPv1DxvJz5qqrNS9dYq9gbrrhn43GcZwy91CtwknZF4
         gLMg==
X-Gm-Message-State: AO0yUKXS7GQKEvKqPg1W7PrcBD9xXQEt2bOEy0E4Jv5DirRvWzH7HLIk
        Ef6e9u2GciJBy5wPDewQUcBnaGx5pZBxTeTocSs=
X-Google-Smtp-Source: AK7set9vU3iA94OwQwJjFlyCzhRRThwkSQ6ymB7ncDITBvYoDY60C68r8MxO5jdzFlutLECI4jO6y5nZw4QJX90Je0M=
X-Received: by 2002:a05:6402:e9d:b0:4ad:739c:b38e with SMTP id
 h29-20020a0564020e9d00b004ad739cb38emr438702eda.1.1678838187529; Tue, 14 Mar
 2023 16:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com>
 <CAEf4Bzb9_5KvWKxEAgz0V_OS0+h6PQN_Pir_rfrcviu2O80cqQ@mail.gmail.com> <CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Mar 2023 16:56:15 -0700
Message-ID: <CAEf4BzaSD_9pdaSzfcinAEapzzHK2vYytHhk39jpepkCKOBVwQ@mail.gmail.com>
Subject: Re: next: zip.c:35:8: error: packed attribute causes inefficient
 alignment for 'magic' [-Werror=attributes]
To:     Ian Rogers <irogers@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 1:01=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Mar 14, 2023 at 11:52=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 13, 2023 at 11:38=E2=80=AFPM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > perf builds failing from Linux next-20230307..next-20230314 but pass =
on
> > > Linux mainline v6.3-rc2.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Thanks for the report, but I'm not sure what's wrong here. We added
> > __attribute__((packed)) attribute intentionally and want to keep it
> > this way. It seems like perf itself is using packed structs (e.g.,
> > struct debug_line_header in util/genelf_debug.c), so I'm wondering why
> > that code doesn't cause any problems.
> >
> > Any hints from perf folks?
>
> We use a #pragma to disable the warnings in at least one place:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools=
/lib/perf/include/perf/event.h?h=3Dperf-tools#n194
>

Ok, let's do the same here. Daniel, can you please send a follow up
patch to silence this warning?

> Thanks,
> Ian
>
> > >
> > > Build log:
> > > ---
> > > libbpf/staticobjs/zip.o
> > > zip.c:35:8: error: packed attribute causes inefficient alignment for
> > > 'magic' [-Werror=3Dattributes]
> > >    35 |  __u32 magic;
> > >       |        ^~~~~
> > > zip.c:40:8: error: packed attribute causes inefficient alignment for
> > > 'this_disk' [-Werror=3Dattributes]
> > >    40 |  __u16 this_disk;
> > >       |        ^~~~~~~~~
> > > zip.c:45:8: error: packed attribute causes inefficient alignment for
> > > 'cd_disk' [-Werror=3Dattributes]
> > >    45 |  __u16 cd_disk;
> > >       |        ^~~~~~~
> > > zip.c:50:8: error: packed attribute causes inefficient alignment for
> > > 'cd_records' [-Werror=3Dattributes]
> > >    50 |  __u16 cd_records;
> > >       |        ^~~~~~~~~~
> > > zip.c:55:8: error: packed attribute causes inefficient alignment for
> > > 'cd_records_total' [-Werror=3Dattributes]
> > >    55 |  __u16 cd_records_total;
> > >       |        ^~~~~~~~~~~~~~~~
> > > zip.c:58:8: error: packed attribute causes inefficient alignment for
> > > 'cd_size' [-Werror=3Dattributes]
> > >    58 |  __u32 cd_size;
> > >       |        ^~~~~~~
> > > zip.c:63:8: error: packed attribute causes inefficient alignment for
> > > 'cd_offset' [-Werror=3Dattributes]
> > >    63 |  __u32 cd_offset;
> > >       |        ^~~~~~~~~
> > > zip.c:66:8: error: packed attribute causes inefficient alignment for
> > > 'comment_length' [-Werror=3Dattributes]
> > >    66 |  __u16 comment_length;
> > >       |        ^~~~~~~~~~~~~~
> > > zip.c:79:8: error: packed attribute causes inefficient alignment for
> > > 'magic' [-Werror=3Dattributes]
> > >    79 |  __u32 magic;
> > >       |        ^~~~~
> > > zip.c:80:8: error: packed attribute causes inefficient alignment for
> > > 'version' [-Werror=3Dattributes]
> > >    80 |  __u16 version;
> > >       |        ^~~~~~~
> > > zip.c:82:8: error: packed attribute causes inefficient alignment for
> > > 'min_version' [-Werror=3Dattributes]
> > >    82 |  __u16 min_version;
> > >       |        ^~~~~~~~~~~
> > > zip.c:83:8: error: packed attribute causes inefficient alignment for
> > > 'flags' [-Werror=3Dattributes]
> > >    83 |  __u16 flags;
> > >       |        ^~~~~
> > > zip.c:84:8: error: packed attribute causes inefficient alignment for
> > > 'compression' [-Werror=3Dattributes]
> > >    84 |  __u16 compression;
> > >       |        ^~~~~~~~~~~
> > > zip.c:85:8: error: packed attribute causes inefficient alignment for
> > > 'last_modified_time' [-Werror=3Dattributes]
> > >    85 |  __u16 last_modified_time;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > zip.c:86:8: error: packed attribute causes inefficient alignment for
> > > 'last_modified_date' [-Werror=3Dattributes]
> > >    86 |  __u16 last_modified_date;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > zip.c:87:8: error: packed attribute causes inefficient alignment for
> > > 'crc' [-Werror=3Dattributes]
> > >    87 |  __u32 crc;
> > >       |        ^~~
> > > zip.c:88:8: error: packed attribute causes inefficient alignment for
> > > 'compressed_size' [-Werror=3Dattributes]
> > >    88 |  __u32 compressed_size;
> > >       |        ^~~~~~~~~~~~~~~
> > > zip.c:89:8: error: packed attribute causes inefficient alignment for
> > > 'uncompressed_size' [-Werror=3Dattributes]
> > >    89 |  __u32 uncompressed_size;
> > >       |        ^~~~~~~~~~~~~~~~~
> > > zip.c:90:8: error: packed attribute causes inefficient alignment for
> > > 'file_name_length' [-Werror=3Dattributes]
> > >    90 |  __u16 file_name_length;
> > >       |        ^~~~~~~~~~~~~~~~
> > > zip.c:91:8: error: packed attribute causes inefficient alignment for
> > > 'extra_field_length' [-Werror=3Dattributes]
> > >    91 |  __u16 extra_field_length;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > zip.c:92:8: error: packed attribute causes inefficient alignment for
> > > 'file_comment_length' [-Werror=3Dattributes]
> > >    92 |  __u16 file_comment_length;
> > >       |        ^~~~~~~~~~~~~~~~~~~
> > > zip.c:94:8: error: packed attribute causes inefficient alignment for
> > > 'disk' [-Werror=3Dattributes]
> > >    94 |  __u16 disk;
> > >       |        ^~~~
> > > zip.c:95:8: error: packed attribute causes inefficient alignment for
> > > 'internal_attributes' [-Werror=3Dattributes]
> > >    95 |  __u16 internal_attributes;
> > >       |        ^~~~~~~~~~~~~~~~~~~
> > > zip.c:108:8: error: packed attribute causes inefficient alignment for
> > > 'magic' [-Werror=3Dattributes]
> > >   108 |  __u32 magic;
> > >       |        ^~~~~
> > > zip.c:110:8: error: packed attribute causes inefficient alignment for
> > > 'min_version' [-Werror=3Dattributes]
> > >   110 |  __u16 min_version;
> > >       |        ^~~~~~~~~~~
> > > zip.c:111:8: error: packed attribute causes inefficient alignment for
> > > 'flags' [-Werror=3Dattributes]
> > >   111 |  __u16 flags;
> > >       |        ^~~~~
> > > zip.c:112:8: error: packed attribute causes inefficient alignment for
> > > 'compression' [-Werror=3Dattributes]
> > >   112 |  __u16 compression;
> > >       |        ^~~~~~~~~~~
> > > zip.c:113:8: error: packed attribute causes inefficient alignment for
> > > 'last_modified_time' [-Werror=3Dattributes]
> > >   113 |  __u16 last_modified_time;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > zip.c:114:8: error: packed attribute causes inefficient alignment for
> > > 'last_modified_date' [-Werror=3Dattributes]
> > >   114 |  __u16 last_modified_date;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > zip.c:118:8: error: packed attribute causes inefficient alignment for
> > > 'file_name_length' [-Werror=3Dattributes]
> > >   118 |  __u16 file_name_length;
> > >       |        ^~~~~~~~~~~~~~~~
> > > zip.c:119:8: error: packed attribute causes inefficient alignment for
> > > 'extra_field_length' [-Werror=3Dattributes]
> > >   119 |  __u16 extra_field_length;
> > >       |        ^~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > Build links,
> > > https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXEyvgh4ba9y=
3rkt6KPf6sUMR/
> > >
> > >
> > > History link,
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230=
314/testrun/15564056/suite/build/test/gcc-10-lkftconfig-perf/history/
> > >
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
