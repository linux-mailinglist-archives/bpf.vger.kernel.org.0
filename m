Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FE43516E
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhJTRj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJTRj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:39:26 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F083C06161C;
        Wed, 20 Oct 2021 10:37:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t127so19779212ybf.13;
        Wed, 20 Oct 2021 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JU/sueCGjx+FZqRSXmq7vkvkcal/5J6S2RQuhQo+EJc=;
        b=bg14LCB0zf9GEJ8PCjHpT1IwtHka0jXl3/AQX1pXI1bidrMbcbY/pvn1fkYEgMPGlR
         XgjCHjc/Ed/yDlsGHQMI43231QqIiQaj57os6t7JYlXnLBMc3BHIejMtAumaklxLtiM8
         5VHuOxlZVWzCON+i5+Utsm7JOnUsyoGPJdFCK34tceURItc0LQeh+aA+q+iIJFIDbTzP
         zF6/f1HfwSos4bmVsL5uK3KTKM+nhP7USfRdvgsdRRP5ZzGhYWzv7jTIx6VTxBWtdfcC
         vCGH2CJCdB4On6mvQMyvWCltyh/UHmIZ7tFz5QAUOYZu7YSXOzAn9f7Tk/hlydVLhteg
         J8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JU/sueCGjx+FZqRSXmq7vkvkcal/5J6S2RQuhQo+EJc=;
        b=PrFSPjvkrsQKjn5Ed5jg1gbldCHCugYpKW1w/5+m27+0o3hap7pJUgUTKT6683KRfP
         apstiSpwakJ4FsxbjkoPkYvJ5au75whYqoGkBoc35ic1NEUleFVopH4iK0/7jGPUOGNz
         23FM3WAh29D/je/W0oPf1Z0VOhqPSXBiSheobutTmCC6cvbnXrRPAX1n0bxe0ioZBBlX
         JJjd8EZ5Fls9HzSzyGY6/ekHcP+lJt5PVJXWWt5OgemeLlm4UfvsHdjVeBI3ycDphzuL
         t0O9ruzfIMAMNQ9P11jDM1gmUXoPkGdf8NoUbO6oR9TkXdpx6oYg9rs+R6KV0W+r3IEd
         ap3g==
X-Gm-Message-State: AOAM531yXTMrI/+bj5FAOFrpPM2m3aJ+mdaggRjf4PAdmwyCzi8ZOEgJ
        UjIE5ZrrJDf4FJK42ihrEc61tGyuxxk0b0Baz+s=
X-Google-Smtp-Source: ABdhPJzHOb3naucbaxmD+ZRagNI20kCKEH0ptuR0J5nyy+05FWsD/G9XQtxPYqbu+66Mn8cN/OGLRlnFGS29wpD9wZA=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr457400ybj.504.1634751431378;
 Wed, 20 Oct 2021 10:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211011082031.4148337-1-davemarchevsky@fb.com> <20211011082031.4148337-3-davemarchevsky@fb.com>
