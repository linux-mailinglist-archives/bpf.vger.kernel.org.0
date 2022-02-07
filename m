Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE04ACA1A
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 21:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiBGUIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 15:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiBGUE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 15:04:26 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0114BC0401E1
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 12:04:26 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id i62so18402624ioa.1
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIU/SRERWGf2PIPis1LpCx3u5LzTA94O6pyuTSzxMAg=;
        b=JuYrPDlNBTuppsxpru0ehULobpfhWQFuXy02e6GcP/rHMNeSVaxU6p1Sc2Z7HXx0DP
         76TOSuz/f6dp0cAyneKVa8n2/KIZ35jqEx5Q2ouH0fhfVXXZxOuRwU6DbbntWJs0rz7L
         h0ILVi/Y3plmy0o45hQAQ9zXfE9um6dcl9J++tQgYdAMSco5TaaWQt5Ya3Ri+Vj4ILUw
         0tgsU34mjNsnzi8fmX0bhX7P2BBSI+gl21g69Sz3fmCwGouylntZsJxJQcni+mZJX5Fs
         wRMfYDWX1x2bv0N/rQGMoaDJStnMhvrJ4PsAK0SEve+ZzbYRyV552dssxXIlHebe9SgN
         agGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIU/SRERWGf2PIPis1LpCx3u5LzTA94O6pyuTSzxMAg=;
        b=dc10cuXbOAD1V4ab8BTyPxxQZ9rMlfOb8/s9NpwzxyWLa2f+tD4Gy0BiFlomRSP4sx
         /GW6pxez4ZbXF/uHPqaJBgAcAohW3+hsmbL0lKAQHC50Ou3Cggi6b8nlvliCpErr3pZQ
         a5n0pWZFENBlpw6iU1525HUN3VKH6/y+vJxYyu7CecqhZmryk2ZzI4Eej8Sxc3BAe3AN
         kAmCW6oJ053HzRSw4gYukMtTaHmcYe73TA6ATaGIJ/8rOXwizH8KAH2GJ5mYC836lu80
         Qu7iO8UoUfd7ik92JsedODxhuuR8HOjnX6ahdBuZaLn0YKSp7fRI+065M+bbELs31uOw
         N/Lg==
X-Gm-Message-State: AOAM531NYgqVhSHrFZc+XDFWVOEHLs2AKuN6daOZKgXuycsseHDrGvI2
        JNR3uTBf9RKAJ609ngYgerI2K3SmJFijATjCkprbV6o8hME=
X-Google-Smtp-Source: ABdhPJzUUc7106UgW2kYPXtfRWK/OaEP8nNMIXVV8mRSz5eYcY3D3poH7eQOCNu6zPFZBodGGbnyqt9n67uNCx9OluE=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr650128jaj.234.1644264265409;
 Mon, 07 Feb 2022 12:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com> <20220204231710.25139-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20220204231710.25139-3-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 12:04:14 -0800
Message-ID: <CAEf4BzZQs=QU2=Qz55TYiiWbhw0ne=S8iTBAV3U8Ayr7grG4Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 3:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Prepare light skeleton to be used in the kernel module and in the user space.
> The look and feel of lskel.h is mostly the same with the difference that for
> user space the skel->rodata is the same pointer before and after skel_load
> operation, while in the kernel the skel->rodata after skel_open and the
> skel->rodata after skel_load are different pointers.
> Typical usage of skeleton remains the same for kernel and user space:
> skel = my_bpf__open();
> skel->rodata->my_global_var = init_val;
> err = my_bpf__load(skel);
> err = my_bpf__attach(skel);
> // access skel->rodata->my_global_var;
> // access skel->bss->another_var;
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 168 +++++++++++++++++++++++++++++++---
>  1 file changed, 153 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index dcd3336512d4..4d99ef8cbbba 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -3,9 +3,19 @@
>  #ifndef __SKEL_INTERNAL_H
>  #define __SKEL_INTERNAL_H
>
> +#ifdef __KERNEL__
> +#include <linux/fdtable.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/slab.h>
> +#include <linux/bpf.h>
> +#else
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
> +#include <stdlib.h>
> +#include "bpf.h"
> +#endif
>
>  #ifndef __NR_bpf
>  # if defined(__mips__) && defined(_ABIO32)
> @@ -25,16 +35,12 @@
>   * requested during loader program generation.
>   */
>  struct bpf_map_desc {
> -       union {
> -               /* input for the loader prog */
> -               struct {
> -                       __aligned_u64 initial_value;
> -                       __u32 max_entries;
> -               };
> +       struct {

Is this anonymous struct still needed?

>                 /* output of the loader prog */
> -               struct {
> -                       int map_fd;
> -               };
> +               int map_fd;
> +               /* input for the loader prog */
> +               __u32 max_entries;
> +               __aligned_u64 initial_value;
>         };
>  };
>  struct bpf_prog_desc {
> @@ -57,11 +63,135 @@ struct bpf_load_and_run_opts {
>         const char *errstr;
>  };
>
> +long bpf_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
> +
>  static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> +#ifdef __KERNEL__
> +       return bpf_sys_bpf(cmd, attr, size);
> +#else
>         return syscall(__NR_bpf, cmd, attr, size);
> +#endif
> +}
> +
> +#ifdef __KERNEL__
> +static inline int close(int fd)
> +{
> +       return close_fd(fd);
> +}
> +static inline void *skel_alloc(size_t size)
> +{
> +       return kcalloc(1, size, GFP_KERNEL);
> +}
> +static inline void skel_free(const void *p)
> +{
> +       kfree(p);
> +}

any reason to skim on empty lines between functions? The rest of this
file (and libbpf code in general) feels very different in terms of
spacing.

> +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +{
> +       if (addr && addr != ~0ULL)
> +               vm_munmap(addr, sz);
> +       if (addr != ~0ULL)
> +               kvfree(p);

minor nit: a small comment explaining that we set addr to ~0ULL on
error (but we still call skel_free_map_data) would help a bit here

> +}
> +/* skel->bss/rodata maps are populated in three steps.
> + *
> + * For kernel use:
> + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> + * skel_prep_init_value() allocates a region in user space process and copies
> + * potentially modified initial map value into it.
> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.

I'm missing something here. If a light skeleton is used from a kernel
module, then this initialization data is also pointing to kernel
module memory, no? So why the copy_from_user() then?

Also this vm_mmap() and vm_munmap(), is it necessary for in-kernel
skeleton itself, or it's required so that if some user-space process
would fetch that BPF map by ID and tried to mmap() its content it
would be possible? Otherwise it's not clear, as kernel module can
access BPF array's value pointer directly anyways, so why the mmaping?


> + * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map.
> + *
> + * For user space:
> + * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
> + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> + * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
> + * skel->rodata address.
> + */
> +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +{
> +       void *addr;
> +
> +       addr = kvmalloc(val_sz, GFP_KERNEL);
> +       if (!addr)
> +               return NULL;
> +       memcpy(addr, val, val_sz);
> +       return addr;
> +}

[...]+
