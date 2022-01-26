Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AF49D2ED
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiAZT6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiAZT6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 14:58:40 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097BC06173B;
        Wed, 26 Jan 2022 11:58:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i14so626738ila.11;
        Wed, 26 Jan 2022 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxQFkds46Y2ifZWhEndwMrXN0P9DVV4itU3txOVyclQ=;
        b=Q/kDTPp8P2pb+DlyuHzNItcqG3nCZlzdPicfcs2wENfrT5zUrywd8XCbimiNPBzpUR
         6rly7TYa5iaLJ2UapYd7w1SnxAlkVLFn/rvEOrL8Xz0W2hTlRB89+jwCwoC9NSDhKQl4
         owO1p0FK6e90jCk88TTQ5i4iLwb/lzuomP02pe5YPJdrG6j1L/HawP1HK5FTKoaOZfgE
         JB8g07Zz2xKVi7cCn4pooZUU98dXWe4BMDe/5tefUCRy8rxuRfMRuIHQkeruBk5kIvzA
         Uqsa/eZmnFmu2rsDLEyyNPmCNS2UdQOZF9FLpQyR/V0QQ0T1GDUqjnK2TykN/3qkY9hq
         M2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxQFkds46Y2ifZWhEndwMrXN0P9DVV4itU3txOVyclQ=;
        b=ij63W5z3NtFdvGLvTtZ4YtEEiIkfl+ICFodFrXE3WV+v2AioO9o5ljA8uQ4voXIbs9
         ngehx8wNboFvdYAa0vTgUh46/+IdOAHEXQgiihUtVJHCw+/fgPqti0FvXQsCYQILzK0y
         Qz7nHB8ez8k3g/vOjfD8gGvKHScBF0iA3YOvIPhKUBbZWLZB3DUp54i+Z74stg4Xjc8Z
         6B8GH2JZf1WrXUGrZU1DhE3cEROWNOysiC/IuvJ9j91jKTKsaOCHxWCtWWavynNc4aUd
         FMvkIgi1+74w3nYq7QEOvA3WdtQAtcjQuXdl76w7/WBTRaCHe5Yayyqb1zeYxbQXldWe
         uMmw==
X-Gm-Message-State: AOAM533Apyz+pZpY7Q9jzSqdiMay8XLxAjE+Vw96uG0On3cpPG/GH/ej
        rtMImNoqcjee4JMXx7XN6ITw5b24fkHFgu/mzBM=
X-Google-Smtp-Source: ABdhPJxEjBhHLzKYRCKg6pDSylE7LEMtBPmMP3p3s0ScfXwtfsPd7BqVk4WBd9Ky28Va89CSI6/5Fck89EjIME7pmeo=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr472581ilu.71.1643227118636;
 Wed, 26 Jan 2022 11:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-4-kuifeng@fb.com>
In-Reply-To: <20220126192039.2840752-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 11:58:27 -0800
Message-ID: <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Create an instance of btf for each worker thread, and add type info to
> the local btf instance in the steal-function of pahole without mutex
> acquiring.  Once finished with all worker threads, merge all
> per-thread btf instances to the primary btf instance.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

There are still unnecessary casts and missing {} in the else branch,
but I'll let Arnaldo decide or fix it up.

Once this lands, can you please send kernel patch to use -j if pahole
support it during the kernel build? See scripts/pahole-version.sh and
scripts/link-vmlinux.sh for how pahole is set up and used in the
kernel. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c |   5 ++
>  btf_encoder.h |   2 +
>  pahole.c      | 125 ++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 124 insertions(+), 8 deletions(-)
>

[...]
