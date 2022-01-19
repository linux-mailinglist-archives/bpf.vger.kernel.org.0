Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DD493405
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 05:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiASEWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 23:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiASEWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 23:22:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE695C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 20:22:05 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o9so1344335iob.3
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 20:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8s8yYBNkcErXCb9jBXHfoScwiHXO7Tqi0fvoEIi0s8=;
        b=ewsFBsBjUo5kHX+jFaRvX9QZxfFj5Um1hnvUX2hKAMdUA273Y16oNwaNG+2r0+JB7F
         qM9K/FwJ02vtH376PrfgzWRHXE4uQpY0KhqcPu0uhKctdBlP1Hl5VFiFGIkrWSQnqs9c
         Hdz3QBERNpMKohkLCREcyZfhlbwtr3BH/zsv2gXmpiglEPAu9W308RQ5L6T7JidpFOAm
         Gg9K7bWLu3O7cnariqNRKI5+mdSaElSKPJAUuHkX5wAON794KMxn5lUr/J7vn5ScXbhO
         UnlhqrcYn1TA9V003U/AYw4n/bNmt1IaNhsx7tkagqJZobUrrTTVx+0OPMlGaOcePcc4
         0wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8s8yYBNkcErXCb9jBXHfoScwiHXO7Tqi0fvoEIi0s8=;
        b=IVb0Fq/StiEzMMOLOg7oZqjSoV4mXuYET+ExynS5j1XenqLmx/zrFOFfTTJY+U1jWw
         Xof9fXKdbkDT+iUtiq+JoziqE6FBDGSVZ03ghHX+gzLnUOgDFbtYoz6AtR8dnTBTxaqv
         +dHczKohztL7whD4f3esee1MZde30n8D1M/0oq8OKHwcO4H5PgHtQbyCu0TGrYm1w7oO
         vn1rfcC1AAGpM9X5VAHxmQ4ooyx+RT8C/rjJH3hUU1azr0pSPrMkiHHpm6y1+nsOn5zU
         WJo5mINVJm1E2hlGDG1Z3xoa60xQAXldQ7e+8OKsrpJaLEZKIAhFx2UnSc/YNpk1yR3t
         Wx2Q==
X-Gm-Message-State: AOAM530DFbGagj3jtVAmw5HPPA6ehIvQiLVj9WSRmoAJI459Jeq/ODTh
        RAAFnYnOjHb747nXpXfGDWsrp9SqeW/B5G6DeG8XPp4u
X-Google-Smtp-Source: ABdhPJxo4FMiONqA1t3scMqG3FwBf2ec662kSh9K2VqzKkA4unyFaKh6dJ5a0cRmuj5/3wyT+nuNT0RGVmvV/BVBNbM=
X-Received: by 2002:a02:bb8d:: with SMTP id g13mr13555852jan.103.1642566124321;
 Tue, 18 Jan 2022 20:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20220118210206.4166763-1-ramasha@fb.com>
In-Reply-To: <20220118210206.4166763-1-ramasha@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Jan 2022 20:21:53 -0800
Message-ID: <CAEf4BzZRLCFhuNQbU5uvGwM0zp2Tx=0AXhJrpagi3KN8hqiN5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: adding support for BTF program names
To:     Raman Shukhau <ramasha@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 1:02 PM Raman Shukhau <ramasha@fb.com> wrote:
>
> `bpftool prog list` and other bpftool subcommands that show
> BPF program names currently get them from bpf_prog_info.name.
> That field is limited by 16 (BPF_OBJ_NAME_LEN) chars what leads

typo: limited to? which leads?

