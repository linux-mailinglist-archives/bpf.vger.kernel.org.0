Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2676733E1DE
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 00:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCPXGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCPXGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 19:06:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDEC06174A;
        Tue, 16 Mar 2021 16:06:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p186so38620958ybg.2;
        Tue, 16 Mar 2021 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2cst11jcwFb+EzWFHn4bvkF3XRi4pyH2UKgp3CnPWw=;
        b=INlc0bGFKkJ3O5UE+B2tZi2kDdTek1CiGVWGX4doIUWZNydBoMCiGZpqpsjfZwqq35
         wCS+ujEtx7rI4f92P44MgvF+lPze1OfFcvZNz0y4dExOFslpQ5Xz6rw1AzcqNaJswJiA
         b6CrGHzmT0oKRR7MTBmtM/lacLPouGvblwElaMiyvSHqJPVw21arJvsiIKil40GQlfAZ
         CQPnJdqOpa+J7GbaHL4cCHd35DABuJr3i9kwwWTfS8whd598Gs874lcb0kNvCesYwh0g
         MKwR7VXwDsh8Bl6xsjmsFvYUXNTKTUf5bZm42eOGg6U9ahfxYJDvvLT1xQxwgyAmQaIc
         1cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2cst11jcwFb+EzWFHn4bvkF3XRi4pyH2UKgp3CnPWw=;
        b=F8VBbgDr33UMl8uuEKUijdaBNq0gu2EofY+TiMt02DzcmJQRvBa5tquqplnsp6KivI
         pOIB5iwJA0B4s+Ajzxzh/OU3BoO7c95Y94sLU/SaH1qJp26jXLPrZkZJrQtf/lEenwJ2
         YR1nqKnmqiSlOyUJkcZBKLA0BFZwUiOPFaYOjpTBLL5GAu4bHjLEQ1HaFT2A5eGS58XP
         nMjw3j7I80cRltQcwG0WqBrXLPdsGGbcawpml558DDv2UDcUSQ5K4bj7i4RHj3Gl5dHZ
         rXMkWRxSQ5VHAkySXiEq8YHQv7hldwPYCrYY2Lg5+8Eh5j6f8xj4fw/6yMZQOk7JLXsx
         jERw==
X-Gm-Message-State: AOAM532R+CNmitiLlLvZ/F6atsZu1s9TdiSc4DKt/+Pzvzr32buSiK2p
        16nB8BPvOXJdg3vVC86483CooLBjrxy7FMNxLL8=
X-Google-Smtp-Source: ABdhPJxG4RazZHW/Cng10wBwdsz/robYCwlCEtnda/cFEynSSMA/JXt/a/EQA2RQV12w/NWZO5hHoQBFS14OCJFHf84=
X-Received: by 2002:a25:874c:: with SMTP id e12mr1409360ybn.403.1615935995690;
 Tue, 16 Mar 2021 16:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-4-revest@chromium.org>
 <CAEf4BzZmQ3C=DfSRckM0AUXhz2MeghwhF6RLspS2u44sx0LP-g@mail.gmail.com> <CABRcYmK2o0odG+OkE=-s2QYZ-i=twqup0z_9_9pSh2ipTLLeEg@mail.gmail.com>
In-Reply-To: <CABRcYmK2o0odG+OkE=-s2QYZ-i=twqup0z_9_9pSh2ipTLLeEg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Mar 2021 16:06:24 -0700
Message-ID: <CAEf4BzZgL8VbyzBVPC+v=TN_ro-zqZxwkGmCBPbs7DVvCYnMjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 3:43 PM Florent Revest <revest@chromium.org> wrote:
>
> On Tue, Mar 16, 2021 at 5:36 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > +#define ___bpf_build_param0(narg, x)
> > > +#define ___bpf_build_param1(narg, x) ___param[narg - 1] = x
> > > +#define ___bpf_build_param2(narg, x, args...) ___param[narg - 2] = x; \
> > > +                                             ___bpf_build_param1(narg, args)
> > > +#define ___bpf_build_param3(narg, x, args...) ___param[narg - 3] = x; \
> > > +                                             ___bpf_build_param2(narg, args)
> > > +#define ___bpf_build_param4(narg, x, args...) ___param[narg - 4] = x; \
> > > +                                             ___bpf_build_param3(narg, args)
> > > +#define ___bpf_build_param5(narg, x, args...) ___param[narg - 5] = x; \
> > > +                                             ___bpf_build_param4(narg, args)
> > > +#define ___bpf_build_param6(narg, x, args...) ___param[narg - 6] = x; \
> > > +                                             ___bpf_build_param5(narg, args)
> > > +#define ___bpf_build_param7(narg, x, args...) ___param[narg - 7] = x; \
> > > +                                             ___bpf_build_param6(narg, args)
> > > +#define ___bpf_build_param8(narg, x, args...) ___param[narg - 8] = x; \
> > > +                                             ___bpf_build_param7(narg, args)
> > > +#define ___bpf_build_param9(narg, x, args...) ___param[narg - 9] = x; \
> > > +                                             ___bpf_build_param8(narg, args)
> > > +#define ___bpf_build_param10(narg, x, args...) ___param[narg - 10] = x; \
> > > +                                              ___bpf_build_param9(narg, args)
> > > +#define ___bpf_build_param11(narg, x, args...) ___param[narg - 11] = x; \
> > > +                                              ___bpf_build_param10(narg, args)
> > > +#define ___bpf_build_param12(narg, x, args...) ___param[narg - 12] = x; \
> > > +                                              ___bpf_build_param11(narg, args)
> >
> > took me some time to get why the [narg - 12] :) it makes sense, but
> > then I started wondering why not
> >
> > #define ___bpf_build_param12(narg, x, args...)
> > ___bpf_build_param11(narg, args); ___param[11] = x
> >
> > ? seems more straightforward, no?
>
> Unless I'm misunderstanding something, I don't think this would work.
> The awkward "narg - 12" comes from the fact that these variadic macros
> work by taking the first argument out of the variadic arguments (x
> followed by args) and calling another macro with what's left (args).

