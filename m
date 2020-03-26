Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E8194765
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgCZTYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 15:24:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36240 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 15:24:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so6498599qtb.3;
        Thu, 26 Mar 2020 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEhcUh84bEc/ZJo24v7isk+pCzKy0P8TtrN2Mpn38Rk=;
        b=U2qxRrFnbEHa2D9PLecSl88ns17wfHcnQxs4UZAG/TJThEFPKfAFBYutyoISMOgNu4
         LuF6aIa3gyACxiKe5JgeccNh+IF7VgjP8jvLBS3USw/7qJNYvTyfUEVV1QMdbrsy5xAp
         G9RuyqJBF1pemXZhkOwJ0I60G8trXLpk60YJQSz1K+crOf/YvDZqhNQDdDlmsUy76LK5
         tGDs/xrnm0dYAVFU8gdOFLKArv1jWWhTKSWHKCcLfVBAq0cKcYygzu5+XzaNgCwjqDqW
         x5U+amugAIUufvuZ219lDV1SG1g29pvI661bPyNuIyfTUNN723VmYA2e4PO5LqcJ4a7a
         xikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEhcUh84bEc/ZJo24v7isk+pCzKy0P8TtrN2Mpn38Rk=;
        b=s6EcxWbkRdg+iKVFbif/MoN+t6rnDjLToakkUmMhiy+JkjXgUl75U7w+tfxEW7iwkl
         m2NU+Uz/ynWC1jvGhGbNDgw8Fmi5GfRxtYNpbs55S5ngxU9WTWwR5ABx7WGzbi4LA9vo
         EIb+6J9qrB6ryRwr3G4ljVSRxD4yIu7vMHN+KCidRHx29E6c2/c1MHRgaEwCnjFes55c
         j5lhDjHGUct67AleIi54xJ2AkHyXb/tJKNSqQjRVvGC2KH+7+4Df+11ZXGZzFdTp7uv7
         AR/5kFwEepdL1OHMBDQ8mW2xNSSuvDqJNlhwBgFgTMHNdmI5+5F32/exlYgYT92534nL
         QVdQ==
X-Gm-Message-State: ANhLgQ0RBIDGZO35EmthRX0kIZ0dypTVpAWVFQl+L/iCc0TvMQL3aCUY
        EcxzSN4CDevR9I/6nrZ4usziUvQtEK8Mmw+aYYE=
X-Google-Smtp-Source: ADFU+vuERR7TjbqcQKMpfu+Nv4ITtl5vdxV4bU6tZC4S+KNkO2aANpBuxPbk4P97fN3IWVyovMbhtdXBju4zMz751bo=
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr9954834qtv.59.1585250671361;
 Thu, 26 Mar 2020 12:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-8-kpsingh@chromium.org>
In-Reply-To: <20200326142823.26277-8-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Mar 2020 12:24:20 -0700
Message-ID: <CAEf4BzZRe_kFR4yzhPFGgauvYLKvre1reuGp=5=jq_nvQGAayw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 26, 2020 at 7:30 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Load/attach a BPF program that hooks to file_mprotect (int)
>   and bprm_committed_creds (void).
> * Perform an action that triggers the hook.
> * Verify if the audit event was received using the shared global
>   variables for the process executed.
> * Verify if the mprotect returns a -EPERM.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---

Please fix endlines below. With that:

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/config            |  2 +
>  .../selftests/bpf/prog_tests/test_lsm.c       | 86 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm.c
>

[...]

> +void test_test_lsm(void)
> +{
> +       struct lsm *skel = NULL;
> +       int err, duration = 0;
> +
> +       skel = lsm__open_and_load();
> +       if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> +               goto close_prog;
> +
> +       err = lsm__attach(skel);
> +       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> +               goto close_prog;
> +
> +       err = exec_cmd(&skel->bss->monitored_pid);
> +       if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> +               goto close_prog;
> +
> +       CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d",

\n is missing

> +             skel->bss->bprm_count);
> +
> +       skel->bss->monitored_pid = getpid();
> +
> +       err = heap_mprotect();
> +       if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> +                 errno))
> +               goto close_prog;
> +
> +       CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
> +             "mprotect_count = %d", skel->bss->mprotect_count);

\n is missing

> +
> +close_prog:
> +       lsm__destroy(skel);
> +}

[...]
