Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0322B0CFC
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 19:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLSu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 13:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgKLSu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 13:50:58 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73AC0613D1;
        Thu, 12 Nov 2020 10:50:58 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id i186so6316312ybc.11;
        Thu, 12 Nov 2020 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0S65KT2c+xPJ4n4jr5bcH8ZJLRH/T0z9HPhKC9k6xI=;
        b=ufvAegeDUPkSEKS+F8PBsGkNrIblvHib7l3dzAn8wF0iL/I+H9pFvRD2RHnSfuqk1W
         0JfC8fui10FM1U79fP5pt9UQ594BQx6MEw1MQV9mssLb+e0OZefwnXV1Pr0m+35t+OC8
         3i97A61C2otdX4KkE34teTGOsaT+t8Sy4aVY/01jVgKBhPY7WL7mZuCtjL1pM+MpXHDY
         9XikjLtAJz5QwCdRZtAGNM9TYRAWiP7010Ir0k0dY2Z4sHPxXW8b9+Fr73tQCmmJTVej
         rBam/Ru7a2LwAAcmXpUZwrd5vyY/HRqLjp/uoRLJmZ5hCHXB49QD/Wfx+ewhb37pgZYp
         5rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0S65KT2c+xPJ4n4jr5bcH8ZJLRH/T0z9HPhKC9k6xI=;
        b=ITCYF+JJg21Xi133i2o7GVH2N5YOk7OgqIjxTBEuBYIOu6eqNf1a0d1dqw158lVYYP
         vtr/TFjiY2OyoW98mSJ7qTbBWSW611Pyk53x2+QpHvx287CucfN3Ch9r2jrXMDrqBm4/
         nZCian4BC0CcDkyofRyNns3lwc9j8avfkp3ewoSuX8VgQhzG0wGettXxylw90u9gnqTm
         YMYD3P7pRnypfjALk9Dhlu4THdcvV9M1Z0ALnFiiMsqGiQa8ZJfHWT2vKaBSDAMVAVZX
         GqfpD4NX03TwubzsyHcb0burFBJSVYyMZxhzncqh91I2PSnsRESsqycPjTQuRdH7HssE
         HC1g==
X-Gm-Message-State: AOAM530ZJPFabKt2HXynoNHnQ/rY3ICYwk8Tr0gTZJxOKH6pxcFOXwco
        vQ9nro0+RyXfqblr9gAudjxCTHP60zCCLnR2+us=
X-Google-Smtp-Source: ABdhPJyIJBDYl270dQzivO4zEZLBYFHT7gqgEKVnshufQjGl+cIRPVm447eFI5mrucQ6uoMuEGDp6hCSg6/UWcvs2Fs=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr1323254ybd.27.1605207057473;
 Thu, 12 Nov 2020 10:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20201112171907.373433-1-kpsingh@chromium.org> <20201112171907.373433-2-kpsingh@chromium.org>
In-Reply-To: <20201112171907.373433-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 10:50:46 -0800
Message-ID: <CAEf4Bzb4sxFQQROP+4oqttUuWowBJWoQywYQJ2RbvLm-ej6vQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Expose bpf_d_path helper to sleepable
 LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 9:20 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Sleepable hooks are never called from an NMI/interrupt context, so it is
> safe to use the bpf_d_path helper in LSM programs attaching to these
> hooks.
>
> The helper is not restricted to sleepable programs and merely uses the
> list of sleeable hooks as the initial subset of LSM hooks where it can
> be used.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  kernel/trace/bpf_trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e4515b0f62a8..eab1af02c90d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -16,6 +16,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/error-injection.h>
>  #include <linux/btf_ids.h>
> +#include <linux/bpf_lsm.h>
>
>  #include <uapi/linux/bpf.h>
>  #include <uapi/linux/btf.h>
> @@ -1178,7 +1179,11 @@ BTF_SET_END(btf_allowlist_d_path)
>
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
>  {
> -       return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
> +       if (prog->type == BPF_PROG_TYPE_LSM)
> +               return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> +
> +       return btf_id_set_contains(&btf_allowlist_d_path,
> +                                  prog->aux->attach_btf_id);
>  }
>
>  BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
