Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8210065485B
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiLVW0D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 17:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiLVW0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 17:26:02 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E01AF0F;
        Thu, 22 Dec 2022 14:26:02 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id b189so3019455vsc.10;
        Thu, 22 Dec 2022 14:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkWzqdI4Ao/+eVXLfPWUg98sZ0/cE4H62K67j4Goqj8=;
        b=iEF2E45WYSiHPz6GVI7qBefO4C0uOy5YXfmuIzCRND8a4TYbPscY0QrjhTXrDQpXdo
         5NMJRXg1Xhp93ucEtlN9ErDxGPNvisjFXYvR70WCuY+QxjmqqRXssDJquVaGr822iBnB
         vouQsxC/7JvWnUeSacxZRw68LtNzS07hWK12aXj33pibEb+Fhrso/4glRKnrjDZ4+2j9
         D3Fn/4Q4wVcvdnBcFF9+FgjUMOhKB7bMOunPd9LTmQPqDZU+WaciZU4fEQH/Th/I7KxT
         g8RHJYr8nNd9Sp1bR+bLuzNrEdrK5AQn5oBxkTNbAb3yOVPGcVcdM0/VeH9MBlt3xlZZ
         UMLw==
X-Gm-Message-State: AFqh2kp+Aw5Glv9oHS1kkYNOmfSuoAA7Wb3HUPEWcDAcrzLlaEpZbMka
        YJ+8W1ve6wljwSp8EDfraqVoQsb00YgRJGP6ar8=
X-Google-Smtp-Source: AMrXdXu92x7/g1eEEZfwE8ES3ruQ0C87z/T6TNu8N8wO0AT01JLWu3vII7c0sqg9sj3/3qajTrcmF429sUadsrPfWVc=
X-Received: by 2002:a67:eace:0:b0:3b1:30fb:e106 with SMTP id
 s14-20020a67eace000000b003b130fbe106mr705520vso.55.1671747961063; Thu, 22 Dec
 2022 14:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221220220144.4016213-1-namhyung@kernel.org> <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net> <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
 <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com> <Y6S7BcblAHO4nQTf@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6S7BcblAHO4nQTf@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Dec 2022 14:25:49 -0800
Message-ID: <CAM9d7chi6ijPEwkTbmLJGz+_fQFvnFxwc44M-g93ym2-ZPN9tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before bpf_prog_run()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 12:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 22, 2022 at 09:34:42AM -0800, Namhyung Kim wrote:
>
> > Sorry about that.  Let me rephrase it like below:
> >
> > With bpf_cast_to_kern_ctx(), BPF programs attached to a perf event
> > can access perf sample data directly from the ctx.
>
> This is the bpf_prog_run() in bpf_overflow_handler(), right?

Yes.

>
> > But the perf sample
> > data is not fully prepared at this point, and some fields can have invalid
> > uninitialized values.  So it needs to call perf_prepare_sample() before
> > calling the BPF overflow handler.
>
> It never was, why is it a problem now?

BPF used to allow selected fields only like period and addr, and they
are initialized always by perf_sample_data_init().  This is relaxed
by the bpf_cast_to_kern_ctx() and it can easily access arbitrary
fields of perf_sample_data now.

The background of this change is to use BPF as a filter for perf
event samples.  The code is there already and returning 0 from
BPF can drop perf samples.  With access to more sample data,
it'd make more educated decisions.

For example, I got some requests to limit perf samples in a
selected region of address (code or data).  Or it can collect
samples only if some hardware specific information is set in
the raw data like in AMD IBS.  We can easily extend it to other
sample info based on users' needs.

>
> > But just calling perf_prepare_sample() can be costly when the BPF
>
> So you potentially call it twice now, how's that useful?

Right.  I think we can check data->sample_flags in
perf_prepare_sample() to minimize the duplicate work.
It already does it for some fields, but misses others.

Thanks,
Namhyung
