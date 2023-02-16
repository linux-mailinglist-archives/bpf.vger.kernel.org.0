Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3581369A25E
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 00:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBPX2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 18:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBPX2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 18:28:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE3241E4
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:28:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n20so9170815edy.0
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKLgfm/NKh4DLeVNkF1lRdK3aZcl+c+m6tC6qvbS3e4=;
        b=d76F2QYUBcdPt42o/cgO827YRY45QWItAi0luAMvxdEJUvmFsncOc9ySbxZTGCa52Q
         HqmjSLDhCjCQJaBUmecT2LGWiXBbOBrX7TVi19b4cSNcLkKjoXX8ZZkOMkoyLHbUOyO8
         Io/oWOC9nlv642mpBFbkcnY+LdGOax5fs+FYhA9fjMHXeYcc4cAgKP1nN5+Y/BhnmGWM
         FF4dlY40zXxIZoF+aBxAnLkP7rzvv0lM+YjUGUDMeUvF19Wf834E8H2iNqK/IQbbKVbm
         l2W/9hZufvydmu5a+aU4oN502QzVtPXhcvxvQDTV3HjR6q3Kw71cECIBQe4ohyivETIB
         JFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKLgfm/NKh4DLeVNkF1lRdK3aZcl+c+m6tC6qvbS3e4=;
        b=7JhVUFXZrxqiZJUWOJ7dXI3yDgfC9aKDWFy7HliJlurTpuJQ2EAWetYyT8qjAwUsKu
         3zyxyqPwBm4yVjfiapDO3NCoVOEJr02e1jPUniGgaN39YxiU+Pqthx1DI2Ba0vsjevTF
         soXvUOYWoQMHIy07Mcrrm1VD0wEQvyw8tWFij4zLw8MBZBZ9OILhWm0TIrTtmh8pqkOY
         2VTC3mjNiac3EOu9RAomjytOMgDoPrVhmsE8gUS06YBEkDFbyueFdgZ1lHbnekQn7YC8
         sQ7olqn4Ke1UdflLYAAQzLQ2aX6gBJO4v1WYbP6r5zP2cUcq3wLim18iT4fSED3JqQlg
         hNjg==
X-Gm-Message-State: AO0yUKVrG5TJUEqHChFRTxvLvs7iFKxwB4OkpU5NNgxVk+BwgZacIN+X
        EfmNdp7tHaflW66AXFJ2wBwzh9t23MgsImhttAg=
X-Google-Smtp-Source: AK7set9P7f66c5rsfmSOdd6XgbwOk6PN/eJu0xVkGOtUja9IE1zQ7fKHFjZuiSnPdhY4Viwdu0a0SIKKS7RYavM4ZaU=
X-Received: by 2002:a17:906:a197:b0:889:8f1a:a153 with SMTP id
 s23-20020a170906a19700b008898f1aa153mr3560390ejy.15.1676590094303; Thu, 16
 Feb 2023 15:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20230214231221.249277-1-iii@linux.ibm.com> <20230214231221.249277-8-iii@linux.ibm.com>
In-Reply-To: <20230214231221.249277-8-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 15:28:02 -0800
Message-ID: <CAEf4BzZcvuCZpjKwgT_-3WaKuM82CA1Uxg3X-4E63r2o6he+sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/8] libbpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Tue, Feb 14, 2023 at 3:12 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> MSan runs into a few false positives in libbpf. They all come from the
> fact that MSan does not know anything about the bpf syscall,
> particularly, what it writes to.
>
> Add __libbpf_mark_mem_written() function to mark memory modified by the
> bpf syscall, and a few convenience wrappers. Use the abstract name (it
> could be e.g. libbpf_msan_unpoison()), because it can be used for
> Valgrind in the future as well.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf.c             | 161 ++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.c             |   1 +
>  tools/lib/bpf/libbpf.c          |   1 +
>  tools/lib/bpf/libbpf_internal.h |  38 ++++++++
>  4 files changed, 194 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b562019271fe..8440d38c781c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,11 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline void *u64_to_ptr(__u64 val)
> +{
> +       return (void *) (unsigned long) val;
> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> @@ -92,6 +97,8 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
>                 fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
>         } while (fd < 0 && errno == EAGAIN && --attempts > 0);
>
> +       libbpf_mark_mem_written(u64_to_ptr(attr->log_buf), attr->log_size);
> +
>         return fd;
>  }
>
> @@ -395,6 +402,26 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
>         return libbpf_err_errno(ret);
>  }
>
> +/* Tell memory checkers that the given value of the given map is initialized. */
> +static void libbpf_mark_map_value_written(int fd, void *value)

