Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE043A49C
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhJYU2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbhJYU1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 16:27:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD0C04F5A1
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:15:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d205so13046959qke.3
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r20jmrkvSoeU0GArP1aRAz2DxJYwHA9lYmnsg20gPA=;
        b=lpERwUL8H/Ravsg1Ywx6/mcTP+m6rTEDdaHtH6KvuM9XFTqbdIt0o7SCqNO+PJVudB
         qkVHxuPeywJ2QXDggb/5aqVZ7CjDGy+9t3E9bNpHGMB3+uQASlfiFikbxBvFL25zzsq1
         AH2Ardoj5HABHmHvJsSsUaCHIghJGsOTm4/wvjzUwqzrviuPKu6cFnRF52V1QlP7ShJ7
         aBllq+QPVvlKew8TUn8qXSB5swvQgbTneQvs/gg3ZFaP6RHQ+bSlrffNB2HyUI5G9/Bb
         y9BWypfas3VPTE6UwQj7mmMaXkktIKq3SpMm+1/1bHgboZ+1ZAgXBMO5c9xKti4N/ISR
         OihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r20jmrkvSoeU0GArP1aRAz2DxJYwHA9lYmnsg20gPA=;
        b=vOUizLox/S06HlllHc256zzPcddKRFA982PO2dxkmojxMO4Sn71x6Yn1RSr9IA74hE
         7TIb4gnqNFCvpzK0D3p0UIenwYw7XndM3A5ut6sLnDwq7ldgKv5OUnxWyBlyT7jfMejx
         hmnj/ldk7gZr352s6vRGbMlIkLld72ACv+akvFikRUPmX0GUWo7Aols6blgvOf6TiPGq
         MzZyKJSu4JkJTtc6/Rt1vBKqg0Po8/FvBdQdN+xranFjWyxnewGCI6OW71QquiTH0ONB
         wBJyLP2FCJMCXOdzqlCbkDJYj7wcmhP+ctELaFtkOz9aNuF5c50Vt3ZwLna/l+QTDEg8
         8pEw==
X-Gm-Message-State: AOAM530hCvMd8ZG6Ot5Buwl3NPZovGZqcUKdWRBN26x2lASZt2Z8yOOL
        Ej0c2Ai5aUKpemSp2AfqpHQLdd/qLQ6Siy1iHwE=
X-Google-Smtp-Source: ABdhPJxpHmnjZVGUWj/hSO5CHAtEmZs21oHL428zXWYD3Q+LdbS/3gWHP1DK4kNnYZuulYxQYlF0A290Wp+9USr9wIg=
X-Received: by 2002:a37:65d0:: with SMTP id z199mr15443223qkb.484.1635192956943;
 Mon, 25 Oct 2021 13:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org>
In-Reply-To: <20211022223228.99920-1-andrii@kernel.org>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 25 Oct 2021 13:15:30 -0700
Message-ID: <CAJygYd11fmiNsw2F1HV1NxCkj_ustqWRdxJqRUpKPimAG37+8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Parallelize verif_scale selftests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks, this patch is awesome!

Acked-by: Yucong Sun <sunyucong@gmail.com>


On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Reduce amount of waiting time when running test_progs in parallel mode (-j) by
> splitting bpf_verif_scale selftests into multiple tests. Previously it was
> structured as a test with multiple subtests, but subtests are not easily
> parallelizable with test_progs' infra. Also in practice each scale subtest is
> really an independent test with nothing shared across all substest.
>
> This patch set changes how test_progs test discovery works. Now it is possible
> to define multiple tests within a single source code file. One of the patches
> also marks tc_redirect selftests as serial, because it's extremely harmful to
> the test system when run in parallel mode.
>
> Andrii Nakryiko (4):
>   selftests/bpf: normalize selftest entry points
>   selftests/bpf: support multiple tests per file
>   selftests/bpf: mark tc_redirect selftest as serial
>   selftests/bpf: split out bpf_verif_scale selftests into multiple tests
>
>  tools/testing/selftests/bpf/Makefile          |   7 +-
>  .../bpf/prog_tests/bpf_verif_scale.c          | 220 ++++++++++++------
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/prog_tests/resolve_btfids.c |  10 +-
>  .../selftests/bpf/prog_tests/signal_pending.c |   2 +-
>  .../selftests/bpf/prog_tests/snprintf.c       |   4 +-
>  .../selftests/bpf/prog_tests/tc_redirect.c    |   2 +-
>  .../bpf/prog_tests/xdp_adjust_tail.c          |   6 +-
>  .../bpf/prog_tests/xdp_devmap_attach.c        |   4 +-
>  9 files changed, 169 insertions(+), 88 deletions(-)
>
> --
> 2.30.2
>
