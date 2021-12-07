Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8246B169
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 04:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhLGDXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 22:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhLGDXw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 22:23:52 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E14C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 19:20:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so37011613ybe.6
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 19:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jhGmjGwuZl4l4gghOKYYfEj7qWXai05hd7Bhy/kkZk=;
        b=GOks1JM0vQ+PCZKMw3kWpD8B3pUuKuiEbUmg6WWxMQCGRtPZZOs+kDNchp6eoK4Ck5
         y2o3g9GQz2B9PTlSVponhZMnMV/B2U8kB4AzjyYoeW3zugJBiONcNSw6dzTBfix1gDFF
         Ce2SvcYk2ac3HHVk49Z1BdY6eqf7VH4SJ0HL8+A1iFIG6XwqXbOkAKsJssVPIhpB7xeq
         jvIG9Xm2wwKxWsFWJKoSC+Q9oQhPgYHLq0NBz+fCAV/aLxwzp8KPbNaNQUWBPMX+Wz6X
         xi/FTASoqx/sF9AP/CVxajWrzzTc1dMOjSFLldRdt9PBjUfxAUC0MwFQ1B3XdunkR6Y/
         Diiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jhGmjGwuZl4l4gghOKYYfEj7qWXai05hd7Bhy/kkZk=;
        b=CJnfqxJ++ErAEAnNhiDC4jjd/FH3X5bvZwUWGHmdFaxCt04VgyuKVN0QNr5OH7gQQy
         VRSU3doaZZ718KoOJDI4EYEQCunRkwCFNFVF7kbcXbeGlnM6XLqS9fbMEZsrezs12d1Q
         HIy+QgZ4f7wynKzvbH9LdEm+Cjx2Er8vOKcuqQTCFGhwmCSGYDBiOJKfUDa/NHWww2zZ
         OEvn2homFa84WV95lRNMkzqrAO38dEfrgAx0HrNXYyjmksPBomDWgBrpXoGBO/4kYbWM
         WoJYLwQP/Iv9JcMQfY8na4lC79wiTAl1X1GSgiPaVB70LkZULPtmiMPp4LNXdyFetHG6
         xVhg==
X-Gm-Message-State: AOAM5313TosClFAljBJNJEEDOWioK1WjeAYtKJTDOr+9mVVTgijMMTDo
        q5N+TBy9AeH/5SYaPj7Qz5980CRrnUkjgg9Pm2AEZj3AMTo=
X-Google-Smtp-Source: ABdhPJwBYwLyzYJCd1RMnq0Cxmg87zUf2LvLMQ/HeytmL1fA2i3LZQjyhEmowqQPWiHxAtrAJU7TamkAIug5n4+RTqQ=
X-Received: by 2002:a25:54e:: with SMTP id 75mr45728979ybf.393.1638847221748;
 Mon, 06 Dec 2021 19:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20211206203709.332530-1-grantseltzer@gmail.com>
In-Reply-To: <20211206203709.332530-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 19:20:10 -0800
Message-ID: <CAEf4BzZ4FCBDukW=vsJ7Y1eMm3jV-8Y1yVPzqwBn2_YP=3U4rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add doc comments in libbpf.h
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 12:37 PM grantseltzer <grantseltzer@gmail.com> wrote:
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
> ---

Fixed trailing whitespaces, added missing mention of 0 being self for
one of uprobe attach APIs, and applied to bpf-next. Thanks.

>  tools/lib/bpf/libbpf.h | 52 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 4ec69f224342..d2ca6f1d1dc4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -108,8 +108,30 @@ struct bpf_object_open_opts {
>  #define bpf_object_open_opts__last_field btf_custom_path
>
>  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
> +
> +/**
> + * @brief **bpf_object__open_file()** creates a bpf_object by opening
> + * the BPF ELF object file pointed to by the passed path and loading it
> + * into memory.
> + * @param path BPF object file path
> + * @param opts options for how to load the bpf object, this parameter is
> + * option and can be set to NULL
> + * @return pointer to the new bpf_object; or NULL is returned on error,
> + * error code is stored in errno
> + */
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
> +
> +/**
> + * @brief **bpf_object__open_mem()** creates a bpf_object by reading
> + * the BPF objects raw bytes from a memory buffer containing a valid
> + * BPF ELF object file.
> + * @param obj_buf pointer to the buffer containing ELF file bytes
> + * @param obj_buf_sz number of bytes in the buffer
> + * @param opts options for how to load the bpf object
> + * @return pointer to the new bpf_object; or NULL is returned on error,
> + * error code is stored in errno
> + */
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
>                      const struct bpf_object_open_opts *opts);
> @@ -344,10 +366,40 @@ struct bpf_uprobe_opts {
>  };
>  #define bpf_uprobe_opts__last_field retprobe
>
> +/**
> + * @brief **bpf_program__attach_uprobe()** attaches a BPF program
> + * to the userspace function which is found by binary path and
> + * offset. You can optionally specify a particular proccess to attach
> + * to. You can also optionally attach the program to the function
> + * exit instead of entry.
> + *
> + * @param prog BPF program to attach
> + * @param retprobe Attach to function exit
> + * @param pid Process ID to attach the uprobe to, -1 for all processes
> + * @param binary_path Path to binary that contains the function symbol
> + * @param func_offset Offset within the binary of the function symbol
> + * @return Reference to the newly created BPF link; or NULL is returned on error,
> + * error code is stored in errno
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
>                            pid_t pid, const char *binary_path,
>                            size_t func_offset);
> +
> +/**
> + * @brief **bpf_program__attach_uprobe_opts()** is just like
> + * bpf_program__attach_uprobe() except with a options struct
> + * for various configurations.
> + *
> + * @param prog BPF program to attach
> + * @param pid Process ID to attach the uprobe to, 0 for self (own process),
> + * -1 for all processes
> + * @param binary_path Path to binary that contains the function symbol
> + * @param func_offset Offset within the binary of the function symbol
> + * @param opts Options for altering program attachment
> + * @return Reference to the newly created BPF link; or NULL is returned on error,
> + * error code is stored in errno
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>                                 const char *binary_path, size_t func_offset,
> --
> 2.33.1
>
