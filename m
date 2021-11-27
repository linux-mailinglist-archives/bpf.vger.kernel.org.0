Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA174601B2
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhK0Vd5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Nov 2021 16:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbhK0Vb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Nov 2021 16:31:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B57C061574
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 13:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9D860F20
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 21:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E6AC53FCB
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638048521;
        bh=oNjNiBM7jPAXXMoGY48ZvKh4t5/WAb36VpbM1Fl4/Kc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=azcpqD5vSPU3LxgaG02gJft2SmHCegF99zJxo+GdeYYdjA6wQQc6zHEA8xg3fsCIt
         FzTzpr290EZvnKpWPzHqgSlgfBOj/vDt0/LM+uFminoup5fXCX+cEkqh+rDxWn1ABZ
         Ylb9aUzoViq1PpeSEjoio3OjSxcPWB6utXln86QccTukbL8iAqaf+pw9OmkW3lrmhJ
         uxSEhx5uCB3jmP71ajAeKKK0bCzh1jNsoXH9u86Z9Gg/y3LS19p/ecmDWpanrUqGwp
         z8dKXC6pbwKG2uF6Eal4us3cmGksDH5HwK0vm/i3flVFsxboiUH5wlsYEh/dN1wOnu
         d5O4VRVv0LgVg==
Received: by mail-yb1-f175.google.com with SMTP id f186so29986280ybg.2
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 13:28:41 -0800 (PST)
X-Gm-Message-State: AOAM532i0FSMJGg+Sug+WWtza8+iFtC+o+DzZJE07yFebyeWMLElI5yq
        S7pubRyuulyy6vP7VFICloUMaA5672Jje90pywI=
X-Google-Smtp-Source: ABdhPJys0GvFP9Kt1sjU3vi5F4yJXWlbEGL/h6Rxi1hGE+ah9qIOjuf4x/PNN9zOO92McqG/7fZ2OOwJ+GUJBKGbTR8=
X-Received: by 2002:a25:660d:: with SMTP id a13mr26172183ybc.460.1638048520282;
 Sat, 27 Nov 2021 13:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20211127210200.1104120-1-grantseltzer@gmail.com>
In-Reply-To: <20211127210200.1104120-1-grantseltzer@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 27 Nov 2021 13:28:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6+LiLZf0SsGbOT+2BNHGB28TZazoEELwb6anbo5_mLPQ@mail.gmail.com>
Message-ID: <CAPhsuW6+LiLZf0SsGbOT+2BNHGB28TZazoEELwb6anbo5_mLPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments in libb.h
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 27, 2021 at 1:04 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above functions in libbpf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> These doc comments are for:
>
> - bpf_object__open_file()
> - bpf_object__open_mem()
> - bpf_program__attach_uprobe()
> - bpf_program__attach_uprobe_opts()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>

s/libb.h/libbpf.h/ in subject

> ---
>  tools/lib/bpf/libbpf.h | 45 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 4ec69f224342..acfb207e71d1 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -108,8 +108,26 @@ struct bpf_object_open_opts {
>  #define bpf_object_open_opts__last_field btf_custom_path
>
>  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
> +
> +/**
> + * @brief **bpf_object__open_file()** creates a bpf_object by opening
> + * the BPF object file pointed to by the passed path and loading it
> + * into memory.
> + * @param path BPF object file relative or absolute path
> + * @param opts options for how to load the bpf object
> + * @return pointer to the new bpf_object

Please document return value on errors, i.e. libbpf_err_ptr(err)
instead of NULL. Same for all functions here.

> + */
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
> +
> +/**
> + * @brief **bpf_object__open_mem()** creates a bpf_object by reading
> + * the BPF objects raw bytes from an in memory buffer.
> + * @param obj_buf pointer to the buffer containing bpf object bytes
> + * @param obj_buf_sz number of bytes in the buffer
> + * @param opts options for how to load the bpf object
> + * @return pointer to the new bpf_object
> + */
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
>                      const struct bpf_object_open_opts *opts);
> @@ -344,10 +362,37 @@ struct bpf_uprobe_opts {
>  };
>  #define bpf_uprobe_opts__last_field retprobe
>
> +/**
> + * @brief **bpf_program__attach_uprobe** attaches a BPF program
> + * to the userspace function which is found by binary path and
> + * offset. You can optionally specify a particular proccess to attach
s/proccess/process/

> + * to. You can also optionally attach the program to the function
> + * exit instead of entry.
> + *
> + * @param prog BPF program to attach
> + * @param retprobe Attach to function exit
> + * @param pid Process ID to attach the uprobe to, -1 for all processes
> + * @param binary_path Path to binary that contains the function symbol
> + * @param func_offset Offset within the binary of the function symbol
> + * @return Reference to the newly created BPF link
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
>                            pid_t pid, const char *binary_path,
>                            size_t func_offset);
> +
> +/**
> + * @brief **bpf_program__attach_uprobe_opts** is just like
> + * bpf_program__attach_uprobe except with a options struct
> + * for various configurations.
> + *
> + * @param prog BPF program to attach
> + * @param pid Process ID to attach the uprobe to, -1 for all processes
> + * @param binary_path Path to binary that contains the function symbol
> + * @param func_offset Offset within the binary of the function symbol
> + * @param opts Options for altering program attachment

Let's also document details about these options.

> + * @return Reference to the newly created BPF link
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>                                 const char *binary_path, size_t func_offset,
> --
> 2.31.1
>
