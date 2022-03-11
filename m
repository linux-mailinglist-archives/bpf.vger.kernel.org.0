Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BE4D6B20
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCKX2e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 18:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCKX2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 18:28:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B81A8063
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:27:29 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x9so486803ilc.3
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/9GK+THuJ8IP5tzfDnxwfNyOJZFEv9skDrTHJVyblw=;
        b=p2Fo+bQ8xUZNHk77l3Ls+UhFXUAgaMwyLeNPlD7hFu3TCVBy7EEwj+NKZ06Ag695Nz
         8BN/hc4f8c7d6wg+w1CQtZHe4tu323SiB2ijuOR3AGyFrJGFoko4BBvAVFYBsL0T8e2g
         nMfenxer3IOS7C2kCKtgKWZGSFcrYMFrfGIxo0vwxtxRKP2LHQwklVmqYEGn/aEQ6hkB
         ND+q8Rvyk1lNQ50QgoOH95epDEm4Xdx12+3Ulf+mvFn94dlTa0DSwyg3REyZFu09JZ5U
         kLCvveUj6a6J6gM8ga8IZr3MlzhZBxBnrToTZrGTtJjORSoJUTcoBB4QVG58l9lSIt97
         BTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/9GK+THuJ8IP5tzfDnxwfNyOJZFEv9skDrTHJVyblw=;
        b=0CZASAnZ/9PLkPwoCA7V4VQ5n8vZf80AGdY9dYX8LIIlgkKtbq5qV0C5Gy41a9zumv
         hsQUIxCarRAP+tqeH+0jYNumhjCUWnLzo/H3DElaVVkoUJ9p8Gh33mBlu/4GZWkVneZ5
         uHjisi8FEih6HHQQRh7NhTLlfUDM0KWNJLbVu5KN9duLwp8gFx7jwHeKqcPNOxVHUEAc
         k5ntqygiMGlUAVwR6Qi16+qjKUf/x8Hzr07Q4mKdcRj3PVHHeWobLhA8+r7C4WAab4X0
         wjYGsDqAmvYRvqYTBREgMCgWYGeAmBKA4YF43HLHt5QW2gnMQ8m3x5cYetl7pkeHwkJQ
         0GAA==
X-Gm-Message-State: AOAM531R0M1xlwV6TiGv8e6NKl5USe2LX626LEIXsbLrDtZGsZy0nn1W
        FR+ggtD6nJGh3NURmPlgo2rWl9Z+b2h3xoqbm0+u5JippL8=
X-Google-Smtp-Source: ABdhPJwPzfqfFfLGNDUCIiw1ZogdBIoXj3sdtvz/+odBfWIqdomeKS1B6QvZ39zgPI1UKPyHPBLTwM5f6mKnplS9G8U=
X-Received: by 2002:a92:ca0c:0:b0:2c7:7983:255f with SMTP id
 j12-20020a92ca0c000000b002c77983255fmr3678828ils.252.1647041249109; Fri, 11
 Mar 2022 15:27:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
In-Reply-To: <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 15:27:17 -0800
Message-ID: <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Subskeletons are headers which require an already loaded program to
> operate.
>
> For example, when a BPF library is linked into a larger BPF object file,
> the library userspace needs a way to access its own global variables
> without requiring knowledge about the larger program at build time.
>
> As a result, subskeletons require a loaded bpf_object to open().
> Further, they find their own symbols in the larger program by
> walking BTF type data at run time.
>
> At this time, programs, maps, and globals are supported through
> non-owning pointers.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
>  tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
>  tools/bpf/bpftool/gen.c                       | 589 ++++++++++++++++--
>  3 files changed, 564 insertions(+), 64 deletions(-)
>

Few comments below, but overall looks great!

[...]

