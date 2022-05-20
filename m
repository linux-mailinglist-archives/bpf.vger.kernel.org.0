Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0952F65D
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbiETXqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353370AbiETXpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:45:55 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4239218357
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:45:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 2so443222iou.5
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5DUsVW8/AdLVP542TLTzS4m58PR1mZagn5FN0OcblA=;
        b=FS5OSt1Tar/3KioeeIfcDkDaTF2asjZqNWHkL6IUIQKFz9S11vQadI7GijpImTTamv
         ugHoc8A05d2DBRvaCUGO6S2Duk05ml0zhl8ddcTfyLvrMbEwo6Amljm+rDo3NGChlBmn
         pN5dImQnwvenxo3GMs3ZIaU5pAVL8c1BpHxcXoJcRQAnxoojqMwek1cq4UsxTbTgO2Hd
         6Y1Ef2hZbWkzJ/k3YFKsXPZaWev9L9KZwdgKMQFhC/X4J9ArST5vrhg8vyzV38dVkMB+
         BJTFTpi9jKcbWOyd3kYu9oVveFmtQxD529FS+OOXEdlm3skSmN2XC+gpJX9ngfTL1WyN
         vjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5DUsVW8/AdLVP542TLTzS4m58PR1mZagn5FN0OcblA=;
        b=voyMD2AuEpcRKHj3PCKqeC/vLcRAD7Xu7Y7a/3z5I/kN5PlYiS0Rf9WdhRzrhobvcb
         sKc1pSucY9ICR7hToNG3K8/v+i2lKfTHc+mdZPbVW4HyPkG5jksAmkIGHu6hNuXGLCag
         lES71kMtrKjCLo9QQ48eDksdTRjPKnmC/qmNerxzDpO0AE38JsgYVGubr0a2dDwpTDC+
         sjpTPIRAs5MOfxC2qz5bEnvRwIcJPaG4OCpDIBsQ/7nb5gjK1ex2sWffU+3fIrtrSKY8
         QmXNZqVDPqnAJhaJruglo2Fqz71NJlyis7IuDKFg+OwF/hlr8+T8q8qjrUwHIPFA2Ye/
         E+fQ==
X-Gm-Message-State: AOAM530v80K+RPTbJEdN67rkS/aRjzf1NKBVHaRO9SQ1F0KKrkzL+GUm
        b0t6zBjrLDNk4u4L5WmYVLZ4bRSgSRwun7KksYiDUPqYkxI=
X-Google-Smtp-Source: ABdhPJyV3OzqQogkIpgzIY7ywcgpQZMVGNSskNd7K0/Iu9WtZKDW7ij9kWDIjkkJgqgXOIUlDO4tHMAObTdfY1x+WAA=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr6618096jav.93.1653090353541; Fri, 20
 May 2022 16:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220519213001.729261-1-deso@posteo.net>
In-Reply-To: <20220519213001.729261-1-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 May 2022 16:45:42 -0700
Message-ID: <CAEf4BzYZ+XY+uhSw1tOC=2KZe19hPsgAuq8o6CRsqCDfbqr59Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/12] libbpf: Textual representation of enums
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
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

On Thu, May 19, 2022 at 2:30 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
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
> bpf_attach_type variants. We decided changing its behavior to work with l=
ibbpf
> representations. However, for user inputs, specifically, we do keep suppo=
rt for
> the traditionally used names around (please see patch "bpftool: Use
> libbpf_bpf_attach_type_str").
>
> The patch series is structured as follows:
> - for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_t=
ype,
>   bpf_link_type}:
>   - we first introduce the corresponding public libbpf API function
>   - we then add BTF based self-tests
>   - we lastly adjust bpftool to use the libbpf provided functionality
>
> Changelog:
> v2 -> v3:
> - use LIBBPF_1.0.0 section in libbpf.map for newly added exports
>
> v1 -> v2:
> - adjusted bpftool to work with algorithmically determined attach types a=
s
>   libbpf now uses (just removed prefix from enum name and lowercased the =
rest)
>   - adjusted tests, man page, and completion script to work with the new =
names
>   - renamed bpf_attach_type_str -> bpf_attach_type_input_str
>   - for input: added special cases that accept the traditionally used str=
ings as
>     well
> - changed 'char const *' -> 'const char *'
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> Acked-by: Yonghong Song <yhs@fb.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
>

So this looks good to me for libbpf and selftests/bpf changes. I'll
wait for Quentin to give his acks at least for bpftool changes.
Quention, please take a look when you get a chance.

Few small nits, please accommodate them in next version, if you happen
to send another one. If not, I'll try to remember to fix it up when
applying.

1. Received Acked-by/Reviewed-by tags should be added to each
individual patch, not cover letter.

2. You are using /** ... */ comments, which are considered to be kdoc
comments and they have some additional formatting, which some of the
tooling run on patches in Patchworks complains about [0]. Please use
just /* ... */ style everywhere where it's not actual kdoc (or libbpf
API documentation).

  [0] https://patchwork.hopto.org/static/nipa/643335/12856068/kdoc/summary

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
>  .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
>  .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
>  tools/bpf/bpftool/cgroup.c                    |  49 +++--
>  tools/bpf/bpftool/common.c                    |  82 +++----
>  tools/bpf/bpftool/feature.c                   |  87 +++++---
>  tools/bpf/bpftool/link.c                      |  61 +++---
>  tools/bpf/bpftool/main.h                      |  23 +-
>  tools/bpf/bpftool/map.c                       |  82 +++----
>  tools/bpf/bpftool/prog.c                      |  77 +++----
>  tools/lib/bpf/libbpf.c                        | 160 ++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  36 +++
>  tools/lib/bpf/libbpf.map                      |   6 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     | 207 ++++++++++++++++++
>  .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++--------
>  15 files changed, 738 insertions(+), 334 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c
>
> --
> 2.30.2
>
