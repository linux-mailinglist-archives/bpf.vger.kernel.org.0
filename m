Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460546F7320
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjEDTR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDTRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 15:17:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE652FE
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 12:17:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so1783513a12.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683227867; x=1685819867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiVwNFKWDWOn1UkI0gML1aYwrg/wMOgrftAeitrREg8=;
        b=OkWNSszxNrGpYxRzCTsJbLV72kk3SzJzlzlICyYAdwNLtyNgS4NO/WczRGZiP2DYkO
         NG6mPY0LgA9lx2siyLOadUOSWnqWTWiAguQ8/qre7d1I+C2T/+BnZatkyWI0Ev36tHb0
         oetpZ2qY4Yv5K2AP6kFC3wuRis3WFIY6YX+MYHT1ke9GEskgh25+8IbnUZxN9L/bpham
         Dh75s03BOlWK4vwJnZXFOvjW8PgiA3XeIzNbYe/5DAKpP0otUC03EZMvR40NYjPV26rO
         rIo9YH/N/9Ey6cq9nU6Q55KyX3Qy4Flkg+whbzeCDNZov8WxQ1qsRGNQeOGsEbnjuZl8
         y9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683227867; x=1685819867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiVwNFKWDWOn1UkI0gML1aYwrg/wMOgrftAeitrREg8=;
        b=M4BMWTX6aTINqu10BewOt8KcmDHYuXTdnCX5Vd0rxfgIuHt2hCm3yLk32wkwY99RuP
         v9CXuMoi9lIDAfwgpaEYHTl3vjipYbjzWdkLMAHKUWJqJQTkIw2hgX9OjhHqfZ7+xkZ2
         4put7ek5gmlY+ju8BKSQ2d1PKIqOd96wASd4jqbjzjDrgeLlTS3Jqh2P/LOsp3ncERI1
         eU3nxlAAIp0z7xEduEIbSQ27rXD9j2ZdQf/7UXk9bh8WoPSdJGn7a9OYbsovwxtVPgPP
         AiXui/2YvhfagQ8mEJyzhZAQDCwr/TcDggAR7IjHfS5AdcbeszeIqZogCWfCsaz0QLhR
         3TVw==
X-Gm-Message-State: AC+VfDzPOam9VyLLrOEZzdbfcbpB9S0TPi0OgBxigHsDhMIhXur/Xlcw
        VjYpJWVj09O/SiWAexTp1cOmifk+Yj+IN8iy9Vf9+cbm
X-Google-Smtp-Source: ACHHUZ7odsUbv/eeJqf/o/vFFGMAmmEvJssH2deFOcSBAlqRQSF8BLHUpXLxfaSyCIMAnz0X3MKRLOeSzv9UZ4vHxsY=
X-Received: by 2002:a17:907:3189:b0:94f:322d:909c with SMTP id
 xe9-20020a170907318900b0094f322d909cmr7183700ejb.34.1683227143113; Thu, 04
 May 2023 12:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-5-andrii@kernel.org>
 <20230504025537.dr32drbhiqxffgc7@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504025537.dr32drbhiqxffgc7@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 May 2023 12:05:31 -0700
