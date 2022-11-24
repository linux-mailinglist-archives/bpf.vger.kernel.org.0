Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82CD637163
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 05:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKXEJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 23:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKXEJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 23:09:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79652B38AA
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 20:09:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m22so1484709eji.10
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 20:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBqfnUR/XMDHvs81b+16ZpgnXNq0nAMq9oURJQhzXL8=;
        b=mbr0thyOz1ei/CX8aYeibUr2Z7QfvzPYg6L0eQqEci1SiFtSQEnB7wsXWGvhWTNGyp
         uuGVZmblKxLbh/bFR/bSVx7swUSk/SRgGTXXp/6Qfvy8BKrZF5Jc+EQQHuH+TxzIPL0q
         sDE/B/P0gI7+UzqAcKzgF4bko00aIZRJDgDGfdJv+W2z1i50NqvudINIVAETmL0bzbbw
         4pYxTUYLZZBrzH3+oB0nKrmdmL1GVAFClYL4KNdCCs5V4aYggEct0Ee7JIVcx/kp9wPW
         obvxmbWMM7vw4+qM4rreDYq8Mcj1nep6jIw2885E6phLVVx8fP5c3lh6fg0YHdO+sZzP
         81Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBqfnUR/XMDHvs81b+16ZpgnXNq0nAMq9oURJQhzXL8=;
        b=eMVI4/vFDRjdIAEskciSBxiXAWZD3OZZchDlYHzpnifxGTRLhnRO4DyFx3lZ0CcR0/
         ovdO0qWMh3r9H0M70fPPZ2TLqHJi1j4cKR5hFxadyNi9WcvTeneun2hbS7Sd7MaAs0Nu
         Sp+BsSLjLDYAo+HnD+GaK40QXFM0DgNrrC7QYTmnoyMa6moXRLhEEq5kEQbaOSrhmbMJ
         SVaMgNK5riPme29Uv92ktZuAGDJX4oo0VBsCD75sL4a6IHD9OhdQG+Swxez/0nvve8NX
         HVDYOLOQElG2p1HJ9aL5vTywZvvR2RB5NvaLdOEEW7s5DW4Vo+JuQlYBmneRRUaC3ucs
         3Xmw==
X-Gm-Message-State: ANoB5pnVHZupi3MLFoYVv4aSeWfZvZ4OdOCAli8oYsKiQzohv9BdJ0xB
        ghXdJEiowjQwV8V3l1+c3NC7gdtX4tGWHNrlhOpZijdyxuQ=
X-Google-Smtp-Source: AA0mqf6SP2ElzwgLJ6fKddTfliHgu2NHfoqWPO1/QC6MGz943+Qh2eyejWIMjGCG0Qzyxn9WSdwPHdVCLtmn/I6CWNY=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr12498323ejm.708.1669262960836; Wed, 23
 Nov 2022 20:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20221123045350.2322811-1-yhs@fb.com> <20221123045406.2324479-1-yhs@fb.com>
 <CAADnVQJGx=8Hdd_fzV=jt7n_zo9GwG5O5a3S4V4JJiM3YpxSkw@mail.gmail.com> <37b640ad-7258-adb8-7cec-23ae776f5764@meta.com>
In-Reply-To: <37b640ad-7258-adb8-7cec-23ae776f5764@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 20:09:09 -0800
Message-ID: <CAADnVQ+uoW+G9Uts3B1q=9Qxws3+dmLqUUWSVaeRgRYLvNkkQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 6:57 PM Yonghong Song <yhs@meta.com> wrote:
> >>
> >> +       rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
> >> +       rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
> >> +       if (env->cur_state->active_rcu_lock) {
> >> +               struct bpf_func_state *state;
> >> +               struct bpf_reg_state *reg;
> >> +
> >> +               if (rcu_lock) {
> >> +                       verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
> >> +                       return -EINVAL;
> >> +               } else if (rcu_unlock) {
> >> +                       bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> >> +                               if (reg->type & MEM_RCU)
> >> +                                       __mark_reg_unknown(env, reg);
> >> +                       }));
> >
> > That feels too drastic.
> > rcu_unlock will mark all pointers as scalar,
> > but the prog can still do bpf_rdonly_cast and read them.
> > Why force the prog to jump through such hoops?
> > Are we trying to prevent some kind of programming mistake?
> >
> > Maybe clear MEM_RCU flag here and add PTR_UNTRUSTED instead?
>
> The original idea is to prevent rcu pointer from leaking out of rcu read
> lock region. The goal is to ensure rcu common practice. Maybe this is
> indeed too strict. As you suggested, the rcu pointer can be marked as
> PTR_UNTRUSTED so it can still be used outside rcu read lock region
> but not able to pass to helper/kfunc.

This is the part where gcc vs clang difference can be observed:

bpf_rcu_read_lock();
ptr = rcu_ptr->rcu_marked_field;
bpf_rcu_read_unlock();
ptr2 = ptr->var;
here it will fail on clang because ptr is a scalar
while it will work on gcc because ptr is still ptr_to_btf_id
and rcu_read_lock/unlock are nop-s.

Making it PTR_UNTRUSTED will still have difference gcc vs clang,
but more subtle: ptr_to_btf_id|untrusted vs ptr_to_btf_id.

So it's best to limit new kfuncs to clang.
ptr_untrusted here is a minor detail. We can change it later.
It feels that ptr_untrusted will be easier on users
especially if we improve error messages.
Say that ptr2 above is later passed into helper/kfunc
and the verifier errors on it.
If the message says 'expected trusted ptr_to_btf_id but scalar is seen'
the prog author will be perplexed, because it's clearly a pointer.
'Why the verifier is so dumb?...'
But if we do ptr_untrusted the message will be:
'expected trusted ptr_to_btf_id but untrusted ptr_btf_id is seen'
which may be interpreted by the user: "hmm. I'm probably doing
something wrong with the rcu section here'.
