Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE66CCE71
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 02:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjC2AAJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 20:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2AAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 20:00:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E6F3AAA
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:59:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so56435182edb.10
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680047985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EedOomMuIt6s4Fkf7a6Vl0lEdMcGDJH13sQKjuGj35g=;
        b=GzWkTCLzf4tW2FHQX3RtNNiFwxf39lSXnfkRv618w7YfD7N5OeSqvnZ32LgP8LcIX9
         o29XGGpjMebDes+d+FrDvoHwvMiTWTUAxwKPtcOn+upAF01tZbSyp+xupMtC8bKUhJIo
         rFNX6bCh9TnjRrEmjzgVqNOh+Ye8GcAe56bqon39IKOlSR0gLeJRYlRjpeWMGEeu3k8o
         34T91o+BXIUcDD9B87o5Cii06Or42GPykQNj0cLoRkSw7YipDFwu1yC67T1GzWG+iaGA
         JU1klef+QC/qT/HqfEISkel/S3G1gTPU2nwr4ixbb79V96AjAuUTFQBVAdrwKxgSyYrP
         km5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EedOomMuIt6s4Fkf7a6Vl0lEdMcGDJH13sQKjuGj35g=;
        b=5cqitVsQBrlx1Vquy39AQIh6i9rzoAXyDOTphkSM4LyFfxnILev5M8msSvIDEWl7Zd
         Cn/YxdVYbbQNEiT6G0eYcGOfxKi+TjJjUmoEl50irnY2fVA0szLwJ8mB0FLjzdVn8nnD
         e9e1J2dRbN3/kNkY1EXOzID3Q5uCcvZuew58uR/Boe/Q07NoQOsdvN8n4uZgq+5VvQO5
         ezpPmySw+IKdtCaWi/9/LrlHbsE6c7JHakHlj924LoRRsLtGeMrPjtTaCgiDE8QLq0CZ
         Wrm7kMMe9j/00rSyrD00dRFufA+uyDd1u9ZcfEOiWuncPcVF9nNu7stY2FJsXDVULViV
         DDlw==
X-Gm-Message-State: AAQBX9cDOggBvKZk+2WH1w/xl6PLZ1q04KqRV9sblaL3s4/TMg3dHFgD
        4d7W5CBFHspN63xFUVRNi4hQfOzdyUYhvcCb6LtwQUsr
X-Google-Smtp-Source: AKy350asP/P2gYtOohQXV8fwavfgL5qqpKgdOFDCmTdsjUECINsurpkbaxHoZbrzgceYxzjE/jSbOLdsFBwPqyEMft0=
X-Received: by 2002:a50:9fef:0:b0:4fc:2096:b15c with SMTP id
 c102-20020a509fef000000b004fc2096b15cmr8991257edf.1.1680047984852; Tue, 28
 Mar 2023 16:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Mar 2023 16:59:32 -0700
Message-ID: <CAEf4BzaAcD0HEgJzQH4NTWAzkTXHLS7T-eGGxxhHm2ADROTRrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] BPF verifier rotating log
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, lmb@isovalent.com, timo@incline.eu,
        robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 4:56=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set changes BPF verifier log behavior to behave as a rotating =
log,
> by default. If user-supplied log buffer is big enough to contain entire
> verifier log output, there is no effective difference. But where previous=
ly
> user supplied too small log buffer and would get -ENOSPC error result and=
 the
> beginning part of the verifier log, now there will be no error and user w=
ill
> get ending part of verifier log filling up user-supplied log buffer.  Whi=
ch
> is, in absolute majority of cases, is exactly what's useful, relevant, an=
d
> what users want and need, as the ending of the verifier log is containing
> details of verifier failure and relevant state that got us to that failur=
e. So
> this rotating mode is made default, but for some niche advanced debugging
> scenarios it's possible to request old behavior by specifying additional
> BPF_LOG_FIXED (8) flag.
>
> This patch set adjusts libbpf to allow specifying flags beyond 1 | 2 | 4.=
 We
> also add --log-size and --log-fixed options to veristat to be able to bot=
h
> test this functionality manually, but also to be used in various debuggin=
g
> scenarios. We also add selftests that tries many variants of log buffer s=
ize
> to stress-test correctness of internal verifier log bookkeeping code.
>
> v1->v2:
>   - return -ENOSPC even in rotating log mode for preserving backwards
>     compatibility (Lorenz);

I haven't implemented the feature we discussed, where the
BPF_PROG_LOAD (and BPF_BTF_LOAD) command will return back the full
size of the buffer that's necessary to contain the complete log
buffer. I'm building it on top of this patch set and would like to
send it separately as a follow up, as it touches UAPI some more, and I
feel like we'll have few revisions just for this. So I didn't want to
delay these changes. Plus, I think to add this even for BPF_LOG_FIXED
mode, so it's provided consistently. So I need a bit more time to
implement this. Hopefully this version will work for everyone and can
go in sooner.

>
> Andrii Nakryiko (6):
>   bpf: split off basic BPF verifier log into separate file
>   bpf: remove minimum size restrictions on verifier log buffer
>   bpf: switch BPF verifier log to be a rotating log by default
>   libbpf: don't enforce verifier log levels on libbpf side
>   selftests/bpf: add more veristat control over verifier log options
>   selftests/bpf: add fixed vs rotating verifier log tests
>
>  include/linux/bpf_verifier.h                  |  48 ++--
>  kernel/bpf/Makefile                           |   3 +-
>  kernel/bpf/btf.c                              |   3 +-
>  kernel/bpf/log.c                              | 262 ++++++++++++++++++
>  kernel/bpf/verifier.c                         |  88 +-----
>  tools/lib/bpf/bpf.c                           |   2 -
>  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
>  .../selftests/bpf/prog_tests/verifier_log.c   | 164 +++++++++++
>  tools/testing/selftests/bpf/veristat.c        |  42 ++-
>  9 files changed, 506 insertions(+), 107 deletions(-)
>  create mode 100644 kernel/bpf/log.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c
>
> --
> 2.34.1
>
