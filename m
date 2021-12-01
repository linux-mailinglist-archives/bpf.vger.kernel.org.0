Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B346596C
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbhLAWnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 17:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353690AbhLAWnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 17:43:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141EEC061748
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 14:40:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so107951658edx.2
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 14:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfIZoz2xAzJu9RJOcxVN05bOnQSiOzrtGJ6tZtujJ7k=;
        b=ke/buHpkMGIU8nJsWW8PSZuSAK7uIWC/r6SbtBu4Uv/24qVZZSyRTxMKrkNWAo+i3H
         +2GLeNy2KDcNTt+zsDwg3Xl3Qn55wJYq6MtvXm8NsvMKifW1b1JLwAfZe3oxyV2Ind6k
         hBdnxEJm1cTSJJEcP8s2HMt4aPI/wqj7duhPdWsP9x2v+ckLuXImOh7veOQmW+706Ar7
         91rrX9t2StQW4DQuSGmsk41e8ZwK3ghHxur5wu1qyQktK2BHkm4IDQQtldxyUNvaazFx
         888Z+dIzEV0iz8xaZJ03qyzXpngU1jZ+btGXsb8LcJHznAuhYKPRcilr02kzELcylUbS
         7nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfIZoz2xAzJu9RJOcxVN05bOnQSiOzrtGJ6tZtujJ7k=;
        b=aBWHkNuy8QnHHF5EwFDkjT3X5kSCmUgXbla67lm8zH46DuKzT/hHo0gHduCYuqFiIl
         wB6fFKflNsZxu8ie3jLY7MF0hWB5UyDKJBjtIkZefR6yZVDNGXI1UTVZhUQMCJXOHOMD
         2aO2som3dDHQrG0wyKS92pf++DxfvWhgQLkWgwcXZRv2N/p/ojaZzQRLOZhEYzWtjDjT
         ac94SkgBCbrc1MwH0k+PVH0828fyYdFzxH9cf7EapnZ5S99MlAlCrnvQwIVsVZsq8Msg
         NFCnRRt2pSrlfyWLKjBKuJ3hdNvhyOZDVugxArVeW3PNsnnHG+4ajpp/c3pjpIasLG6j
         ChCw==
X-Gm-Message-State: AOAM533WIbrNKqkailyrsByLrb8H4xLhNYwZgVEiRYvjlwPAIiH4KnUk
        E1lsra6UOCX3DtKnxs9LLC/H0Y5hmZqpEDJ3PxA8ag==
X-Google-Smtp-Source: ABdhPJwcQm80JXZ9dN+4odxG+WqdpUV/QCphx+Zj2vxhdc55hbIzo8yH8LoaeH7WwX075CWWylAaJW1rMyEGBbFVJZA=
X-Received: by 2002:a05:6402:1a27:: with SMTP id be7mr12352590edb.187.1638398423438;
 Wed, 01 Dec 2021 14:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-4-haoluo@google.com>
 <20211201203046.saxv5hl7zz3wzyvv@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211201203046.saxv5hl7zz3wzyvv@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 1 Dec 2021 14:40:12 -0800
Message-ID: <CA+khW7ibeg4fGz1D=aZ8yF6me0_yif_Hm_FHA=+RPxw+YnW=tA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/9] bpf: Replace RET_XXX_OR_NULL with
 RET_XXX | PTR_MAYBE_NULL
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 12:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 05:29:42PM -0800, Hao Luo wrote:
> >       /* update return register (already marked as written above) */
> > -     if (fn->ret_type == RET_INTEGER) {
> > +     ret_type = fn->ret_type;
> > +     if (ret_type == RET_INTEGER) {
> >               /* sets type to SCALAR_VALUE */
> >               mark_reg_unknown(env, regs, BPF_REG_0);
> > -     } else if (fn->ret_type == RET_VOID) {
> > +     } else if (ret_type == RET_VOID) {
> >               regs[BPF_REG_0].type = NOT_INIT;
> > -     } else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
> > -                fn->ret_type == RET_PTR_TO_MAP_VALUE) {
> > +     } else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_MAP_VALUE) {
> >               /* There is no offset yet applied, variable or fixed */
> >               mark_reg_known_zero(env, regs, BPF_REG_0);
> >               /* remember map_ptr, so that check_map_access()
> > @@ -6530,28 +6536,27 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               }
> >               regs[BPF_REG_0].map_ptr = meta.map_ptr;
> >               regs[BPF_REG_0].map_uid = meta.map_uid;
> > -             if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
> > +             if (ret_type_may_be_null(fn->ret_type)) {
>
> it should have been ret_type here?
>

Yes. I think fn->ret_type and ret_type are the same here. I can
replace it with 'ret_type' in the next version.

> > +                     regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
> > +             } else {
> >                       regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
