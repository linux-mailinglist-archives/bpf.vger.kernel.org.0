Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4A41655C
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhIWSuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 14:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbhIWSuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 14:50:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F10AC061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:48:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h2so343109ybi.13
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rs1DfI55CujXeYu5ks4NQbwgTijp84iOjrkKAH5DDyA=;
        b=QFA0yDbbc4qqI3xkF5O2+DPSm9MB6MkAA1kxp4DTXOPkLGifihAV2MbUm22u9zpxjX
         gBXSvykYKCLDI+0VbJdr9mb0l5sdo0rvsAnvjk9K8E2ye2fkusenr6QHIf8LunCKpj5N
         soWBPk/+QT9La6l7HxuLkBB2a9PzU7pMrYc5Q9GNfjlNP6KQteLb7eH9Kwquu1Nr1Xr5
         LPOD44z3h3qH7lFFZPR/KgGedtmKNEjlja4KCtoYu95QLtg6HqIXpuDDYYnmeMJ6oRyk
         mnIMMPQlw4H7viB0TMEbPKxMtUiPus8obW/rGomfK+VDkpPm/QJHFejEv2UbLvWDsGj/
         VPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rs1DfI55CujXeYu5ks4NQbwgTijp84iOjrkKAH5DDyA=;
        b=4T15rOnez/DcShc1KcugluGDXzXJk3/bn3RGdCTtYjmvsLnB/6BbVZ52LePiQq6v3j
         eCmrrbx/rNEjRKLz1pTtS5wPSyEip+2NiAvtESmh57TGQAi+Wyl72qo4bH1iIJ7tVSex
         oDa+MTHsioBwcV3Dvwk0SJfo0SjECaKyhTI5Gg3F58IkbROJGBWYzoF7o3Bef40cNPAQ
         omk9n0TqeP+x0xPMDEFMTXeP2l2h8SZRrLEGnF1VwsV4Cjaq8jZ1HpeMa5jpvMaeMyuN
         iZcbo6YoW+b2o1ypR6c93RRS+/Ysd/Ds150lz4w4yXfd2FAIlLN6KNYnkYjn10f6IOqK
         XmCg==
X-Gm-Message-State: AOAM530grheJVzMcOJTir2GeGSGyX+qOxJXT4BWvo4IL0wIo0LbsIsDF
        TKBGCZvuGZNXi4EgrftfzhgVLU2Vd4Cq2Ly6FuzQSlcV
X-Google-Smtp-Source: ABdhPJx8QCmglgqupGFbmFymkjH4BC7JgMdewM5HESZVgoftCmyrKhDkHHAihhQA/+rI1Dn16VubYCHhdUUdjkKldGs=
X-Received: by 2002:a25:840d:: with SMTP id u13mr7474533ybk.455.1632422913655;
 Thu, 23 Sep 2021 11:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-4-alexei.starovoitov@gmail.com> <CACAyw992kSRHmHky+S03TdOcwDLCAsqK9quoy-p3vQ9DjCdyKA@mail.gmail.com>
In-Reply-To: <CACAyw992kSRHmHky+S03TdOcwDLCAsqK9quoy-p3vQ9DjCdyKA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Sep 2021 11:48:22 -0700
Message-ID: <CAEf4BzZWFRcc6fwqPYZDCex0E_70oWMB-Ce7bV2SX-HC3GmSEg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 03/10] bpf: Add proto of bpf_core_apply_relo()
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 4:22 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Fri, 17 Sept 2021 at 22:57, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Prototype of bpf_core_apply_relo() helper.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> ...
>
> > @@ -6313,4 +6321,10 @@ enum bpf_core_relo_kind {
> >         BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
> >  };
> >
> > +struct bpf_core_relo_desc {
> > +       __u32 type_id;
> > +       __u32 access_str_off;
> > +       enum bpf_core_relo_kind kind;
>
> Not a C expert, I thought enums don't have a fixed size?

They are backed by int (4 bytes) in C, unless values don't fit into
int, then it's long long (or unsigned variants of int or long long).
The only exception is when it's used in a packed struct, then field
will get allocated only as little space as necessary to keep all
values (so could be byte or two bytes). You can also have a
bitfield-backed enum field in a struct, but enum itself is still going
to be of whole and power-of-two of number of bytes.

So long story short, here it's 4 bytes and will stay 4 bytes.

C++ gives more flexibility and you can actually specify backing
integer type. Not the case for C, though.

>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
