Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4E525A59
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbiEMDqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 23:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347398AbiEMDpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 23:45:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31D186EB
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:45:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m1so6241429qkn.10
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0XFr0T0atIjtaiOrslIgWPrAxFimiJbx5sDo/ALpaU=;
        b=eWGN19iBlLR5tG76FUdouA5ESOC0XL77OzGnFiniZ6iex8yqfFNEzemrVjojNzy7rc
         Lg8A4cj+YjHNJM02nmEWXqeycfSSGhQ4/RDaMXRCN/cxqkbTg6xCmnEZlNnyQ0N2f8Fv
         tLbT97VkM5pI7lRU4nZaMdr0QvHBMJsiQlTkUsIwIw6fC516J07pUqfNYI3Os2clg57i
         hYbRfEB6/4z4H2kwRDi17diHGTVK7FyNC/gf1Nm3clyrTX1aw4/6DHyOY/84H7D8+9nV
         1HCmKRluRA+XGEn6v1dWirjujBU4TCpUM+h2UwBQpT93iG9f1L5CBJ7pA62uqcMIbW92
         XtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0XFr0T0atIjtaiOrslIgWPrAxFimiJbx5sDo/ALpaU=;
        b=j/VvySQEC9MdA2af92WcaPL7wNokVbi6XyrW13haa+07ZI3sTGy6geZK/afNS2STvT
         +W6Achztf2SGW5bUyVu9kBT1bsunXPl1TP2lCDQWCkFmhujqTy6F8PT+pnK99/ufzH30
         yg+1f+jC6/Hc4z4ui7qosUn2V1JVYgu2M2tiQTRJlrJbq9KiGdaEdocumsSZBKt643HR
         B+u4IJwubpWtkB3WxSKZ3G7/Kjb5kyy1qZUlgheWRNf/A0pvp28zl/gAed7i8QF52siC
         VCBXona+ZwRrC7nJLEBjOQJixmOBHPN3oExoyZCLk0BD8wOn+8zQ7EKcLs9PcojwHzdj
         +Lvg==
X-Gm-Message-State: AOAM533q56YpALKiuTvsaJCxKgzv2wYcuNucDYrGuDIiO7YETaF2zgNh
        xIJPVfSy7COmKkjm0QcsbKGlSKipXzI8nDo6Kj0=
X-Google-Smtp-Source: ABdhPJxammcUzOkexIJAt+4iMNZiUbtM8CTqBllO3m98s6LFwfd5yIb1ZbGqLqWzV71V5E/FFcMu+Cz0ebPT1v7og0M=
X-Received: by 2002:a05:620a:146:b0:6a0:267b:49ea with SMTP id
 e6-20020a05620a014600b006a0267b49eamr2351598qkn.256.1652413546986; Thu, 12
 May 2022 20:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com> <CAEf4BzZP__5CGCQM+f6RG3Vpiw-Usi9aR_O=7a7WA4N10eFhiQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZP__5CGCQM+f6RG3Vpiw-Usi9aR_O=7a7WA4N10eFhiQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 May 2022 20:45:36 -0700
Message-ID: <CAADnVQJsoatpJF3nwPgT9PQJk+XFN9Yur0o1NLyv09THZH0EUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix combination of jit blinding and
 pointers to bpf subprogs.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, May 12, 2022 at 8:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 6:10 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The combination of jit blinding and pointers to bpf subprogs causes:
> > [   36.989548] BUG: unable to handle page fault for address: 0000000100000001
> > [   36.990342] #PF: supervisor instruction fetch in kernel mode
> > [   36.990968] #PF: error_code(0x0010) - not-present page
> > [   36.994859] RIP: 0010:0x100000001
> > [   36.995209] Code: Unable to access opcode bytes at RIP 0xffffffd7.
> > [   37.004091] Call Trace:
> > [   37.004351]  <TASK>
> > [   37.004576]  ? bpf_loop+0x4d/0x70
> > [   37.004932]  ? bpf_prog_3899083f75e4c5de_F+0xe3/0x13b
> >
> > The jit blinding logic didn't recognize that ld_imm64 with an address
> > of bpf subprogram is a special instruction and proceeded to randomize it.
> > By itself it wouldn't have been an issue, but jit_subprogs() logic
> > relies on two step process to JIT all subprogs and then JIT them
> > again when addresses of all subprogs are known.
> > Blinding process in the first JIT phase caused second JIT to miss
> > adjustment of special ld_imm64.
> >
> > Fix this issue by ignoring special ld_imm64 instructions that don't have
> > user controlled constants and shouldn't be blinded.
> >
> > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Thanks for the fix, LGTM.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>

Ohh. Sorry. Yes!

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
