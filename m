Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337936BA048
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNUBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 16:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCNUBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 16:01:38 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92951BAD5
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 13:01:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y12so5024069ilq.4
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678824087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daEuCuG7DXOdjWhiCTyJik6XgyB8D3WRZ/VzAWKx3KA=;
        b=eSQRb8tXj9GGNO4A71DATPGrLAjfPar+fRCBJgreepWxbtWxZSZhNptR80zD3O+KEM
         TEThEkfKvl1Y8Dp+lGsY2RCsUwm1bz8738EFr0eSLg/c4X7tzawk/OQRpQZYRTYBkv96
         O2dI7jgYH+vYDEx9OBpvW9UUaessOMV5uQ9hFTTbhlzGeKQmkvQCp2kNlmp5Q5rzg5CF
         H3Nlj+aRn/5m2l7+W/I0xgmI1SfqjuBTkbeP3SJUQbOIt6ZZRPlP6IORcE3mShl6m5TT
         YMbgh8fEnycZvROkqzeKDxsTKKhfDJEIwzuNlm672k5E8pYSL2CDR6LAtasbfoqln6d8
         +VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daEuCuG7DXOdjWhiCTyJik6XgyB8D3WRZ/VzAWKx3KA=;
        b=1g4WBN8aYIklPFBbbBda2MBRCUECx+IU97WZvmIUrVL8shUTr7oLM9sfVAO/9KO+rk
         fhFXjmSRBEixH9b2Rn6Xq/smRS86Tu3vTI3KYZretsMv7i5Yi4WmB+NTVzilEZKlhBOV
         1CunB+zqChCB6YbEEF99H4+09xHLu6BcxaVPUp5vWnxW8jqKstJg5uItjQX3Bs17k1WE
         Y+t4O+XCE6isAFjqXYZP9hn6HS3dIXjdFJjpwnYY2cR982oUEZIfzsP/d6hmzFECCSz+
         H75gpPFDEulKvdCEYeGyEScomSvGXk46UHdQbP+ipiXnwOI2kG0E1yq7tn8mppQOO/fD
         LDcw==
X-Gm-Message-State: AO0yUKW2k5u+4au9aQ8SvATqDXv2pfwqS44RowmRVRXY5agNrfSW7lBd
        Sl3Uj0Er9s+qFV/jD5aixfL2TxIY13KoP26G1weZYA==
X-Google-Smtp-Source: AK7set96x6suxfGHScWxcXUHwap0eV9HJEwIfYQuknkf9aG7fLFjai5z7b95ejSc9XOLkUfd8utZv/hV6VfBvk3Z8DA=
X-Received: by 2002:a05:6e02:66e:b0:313:93c8:e714 with SMTP id
 l14-20020a056e02066e00b0031393c8e714mr297734ilt.8.1678824086871; Tue, 14 Mar
 2023 13:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com>
 <CAEf4Bzb9_5KvWKxEAgz0V_OS0+h6PQN_Pir_rfrcviu2O80cqQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9_5KvWKxEAgz0V_OS0+h6PQN_Pir_rfrcviu2O80cqQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Mar 2023 13:01:16 -0700
Message-ID: <CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com>
Subject: Re: next: zip.c:35:8: error: packed attribute causes inefficient
 alignment for 'magic' [-Werror=attributes]
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 11:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 13, 2023 at 11:38=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > perf builds failing from Linux next-20230307..next-20230314 but pass on
> > Linux mainline v6.3-rc2.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thanks for the report, but I'm not sure what's wrong here. We added
> __attribute__((packed)) attribute intentionally and want to keep it
> this way. It seems like perf itself is using packed structs (e.g.,
> struct debug_line_header in util/genelf_debug.c), so I'm wondering why
> that code doesn't cause any problems.
>
> Any hints from perf folks?

We use a #pragma to disable the warnings in at least one place:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/l=
ib/perf/include/perf/event.h?h=3Dperf-tools#n194

Thanks,
Ian

