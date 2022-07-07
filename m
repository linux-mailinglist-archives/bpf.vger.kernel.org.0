Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9F569FF4
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiGGKa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiGGKa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 06:30:28 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C11564F3
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 03:30:26 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id d6so2237141vko.11
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNt1u7R+eN/x3tIuhIyGJhKuokTR5Zn4HsNjpIKWO9w=;
        b=ifzYQYeHcS9UTCVMztgbre4Kl7knMGfpYmbp/qAVuj6OQX1IqUuFWPehUhfuukSBPV
         mpihsshtAqM6NAb5JYC/dt+CjlMfgHhVzYvUsDQUevmOT1lJlHQgk9uipA1h+6QZhyDd
         LVddxYN+JKJuThHxLXt6dQQwoo/zqKrLbJ9QuPS8uLDhrg5CC9yBK2mEnvdom42WhVdy
         6qrUcv7adCR7/I3wFc36+qObmk3ZFmPEPDWZxssq3CAOTDiz5P9lPIHehPpLKNqMkkyI
         VPp0JbSMUZDb+UtnR3ZviWd75SvvSN9tN4XaMdaRoMTyPcjLjJUUF/o9U53WucclBXdF
         QQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNt1u7R+eN/x3tIuhIyGJhKuokTR5Zn4HsNjpIKWO9w=;
        b=DzK6FNDKRapcWVAgK87cuHqLDW+6lNseQTdXIcgl4QZDmiEcMPorQJzxzsPtEac9OM
         dc2ZTjhoxdtbmP8L2r1F+dOBFr9u52wj/lY2PvWVMesFlXcrgBDhQaKIFdojBH95wgEV
         FLgQRg7vWY4HTa4IEcKw79ouJSWaulJHXoA2NgBR3ly9jmyKaN115jcWJ1dOwklGG9UH
         kJQ78R33pvfqhIytomRdZnMhX4frF6FbU28mCfWS2hV3hVdGZmW3Lr4OJRjqqmMS2xUK
         zX3EwnJTDUlKtKG/BXeRYmoosEzVkD6fIenyPVTm3CS94vWdGmyKMwwT23RPqhXtao0o
         Se5Q==
X-Gm-Message-State: AJIora9lM7p7VvyM+J83zT6HBTQOFbwU5yGGHvN4tUhWVNIuxkOKjdlL
        KPaJvNM7ENYKMujmhXO9jD8QChbP5nzYFcbmDyPJ+lzdSYFxJGsY
X-Google-Smtp-Source: AGRyM1utikq+PryJRTKyb6gB5KS4/sYQLvYxZ+RUZtw19TF8lZbhuB9N0gvKFcZfh2VV6s75CjgfprzgFIdIIWpny1Y=
X-Received: by 2002:ac5:cc4c:0:b0:374:502d:85f4 with SMTP id
 l12-20020ac5cc4c000000b00374502d85f4mr1414185vkm.8.1657189825110; Thu, 07 Jul
 2022 03:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-3-laoar.shao@gmail.com>
 <CAADnVQLHDATCgQE39nVTy-LE+Mhx-hXbj8phBeyUKFc1f=W-6A@mail.gmail.com>
In-Reply-To: <CAADnVQLHDATCgQE39nVTy-LE+Mhx-hXbj8phBeyUKFc1f=W-6A@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Jul 2022 18:29:48 +0800
Message-ID: <CALOAHbDN3zv0Tx+poM5jH_AHR7HzVLag8534QdS07c2U_rVtbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Warn on non-preallocated case for
 missed trace types
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

On Thu, Jul 7, 2022 at 12:50 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE and BPF_PROG_TYPE_TRACING are
> > trace type as well, which may also cause unexpected memory allocation if
> > we set BPF_F_NO_PREALLOC.
> > Let's also warn on both of them.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index df3ec6b05f05..f9c0f4889a3a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12570,6 +12570,8 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
> >         case BPF_PROG_TYPE_TRACEPOINT:
> >         case BPF_PROG_TYPE_PERF_EVENT:
> >         case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> > +       case BPF_PROG_TYPE_TRACING:
>
> BPF_TRACE_ITER should probably be excluded.

Right, I have verified that BPF_TRACE_ITER can be excluded.
Will change it.

-- 
Regards
Yafang
