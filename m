Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB04F6E6D
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiDFXRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiDFXRN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 19:17:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3B1CC436
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 16:15:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y16so3049541ilc.7
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neCWB8iWhVhspNQEvo1BKyg4Ujm9iPbysd7e3JIHPuQ=;
        b=qO7tes30ffvHkxi+wXxAukW1iVRpN40hdF9XUzmIV6/moHjrygnofBHtaolvBgVJ53
         m0PeGre4K2AJSBp4CxZQyY9u9ZpQhHlDAXrzFjui/AjDqsdrU5eBTLjlRw4rLIZgVtjc
         MfiuTbOkxjHyAIeXEZswyeXvNfRbWWlAFuNPPUU6nAgNx4gl+1uW7RRrjsqMJPy1jcBh
         fL6ayYCkWB/KMSexcekcDp2FtS9TUHPQgdQrQlfZ0cJ05gooMWLzDZyoZJEyZWN7pKIP
         /qsXTxSlXYvhw/eKipvIp2oVLTVm4DC7ojxKJYjxR3JIwk87GH2fEyZj9DWC7t3yVPYZ
         sIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neCWB8iWhVhspNQEvo1BKyg4Ujm9iPbysd7e3JIHPuQ=;
        b=RFVNosBragdyHoV2MkNPi+3lnxG2NxoQ9ouvmkyQJkorQ9lYYeSrXMt+pDVJWdncYg
         tVKals1V/IH0wfLDMZrKqQhUTsfYEI/OepWcQ91nVnP+k7mxj/4MMEHhvNo96BDOpPVJ
         RLli5nIdrkgfz1V0AVB3UOk9OxzdCBoooChKHk+LSre5+71EOFQBhQRUlOoJOzxIoiGp
         Uz4dQPqka9KlDAt1wyd2BXOguxEzlG6tjpGGdec7hIyBC8TM5+R7RVccdMp08BxO7O7K
         VYDxRTGHE35QYagQJ/fdhp3XuvlQJePNoQ8pUg9NziuhXtfIf5Lzuo2pmqGzafYp81BD
         CPjQ==
X-Gm-Message-State: AOAM5323c4iTU+NoeJx3twcG07LRsfLkkIe8uy2gNZuw2btt3Et5YTgU
        DKF637/vrdRAgIsvQSym1hSqdQ/ySMHQ0YAXk5o=
X-Google-Smtp-Source: ABdhPJwU4tZAjek7RxnVbvXQp3uwcHRXj3otXR6vOZ/2nDxXAwyqdTgJc5B82KYC78VO8voyfggmSG42vRQqST/1TGs=
X-Received: by 2002:a05:6e02:1562:b0:2ca:50f1:72f3 with SMTP id
 k2-20020a056e02156200b002ca50f172f3mr5096251ilu.71.1649286915706; Wed, 06 Apr
 2022 16:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234202.331384-1-andrii@kernel.org> <20220404234202.331384-6-andrii@kernel.org>
 <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com> <034e57e04eeb7dab4bad4fa674ab337a5534cbdc.camel@linux.ibm.com>
In-Reply-To: <034e57e04eeb7dab4bad4fa674ab337a5534cbdc.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 16:15:04 -0700
Message-ID: <CAEf4BzYJixpYpg4MUxETPVbCrUrZYbn==-UYgVh1z5MWx1TV+w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Wed, Apr 6, 2022 at 3:49 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2022-04-06 at 10:23 -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 4, 2022 at 4:42 PM Andrii Nakryiko <andrii@kernel.org>
> > wrote:
> > >
> > > Add x86/x86_64-specific USDT argument specification parsing. Each
> > > architecture will require their own logic, as all this is arch-
> > > specific
> > > assembly-based notation. Architectures that libbpf doesn't support
> > > for
> > > USDTs will pr_warn() with specific error and return -ENOTSUP.
> > >
> > > We use sscanf() as a very powerful and easy to use string parser.
> > > Those
> > > spaces in sscanf's format string mean "skip any whitespaces", which
> > > is
> > > pretty nifty (and somewhat little known) feature.
> > >
> > > All this was tested on little-endian architecture, so bit shifts
> > > are
> > > probably off on big-endian, which our CI will hopefully prove.
> > >
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > Ilya, would you be interested in implementing at least some limited
> > support of USDT parameters for s390x? It would be good to have
> > big-endian platform supported and tested. aarch64 would be nice as
> > well, but I'm not sure who's the expert on that to help with.
>
> Sure, I'll give it a try. I see there is some support in bcc, which I
> can probably partially borrow.

Awesome, thanks!
