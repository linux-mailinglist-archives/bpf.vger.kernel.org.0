Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E774572998
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 01:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiGLXCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGLXCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 19:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C464E22
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 16:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6937616BF
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1B6C341C8
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657666922;
        bh=xRelsi68mZrrMrDmVtKMT37nT0g42mmu1glw8tq9XNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dItd55hjLtebp35SpaNCpHrf91oUngskXrkjGaFiWyWnF+0+MNYbNoyqUCh2dAu/D
         yiGo2GjWp4YYYmTSPlB3fvODkCrsibiDd3fJtkLMQ18lLrsLOAhgME6j3WqSm70q7P
         S7xZZUMcZ4yHGUpaLUJztXL5MhIas9PEQAHR0wU7HFzheRhOdmlbPUYD/vOQVSHAVq
         6sOiDmF/5jCFkU9O0hp5GW8Jrd01dzye+ZvCSSAREQqYU4Or+376v2cUOxsdHNh2Xq
         yqVxFDXeA70MHPwJPID0ZzMX+QF5qnylXPrWYaQgKaMXiRoJrzbgBP7jap5BaB6fCw
         gKx+BNnXeOH+g==
Received: by mail-yb1-f174.google.com with SMTP id i14so16525492yba.1
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 16:02:02 -0700 (PDT)
X-Gm-Message-State: AJIora8TUP9VOb1f0O/SezcyB0LXxQCn97dXevk5fiPx3SHIVoOG8cfa
        V2FuwJIT6pzi11ZEne/GyCETJzfMDiAyEDwHM44=
X-Google-Smtp-Source: AGRyM1sW/0v0kDXTsygBMJgc8aLW8F92oriS9Sb1a9BiitIPslKgREcK9Sbk1XuWZ9LpbQLk9r+MMg5lecnTdmCDBfc=
X-Received: by 2002:a25:8611:0:b0:66e:d9e7:debc with SMTP id
 y17-20020a258611000000b0066ed9e7debcmr716558ybk.257.1657666921301; Tue, 12
 Jul 2022 16:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220706002612.4013790-1-song@kernel.org> <CAADnVQ++wJcuKemLaJo9eJrvw_873LtMPidFSvgyHtWjCgG2MQ@mail.gmail.com>
In-Reply-To: <CAADnVQ++wJcuKemLaJo9eJrvw_873LtMPidFSvgyHtWjCgG2MQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 12 Jul 2022 16:01:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6T20wJVZBs4B1d9ic0ZCf5kcA1fbQ+aWAE9p2=Jib_dg@mail.gmail.com>
Message-ID: <CAPhsuW6T20wJVZBs4B1d9ic0ZCf5kcA1fbQ+aWAE9p2=Jib_dg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot <syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com>,
        syzbot <syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 3:09 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 5:26 PM Song Liu <song@kernel.org> wrote:
> >
> > syzbot reported a few issues with bpf_prog_pack [1], [2]. These are
> > triggered when the program passed initial JIT in jit_subprogs(), but
> > failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> > called before bpf_jit_binary_pack_finalize(), and the whole 2MB page is
> > freed.
> >
> > Fix this with a custom bpf_jit_free() for x86_64, which calls
> > bpf_jit_binary_pack_finalize() if necessary. Also, with custom
> > bpf_jit_free(), bpf_prog_aux->use_bpf_prog_pack is not needed any more,
> > remove it.
> >
> > Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
> > [1] https://syzkaller.appspot.com/bug?extid=2f649ec6d2eea1495a8f
> > [2] https://syzkaller.appspot.com/bug?extid=87f65c75f4a72db05445
> > Reported-by: syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com
> > Reported-by: syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++++
> >  include/linux/bpf.h         |  1 -
> >  include/linux/filter.h      |  8 ++++++++
> >  kernel/bpf/core.c           | 29 ++++++++++++-----------------
> >  4 files changed, 45 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index c98b8c0ed3b8..c3dca4c97e48 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2492,3 +2492,28 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> >                 return ERR_PTR(-EINVAL);
> >         return dst;
> >  }
> > +
> > +void bpf_jit_free(struct bpf_prog *prog)
> > +{
> > +       if (prog->jited) {
> > +               struct x64_jit_data *jit_data = prog->aux->jit_data;
> > +               struct bpf_binary_header *hdr;
> > +
> > +               /*
> > +                * If we fail the final pass of JIT (from jit_subprogs),
> > +                * the program may not be finalized yet. Call finalize here
> > +                * before freeing it.
> > +                */
> > +               if (jit_data) {
> > +                       bpf_jit_binary_pack_finalize(prog, jit_data->header,
> > +                                                    jit_data->rw_header);
> > +                       kvfree(jit_data->addrs);
> > +                       kfree(jit_data);
> > +               }
>
> It looks like a workaround for missed cleanup on the JIT side.
> When bpf_int_jit_compile() fails it is supposed to free jit_data
> immediately.
>
> > passed initial JIT in jit_subprogs(), but
> > failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> > called before bpf_jit_binary_pack_finalize()
>
> It feels that bpf_int_jit_compile() should call
> bpf_jit_binary_pack_finalize() instead in the path where
> it's failing.
> I could be missing details on what exactly
> "failed final pass of JIT" means.

This only happens with multiple subprogs. In jit_subprogs(), we
first call bpf_int_jit_compile() on each sub program. And then,
we call it on each sub program again. jit_data is not freed in the
first call of bpf_int_jit_compile(). Similarly we don't call
bpf_jit_binary_pack_finalize() in the first call of bpf_int_jit_compile().

If bpf_int_jit_compile() failed for one sub program, we will call
bpf_jit_binary_pack_finalize() for this sub program. However,
we don't have a chance to call it for other sub programs. Then
we will hit "goto out_free" in jit_subprogs(), and call bpf_jit_free
on some subprograms that haven't got bpf_jit_binary_pack_finalize()
yet. So, I think bpf_jit_free is the best place we can add the extra
check and call bpf_jit_binary_pack_finalize().

Does this make sense?

Thanks,
Song
