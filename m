Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4856A73A
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGGPqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGGPqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 11:46:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F803055D
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 08:46:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dn9so27851388ejc.7
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGEBbie67q5TXwVzOJXE7BN9/2n5IbFsl2IvZ4cbCcE=;
        b=goedwjqoQ2sWlaUqLeZOrUhs9AKIg6BJq+VcnIzpR1u4OlsdoPmMpxHBA9CcgJ9MX5
         PmHiYlknW7+KelZITx2/4lh2ZDUAnpw7fAJJFeKYeVsmH38K89R19JRmSOj3YDv1jFKp
         2RBHLdGI3tfrNTKyxXrZ69PzqvIWdKuuPnWa2yOX9l0lY5wnEDnn5ti/DZhRtfHy8b+v
         IZPIqjGYppqtz85aS79S3+ghWXUfwPpXo4NCiGmJHR64TZcFomqUaKB/IwFHi/ePliVE
         nsiK1IgzHoz99SPUGNpom4RH+INBgM5xZl19Na5tWdpHaL31LladA73UBA8Y6E/cY2So
         Mp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGEBbie67q5TXwVzOJXE7BN9/2n5IbFsl2IvZ4cbCcE=;
        b=cXWMPaT2720SPHHORZFAmvEpDwPx67hl9bsBbeEa84KhrNlOME4Rn77y+VqoP/pHwr
         Mc42tWJcjHLeh/zKd9LuufzsfEzchl8lmlIfVMSW+1PFWRTS9qihfGpw6CMEZ+DbtV2q
         BCHQ6Nipq0YFFYZADDIx9j7Y3eTEgYVhBNPiQK1Cq+HYxeSeOzChwKkFR6028W2o4OLv
         g9HSzItq10CDtk8JzE3nJ4pKglZ0Gs5RGZFOqDsvTLOxTm5aAMD//igyeSPkvLdajorY
         qBlmx96lRZrlD5JiHAC1qpRM3BC7Pec72C/doIb9G6U7IjQ/P8T+4eREM0RfR3LtZtKd
         n9mw==
X-Gm-Message-State: AJIora+mF9eawQM777rreyiXSn6Jo59/fZWpzCo1esigEzqzJfShpA3i
        YmdLsH1UmeB3SLPQ1k5lSbKGxFip2655NyaRw1Q=
X-Google-Smtp-Source: AGRyM1ulov115nvGKkxiMqWRfqRf9lMLJAh+4WYm5LVfsH1/Jtb5ZM5HC+/wR6bk6c3DyxMzSfz2E2Z0x67JEWIJWPc=
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id
 y9-20020a170906518900b00722dc81222amr45443816ejk.502.1657208759039; Thu, 07
 Jul 2022 08:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-3-laoar.shao@gmail.com>
 <CAADnVQLHDATCgQE39nVTy-LE+Mhx-hXbj8phBeyUKFc1f=W-6A@mail.gmail.com> <CALOAHbDN3zv0Tx+poM5jH_AHR7HzVLag8534QdS07c2U_rVtbQ@mail.gmail.com>
In-Reply-To: <CALOAHbDN3zv0Tx+poM5jH_AHR7HzVLag8534QdS07c2U_rVtbQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 Jul 2022 08:45:47 -0700
Message-ID: <CAADnVQJX-ODKvV3XT1i=0jHBTpgWb0UTmWU5hGn9D4VTiZQUrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Warn on non-preallocated case for
 missed trace types
To:     Yafang Shao <laoar.shao@gmail.com>
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

On Thu, Jul 7, 2022 at 3:30 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 12:50 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE and BPF_PROG_TYPE_TRACING are
> > > trace type as well, which may also cause unexpected memory allocation if
> > > we set BPF_F_NO_PREALLOC.
> > > Let's also warn on both of them.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index df3ec6b05f05..f9c0f4889a3a 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12570,6 +12570,8 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
> > >         case BPF_PROG_TYPE_TRACEPOINT:
> > >         case BPF_PROG_TYPE_PERF_EVENT:
> > >         case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > > +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> > > +       case BPF_PROG_TYPE_TRACING:
> >
> > BPF_TRACE_ITER should probably be excluded.
>
> Right, I have verified that BPF_TRACE_ITER can be excluded.
> Will change it.

Probably more than that. See that your change broke BPF CI
and selftests are failing.
Which means it breaks existing bpf programs.
