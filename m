Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06544B8F2C
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiBPReF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 12:34:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiBPReE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 12:34:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F122219C
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 09:33:51 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c4so2694917pfl.7
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 09:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/b4pvVKBosaMZz+EmQWoH+hiG810FwCQCYfzBZ6hw4=;
        b=XEtXEEI8eTWtCMKYFbCT0Ci8MTZiI+kRFcXTAZMq7C8B8LIweCXRR7pvH/RO6Y/r+X
         E7xM92vijkEgJnpFTzzmH2Sgez8APJ3KcKBEgw5cvLYqv/X0GAZEAa0KFiyJY0hP4pt3
         AKIV3cmiELjijqFjrg0JKRdIoRzE3zX7lku2R69bdpxf9BSaH/AVMTpNrq1N2wkuwD2Y
         8cwYvcZWMglhEwFr6IvnERnFGU3FWsTDj9bTFyWN7bJHwZTpTW4mjS1hlRZkLetZEMIB
         uLR/A8CMrjSmS5ymZZuojL31tKhT6mDCDNm4cyrccaZysPsOHPw1DpuVfd12qLhRwitg
         Zg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/b4pvVKBosaMZz+EmQWoH+hiG810FwCQCYfzBZ6hw4=;
        b=PguaAe6ElYupqQAZ+zNHGIBCnHsJxmjpFDKLhHV4FXIIuIlMnDsacSb6Z+WBwvMRyf
         30/yIdsZIYWHfJdD8C1cr7Veeir+kxuMTATW9NQM6xYJnbWn5YZ+6eIkAOkKp9hhyzez
         TzVYqTOnvZV31AQeBnzBUwyO+iBh7nQB1SnU8vlxFY0nO+F1b2TKAggDTwlk5D90v9as
         dCQrQCCx9AHmYLgv8HL6VYYyCTeLfpDO67DHCz26KIkuYdmRFDO6pBQ/ZuxCn1q3eVGW
         96VHSJHQzhWQ6caKxb3mO+vgbIYNq2JmihnjfFg4/D33ZPHUwj0ObAHSC0BDMQvpbtyi
         cHqg==
X-Gm-Message-State: AOAM531m7fTYcfEYJJdOulqEmUmaRXbMGqMpQtwuuZR9SUZPcKfUYzra
        xgdByJLekAJ0NopICyvhKjE=
X-Google-Smtp-Source: ABdhPJxmmZGg88WJbyoXDCYhPhfQzcspxilUx9iNqACtmsOzG1ZFjoM1UYDJhkYwU0hBfImvAJQszw==
X-Received: by 2002:a05:6a00:88a:b0:4df:f3a9:b246 with SMTP id q10-20020a056a00088a00b004dff3a9b246mr4022911pfj.83.1645032831407;
        Wed, 16 Feb 2022 09:33:51 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id c17sm47480619pfv.68.2022.02.16.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 09:33:51 -0800 (PST)
Date:   Wed, 16 Feb 2022 23:03:48 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216173348.luidfddtou6yfxed@apollo.legion>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 09:15:47PM IST, Alexei Starovoitov wrote:
> On Wed, Feb 16, 2022 at 1:13 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
> > function") added kfunc support, it defined reg2btf_ids as a cheap way to
> > translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
> > however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
> > PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
> > member of bpf_reg_type enum to after the base register types, and
> > defined other variants using type flag composition. However, now, the
> > direct usage of reg->type to index into reg2btf_ids may no longer fall
> > into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
> > and kernel crash on dereference of bad pointer.
> ...
> > [   20.488393] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000524156
> > [   20.489045] RBP: ffffffffa398c6d4 R08: ffffffffa14dd991 R09: 0000000000000000
> > [   20.489696] R10: fffffbfff484f31c R11: 0000000000000001 R12: ffff888007bf8600
> > [   20.490377] R13: ffff88800c2f6078 R14: 0000000000000000 R15: 0000000000000001
> > [   20.491065] FS:  00007fe06ae70740(0000) GS:ffff88808cc00000(0000) knlGS:0000000000000000
> > [   20.491782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   20.492272] CR2: 0000000000524156 CR3: 000000000902a004 CR4: 0000000000770ef0
> > [   20.492925] PKRU: 55555554
>
> Please do not include a full kernel dump in the commit log.
> It provides no value.
> The first paragraph was enough.
>

Ok, won't include next time.

> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Fixes: c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e16dafeb2450..416345798e0a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5568,13 +5568,21 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
> >         return btf_check_func_type_match(log, btf1, t1, btf2, t2);
> >  }
> >
> > -static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> > +static u32 *reg2btf_ids(enum bpf_reg_type type)
> > +{
> > +       switch (type) {
> >  #ifdef CONFIG_NET
> > -       [PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > -       [PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> > -       [PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> > +       case PTR_TO_SOCKET:
> > +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK];
> > +       case PTR_TO_SOCK_COMMON:
> > +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
> > +       case PTR_TO_TCP_SOCK:
> > +               return &btf_sock_ids[BTF_SOCK_TYPE_TCP];
> >  #endif
> > -};
> > +       default:
> > +               return NULL;
> > +       }
> > +}
> >
> >  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> >  static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> > @@ -5688,7 +5696,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                         }
> >                         if (check_ptr_off_reg(env, reg, regno))
> >                                 return -EINVAL;
> > -               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
> > +               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids(reg->type))) {
>
> Just use reg2btf_ids[base_type(reg->type)] instead?

That would be incorrect I think, then we'd allow e.g. PTR_TO_TCP_SOCK_OR_NULL
and treat it as PTR_TO_TCP_SOCK, while current code only wants to permit
non-NULL variants for these three.

--
Kartikeya
