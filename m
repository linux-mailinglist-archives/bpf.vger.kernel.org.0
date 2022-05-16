Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA380529571
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 01:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbiEPXnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiEPXny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 19:43:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83023369D5
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:43:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e3so17688699ios.6
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7RBYF0Eag3EQ8BRE/ZBj5JUOHmqfvm0MbODfaaZVQhc=;
        b=eN/AOebNGNkLE1mD1YTit1AjZ3jvWKF8B1VFESsofdFIdu13WQSPnW0DRx/8980k/d
         LROg8Ly7d00jPDh/CnB16BD+AfPogqiE8hn0zm/8t/Zq6r0IiL+tYVpzzJ62ZGsHZvfi
         y5oGy5uEutiPHWzuD7wGssg6YHHHxMWxSkI84lLkZuGohYjl+01U3k7oVs6XFg2/K4wT
         2bYC5dfagveEa4+v/7CAXnHioR0prkIXLpKflvfpf1k5ITbRJ9hgaXsbDgDxp4ZTSmw1
         LrThLm00bcfQEdOe51LuUZCJnJ1/qqWX11reu3ANPVbhXBcGOmkt6cRd9jUNDzduTdlk
         eK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7RBYF0Eag3EQ8BRE/ZBj5JUOHmqfvm0MbODfaaZVQhc=;
        b=ixKYQImEnPjQaBAPZqusSqIvRignRfIvAzaXxS4qm725MVE6k8Rw+6tcLyF7xhhr9k
         bfAYPXaGchuBn1ykC5KYTvGy7+C92KNOonazss/1hmUQQFf7vr1vHe3EKyD25EdKaBfP
         JdFn3AP+RioP/CrAEQcpjqlHPW9pzPHxILI/cbJEQQCS//H5W2rzfLHv1q5DOafPuDGs
         FLxcltUBOf0RR6KCyYfUoh/wfR9oBLy8aD2rYTJG0lKiHazh6LX1cDGS4ZOaicno3Dy5
         LV072Mi4CS60gYr++dV2XswvTbG8JpPKQPpZnGESiQbg4LE0kXIctauRIFMSNJxHT3aD
         2q0g==
X-Gm-Message-State: AOAM533juxwGZm6Oqgd8krHmoav+Zj7m3bHRJC2D4ITQR27w0C6Q/Fne
        qvDRDMvORsCRk2BB0X3CpHWGgySnlTvB1GWtbaI=
X-Google-Smtp-Source: ABdhPJy00+MyF/JyQWIRs2duO/XukTveGBquIe5JoYm2CPvh1BZ/SK7VzDKTqwTfLykfa1wvKTFY4oBagjhs6kf5tGc=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr9247095ion.63.1652744632934; Mon, 16
 May 2022 16:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173540.3520665-1-deso@posteo.net>
In-Reply-To: <20220516173540.3520665-1-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 16:43:42 -0700
Message-ID: <CAEf4BzYg24WGidanbqQHQnUUeWS0JFKze08cGCPtD+EX94LrFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/12] libbpf: Textual representation of enums
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 10:35 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This patch set introduces the means for querying a textual representation=
 of
> the following BPF related enum types:
> - enum bpf_map_type
> - enum bpf_prog_type
> - enum bpf_attach_type
> - enum bpf_link_type
>
> To make that possible, we introduce a new public function for each of the=
 types:
> libbpf_bpf_<type>_type_str.
>
> Having a way to query a textual representation has been asked for in the =
past
> (by systemd, among others). Such representations can generally be useful =
in
> tracing and logging contexts, among others. At this point, at least one c=
lient,
> bpftool, maintains such a mapping manually, which is prone to get out of =
date as
> new enum variants are introduced. libbpf is arguably best situated to kee=
p this
> list complete and up-to-date. This patch series adds BTF based tests to e=
nsure
> that exhaustiveness is upheld moving forward.
>
> The libbpf provided textual representation can be inferred from the
> corresponding enum variant name by removing the prefix and lowercasing th=
e
> remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunat=
ely,
> bpftool does not use such a programmatic approach for some of the
> bpf_attach_type variants. We propose a work around keeping the existing b=
ehavior
> for the time being in the patch titled "bpftool: Use
> libbpf_bpf_attach_type_str".
>
> The patch series is structured as follows:
> - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_t=
ype,
>   bpf_link_type}:
>   - we first introduce the corresponding public libbpf API function
>   - we then add BTF based self-tests
>   - we lastly adjust bpftool to use the libbpf provided functionality
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
>
> Daniel M=C3=BCller (12):
>   libbpf: Introduce libbpf_bpf_prog_type_str
>   selftests/bpf: Add test for libbpf_bpf_prog_type_str
>   bpftool: Use libbpf_bpf_prog_type_str
>   libbpf: Introduce libbpf_bpf_map_type_str
>   selftests/bpf: Add test for libbpf_bpf_map_type_str
>   bpftool: Use libbpf_bpf_map_type_str
>   libbpf: Introduce libbpf_bpf_attach_type_str
>   selftests/bpf: Add test for libbpf_bpf_attach_type_str
>   bpftool: Use libbpf_bpf_attach_type_str
>   libbpf: Introduce libbpf_bpf_link_type_str
>   selftests/bpf: Add test for libbpf_bpf_link_type_str
>   bpftool: Use libbpf_bpf_link_type_str
>

Looks good to me overall. But keep in mind that libbpf v0.8 was just
released, so these new APIs will have to go into 1.0 section in
libbpf.map. It can't inherit from 0.8, btw, so this is a bit new
procedure, I'll try to get to it in next few days. Meanwhile I'd like
to get some feedback at least from Quentin on bpftool changes.

>  tools/bpf/bpftool/cgroup.c                    |  20 +-
>  tools/bpf/bpftool/common.c                    |  46 ----
>  tools/bpf/bpftool/feature.c                   |  87 +++++---
>  tools/bpf/bpftool/link.c                      |  61 +++---
>  tools/bpf/bpftool/main.h                      |   6 -
>  tools/bpf/bpftool/map.c                       |  82 +++----
>  tools/bpf/bpftool/prog.c                      |  51 +----
>  tools/lib/bpf/libbpf.c                        | 160 ++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  36 ++++
>  tools/lib/bpf/libbpf.map                      |   4 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     | 201 ++++++++++++++++++
>  11 files changed, 539 insertions(+), 215 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c
>
> --
> 2.30.2
>
