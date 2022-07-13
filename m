Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ACC572A4F
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 02:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGMAh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 20:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGMAhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 20:37:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187AEAAB1D
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 17:37:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g1so12161889edb.12
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gNR5BG0F+4+4lfqBE0tC3B3X10Lqiqc4ILEi5gNMdo=;
        b=Tw4D/6dCs5DaEWDd6CKH7YQJPpsu4t/BBgy5lt+h5kuqL2hlj/Ewt9N2RBThUU5zfT
         5vnX3xDVChp7ABY3XN8kyWh8HmQGOUAov6SgZ/houD1D56yArTe829HjYQ54woRbbUai
         rsw8/wLCnhudqOEfGgCJgkQMRw96z9c5KSeCwBLIj85ZHPYBOuRH9Gp7setro515h+d0
         RhQJzqUQHHIaTixrOYQ3ccRFOhtdKoLOr2vc5Rkjiey0eD3XS3sHrefsRa60+3vvdRLF
         mUdzornTXd4xp0a2wDIBevhuTsW1s0IbclT2bZAdNxFI3vHkQ4UvWn1CW6nLFy8J2djC
         4ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gNR5BG0F+4+4lfqBE0tC3B3X10Lqiqc4ILEi5gNMdo=;
        b=KfzMqGnJTrA5bLv8zQhDofHCl2E/PeJ0emqaqdLuhZd19KD6NXlzcg3H8nck50qiSb
         eJmEjTA7qVhTxzphSTj10j2EeQj2ETBzxvjJcJSU9Rh7W8rgwzRVOqoxuZulUymLBKS/
         7QAtQ6sjViE3gWjeEwyTQCZm/Ybt+DnPZtxk9OivABXmppQ3plFceWQT9a07eOyw0iDC
         ZmZ9aEW+D7q9zhT6t03KHqsamju5qcPUcHJoF6tLfIX/fCei+IqcqJuJNjf74iK4Bovx
         BeMtL6enkA0MS1acsghvzpkToWYtZk8xJM6gBMo9VP4Io71tGfax1XKQaMYpLoyLjLpT
         IyqQ==
X-Gm-Message-State: AJIora/warbI02z9HaF/T2c3LlFXF/BfW0hiKoCibZVcNl4nbgefYPb7
        E3qKWahy8w7nifo9trVtQHaA8Ri1heEzn6MQqqc=
X-Google-Smtp-Source: AGRyM1ur3uIYA9ruPdrUO+SbEGYaIEhkCcIC+yn0wlLEMwZbHWTzgNURt2yqPTKeWLLnxW8NwEKu3Fun4cTr0Q7uLMs=
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id
 n11-20020a05640205cb00b00434eb48754fmr1098368edx.421.1657672642667; Tue, 12
 Jul 2022 17:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220706002612.4013790-1-song@kernel.org> <CAADnVQ++wJcuKemLaJo9eJrvw_873LtMPidFSvgyHtWjCgG2MQ@mail.gmail.com>
 <CAPhsuW6T20wJVZBs4B1d9ic0ZCf5kcA1fbQ+aWAE9p2=Jib_dg@mail.gmail.com>
In-Reply-To: <CAPhsuW6T20wJVZBs4B1d9ic0ZCf5kcA1fbQ+aWAE9p2=Jib_dg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 17:37:10 -0700
Message-ID: <CAADnVQLLs3pk-Lq1TcOox=XSDTPLG7y_MnGfXRRZ4d0iR0OMpg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot <syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com>,
        syzbot <syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com>
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

On Tue, Jul 12, 2022 at 4:02 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jul 12, 2022 at 3:09 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 5, 2022 at 5:26 PM Song Liu <song@kernel.org> wrote:
> > >
> > > syzbot reported a few issues with bpf_prog_pack [1], [2]. These are
> > > triggered when the program passed initial JIT in jit_subprogs(), but
> > > failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> > > called before bpf_jit_binary_pack_finalize(), and the whole 2MB page is
> > > freed.
> > >
> > > Fix this with a custom bpf_jit_free() for x86_64, which calls
> > > bpf_jit_binary_pack_finalize() if necessary. Also, with custom
> > > bpf_jit_free(), bpf_prog_aux->use_bpf_prog_pack is not needed any more,
> > > remove it.
> > >
> > > Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
> > > [1] https://syzkaller.appspot.com/bug?extid=2f649ec6d2eea1495a8f
> > > [2] https://syzkaller.appspot.com/bug?extid=87f65c75f4a72db05445
> > > Reported-by: syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com
> > > Reported-by: syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++++
> > >  include/linux/bpf.h         |  1 -
> > >  include/linux/filter.h      |  8 ++++++++
> > >  kernel/bpf/core.c           | 29 ++++++++++++-----------------
> > >  4 files changed, 45 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index c98b8c0ed3b8..c3dca4c97e48 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -2492,3 +2492,28 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > >                 return ERR_PTR(-EINVAL);
> > >         return dst;
> > >  }
> > > +
> > > +void bpf_jit_free(struct bpf_prog *prog)
> > > +{
> > > +       if (prog->jited) {
> > > +               struct x64_jit_data *jit_data = prog->aux->jit_data;
> > > +               struct bpf_binary_header *hdr;
> > > +
> > > +               /*
> > > +                * If we fail the final pass of JIT (from jit_subprogs),
> > > +                * the program may not be finalized yet. Call finalize here
> > > +                * before freeing it.
> > > +                */
> > > +               if (jit_data) {
> > > +                       bpf_jit_binary_pack_finalize(prog, jit_data->header,
> > > +                                                    jit_data->rw_header);
> > > +                       kvfree(jit_data->addrs);
> > > +                       kfree(jit_data);
> > > +               }
> >
> > It looks like a workaround for missed cleanup on the JIT side.
> > When bpf_int_jit_compile() fails it is supposed to free jit_data
> > immediately.
> >
> > > passed initial JIT in jit_subprogs(), but
> > > failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> > > called before bpf_jit_binary_pack_finalize()
> >
> > It feels that bpf_int_jit_compile() should call
> > bpf_jit_binary_pack_finalize() instead in the path where
> > it's failing.
> > I could be missing details on what exactly
> > "failed final pass of JIT" means.
>
> This only happens with multiple subprogs. In jit_subprogs(), we
> first call bpf_int_jit_compile() on each sub program. And then,
> we call it on each sub program again. jit_data is not freed in the
> first call of bpf_int_jit_compile(). Similarly we don't call
> bpf_jit_binary_pack_finalize() in the first call of bpf_int_jit_compile().
>
> If bpf_int_jit_compile() failed for one sub program, we will call
> bpf_jit_binary_pack_finalize() for this sub program. However,
> we don't have a chance to call it for other sub programs. Then
> we will hit "goto out_free" in jit_subprogs(), and call bpf_jit_free
> on some subprograms that haven't got bpf_jit_binary_pack_finalize()
> yet. So, I think bpf_jit_free is the best place we can add the extra
> check and call bpf_jit_binary_pack_finalize().
>
> Does this make sense?

Got it. I've amended the commit log with the above details.
Considering that we're at rc6 and the amount of conflicts
this patch would cause between bpf and bpf-next trees
I pushed it to bpf-next after applying manually.
Thanks.
