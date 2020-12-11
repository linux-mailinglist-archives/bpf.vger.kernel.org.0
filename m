Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1B2D701C
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 07:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390446AbgLKGUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 01:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392014AbgLKGUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 01:20:05 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C286C0613CF
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 22:19:25 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id w135so7054638ybg.13
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 22:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJAI8jV2OQsfPb+cWbFF3iduwrPTmIpzTKdbWUpFx/8=;
        b=BJNvgH58cfuZlOz8jMFC+YpD3utjtMXAk1DNe6+Hrkuu9vEnsFvQN7oPEcJBPYPtFC
         VF0Gmy1B8HH41Jf9YXE2EQcOqZ0ejXRwhCJWXGu/o5pFdzo0Cj8aqrTSlLSN7/6kF+q6
         1gw4Zkh8glv4hplBND9DOWfffbmST8qYLaKd9esqNMOjNvX8kDYANek0ERke2phnEo8W
         JsX9ZMyuyTwa0Y7KZ0r6DJWYZvtBJBjc/QPw1s3sySS9I3zIjiv8pkQ5t05S70+p0Oui
         mCBBmINt2Uyylzf0SIxkyKXd6kVVRKL+MDT2vmLvolPEhWgapsIZy2+oLujlsKpnsdfh
         7h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJAI8jV2OQsfPb+cWbFF3iduwrPTmIpzTKdbWUpFx/8=;
        b=hJWA7JyNzP6zzg+LmR4FXumgNLhIayWTl0Mvc6cbq6haD6oTzbif9dGJ66dFZir4zI
         fT9acGQOsRBSbjV1DVc30SebAwbyl2e5u/GI49S7eVQlj5vxA58KJxwwKfanLJkbLw+C
         tAoFONP4EYJuZmX/dPwzqDh+mh48SYoLFROYFJ374cGiKPnKjeS8u4an7zOzmSTS4fku
         tXnNNHaUHUmMGf/LTNuPXx1SnfkywY7XQySzIqeZDbuHzJL3+9WQR7lnfXvTbmUxE8IH
         TakDT2wkZ75zZK4WMKynHAi+2LCN+rhDi3OpgW/wUjp9R0agaYTdqEFaokTk0EFgAqrV
         xyXw==
X-Gm-Message-State: AOAM531qoiHzwljxBcn0WWHb/tWeK4Yuhx9E0ZSu9CG1GH4DxFun5PFD
        Mz/SbKLIBXwzHENLvBmNl39aom8kV1rdWkkk4cW4HpPa+tI=
X-Google-Smtp-Source: ABdhPJzdI9vpaiXVkKAJ5bjfaXp4YK3B9hugoU1Ckk/vyK8zDuZrV9V6V8fERX9JicRMtECVZdrELsR3ABWkD8GL+ic=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr16850786ybj.347.1607667564489;
 Thu, 10 Dec 2020 22:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20201211010711.3716917-1-kpsingh@kernel.org>
In-Reply-To: <20201211010711.3716917-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Dec 2020 22:19:13 -0800
Message-ID: <CAEf4BzZrw3CCUcV7gpY97SEGW6bNgHYYt-KNaqNm6e4eirYaWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Silence ima_setup.sh when not
 running in verbose mode.
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 5:07 PM KP Singh <kpsingh@kernel.org> wrote:
>
> Currently, ima_setup.sh spews outputs from commands like mkfs and dd
> on the terminal without taking into account the verbosity level of
> the test framework. Update test_progs to set the environment variable
> SELFTESTS_VERBOSE=1 when a verbose output is requested. This
> environment variable is then used by ima_setup.sh (and can be used by
> other similar scripts) to obey the verbosity level of the test harness
> without needing to re-implement command line options for verbosity.
>
> In "silent" mode, the script saves the output to a temporary file, the
> contents of which are echoed back to stderr when the script encounters
> an error.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

This looks great, thank you. Applied.

>  tools/testing/selftests/bpf/ima_setup.sh | 24 ++++++++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.c | 10 ++++++++++
>  2 files changed, 34 insertions(+)
>

[...]
