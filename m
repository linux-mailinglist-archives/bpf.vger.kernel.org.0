Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87C37B4D7
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhELESd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELESc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 00:18:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A5C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:17:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 15so29184031ybc.0
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 21:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfnhfncKREMhTBaSORYjz8LcmwpBU3YZsB+kL4446qo=;
        b=aWFkqMUNpTImJpZEeIpvSBtPu2FMiUUXgHnKS38izM/U01iaVGRPKsknZQG8fFRXIF
         jaWJ1Zjktxc0QpaRiRXrvUpX7lJ5KvgUiJaSbj6CQGreKcqBnk+8jtTIQdjWK593658O
         2PNb71iOT0ScvuPAyOVRJ4AAhWrdaPxGWCEMXn7rbZbltw3oh88C+zH/yU+fUzWf846z
         4UQDQqsh3fE5NDzFxwLRpxMcevjW9XX3f/Ib8Do7gvm2ZhRyGHDdy2oULJkc/Zabg1Lz
         Jw738xrVS7eUdfJJuIoopKXHOqL/PfAJsbRtVR5pnqWY6ju526v2GXsVXftPMYwIBbK9
         H/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfnhfncKREMhTBaSORYjz8LcmwpBU3YZsB+kL4446qo=;
        b=aLqVPykog0+JGt6N7DxurahjJM/Eu9pOSHCTWtUuFTz2Jkb9zHamihHjAx5uCcDdL+
         cRf+U/YGYzJIPJhJDC0DRgv42giaqvG060uOwvs0L4V4C5qJCaaNXgj+mDRfelUqK6O2
         WAj7Zb0RMgzT7gAPf5n6st41gR3BwNRuhkUvUQa7Wughm4tb4oGHZ3GZ8133Yt3Qs0+Q
         c5RSoehXEagifDqi8P3zjXD+jpYV/tRTqxhvxG1ZcaSKTDcVCE/UobvRSKIWcVhqU+GU
         CdlF/SUAstBbIs6fFomimq0PoHNhwN7nBI0dimPv8i7chAjO8aupfdVueL98hRt0ncmr
         YQ1A==
X-Gm-Message-State: AOAM53116hdgWEhV+DK1AFsCXtwo8W+NUKAnEIpvd2JgIkyUA3I0WjRX
        SVfFpIyNlJ1yuqAJpF4Os+Zw1lvZzMqQ2HwxtSE=
X-Google-Smtp-Source: ABdhPJz5uWAcwBgI0omtkDe34lmrRGJu6vd4stUQwh0zVKGG16FaLX7kA14n1GEpdqPrdY+gnokYRfL6eT8XbiAbsG4=
X-Received: by 2002:a25:1455:: with SMTP id 82mr44912646ybu.403.1620793044083;
 Tue, 11 May 2021 21:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-19-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-19-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 21:17:12 -0700
Message-ID: <CAEf4BzZYZ9i+pJ_aBzkhCLX9fVjUbOF_1=xvykk93TL5yQZieA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 18/22] bpftool: Use syscall/loader program in
 "prog load" and "gen skeleton" command.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add -L flag to bpftool to use libbpf gen_trace facility and syscall/loader program
> for skeleton generation and program loading.
>
> "bpftool gen skeleton -L" command will generate a "light skeleton" or "loader skeleton"
> that is similar to existing skeleton, but has one major difference:
> $ bpftool gen skeleton lsm.o > lsm.skel.h
> $ bpftool gen skeleton -L lsm.o > lsm.lskel.h
> $ diff lsm.skel.h lsm.lskel.h
> @@ -5,34 +4,34 @@
>  #define __LSM_SKEL_H__
>
>  #include <stdlib.h>
> -#include <bpf/libbpf.h>
> +#include <bpf/bpf.h>
>
> The light skeleton does not use majority of libbpf infrastructure.
> It doesn't need libelf. It doesn't parse .o file.
> It only needs few sys_bpf wrappers. All of them are in bpf/bpf.h file.
> In future libbpf/bpf.c can be inlined into bpf.h, so not even libbpf.a would be
> needed to work with light skeleton.
>
> "bpftool prog load -L file.o" command is introduced for debugging of syscall/loader
> program generation. Just like the same command without -L it will try to load
> the programs from file.o into the kernel. It won't even try to pin them.
>
> "bpftool prog load -L -d file.o" command will provide additional debug messages
> on how syscall/loader program was generated.
> Also the execution of syscall/loader program will use bpf_trace_printk() for
> each step of loading BTF, creating maps, and loading programs.
> The user can do "cat /.../trace_pipe" for further debug.
>
> An example of fexit_sleep.lskel.h generated from progs/fexit_sleep.c:
> struct fexit_sleep {
>         struct bpf_loader_ctx ctx;
>         struct {
>                 struct bpf_map_desc bss;
>         } maps;
>         struct {
>                 struct bpf_prog_desc nanosleep_fentry;
>                 struct bpf_prog_desc nanosleep_fexit;
>         } progs;
>         struct {
>                 int nanosleep_fentry_fd;
>                 int nanosleep_fexit_fd;
>         } links;
>         struct fexit_sleep__bss {
>                 int pid;
>                 int fentry_cnt;
>                 int fexit_cnt;
>         } *bss;
> };
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

