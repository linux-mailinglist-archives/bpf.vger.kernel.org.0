Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1D573CD5
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGMS5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiGMS5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:57:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A42F3A0
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:57:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso5089072pjj.5
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBqb35Lwyeh6mNL6btULzQkOSlggDCgbHp8LiPpOlpQ=;
        b=Y7PQXLimbfFoEi4Ltd7IOyF9dzSaU9NhT4QYXV7MQahSTwFv8ofdvvsszRXe8kSnPa
         EQqP7pQjJCZ2id4YpJ0d9LA4kVcxzHytOSwBIliVdP0lO/fXMl6wazURNapmSOHxyIjZ
         EmkKl60RJXWspad5XRbryhnrHmGH94x7ZoZf86GEKeHuZLX/1lsUJE6DJ7F30KrCkyal
         zcQSXL/uA6+y08MIR5hbiVrtKKt0qWLJmzGHh/ejrCSSOq/7/MgaRIKxDv63gowTJ5hC
         z3rQrRKOymbsPthMOil3+xUg4WWRw1sD9qdXvDtXjgGTZOlF9pc3k3S1KU2dcF9aBfC7
         vFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBqb35Lwyeh6mNL6btULzQkOSlggDCgbHp8LiPpOlpQ=;
        b=fSMCpqmEXJCUXxkdV5EEyq29E5/WyeDGM4tPteSXDclNTdz5XL89WPcfIjtdOrU/L4
         BOcqXl85eq34VIq9RQvapbe4XXCq3JWHqLi6le1LUNgQpS6E3Q3fk2QfA1oKdELgqEEM
         wwgpw+7FfJu0oU4bEWOs8X/xM6Tv5Mt7b52J3boRlMcyg3AuIZVCfZfe+ukGJMrQLgLM
         wf9sPyaZQULAuCEyuGX8iKEhF/ygARh3Rlz9kgEXFxNHc70eEkfBfqfaPOho15LN2kNt
         oFjHw3Na4Uuv/z+eTtATUlI96vK+QOXn617WCFHLeCsTbJ7jwOF2lLEWzu1sPDCaUDVy
         CNeA==
X-Gm-Message-State: AJIora8E7hhUY9AZz8QXTs17tl8nvqP3+YyGNABEy93ZVJI+PoBro1zI
        9Us7W5fBDZ/PesSKrcyAwSYsyRDG3n7rahDxSuJBfQ==
X-Google-Smtp-Source: AGRyM1u5gVc+SxJ5YeStPgSPDfExfM/wby7rS0Xlbb1W6eFrUbqFnASpPkaz/iXb8P/k44rnB9Qrihql1xSb6V9rs6w=
X-Received: by 2002:a17:90b:4b4d:b0:1ef:bff5:de4f with SMTP id
 mi13-20020a17090b4b4d00b001efbff5de4fmr11648706pjb.120.1657738665789; Wed, 13
 Jul 2022 11:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-2-andrii@kernel.org>
 <Ys7xxbyYWhrqsQka@google.com> <CAEf4BzYUVD2F9Hrn4SgYHcjX=UA5G=57Uw9+uH9P6oJ3X0xbdQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYUVD2F9Hrn4SgYHcjX=UA5G=57Uw9+uH9P6oJ3X0xbdQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 11:57:34 -0700
