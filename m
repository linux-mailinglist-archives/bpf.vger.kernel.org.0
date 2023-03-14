Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB586B9F1F
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCNSxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCNSxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 14:53:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953722129E;
        Tue, 14 Mar 2023 11:52:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd5so32181330edb.7;
        Tue, 14 Mar 2023 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TyElIWgexllmpdDJP4yPEqDY3bV2L7lXgcPPLwRUOY=;
        b=UeDOTY0aX04XtbWW7DgBEXbwSH/civPFMvrDvl60KzcJlFT8kaHIARlTBja1329vf1
         MhtQ9Tw8+PnHGNLRksLZzc+222BDWyXI1TzLC3Yd/X7NR/yVUTC8ERN2jWM3IuP4hhJA
         bpnoBHR0y+5VPfeoHvQMymRj9w2SX1IYMrkA04LF1+pN/0kJDGLj3Jkg1maHQ8heMV8+
         UFXf5GYKDiRcng5OXQ79cHrkb/OYTRxCDa8kTrEz3xXcSTzVSkddy1MJi8P5fZjyyEe8
         GjH+GgJxheA8/DAwtc4jx9R9zDF6bOgLatuoahLKLlRMiv8byyiRelYNp9L4AFZCxQXM
         z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TyElIWgexllmpdDJP4yPEqDY3bV2L7lXgcPPLwRUOY=;
        b=jGP5xx2qoirRrUAKgU7MmdbmLhHRbT4XG+FcV19zKjBjrYIgIylhOjAQujR5kS938A
         UYWtq1ZsYtB5vjwOGuGUMFtY7rtV3QtQo6JMwntK3i4UaF92AiT5wMDQreDJExSNJGfE
         fIGeZLBgOn1pb1tGewJ67psl7oM7FT9rwBySSSu/ijFjumEPKK+i5fxPBI+v4lJ6ZNHG
         Ce4TOjsMJmp8Lf2bP/IVZq2SUuq+2rjrp79UsQAPlk+H3hZwjy/ZbnlAMOs2nybubRCB
         hG0RO3DbZ+o5WC1r3p5aVc7Iavev75vmfvanhOY5kSzueBfmt8u73mCXoGQJ8ybwq1nV
         TEXw==
X-Gm-Message-State: AO0yUKWSf04EAdrY6M3CyAeYsbVw4dZww2PP0ZOKHxmiA6de5FzUu9B8
        HyhMPZImCA7h+ixY2hPjZUnwkKz5XcbO2keBrWzcav4c
X-Google-Smtp-Source: AK7set/9zMCyA10PYR9HiyiyTZRC+Fn7ib1qNvhz/pfVTT3MgkLBj1Ci2HypROZLVLSZfmh0Psf1gnEwUkgLuBTk4Ks=
X-Received: by 2002:a17:906:bc51:b0:923:6595:a81b with SMTP id
 s17-20020a170906bc5100b009236595a81bmr1813215ejv.5.1678819960041; Tue, 14 Mar
 2023 11:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com>
In-Reply-To: <CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Mar 2023 11:52:27 -0700
Message-ID: <CAEf4Bzb9_5KvWKxEAgz0V_OS0+h6PQN_Pir_rfrcviu2O80cqQ@mail.gmail.com>
Subject: Re: next: zip.c:35:8: error: packed attribute causes inefficient
 alignment for 'magic' [-Werror=attributes]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
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

On Mon, Mar 13, 2023 at 11:38=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> perf builds failing from Linux next-20230307..next-20230314 but pass on
> Linux mainline v6.3-rc2.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks for the report, but I'm not sure what's wrong here. We added
__attribute__((packed)) attribute intentionally and want to keep it
this way. It seems like perf itself is using packed structs (e.g.,
struct debug_line_header in util/genelf_debug.c), so I'm wondering why
that code doesn't cause any problems.

Any hints from perf folks?


