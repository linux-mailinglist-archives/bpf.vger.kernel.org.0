Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2711C6D0
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 09:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfLLIIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 03:08:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46302 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLLIIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 03:08:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id 38so1496231qtb.13
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJa6R6bLNvGylVw70cAGG7sB0GjXfOC2Z8O74knVzjw=;
        b=Dtbb4RG0WsOBJF+0YVy0sYY0pvd6BTftmTac0GhA5iQZa8xO2gKTKOUJhdpotc1bPS
         bcTiWofIHi8GZgQ34OM0KZhc3If2O9DIMkeoPOwuCrlTjzTTisp+rYv1Ospe3oMQfE4h
         /Oc8x4hB3IOYFtvvujNZoGYtZ8k4VKE9Zp+sF1oWuuFbdfE4lrxMhTOcBSf64j+YvyVO
         1yOoTb1k7xGPWSlf+iNtF5pboi29jhzcMgVl4xZTMBaGjZUWFvf3GXa2q7QGG8rul6Ea
         G+X2FAGen2TefDz10Yl9rqR7dgJRK5rTgxh/eG47vkNPqIlLAyIkVlR7CBK2EtXwOUYD
         vFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJa6R6bLNvGylVw70cAGG7sB0GjXfOC2Z8O74knVzjw=;
        b=ikIFE5v3Y85Ss5nT3QwsMgLa9TQpvlcC9ty3npAxjJMyn84qWGhYQs21tA0SRHRQpW
         2z65NuPiqp/ja0YGa6GNA9LeXhSRMpPkBNGdOy1T5R0aIVQ6riI3ok7MEVAg5W9hmFAe
         PW98uQ7Mslt/pi1M5D78o/i48xhrZ+G+o5EE+iwHx0ShLIx86YZqQKofNgdNo6F6+NZd
         zav9hiR4jHUaS/rsYCXfzOBXgzebcXLnizwoojRkrMoPLubc0r/RLudDGKm+R1cx/JI9
         atsg3XgyT8YQWlhpit3Amp7Kvwv+k4NayV3JTk+oHRVpjZ4kzGLrbO3NKIYj09anREcY
         5Apw==
X-Gm-Message-State: APjAAAXySkoJqrH9gWOwL1M8+o9twe4fsCNmMUEF+WdPcrlZ+/Qdxp9V
        kexXS9PJHojgHlq3Zt6FZgLTyMXZJIW4Wu8V9PM=
X-Google-Smtp-Source: APXvYqw13BqFy1mdSdNdiZXWIzK3YYfesdv3c249Xve2NFboLyUy/y5uoTliHmuOY8XC71kB8pR94twHKqmqEFq7dhs=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr6388830qtj.117.1576138118269;
 Thu, 12 Dec 2019 00:08:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576031228.git.rdna@fb.com> <ceaea4e9eacdd0f75840f6c2684967342a6af164.1576031228.git.rdna@fb.com>
In-Reply-To: <ceaea4e9eacdd0f75840f6c2684967342a6af164.1576031228.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Dec 2019 00:08:27 -0800
Message-ID: <CAEf4BzY0J=RLVdGfVx-WxJc0Zqgx9YMovQmaGcFxmT6-HM0JsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] libbpf: Introduce bpf_prog_attach_xattr
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 6:35 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Introduce a new bpf_prog_attach_xattr function that accepts an
> extendable structure and supports passing a new attribute to
> BPF_PROG_ATTACH command: replace_prog_fd that is fd of previously
> attached cgroup-bpf program to replace if recently introduced
> BPF_F_REPLACE flag is used.
>
> The new function is named to be consistent with other xattr-functions
> (bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).
>
> NOTE: DECLARE_LIBBPF_OPTS macro is not used here because it's available
> in libbpf.h, and unavailable in bpf.h. Please let me know if the macro
> should be shared in a common place and used here instead of declaring
> struct bpf_prog_attach_attr directly.
>

I think doing opts is a better way to go forward. With current
approach, next time we need another extra field, we'd need to add yet
another function and/or symbol version existing one. BTW, with
xxx_opts approach, we tried to keep mandatory arguments that are going
to be always specified as first few arguments of a function, and other
stuff that's optional (e.g., flags or replace_prog_fd seem to be good
candidates), would go under opts. This differs from xattr way, which
is why I'm pointing this out.

> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/lib/bpf/bpf.c      | 22 ++++++++++++++++++----
>  tools/lib/bpf/bpf.h      | 10 ++++++++++
>  tools/lib/bpf/libbpf.map |  5 +++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 98596e15390f..5a2830fac227 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -466,14 +466,28 @@ int bpf_obj_get(const char *pathname)
>
>  int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>                     unsigned int flags)
> +{
> +       struct bpf_prog_attach_attr attach_attr;
> +
> +       memset(&attach_attr, 0, sizeof(attach_attr));
> +       attach_attr.target_fd   = target_fd;
> +       attach_attr.prog_fd     = prog_fd;
> +       attach_attr.type        = type;
> +       attach_attr.flags       = flags;
> +
> +       return bpf_prog_attach_xattr(&attach_attr);
> +}
> +
> +int bpf_prog_attach_xattr(const struct bpf_prog_attach_attr *attach_attr)
>  {
>         union bpf_attr attr;
>
>         memset(&attr, 0, sizeof(attr));
> -       attr.target_fd     = target_fd;
> -       attr.attach_bpf_fd = prog_fd;
> -       attr.attach_type   = type;
> -       attr.attach_flags  = flags;
> +       attr.target_fd     = attach_attr->target_fd;
> +       attr.attach_bpf_fd = attach_attr->prog_fd;
> +       attr.attach_type   = attach_attr->type;
> +       attr.attach_flags  = attach_attr->flags;
> +       attr.replace_bpf_fd = attach_attr->replace_prog_fd;
>
>         return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
>  }
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 3c791fa8e68e..4b7269d3bae7 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -128,8 +128,18 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
>  LIBBPF_API int bpf_map_freeze(int fd);
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
> +
> +struct bpf_prog_attach_attr {
> +       int target_fd;
> +       int prog_fd;
> +       enum bpf_attach_type type;
> +       unsigned int flags;
> +       int replace_prog_fd;
> +};
> +
>  LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
>                                enum bpf_attach_type type, unsigned int flags);
> +LIBBPF_API int bpf_prog_attach_xattr(const struct bpf_prog_attach_attr *attr);
>  LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
>  LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
>                                 enum bpf_attach_type type);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8ddc2c40e482..42b065454031 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -208,3 +208,8 @@ LIBBPF_0.0.6 {
>                 btf__find_by_name_kind;
>                 libbpf_find_vmlinux_btf_id;
>  } LIBBPF_0.0.5;
> +
> +LIBBPF_0.0.7 {
> +       global:
> +               bpf_prog_attach_xattr;
> +} LIBBPF_0.0.6;
> --
> 2.17.1
>
