Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367BD3AD703
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhFSD2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 23:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFSD2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 23:28:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48478C061574
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 20:26:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q64so9535195qke.7
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ljhpLlMGOua94MpV84jSnVrLQRHDCE/9w8rlv1AeRY=;
        b=VEAvpaYW1rQAfrPmrlu3IYooEXCZvPHZWluAKgZPBbTgzSMUH4axgg2CWB0QiohxHr
         Px7eFg3cy/Zh/c07Dy8Y1Sy9X5yXh+r6qHlyTOu2NrPKxtir8ID5Guwg8eaH38E4TrWs
         2pHVhJWVZ93qfqyoye3Gn8qu1E/gO7K30qNxrfmSyWmH4XKJhTpvhKzUzZtLZzYQT2yi
         TFakHVqnm4+vxQ8eXrYsdrq0VDGIbH1Y3ah7+CqCIlCdRfCfeTVjGlPwlFmYOs8bvAzH
         R+JTs3IZBuX1qWPOfg9EVS5NtJFgGgYI+oGfTymaAJYOxmptfsSsp2xbFJAVTa6IZ2pw
         iUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ljhpLlMGOua94MpV84jSnVrLQRHDCE/9w8rlv1AeRY=;
        b=hRTaryzt83d8ibkp+g6Zh4qmiTFqbbnzIv7uEEct57vDfQwAi5f1sMUvCXCi0smOAN
         hrU09N8esdIAPMrVwELoL3be/zaa/T4Zj69eINCawvcX00gHHuK4auWo7AkRGTP7/LBG
         lbvx4lycKHhlsHn9RB0G0PZN7gkQHHGO2DF1TsWdjkb1y5BITnDjPpHnP9tG3ZYwMSgl
         7KZfFahNrgACJuFL9de85VZHlLkbqQ2d/XZ5UhLn8uXT0Z/s5UDammiLniGzrP99p4qj
         +k5PUrxw/R6REoke7H1C8UcyKJL6ovob+H+f12Mhn93MAQTpQzllahhD91wWhhHxrkIW
         e+Fw==
X-Gm-Message-State: AOAM531W9ykRPe9pTa1bZCXHHDPK7R2ymBi3GY2NjLFVHo13hgjeByen
        9HlDyY9kgfDib8BjVAWqRKP+5iX0Jbudw06WesI=
X-Google-Smtp-Source: ABdhPJwLulVYlXKzId9ji8Rqo20owF1i1UFSuVbFLpnaABmJPdK2DFZn4WZCiX2+0eUUWgYE4iNwAv9IODB4/6fjn5Y=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr16442969ybg.459.1624073190337;
 Fri, 18 Jun 2021 20:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYtuJKaOSk6nqkMbb4vwmTAXjSWOZUJ8FnRUf_7LKkO1w@mail.gmail.com>
 <20210618231322.GA27742@165gc.onmicrosoft.com>
In-Reply-To: <20210618231322.GA27742@165gc.onmicrosoft.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Jun 2021 20:26:19 -0700
Message-ID: <CAEf4BzZxHSAn6d7M9O5_HE7p5K-Z2OJ1E9f0YGXfAbdWhsZ1GQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add extra BPF_PROG_TYPE check to bpf_object__probe_loading
To:     jjedwa165 <jonathan.edwards@165gc.onmicrosoft.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 4:13 PM jjedwa165
<jonathan.edwards@165gc.onmicrosoft.com> wrote:
>
> eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ [0]. However
> only the following program types are supported [1]
>
> BPF_PROG_TYPE_KPROBE
> BPF_PROG_TYPE_TRACEPOINT
> BPF_PROG_TYPE_PERF_EVENT
>
> For libbpf this causes an EINVAL return during the bpf_object__probe_loading
> call which only checks to see if programs of type BPF_PROG_TYPE_SOCKET_FILTER
> can load.
>
> The following will try BPF_PROG_TYPE_TRACEPOINT as a fallback attempt before
> erroring out. BPF_PROG_TYPE_KPROBE was not a good candidate because on some
> kernels it requires knowledge of the LINUX_VERSION_CODE.
>
> [0] https://www.redhat.com/en/blog/introduction-ebpf-red-hat-enterprise-linux-7
> [1] https://access.redhat.com/articles/3550581
>
> Signed-off-by: jjedwa165 <jonathan.edwards@165gc.onmicrosoft.com>
> ---

LGTM, but please re-submit with your real first and last name in
Signed-off-by. Also add my ack:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 48c0ade05..1e04ce724 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4000,6 +4000,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
>         attr.license = "GPL";
>
>         ret = bpf_load_program_xattr(&attr, NULL, 0);
> +       if (ret < 0) {
> +               attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
> +               ret = bpf_load_program_xattr(&attr, NULL, 0);
> +       }
>         if (ret < 0) {
>                 ret = errno;
>                 cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> --
> 2.17.1
>
