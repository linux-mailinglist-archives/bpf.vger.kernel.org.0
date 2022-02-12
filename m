Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F54B361E
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiBLPzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 10:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBLPzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 10:55:03 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DACBB9
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:54:58 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h7so15004817iof.3
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tkNNr3HWpzm5t0Q/VMrY2dBm/zoUF7w4pPfAHFM6fYE=;
        b=qF1ZjzGwMx6dmsPnrqNdJGkVn+SqTxq0KyjfUVNw2JTtu8qzdbmxP7YpiclwzMQ7k3
         3UsEhwIrSQrQ4ZWciihO3ioCPMxH3lSPAOpPAipAV3v8y1bGtq+qdK6i/7wdycD1T12i
         awCOFvHsprH/lw66sXUuKYT4rV+EjQZz741XTIGeM18DAfDmF+3ORuGJzBGkISecPFGT
         7tbmkrDErRDZNd2Q8kmxY4wBourP5Avk/rmENw4+cUcC2yO1fFshi4yiFnOK0hTpIfCr
         2zaQo70r33zyrf4cfxiqYNvIwSejrCn3CZhxuO4w38elRziWZSfqs7KbAj22vqJWwZUb
         ySCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tkNNr3HWpzm5t0Q/VMrY2dBm/zoUF7w4pPfAHFM6fYE=;
        b=CF1gPHAIKHGkmZ02AHJhAaJEK+fZR5Bl7gm1xT380GjuYGCH/JOE9CKYfSfg6OvDb7
         tg60G+yLVtz4ADtwlPgUtKK8lT3QaQyk3D1tC9VfnUUqo12w7RSE61TKSY6ncta+BL9g
         T/B+9mZDWNbaKsEivdS7hGJajpzuKO5F97Gxn7yz8FSfN621QSQTpf6eAxVcDKLqfN8p
         8DLpfrteOP9L3Rfz3eLGmwt96HcLY8FtBdM+PDwMHzpun6EdwZQpD+XeenbkgAzqlToe
         4gLlAlIQfT/xH/bJHc2/q8ysKEoZYDI+NLq8xvY13DzFn7PYKTI7BQla7Hci3WJAPG/M
         rXGQ==
X-Gm-Message-State: AOAM533N69SqtVXuSzBuJskAbnFMVpUcBSr3OJXfHMntVk4e0iW9GIER
        DnTsflPN6rhloVw4fSdO+v3h/BVLDagmzr0PFc4=
X-Google-Smtp-Source: ABdhPJx3TS5zHUM/6cl6+7NQ5BFD0kz81Wf6owzAQnuvf9o3xhqUxRPTSYqIvFxsrKUasGzff+3eJXwqrAs5qVmKvCw=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr3783391jaj.234.1644681297718;
 Sat, 12 Feb 2022 07:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20220212073054.1052880-1-andrii@kernel.org> <YgfToqR6xR5lq0HI@kernel.org>
 <YgfUEW5pa0eMN3/I@kernel.org> <YgfYEdsvP82XEOjx@kernel.org>
In-Reply-To: <YgfYEdsvP82XEOjx@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 12 Feb 2022 07:54:46 -0800
Message-ID: <CAEf4Bzb5HUkJg+7Prz5pROgkiZeU-jH8inTGGyN3yhqE2fCFVQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/2] perf: stop using deprecated bpf APIs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Christy Lee <christylee@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 12, 2022 at 7:53 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Feb 12, 2022 at 12:36:49PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Sat, Feb 12, 2022 at 12:34:58PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Fri, Feb 11, 2022 at 11:30:52PM -0800, Andrii Nakryiko escreveu:
> > > > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated=
.
> > > > remove perf's usage of these deprecated functions. After this patch
> > > > set, the only remaining libbpf deprecated APIs in perf would be
> > > > bpf_program__set_prep() and bpf_program__nth_fd().
> > >
> > > Not applying to perf/core, I'm checking...
> >
> > Just some fuzz on the second patch:
> >
> > =E2=AC=A2[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> > patching file tools/perf/util/bpf-loader.c
> > Hunk #2 succeeded at 111 with fuzz 1 (offset -1 lines).
> > Hunk #3 succeeded at 156 (offset -2 lines).
> > Hunk #4 succeeded at 1563 (offset 8 lines).
> > Hunk #5 succeeded at 1575 (offset 8 lines).
> > Hunk #6 succeeded at 1628 (offset 8 lines).
> > =E2=AC=A2[acme@toolbox perf]$
> >
> > Applying manually to test on the set of test build containers.
>
> perf test clean, these also work:
>
> # perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c  sleep 1
> [root@quaco perf]# perf trace -e tools/perf/examples/bpf/5sec.c  sleep 5s
>      0.000 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1994947936, rqtp=
: 5000000000)
> [root@quaco perf]#
>
> containers building:
>
> [perfbuilder@five ~]$ export BUILD_TARBALL=3Dhttp://192.168.100.2/perf/pe=
rf-5.17.0-rc3.tar.xz
> [perfbuilder@five ~]$ time dm
>    1   164.81 almalinux:8                   : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.=
0+1025+93159d6c)
>    2    90.60 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3=
.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>    3    55.88 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2=
.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
>    4    58.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3=
.0 , clang version 4.0.0 (tags/RELEASE_400/final)
>    5    65.65 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4=
.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0=
.0)
>    6    69.85 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4=
.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0=
.1)
>    7    66.83 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3=
.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0=
.1)
>    8: alpine:3.10
>
> I don't expect problems with those, so probably later today I'll push it
> to perf/core so that it will be on its way t 5.18.