> +static bool btf_is_ptr_to_func_proto(const struct btf *btf,
> +                                    const struct btf_type *v)
> +{
> +       return btf_is_ptr(v) && btf_is_func_proto(btf__type_by_id(btf, v->type));
> +}
> +
> +static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name)
> +{
> +       struct btf *btf = bpf_object__btf(obj);
> +       struct btf_dump *d;
> +       struct bpf_map *map;
> +       const struct btf_type *sec, *var;
> +       const struct btf_var_secinfo *sec_var;
> +       int i, err, vlen;
> +       char map_ident[256], var_ident[256], sec_ident[256];
> +       bool strip_mods = false;
> +       const char *sec_name, *var_name;
> +       __u32 var_type_id;
> +
> +       d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
> +       err = libbpf_get_error(d);

nit: no need to use libbpf_get_error() in libbpf 1.0 mode

> +       if (err)
> +               return err;
> +
> +       bpf_object__for_each_map(map, obj) {
> +               /* only generate definitions for memory-mapped internal maps */
> +               if (!bpf_map__is_internal(map))
> +                       continue;
> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                       continue;
> +               if (!get_map_ident(map, map_ident, sizeof(map_ident)))
> +                       continue;

extract these three checks into helper and reuse from codegen_asserts
and codegen_datasecs?


> +
> +               sec = find_type_for_map(btf, map_ident);
> +               if (!sec)
> +                       continue;
> +
> +               sec_name = btf__name_by_offset(btf, sec->name_off);
> +               if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
> +                       continue;
> +
> +               if (strcmp(sec_name, ".kconfig") != 0)
> +                       strip_mods = true;
> +
> +               printf("        struct %s__%s {\n", obj_name, sec_ident);
> +
> +               sec_var = btf_var_secinfos(sec);
> +               vlen = btf_vlen(sec);
> +               for (i = 0; i < vlen; i++, sec_var++) {
> +                       DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
> +                               .field_name = var_ident,
> +                               .indent_level = 2,
> +                               .strip_mods = strip_mods,
> +                       );
> +
> +                       var = btf__type_by_id(btf, sec_var->type);
> +                       var_name = btf__name_by_offset(btf, var->name_off);
> +                       var_type_id = var->type;
> +
> +                       /* static variables are not exposed through BPF skeleton */
> +                       if (btf_var(var)->linkage == BTF_VAR_STATIC)
> +                               continue;
> +
> +                       /* leave the first character for a * prefix, size - 2
> +                        * as a result as well
> +                        */
> +                       var_ident[0] = '\0';
> +                       var_ident[1] = '\0';
> +                       strncat(var_ident + 1, var_name, sizeof(var_ident) - 2);
> +
> +                       /* sanitize variable name, e.g., for static vars inside
> +                        * a function, it's name is '<function name>.<variable name>',
> +                        * which we'll turn into a '<function name>_<variable name>'.
> +                        */
> +                       sanitize_identifier(var_ident + 1);

btw, I think we don't need sanitization anymore. We needed it for
static variables (they would be of the form <func_name>.<var_name> for
static variables inside the functions), but now it's just unnecessary
complication

> +                       var_ident[0] = ' ';
> +
> +                       /* The datasec member has KIND_VAR but we want the
> +                        * underlying type of the variable (e.g. KIND_INT).
> +                        */
> +                       var = btf__type_by_id(btf, var->type);

you need to use skip_mods_and_typedefs() or equivalent to skip any
const/volatile/restrict modifiers before checking btf_is_array()

> +
> +                       /* Prepend * to the field name to make it a pointer. */
> +                       var_ident[0] = '*';
> +
> +                       printf("\t\t");
> +                       /* Func and array members require special handling.
> +                        * Instead of producing `typename *var`, they produce
> +                        * `typeof(typename) *var`. This allows us to keep a
> +                        * similar syntax where the identifier is just prefixed
> +                        * by *, allowing us to ignore C declaration minutae.
> +                        */
> +                       if (btf_is_array(var) ||
> +                           btf_is_ptr_to_func_proto(btf, var)) {
> +                               printf("typeof(");
> +                               /* print the type inside typeof() without a name */
> +                               opts.field_name = "";
> +                               err = btf_dump__emit_type_decl(d, var_type_id, &opts);
> +                               if (err)
> +                                       goto out;
> +                               printf(") %s", var_ident);
> +                       } else {
> +                               err = btf_dump__emit_type_decl(d, var_type_id, &opts);
> +                               if (err)
> +                                       goto out;
> +                       }
> +                       printf(";\n");

we can simplify this a bit around var_ident and two
btf_dump__emit_type_decl() invocations. We know that we are handling
"non-uniform" C syntax for array and func pointer, so we don't need to
use opts.field_name. Doing this (schematically) should work (taking
into account no need for sanitization as well):

if (btf_is_array() || btf_is_ptr_to_func_proto())
    printf("typeof(");
btf_dump__emit_type_decl(... /* opts.field_name stays NULL */);
printf(" *%s", var_name);

or did I miss some corner case?

> +               }
> +               printf("        } %s;\n", sec_ident);
> +       }
> +
> +out:
> +       btf_dump__free(d);
> +       return err;
> +}
> +
>  static void codegen(const char *template, ...)
>  {
>         const char *src, *end;
> @@ -727,10 +843,93 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>         return err;
>  }
>
> +static void
> +codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped)
> +{
> +       struct bpf_map *map;
> +       char ident[256];
> +       size_t i;
> +
> +       if (map_cnt) {

invert if, return early, reduce nestedness?

> +               codegen("\
> +                       \n\
> +                                                                           \n\
> +                               /* maps */                                  \n\
> +                               s->map_cnt = %zu;                           \n\
> +                               s->map_skel_sz = sizeof(*s->maps);          \n\
> +                               s->maps = (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel_sz);\n\
> +                               if (!s->maps)                               \n\
> +                                       goto err;                           \n\
> +                       ",
> +                       map_cnt
> +               );
> +               i = 0;
> +               bpf_object__for_each_map(map, obj) {
> +                       if (!get_map_ident(map, ident, sizeof(ident)))
> +                               continue;
> +
> +                       codegen("\
> +                               \n\
> +                                                                           \n\
> +                                       s->maps[%zu].name = \"%s\";         \n\
> +                                       s->maps[%zu].map = &obj->maps.%s;   \n\
> +                               ",
> +                               i, bpf_map__name(map), i, ident);
> +                       /* memory-mapped internal maps */
> +                       if (mmaped && bpf_map__is_internal(map) &&
> +                           (bpf_map__map_flags(map) & BPF_F_MMAPABLE)) {
> +                               printf("\ts->maps[%zu].mmaped = (void **)&obj->%s;\n",
> +                                      i, ident);
> +                       }
> +                       i++;
> +               }
> +       }
> +}
> +
> +static void
> +codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_links)
> +{
> +       struct bpf_program *prog;
> +       int i;
> +
> +       if (prog_cnt) {

same as above, reduce nestedness?

> +               codegen("\
> +                       \n\
> +                                                                           \n\
> +                               /* programs */                              \n\
> +                               s->prog_cnt = %zu;                          \n\
> +                               s->prog_skel_sz = sizeof(*s->progs);        \n\
> +                               s->progs = (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_skel_sz);\n\
> +                               if (!s->progs)                              \n\
> +                                       goto err;                           \n\
> +                       ",
> +                       prog_cnt
> +               );
> +               i = 0;
> +               bpf_object__for_each_program(prog, obj) {
> +                       codegen("\
> +                               \n\
> +                                                                           \n\
> +                                       s->progs[%1$zu].name = \"%2$s\";    \n\
> +                                       s->progs[%1$zu].prog = &obj->progs.%2$s;\n\
> +                               ",
> +                               i, bpf_program__name(prog));
> +
> +                       if (populate_links)

nit: {} ?

> +                               codegen("\
> +                                       \n\
> +                                               s->progs[%1$zu].link = &obj->links.%2$s;\n\
> +                                       ",
> +                                       i, bpf_program__name(prog));
> +                       i++;
> +               }
> +       }
> +}
> +

