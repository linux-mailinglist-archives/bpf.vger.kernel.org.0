Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD263166A
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 21:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKTUqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 15:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKTUqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 15:46:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6518345
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:46:37 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d192so9642612pfd.0
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4/0VlqipDtqILulUj+QdSElM4ihlJdwTBGv3yfiNRo=;
        b=AZWPTJm/RFhaw37sIZNdRwU82yG77VeqbBIs2L4O4W8qmfl6joW+pIg/nOsD92OsT3
         z8apAEAYIw8j49YxKv79qImZxD2ykU98vw6pp5SWsO6zZkmnXpIUXEPDD6BLMPvJeYkm
         u3dqQ/7aGELygnskGpnkHdYFOzg/Km9lHlgMDEG4CTK0PwUaSes/urQdlQWuJah4p4Mj
         +p8HlwQOlneDzjG4HHq2FqVR7UhHu+8G6uPsu87BN6tlPOd1UzfVnCP7/xAJ+GzYOlR2
         dtS051Cfh315+E+DwLBBsHS8v4KCqeafbKp/sRvjU+aRAZxhO55mQoUQ6D+J9UPILYaM
         gh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4/0VlqipDtqILulUj+QdSElM4ihlJdwTBGv3yfiNRo=;
        b=FpBuM7iTwMhLzfuJRbaiphdfbJ+aZUmoegDxpEk6ZHTIWY34mV0pXTUH51GRt77K8Z
         rStXOUEI+Fmx7W2W81Xzz9I198q+xBYtBf5p76VVo86ShIGtDmRVuxkIbJg3oS9ntp0C
         sA5oE8Ncnywvaz67jbl61twTSgu5J93RQUl58NB8T6rH4IaG4sfUHr76ea9z5nKlx1Dk
         E5530mAmMf0nifCvWn8yEcEkc0qa/rHVFaiUZwnGu3/p85aOCN/7CZ3gy1NbAag45lnQ
         /HJ+dF84NawMmJMw1SQXz+2dzqhL4n1teSBrlf4vifmi9RQU5eJaijvjTexNHmPoh5Ox
         3cNw==
X-Gm-Message-State: ANoB5pn1MiKTo80DDGhceJHu2x5w6wBzOJE+VGkJVtnnedfwDKMkRuT+
        dEtS6o/KlnsuBACA002jUCo=
X-Google-Smtp-Source: AA0mqf7cfP6K3n0pNJByUNvyv+cowy4m0XdZl6dQaNq0i/IdOFjCtM2r7v7/7SmOSsowrtBdI7R5jQ==
X-Received: by 2002:a63:d751:0:b0:46f:f87c:fb1a with SMTP id w17-20020a63d751000000b0046ff87cfb1amr2017988pgi.214.1668977196559;
        Sun, 20 Nov 2022 12:46:36 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b0056ee0d0985asm7073218pfb.82.2022.11.20.12.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:46:36 -0800 (PST)
Date:   Mon, 21 Nov 2022 02:16:25 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disallow calling bpf_obj_new_impl
 on bpf_mem_alloc_init failure
Message-ID: <20221120204625.ndtr7ygh7zgjxrsz@apollo>
References: <20221118185938.2139616-1-memxor@gmail.com>
 <20221118185938.2139616-2-memxor@gmail.com>
 <CAADnVQLKwfr_UiLEc-5exQGd3saeuYUX2j8BHzAtBgZovUpCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLKwfr_UiLEc-5exQGd3saeuYUX2j8BHzAtBgZovUpCGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 19, 2022 at 01:47:25AM IST, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 11:00 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Instead of checking bpf_global_ma_set at runtime on each allocation
> > inside bpf_obj_new_impl, simply disallow calling the kfunc in case
> > bpf_global_ma initialization failed during program verification.
> >
> > The error generated when bpf_global_ma initialization fails:
> > ...
> > 21: (18) r1 = 0x7                     ; R1_w=7
> > 23: (b7) r2 = 0                       ; R2_w=0
> > 24: (85) call bpf_obj_new_impl#36585
> > bpf_global_ma initialization failed, can't call bpf_obj_new_impl
> > calling kernel function bpf_obj_new_impl is not allowed
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/helpers.c  |  2 --
> >  kernel/bpf/verifier.c | 13 ++++++++++++-
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 212e791d7452..bc02f55adc1f 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1760,8 +1760,6 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> >         u64 size = local_type_id__k;
> >         void *p;
> >
> > -       if (unlikely(!bpf_global_ma_set))
> > -               return NULL;
> >         p = bpf_mem_alloc(&bpf_global_ma, size);
> >         if (!p)
> >                 return NULL;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 195d24316750..f04bee7934a8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8746,6 +8746,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >         return 0;
> >  }
> >
> > +static bool is_kfunc_disabled(struct bpf_verifier_env *env, const struct btf *btf, u32 func_id)
> > +{
> > +       if (btf != btf_vmlinux)
> > +               return false;
> > +       if (!bpf_global_ma_set && func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> > +               verbose(env, "bpf_global_ma initialization failed, can't call bpf_obj_new_impl\n");
> > +               return true;
> > +       }
> > +       return false;
> > +}
> > +
>
> This is all just unnecessary code bloat for the case
> that cannot happen.
>
> When you do:
> meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl]
> just add
> if (!bpf_global_ma_set)
>  return -ENOMEM;
>
> No need for verbose(). The users will never hit it.
>

Ok, makes sense, will fix and resend.

> Also please get rid of special_kfunc_set and
> and btf_id_set_contains(&special_kfunc_set, meta.func_id)
> That additional check is unnecessary as well.
> special_kfunc_list is enough.

It provides an easy way to do 'btf == vmlinux && is_special_kfunc'.
Otherwise if I drop it, every check matching func_id == special_kfunc_list will
also have to do btf == vmlinux check (because eventually we want to drop to the
other branches that should work for non-vmlinux BTF as well).

What I mean is:
	if (btf == vmlinux && btf_id_set_contains(special_kfunc_set)) {
		if (func_id == special_kfunc_list) {
		} else if (func_id == special_kfunc_list) {
		} else {
		}
	} else if (!__btf_type_is_struct) {
	} else /* struct */ {
	}

will become:
	if (btf == vmlinux && func_id == special_kfunc_list) {
	} else if (btf == vmlinux && func_id == special_kfunc_list) {
	} else if (!__btf_type_is_struct) {
	} else /* struct */ {
	}

I think it's better to keep it. It also fails the kfunc call if the return type
is not properly handled (either custom implementation or just falling through to
default cases, w/e applies).

But up to you.
