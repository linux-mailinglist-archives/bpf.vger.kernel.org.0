Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9498B45CD69
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhKXTnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 14:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhKXTnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 14:43:10 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983B8C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:40:00 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t6so4176790qkg.1
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuGAYRuUxuKMsobGmynQjPVsLqR9gWtfIY1YGNkDRrU=;
        b=L1K1ofYIP0K7QL9llWTxxr4VRpVPMqR/RqhvstzLl6HosVz9Hs2a6tILaXhUajwDuA
         a5OJ4SHOZrjCkhK6yWbNnYkM+Gh+ZtPQ8B03eaXeuj9uk0+TcJcMlCiF56XsQiU5fZeh
         eKSHFw9jySOAvdQ2Vr+nm40L5X/gwitNxffoCtGXSZLeIfUVjaueAM7avoaQRvj+XXYz
         0BF7qtWdaB3V+4hTDDVK/bwz3fTTm1wDUHiVnteYAC8xMFe21hZQoS2ichzRy5LFCvTk
         v+YTMTL10ApA3+25PVFoU06c2uZ+gZXuOUG1xABd0K1MDM0Lk2Cgdu2LcxfYto2D3+pC
         ORFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuGAYRuUxuKMsobGmynQjPVsLqR9gWtfIY1YGNkDRrU=;
        b=cFM6BEhQtdqz2t/i+eXCsjfzO6D3fvN5Gnmy/uEUvHD7iM/Tpy4ihhyPqZsANAzyi+
         ICdWVxYQV7ZV1u3UPEaRfB6Fv5JcKvxfuP65ZclUreVqaMdrB560pD4qsqmVwHJHpOJc
         k/O4MRNukdg+cjnSRpbbUY6E207uEKbCy+fAjUaAwYaMoLUEXm0loWgTmscrvxmSBfyM
         5gLBdKlXNA5p+wpeUvg1/3ynPzqdrBkZMZ2d8tksYiHW0MWXNHOSoHEkuoVQ4LvniL3/
         qZ2GDJb71KP2zOCaNO6LzEu6A/XqMZspUzka0AnuaoSNGB4EtUQiQK5civ44jMBq7Flb
         sgeg==
X-Gm-Message-State: AOAM530hxq9K2P+OVBBXby1K5ji4zd2IkGwD3/A6eBUrHaUHya28MTOQ
        cw4RDne0Lqbr9oW1ZvUvjPiPCufY+aP+52gQL8A=
X-Google-Smtp-Source: ABdhPJxoIDlZovYwohHXrCIzjMjlxwSjb3Bp0nOsPPjvreZRU6hOLH9AZbsVljDdN5EEpqo2DRiuc60XFe5UVoGh1Zk=
X-Received: by 2002:a25:d16:: with SMTP id 22mr19914125ybn.51.1637782799819;
 Wed, 24 Nov 2021 11:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20211124193233.3115996-1-andrii@kernel.org>
In-Reply-To: <20211124193233.3115996-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Nov 2021 11:39:48 -0800
Message-ID: <CAEf4BzbLC2BcYJ412LYwTrxw6UYkOsDqE9fUcD55J7KqrMVSPQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] libbpf: unify low-level map creation APIs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 11:32 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add new OPTS-based bpf_map_create() API. Schedule deprecation of 6 (!)
> existing non-extensible variants. Clean up both internal libbpf use of
> to-be-deprecated APIs as well as selftests/bpf.
>
> Thankfully, as opposed to bpf_prog_load() and few other *_opts structs
> refactorings, this one is very straightforward and doesn't require any macro
> magic.
>
> Third patch also ensures that when libbpf 0.7 development starts we won't be
> getting deprecation warning for using our own xsk_* APIs. Without that it's
> hard to simulate libbpf 0.7 and ensure that there are no upcoming
> deprecation warnings.
>
> v1->v2:
>   - fix one instance of bpf_map_create() passing unnecessary opts (CI).

This was in test_maps.c, should have mentioned that.

>
> Andrii Nakryiko (4):
>   libbpf: unify low-level map creation APIs w/ new bpf_map_create()
>   libbpf: use bpf_map_create() consistently internally
>   libbpf: prevent deprecation warnings in xsk.c
>   selftests/bpf: migrate selftests to bpf_map_create()
>
>  tools/lib/bpf/bpf.c                           | 140 ++++++++----------
>  tools/lib/bpf/bpf.h                           |  33 ++++-
>  tools/lib/bpf/bpf_gen_internal.h              |   5 +-
>  tools/lib/bpf/gen_loader.c                    |  46 ++----
>  tools/lib/bpf/libbpf.c                        |  63 +++-----
>  tools/lib/bpf/libbpf.map                      |   1 +
>  tools/lib/bpf/libbpf_internal.h               |  21 ---
>  tools/lib/bpf/libbpf_probes.c                 |  30 ++--
>  tools/lib/bpf/skel_internal.h                 |   3 +-
>  tools/lib/bpf/xsk.c                           |  18 +--
>  .../bpf/map_tests/array_map_batch_ops.c       |  13 +-
>  .../bpf/map_tests/htab_map_batch_ops.c        |  13 +-
>  .../bpf/map_tests/lpm_trie_map_batch_ops.c    |  15 +-
>  .../selftests/bpf/map_tests/sk_storage_map.c  |  50 +++----
>  .../bpf/prog_tests/bloom_filter_map.c         |  36 ++---
>  .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  51 +++----
>  .../bpf/prog_tests/cgroup_attach_multi.c      |  12 +-
>  .../selftests/bpf/prog_tests/pinning.c        |   4 +-
>  .../selftests/bpf/prog_tests/ringbuf_multi.c  |   4 +-
>  .../bpf/prog_tests/select_reuseport.c         |  21 +--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  |   4 +-
>  .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
>  .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
>  .../selftests/bpf/prog_tests/test_bpffs.c     |   2 +-
>  .../selftests/bpf/test_cgroup_storage.c       |   8 +-
>  tools/testing/selftests/bpf/test_lpm_map.c    |  27 ++--
>  tools/testing/selftests/bpf/test_lru_map.c    |  16 +-
>  tools/testing/selftests/bpf/test_maps.c       | 110 +++++++-------
>  tools/testing/selftests/bpf/test_tag.c        |   5 +-
>  tools/testing/selftests/bpf/test_verifier.c   |  52 +++----
>  31 files changed, 357 insertions(+), 460 deletions(-)
>
> --
> 2.30.2
>