nit: fd -> map_fd

> +{
> +#ifdef HAVE_LIBBPF_MARK_MEM_WRITTEN
> +       struct bpf_map_info info;
> +       __u32 info_len;
> +       size_t size;
> +       int err;
> +
> +       info_len = sizeof(info);

nit: just initialize variable inline?

> +       err = bpf_map_get_info_by_fd(fd, &info, &info_len);
> +       if (!err) {
> +               size = info.value_size;
> +               if (is_percpu_bpf_map_type(info.type))
> +                       size = roundup(size, 8) * libbpf_num_possible_cpus();
> +               libbpf_mark_mem_written(value, size);
> +       }
> +#endif
> +}
> +
>  int bpf_map_lookup_elem(int fd, const void *key, void *value)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, flags);
> @@ -407,6 +434,8 @@ int bpf_map_lookup_elem(int fd, const void *key, void *value)
>         attr.value = ptr_to_u64(value);
>
>         ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
> +       if (!ret)
> +               libbpf_mark_map_value_written(fd, value);
>         return libbpf_err_errno(ret);

ok, so libbpf_err_errno() relies on errno to be correct for last bpf()
syscall, but libbpf_mark_map_value_written() can clobber it. We need
to make libbpf_mark_map_value_written() "transparent" as far as errno
goes. Let's store and restore it internally.

Also, instead of adding all these `if (!ret)`, let's pass ret into
libbpf_mark_map_value_written() and do that check internally?

Basically, let's make all these MSan-related "annotations" as
invisible in the code as possible.


>  }
>
> @@ -423,6 +452,8 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
>         attr.flags = flags;
>
>         ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
> +       if (!ret)
> +               libbpf_mark_map_value_written(fd, value);
>         return libbpf_err_errno(ret);
>  }
>

[...]

