Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05401149200
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 00:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgAXX0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 18:26:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44132 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbgAXX0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 18:26:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id w8so2884072qts.11
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 15:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTAEwgRWvbu8ydTGqLXuTo/hhOVQds5P6lPcrWETvtY=;
        b=IWEBxLvZi3GyTervxZy76zyVc2eEDl6+8Ns3NVs87NA7WsVzUIu4RL/LZcPKxP2Rrm
         N/g1lm4vUiPhbG8iw5UMhqy/GRWDsmlTQCvRgvh1k1OM/aTzMDrbXD4fGtKu2YT8kHjI
         8yWYcM2F6LTTWG4e6o25mcGoMBTx3bW9P0eS7bsfGvFPDMZQQpR8AAcNmXWnJxQLakJL
         p+iUahyTy6UoPOj37kB7TQGuQYIdHNgBrxGt3Zwtop3my+SlkcoHtWdQFU9z6HfggsiN
         jzuyyACW+z4pA7j8XV9tg/zzWq4+o5b6siDBAAZIVcVZLblReGxO3Zoo/lymVoxfwiqs
         NAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTAEwgRWvbu8ydTGqLXuTo/hhOVQds5P6lPcrWETvtY=;
        b=dhBdP8KOHtJebT2Z8AKCQCg7DuQPxyYNJxH0KfdJjG8+e0hCBNU+giQwwKpSjR0UMI
         3kFLQ5tQFzrypIPzxBzRmBLElGK9dUIYjRbP/EAaPLyPNMV143wHT83OmoyROUdWCXEu
         UGhCOAXEpsX+jr2II2rDfO79EkKMWaTog6XcplgALQq70U6ixZJ/p3IwK0TBFFK2ICTC
         o9qVx4iaQnlCq0L2xJv5kE0XSt91CwT4PFaMAl5xWxFwUpSuB68JzpxZKvrcjGTPqR94
         y1tJXvEwes1eyi6FR07jn21mMbVLzAM89rcSqLHsd6Xe1AqyGwu8DA7Klw6COEm4+FQb
         hQcg==
X-Gm-Message-State: APjAAAWFmMSX8QE2G0uzU4ChP/T4ol97OIU53mefjpxfunAaHIM4oXF1
        8cplAjdnwKMkIguOFB6npECyQrveNqb+jw9bQV8=
X-Google-Smtp-Source: APXvYqyF/tPeEZNwoGAuSruLZzkV1WJl6RdGnFI+H62yluMTG0z0vSBk14y30+SuG4ZjDkHncd42H0W1YJgCvcqR0ac=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr4876235qtl.171.1579908377957;
 Fri, 24 Jan 2020 15:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20200124224142.1833678-1-rdna@fb.com>
In-Reply-To: <20200124224142.1833678-1-rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jan 2020 15:26:05 -0800
Message-ID: <CAEf4BzYZMwDAu-4=UXUBE8NbhXnRnsWWc9Z4mypU0zDb3m6TSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/bpf: Allow overriding llvm tools for runqslower
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 2:42 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> tools/testing/selftests/bpf/Makefile supports overriding clang, llc and
> other tools so that custom ones can be used instead of those from PATH.
> It's convinient and heavily used by some users.
>
> Apply same rules to runqslower/Makefile.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/runqslower/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index faf5418609ea..0c021352beed 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  OUTPUT := .output
> -CLANG := clang
> -LLC := llc
> -LLVM_STRIP := llvm-strip
> +CLANG ?= clang
> +LLC ?= llc
> +LLVM_STRIP ?= llvm-strip
>  DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  LIBBPF_SRC := $(abspath ../../lib/bpf)
> --
> 2.17.1
>
