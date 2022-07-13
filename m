Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38A573C50
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiGMSCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMSCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:02:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270A286FC
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:02:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so21186824eju.10
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3t0WYk6CvCQy6+b/TCObf89DcBnCemuE7zADBlw59I=;
        b=dLe5IVtw5oa2Vq3QpHHFoSrUds5qquBK1J4rEKatxcL5478uIhwJxWOCaurYjeubtr
         7ewrRBFOUYt/YbpOiexU7EnrTGDo9ddMNJa3XVWnyqp+c4HZuEgLXKlSWwLhtsrftkcW
         FeIx4QodQu5OjttmTdZNDSm3xsKxTJmau4udQhmDWpz7RkRx8dBTuDS1yih7hWGaOfFj
         B1AjfEpB0yDYxuYrJRx3YxTAcevVtqaT5KPFwQfyOsjT3QW/NK4efSmVIXkougge5wr2
         UL2ngcgsgVSxpSNHvSqs21aQUX9YMB0lt7aSlW8NiR+syWu4BN1JMDp8WxJrM+IYA1Zy
         ZoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3t0WYk6CvCQy6+b/TCObf89DcBnCemuE7zADBlw59I=;
        b=QvnmAWE0T8x9ZitfxGg/BGYd/bJ14EiK4rTOTI54g6S+nD4dx+AOx2LTrwycP+QCYs
         c/UlP/q+vn1OMAmdZxJ2oqqcxEhg2Le4MNq09zoXaRsvl1zm09auIU/E95d7MWR6c2dU
         LUkNCus0w+PzMYfPuwyjXEBV9V1h5I90gnxH0XIZwFZs2Eyx/K9Jl0hqv2oPHegWU+sp
         zCgf+IV2qd3+FHGzoxLcoqF6ZXgTD1I0DVObHmL4/5qJM3WBhx0cezgcWDhSMaZhWOCH
         qirQMKYqGq/D7ioCr81ANaJF2paCNTuzSc5VRa3O0SVo9MYcfxmVo6PflRGdMDPZCi5s
         gOVg==
X-Gm-Message-State: AJIora/6haHAnCdtwNDbfszHKAmHGjH3hqpWFCuCLSwwZeNlm6m9Qxq6
        g9JKGizAsEutp64claMB3Ky+ke3cxF1N7fOEz7c=
X-Google-Smtp-Source: AGRyM1vYb1uCPwPRewihv24PO1YVB1a7qstbIm/LU24d/QyGlQZQNTDs1x1wOFzG8+6NLRpozQEp/1C5zqOgEiEsDxU=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr4549890ejc.115.1657735333941; Wed, 13
 Jul 2022 11:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-2-andrii@kernel.org>
 <f748ace1-f3fb-2525-ee3f-5fb6c564fe2d@oracle.com>
In-Reply-To: <f748ace1-f3fb-2525-ee3f-5fb6c564fe2d@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 11:02:02 -0700
Message-ID: <CAEf4BzbxeGHNJ8KuaPCFsN5-YHCeXmULpHVHZt9TpYRp1JSdJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs
 and use it for USDT
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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

On Wed, Jul 13, 2022 at 8:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 13/07/2022 02:53, Andrii Nakryiko wrote:
> > Libbpf supports single virtual __kconfig extern currently: LINUX_KERNEL_VERSION.
> > LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
> > customly filled out by libbpf.
> >
> > This patch generalizes this approach to support more such virtual
> > __kconfig externs. One such extern added in this patch is
> > LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
> > usdt.bpf.h instead of using CO-RE-based enum detection approach for
> > detecting bpf_get_attach_cookie() BPF helper. This allows to remove
> > otherwise not needed CO-RE dependency and keeps user-space and BPF-side
> > parts of libbpf's USDT support strictly in sync in terms of their
> > feature detection.
> >
> > We'll use similar approach for syscall wrapper detection for
> > BPF_KSYSCALL() BPF-side macro in follow up patch.
> >
> > Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
> > and LINUX_ for virtual libbpf-backed externs. In the future we might
> > extend the set of prefixes that are supported. This can be done without
> > any breaking changes, as currently any __kconfig extern with
> > unrecognized name is rejected.
> >
> > For LINUX_xxx externs we support the normal "weak rule": if libbpf
> > doesn't recognize given LINUX_xxx extern but such extern is marked as
> > __weak, it is not rejected and defaults to zero.  This follows
> > CONFIG_xxx handling logic and will allow BPF applications to
> > opportunistically use newer libbpf virtual externs without breaking on
> > older libbpf versions unnecessarily.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Tested the v1 patch series on arm64, all works well, so feel free to add

