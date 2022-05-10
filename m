Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD077522778
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiEJXSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 19:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiEJXSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 19:18:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38A266E25
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:18:15 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id o190so356218iof.10
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpGKwkeFozCJu+UJhgcXgQbGG4kB0Bnh1v4Es3on35c=;
        b=hExo+rv6GmVDfIlUgu81hjPSF5yqsViBdxjaMkNzg49VwNvM/x+w66Ca5vuG6lTHcM
         bzR2NMrc7wMnMItwT/PVFZxOBwxojaZ8jN5lIbybNdj0m+l9FbywIoi6AQkpBFYN4eSl
         3pk4M4l6YpXkHlohPMnUNR7hq5BwAyr2eqjBSCJNw2JfUBDv+ZZ/cu8Vq7KnwS7mSZIy
         Alrs2DtwhMdbmVoZyuSZ2uLpOkyLtT37LPdZGx3hNLIRPcuJrfB4vPNC1TasoaCvavew
         xgzAp+WRqA8Y4yleDzaPlcDvID0hyQ7BAoEE2rANI+E/f0gK7SIaqeaWTne1HCcyf14x
         zQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpGKwkeFozCJu+UJhgcXgQbGG4kB0Bnh1v4Es3on35c=;
        b=WOcRd4T8S29NSRlbVooWdIw/cw9BhnN7g7NmbbEjUKA1OXiAxj6989wip0qFI2h7s7
         kDh4TJNJzNdv5K/VGipVW1Noh6ISudyV+0qUZlF5HLEXbB279NwTXxvIZFSZ2YxJjWSJ
         EMLjEISvTPxjaTDXD1udbkG7ttPlDf0CfjCDl4hlgFd2OwF9OR7Cl4zQIwMq+GuU+B/G
         JE+dwgaZRFklSVIPTy1QuHDa8hU/1EGgXXB9vJbUO9FInU8/Z/oo/hH6SN3B6Zb5RNiH
         boi80Qg1pqcySCmf4gOfrlNO7AB7YJ0niXQa7/r8mneQPmNgsMrbXAYsHrdm5SAgeXb2
         BHSg==
X-Gm-Message-State: AOAM5312pzEy6TSCiRLmB6HFViWOWgpPHjbTb234qV1KttyQkgczbCU0
        3tgcMU1aeWN5IIDMbTTgdjkxKTxStmXN2oumxRLrsXQ/Leo=
X-Google-Smtp-Source: ABdhPJyin9kMP9v5/gVPybDKAP0XeZlEDA5AsDiFo5pfzthDnhFXGwiy3bolRx5av91QbYayLfoP2GvPayjtwgEfSGQ=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr10968254jar.237.1652224694294; Tue, 10
 May 2022 16:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190007.2576808-1-yhs@fb.com>
 <CAEf4BzbqQDVsiaY1u5G6QAu_3Zq8Vn19qBkzuzVYX0T_e3OLSw@mail.gmail.com> <be27f832-c803-1ab0-2180-74bf7177ca41@fb.com>
