Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E817860C
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCW6g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:58:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42413 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCW6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:58:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so4211491qtt.9;
        Tue, 03 Mar 2020 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVFYEvw2qmu2jM88Am2H9EOrofn0f8G79RS7/47Djvw=;
        b=p35GXZsro4kgDGA4OL3xpE8wVBACG2zcivDJEEmOjk4iBGk0GcUCCKvnQECPEV8cvA
         VByffr11Tv27u/bWfF3IW/f+SZzmahnrKflrXv6s3gSv6bM/q/yTFPBEJWo+BiUdNPId
         09Sp8bH9KmPMrySdX4sVtcLAvUo32k6E4dY9SDL/e5Et0088Fspfa/H4Wu5963I9Ab1N
         7c1OKGIbNTfryC2vBxUxvF09ZhggSRchL9yeAfqS0EQMzQidy1hEH+C8SmJmBtJlJydy
         Rpm3/y5FujPuq8l25YwTn5BwW/Y/YD5GhXBqxMzNHGhSHDVGnK+zmM/Ajs4Bpc2M+jNs
         l0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVFYEvw2qmu2jM88Am2H9EOrofn0f8G79RS7/47Djvw=;
        b=eQqN6R6m0jD2DG6D2tVmGcAAkGMHkXyi2zMjqdDTdf6Es1GPByRV8O/gl+gP+c2fop
         Tz2JNxhyG8qqZz2vfC3omLCBs6jejl4qgAjoEsBKoSq+yZBocQfw1/aVy9/62Lps5lWa
         PVahghMoXXGk9n+jVXqOWrzE2xZ7+wOlxjJk4jXnyFWqFoZotuo73FjRPyLb47krSU8n
         +FbmXWEhKOxOoXGuZCq3VJeZLp98mbuWqvCSFeoXWtk8SKWympTKwi2UDbqzUMFv5TOj
         SfK4ruN/DCuzaZlcMt7uPk7FIdg5eBYdFu5NsI9AZjuzyuV19QgpoRnqBvN9VyU/l7Lf
         1X5g==
X-Gm-Message-State: ANhLgQ12MEWgwd0ZzqUnfouionPmXdf6O9kdUVb/8Htl9ZUlZVrxQbbr
        /9m2/cM905kXo3aJkg1jZ0EmohJwBv4THfoqRzE=
X-Google-Smtp-Source: ADFU+vuF4HMYC47tdlKnc/agFPce4Cq89AQ2pCmsmIDRIJJ/rkh058pR71cMcDAh4FHXqaXaHG+fJUXlZOCeYzwaoVc=
X-Received: by 2002:ac8:4581:: with SMTP id l1mr6512031qtn.59.1583276315171;
 Tue, 03 Mar 2020 14:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-8-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-8-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:58:20 -0800
Message-ID: <CAEf4Bzb7Bg2FSsc3Ai6VqHNbcFdxAcFCiZQXV+vTjEmwCRevCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: Add selftests for BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Test for two scenarios:
>
>   * When the fmod_ret program returns 0, the original function should
>     be called along with fentry and fexit programs.
>   * When the fmod_ret program returns a non-zero value, the original
>     function should not be called, no side effect should be observed and
>     fentry and fexit programs should be called.
>
> The result from the kernel function call and whether a side-effect is
> observed is returned via the retval attr of the BPF_PROG_TEST_RUN (bpf)
> syscall.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

minor nits only

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  net/bpf/test_run.c                            | 23 ++++++-
>  .../selftests/bpf/prog_tests/modify_return.c  | 65 +++++++++++++++++++
>  .../selftests/bpf/progs/modify_return.c       | 49 ++++++++++++++
>  3 files changed, 135 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
>  create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c
>

[...]

>
> -       return 0;
> +       retval = (u32)side_effect << 16 | ret;

uhm, I didn't look up operator priority table, but I'd rather have ()
around bit shift operation :)

> +       if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
> +               goto out;
>
> +       return 0;
>  out:
>         trace_bpf_test_finish(&err);
>         return err;
> diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
> new file mode 100644
> index 000000000000..beab9a37f35c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include "modify_return.skel.h"
> +
> +#define LOWER(x) (x & 0xffff)
> +#define UPPER(x) (x >> 16)

pedantic nit: (x) instead of just x

> +
> +

[...]
