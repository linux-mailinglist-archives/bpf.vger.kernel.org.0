Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D244C31A6A0
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBLVQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBLVQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:16:11 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8EC061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:15:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k4so798004ybp.6
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2NIIJCdgafjz9atc5quiMXbEoxuWSG8948VHKk0SIY=;
        b=piLHV8rrrm7o2TlPf3cacwyNWf0/xtW4zsPDVaI0HHJ1oXHXvggrRmYb1BCVHfppZP
         H7++V7v8Cd/kfqoM375hyFnPgbZ/XNTIsRo6unTgSc2PC5R9epWyft6eDDB7q2hpcYOx
         mMVXJLn8AdR46B/yhMKamRZRVAzSQGWyPRPouDm08RGy6zerRbZdu8m/cYIDxPx9rzM/
         v0vOSucBhh58s3AevvpTDx6cZWx4tDSO248cKwuoOxe1mFLSkPsP/xLaS0R21By90fJE
         /sOZ1OT1dYoo/YbiAonOKY5XL04hd7rcE8UovfSUMoQrkac6OF+9VbPGaejTeD6bJtP1
         v9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2NIIJCdgafjz9atc5quiMXbEoxuWSG8948VHKk0SIY=;
        b=ue9AGtQiFVbKzA5A1AwOcNceyqMBYZWL3Klbu804rC3pL8HKGPkexeZbjAEgnsV+2v
         vffnUFcidis/0iWIZ4wd2K+aOJc8xYnM6E8Nd2uvB6vgzydU32DwYIbtz5cLV4f7a/Cn
         W4UwUycYLY7bxA/Q5nYI5V0HfaO64CJ8+V3XvVsf8XQBHPbDIbzGVqfVzX66UxgU4v/A
         nKSLZSqDdkk0HfIV3zCtKGoXcFXBO6pXtX195bUlj7CnBH7/dOpq2osTXIaelWXZa3E0
         LuaNcAANujQPklix6fA/zyaVVOhx1cUs3k2wl5j/2M8vt66tFfj0248ERS+OFoPS2qRm
         Laww==
X-Gm-Message-State: AOAM530IWQQJUgWnRb9IYdnlgK9w++Qu4wCJamp1c7suXXWWRXsnzuFG
        MC/39yUMPuABoV8Qnpk20vigRQMyHtDfxe8v8yc=
X-Google-Smtp-Source: ABdhPJxf78b3l5mZjYEZmdvPrzqy9I0kxMQEGiVXo1af2fbp65sCVhQ4wN+U7isqmTd8NSf9qA0q76/1jYfTDq1GHQw=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr6391592ybd.230.1613164530518;
 Fri, 12 Feb 2021 13:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20210212205642.620788-1-me@ubique.spb.ru> <20210212205642.620788-5-me@ubique.spb.ru>
In-Reply-To: <20210212205642.620788-5-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Feb 2021 13:15:19 -0800
Message-ID: <CAEf4BzYrVCXDSHE=hcZaONnx47Spqu6vypc1qg=Aju5n5HDpHg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Add unit tests for
 pointers in global functions
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 12:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> test_global_func9  - check valid pointer's scenarios
> test_global_func10 - check that a smaller type cannot be passed as a
>                      larger one
> test_global_func11 - check that CTX pointer cannot be passed
> test_global_func12 - check access to a null pointer
> test_global_func13 - check access to an arbitrary pointer value
> test_global_func14 - check that an opaque pointer cannot be passed
> test_global_func15 - check that a variable has an unknown value after
>                      it was passed to a global function by pointer
> test_global_func16 - check access to uninitialized stack memory
>
> test_global_func_args - check read and write operations through a pointer
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/global_func_args.c         |  60 ++++++++
>  .../bpf/prog_tests/test_global_funcs.c        |   8 ++
>  .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
>  .../selftests/bpf/progs/test_global_func11.c  |  19 +++
>  .../selftests/bpf/progs/test_global_func12.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
>  .../selftests/bpf/progs/test_global_func14.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func15.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func16.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
>  .../bpf/progs/test_global_func_args.c         |  91 ++++++++++++
>  11 files changed, 449 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func14.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func15.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func16.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_args.c
>

[...]
