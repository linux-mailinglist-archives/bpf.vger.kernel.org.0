Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2067B6A5
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjAYQNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYQNc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:13:32 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EA3EFE1;
        Wed, 25 Jan 2023 08:13:31 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15f97c478a8so21877948fac.13;
        Wed, 25 Jan 2023 08:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTCa2vo9i3IBnK5+rd9IFa4vMJNUSl/n6ZWkom8taS0=;
        b=LGXmc+7qa90BRAQshm1bvTSn5RjXArZ1JsUUhQgv/WLF4Ek82ogc1PwOeBSjE2FRSJ
         sEh+ZfkamISHFKJZVJbrM55gzukc+V6P17dDapsBwzYk43E55h6zf2xD1z2Lx+k7X+7v
         OnesAhGCAIlWlaMOEXf0S+LDI0Wtpr/Rr6IqYFeasr04Y6HyKsjaQ/XZOKjjxoZ8MqSJ
         yeBmD+3Qnwd5ezP1vISjrI7N9BqyDcLwwJlmuDoHXbP/t/oEYJVA6A2OU26iegalAhGs
         7ei4kuK+/EYzvU8swDg7DLScg2pV0Nq0uL0imZJmeGrUgmZ7ell9K3O3K03hJxwNboZu
         mbGg==
X-Gm-Message-State: AO0yUKUG22wkqJdWXmAHHaClGf9S9yLHqXyn4raH4+AJP9rlsSQoFDCm
        SR1LmLZi51rEKrUGH+3ttos=
X-Google-Smtp-Source: AK7set85967Uk9TtaN3rp2BoksbIi2nkImEVWAAxvT/nsm7tovrMjskLQGR4R6w6UFCs/Wxcqpo40A==
X-Received: by 2002:a05:6870:d248:b0:163:2054:44db with SMTP id h8-20020a056870d24800b00163205444dbmr3347258oac.30.1674663210437;
        Wed, 25 Jan 2023 08:13:30 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05620a318b00b007090bb886a2sm3854016qkb.118.2023.01.25.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:13:29 -0800 (PST)
Date:   Wed, 25 Jan 2023 10:13:26 -0600
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
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Enable cpumasks to be queried and
 used as kptrs
Message-ID: <Y9FVJjbBvIjwwd0S@maniforge>
References: <20230125143816.721952-1-void@manifault.com>
 <20230125143816.721952-3-void@manifault.com>
 <CAADnVQLtNJ7DYsvzZ0q3So-8PxywiCC4pmV0xKhkDZiw+jx=4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLtNJ7DYsvzZ0q3So-8PxywiCC4pmV0xKhkDZiw+jx=4A@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 08:01:49AM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 25, 2023 at 6:38 AM David Vernet <void@manifault.com> wrote:
> > +
> > +void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> > +{
> > +       if (!cpu_valid(cpu))
> > +               return;
> > +
> > +       cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
> 
> I was considering suggesting to use &cpumask->cpumask here and
> in other cases, but figured it's better to leave it as-is,
> since bpf prog will be doing this cast, so it matches.
> Maybe some build assertion is necessary to make sure it's the first member.
> Probably overkill as well.

IMO a build assertion is a good idea. Serves as documentation and a
sanity check. I'll send it out in a follow-on patch, unless you really
think it's overkill.

> 
> Applied.
