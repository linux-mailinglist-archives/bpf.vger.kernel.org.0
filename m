Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8673698242
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBORg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBORg0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 12:36:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8802D49
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:36:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r8so20970972pls.2
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676482585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GM3XPNdoU8JQKvVhhMrMGU9nL9R92D6FIU1eBI+uHc=;
        b=C9c27Fp0zmHul2qdGh1YV3+YPRlgkB98DLo5eTbHhwKsIxAfAN1ONsIC318RMcCJQ+
         m2b/6xuGFhALSmONnVW4CrEYLaTt0Xp28ZW3aWc+YAFngiWtGbKaNGRNhXD8sS9FnYG+
         S+XVvWn+1xncDOEl5dpsAZWo+KpzvmjYnsnbrTc6pKARBBW/NaxuZnm1Uy+vYFoG1J9P
         3IrB6O1eSAwH5XtiTehPsNDT+3q0CnDYNhQPq+ga4SQZ7sW3xvlLbu6Svikk8iwRvgMu
         FsXarthd5jdHLqsB39boK6IT+6lNrbFNXgAKC2VZaj8l7zVt+t/0vM+yxMOHP6FS7rtS
         2zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676482585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GM3XPNdoU8JQKvVhhMrMGU9nL9R92D6FIU1eBI+uHc=;
        b=jeGaIxWT3e4cVbqb4ECAP4++VLTvSSUPfm/MKXKD5VQcsqIOe35cFtoY3tz5vEuVJB
         kDiEbkfE+4wskVfSKMO1E6E54ECf9Z0oK4iYrWFgjZwlg119ycowyw9CrDkdm59JKDH1
         qCY6vuYOFNdBw0utSPGn88j7lo9Y5xLmrSFAKgWWg7vtF+3d8O2WI9cw6ghxICe3Hcdj
         aNT7pfwRRrrl3STR9Mt0wnWFm+NAMwsfSBGyAsekm8LDuCjo9nfUgmGky0NoRHc5hNM+
         5kbHQtldhtqjEr2H4WEj782jKC0MIITc4MoEZ3uofCciZVBl3gaoY6idxN9PWM3JMxok
         Q7Hg==
X-Gm-Message-State: AO0yUKU5csQnv4EH3Np70n6DGqfNLj/gawKBWJBFNL9ABWKwkNwPdEcC
        7CagUV+87b4nrNwGVMr/NeNDBmXdJAqj6KKfKaNiF6lbHw42/Ga1CcE=
X-Google-Smtp-Source: AK7set/+XXJjfCF7vMMKNpkYe6LxNxlWgyfLtb/6xz+ND9WCbqFhKGqkgYJcJboy3LhqAQkRQYA9B8gghxAuSwPMvMY=
X-Received: by 2002:a17:902:9b8c:b0:19a:b2ef:f177 with SMTP id
 y12-20020a1709029b8c00b0019ab2eff177mr727679plp.13.1676482584964; Wed, 15 Feb
 2023 09:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20230214235051.22938-1-alexei.starovoitov@gmail.com>
 <Y+xLXcmf1pxl43dn@google.com> <CAADnVQLCdMMGm1TGDbC5eUSSZWF+-au5cPr1OsKUz=SxM4bnCA@mail.gmail.com>
In-Reply-To: <CAADnVQLCdMMGm1TGDbC5eUSSZWF+-au5cPr1OsKUz=SxM4bnCA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 15 Feb 2023 09:36:12 -0800
Message-ID: <CAKH8qBuO1r65-uQ2usCgsdjDHchD3Cn0g+CS7wqmvxhwbH0xEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_kptr test.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 7:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 7:02 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 02/14, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> >
> > > The compiler is optimizing out majority of unref_ptr read/writes, so the
> > > test
> > > wasn't testing much. For example, one could delete '__kptr' tag from
> > > 'struct prog_test_ref_kfunc __kptr *unref_ptr;' and the test would
> > > still "pass".
> >
> > > Convert it to volatile stores. Confirmed by comparing bpf asm
> > > before/after.
> >
> > > Fixes: 2cbc469a6fc3 ("selftests/bpf: Add C tests for kptr")
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > > ---
> > >   tools/testing/selftests/bpf/progs/map_kptr.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c
> > > b/tools/testing/selftests/bpf/progs/map_kptr.c
> > > index eb8217803493..228ec45365a8 100644
> > > --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> > > +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> > > @@ -62,21 +62,23 @@ extern struct prog_test_ref_kfunc *
> > >   bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int
> > > b) __ksym;
> > >   extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
> > > __ksym;
> >
> >
> > [..]
> >
> > > +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
> >
> > (thinking out loud)
> >
> > Maybe time for us to put these into some common headers in the
> > selftests.
> > progs/test_ksyms_btf_null_check.c READ_ONCE as well..
>
> Not quite. There is no READ_ONCE there. Only comment about it :)

/* READ_ONCE */
*(volatile int *)active;
^^^ looks like a real read_once to me? not just a comment?


> But yeah a follow up is necessary, but it's not that simple.
> I think it's ok to use WRITE_ONCE here, but
> saying it's a generic thing for all bpf programs to use
> is not something we can do without defining a BPF memory model.
> So it's a whole can of worms that I'd rather not open right now.

SG!