> to truncated names since many progs have much longer names.
>
> The idea of this change is to improve all bpftool commands that
> output prog name so that bpftool uses info from BTF to print
> program names if available.
>
> It tries bpf_prog_info.name first and fall back to btf only if
> the name is suspected to be truncated (has 15 chars length).
>
> Right now `bpftool p show id <id>` returns capped prog name
>
> <id>: kprobe  name example_cap_cap  tag 712e...
> ...
>
> With this change it would return
>
> <id>: kprobe  name example_cap_capable  tag 712e...
> ...
>
> Note, other commands that prints prog names (e.g. "bpftool

typo: print

> cgroup tree") are also addressed in this change.
>
> Signed-off-by: Raman Shukhau <ramasha@fb.com>
> ---
>  tools/bpf/bpftool/cgroup.c |  6 ++++--
>  tools/bpf/bpftool/common.c | 34 ++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/main.h   |  2 ++
>  tools/bpf/bpftool/prog.c   | 17 +++++++++--------
>  4 files changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 3571a281c43f..5e098d9772ae 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -73,7 +73,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
>                         jsonw_uint_field(json_wtr, "attach_type", attach_type);
>                 jsonw_string_field(json_wtr, "attach_flags",
>                                    attach_flags_str);
> -               jsonw_string_field(json_wtr, "name", info.name);
> +               jsonw_string_field(json_wtr, "name",
> +                                  get_prog_full_name(&info, prog_fd));
>                 jsonw_end_object(json_wtr);
>         } else {
>                 printf("%s%-8u ", level ? "    " : "", info.id);
> @@ -81,7 +82,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
>                         printf("%-15s", attach_type_name[attach_type]);
>                 else
>                         printf("type %-10u", attach_type);
> -               printf(" %-15s %-15s\n", attach_flags_str, info.name);
> +               printf(" %-15s %-15s\n", attach_flags_str,
> +                      get_prog_full_name(&info, prog_fd));
>         }
>
>         close(prog_fd);
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index fa8eb8134344..b94d0020e4b4 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -24,6 +24,7 @@
>  #include <bpf/bpf.h>
>  #include <bpf/hashmap.h>
>  #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
> +#include <bpf/btf.h>
>
>  #include "main.h"
>
> @@ -304,6 +305,39 @@ const char *get_fd_type_name(enum bpf_obj_type type)
>         return names[type];
>  }
>
> +const char *get_prog_full_name(const struct bpf_prog_info *prog_info,
> +                              int prog_fd)

see below about leaks and corrupted pointer, you need to handle string
returning more carefully. Either alway strdup() and then free in each
caller (which honestly sucks from usability and safety point of view)
or let callers pass buffer and buffer size and make sure you put the
result into that buffer (and truncate, if necessary).

> +{
> +       const struct btf_type *func_type;
> +       const struct bpf_func_info finfo;
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       const struct btf *prog_btf;
> +
> +       if (strlen(prog_info->name) < BPF_OBJ_NAME_LEN - 1)
> +               return prog_info->name;
> +
> +       if (!prog_info->btf_id || prog_info->nr_func_info == 0)
> +               return prog_info->name;
> +
> +       info.nr_func_info = 1;
> +       info.func_info_rec_size = prog_info->func_info_rec_size;

if prog_info->func_info_rec_size is bigger than sizeof(finfo) you'll
let kernel overwrite stack (corrupting info, probably). Should this be
min of sizeof(finfo) and prog_info->func_info_rec_size?

> +       info.func_info = ptr_to_u64(&finfo);
> +
> +       if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len))
> +               return prog_info->name;
> +
> +       prog_btf = btf__load_from_kernel_by_id(info.btf_id);
> +       if (libbpf_get_error(prog_btf))

bpftool is using libbpf 1.0 strict mode, so prog_btf will be NULL on
error, so just check for NULL instead of libbpf_get_error().

> +               return prog_info->name;
> +
> +       func_type = btf__type_by_id(prog_btf, finfo.type_id);
> +       if (!func_type || !btf_is_func(func_type))
> +               return prog_info->name;

leaking prog_btf here

> +
> +       return btf__name_by_offset(prog_btf, func_type->name_off);

and here. Also, here you are returning a pointer to a string inside
that prog_btf, so once you fix up the leak you'll be returning invalid
pointer.

> +}
> +
>  int get_fd_type(int fd)
>  {
>         char path[PATH_MAX];

[...]