> >
> > Build log:
> > ---
> > libbpf/staticobjs/zip.o
> > zip.c:35:8: error: packed attribute causes inefficient alignment for
> > 'magic' [-Werror=3Dattributes]
> >    35 |  __u32 magic;
> >       |        ^~~~~
> > zip.c:40:8: error: packed attribute causes inefficient alignment for
> > 'this_disk' [-Werror=3Dattributes]
> >    40 |  __u16 this_disk;
> >       |        ^~~~~~~~~
> > zip.c:45:8: error: packed attribute causes inefficient alignment for
> > 'cd_disk' [-Werror=3Dattributes]
> >    45 |  __u16 cd_disk;
> >       |        ^~~~~~~
> > zip.c:50:8: error: packed attribute causes inefficient alignment for
> > 'cd_records' [-Werror=3Dattributes]
> >    50 |  __u16 cd_records;
> >       |        ^~~~~~~~~~
> > zip.c:55:8: error: packed attribute causes inefficient alignment for
> > 'cd_records_total' [-Werror=3Dattributes]
> >    55 |  __u16 cd_records_total;
> >       |        ^~~~~~~~~~~~~~~~
> > zip.c:58:8: error: packed attribute causes inefficient alignment for
> > 'cd_size' [-Werror=3Dattributes]
> >    58 |  __u32 cd_size;
> >       |        ^~~~~~~
> > zip.c:63:8: error: packed attribute causes inefficient alignment for
> > 'cd_offset' [-Werror=3Dattributes]
> >    63 |  __u32 cd_offset;
> >       |        ^~~~~~~~~
> > zip.c:66:8: error: packed attribute causes inefficient alignment for
> > 'comment_length' [-Werror=3Dattributes]
> >    66 |  __u16 comment_length;
> >       |        ^~~~~~~~~~~~~~
> > zip.c:79:8: error: packed attribute causes inefficient alignment for
> > 'magic' [-Werror=3Dattributes]
> >    79 |  __u32 magic;
> >       |        ^~~~~
> > zip.c:80:8: error: packed attribute causes inefficient alignment for
> > 'version' [-Werror=3Dattributes]
> >    80 |  __u16 version;
> >       |        ^~~~~~~
> > zip.c:82:8: error: packed attribute causes inefficient alignment for
> > 'min_version' [-Werror=3Dattributes]
> >    82 |  __u16 min_version;
> >       |        ^~~~~~~~~~~
> > zip.c:83:8: error: packed attribute causes inefficient alignment for
> > 'flags' [-Werror=3Dattributes]
> >    83 |  __u16 flags;
> >       |        ^~~~~
> > zip.c:84:8: error: packed attribute causes inefficient alignment for
> > 'compression' [-Werror=3Dattributes]
> >    84 |  __u16 compression;
> >       |        ^~~~~~~~~~~
> > zip.c:85:8: error: packed attribute causes inefficient alignment for
> > 'last_modified_time' [-Werror=3Dattributes]
> >    85 |  __u16 last_modified_time;
> >       |        ^~~~~~~~~~~~~~~~~~
> > zip.c:86:8: error: packed attribute causes inefficient alignment for
> > 'last_modified_date' [-Werror=3Dattributes]
> >    86 |  __u16 last_modified_date;
> >       |        ^~~~~~~~~~~~~~~~~~
> > zip.c:87:8: error: packed attribute causes inefficient alignment for
> > 'crc' [-Werror=3Dattributes]
> >    87 |  __u32 crc;
> >       |        ^~~
> > zip.c:88:8: error: packed attribute causes inefficient alignment for
> > 'compressed_size' [-Werror=3Dattributes]
> >    88 |  __u32 compressed_size;
> >       |        ^~~~~~~~~~~~~~~
> > zip.c:89:8: error: packed attribute causes inefficient alignment for
> > 'uncompressed_size' [-Werror=3Dattributes]
> >    89 |  __u32 uncompressed_size;
> >       |        ^~~~~~~~~~~~~~~~~
> > zip.c:90:8: error: packed attribute causes inefficient alignment for
> > 'file_name_length' [-Werror=3Dattributes]
> >    90 |  __u16 file_name_length;
> >       |        ^~~~~~~~~~~~~~~~
> > zip.c:91:8: error: packed attribute causes inefficient alignment for
> > 'extra_field_length' [-Werror=3Dattributes]
> >    91 |  __u16 extra_field_length;
> >       |        ^~~~~~~~~~~~~~~~~~
> > zip.c:92:8: error: packed attribute causes inefficient alignment for
> > 'file_comment_length' [-Werror=3Dattributes]
> >    92 |  __u16 file_comment_length;
> >       |        ^~~~~~~~~~~~~~~~~~~
> > zip.c:94:8: error: packed attribute causes inefficient alignment for
> > 'disk' [-Werror=3Dattributes]
> >    94 |  __u16 disk;
> >       |        ^~~~
> > zip.c:95:8: error: packed attribute causes inefficient alignment for
> > 'internal_attributes' [-Werror=3Dattributes]
> >    95 |  __u16 internal_attributes;
> >       |        ^~~~~~~~~~~~~~~~~~~
> > zip.c:108:8: error: packed attribute causes inefficient alignment for
> > 'magic' [-Werror=3Dattributes]
> >   108 |  __u32 magic;
> >       |        ^~~~~
> > zip.c:110:8: error: packed attribute causes inefficient alignment for
> > 'min_version' [-Werror=3Dattributes]
> >   110 |  __u16 min_version;
> >       |        ^~~~~~~~~~~
> > zip.c:111:8: error: packed attribute causes inefficient alignment for
> > 'flags' [-Werror=3Dattributes]
> >   111 |  __u16 flags;
> >       |        ^~~~~
> > zip.c:112:8: error: packed attribute causes inefficient alignment for
> > 'compression' [-Werror=3Dattributes]
> >   112 |  __u16 compression;
> >       |        ^~~~~~~~~~~
> > zip.c:113:8: error: packed attribute causes inefficient alignment for
> > 'last_modified_time' [-Werror=3Dattributes]
> >   113 |  __u16 last_modified_time;
> >       |        ^~~~~~~~~~~~~~~~~~
> > zip.c:114:8: error: packed attribute causes inefficient alignment for
> > 'last_modified_date' [-Werror=3Dattributes]
> >   114 |  __u16 last_modified_date;
> >       |        ^~~~~~~~~~~~~~~~~~
> > zip.c:118:8: error: packed attribute causes inefficient alignment for
> > 'file_name_length' [-Werror=3Dattributes]
> >   118 |  __u16 file_name_length;
> >       |        ^~~~~~~~~~~~~~~~
> > zip.c:119:8: error: packed attribute causes inefficient alignment for
> > 'extra_field_length' [-Werror=3Dattributes]
> >   119 |  __u16 extra_field_length;
> >       |        ^~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > Build links,
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXEyvgh4ba9y3r=
kt6KPf6sUMR/
> >
> >
> > History link,
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-2023031=
4/testrun/15564056/suite/build/test/gcc-10-lkftconfig-perf/history/
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