Message-ID: <CAEf4BzYHr2Led1a2BwjwApU+KT+P9QgNUAaumnh+w8CmH39JvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: improve precision backtrack logging
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 3, 2023 at 7:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:05PM -0700, Andrii Nakryiko wrote:
> > Add helper to format register and stack masks in more human-readable
> > format. Adjust logging a bit during backtrack propagation and especiall=
y
> > during forcing precision fallback logic to make it clearer what's going
> > on (with log_level=3D2, of course), and also start reporting affected
> > frame depth. This is in preparation for having more than one active
> > frame later when precision propagation between subprog calls is added.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h                  |  13 ++-
> >  kernel/bpf/verifier.c                         |  72 ++++++++++--
> >  .../testing/selftests/bpf/verifier/precise.c  | 106 +++++++++---------
> >  3 files changed, 128 insertions(+), 63 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 185bfaf0ec6b..0ca367e13dd8 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -18,8 +18,11 @@
> >   * that converting umax_value to int cannot overflow.
> >   */
> >  #define BPF_MAX_VAR_SIZ      (1 << 29)
> > -/* size of type_str_buf in bpf_verifier. */
> > -#define TYPE_STR_BUF_LEN 128
> > +/* size of tmp_str_buf in bpf_verifier.
> > + * we need at least 306 bytes to fit full stack mask representation
> > + * (in the "-8,-16,...,-512" form)
> > + */
> > +#define TMP_STR_BUF_LEN 320
> >
> >  /* Liveness marks, used for registers and spilled-regs (in stack slots=
).
> >   * Read marks propagate upwards until they find a write mark; they rec=
ord that
> > @@ -621,8 +624,10 @@ struct bpf_verifier_env {
> >       /* Same as scratched_regs but for stack slots */
> >       u64 scratched_stack_slots;
> >       u64 prev_log_pos, prev_insn_print_pos;
> > -     /* buffer used in reg_type_str() to generate reg_type string */
> > -     char type_str_buf[TYPE_STR_BUF_LEN];
> > +     /* buffer used to generate temporary string representations,
> > +      * e.g., in reg_type_str() to generate reg_type string
> > +      */
> > +     char tmp_str_buf[TMP_STR_BUF_LEN];
> >  };
> >
> >  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1cb89fe00507..8faf9170acf0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -604,9 +604,9 @@ static const char *reg_type_str(struct bpf_verifier=
_env *env,
> >                type & PTR_TRUSTED ? "trusted_" : ""
> >       );
> >
> > -     snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> > +     snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
> >                prefix, str[base_type(type)], postfix);
> > -     return env->type_str_buf;
> > +     return env->tmp_str_buf;
> >  }
> >
> >  static char slot_type_char[] =3D {
> > @@ -3275,6 +3275,45 @@ static inline bool bt_is_slot_set(struct backtra=
ck_state *bt, u32 slot)
> >       return bt->stack_masks[bt->frame] & (1ull << slot);
> >  }
> >
> > +/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
> > +static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
> > +{
> > +     DECLARE_BITMAP(mask, 64);
> > +     bool first =3D true;
> > +     int i, n;
> > +
> > +     buf[0] =3D '\0';
> > +
> > +     bitmap_from_u64(mask, reg_mask);
> > +     for_each_set_bit(i, mask, 32) {
> > +             n =3D snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i)=
;
> > +             first =3D false;
> > +             buf +=3D n;
> > +             buf_sz -=3D n;
> > +             if (buf_sz < 0)
> > +                     break;
> > +     }
> > +}
> > +/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
> > +static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
> > +{
> > +     DECLARE_BITMAP(mask, 64);
> > +     bool first =3D true;
> > +     int i, n;
> > +
> > +     buf[0] =3D '\0';
> > +
> > +     bitmap_from_u64(mask, stack_mask);
> > +     for_each_set_bit(i, mask, 64) {
> > +             n =3D snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i=
 + 1) * 8);
> > +             first =3D false;
> > +             buf +=3D n;
> > +             buf_sz -=3D n;
> > +             if (buf_sz < 0)
> > +                     break;
> > +     }
> > +}
> > +
> >  /* For given verifier state backtrack_insn() is called from the last i=
nsn to
> >   * the first insn. Its purpose is to compute a bitmask of registers an=
d
> >   * stack slots that needs precision in the parent verifier state.
> > @@ -3298,7 +3337,11 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx,
> >       if (insn->code =3D=3D 0)
> >               return 0;
> >       if (env->log.level & BPF_LOG_LEVEL2) {
> > -             verbose(env, "regs=3D%x stack=3D%llx before ", bt_reg_mas=
k(bt), bt_stack_mask(bt));
> > +             fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_ma=
sk(bt));
> > +             verbose(env, "mark_precise: frame%d: regs(0x%x)=3D%s ",
> > +                     bt->frame, bt_reg_mask(bt), env->tmp_str_buf);
> > +             fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stac=
k_mask(bt));
> > +             verbose(env, "stack(0x%llx)=3D%s before ", bt_stack_mask(=
bt), env->tmp_str_buf);
>
> Let's drop (0x%llx) part from regs and stack.
> With nice human readable addition no one will be reading the hex anymore.
> It's just wasting screen real estate.

ack, will drop

>
> > +     "mark_precise: frame0: last_idx 26 first_idx 20\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 25\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 24\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 23\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 22\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 20\
> > +     parent didn't have regs=3D4 stack=3D0 marks:\
> > +     mark_precise: frame0: last_idx 19 first_idx 10\
> > +     mark_precise: frame0: regs(0x4)=3Dr2 stack(0x0)=3D before 19\
> > +     mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 18\
> > +     mark_precise: frame0: regs(0x300)=3Dr8,r9 stack(0x0)=3D before 17=
\
> > +     mark_precise: frame0: regs(0x201)=3Dr0,r9 stack(0x0)=3D before 15=
\
> > +     mark_precise: frame0: regs(0x201)=3Dr0,r9 stack(0x0)=3D before 14=
\
> > +     mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 13\
> > +     mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 12\
> > +     mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 11\
> > +     mark_precise: frame0: regs(0x200)=3Dr9 stack(0x0)=3D before 10\
> > +     parent already had regs=3D0 stack=3D0 marks:",
>
> This part would be much cleaner without (0x...)
