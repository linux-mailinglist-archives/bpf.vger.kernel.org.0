Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41B457BAB6
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiGTPn7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGTPn7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 11:43:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230761727
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:43:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z3so2949597plb.1
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGsJvuFK1P0StUNe4EMXnCR7wiiqG/+GDn6WchLqHp8=;
        b=asnvw1gCOlFRHjdtSz7cx8/mp4qY6YP7uJ62xo4jElVwEL4T3Rr4TPYFc3QLPYMZNm
         OniyfT7Af4h5gqHpJOsj7vAnl/KIXHHokk/PluEhn9jLWvydfgUpYTbAqGqCh7rf2wW9
         jKOxae0hF6RARLJJhvUUFTbGF2SVPjEbd8/bmVJP4t5BVeZQGZnUKmYB+ObD4+KL8Wul
         8KejwjHD4m6dxtrQ6lsxKi6lVhozihcjRx3Z52AXr60C1csw0YbYgKLzQs3hJmIjT624
         a6qYKXuwrEW1ng+mHIjDITmkdF17TuO0ITFC/3YDSVDz3/g7VCrY+Tz6AF0UZEQGYkOB
         pt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGsJvuFK1P0StUNe4EMXnCR7wiiqG/+GDn6WchLqHp8=;
        b=bdesd/zwAeyN74fL4z6L41hw3FEwle/64mCqfb3YQjI9q3YXVyqvNqIrHFEuwZv3Xq
         CRQce6lkWcbO22n0QQ3kPIZhEKC9C/i+7RMzXYSEvDpa6PJwpDukt6xyhNq3KaWDVkV5
         wxeL1k5dszVhzzHbqeejeARRuR/1QbrERYGuwHjcMFdJ0f2bYxywZhz9jNenmUx6Hntw
         +IeJum3Ox56RmHpPFN8Ox4V8QonpqWb0zB4ozfz0l7uPNfS7PdP45EqrA84Qa8PpRIg8
         84tVh48vBLgAZmNoFwz8NwGcpH43YqYCQKtAne7lcsVLzuQX13vqiJLTNaxR31mqavSm
         KLHA==
X-Gm-Message-State: AJIora9iGbrfiYhOfTA8trBhcnho8VAblqKHfjw5VpFr8ChzgKGknppZ
        QyVUWKuJX6Dste4WUMTHIU/ItRDMZigr9ALtDodguA==
X-Google-Smtp-Source: AGRyM1vyz27Bi5RQTT3r9/HkOnlcWVGN1osnp7RUWGYD533P0CfYo3YTTMwoNdH3u0qcH5jRSO17hw33jQLxBXKY+Lc=
X-Received: by 2002:a17:90b:4b01:b0:1f0:1aa7:928 with SMTP id
 lx1-20020a17090b4b0100b001f01aa70928mr5980124pjb.195.1658331837692; Wed, 20
 Jul 2022 08:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220720034954.3032878-1-sdf@google.com> <20220720054013.tqe5fmhcbow45am6@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220720054013.tqe5fmhcbow45am6@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Jul 2022 08:43:46 -0700
Message-ID: <CAKH8qBtUOMpz2QP0WZHwEzcsOwdWrcqvAHAzuR91_GFC4UNpvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix bpf_shim_tramp_link_release ifdef guards
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:40 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Jul 19, 2022 at 08:49:54PM -0700, Stanislav Fomichev wrote:
> > They were updated in kernel/bpf/trampoline.c to fix another build
> > issue. We should to do the same for include/linux/bpf.h header.
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/bpf.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a5bf00649995..0ff033afe0ad 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1256,7 +1256,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  #endif
> >  int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> >                                   int cgroup_atype);
> This link_cgroup_shim also needs to move ?

Doh, definitely! Thanks for catching this.

> > -void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
> >  #else
> >  static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
> >  {
> > @@ -1285,6 +1284,11 @@ static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +#endif
> > +
> > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
> > +void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
> > +#else
> >  static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
> >  {
> >  }
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