>
> +/* Helper macros for telling memory checkers that an array pointed to by
> + * a struct bpf_{btf,link,map,prog}_info member is initialized. Before doing
> + * that, they make sure that kernel has provided the respective member.
> + */
> +
> +/* Handle arrays with a certain element size. */
> +#define __MARK_INFO_ARRAY_WRITTEN(ptr, nr, elem_size) do {                    \
> +       if (info_len >= offsetofend(typeof(*info), ptr) &&                     \
> +           info_len >= offsetofend(typeof(*info), nr) &&                      \
> +           info->ptr)                                                         \
> +               libbpf_mark_mem_written(u64_to_ptr(info->ptr),                 \
> +                                       info->nr * elem_size);                 \
> +} while (0)
> +
> +/* Handle arrays with a certain element type. */
> +#define MARK_INFO_ARRAY_WRITTEN(ptr, nr, type)                                \
> +       __MARK_INFO_ARRAY_WRITTEN(ptr, nr, sizeof(type))
> +
> +/* Handle arrays with element size defined by a struct member. */
> +#define MARK_INFO_REC_ARRAY_WRITTEN(ptr, nr, rec_size) do {                   \
> +       if (info_len >= offsetofend(typeof(*info), rec_size))                  \
> +               __MARK_INFO_ARRAY_WRITTEN(ptr, nr, info->rec_size);            \
> +} while (0)
> +
> +/* Handle null-terminated strings. */
> +#define MARK_INFO_STR_WRITTEN(ptr, nr) do {                                   \
> +       if (info_len >= offsetofend(typeof(*info), ptr) &&                     \
> +           info_len >= offsetofend(typeof(*info), nr) &&                      \
> +           info->ptr)                                                         \
> +               libbpf_mark_mem_written(u64_to_ptr(info->ptr),                 \
> +                                       info->nr + 1);                         \
> +} while (0)
> +
> +/* Helper functions for telling memory checkers that arrays pointed to by
> + * bpf_{btf,link,map,prog}_info members are initialized.
> + */
> +
> +static void mark_prog_info_written(struct bpf_prog_info *info, __u32 info_len)
> +{
> +       MARK_INFO_ARRAY_WRITTEN(map_ids, nr_map_ids, __u32);
> +       MARK_INFO_ARRAY_WRITTEN(jited_ksyms, nr_jited_ksyms, __u64);
> +       MARK_INFO_ARRAY_WRITTEN(jited_func_lens, nr_jited_func_lens, __u32);
> +       MARK_INFO_REC_ARRAY_WRITTEN(func_info, nr_func_info,
> +                                   func_info_rec_size);
> +       MARK_INFO_REC_ARRAY_WRITTEN(line_info, nr_line_info,
> +                                   line_info_rec_size);
> +       MARK_INFO_REC_ARRAY_WRITTEN(jited_line_info, nr_jited_line_info,
> +                                   jited_line_info_rec_size);
> +       MARK_INFO_ARRAY_WRITTEN(prog_tags, nr_prog_tags, __u8[BPF_TAG_SIZE]);
> +}
> +
> +static void mark_btf_info_written(struct bpf_btf_info *info, __u32 info_len)
> +{
> +       MARK_INFO_ARRAY_WRITTEN(btf, btf_size, __u8);
> +       MARK_INFO_STR_WRITTEN(name, name_len);
> +}
> +
> +static void mark_link_info_written(struct bpf_link_info *info, __u32 info_len)
> +{
> +       switch (info->type) {
> +       case BPF_LINK_TYPE_RAW_TRACEPOINT:
> +               MARK_INFO_STR_WRITTEN(raw_tracepoint.tp_name,
> +                                     raw_tracepoint.tp_name_len);
> +               break;
> +       case BPF_LINK_TYPE_ITER:
> +               MARK_INFO_STR_WRITTEN(iter.target_name, iter.target_name_len);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +#undef MARK_INFO_STR_WRITTEN
> +#undef MARK_INFO_REC_ARRAY_WRITTEN
> +#undef MARK_INFO_ARRAY_WRITTEN
> +#undef __MARK_INFO_ARRAY_WRITTEN

Ugh... I wasn't a big fan of adding all these "mark_mem_written"
across a bunch of APIs to begin with, but this part is really putting
me off.

I like the bpf_{map,btf,prog,btf}_info_by_fd() improvements you did,
but maybe adding these MSan annotations is a bit too much?
Applications that really care about this whole "do I read
uninitialized memory" business could do their own simpler wrappers on
top of libbpf APIs, right?

Maybe we should start there first and see if there is more demand to
have built-in libbpf support?

BTW, is this all needed for ASan as well?

One more worry I have is that given we don't exercise all these
sanitizers regularly in BPF CI, we'll keep forgetting adding new
annotations and all this machinery will start bit rotting.

So I'd say that we should first make sure that we have sanitizer
builds/runs in BPF CI, before signing up for maintaining these
"annotations".

> +
>  int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
>                             __u32 *info_len)
>  {
> -       return bpf_obj_get_info_by_fd(prog_fd, info, info_len);
> +       int err;
> +
> +       err = bpf_obj_get_info_by_fd(prog_fd, info, info_len);
> +       if (!err)
> +               mark_prog_info_written(info, *info_len);
> +
> +       return err;
>  }
>
>  int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,

[...]
