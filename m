Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B15340E97
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 20:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCRTqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhCRTqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 15:46:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA27C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:46:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o83so3839133ybg.1
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2NnDAMdril70A+p9ccUB8pp0KGuaUAQFd+hCpCLTDQ=;
        b=nAPHFn3niprsveMBw2utSHiAn5+eJm1jB0iF/FZhTL2P9wfapE1IP5Gd7p742u82id
         Y5Fp5cSkB3KD/PCtXHWnr7UBaTkdL3fAfHLM/ko77lT5aj0NwUeb6R+2JKTbrA5Mwta9
         GZLB/h+BEy00ZRo39UocnCeC8lWJ0eOaUMcojJhiLnXQ8tzDtHEYZuWW35qJQZTPzwwY
         MNrzBB9ccI0vgz8vj2bJvInhGdASw0KAHIGWcrqRLyormYbh6AudLhkXpbLxoo+OErpY
         xpPV1kzA6GAwD5OvFULhu6JrW2p3IOYo2g1vgZH/9e823E8Bqkb6b5juMfeBAjsiVzqW
         nebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2NnDAMdril70A+p9ccUB8pp0KGuaUAQFd+hCpCLTDQ=;
        b=MIGwiS/0CzpDeY59Cju38MbEN4oaJJ9DFK2IOoVvTy4QZwsLLhghDhoeXY+K8+x5/U
         77+usbWiDnKeWZiuAxw+2oSPLMsmsbNGCSYVPVggN1OGdYGR1sfSB1RD5aWlZrpFwJsu
         v/rEhbtZvfmi6zT9VxqVco//Rv0B+aIp3qkrnawaZ66BjkId81ZUeGb5SgtbBIzTyrKC
         cJ3pqLBi2LOMBNhLfWOh/jl8DYqC70Aooy4gzyGqe2cCWjfo1GVJv1pjIVof27QP4+1R
         zFzl/G+ygxLbTvddtQnTa/Xejy8c+jFgOwz3C/KZD+ltgFDL9RrVdlqzDk1kOVoyDTnw
         Kkvw==
X-Gm-Message-State: AOAM530bBs2UpblRwQYi0mQDCyEhgm5Yfqvr5WWRrFHFVlWRfzpZEyMy
        8unAwHLok5gFRGuy8JR9DOQahJcs9DxRd+0eWf+o+6hadaD+Pw==
X-Google-Smtp-Source: ABdhPJzbniwlpedVTx6R7cONOZF2NfZgEuf3Fice25e1GiU/5CxDs0GUkMUZ/XJIxYEQKTWpUIyeI5A7W22Vx/g0BkY=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr1319430yba.459.1616096772978;
 Thu, 18 Mar 2021 12:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com> <20210318193121.370561-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210318193121.370561-1-rafaeldtinoco@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Mar 2021 12:46:02 -0700
Message-ID: <CAEf4BzZBy+H_ZHTf+fErB2-aMpJr+JSAgCYwvtWbG7dT3=97Cw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: allow bpf object kern_version to be overridden
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 12:31 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> Unfortunately some distros don't have their accurate kernel version
> defined correctly in version.h due to long term support decisions. This
> makes LINUX_VERSION_CODE to be defined as the original upstream version
> in header, while the running in-kernel version is different.
>
> Older kernels might still check kern_version during bpf_prog_load(),
> making it impossible to load a program that could still be portable.
> This patch allows one to override bpf objects kern_version attributes,
> so program can bypass this in-kernel check during load.
>
> Example:
>
> A kernel 4.15.0-129.132, for example, might have 4.15.18 version defined
> in its headers, which is the kernel it is based on, but have a 4.15.0
> version defined within the kernel due to other factors.
>
> $ export LIBBPF_KERN_VERSION=4.15.18
> $ sudo -E ./portablebpf -v
> ...
> libbpf: bpf object: kernel_version enforced by env variable: 266002
> ...
>
> This will also help portable binaries within similar older kernels, as
> long as they have their BTF data converted from DWARVES (for example).
>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> ---

Libbpf currently provides a way to specify custom kernel version using
a special "version" ELF section:

int _version SEC("version") = 123;

But it seems like you would want to set it at runtime, so this
compile-time approach might be problematic. But instead of hijacking
get_kernel_version(), it's better to add a simple setter counterpart
to bpf_object__kversion() that would just override obj->kern_version.

>  src/libbpf.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 4dc09d3..cbc6e61 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -708,13 +708,19 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>
>  static __u32 get_kernel_version(void)
>  {
> -       __u32 major, minor, patch;
>         struct utsname info;
> +       __u32 major, minor, patch, ver;
> +       char *ptr, *e = getenv("LIBBPF_KERN_VERSION");
>
>         uname(&info);
> -       if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
> +       ptr = (e != NULL) ? e : (char *) &info.release;
> +       if (sscanf(ptr, "%u.%u.%u", &major, &minor, &patch) != 3)
>                 return 0;
> -       return KERNEL_VERSION(major, minor, patch);
> +       ver = KERNEL_VERSION(major, minor, patch);
> +       if (e)
> +               pr_debug("bpf object: kernel_version enforced by env variable: %u\n", ver);
> +
> +       return ver;
>  }
>
>  static const struct btf_member *
> --
> 2.17.1
>
