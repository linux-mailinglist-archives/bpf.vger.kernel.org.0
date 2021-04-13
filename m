Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB8235E8BE
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbhDMWFY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhDMWFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:05:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE6C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:05:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v3so17515430ybi.1
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwzcbDiDUc31zGP77hawGcwV1/yKxcxWhcxlp1rWxZs=;
        b=J8ZWU1yIn8jOb9i9/+dIVjBSEKs/h0vmMc23ksHx8DKGPldsmO8Qr4R1/cT9CGZ9l4
         YLaSui/rWYLkZAqt7dMiI7uKXBR1AtVy5f4voXPHp9q3D74gHSbLl8i3VyIbqmXs6Gpk
         mEw1SraG5GTtH8OCY5s+jm93979jXwnZIaioX8U16EBZTX2qM2XqsNguRg2VP9kgLNti
         ZJ0mWphxDM95U5EAR6GiT0Y9rSVTYFIJKmQzTUMBCxGBD9n9qQxcNcb+uYOlKblvSeMB
         Nn0XMOy34s8FrpQOT8/zaUMP2Tu2+PVFAQemKt2wCouUKd+KBXThsuEtKL3E9icZ5i9C
         LzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwzcbDiDUc31zGP77hawGcwV1/yKxcxWhcxlp1rWxZs=;
        b=ObisllN3Dy9D0TOr7U1P3qruRZzZUDokdG1xZQ5lXGfjxN+6SYPrEo1lXU80HPrsXV
         EG2728vWufIq+URRL/GCyo8ssYXi+qwBGPHNFVB4AV6KSzuVbIZ8fPRmvY8kjS7Kz+Uh
         3KrvGf4SiKkJ0CWgpf3HhFsFGr1zsYQyETQax+7ETX+4uSpGdaE0AS00VQxM9u3juT5l
         QlX6ItDSUwo02twiZgC+R5jrmI/1flp4mYgu+mGCS7YIv0G8j3KUV4BZ6MrsTPjs/y1Z
         V+PHzyd0bDuXUdQLHU9zeBKus/pUsP7kI9QXhSmnFfOSbGtfKiXU80boDa5Qjow5rqRt
         Ro0w==
X-Gm-Message-State: AOAM532tYvYsy0fhNw4oxNbNrY9feHCSGUggZIrJkWHC3m7yFxbBiZrs
        vawQnPUx8B+tfqcN7Utyg7oCtf14xSjHgURwQlc=
X-Google-Smtp-Source: ABdhPJy8q+QArcfcI0GvCkv8Aen6j7w01tObUiJ7TIh+socQT/XBqWwOMQldl4+VxMiDYpWi1fO49WPQOTcGaLf03WA=
X-Received: by 2002:a25:9942:: with SMTP id n2mr47183912ybo.230.1618351503054;
 Tue, 13 Apr 2021 15:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153413.3027426-1-yhs@fb.com>
In-Reply-To: <20210413153413.3027426-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 15:04:52 -0700
Message-ID: <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if
 LLVM is set
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
>
> selftests/bpf/Makefile includes lib.mk. With the following command
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> some files are still compiled with gcc. This patch
> fixed lib.mk issue which sets CC to gcc in all cases.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/lib.mk | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index a5ce26d548e4..9a41d8bb9ff1 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -1,6 +1,10 @@
>  # This mimics the top-level Makefile. We do it explicitly here so that this
>  # Makefile can operate with or without the kbuild infrastructure.
> +ifneq ($(LLVM),)
> +CC := clang

Does this mean that cross-compilation with Clang doesn't work at all
or is achieved in some other way?


> +else
>  CC := $(CROSS_COMPILE)gcc
> +endif
>
>  ifeq (0,$(MAKELEVEL))
>      ifeq ($(OUTPUT),)
> --
> 2.30.2
>
