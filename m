Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389344EF17
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhKLWNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 17:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKLWNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 17:13:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A8C061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 14:10:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n8so9515783plf.4
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhE7WiLEvTfolf4lP99T3od+puiZF5D1D989RWokAb4=;
        b=VBHg/hz+ybFNHwczteWrH8TqoBNDpnvIhpXYClH8Kn32ZI4jApYjDwEz88+JiHRymb
         p4ns7LBo3l18BGPUpyqGkvJFgK01lY9m1T3jBxcWFppLm0qneU93f/VBiDZCr6Nz0cv9
         ZA+CAiK5zyuZ9+UzOilqGyZNRnKBAq1tbIMc5rsuIuOciKQQzQvqc1CABWjxtqQAB6HY
         3PcMyPHsBCgHfCN/mNGWbJjrP0yxJX73eJlRU/Ztm1b1m4n+4r3rVZOm++hCsCe25rSw
         OU/+bJ8FXkuk6THJyR9voZLMgFlH6YSxtejljlEn9g/qYVMiP3COz3mraRXBV4pKxBJL
         d9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhE7WiLEvTfolf4lP99T3od+puiZF5D1D989RWokAb4=;
        b=tkipVu9re2FgVHP0P7GNWqeYk9PmAxDbUXtQstCNQABdx2maLHFTTUR1MSptUxyb26
         JOXP2bINuCcoXKMbdsNkSTOdka9iTD1Mtdnv328/TBNY/vWT0/DRO9J8t9TM14eNhZoY
         eluXjLapLL+WGrh3GuE1XFpSqhJga35YJcY2w8LkTcscSMXV1pTMuDQWe/GRixNu8lYg
         DY0gaviPJRC8UlpG7OD9Y0Niv1FCEY0VWRRHNZ9su7STsQWki8EhLD6bbv4BMfcQVcZp
         9t+JIYZNXL5GZZHwYUUWT85wLOvYLgYuDfpt+ChZAFpWq0VIU8j3ktjkF+AZjoj5TevR
         wHIA==
X-Gm-Message-State: AOAM530nTzWA9Wf4pLEPEFEq++znvOdg9gLh9JYuXXa4ULIKrsTOiN85
        eA2q9liX8cW5M1VV+QP59lJjvRVquK03MlKE5GM=
X-Google-Smtp-Source: ABdhPJx4R8RSgJtWUpOI14K/wVJCKKDaeYdHuzXqlkjee9MJhMYIVITP9EwrxZR1RGEBY6YO9PwMgOL8CBxuQCSKnqo=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr11731160plh.3.1636755019309; Fri, 12 Nov
 2021 14:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20211112202421.720179-1-memxor@gmail.com> <20211112213411.m3uxisnzkzkyf2os@ast-mbp.dhcp.thefacebook.com>
 <20211112214656.dvcm2cikjxq4r6ta@apollo.localdomain>
In-Reply-To: <20211112214656.dvcm2cikjxq4r6ta@apollo.localdomain>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Nov 2021 14:10:08 -0800
Message-ID: <CAADnVQKMEhEr8AXTfd2pdrUqjubtamqfjVLUgdcRivPh9EwYjw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Perform map fd cleanup for gen_loader in case
 of error
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 1:47 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Nov 13, 2021 at 03:04:11AM IST, Alexei Starovoitov wrote:
> > On Sat, Nov 13, 2021 at 01:54:21AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >
> > > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > > index 7b73f97b1fa1..558479c13c77 100644
> > > --- a/tools/lib/bpf/gen_loader.c
> > > +++ b/tools/lib/bpf/gen_loader.c
> > > @@ -18,7 +18,7 @@
> > >  #define MAX_USED_MAPS      64
> > >  #define MAX_USED_PROGS     32
> > >  #define MAX_KFUNC_DESCS 256
> > > -#define MAX_FD_ARRAY_SZ (MAX_USED_PROGS + MAX_KFUNC_DESCS)
> > > +#define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)
> >
> > Lol. Not sure how I missed it during code review :)
> >
> > >  void bpf_gen__init(struct bpf_gen *gen, int log_level)
> > >  {
> > >     size_t stack_sz = sizeof(struct loader_stack);
> > > @@ -120,8 +146,12 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
> > >
> > >     /* jump over cleanup code */
> > >     emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> > > -                         /* size of cleanup code below */
> > > -                         (stack_sz / 4) * 3 + 2));
> > > +                         /* size of cleanup code below (including map fd cleanup) */
> > > +                         (stack_sz / 4) * 3 + 2 + (MAX_USED_MAPS *
> > > +                         /* 6 insns for emit_sys_close_blob,
> > > +                          * 6 insns for debug_regs in emit_sys_close_blob
> > > +                          */
> > > +                         (6 + (gen->log_level ? 6 : 0)))));
> > >
> > >     /* remember the label where all error branches will jump to */
> > >     gen->cleanup_label = gen->insn_cur - gen->insn_start;
> > > @@ -131,37 +161,19 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
> > >             emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
> > >             emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
> > >     }
> > > +   gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
> >
> > could you move this line to be the first thing in bpf_gen__init() ?
> > Otherwise it looks like that fd_array is only used in cleanup part while
> > it's actually needed everywhere.
> >
>
> Ack. Also thinking of not reordering add_data as that pollutes git blame, but
> just adding a declaration before use.

git blame is not a big deal. Both options are fine.


>
> > > +   for (i = 0; i < MAX_USED_MAPS; i++)
> > > +           emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
> >
> > I confess that commit 30f51aedabda ("libbpf: Cleanup temp FDs when intermediate sys_bpf fails.")
> > wasn't great in terms of redundant code gen for closing all 32 + 64 FDs.
> > But can we make it better while we're at it?
> > Most bpf files don't have 32 progs and 64 maps while gen_loader emits
> > (32 + 64) * 6 = 576 instructions (without debug).
> > While debugging/developing gen_loader this large cleanup code is just noise.
> >
>
> Yeah, I've been thinking about this for a while, there's also lots of similar
> code gen in e.g. test_ksyms_module.o for the relocations. It might make sense to
> move to subprog approach and emit a BPF_CALL, but that's a separate issue. I can
> look into that too if it sounds good (but maybe you already tried this and ran
> into issues).

Do you mean to split things like emit_sys_close into its own subprog
and call it ?
I'm not sure it's large enough to do that.
Or you mean the code that copies?
There is a lot of it in test_ksyms_module.o
Would be good to reduce it, but it's a corner case
and probably not typical.
I'm all ears.

> > So cleanup code can close only nr_progs + nr_maps FDs.
> > gen_loader prog will be much shorter and will be processed by the verifier faster.
> > MAX_FD_ARRAY_SZ can stay fixed. Reducing data size is not worth it.
> > wdyt?
>
> Looks nice, I'll rework it like this.

Thanks. Pls keep targeting bpf tree with respin.
