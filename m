Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85952AE09
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiEQWWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiEQWWe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 18:22:34 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D452FFDE
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 15:22:33 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z144so149967vsz.13
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOYBr1+tJ/MjYHcv06yEe4yL7LXUGyFlMW+Ti+TRzoM=;
        b=E4qKV9pIx8ytcDKx+E77rd1xXPHPRmnooMyhyflC60oxceHNujYS3A4ji9F78+R5s2
         rEATifUxg3/XrgQAIgDGVWIuhTKXQ8LCfwJwuLRyX0hFXu7ruCu0ScnkYV/M89d53P2K
         fWToC+1Umm9RfFyg2s+hLOagM9jUeH4FkwXyNI7YaR4init4/97lUOWxgrTe0i7prFdW
         lrTfJR2djnz8XNEWyFyo/HeZoyWPxQ7fiiTRLZ+AuBYp23VxjEUwmZsVmfISfL3q0UTL
         F5o+MsOfxStXCW8tR8XYS2FotDe1FuQja67hdWs6AaZssM6qOMzvVgNp7AydgDo/Nihq
         WW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOYBr1+tJ/MjYHcv06yEe4yL7LXUGyFlMW+Ti+TRzoM=;
        b=obU7oFr+j+VDsIceTJ0USoialsNURBpKOwQaarRbtgkOJRFdHbWdrkEkvvTxI/9vnV
         UtqGAeVCnl0l+vjjtAOnIDssndd0+gY4ojUanGWC5PC0effVL3M9sLMcZ92/wXTLAGh7
         RZrztssk5GLlxsHfQPE1BYQdZ86T+EqQNswmvIofSrWd9ssXuY18BkKaANKaEm3K3x1o
         35lKqns78EblT6x25XIqUUPBrvkCscckQal9FpidW03PK6LfttpoLHvHIQrr61AZ9xFW
         Gh/zGNkkGE7BnSanpjf2TGyVrNcEqcgkh6nz9kXRgfXQKnMyi92W1cHVEKtHXEUr342f
         Nk6w==
X-Gm-Message-State: AOAM531Y3bW4EAKcX/0jgSyqzFjFNLvEpxWBkNIKnOAblrMJSZiJ1tLD
        R973ayH0iRSvcowKIjSCgNJHe2Mdt/Tjeq2Rdf0=
X-Google-Smtp-Source: ABdhPJxSjA3yexJ/jS/uhR7H0YC8jraCjGt7RkvhXXgZw36iuC3PR/9tg1jB605g5dcktAqFjFptcDgiJvTUBtzwCYs=
X-Received: by 2002:a05:6102:370a:b0:333:c0e7:77e8 with SMTP id
 s10-20020a056102370a00b00333c0e777e8mr10772682vst.54.1652826152494; Tue, 17
 May 2022 15:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031253.3242578-1-yhs@fb.com>
 <CAEf4BzYqC8BhUHk=SW-=dLyF=4ZPqYXoo2eBTLcqd1VXjK0xUg@mail.gmail.com> <804bf498-a272-86ac-7a24-e4662e8288a1@fb.com>
In-Reply-To: <804bf498-a272-86ac-7a24-e4662e8288a1@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 15:22:21 -0700
Message-ID: <CAEf4BzaV_uuE6FcqeCJqK4EjA+yPkNLfx6SnwhCWHN4Hq8f7qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/18] libbpf: Add enum64 deduplication support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Tue, May 17, 2022 at 10:11 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/16/22 5:28 PM, Andrii Nakryiko wrote:
> > On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
> >> is very similar to BTF_KIND_ENUM.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/btf.c | 55 +++++++++++++++++++++++++++++++++------------
> >>   tools/lib/bpf/btf.h |  5 +++++
> >>   2 files changed, 46 insertions(+), 14 deletions(-)
> >>
> >
> > [...]
> >
> >> +static bool btf_equal_enum64_val(struct btf_type *t1, struct btf_type *t2)
> >> +{
> >> +       const struct btf_enum64 *m1, *m2;
> >> +       __u16 vlen = btf_vlen(t1);
> >> +       int i;
> >> +
> >> +       m1 = btf_enum64(t1);
> >> +       m2 = btf_enum64(t2);
> >> +       for (i = 0; i < vlen; i++) {
> >> +               if (m1->name_off != m2->name_off || m1->val_lo32 != m2->val_lo32 ||
> >> +                   m1->val_hi32 != m2->val_hi32)
> >> +                       return false;
> >> +               m1++;
> >> +               m2++;
> >> +       }
> >> +       return true;
> >> +}
> >> +
> >> +/* Check structural equality of two ENUMs. */
> >> +static bool btf_equal_enum_or_enum64(struct btf_type *t1, struct btf_type *t2)
> >
> > I find this helper quite confusing. It implies it can compare any enum
> > or enum64 with each other, but it really allows only enum vs enum and
> > enum64 vs enum64 (as it should!). Let's keep
> > btf_equal_enum()/btf_compat_enum() completely intact and add
> > btf_equal_enum64()/btf_compat_enum64() separately (few lines of
> > copy-pasted code is totally fine to keep them separate, IMO). See
> > below.
>
> I debate with myself about whether I should use separate functions or
> use one function for both enum/enum64. My current approach will have
> less code changes. But I can do what you suggested to have separate
> functions for enum and enum64. This will apply to btf_compat_enum
> as well.

yep, thanks!

>
> >
> >> +{
> >> +       if (!btf_equal_common(t1, t2))
> >> +               return false;
> >> +
> >> +       if (btf_is_enum(t1))
> >> +               return btf_equal_enum32_val(t1, t2);
> >> +       return btf_equal_enum64_val(t1, t2);
> >> +}
> >> +
> >>   static inline bool btf_is_enum_fwd(struct btf_type *t)
> >>   {
> >> -       return btf_is_enum(t) && btf_vlen(t) == 0;
> >> +       return btf_type_is_any_enum(t) && btf_vlen(t) == 0;
> >>   }
> >>
> [...]
