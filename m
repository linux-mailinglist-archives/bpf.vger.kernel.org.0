Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC0344CC8
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhCVRHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCVRGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 13:06:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39679C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 10:06:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so7335653ybi.12
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jadgk47b8HeQXSgRuHPD0UTXj6gkLGzfw/gM2zS6mw=;
        b=TMjkxMZqyCooMT3ur2AcP0g0NAIciQKm7zVyyl6wr1CNwfYxxl9kI6jBrXNx4LbBAY
         N7eUEcseUzu4RNq58h5rAO/GAMThvvO3wlMpLw3anCb6FS+Oc2fbrkFsNycPrIPuxoq8
         nGxRJWcYaoJ2HE2PvkZg/p/rm70u1iVTlCavupBwBz7wMhh3waV7mCnInHn7uqn1THPc
         tYRoe6nMN5Yoy/WrKyNIi6cQE6K8+0lZ0BXGryciJtVxhMPwOq6Ed2RVYFSG3wzCRB79
         T1l5zinuglOPgg266ZeXvLv0nTe39KwJK/MTLS0RjYCA9+nEVgaDbqFk1ikOAN0IQ3dD
         jQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jadgk47b8HeQXSgRuHPD0UTXj6gkLGzfw/gM2zS6mw=;
        b=p/AxMadCC+OzTOBfsbwVWGOK0pfMiytVY5pjtApPtN0pWfheyzEuYttlCkU14ezf2+
         6Kt9eOZg8Hhm8YkQPBLKuDSJygRkwVdII5v+h9HY1Y8B8c44rZN/t1aJkr0SZyDhR6tq
         yydB5LFBKiBL/j30iMUKjkUUsN1FXqCwW5zDtX5xQwY34v2v3HTDFuJCPTYNKJgL+N8X
         q5Dyu1r5Flni33bXCIIBv8zYEdWetVdettjPSg3FOj0yQRX9AQwcDhJVNsaF4IP38byz
         0Tz5NU8Ao+of4GFPDnf7Xg/i/GXVPnIkY0h4oKUU+3WZC8PF3Nj+MKOZpWkUV/aFvphD
         lPYw==
X-Gm-Message-State: AOAM532RtjsIhYxnOmaoxoF5NtyAOU7v9uUPgy4i4kRy8cZkaJfExOTq
        nzHrv/Euqp646+XfRMWxRzHP04d+aBtzv/DQAQV93DgQ25w=
X-Google-Smtp-Source: ABdhPJyJqEgwEoeXIM6/Oyp8smi1phbD4wVuwlj/uOyTt75Athd8cw74x4RDwCvuDnFGzizsMRELj3upYmec2139NJs=
X-Received: by 2002:a25:74cb:: with SMTP id p194mr619172ybc.347.1616432801575;
 Mon, 22 Mar 2021 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210320202821.3165030-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210320202821.3165030-1-rafaeldtinoco@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Mar 2021 10:06:30 -0700
Message-ID: <CAEf4BzbUaDbhd4zzfpzpHS007hT+uyQyifdzCdD8_Rwp6ydhfQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add bpf object kern_version attribute setter
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 1:28 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> Unfortunately some distros don't have their kernel version defined
> accurately in <linux/version.h> due to different long term support
> reasons.
>
> It is important to have a way to override the bpf kern_version
> attribute during runtime: some old kernels might still check for
> kern_version attribute during bpf_prog_load().
>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> ---

Ok, getting close, but probably another iteration is needed.

>  src/libbpf.c | 10 ++++++++++
>  src/libbpf.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 2f351d3..3b1c79f 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -8278,6 +8278,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
>         return obj->btf ? btf__fd(obj->btf) : -1;
>  }
>
> +int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
> +{
> +       if (obj->loaded)
> +               return -1;

other functions return -EINVAL in such cases. -1 is actually -EPERM,
which is very misleading, please update


> +
> +       obj->kern_version = kern_version;
> +
> +       return 0;
> +}
> +
>  int bpf_object__set_priv(struct bpf_object *obj, void *priv,
>                          bpf_object_clear_priv_t clear_priv)
>  {
> diff --git a/src/libbpf.h b/src/libbpf.h
> index 3c35eb4..f73ec5b 100644
> --- a/src/libbpf.h
> +++ b/src/libbpf.h
> @@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
>
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);

have you run libbpf's Makefile? It should have complained about
bpf_object__set_kversion symbol mismatches/etc. That means that this
API needs to be listed in libbpf.map file, please add it there (to
latest version, 0.4, and also preserve alphabetical order). Thanks.

>
>  struct btf;
>  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
> --
> 2.27.0
>