In-Reply-To: <20211011082031.4148337-3-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 10:37:00 -0700
Message-ID: <CAEf4BzZk=fO8YNR9VQYUodSATp76XpRD6xd+pXMF90KummFwqQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpftool: use bpf_obj_get_info_by_fd directly
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> To prepare for impending deprecation of libbpf's
> bpf_program__get_prog_info_linear, migrate uses of this function to use
> bpf_obj_get_info_by_fd.
>
> Since the profile_target_name and dump_prog_id_as_func_ptr helpers were
> only looking at the first func_info, avoid grabbing the rest to save a
> malloc. For do_dump, add a more full-featured helper, but avoid
> free/realloc of buffer when possible for multi-prog dumps.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c |  40 +++++----
>  tools/bpf/bpftool/prog.c       | 154 +++++++++++++++++++++++++--------
>  2 files changed, 144 insertions(+), 50 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 9c25286a5c73..0f85704628bf 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -32,14 +32,16 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
>                                     const struct btf_type *func_proto,
>                                     __u32 prog_id)
>  {
> -       struct bpf_prog_info_linear *prog_info = NULL;
>         const struct btf_type *func_type;
> +       int prog_fd = -1, func_sig_len;
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
>         const char *prog_name = NULL;
> -       struct bpf_func_info *finfo;
>         struct btf *prog_btf = NULL;
> -       struct bpf_prog_info *info;
> -       int prog_fd, func_sig_len;
> +       struct bpf_func_info finfo;
> +       __u32 finfo_rec_size;
>         char prog_str[1024];
> +       int err;
>
>         /* Get the ptr's func_proto */
>         func_sig_len = btf_dump_func(d->btf, prog_str, func_proto, NULL, 0,
> @@ -55,22 +57,27 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
>         if (prog_fd == -1)

please change this to (prog_fd < 0), see [0] for why

we should check all the other places in bpftool to see if there are
any patterns like this that would break on libbpf 1.0 (cc Quentin as
well)

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#direct-error-code-returning-libbpf_strict_direct_errs

>                 goto print;
>
> -       prog_info = bpf_program__get_prog_info_linear(prog_fd,
> -                                               1UL << BPF_PROG_INFO_FUNC_INFO);
> -       close(prog_fd);
> -       if (IS_ERR(prog_info)) {
> -               prog_info = NULL;
> +       err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> +       if (err)
>                 goto print;
> -       }
> -       info = &prog_info->info;
>
> -       if (!info->btf_id || !info->nr_func_info)
> +       if (!info.btf_id || !info.nr_func_info)
> +               goto print;
> +
> +       finfo_rec_size = info.func_info_rec_size;
> +       memset(&info, 0, sizeof(info));
> +       info.nr_func_info = 1;
> +       info.func_info_rec_size = finfo_rec_size;
> +       info.func_info = ptr_to_u64(&finfo);
> +
> +       err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> +       if (err)
>                 goto print;
> -       prog_btf = btf__load_from_kernel_by_id(info->btf_id);
> +
> +       prog_btf = btf__load_from_kernel_by_id(info.btf_id);
>         if (libbpf_get_error(prog_btf))
>                 goto print;
> -       finfo = u64_to_ptr(info->func_info);
> -       func_type = btf__type_by_id(prog_btf, finfo->type_id);
> +       func_type = btf__type_by_id(prog_btf, finfo.type_id);
>         if (!func_type || !btf_is_func(func_type))
>                 goto print;
>
> @@ -92,7 +99,8 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
>         prog_str[sizeof(prog_str) - 1] = '\0';
>         jsonw_string(d->jw, prog_str);
>         btf__free(prog_btf);
> -       free(prog_info);
> +       if (prog_fd != -1)

similarly, prog_fd >= 0 here; also, isn't this a fix? Can you add
Fixes: tag then?

> +               close(prog_fd);
>         return 0;
>  }
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a24ea7e26aa4..3b3ccc7b6dd4 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -98,6 +98,72 @@ static enum bpf_attach_type parse_attach_type(const char *str)
>         return __MAX_BPF_ATTACH_TYPE;
>  }
>
> +#define holder_prep_needed_rec_sz(nr, rec_size)\
> +({                                             \
> +       holder.nr = info->nr;                   \
> +       needed += holder.nr * rec_size;         \
> +})
> +
> +#define holder_prep_needed(nr, rec_size)       \
> +({                                             \
> +       holder.nr = info->nr;                   \
> +       holder.rec_size = info->rec_size;       \
> +       needed += holder.nr * holder.rec_size;  \
> +})
> +
> +#define holder_set_ptr(field, nr, rec_size)    \
> +({                                             \
> +       holder.field = ptr_to_u64(ptr);         \
> +       ptr += nr * rec_size;                   \
> +})
> +
> +static int prep_prog_info(struct bpf_prog_info *const info, enum dump_mode mode,
> +                         void **info_data, size_t *const info_data_sz)
> +{
> +       struct bpf_prog_info holder = {};
> +       size_t needed = 0;
> +       void *ptr;
> +
> +       if (mode == DUMP_JITED)
> +               holder_prep_needed_rec_sz(jited_prog_len, 1);
> +       else
> +               holder_prep_needed_rec_sz(xlated_prog_len, 1);
> +
> +       holder_prep_needed_rec_sz(nr_jited_ksyms, sizeof(__u64));
> +       holder_prep_needed_rec_sz(nr_jited_func_lens, sizeof(__u32));
> +       holder_prep_needed(nr_func_info, func_info_rec_size);
> +       holder_prep_needed(nr_line_info, line_info_rec_size);
> +       holder_prep_needed(nr_jited_line_info, jited_line_info_rec_size);
> +
> +       if (needed > *info_data_sz) {
> +               *info_data = realloc(*info_data, needed);

never do `x = realloc(x);`, if realloc fails, original memory is
leaked. Temporary variable is necessary to work with realloc, see a
bunch of other places in libbpf where we use realloc for an example.

> +               if (!*info_data)
> +                       return -1;
> +               *info_data_sz = needed;
> +       }
> +
> +       ptr = *info_data;
> +
> +       if (mode == DUMP_JITED)
> +               holder_set_ptr(jited_prog_insns, holder.jited_prog_len, 1);
> +       else
> +               holder_set_ptr(xlated_prog_insns, holder.xlated_prog_len, 1);
> +
> +       holder_set_ptr(jited_ksyms, holder.nr_jited_ksyms, sizeof(__u64));
> +       holder_set_ptr(jited_func_lens, holder.nr_jited_func_lens, sizeof(__u32));
> +       holder_set_ptr(func_info, holder.nr_func_info, holder.func_info_rec_size);
> +       holder_set_ptr(line_info, holder.nr_line_info, holder.line_info_rec_size);
> +       holder_set_ptr(jited_line_info, holder.nr_jited_line_info,
> +                      holder.jited_line_info_rec_size);

tbh, I completely lost track of what these holder_xxx() macro actually
do here... You saved few lines of code, but I think we lost a lot in
readability

> +
> +       *info = holder;

instead of copying at the end, why not fill out the passed in
bpf_prog_info directly? Of course *info stuff is annoying, but that's
solved with a temporary variable, no?


> +       return 0;
> +}
> +
> +#undef holder_prep_needed
> +#undef holder_prep_needed_rec_sz
> +#undef holder_set_ptr
> +

[...]
