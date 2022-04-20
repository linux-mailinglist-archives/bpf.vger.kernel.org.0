Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D535091EF
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 23:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbiDTVSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiDTVSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 17:18:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B843ACD
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:15:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu29so5274609lfb.0
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B0znDhtCpOmNc7+EngWV3e/FTLWUmBoX6wEDkc700NA=;
        b=XowPm+7UUFNv+ZIa9VjBp9OnwfPDv55rj7jZU6aMFkEFmRjalcf9Ip8uhICfUZb7Y7
         C54J3GDaSF1iEXHYBbQfsH/P6RSHAak+/nDIRZKTgH6ZTYH7yMa4ZbYUYgxWUuDx6IPN
         aQymHmnOsJSdUgGx5GPiJTdvLZ3uiGoeQ7N91nJ86XTbgJrlmRvsSQ9qOgHUm+7VCVz0
         VqDUlxXKLBQgkaem00z1JRd0kI3RgIr77jXUZB9UM6GyWntQaQLHG/e2ZIlbQz0trp0e
         LsBHVZhVF1xe67yVd6KjiXoZokeGFMhQJQM1E3av2o8B1vTfBGi+/VfAJR675cBx7lZR
         a3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B0znDhtCpOmNc7+EngWV3e/FTLWUmBoX6wEDkc700NA=;
        b=JUs14oKiG1bBmSjz7HM/4ImjdqQ/mAYONZzxvCpnl6dMIlukugcmgDYUabvqSjsFei
         XuCpL72a5hQ/+I1Pv4E7ubOjpwiaPNFYHgXx3Ujj4S25m0pw1TJcI2RQBlBSTbhoYIgy
         9U3yhNDRI2f41tvBnoMGi3+8JM23ZdAujnfX0+lIHm8QAch/6wlxcy+pnDWutZIYq0wl
         YM5ZXzizPpzMM/o+Uif7Pt9+KAs1G6oNeqzesDaeyYsJhs6gDqHWVGxgoc8NAcW4hoTD
         vUUIJHsJ0aSXZcfY/9hewfz9CT/K2EJvl1FINdtd5AlQEAIo4ig6YfAa8wfbnzw3jmDA
         n3aA==
X-Gm-Message-State: AOAM533KXTBu14w9TG/0ooq26n5+M3IKUXHJmgVFN067ay3cK9lULSNG
        KhNvaLA8D2wh9w4LV7GawwwVt9EF4iuwlzs+m+s=
X-Google-Smtp-Source: ABdhPJx76g3LJqz/KwisJdzZjREn4g5ISvKV04advjy4ttn/YY5Jzk6ZYs+fTrc8Tb6OY5gT+s73YCVCm2yc3TOUNa8=
X-Received: by 2002:a05:6512:10c5:b0:471:924f:1eed with SMTP id
 k5-20020a05651210c500b00471924f1eedmr11583824lfg.641.1650489332023; Wed, 20
 Apr 2022 14:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
 <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com>
 <20220418235718.izeq7kkwinedpkuj@apollo.legion> <CAJnrk1ag9PT1iXMzB5cxJEnwESYndYE_LozvBuL_Db2degJ-CQ@mail.gmail.com>
 <20220419201851.qtekbc5twmyuyktn@apollo.legion>
In-Reply-To: <20220419201851.qtekbc5twmyuyktn@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 20 Apr 2022 14:15:20 -0700
Message-ID: <CAJnrk1YSk_19JYiJ_tDex=_CqK6ppANaM6BM5kKW_Kt41rsDzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 1:18 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 12:53:55AM IST, Joanne Koong wrote:
> > > [...]
> > > There is another issue I noticed while basing other work on this. You=
 have
> > > declared bpf_dynptr in UAPI header as:
> > >
> > >         struct bpf_dynptr {
> > >                 __u64 :64;
> > >                 __u64 :64;
> > >         } __attribute__((aligned(8)));
> > >
> > > Sadly, in C standard, the compiler is under no obligation to initiali=
ze padding
> > > bits when the object is zero initialized (using =3D {}). It is worse,=
 when
> > > unrelated struct fields are assigned the padding bits are assumed to =
attain
> > > unspecified values, but compilers are usually conservative in that ca=
se (C11
> > > 6.2.6.1 p6).
> > Thanks for noting this. By "padding bits", you are referring to the
> > unnamed fields, correct?
> >
> > From the commit message in 5eaed6eedbe9, I see:
> >
> > INTERNATIONAL STANDARD =C2=A9ISO/IEC ISO/IEC 9899:201x
> >   Programming languages =E2=80=94 C
> >   http://www.open-std.org/Jtc1/sc22/wg14/www/docs/n1547.pdf
> >   page 157:
> >   Except where explicitly stated otherwise, for the purposes of
> >   this subclause unnamed members of objects of structure and union
> >   type do not participate in initialization. Unnamed members of
> >   structure objects have indeterminate value even after initialization.
> >
> > so it seems like the best way to address that here is to just have the
> > fields be explicitly named, like something like
> >
> > struct bpf_dynptr {
> >     __u64 anon1;
> >     __u64 anon2;
> > } __attribute__((aligned(8)))
> >
> > Do you agree with this assessment?
> >
>
> Yes, this should work. Also, maybe 'variable not initialized error' shoul=
dn't be
> 'verifier internal error', since it would quite common for user to hit it=
.
>
I looked into this some more and I don't think it's an issue that the
compiler doesn't initialize anonymous fields and/or initializes it
with indeterminate values. We set up the dynptr in
bpf_dynptr_from_mem() and bpf_dynptr_alloc() where we initialize its
contents with real values. It doesn't matter if prior to
bpf_dynptr_from_mem()/bpf_dynptr_alloc() it's filled with garbage
values because they'll be overridden.

The "verifier internal error: variable not initialized on stack in
mark_as_dynptr_data" error you were seeing is unrelated to this. It's
because of a mistake in mark_as_dynptr_data() where when we check that
the memory size of the data should be within the spi bounds, the 3rd
argument we pass to is_spi_bounds_valid() should be the number of
slots, not the memory size (the value should be mem_size /
BPF_REG_SIZE, not mem_size). Changing this fixes the error.

> --
> Kartikeya
