Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3323140FF07
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhIQSJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhIQSJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 14:09:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682CC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:08:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id ay33so20018360qkb.10
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evU2F572MFeiyQEbp/9Wida5qV/d2wb3L+Aks8fSC9k=;
        b=RwTmdhJsUbhnZv424CyACZjZh20n6xKHjANTSKfNV5Lmqc7u+eVskLLf0IRSJs5+ar
         +1HK45NWeaf9xqWKtgzsCrXJ6kD1J44rvL027JbBQh7wX7hdqgoihgpHnAdOc/eKsRVp
         sEkXOuLk4nv5nxfc6WT3sywyeB60wf815bxesFOgniiz/U7keHdFPoiEVjyGiDKOsfEc
         dtVUL+OW4R8RQBHWzBG9UQ5MrG34cCdapryh7XyiLEly8fNCwa9w0KbANLbkXEJ3SIKz
         dLopOF1FYnhvF9NNOF7uvwlyWob5RUzhq/9Wv8NKDblFJlJdW6eRpb7sgWVm9jrZLBT8
         P95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evU2F572MFeiyQEbp/9Wida5qV/d2wb3L+Aks8fSC9k=;
        b=PTuQrLeFXzkZiqBb/N9OLHMMGFIOjb9lKf/UwO0pPv9GdQmXmzjwY8eLGyKW52CEF4
         v2s7qKo3T4N3mza0h7yfRhbUlrWcDqze83aoWnlkK8nQWVIzwOV4GoR/+cwxIk3m2UXk
         k0MU7p+eVUt9V0YdxGds9aDphutXFCm2aCrL3lN2mlc0oAjq0xD2AF0dLrzLXnShKvSm
         0ZMnTxU/bbATwUbsAbguZi/R7Kb3AXTO7hNlP1XfKwtUxmb5pzuMXjCMZy+slt4uqjZe
         k4HM8lKAusp8Re0TtDEvCDTfgNi1mk3E/l+7jtOlme3o+PgSvQuDP3qxcA0wxwc2Mg3V
         FhMg==
X-Gm-Message-State: AOAM532NtWfq2P2MIiYkprq4BbdSo5gJD+6/ZeKAeWD4ZYoyj+bsb49O
        h4HngvzblubFI2d5UORMdIEYQUIdRB11oYKRoeI=
X-Google-Smtp-Source: ABdhPJywTGZ4w/J1sSGzB3FdLe2U6s7jl6eM8dYJ1t37d8sqJVuedTf1zJiXfD23yXRU2TQ0OwJmlPrunvJlw7Oeypo=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr16245941yba.225.1631902093248;
 Fri, 17 Sep 2021 11:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061020.821711-1-andrii@kernel.org> <20210917061020.821711-6-andrii@kernel.org>
 <YUTQHir6qZZHUNZm@google.com>
