Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE34BD140
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiBTUUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 15:20:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiBTUUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:03 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD94B40B
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 12:19:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d3so8551315ilr.10
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+awnre2X2SVMnDE+UV+bHywx1/00lE7vKuMBP7lAtE=;
        b=Hs0U+t3O+FAr+IGjoQV37/LJ66hVV7H04xx7//bNkS5mWH0Js2lR3xoBAPRRSoj/yR
         WXy9PQbrRHaLTnqu2o+yhDB9MqtfBC1jwHIUpXg4I2cO/ZHVJolcee1f2CGh5tvmn3bG
         4oaBtBSP0evtQba/h59isL51fsuAsdqxoMAmuNB3E6U8hQNTC3g5QeTryRVhx229HgqA
         9jJZIk2gB109pZ6uOUmktxQ896wxZO9re3jOklG7c3PzloQf4YafiPppCMvDJKUoN2KQ
         DXCbvKWqQ35JPXaGFGzmsAojC+HStK3Y6rsjIK8NjJbd32f5vla8hYHta1gBMDzAx234
         fYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+awnre2X2SVMnDE+UV+bHywx1/00lE7vKuMBP7lAtE=;
        b=yh0y17NYlL/J/wXLgK0H4cU6YaELKLTgRAmIBiWbw4JHgAa9mAhmmM9x1L2f90ib3A
         yTGcQSLK/gBOjqYw/pJePwRRjagUrocuBErYG7Bice8uu8S5IOJ4g0RpYjwlCf51dtoX
         ugR9bw8gV6MOdooLuK3Q9zOEnsidb9CxsCP5MuoAFSyUzOkGoCXSHXQXC42wtFeFIlYR
         AoEY1K+x6rqS4vG/SHoesyiT2qd7CPHklbFJUaqfLdSGzwfhVvMQlxFK3NSco+cahqN9
         P2534SLz7Ja+ixxqviePzEwAQc7juL6roRkvdmOxYNPO0EDJUgR0Hrgpo1MM9O3Uq34s
         CLVg==
X-Gm-Message-State: AOAM530H227fxz1+431CIIcYnOdRgp2YuFUopwtR29sq1q496XDrxqwW
        Qv74n5knXpe1NypRTfixY/f1rBI/0FOK3vNbT1s=
X-Google-Smtp-Source: ABdhPJxO8GO/RJV7x07nL3FQcV5fvjUJebcStXFS0aQDsKoPN5FHrMfZKxDcA1R71ipAtiZ5ysa/1WUx5uDd3u4M+TU=
X-Received: by 2002:a05:6e02:1a88:b0:2be:a472:90d9 with SMTP id
 k8-20020a056e021a8800b002bea47290d9mr13608286ilv.239.1645388381245; Sun, 20
 Feb 2022 12:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20220220072750.209215-1-ytcoode@gmail.com> <CAEf4BzaGEZAmLM=wmT=ohSaVco_iu8v7cTGYFGCyRz_Xf3c5=A@mail.gmail.com>
In-Reply-To: <CAEf4BzaGEZAmLM=wmT=ohSaVco_iu8v7cTGYFGCyRz_Xf3c5=A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 20 Feb 2022 12:19:30 -0800
Message-ID: <CAEf4BzYYvHBbTKySwy-G9WttuWL1SD=S7RM=D39K8nfd-A_wCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Remove redundant check in btf_fixup_datasec()
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
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

On Sun, Feb 20, 2022 at 12:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Feb 19, 2022 at 11:29 PM Yuntao Wang <ytcoode@gmail.com> wrote:
> >
> > The check 't->size && t->size != size' is redundant because if t->size
> > compares unequal to 0, we will just skip straight to sorting variables.
> >
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ad43b6ce825e..7e978feaf822 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2795,7 +2795,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
> >                 goto sort_vars;
> >
> >         ret = find_elf_sec_sz(obj, name, &size);
> > -       if (ret || !size || (t->size && t->size != size)) {
>
> t->size check is redundant, but  (t->size != size) is not

ah, never mind :) applied to bpf-next

>
> > +       if (ret || !size) {
> >                 pr_debug("Invalid size for section %s: %u bytes\n", name, size);
> >                 return -ENOENT;
> >         }
> > --
> > 2.35.1
> >
