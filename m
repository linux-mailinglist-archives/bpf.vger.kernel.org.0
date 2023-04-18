Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB56E6BC1
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjDRSKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjDRSKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 14:10:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC261FE4
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:10:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fw30so22700274ejc.5
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681841443; x=1684433443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4y22LQ7Bxjcjad3XJBlCzfrPAkmiYaCegefqV9K2lc=;
        b=kwI5Pel5hnNtZwSz8muTMJ1iiIrh9aHtFq8uX1Vv97u97CDzBlIGz5ldst1KKVP4YL
         DDRKhcz8eHpWhsSsc0SNguYK91V3hU8lIrAcprZVNSIXo1nFh1fnMYU15HAn+rTqScML
         ej+jvjuzoKAPHQGj64+kY/n61rng26weJh/VASIr5hGf8Wcg1blWzCAUaaCYme+hyQZI
         jzOggWXv40eb+l1o94/LI7oXwzBp+Hh7+5Z5RI7XLDAGws5SumRs/BQwxqlrnyAqvdmD
         awh6R/1onhUr8QpRo4YKT0Ebgep02x9+3s8DWpskP0N2Zs/qV7IMtilVEZ/tfi7QoavW
         cnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841443; x=1684433443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4y22LQ7Bxjcjad3XJBlCzfrPAkmiYaCegefqV9K2lc=;
        b=DoY4UTqw3Jm4a8sEAKcEniqHyYCY2HwzcqgKXPz6FPMzsIsuWPpEbF1ts2Y+1NIa3T
         KRsGl2xrAxXPs/edAjMagJcyCtLaACLQ5fdbqoSeYL6F8stL8yM1InUz15oEZxxgjB3n
         Tgplnca63ESE4IWou1BBYTvDG0PvRUP7DZMk1RbiW7TU/OkthY8F/dhBVhVucp13Bj7j
         Ehv7tOzbSyZQI+SB8/SNlNkD3G9WefVzEhTzdjKK+N9XhBWGxUJQT2izCy/JNij8MNls
         PRqGQdP4OxXEzgMCsCNcdiVGqGCuoEEDq/PUwXbyJ0RuQH4IdRKNxC6Ui24moVjKLx8n
         PUpQ==
X-Gm-Message-State: AAQBX9cRqSg/AbjNxK4RfFsAP4Dxes7OqMY+JjjAaPw47SZShJR44p8k
        l1pEE+ZSuPoxUhq+9sQ6t3y0bj+UCVhkos2rbsE=
X-Google-Smtp-Source: AKy350YiVsk07IGV00tk+CwiNY+ArKpF8WMOWoOmHp/KWZu0vGZHVT4S2DzLR0dUn3lxa/qKEiXUPT0Zg5AzNLAy61E=
X-Received: by 2002:a17:907:920b:b0:930:3916:df17 with SMTP id
 ka11-20020a170907920b00b009303916df17mr10319128ejb.0.1681841442572; Tue, 18
 Apr 2023 11:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230418002148.3255690-1-andrii@kernel.org> <20230418002148.3255690-4-andrii@kernel.org>
 <CAADnVQK-JjutrU-TMCh6f9qfcY_9T2mr59+Lzcw5us8KwDEmug@mail.gmail.com>
In-Reply-To: <CAADnVQK-JjutrU-TMCh6f9qfcY_9T2mr59+Lzcw5us8KwDEmug@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Apr 2023 11:10:28 -0700
Message-ID: <CAEf4BzaGEhszZ-VxB=0YdF989LQNZA-rnuZasEF_BB-Qy_hdNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: improve handling of unresolved kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Mon, Apr 17, 2023 at 6:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 5:22=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >                                 insn[0].imm =3D ext->ksym.kernel_btf_id=
;
> >                                 insn[0].off =3D ext->ksym.btf_fd_idx;
> > -                       } else { /* unresolved weak kfunc */
> > -                               insn[0].imm =3D 0;
> > -                               insn[0].off =3D 0;
> > +                       } else { /* unresolved weak kfunc call */
> > +                               poison_kfunc_call(prog, i, relo->insn_i=
dx, insn,
> > +                                                 relo->ext_idx, ext);
>
> With that done should we remove:
>     /* skip for now, but return error when we find this in fixup_kfunc_ca=
ll */
>     if (!insn->imm)
>           return 0;
> in check_kfunc_call()...
>
> and  if (!func_id && !offset) in add_kfunc_call() ?
>
> That was added in commit a5d827275241 ("bpf: Be conservative while
> processing invalid kfunc calls")

I guess?.. I don't know if there was any other situation that this fix
was handling, but if it's only due to unresolved kfuncs by libbpf,
then yep.
