Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E098C6888FC
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 22:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjBBV1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 16:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjBBV1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 16:27:54 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE76EADA;
        Thu,  2 Feb 2023 13:27:53 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id g8so3485863qtq.13;
        Thu, 02 Feb 2023 13:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn6+kyK883Ko/a6fWx7kKiKyXEuphEAhRIxLjNFQxS4=;
        b=uw4cnPSoTYlz/CiKiZxjwKGRUkfGbp55vKWLBvEVu0iZXF5QtHjELG0Wgn8bRynHfd
         3HXRghcVwjJoleCdacOVDMsVODSzqjpZgR4xY3Qb5WUAtNL5SKjpR34KXW8GTE9XVDkI
         PWD7IT062tGZ/7DP/l7+w8niWEkrJfst57x5qIPMTXolP5f0LZGnsJs8dJkA4aadXhsf
         /4XLGowUmBDsriJZ4Ak8x3ZaEy4lQ6fpNdtSBEdqbGNc8nxFL2roHWaKiGjafVVV5R8k
         v6VGFDb54UjvSL0sAaIQFWWxR0PWOJWwujaabgv5CFOiX6+vwW78+5dmyeDD1n4za63i
         Ib1g==
X-Gm-Message-State: AO0yUKWEkukLU4mCHqiOJrbm7TX1nAqoUiIneHg+QvTk+KlkJr8SESil
        mrLZWjuNJRDU3KwZSBBNTfg=
X-Google-Smtp-Source: AK7set9icixfKli7wGDEXOE1Jk8blfc3+y1oet8BhePhE5usePpzNtn60ivXkWfr9LMPwn0inXN1HQ==
X-Received: by 2002:a05:622a:d2:b0:3b6:2dc7:de7d with SMTP id p18-20020a05622a00d200b003b62dc7de7dmr14353979qtw.22.1675373272172;
        Thu, 02 Feb 2023 13:27:52 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:9cc7])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006f9ddaaf01esm488573qkp.102.2023.02.02.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:27:51 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:27:48 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
Message-ID: <Y9wq1Fy8sgpGB+pe@maniforge>
References: <20230202163056.658641-1-void@manifault.com>
 <20230202163056.658641-3-void@manifault.com>
 <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 01:21:19PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 2, 2023 at 8:31 AM David Vernet <void@manifault.com> wrote:
> >
> > Now that we have our kfunc lifecycle expectations clearly documented,
> > and that KF_DEPRECATED is documented as an optional method for kfunc
> > developers and maintainers to provide a deprecation story to BPF users,
> > we need to actually implement the flag.
> >
> > This patch adds KF_DEPRECATED, and updates the verifier to issue a
> > verifier log message if a deprecated kfunc is called. Currently, a BPF
> > program either has to fail to verify, or be loaded with log level 2 in
> > order to see the message. We could eventually enhance this to always
> > be logged regardless of log level or verification status, or we could
> > instead emit a warning to dmesg. This seems like the least controversial
> > option for now.
> >
> > A subsequent patch will add a selftest that verifies this behavior.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  include/linux/btf.h   | 1 +
> >  kernel/bpf/verifier.c | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 49e0fe6d8274..a0ea788ee9b0 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -71,6 +71,7 @@
> >  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> >  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> >  #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
> > +#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
> >
> >  /*
> >   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4cc0e70ee71e..22adcf24f9e1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
> >         return meta->kfunc_flags & KF_RCU;
> >  }
> >
> > +static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +       return meta->kfunc_flags & KF_DEPRECATED;
> > +}
> > +
> >  static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
> >  {
> >         return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> > @@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                         mark_btf_func_reg_size(env, regno, t->size);
> >         }
> >
> > +       if (is_kfunc_deprecated(&meta))
> > +               verbose(env, "calling deprecated kfunc %s\n", func_name);
> > +
> 
> Since prog will successfully load, no one will notice this message.
> 
> I think we can skip patches 2 and 3 for now.

I can leave them out of the v2 version of the patch set, but the reason
I included them here is because I thought it would be odd to document
KF_DEPRECATED without actually upstreaming it. Agreed that it is
essentially 0 signal in its current form. Hopefully it could be expanded
soon to be louder and more noticeable by not relying on the env log,
which is wiped if the verifier passes, but that's separate from whether
KF_DEPRECATED in general is the API that we want to provide kfunc
developers (in which case at least 2 and 3 would add that in a
non-controversial form).

Let me know how you'd like to proceed. Either just removing patches 2
and 3 and still mentioning KF_DEPRECATED, removing 2 and 3 and removing
any mention of KF_DEPRECATED, or leaving 2 and 3.
