Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E3512232
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiD0TNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 15:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiD0TNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 15:13:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C96E8E8
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:03:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m6so97182iob.4
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o97tzyhTUNPeOOwGgjpbesMcUj4p8qgLitBHW8NCRa0=;
        b=DyXNm6fxwo+jqSpJ9QDRrhnsS0jUCgSd2u5kZdLnMQDuK9jTwNu/VOBMD2ssh6vjR7
         /rdAvRBv5HPMUVTAZKzDsdRmfrrLRDB+6HBykbqx5kh/U/V3oUhJ8ujLkYUoMBux8cxT
         97Hue3tk+BG5cTAxC3cfvxlcwxVaV15QXYZxRfpGfAQCTrIeEtZYaJOC3Fe+2mW5wEgD
         PmHq30nJZJnqxPoreNTy7vst68GgzorE6ScRXoc0lobOOXuOCa02KeS+7v/XmKGbatuZ
         U6U1jAnja7PuLACi/s7Iaiggm0c6ncc5HvTwDVzfrxfJfwivhU+auOriGYdzvtt04Qw2
         ic/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o97tzyhTUNPeOOwGgjpbesMcUj4p8qgLitBHW8NCRa0=;
        b=RlybL+2WdRILFH/YGlQT7oFpwG79n5hcpeB/MgrsxXAAMMzP4wguWhd7Og6H+ZsHHb
         FJ2Ju1z0j5pH4ukiKNkm4q1fBjefbJReWwvy7EEXijuT+hzvCc2eR2MnMcCPvFJUdLI4
         bJhQ1Lk2j41UkWrHwj7/1GLoCIrkzk4bQpBdZGNYYkTpYsi22T5a2uqnOuHOlSKlqcav
         4/dXP3RHeNlT0KS6Qn+I2r4A57COa97IqfxfMtLw77LOnoaHQ9GrC3UgEkpL+k75NnO8
         N71o3E1VjD2BJVMBFLn9IxE+81hdaYq7DiToxzTGpHFWbvINz74NQU/Lycy+PyDD2FWv
         Ds4Q==
X-Gm-Message-State: AOAM530YM5nS5JRC+6sq69sues9+3kBqqLIJXfdea9dYONu+9vi3lODG
        zo8Rh1bsdJ9DZ+op9PrYEym2Vers2n6cQpKdseQ=
X-Google-Smtp-Source: ABdhPJx6sBpRssMeB54kLQ+WqRNTYTWTWqfiY/uNkXXaoyDNdNvXaN7hYrV30ILwBdRzLGZZeMU81bzPKeMBFdG0KZE=
X-Received: by 2002:a05:6638:3393:b0:32a:93cd:7e48 with SMTP id
 h19-20020a056638339300b0032a93cd7e48mr12796662jav.93.1651086237838; Wed, 27
 Apr 2022 12:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220422182254.13693-1-9erthalion6@gmail.com> <20220422182254.13693-2-9erthalion6@gmail.com>
In-Reply-To: <20220422182254.13693-2-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 12:03:47 -0700
Message-ID: <CAEf4BzZxq3koNMRAXw-o=vdkqqiwfyPhbjgZZ9H+0Dx8UnGo5A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_link iterator
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 11:23 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Implement bpf_link iterator to traverse links via bpf_seq_file
> operations. The changeset is mostly shamelessly copied from
> commit a228a64fc1e4 ("bpf: Add bpf_prog iterator")
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  include/linux/bpf.h    |   1 +
>  kernel/bpf/Makefile    |   2 +-
>  kernel/bpf/link_iter.c | 107 +++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c   |  19 ++++++++
>  4 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/link_iter.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7bf441563ffc..330e88fcc50e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1489,6 +1489,7 @@ void bpf_link_put(struct bpf_link *link);
>  int bpf_link_new_fd(struct bpf_link *link);
>  struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> +struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>
>  int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>  int bpf_obj_get_user(const char __user *pathname, int flags);
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index c1a9be6a4b9f..057ba8e01e70 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>  endif
>  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
> new file mode 100644
> index 000000000000..fde41d09f26b
> --- /dev/null
> +++ b/kernel/bpf/link_iter.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2020 Facebook */

this probably needs a bit of update?

> +#include <linux/bpf.h>
> +#include <linux/fs.h>
> +#include <linux/filter.h>
> +#include <linux/kernel.h>
> +#include <linux/btf_ids.h>
> +
> +struct bpf_iter_seq_link_info {
> +       u32 link_id;
> +};
> +

[...]