After you applied my patchset removing static variables from BPF
skeleton, trace_printk selftests doesn't compile anymore, you'll need
to move out fmt outside of the function and make it non-static. With
that everything compiles locally.

But CI reports different errors still, not sure what's going on there, see [0].

https://travis-ci.com/github/kernel-patches/bpf/builds/225675119

My main complaint for this patch is that the generated .lskel.h header
file looks quite sloppy and doesn't follow kernel code style. It would
be good to try to clean this up a bit.

E.g., we don't write

        if (skel->maps.ringbuf.map_fd > 0) close(skel->maps.ringbuf.map_fd);

but instead

        if (skel->maps.ringbuf.map_fd > 0)
                close(skel->maps.ringbuf.map_fd);

And instead of

        int ret = 0;
        ret = ret < 0 ? ret : test_ringbuf__test_ringbuf__attach(skel);

we'd have an empty line

        int ret = 0;

        ret = ret < 0 ? ret : test_ringbuf__test_ringbuf__attach(skel);

It's auto-generated code, of course, but people might want/need to
read it, so would be good to have it look clean.

>  tools/bpf/bpftool/Makefile        |   2 +-
>  tools/bpf/bpftool/gen.c           | 362 ++++++++++++++++++++++++++++--
>  tools/bpf/bpftool/main.c          |   7 +-
>  tools/bpf/bpftool/main.h          |   1 +
>  tools/bpf/bpftool/prog.c          | 104 +++++++++
>  tools/bpf/bpftool/xlated_dumper.c |   3 +
>  6 files changed, 456 insertions(+), 23 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b3073ae84018..d16d289ade7a 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -136,7 +136,7 @@ endif
>
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>
> -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
> +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o) $(OUTPUT)disasm.o
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>
>  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 31ade77f5ef8..7a3e343f31db 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -18,6 +18,7 @@
>  #include <sys/stat.h>
>  #include <sys/mman.h>
>  #include <bpf/btf.h>
> +#include <bpf/bpf_gen_internal.h>
>
>  #include "json_writer.h"
>  #include "main.h"
> @@ -268,6 +269,303 @@ static void codegen(const char *template, ...)
>         free(s);
>  }
>
> +static void print_hex(const char *obj_data, int file_sz)

