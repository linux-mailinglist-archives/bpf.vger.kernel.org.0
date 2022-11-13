Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86C626E8B
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiKMInt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 03:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 03:43:48 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB579DF3A
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 00:43:46 -0800 (PST)
Date:   Sun, 13 Nov 2022 08:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668329023;
        x=1668588223; bh=PB6zQVyGct9TfMuRhYTrjzyrwSGKudB8nxR7UWmp1UM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=U+uCsCBLqgxv6b8nZfB5yas3CmjnkhYx6Xp+yztgla3OES+xZgTjW2s1fZ0GyjaAp
         78/zeHWKsvv2jm6qvRcFlmnl3pt07DwPU1Muhs/KxJfByieTGZhIOrqyoP4dUildTn
         84CVbq+JyPd4tSTx6elnxk4MJdPgw+EqhNCQI1pzD0GvNwc6J3JLu8IC5yOIn7Tns7
         ZTr2ja0c8XGqk6Bv2+ed0Hg/UAkXNw8MoneZy0fRwJXwTH8oicn7SqX6DvND/eU0kr
         LAV5DDeXbbqTPpw7m3oxMc0q7KDtjB3cmyVUpDpsZ6gSvSmEiL0Op1qGUS3oaWksFz
         OqHTOnY+G8jsg==
To:     Yonghong Song <yhs@meta.com>
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] clean-up bpftool from legacy support
Message-ID: <Y3CuJ5GtVg+fEH+z@system76-pc.localdomain>
In-Reply-To: <8f340958-71da-508c-bf57-73daa0fd22cc@meta.com>
References: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com> <8f340958-71da-508c-bf57-73daa0fd22cc@meta.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/09/ , Yonghong Song wrote:
>
>
> On 11/8/22 11:44 PM, Sahid Orentino Ferdjaoui wrote:
> > As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
> > definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
> > 1.0 behaviors") The --legacy option is not relevant anymore. #1 is
> > removing it. #4 is cleaning the code from using libbpf_get_error().
> >
> > About patches #2 and #3 They are changes discovered while working on
> > this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
> > unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
> > passed to strerror().
> >
> > v1 -> v2:
> >    - Addressed review comments from Yonghong Song on patch #4
> >    - Added a patch #5 that removes unwanted function noticed by
> >      Yonghong Song
> >
> > Sahid Orentino Ferdjaoui (5):
> >    bpftool: remove support of --legacy option for bpftool
> >    bpftool: replace return value PTR_ERR(NULL) with 0
> >    bpftool: fix error message when function can't register struct_ops
> >    bpftool: clean-up usage of libbpf_get_error()
> >    bpftool: remove function free_btf_vmlinux()
> >
> >   .../bpftool/Documentation/common_options.rst  |  9 --------
> >   .../bpftool/Documentation/substitutions.rst   |  2 +-
> >   tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
> >   tools/bpf/bpftool/btf.c                       | 17 ++++++--------
> >   tools/bpf/bpftool/btf_dumper.c                |  2 +-
> >   tools/bpf/bpftool/gen.c                       | 11 ++++------
> >   tools/bpf/bpftool/iter.c                      |  6 ++---
> >   tools/bpf/bpftool/main.c                      | 22 +++---------------=
-
> >   tools/bpf/bpftool/main.h                      |  3 +--
> >   tools/bpf/bpftool/map.c                       | 20 ++++++-----------
> >   tools/bpf/bpftool/prog.c                      | 15 +++++--------
> >   tools/bpf/bpftool/struct_ops.c                | 22 ++++++++----------=
-
> >   .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
> >   13 files changed, 44 insertions(+), 93 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> You can carry the 'Ack' if no significant change for
> each patch.

Thanks a lot for this advice. I will use this in my v3 when addressing
Andrii comments.

> Ack for the whole series.
>
> Acked-by: Yonghong Song <yhs@fb.com>