[...]

> +       if (!REQ_ARGS(1)) {
> +               usage();
> +               return -1;
> +       }
> +       file = GET_ARG();
> +
> +       while (argc) {
> +               if (!REQ_ARGS(2))
> +                       return -1;
> +
> +               if (is_prefix(*argv, "name")) {
> +                       NEXT_ARG();
> +
> +                       if (obj_name[0] != '\0') {
> +                               p_err("object name already specified");
> +                               return -1;
> +                       }
> +
> +                       strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
> +                       obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';

we don't know the name of the final object, why would we allow to set
any object name at all?

> +               } else {
> +                       p_err("unknown arg %s", *argv);
> +                       return -1;
> +               }
> +
> +               NEXT_ARG();
> +       }
> +
> +       if (argc) {
> +               p_err("extra unknown arguments");
> +               return -1;
> +       }
> +
> +       if (use_loader) {
> +               p_err("cannot use loader for subskeletons");
> +               return -1;
> +       }
> +
> +       if (stat(file, &st)) {
> +               p_err("failed to stat() %s: %s", file, strerror(errno));
> +               return -1;
> +       }
> +       file_sz = st.st_size;
> +       mmap_sz = roundup(file_sz, sysconf(_SC_PAGE_SIZE));
> +       fd = open(file, O_RDONLY);
> +       if (fd < 0) {
> +               p_err("failed to open() %s: %s", file, strerror(errno));
> +               return -1;
> +       }
> +       obj_data = mmap(NULL, mmap_sz, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (obj_data == MAP_FAILED) {
> +               obj_data = NULL;
> +               p_err("failed to mmap() %s: %s", file, strerror(errno));
> +               goto out;
> +       }
> +       if (obj_name[0] == '\0')
> +               get_obj_name(obj_name, file);
> +
> +       /* The empty object name allows us to use bpf_map__name and produce
> +        * ELF section names out of it. (".data" instead of "obj.data")
> +        */
> +       opts.object_name = "";

yep, like this. So that "name" argument "support" above is bogus,
let's remove it

> +       obj = bpf_object__open_mem(obj_data, file_sz, &opts);
> +       if (!obj) {
> +               char err_buf[256];
> +
> +               libbpf_strerror(errno, err_buf, sizeof(err_buf));
> +               p_err("failed to open BPF object file: %s", err_buf);
> +               obj = NULL;
> +               goto out;
> +       }
> +

[...]

> +               for (i = 0; i < len; i++, var++) {
> +                       var_type = btf__type_by_id(btf, var->type);
> +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> +
> +                       if (btf_var(var_type)->linkage == BTF_VAR_STATIC)
> +                               continue;
> +
> +                       var_ident[0] = '\0';
> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +                       sanitize_identifier(var_ident);
> +
> +                       /* Note that we use the dot prefix in .data as the
> +                        * field access operator i.e. maps%s becomes maps.data
> +                        */
> +                       codegen("\
> +                       \n\
> +                               s->vars[%4$d].name = \"%1$s\";              \n\
> +                               s->vars[%4$d].map = &obj->maps%3$s;         \n\
> +                               s->vars[%4$d].addr = (void**) &obj->%2$s.%1$s;\n\
> +                       ", var_ident, ident, bpf_map__name(map), var_idx);

map reference should be using ident, not bpf_map__name(), as it refers
to a field. The way it is now it shouldn't work for custom
.data.my_section case (do you have a test for this?) You shouldn't
need bpf_map__name() here at all.

> +
> +                       var_idx++;
> +               }
> +       }
> +
> +       codegen_maps_skeleton(obj, map_cnt, false /*mmaped*/);
> +       codegen_progs_skeleton(obj, prog_cnt, false /*links*/);
> +
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +                       err = bpf_object__open_subskeleton(s);              \n\
> +                       if (err) {                                          \n\
> +                               errno = err;                                \n\

see below, best setting errno after __destroy() call (and errno has to
be positive), see below

> +                               goto err;                                   \n\
> +                       }                                                   \n\
> +                                                                           \n\
> +                       return obj;                                         \n\
> +               err:                                                        \n\
> +                       %1$s__destroy(obj);                                 \n\