In-Reply-To: <be27f832-c803-1ab0-2180-74bf7177ca41@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 16:18:03 -0700
Message-ID: <CAEf4BzZN-o+MnPsQ+3_MB+kxyUhmwGa2q9SqN_b6vE6dxsJv1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/12] bpf: Add btf enum64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 3:06 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/9/22 3:29 PM, Andrii Nakryiko wrote:
> > On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
> >> But in kernel, some enum indeed has 64bit values, e.g.,
> >> in uapi bpf.h, we have
> >>    enum {
> >>          BPF_F_INDEX_MASK                = 0xffffffffULL,
> >>          BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
> >>          BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
> >>    };
> >> In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
> >> as 0, which certainly is incorrect.
> >>
> >> This patch added a new btf kind, BTF_KIND_ENUM64, which permits
> >> 64bit value to cover the above use case. The BTF_KIND_ENUM64 has
> >> the following three bytes followed by the common type:
> >
> > you probably meant three fields, not bytes
>
> correct.
>
> >
> >>    struct bpf_enum64 {
> >>      __u32 nume_off;
> >>      __u32 hi32;
> >>      __u32 lo32;
> >
> > I'd like to nitpick on name here, as hi/lo of what? Maybe val_hi32 and
> > val_lo32? Can we also reverse the order here? For x86 you'll be able
> > to use &lo32 to get value directly if you really want, without a local
> > copy. It also just logically seems better to have something low first,
> > then high next.
>
> I can go with val_hi32, val_lo32 and put val_lo32 before val_hi32.
> I don't have any preference for the ordering of these two fields.
>
> >
> >
> >>    };
> >> Currently, btf type section has an alignment of 4 as all element types
> >> are u32. Representing the value with __u64 will introduce a pad
> >> for bpf_enum64 and may also introduce misalignment for the 64bit value.
> >> Hence, two members of hi32 and lo32 are chosen to avoid these issues.
> >>
> >> The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
> >> to indicate whether the value is signed or unsigned. The kflag intends
> >> to provide consistent output of BTF C fortmat with the original
> >> source code. For example, the original BTF_KIND_ENUM bit value is 0xffffffff.
> >> The format C has two choices, print out 0xffffffff or -1 and current libbpf
> >> prints out as unsigned value. But if the signedness is preserved in btf,
> >> the value can be printed the same as the original source code.
> >>
> >> The new BTF_KIND_ENUM64 is intended to support the enum value represented as
> >> 64bit value. But it can represent all BTF_KIND_ENUM values as well.
> >> The value size of BTF_KIND_ENUM64 is encoded to 8 to represent its intent.
> >> The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the value has
> >> to be represented with 64 bits.
> >>
> >>    [1] https://reviews.llvm.org/D124641
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   include/linux/btf.h            |  18 ++++-
> >>   include/uapi/linux/btf.h       |  17 ++++-
> >>   kernel/bpf/btf.c               | 132 ++++++++++++++++++++++++++++++---
> >>   tools/include/uapi/linux/btf.h |  17 ++++-
> >>   4 files changed, 168 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/btf.h b/include/linux/btf.h
> >> index 2611cea2c2b6..280c33c9414a 100644
> >> --- a/include/linux/btf.h
> >> +++ b/include/linux/btf.h
> >> @@ -174,7 +174,8 @@ static inline bool btf_type_is_small_int(const struct btf_type *t)
> >>
> >>   static inline bool btf_type_is_enum(const struct btf_type *t)
> >>   {
> >> -       return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
> >> +       return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM ||
> >> +              BTF_INFO_KIND(t->info) == BTF_KIND_ENUM64;
> >>   }
> >
> > a bit hesitant about this change, there is no helper to check for ENUM
> > vs ENUM64. Inside the kernel this change seems to be correct as we
> > don't care, but for libbpf I'd probably keep btf_is_enum() unchanged
> > (you can't really work with them in the same generic way in
> > user-space, as their memory layout is very different, so it's better
> > not to generalize them unnecessarily)
>
> Let me introduce a new helper called
> btf_type_is_any_enum(...) to check both
> BTF_KIND_ENUM or BTF_KIND_ENUM64.
>
> >
> >>
> >>   static inline bool str_is_empty(const char *s)
> >> @@ -192,6 +193,16 @@ static inline bool btf_is_enum(const struct btf_type *t)
> >>          return btf_kind(t) == BTF_KIND_ENUM;
> >>   }
> >>
> >> +static inline bool btf_is_enum64(const struct btf_type *t)
> >> +{
> >> +       return btf_kind(t) == BTF_KIND_ENUM64;
> >> +}
> >> +
> >> +static inline u64 btf_enum64_value(const struct btf_enum64 *e)
> >> +{
> >> +       return (u64)e->hi32 << 32 | e->lo32;
> >
> > this might be correct but () around bit shift would make it more obvious
>
> I can do this.
>
> >
> >> +}
> >> +
> >>   static inline bool btf_is_composite(const struct btf_type *t)
> >>   {
> >>          u16 kind = btf_kind(t);
> >> @@ -332,6 +343,11 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
> >>          return (struct btf_enum *)(t + 1);
> >>   }
> >>
> >> +static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
> >> +{
> >> +       return (struct btf_enum64 *)(t + 1);
> >> +}
> >> +
> >>   static inline const struct btf_var_secinfo *btf_type_var_secinfo(
> >>                  const struct btf_type *t)
> >>   {
> >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> >> index a9162a6c0284..2aac226a27b2 100644
> >> --- a/include/uapi/linux/btf.h
> >> +++ b/include/uapi/linux/btf.h
> >> @@ -36,10 +36,10 @@ struct btf_type {
> >>           * bits 24-28: kind (e.g. int, ptr, array...etc)
> >>           * bits 29-30: unused
> >>           * bit     31: kind_flag, currently used by
> >> -        *             struct, union and fwd
> >> +        *             struct, union, enum, fwd and enum64
> >
> > see comment below on kflag for enum itself, but reading this I
> > realized that we don't really describe the meaning of kind_flag for
> > different kinds. Should it be done here?
>
> We have detailed description in Documentation/bpf/btf.rst.
> Hopefully it will be enough if people wants to understand
> what kflag means for each kind.
>
>
> >
> >>           */
> >>          __u32 info;
> >> -       /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
> >> +       /* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
> >>           * "size" tells the size of the type it is describing.
> >>           *
> >>           * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> >> @@ -63,7 +63,7 @@ enum {
> >>          BTF_KIND_ARRAY          = 3,    /* Array        */
> >>          BTF_KIND_STRUCT         = 4,    /* Struct       */
> >>          BTF_KIND_UNION          = 5,    /* Union        */
> >> -       BTF_KIND_ENUM           = 6,    /* Enumeration  */
> >> +       BTF_KIND_ENUM           = 6,    /* Enumeration for int/unsigned int values */
> >
> > nit: "Enumeration for up to 32-bit values" ?
>
> This should work.
>
> >
> >>          BTF_KIND_FWD            = 7,    /* Forward      */
> >>          BTF_KIND_TYPEDEF        = 8,    /* Typedef      */
> >>          BTF_KIND_VOLATILE       = 9,    /* Volatile     */
> >> @@ -76,6 +76,7 @@ enum {
> >>          BTF_KIND_FLOAT          = 16,   /* Floating point       */
> >>          BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
> >>          BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */
> >> +       BTF_KIND_ENUM64         = 19,   /* Enumeration for long/unsigned long values */
> >
> > and then "for 64-bit values" (or maybe up to 64 bit values, but in
> > practice we won't do that, right?)
>
> We can do "up to 64-bit values". In practice, from llvm and pahole,
> we will only encode 64-bit values in ENUM64.
>
> >
> >>
> >>          NR_BTF_KINDS,
> >>          BTF_KIND_MAX            = NR_BTF_KINDS - 1,
> >> @@ -186,4 +187,14 @@ struct btf_decl_tag {
> >>          __s32   component_idx;
> >>   };
> >>
> >
> > [...]
> >
> >> @@ -3716,7 +3721,8 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
> >>
> >>                  if (env->log.level == BPF_LOG_KERNEL)
> >>                          continue;
> >> -               btf_verifier_log(env, "\t%s val=%d\n",
> >> +               fmt_str = btf_type_kflag(t) ? "\t%s val=%u\n" : "\t%s val=%d\n";
> >> +               btf_verifier_log(env, fmt_str,
> >>                                   __btf_name_by_offset(btf, enums[i].name_off),
> >>                                   enums[i].val);
> >>          }
> >> @@ -3757,7 +3763,10 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
> >>                  return;
> >>          }
> >>
> >> -       btf_show_type_value(show, "%d", v);
> >> +       if (btf_type_kflag(t))
> >
> > libbpf's assumption right now and most common case is unsigned enum,
> > so it seems more desirable to have kflag == 0 mean unsigned, with
> > kflag == 1 being signed. It will make most existing enum definitions
> > not change but also make it easy for libbpf's btf_dumper to use kflag
> > if it's set, but otherwise have the same unsigned printing whether
> > enum is really unsigned or Clang is too old to emit the kflag for
> > enum. WDYT?
>
> Right, libbpf assumption is unsigned enum and the kernel prints as
> signed. I agree that default unsigned should cover more cases.
> Will change that in the next revision.
>
> >
> >> +               btf_show_type_value(show, "%u", v);
> >> +       else
> >> +               btf_show_type_value(show, "%d", v);
> >
> > you didn't got with ternary operator for fmt string selector like in
> > previous case? I have mild preference for keeping it consistent (and
> > keeping btf_type_kflag(t) ? "fmt1" : "fmt2" inline)
>
> The reason I didn't do it is the line is a little long.
> But I can do it.
>
> >
> >>          btf_show_end_type(show);
> >>   }
> >>
> >> @@ -3770,6 +3779,109 @@ static struct btf_kind_operations enum_ops = {
> >>          .show = btf_enum_show,
> >>   };
> >>
> >> +static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
> >> +                                const struct btf_type *t,
> >> +                                u32 meta_left)
> >> +{
> >> +       const struct btf_enum64 *enums = btf_type_enum64(t);
> >> +       struct btf *btf = env->btf;
> >> +       const char *fmt_str;
> >> +       u16 i, nr_enums;
> >> +       u32 meta_needed;
> >> +
> >> +       nr_enums = btf_type_vlen(t);
> >> +       meta_needed = nr_enums * sizeof(*enums);
> >> +
> >> +       if (meta_left < meta_needed) {
> >> +               btf_verifier_log_basic(env, t,
> >> +                                      "meta_left:%u meta_needed:%u",
> >> +                                      meta_left, meta_needed);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (t->size != 8) {
> >
> > technically there is nothing wrong with using enum64 for smaller
> > sizes, right? Any particular reason to prevent this? We can just
> > define that 64-bit value is sign-extended if enum is signed and has
> > size < 8?
>
> My original idea is to support 64-bit enum only for ENUM64 kind.
> But it is certainly possible to encode 32-bit enums as well for
> ENUM64. So I will remove this restriction.
>
> The dwarf only generates sizes 4 (for up-to 32 bit values)
> and 8 (for 64 bit values). But BTF_KIND_ENUM supports 1/2/4/8
> sizes, so BTF_KIND_ENUM64 will also support 1/2/4/8 sizes.

Little known fact, but it's not true:

$ bpftool btf dump file /sys/kernel/btf/vmlinux| rg 'ENUM.*size=1' -A8
[83476] ENUM 'hub_led_mode' size=1 vlen=8
        'INDICATOR_AUTO' val=0
        'INDICATOR_CYCLE' val=1
        'INDICATOR_GREEN_BLINK' val=2
        'INDICATOR_GREEN_BLINK_OFF' val=3
        'INDICATOR_AMBER_BLINK' val=4
        'INDICATOR_AMBER_BLINK_OFF' val=5
        'INDICATOR_ALT_BLINK' val=6
        'INDICATOR_ALT_BLINK_OFF' val=7

Defined as packed enum:

enum hub_led_mode {
        INDICATOR_AUTO = 0,
        INDICATOR_CYCLE,
        /* software blinks for attention:  software, hardware, reserved */
        INDICATOR_GREEN_BLINK, INDICATOR_GREEN_BLINK_OFF,
        INDICATOR_AMBER_BLINK, INDICATOR_AMBER_BLINK_OFF,
        INDICATOR_ALT_BLINK, INDICATOR_ALT_BLINK_OFF
} __attribute__ ((packed));


>
> >
> >> +               btf_verifier_log_type(env, t, "Unexpected size");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* enum type either no name or a valid one */
> >> +       if (t->name_off &&
> >> +           !btf_name_valid_identifier(env->btf, t->name_off)) {
> >> +               btf_verifier_log_type(env, t, "Invalid name");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >
> > [...]