Message-ID: <CAKH8qBtGNyk1HXNjNjw9owCsRSTutOyBDsmGrwSXu7wE2PspQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs
 and use it for USDT
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 11:08 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 9:24 AM <sdf@google.com> wrote:
> >
> > On 07/12, Andrii Nakryiko wrote:
> > > Libbpf supports single virtual __kconfig extern currently:
> > > LINUX_KERNEL_VERSION.
> > > LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
> > > customly filled out by libbpf.
> >
> > > This patch generalizes this approach to support more such virtual
> > > __kconfig externs. One such extern added in this patch is
> > > LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
> > > usdt.bpf.h instead of using CO-RE-based enum detection approach for
> > > detecting bpf_get_attach_cookie() BPF helper. This allows to remove
> > > otherwise not needed CO-RE dependency and keeps user-space and BPF-side
> > > parts of libbpf's USDT support strictly in sync in terms of their
> > > feature detection.
> >
> > > We'll use similar approach for syscall wrapper detection for
> > > BPF_KSYSCALL() BPF-side macro in follow up patch.
> >
> > > Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
> > > and LINUX_ for virtual libbpf-backed externs. In the future we might
> > > extend the set of prefixes that are supported. This can be done without
> > > any breaking changes, as currently any __kconfig extern with
> > > unrecognized name is rejected.
> >
> > > For LINUX_xxx externs we support the normal "weak rule": if libbpf
> > > doesn't recognize given LINUX_xxx extern but such extern is marked as
> > > __weak, it is not rejected and defaults to zero.  This follows
> > > CONFIG_xxx handling logic and will allow BPF applications to
> > > opportunistically use newer libbpf virtual externs without breaking on
> > > older libbpf versions unnecessarily.
> >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >   tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
> > >   tools/lib/bpf/usdt.bpf.h | 16 ++--------
> > >   2 files changed, 52 insertions(+), 33 deletions(-)
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index cb49408eb298..4bae67767f82 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -1800,11 +1800,18 @@ static bool is_kcfg_value_in_range(const struct
> > > extern_desc *ext, __u64 v)
> > >   static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
> > >                             __u64 value)
> > >   {
> > > -     if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> > > -             pr_warn("extern (kcfg) %s=%llu should be integer\n",
> > > +     if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR &&
> > > +         ext->kcfg.type != KCFG_BOOL) {
> > > +             pr_warn("extern (kcfg) %s=%llu should be integer, char or boolean\n",
> > >                       ext->name, (unsigned long long)value);
> > >               return -EINVAL;
> > >       }
> > > +     if (ext->kcfg.type == KCFG_BOOL && value > 1) {
> > > +             pr_warn("extern (kcfg) %s=%llu value isn't boolean\n",
> > > +                     ext->name, (unsigned long long)value);
> > > +             return -EINVAL;
> > > +
> > > +     }
> > >       if (!is_kcfg_value_in_range(ext, value)) {
> > >               pr_warn("extern (kcfg) %s=%llu value doesn't fit in %d bytes\n",
> > >                       ext->name, (unsigned long long)value, ext->kcfg.sz);
> > > @@ -1870,10 +1877,13 @@ static int
> > > bpf_object__process_kconfig_line(struct bpf_object *obj,
> > >               /* assume integer */
> > >               err = parse_u64(value, &num);
> > >               if (err) {
> > > -                     pr_warn("extern (kcfg) %s=%s should be integer\n",
> > > -                             ext->name, value);
> > > +                     pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
> > >                       return err;
> > >               }
> > > +             if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> > > +                     pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
> > > +                     return -EINVAL;
> > > +             }
> > >               err = set_kcfg_value_num(ext, ext_val, num);
> > >               break;
> > >       }
> > > @@ -7493,26 +7503,47 @@ static int bpf_object__resolve_externs(struct
> > > bpf_object *obj,
> > >       for (i = 0; i < obj->nr_extern; i++) {
> > >               ext = &obj->externs[i];
> >
> > > -             if (ext->type == EXT_KCFG &&
> > > -                 strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> > > -                     void *ext_val = kcfg_data + ext->kcfg.data_off;
> > > -                     __u32 kver = get_kernel_version();
> > > +             if (ext->type == EXT_KSYM) {
> > > +                     if (ext->ksym.type_id)
> > > +                             need_vmlinux_btf = true;
> > > +                     else
> > > +                             need_kallsyms = true;
> > > +                     continue;
> > > +             } else if (ext->type == EXT_KCFG) {
> > > +                     void *ext_ptr = kcfg_data + ext->kcfg.data_off;
> > > +                     __u64 value = 0;
> > > +
> > > +                     /* Kconfig externs need actual /proc/config.gz */
> > > +                     if (str_has_pfx(ext->name, "CONFIG_")) {
> > > +                             need_config = true;
> > > +                             continue;
> > > +                     }
> >
> > > -                     if (!kver) {
> > > -                             pr_warn("failed to get kernel version\n");
> > > +                     /* Virtual kcfg externs are customly handled by libbpf */
> > > +                     if (strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> > > +                             value = get_kernel_version();
> > > +                             if (!value) {
> > > +                                     pr_warn("extern (kcfg) '%s': failed to get kernel version\n",
> > > ext->name);
> > > +                                     return -EINVAL;
> > > +                             }
> > > +                     } else if (strcmp(ext->name, "LINUX_HAS_BPF_COOKIE") == 0) {
> > > +                             value = kernel_supports(obj, FEAT_BPF_COOKIE);
> > > +                     } else if (!str_has_pfx(ext->name, "LINUX_") || !ext->is_weak) {
> > > +                             /* Currently libbpf supports only CONFIG_ and LINUX_ prefixed
> > > +                              * __kconfig externs, where LINUX_ ones are virtual and filled out
> > > +                              * customly by libbpf (their values don't come from Kconfig).
> > > +                              * If LINUX_xxx variable is not recognized by libbpf, but is marked
> > > +                              * __weak, it defaults to zero value, just like for CONFIG_xxx
> > > +                              * externs.
> > > +                              */
> > > +                             pr_warn("extern (kcfg) '%s': unrecognized virtual extern\n",
> > > ext->name);
> > >                               return -EINVAL;
> > >                       }
> > > -                     err = set_kcfg_value_num(ext, ext_val, kver);
> > > +
> > > +                     err = set_kcfg_value_num(ext, ext_ptr, value);
> > >                       if (err)
> > >                               return err;
> > > -                     pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
> > > -             } else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_"))
> > > {
> > > -                     need_config = true;
> > > -             } else if (ext->type == EXT_KSYM) {
> > > -                     if (ext->ksym.type_id)
> > > -                             need_vmlinux_btf = true;
> > > -                     else
> > > -                             need_kallsyms = true;
> > > +                     pr_debug("extern (kcfg) %s=0x%llx\n", ext->name, (long long)value);
> > >               } else {
> > >                       pr_warn("unrecognized extern '%s'\n", ext->name);
> > >                       return -EINVAL;
> > > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > > index 4181fddb3687..4f2adc0bd6ca 100644
> > > --- a/tools/lib/bpf/usdt.bpf.h
> > > +++ b/tools/lib/bpf/usdt.bpf.h
> > > @@ -6,7 +6,6 @@
> > >   #include <linux/errno.h>
> > >   #include <bpf/bpf_helpers.h>
> > >   #include <bpf/bpf_tracing.h>
> > > -#include <bpf/bpf_core_read.h>
> >
> > >   /* Below types and maps are internal implementation details of libbpf's
> > > USDT
> > >    * support and are subjects to change. Also, bpf_usdt_xxx() API helpers
> > > should
> > > @@ -30,14 +29,6 @@
> > >   #ifndef BPF_USDT_MAX_IP_CNT
> > >   #define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
> > >   #endif
> > > -/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This
> > > is
> > > - * the only dependency on CO-RE, so if it's undesirable, user can
> > > override
> > > - * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported
> > > or not.
> > > - */
> > > -#ifndef BPF_USDT_HAS_BPF_COOKIE
> > > -#define BPF_USDT_HAS_BPF_COOKIE \
> > > -     bpf_core_enum_value_exists(enum bpf_func_id___usdt,
> > > BPF_FUNC_get_attach_cookie___usdt)
> > > -#endif
> >
> > >   enum __bpf_usdt_arg_type {
> > >       BPF_USDT_ARG_CONST,
> > > @@ -83,15 +74,12 @@ struct {
> > >       __type(value, __u32);
> > >   } __bpf_usdt_ip_to_spec_id SEC(".maps") __weak;
> >
> > > -/* don't rely on user's BPF code to have latest definition of
> > > bpf_func_id */
> > > -enum bpf_func_id___usdt {
> > > -     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > > -};
> > > +extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
> >
> > Could _Bool be a problem when used by c++? I remember that we can have
> > sizeof(bool) != sizeof(_Bool) when compiling with g++. If we were to
> > use 'int' instead I'm assuming we'll loose all the niceties of
> > KCFG_BOOL?
> >
> > Or shouldn't be a problem since it's not part of C/C++ api boundary?
>
> I actually don't know if C++ supports "_Bool", but in C, "bool" is an
> alias to _Bool. _Bool is *the type* of the boolean. The benefit of
> _Bool is that it doesn't require including stdbool.h, while "bool"
> itself needs extra header. So I try not to use bool in libbpf BPF API
> headers just to avoid extra header dependencies.
>
> But it shouldn't matter as this is BPF-side code, so it has to be
> compiled in C mode by Clang/GCC, so _Bool should always be there.

The program is fine, but these _Bool's can now leak into generated
skeletons, right?
And skeletons might be included into c++ and I'm not sure what happens
with _Bool over there.

My naive attempt to use it gives me the following:

$ cat tst.cc
int main(int argc, char *argv[])
{
    _Bool have_args = argc > 1;
    if (have_args)
        return 1;
    else
        return 0;
}
$ clang++ tst.cc
tst.cc:3:5: error: unknown type name '_Bool'
    _Bool have_args = argc > 1;
    ^
1 error generated.

> As for the size it seems like it's not even specified by the standard
> that sizeof(bool/_Bool) is 1, though it is in practice. I only
> remember some very-very-very old versions of Microsoft's Visual C++
> having sizeof(bool) == 4, but then they changed that anyways to
> sizeof(bool) == 1 (it was many-many years ago, so it might be an
> incomplete story).
>
> But either way it doesn't matter, because libbpf will support any
> size: 1, 2, 4, 8 and will just set 1 for true, 0 for false, with
> correct zero extension to match variable size.
>
> As for bool vs int, no real difference, but it is true/false
> conceptually, so seems cleaner to use bool. But using int will work
> just fine here as well (you still get 0 or 1 for both, effectively).

Yeah, so my question is more like: rather than trying to figure out if
_Bool is safe, might it be easier to stick to ints?


> > >   static __always_inline
> > >   int __bpf_usdt_spec_id(struct pt_regs *ctx)
> > >   {
> > > -     if (!BPF_USDT_HAS_BPF_COOKIE) {
> > > +     if (!LINUX_HAS_BPF_COOKIE) {
> > >               long ip = PT_REGS_IP(ctx);
> > >               int *spec_id_ptr;
> >
> > > --
> > > 2.30.2
> >