oh, cool, ignore my last message on your RFC reply then :)

>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>
>
> ...for the series.
>
> I really like the concept of extending LINUX_ kconfig values.
> A few nits, but looks great!
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
> >  tools/lib/bpf/usdt.bpf.h | 16 ++--------
> >  2 files changed, 52 insertions(+), 33 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index cb49408eb298..4bae67767f82 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1800,11 +1800,18 @@ static bool is_kcfg_value_in_range(const struct extern_desc *ext, __u64 v)
> >  static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
> >                             __u64 value)
> >  {
> > -     if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> > -             pr_warn("extern (kcfg) %s=%llu should be integer\n",
> > +     if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR &&
> > +         ext->kcfg.type != KCFG_BOOL) {
> > +             pr_warn("extern (kcfg) %s=%llu should be integer, char or boolean\n",
> >                       ext->name, (unsigned long long)value);
> >               return -EINVAL;
> >       }
> > +     if (ext->kcfg.type == KCFG_BOOL && value > 1) {
> > +             pr_warn("extern (kcfg) %s=%llu value isn't boolean\n",
>
> most warnings sem to conform to the format
>
>                 pr_warn("extern (kcfg) '%s'; value '%llu' isn't boolean\n",
>
> I find that a bit clearer but subjective I realize...

yeah, this was a bit older format, but I can update all such use cases
as well, just didn't want to distract from main changes

>
> > +                     ext->name, (unsigned long long)value);
> > +             return -EINVAL;
> > +
> > +     }
> >       if (!is_kcfg_value_in_range(ext, value)) {
> >               pr_warn("extern (kcfg) %s=%llu value doesn't fit in %d bytes\n",
> >                       ext->name, (unsigned long long)value, ext->kcfg.sz);
> > @@ -1870,10 +1877,13 @@ static int bpf_object__process_kconfig_line(struct bpf_object *obj,
> >               /* assume integer */
> >               err = parse_u64(value, &num);
> >               if (err) {
> > -                     pr_warn("extern (kcfg) %s=%s should be integer\n",
> > -                             ext->name, value);
> > +                     pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
> >                       return err;
> >               }
> > +             if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> > +                     pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
>
> I think the logic here is meant to support a KCONFIG_CHAR value that is expressed as an
> integer; if I've got this right would the error message read better as something like
>
>                         pr_warn("extern (kcfg) '%s': '%s' isn't an integer value\n", ext->name, value);

yeah, makes sense. and yes about KCFG_CHAR (char in general is this
weird hybrid integer/character type, but what can we do)

>
> > +                     return -EINVAL;
> > +             }
> >               err = set_kcfg_value_num(ext, ext_val, num);
> >               break;
> >       }
> > @@ -7493,26 +7503,47 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
> >       for (i = 0; i < obj->nr_extern; i++) {
> >               ext = &obj->externs[i];
> >
> > -             if (ext->type == EXT_KCFG &&
> > -                 strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> > -                     void *ext_val = kcfg_data + ext->kcfg.data_off;
> > -                     __u32 kver = get_kernel_version();
> > +             if (ext->type == EXT_KSYM) {
> > +                     if (ext->ksym.type_id)
> > +                             need_vmlinux_btf = true;
> > +                     else
> > +                             need_kallsyms = true;
> > +                     continue;
> > +             } else if (ext->type == EXT_KCFG) {
> > +                     void *ext_ptr = kcfg_data + ext->kcfg.data_off;
> > +                     __u64 value = 0;
> > +
> > +                     /* Kconfig externs need actual /proc/config.gz */
> > +                     if (str_has_pfx(ext->name, "CONFIG_")) {
> > +                             need_config = true;
> > +                             continue;
> > +                     }
> >
> > -                     if (!kver) {
> > -                             pr_warn("failed to get kernel version\n");
> > +                     /* Virtual kcfg externs are customly handled by libbpf */
> > +                     if (strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> > +                             value = get_kernel_version();
> > +                             if (!value) {
> > +                                     pr_warn("extern (kcfg) '%s': failed to get kernel version\n", ext->name);
> > +                                     return -EINVAL;
> > +                             }
> > +                     } else if (strcmp(ext->name, "LINUX_HAS_BPF_COOKIE") == 0) {
> > +                             value = kernel_supports(obj, FEAT_BPF_COOKIE);
> > +                     } else if (!str_has_pfx(ext->name, "LINUX_") || !ext->is_weak) {
> > +                             /* Currently libbpf supports only CONFIG_ and LINUX_ prefixed
> > +                              * __kconfig externs, where LINUX_ ones are virtual and filled out
> > +                              * customly by libbpf (their values don't come from Kconfig).
> > +                              * If LINUX_xxx variable is not recognized by libbpf, but is marked
> > +                              * __weak, it defaults to zero value, just like for CONFIG_xxx
> > +                              * externs.
> > +                              */
> > +                             pr_warn("extern (kcfg) '%s': unrecognized virtual extern\n", ext->name);
> >                               return -EINVAL;
> >                       }
> > -                     err = set_kcfg_value_num(ext, ext_val, kver);
> > +
> > +                     err = set_kcfg_value_num(ext, ext_ptr, value);
> >                       if (err)
> >                               return err;
> > -                     pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
> > -             } else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_")) {
> > -                     need_config = true;
> > -             } else if (ext->type == EXT_KSYM) {
> > -                     if (ext->ksym.type_id)
> > -                             need_vmlinux_btf = true;
> > -                     else
> > -                             need_kallsyms = true;
> > +                     pr_debug("extern (kcfg) %s=0x%llx\n", ext->name, (long long)value);
>
> nit: should we use "extern (kcfg) '%s'=" as above to be consistent with warning messages?
>

will update


> >               } else {
> >                       pr_warn("unrecognized extern '%s'\n", ext->name);
> >                       return -EINVAL;
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > index 4181fddb3687..4f2adc0bd6ca 100644
> > --- a/tools/lib/bpf/usdt.bpf.h
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -6,7 +6,6 @@
> >  #include <linux/errno.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <bpf/bpf_core_read.h>
> >
> >  /* Below types and maps are internal implementation details of libbpf's USDT
> >   * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
> > @@ -30,14 +29,6 @@
> >  #ifndef BPF_USDT_MAX_IP_CNT
> >  #define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
> >  #endif
> > -/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> > - * the only dependency on CO-RE, so if it's undesirable, user can override
> > - * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> > - */
> > -#ifndef BPF_USDT_HAS_BPF_COOKIE
> > -#define BPF_USDT_HAS_BPF_COOKIE \
> > -     bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> > -#endif
> >
> >  enum __bpf_usdt_arg_type {
> >       BPF_USDT_ARG_CONST,
> > @@ -83,15 +74,12 @@ struct {
> >       __type(value, __u32);
> >  } __bpf_usdt_ip_to_spec_id SEC(".maps") __weak;
> >
> > -/* don't rely on user's BPF code to have latest definition of bpf_func_id */
> > -enum bpf_func_id___usdt {
> > -     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > -};
> > +extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
> >
> >  static __always_inline
> >  int __bpf_usdt_spec_id(struct pt_regs *ctx)
> >  {
> > -     if (!BPF_USDT_HAS_BPF_COOKIE) {
> > +     if (!LINUX_HAS_BPF_COOKIE) {
> >               long ip = PT_REGS_IP(ctx);
> >               int *spec_id_ptr;
> >
> >