>
> Build log:
> ---
> libbpf/staticobjs/zip.o
> zip.c:35:8: error: packed attribute causes inefficient alignment for
> 'magic' [-Werror=3Dattributes]
>    35 |  __u32 magic;
>       |        ^~~~~
> zip.c:40:8: error: packed attribute causes inefficient alignment for
> 'this_disk' [-Werror=3Dattributes]
>    40 |  __u16 this_disk;
>       |        ^~~~~~~~~
> zip.c:45:8: error: packed attribute causes inefficient alignment for
> 'cd_disk' [-Werror=3Dattributes]
>    45 |  __u16 cd_disk;
>       |        ^~~~~~~
> zip.c:50:8: error: packed attribute causes inefficient alignment for
> 'cd_records' [-Werror=3Dattributes]
>    50 |  __u16 cd_records;
>       |        ^~~~~~~~~~
> zip.c:55:8: error: packed attribute causes inefficient alignment for
> 'cd_records_total' [-Werror=3Dattributes]
>    55 |  __u16 cd_records_total;
>       |        ^~~~~~~~~~~~~~~~
> zip.c:58:8: error: packed attribute causes inefficient alignment for
> 'cd_size' [-Werror=3Dattributes]
>    58 |  __u32 cd_size;
>       |        ^~~~~~~
> zip.c:63:8: error: packed attribute causes inefficient alignment for
> 'cd_offset' [-Werror=3Dattributes]
>    63 |  __u32 cd_offset;
>       |        ^~~~~~~~~
> zip.c:66:8: error: packed attribute causes inefficient alignment for
> 'comment_length' [-Werror=3Dattributes]
>    66 |  __u16 comment_length;
>       |        ^~~~~~~~~~~~~~
> zip.c:79:8: error: packed attribute causes inefficient alignment for
> 'magic' [-Werror=3Dattributes]
>    79 |  __u32 magic;
>       |        ^~~~~
> zip.c:80:8: error: packed attribute causes inefficient alignment for
> 'version' [-Werror=3Dattributes]
>    80 |  __u16 version;
>       |        ^~~~~~~
> zip.c:82:8: error: packed attribute causes inefficient alignment for
> 'min_version' [-Werror=3Dattributes]
>    82 |  __u16 min_version;
>       |        ^~~~~~~~~~~
> zip.c:83:8: error: packed attribute causes inefficient alignment for
> 'flags' [-Werror=3Dattributes]
>    83 |  __u16 flags;
>       |        ^~~~~
> zip.c:84:8: error: packed attribute causes inefficient alignment for
> 'compression' [-Werror=3Dattributes]
>    84 |  __u16 compression;
>       |        ^~~~~~~~~~~
> zip.c:85:8: error: packed attribute causes inefficient alignment for
> 'last_modified_time' [-Werror=3Dattributes]
>    85 |  __u16 last_modified_time;
>       |        ^~~~~~~~~~~~~~~~~~
> zip.c:86:8: error: packed attribute causes inefficient alignment for
> 'last_modified_date' [-Werror=3Dattributes]
>    86 |  __u16 last_modified_date;
>       |        ^~~~~~~~~~~~~~~~~~
> zip.c:87:8: error: packed attribute causes inefficient alignment for
> 'crc' [-Werror=3Dattributes]
>    87 |  __u32 crc;
>       |        ^~~
> zip.c:88:8: error: packed attribute causes inefficient alignment for
> 'compressed_size' [-Werror=3Dattributes]
>    88 |  __u32 compressed_size;
>       |        ^~~~~~~~~~~~~~~
> zip.c:89:8: error: packed attribute causes inefficient alignment for
> 'uncompressed_size' [-Werror=3Dattributes]
>    89 |  __u32 uncompressed_size;
>       |        ^~~~~~~~~~~~~~~~~
> zip.c:90:8: error: packed attribute causes inefficient alignment for
> 'file_name_length' [-Werror=3Dattributes]
>    90 |  __u16 file_name_length;
>       |        ^~~~~~~~~~~~~~~~
> zip.c:91:8: error: packed attribute causes inefficient alignment for
> 'extra_field_length' [-Werror=3Dattributes]
>    91 |  __u16 extra_field_length;
>       |        ^~~~~~~~~~~~~~~~~~
> zip.c:92:8: error: packed attribute causes inefficient alignment for
> 'file_comment_length' [-Werror=3Dattributes]
>    92 |  __u16 file_comment_length;
>       |        ^~~~~~~~~~~~~~~~~~~
> zip.c:94:8: error: packed attribute causes inefficient alignment for
> 'disk' [-Werror=3Dattributes]
>    94 |  __u16 disk;
>       |        ^~~~
> zip.c:95:8: error: packed attribute causes inefficient alignment for
> 'internal_attributes' [-Werror=3Dattributes]
>    95 |  __u16 internal_attributes;
>       |        ^~~~~~~~~~~~~~~~~~~
> zip.c:108:8: error: packed attribute causes inefficient alignment for
> 'magic' [-Werror=3Dattributes]
>   108 |  __u32 magic;
>       |        ^~~~~
> zip.c:110:8: error: packed attribute causes inefficient alignment for
> 'min_version' [-Werror=3Dattributes]
>   110 |  __u16 min_version;
>       |        ^~~~~~~~~~~
> zip.c:111:8: error: packed attribute causes inefficient alignment for
> 'flags' [-Werror=3Dattributes]
>   111 |  __u16 flags;
>       |        ^~~~~
> zip.c:112:8: error: packed attribute causes inefficient alignment for
> 'compression' [-Werror=3Dattributes]
>   112 |  __u16 compression;
>       |        ^~~~~~~~~~~
> zip.c:113:8: error: packed attribute causes inefficient alignment for
> 'last_modified_time' [-Werror=3Dattributes]
>   113 |  __u16 last_modified_time;
>       |        ^~~~~~~~~~~~~~~~~~
> zip.c:114:8: error: packed attribute causes inefficient alignment for
> 'last_modified_date' [-Werror=3Dattributes]
>   114 |  __u16 last_modified_date;
>       |        ^~~~~~~~~~~~~~~~~~
> zip.c:118:8: error: packed attribute causes inefficient alignment for
> 'file_name_length' [-Werror=3Dattributes]
>   118 |  __u16 file_name_length;
>       |        ^~~~~~~~~~~~~~~~
> zip.c:119:8: error: packed attribute causes inefficient alignment for
> 'extra_field_length' [-Werror=3Dattributes]
>   119 |  __u16 extra_field_length;
>       |        ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Build links,
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXEyvgh4ba9y3rkt=
6KPf6sUMR/
>
>
> History link,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/=
testrun/15564056/suite/build/test/gcc-10-lkftconfig-perf/history/
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
