Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595B3342E9C
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 18:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCTRYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCTRXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 13:23:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E16C061574
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:23:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j198so1768865ybj.11
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EIUBvMs9uRTHtoO6SYB3CeIu9JgdY/uMBAgQFRrBXk=;
        b=tNTZH1pjtOV/nJuEYPfwDXbcj8T3a0p+LeVheD06GbLMxrjj0tdC7k8qlNQjsgSXKX
         62FNIoQv4fcgF+lANhVikoGY+aetL6aqyz7OFN2tchsA5J4PTJ8GxeTvI7IAxioAGvt4
         fgqbUqfxE0XzsK7+gvyWyFfyX8BK3Fs8WaaAYBrNurXpePnF90AbvJeWNDjx8FUr9WEJ
         XYs79/sBfIw2ec/idLazE8UGBtubt0YHsBQTbY8hVxmaf/T8CN6SpWfYvDHVwbbVzcXr
         mJW4b685LF/eoG7lH6TdX+8rofRZ0mgircybBdm8D6wJx1jzjQhbXCKTTf2fBgG5IDzz
         UmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EIUBvMs9uRTHtoO6SYB3CeIu9JgdY/uMBAgQFRrBXk=;
        b=tu3X6EOc2OWGsDZmfmIfhCgcQF+rdNs2itgkv2d9jg0HQkP4pVvQGcpxKmYeqazqSo
         n56LjBo5Y4s9JrsePu0pPq/Bc5Pz0BoybtYHvkfG4mvQhCa5ceNY1eGsxwR4FuX1vv7h
         fp/Nll5OO12AiR+kbLheDE05wnQ31yMtP7I/zVCRK72K5Qpiawva3D5xzfK+yftnM5hZ
         Dvc6I6ESiw6r70zX+qRnw0IRl6eyS4SDgqSTqBbP724ZJ1zIHzoMeoYnQkN6IKcxcLn0
         q+nQrRCe48eeN1jaiAdrK0sYCE3w+afKNPfj7U7ubbehpIVFN3NxX0uT75Uhvt3CvQEU
         oFhg==
X-Gm-Message-State: AOAM5317uDpkplZmzq/fa/zxenLxIQyxvBtaM9CxNgnlhgOFxPRlpXjT
        ZmEN3nAo8F+EJ1LFLnSSpVOxe8l6/3u63ui41B0=
X-Google-Smtp-Source: ABdhPJz+Kn4rEHqfwqTeAvuSdY7cz2NhqIPvSTrHM8z+y45Ri7KckrRZ/vfa153TemrOVstjN1q3PSy2y3hvT1NKkcc=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr13434772yba.510.1616261033137;
 Sat, 20 Mar 2021 10:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210320041623.2241647-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210320041623.2241647-1-rafaeldtinoco@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 20 Mar 2021 10:23:42 -0700
Message-ID: <CAEf4Bzah-xFhO-hDzsZZoynsR_BuihAHVQ4jUMPYqyPstdJ9_Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add bpf object kern_version attribute setter
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 19, 2021 at 9:16 PM Rafael David Tinoco
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
>  src/libbpf.c | 15 +++++++++++++++
>  src/libbpf.h |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 0c4a386..7b52cd6 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -8278,6 +8278,21 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
>         return obj->btf ? btf__fd(obj->btf) : -1;
>  }
>
> +int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version)
> +{
> +       __u32 major, minor, patch;
> +
> +       if (!kern_version) {
> +               obj->kern_version = 0;
> +               return 0;
> +       }
> +       if (sscanf(kern_version, "%u.%u.%u", &major, &minor, &patch) != 3)

given SEC("version") expects `int` and bpf_object__kversion() returns
int, I think it's appropriate for bpf_object__set_kversion() to accept
just opaque int as well. Please also check that obj is not loaded and
return error if it is. Thanks!

> +               return -1;
> +       obj->kern_version = KERNEL_VERSION(major, minor, patch);
> +
> +       return 0;
> +}
> +
>  int bpf_object__set_priv(struct bpf_object *obj, void *priv,
>                          bpf_object_clear_priv_t clear_priv)
>  {
> diff --git a/src/libbpf.h b/src/libbpf.h
> index 3c35eb4..3e14ae7 100644
> --- a/src/libbpf.h
> +++ b/src/libbpf.h
> @@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
>
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version);
>
>  struct btf;
>  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
> --
> 2.27.0
>