nit: obj_data -> data, file_sz -> data_sz (it's multi-purpose now)

> +{
> +       int i, len;
> +
> +       for (i = 0, len = 0; i < file_sz; i++) {
> +               int w = obj_data[i] ? 4 : 2;
> +
> +               len += w;
> +               if (len > 78) {
> +                       printf("\\\n");
> +                       len = w;
> +               }
> +               if (!obj_data[i])
> +                       printf("\\0");
> +               else
> +                       printf("\\x%02x", (unsigned char)obj_data[i]);
> +       }
> +}
> +
> +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> +{
> +       long page_sz = sysconf(_SC_PAGE_SIZE);
> +       size_t map_sz;
> +
> +       map_sz = (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map__max_entries(map);
> +       map_sz = roundup(map_sz, page_sz);
> +       return map_sz;
> +}
> +
> +static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
> +{
> +       struct bpf_program *prog;
> +
> +       bpf_object__for_each_program(prog, obj) {
> +               codegen("\
> +                       \n\
> +                       \n\
> +                       static inline int                                           \n\
> +                       %1$s__%2$s__attach(struct %1$s *skel)                       \n\
> +                       {                                                           \n\
> +                               int fd = bpf_raw_tracepoint_open(                   \
> +                       ", obj_name, bpf_program__name(prog));
> +
> +               switch (bpf_program__get_type(prog)) {
> +               case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +                       putchar('"');
> +                       fputs(strchr(bpf_program__section_name(prog), '/') + 1, stdout);
> +                       putchar('"');

we use codegen() and printf(), let's not add fputs() to the mix, it's
doesn't add much and in this case, I think printf is even a bit easier
to follow:

tp_name = strchr(bpf_program__section_name(prog), '/') + 1;
printf("\"%s\", tp_name);

But also it seems like this code assumes that every program type can
be attached with bpf_raw_tracepoint_open() which is definitely not the
case for a lot of programs. When in the future you support, say, BPF
iterator, you'll do that with bpf_link_create(), so not sure why you
chose this code pattern instead of something like:

printf("\tint prog_fd = skel->progs.%s.prog_fd;\n", bpf_program__name(prog));

switch (bpf_program__get_type(prog)) {
case BPF_PROG_TYPE_RAW_TRACEPOINT:
    tp_name = ...;
    printf("\tint fd = bpf_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
    break;
case BPF_PROG_TYPE_TRACING:
    printf("\tint fd = bpf_raw_tracepoint_open(NULL, prog_fd);\n");
    break;
default:
    printf("int fd = 0; /* auto-attach not supported */\n");
    break;
}

Then you have a common if (fd > 0) /* set fd */; return fd; piece of code.

This is much clearer to follow, it's more easily extensible and it
doesn't pretend that every program is a fentry/fexit or raw_tp and
fails to auto-attach, rather just skipping auto-attaching.

> +                       break;
> +               default:
> +                       fputs("NULL", stdout);
> +                       break;
> +               }
> +               codegen("\
> +                       \n\
> +                       , skel->progs.%1$s.prog_fd);                                \n\
> +                               if (fd > 0) skel->links.%1$s_fd = fd;               \n\
> +                               return fd;                                          \n\
> +                       }                                                           \n\
> +                       ", bpf_program__name(prog));
> +       }
> +
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +               static inline int                                           \n\
> +               %1$s__attach(struct %1$s *skel)                             \n\
> +               {                                                           \n\
> +                       int ret = 0;                                        \n\

codegen empty line here, as one example of what I've talked about above

> +               ", obj_name);
> +
> +       bpf_object__for_each_program(prog, obj) {
> +               codegen("\
> +                       \n\
> +                               ret = ret < 0 ? ret : %1$s__%2$s__attach(skel);   \n\
> +                       ", obj_name, bpf_program__name(prog));
> +       }
> +
> +       codegen("\
> +               \n\
> +                       return ret < 0 ? ret : 0;                           \n\
> +               }                                                           \n\
> +                                                                           \n\
> +               static inline void                                          \n\
> +               %1$s__detach(struct %1$s *skel)                             \n\
> +               {                                                           \n\
> +               ", obj_name);
> +       bpf_object__for_each_program(prog, obj) {
> +               printf("\tif (skel->links.%1$s_fd > 0) close(skel->links.%1$s_fd);\n",
> +                      bpf_program__name(prog));

you use bpf_program__name(prog) in so many place that it will be much
simpler if you have a dedicated variable for it

> +       }
> +       codegen("\
> +               \n\
> +               }                                                           \n\
> +               ");
> +}
> +
> +static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
> +{
> +       struct bpf_program *prog;
> +       struct bpf_map *map;
> +
> +       codegen("\
> +               \n\
> +               static void                                                 \n\
> +               %1$s__destroy(struct %1$s *skel)                            \n\
> +               {                                                           \n\
> +                       if (!skel)                                          \n\
> +                               return;                                     \n\
> +                       %1$s__detach(skel);                                 \n\
> +               ",
> +               obj_name);

please use some separator empty lines between logical blocks/steps
(here and in many other places), it's quite hard to follow these dense
blocks of code

> +       bpf_object__for_each_program(prog, obj) {
> +               printf("\tif (skel->progs.%1$s.prog_fd > 0) close(skel->progs.%1$s.prog_fd);\n",
> +                      bpf_program__name(prog));
> +       }

[...]

> +               if (!bpf_map__is_internal(map) ||
> +                   !(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
> +                       continue;
> +
> +               printf("\tskel->%1$s =\n"
> +                      "\t\tmmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n"
> +                      "\t\t\tMAP_SHARED | MAP_ANONYMOUS, -1, 0);\n"
> +                      "\tmemcpy(skel->%1$s, (void *)\"",

add \\ after (void *)" so that long hex dump starts on a new line?

> +                      ident, bpf_map_mmap_sz(map));

this printf is also very unreadable. If you insist on doing this as
multi-line code, I think it deserves codegen, but I'd probably
generate mmap() invocation on a single line

But also, mmap() can fail, it would be good to handle this instead of
having (void *)-1 happily stored and getting sigsegv on memcpy().

> +               bpf_map__get_initial_value(map, &mmap_data, &mmap_size);
> +               print_hex(mmap_data, mmap_size);
> +               printf("\", %2$zd);\n"
> +                      "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
> +                      ident, mmap_size);
> +       }

[...]

> +
> +static int try_loader(struct gen_loader_opts *gen)
> +{
> +       struct bpf_load_and_run_opts opts = {};
> +       struct bpf_loader_ctx *ctx;
> +       int ctx_sz = sizeof(*ctx) + 64 * max(sizeof(struct bpf_map_desc), sizeof(struct bpf_prog_desc));

this is quite a long line...

> +       int log_buf_sz = (1u << 24) - 1;
> +       int err, fds_before, fd_delta;
> +       char *log_buf;
> +

[...]

> +static int do_loader(int argc, char **argv)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts);
> +       DECLARE_LIBBPF_OPTS(gen_loader_opts, gen);
> +       struct bpf_object_load_attr load_attr = {};
> +       struct bpf_object *obj;
> +       const char *file;
> +       int err = 0;
> +
> +       if (!REQ_ARGS(1))
> +               return -1;
> +       file = GET_ARG();
> +
> +       obj = bpf_object__open_file(file, &open_opts);
> +       if (IS_ERR_OR_NULL(obj)) {

please use libbpf_get_error() instead of IS_ERR_OR_NULL()


> +               p_err("failed to open object file");
> +               goto err_close_obj;
> +       }
> +

[...]