You are right, of course, silly me.

>
> So if you do __bpf_build_param(arg1, arg2) you will have
> __bpf_build_param2() called with arg1 and __bpf_build_param1() called
> with arg2. And if you do __bpf_build_param(arg1, arg2, arg3) you will
> have __bpf_build_param3() called with arg1, __bpf_build_param2()
> called with arg2, and __bpf_build_param1() called with arg3.
> Basically, things are inverted, the position at which you need to
> insert in ___param evolves in the opposite direction of the X after
> ___bpf_build_param which is the number of arguments left.
>
> No matter in which order __bpf_build_paramX calls
> __bpf_build_param(X-1) (before or after setting ___param[n]) you will
> be unable to know just from the macro name at which cell in __param
> you need to write the argument. (except for __bpf_build_param12 which
> is an exception, because the max number of arg is 12, if this macro
> gets called, then we know that narg=12 and we will always write at
> __param[0])
>
> That being said, I share your concern that this code is hard to read.
> So instead of giving narg to each macro, I tried to give a pos
> argument which indicates in which cell the macro should write. pos is
> basically a counter that goes from 0 to narg as macros go from narg to
> 0.
>
> #define ___bpf_fill0(array, pos, x)
> #define ___bpf_fill1(array, pos, x) array[pos] = x
> #define ___bpf_fill2(array, pos, x, args...) array[pos] = x;
> ___bpf_fill1(array, pos + 1, args)
> #define ___bpf_fill3(array, pos, x, args...) array[pos] = x;
> ___bpf_fill2(array, pos + 1, args)
> #define ___bpf_fill4(array, pos, x, args...) array[pos] = x;
> ___bpf_fill3(array, pos + 1, args)
> #define ___bpf_fill5(array, pos, x, args...) array[pos] = x;
> ___bpf_fill4(array, pos + 1, args)
> #define ___bpf_fill6(array, pos, x, args...) array[pos] = x;
> ___bpf_fill5(array, pos + 1, args)
> #define ___bpf_fill7(array, pos, x, args...) array[pos] = x;
> ___bpf_fill6(array, pos + 1, args)
> #define ___bpf_fill8(array, pos, x, args...) array[pos] = x;
> ___bpf_fill7(array, pos + 1, args)
> #define ___bpf_fill9(array, pos, x, args...) array[pos] = x;
> ___bpf_fill8(array, pos + 1, args)
> #define ___bpf_fill10(array, pos, x, args...) array[pos] = x;
> ___bpf_fill9(array, pos + 1, args)
> #define ___bpf_fill11(array, pos, x, args...) array[pos] = x;
> ___bpf_fill10(array, pos + 1, args)
> #define ___bpf_fill12(array, pos, x, args...) array[pos] = x;
> ___bpf_fill11(array, pos + 1, args)
> #define ___bpf_fill(array, args...) \
> ___bpf_apply(___bpf_fill, ___bpf_narg(args))(array, 0, args)

Yeah, this is still more straightforward, I think. Please use shorter
names to keep it a bit more succinct: arr and p seems clear enough.

>
> I hope this makes things a bit clearer ? (I often joke that BPF is
> written in preprocessor... :p)

Definitely true for BPF_CORE_READ macros :)
