Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F54B2BE6
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiBKRhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiBKRhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:37:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659AA394
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:37:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u16so11785450pfg.3
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXkb1HYZtTxxsdq+xfc0pXJCSU+kQWd0GR2a9VVJQyw=;
        b=LcodaqK0iQwmO96V6uWDRTE/ZVpg5sxLKMtYf4AD9rgvjgEUDCc5wqTsSojl3nHCTF
         hSxGH7r92iDvxCeE5Lg9VTKiNct8cvL7gOsdsXSP0t55MLIFXlpo1ek8sF/SV7G3ENyZ
         TLuIOFcHrrXxQvPte5kLKqq/CQ48lSMqsKbNhbXRIWP4FE2gYT/JnHLvFm8F6yxGpHUZ
         HLbh4SuYoHoQW+Gj4z8mHa0AoMpTLjjin1pX1AY5v6ItkAjaOqA9yZEOo1owRVbARQzp
         NY5Qk4ZPpzHpr3UiemSTgRayfrpFK3HHDtuXH2p3KU/DQRjti4l02fVUqRkPp7aTgdTf
         eZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXkb1HYZtTxxsdq+xfc0pXJCSU+kQWd0GR2a9VVJQyw=;
        b=0O5hb/jLqAcIkUccsDExUvXsR4ss3sNJhFLVbJZkS2wkleBIc/kfcWg20KcaR1U1ps
         Drv4CzilqsPKgsuxIXNTeBbZXuolMbuFAYSuJSusgIKzGDzS3MnZmuXJEUPHSrR5pjWy
         ep9br9cF5j06oT/svyYeS1d1Ft2HzHElcyCsf6ywZLz3DENOzc+3980xOGWlsKKdvWe0
         zSAwo2zw4y7kHrZiwIQV540KlejugQ0ZdOQkPo+oVp0ForSY0fkZMA0IgRdrZwTQ9c2M
         8y1Dvu7uGztjTOXR9Wy3TKxN5ClKIbRXhw1yjQCkTa6e35+0QoUXQUhjQORy/8YdwhrG
         kMew==
X-Gm-Message-State: AOAM530PgWs8nC7cSVLSQBZB2TLxeDbpizlxiYg2I636effVKJouIsAI
        Xr9J6gzC6gbkVHX/M6Rc+ZZ13+hnkQKLIr3BMzOO3Vqq
X-Google-Smtp-Source: ABdhPJy5kdSaPyUd7XiCLJc+1UidRS6aAJMbmF6cZ8wylVhhdsxfr1+1qzdY/7Y0HLfpkC77LYDc6OiK/hg1h9L5UWQ=
X-Received: by 2002:a65:6e04:: with SMTP id bd4mr2173448pgb.375.1644601023829;
 Fri, 11 Feb 2022 09:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20220211152054.1584283-1-yhs@fb.com> <20220211152059.1584701-1-yhs@fb.com>
 <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com> <f5f68d5a-91eb-84e4-d4fd-fc4aaa34207c@fb.com>
In-Reply-To: <f5f68d5a-91eb-84e4-d4fd-fc4aaa34207c@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 11 Feb 2022 09:36:52 -0800
Message-ID: <CAADnVQLPy_BiCghkCu7ue9wEFQJm8gvieDnuqQiErp3iZuck7A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix a bpf_timer initialization issue
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Feb 11, 2022 at 9:32 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/11/22 8:47 AM, Alexei Starovoitov wrote:
> > On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>    struct bpf_spin_lock {
> >>          __u32   val;
> >>    };
> >>    struct bpf_timer {
> >>          __u64 :64;
> >>          __u64 :64;
> >>    } __attribute__((aligned(8)));
> >>
> >> The initialization code:
> >>    *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =3D
> >>        (struct bpf_spin_lock){};
> >>    *(struct bpf_timer *)(dst + map->timer_off) =3D
> >>        (struct bpf_timer){};
> >> It appears the compiler has no obligation to initialize anonymous fiel=
ds.
> >> For example, let us use clang with bpf target as below:
> >>    $ cat t.c
> >>    struct bpf_timer {
> >>          unsigned long long :64;
> >>    };
> >>    struct bpf_timer2 {
> >>          unsigned long long a;
> >>    };
> >>
> >>    void test(struct bpf_timer *t) {
> >>      *t =3D (struct bpf_timer){};
> >>    }
> >>    void test2(struct bpf_timer2 *t) {
> >>      *t =3D (struct bpf_timer2){};
> >>    }
> >>    $ clang -target bpf -O2 -c -g t.c
> >>    $ llvm-objdump -d t.o
> >>     ...
> >>     0000000000000000 <test>:
> >>         0:       95 00 00 00 00 00 00 00 exit
> >>     0000000000000008 <test2>:
> >>         1:       b7 02 00 00 00 00 00 00 r2 =3D 0
> >>         2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) =3D r2
> >>         3:       95 00 00 00 00 00 00 00 exit
> >
> > wow!
> > Is this a clang only behavior or gcc does the same "smart" optimization=
?
> >
> > We've seen this issue with padding, but I could have never guessed
> > that compiler will do so for explicit anon fields.
> > I wonder what standard says and what other kernel code is broken
> > by this "optimization".
>
> Searched the internet, not sure whether this helps or not.
>
> INTERNATIONAL STANDARD =C2=A9ISO/IEC ISO/IEC 9899:201x
> Programming languages =E2=80=94 C
>
> http://www.open-std.org/Jtc1/sc22/wg14/www/docs/n1547.pdf
> page 157:
>
> Except where explicitly stated otherwise, for the purposes of this
> subclause unnamed
> members of objects of structure and union type do not participate in
> initialization.
> Unnamed members of structure objects have indeterminate value even after
> initialization.

Thanks for clarifying! It means that gcc might do so eventually as well.