In-Reply-To: <YUTQHir6qZZHUNZm@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 11:08:02 -0700
Message-ID: <CAEf4Bzb7hD6kYKaS7CnMbPsZ1wfqLOY-DX4RAFTAwwdmzMT1ig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/9] libbpf: reduce reliance of attach_fns on
 sec_def internals
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 10:28 AM <sdf@google.com> wrote:
>
> On 09/16, Andrii Nakryiko wrote:
> > Move closer to not relying on bpf_sec_def internals that won't be part
> > of public API, when pluggable SEC() handlers will be allowed. Drop
> > pre-calculated prefix length, and in various helpers don't rely on this
> > prefix length availability. Also minimize reliance on knowing
> > bpf_sec_def's prefix for few places where section prefix shortcuts are
> > supported (e.g., tp vs tracepoint, raw_tp vs raw_tracepoint).
>
> > Given checking some string for having a given string-constant prefix is
> > such a common operation and so annoying to be done with pure C code, add
> > a small macro helper, str_has_pfx(), and reuse it throughout libbpf.c
> > where prefix comparison is performed. With __builtin_constant_p() it's
> > possible to have a convenient helper that checks some string for having
> > a given prefix, where prefix is either string literal (or compile-time
> > known string due to compiler optimization) or just a runtime string
> > pointer, which is quite convenient and saves a lot of typing and string
> > literal duplication.
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c          | 41 ++++++++++++++++++---------------
> >   tools/lib/bpf/libbpf_internal.h |  7 ++++++
> >   2 files changed, 30 insertions(+), 18 deletions(-)
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8ab2edbf7a3b..52c398fae0af 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -226,7 +226,6 @@ typedef struct bpf_link *(*attach_fn_t)(const struct
> > bpf_program *prog, long coo
>
> >   struct bpf_sec_def {
> >       const char *sec;
> > -     size_t len;
> >       enum bpf_prog_type prog_type;
> >       enum bpf_attach_type expected_attach_type;
> >       bool is_exp_attach_type_optional;
> > @@ -1671,7 +1670,7 @@ static int bpf_object__process_kconfig_line(struct
> > bpf_object *obj,
> >       void *ext_val;
> >       __u64 num;
>
> > -     if (strncmp(buf, "CONFIG_", 7))
> > +     if (!str_has_pfx(buf, "CONFIG_"))
> >               return 0;
>
> >       sep = strchr(buf, '=');
> > @@ -2919,7 +2918,7 @@ static Elf_Data *elf_sec_data(const struct
> > bpf_object *obj, Elf_Scn *scn)
> >   static bool is_sec_name_dwarf(const char *name)
> >   {
> >       /* approximation, but the actual list is too long */
> > -     return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
> > +     return str_has_pfx(name, ".debug_");
> >   }
>
> >   static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
> > @@ -2941,7 +2940,7 @@ static bool ignore_elf_section(GElf_Shdr *hdr,
> > const char *name)
> >       if (is_sec_name_dwarf(name))
> >               return true;
>
> > -     if (strncmp(name, ".rel", sizeof(".rel") - 1) == 0) {
> > +     if (str_has_pfx(name, ".rel")) {
> >               name += sizeof(".rel") - 1;
> >               /* DWARF section relocations */
> >               if (is_sec_name_dwarf(name))
> > @@ -6890,8 +6889,7 @@ static int bpf_object__resolve_externs(struct
> > bpf_object *obj,
> >                       if (err)
> >                               return err;
> >                       pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
> > -             } else if (ext->type == EXT_KCFG &&
> > -                        strncmp(ext->name, "CONFIG_", 7) == 0) {
> > +             } else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_"))
> > {
> >                       need_config = true;
> >               } else if (ext->type == EXT_KSYM) {
> >                       if (ext->ksym.type_id)
> > @@ -7955,7 +7953,6 @@ void bpf_program__set_expected_attach_type(struct
> > bpf_program *prog,
> >                         attachable, attach_btf)                           \
> >       {                                                                   \
> >               .sec = string,                                              \
> > -             .len = sizeof(string) - 1,                                  \
> >               .prog_type = ptype,                                         \
> >               .expected_attach_type = eatype,                             \
> >               .is_exp_attach_type_optional = eatype_optional,             \
> > @@ -7986,7 +7983,6 @@ void bpf_program__set_expected_attach_type(struct
> > bpf_program *prog,
>
> >   #define SEC_DEF(sec_pfx, ptype, ...) {                                          \
> >       .sec = sec_pfx,                                                     \
> > -     .len = sizeof(sec_pfx) - 1,                                         \
> >       .prog_type = BPF_PROG_TYPE_##ptype,                                 \
> >       .preload_fn = libbpf_preload_prog,                                  \
> >       __VA_ARGS__                                                         \
> > @@ -8160,10 +8156,8 @@ static const struct bpf_sec_def
> > *find_sec_def(const char *sec_name)
> >       int i, n = ARRAY_SIZE(section_defs);
>
> >       for (i = 0; i < n; i++) {
> > -             if (strncmp(sec_name,
> > -                         section_defs[i].sec, section_defs[i].len))
> > -                     continue;
> > -             return &section_defs[i];
> > +             if (str_has_pfx(sec_name, section_defs[i].sec))
> > +                     return &section_defs[i];
> >       }
> >       return NULL;
> >   }
> > @@ -8517,7 +8511,7 @@ static int libbpf_find_attach_btf_id(struct
> > bpf_program *prog, int *btf_obj_fd,
> >                       prog->sec_name);
> >               return -ESRCH;
> >       }
> > -     attach_name = prog->sec_name + prog->sec_def->len;
> > +     attach_name = prog->sec_name + strlen(prog->sec_def->sec);
>
> >       /* BPF program's BTF ID */
> >       if (attach_prog_fd) {
> > @@ -9454,8 +9448,11 @@ static struct bpf_link *attach_kprobe(const struct
> > bpf_program *prog, long cooki
> >       char *func;
> >       int n, err;
>
> > -     func_name = prog->sec_name + prog->sec_def->len;
> > -     opts.retprobe = strcmp(prog->sec_def->sec, "kretprobe/") == 0;
> > +     opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
> > +     if (opts.retprobe)
> > +             func_name = prog->sec_name + sizeof("kretprobe/") - 1;
> > +     else
> > +             func_name = prog->sec_name + sizeof("kprobe/") - 1;
>
> >       n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
> >       if (n < 1) {
> > @@ -9627,8 +9624,11 @@ static struct bpf_link *attach_tp(const struct
> > bpf_program *prog, long cookie)
> >       if (!sec_name)
> >               return libbpf_err_ptr(-ENOMEM);
>
> > -     /* extract "tp/<category>/<name>" */
> > -     tp_cat = sec_name + prog->sec_def->len;
> > +     /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
> > +     if (str_has_pfx(prog->sec_name, "tp/"))
> > +             tp_cat = sec_name + sizeof("tp/") - 1;
> > +     else
> > +             tp_cat = sec_name + sizeof("tracepoint/") - 1;
> >       tp_name = strchr(tp_cat, '/');
> >       if (!tp_name) {
> >               free(sec_name);
> > @@ -9674,7 +9674,12 @@ struct bpf_link
> > *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
>
> >   static struct bpf_link *attach_raw_tp(const struct bpf_program *prog,
> > long cookie)
> >   {
> > -     const char *tp_name = prog->sec_name + prog->sec_def->len;
> > +     const char *tp_name;
> > +
> > +     if (str_has_pfx(prog->sec_name, "raw_tp/"))
> > +             tp_name = prog->sec_name + sizeof("raw_tp/") - 1;
> > +     else
> > +             tp_name = prog->sec_name + sizeof("raw_tracepoint/") - 1;
>
> >       return bpf_program__attach_raw_tracepoint(prog, tp_name);
> >   }
> > diff --git a/tools/lib/bpf/libbpf_internal.h
> > b/tools/lib/bpf/libbpf_internal.h
> > index ceb0c98979bc..ec79400517d4 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -89,6 +89,13 @@
> >       (offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
> >   #endif
>
> > +/* Check whether a string `str` has prefix `pfx`, regardless if `pfx` is
> > + * a string literal known at compilation time or char * pointer known
> > only at
> > + * runtime.
> > + */
> > +#define str_has_pfx(str, pfx) \
> > +     (strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 :
> > strlen(pfx)) == 0)
> > +
>
> Nit: maybe 'starts_with'? c++ has that in stdlib and iirc python also
> has either starts_with or statswith.

And C has strcmp, strncmp, strstr... I didn't want to do strpfxcmp or
something like that, but it also doesn't matter as it's an internal
helper. "starts_with" doesn't communicate that we are dealing with
strings and not just some arrays of elements. So I'd rather keep it
named as is.