Great, thank you!

>
> - Arnaldo
> >
> > > =E2=AC=A2[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 2022021207305=
4.1052880-1-andrii@kernel.org
> > > Looking up https://lore.kernel.org/r/20220212073054.1052880-1-andrii%=
40kernel.org
> > > Grabbing thread from lore.kernel.org/all/20220212073054.1052880-1-and=
rii%40kernel.org/t.mbox.gz
> > > Checking for newer revisions on https://lore.kernel.org/all/
> > > Analyzing 3 messages in the thread
> > > Checking attestation on all messages, may take a moment...
> > > ---
> > >   [PATCH v5 1/2] perf: Stop using deprecated bpf_load_program() API
> > >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >     + Link: https://lore.kernel.org/r/20220212073054.1052880-2-andrii=
@kernel.org
> > >     + Cc: kernel-team@fb.com
> > >     + Cc: daniel@iogearbox.net
> > >     + Cc: ast@kernel.org
> > >     + Cc: bpf@vger.kernel.org
> > >   [PATCH v5 2/2] perf: Stop using deprecated bpf_object__next() API
> > >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >     + Link: https://lore.kernel.org/r/20220212073054.1052880-3-andrii=
@kernel.org
> > >     + Cc: kernel-team@fb.com
> > >     + Cc: daniel@iogearbox.net
> > >     + Cc: ast@kernel.org
> > >     + Cc: bpf@vger.kernel.org
> > > ---
> > > Total patches: 2
> > > ---
> > > Cover: ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.cover
> > >  Link: https://lore.kernel.org/r/20220212073054.1052880-1-andrii@kern=
el.org
> > >  Base: not specified
> > >        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_api=
s.mbx
> > > =E2=AC=A2[acme@toolbox perf]$        git am ./v5_20220211_andrii_perf=
_stop_using_deprecated_bpf_apis.mbx
> > > Applying: perf: Stop using deprecated bpf_load_program() API
> > > Applying: perf: Stop using deprecated bpf_object__next() API
> > > error: patch failed: tools/perf/util/bpf-loader.c:68
> > > error: tools/perf/util/bpf-loader.c: patch does not apply
> > > Patch failed at 0002 perf: Stop using deprecated bpf_object__next() A=
PI
> > > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patc=
h
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort=
".
> > >
> > >
> > > - Arnaldo
> > >
> > > > v4 -> v5:
> > > >   - add bpf_perf_object__add() and use it where appropriate (Jiri);
> > > >   - use __maybe_unused in first patch;
> > > > v3 -> v4:
> > > >   - Fixed commit title
> > > >   - Added weak definition for deprecated function
> > > > v2 -> v3:
> > > >   - Fixed commit message to use upstream perf
> > > > v1 -> v2:
> > > >   - Added missing commit message
> > > >   - Added more details to commit message and added steps to reprodu=
ce
> > > >     original test case.
> > > >
> > > > Christy Lee (2):
> > > >   perf: Stop using deprecated bpf_load_program() API
> > > >   perf: Stop using deprecated bpf_object__next() API
> > > >
> > > >  tools/perf/tests/bpf.c       | 14 ++----
> > > >  tools/perf/util/bpf-event.c  | 13 +++++
> > > >  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++---=
----
> > > >  3 files changed, 96 insertions(+), 29 deletions(-)
> > > >
> > > > --
> > > > 2.30.2
> > >
> > > --
> > >
> > > - Arnaldo
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