errno = -err here

> +                       return NULL;                                        \n\
> +               }                                                           \n\
> +                                                                           \n\
> +               #ifdef __cplusplus                                          \n\
> +               struct %1$s *%1$s::open(const struct bpf_object *src) { return %1$s__open(src); }\n\
> +               void %1$s::destroy(struct %1$s *skel) { %1$s__destroy(skel); }\n\
> +               #endif /* __cplusplus */                                    \n\
> +                                                                           \n\
> +               #endif /* %2$s */                                           \n\
> +               ",
> +               obj_name, header_guard);
> +       err = 0;
> +out:
> +       bpf_object__close(obj);
> +       if (obj_data)
> +               munmap(obj_data, mmap_sz);
> +       close(fd);
> +       return err;
> +}
> +
>  static int do_object(int argc, char **argv)
>  {
>         struct bpf_linker *linker;
> @@ -1192,6 +1653,7 @@ static int do_help(int argc, char **argv)
>         fprintf(stderr,
>                 "Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
>                 "       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
> +               "       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"

[name OBJECT_NAME] should be supported

>                 "       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
> @@ -1788,6 +2250,7 @@ static int do_min_core_btf(int argc, char **argv)
>  static const struct cmd cmds[] = {
>         { "object",             do_object },
>         { "skeleton",           do_skeleton },
> +       { "subskeleton",        do_subskeleton },
>         { "min_core_btf",       do_min_core_btf},
>         { "help",               do_help },
>         { 0 }
> --
> 2.34.1
