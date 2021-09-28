Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9BF41A4FF
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 03:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhI1By6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 21:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbhI1By6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 21:54:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9AC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 18:53:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s18so13787289ybc.0
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pkcZShFSIObtQWoy2gCJQ3x2hAx5rkCPnQJPXJegaU=;
        b=Mh8rS4xDC87GuyqqXAGFBbYBOh4RNdhn9Kq1mSDzZewzHtzW6+XskndK1H2AuBA8Lw
         al89dbxd8A6CIpdWOf6GiF0E1h2iKasBo7ICKBjT1ghjY9DzX1uTc5VfPyZh0SzWRwTE
         8YpcMnzQjrtsqydhjkO90m5tBd46cfRUwOjWZi2JjDLcDbwDfN5AnDAQbPBroTHbG1sv
         u97u+vaCYxXFcKkUxXP3krSLSSoxeo0LO/peOmrQ7Hvv29zn0++ydk6s0LRsOFjj3BJ+
         JvBFogrqH8nmIOGAiYDz3XNozaflgzbEBetJqJ/YpnYj8Jmoml3KMtO+XpI/rFE69kyr
         /G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pkcZShFSIObtQWoy2gCJQ3x2hAx5rkCPnQJPXJegaU=;
        b=xuaGLD7vxgIzrwWZO9TZbsaEWadW7i7/nFUCbizAmX+tAPkouhTOi2I5dWV/bkaSax
         BsDRXEIr264elMShNMuKBFrtdbnAKVSKNeDCF3x5Ko3aKElPUAjRqcBB5BwfxFLi7gVS
         6VQ7FXwHVN2+Po4kMIHvIxCB2lFomSiY+HzaWsWEPHhHdbbCdFd1KjX3wukQwugjXlLA
         E13KfwiIVPSYUf3rWKOCAZ+IZyZ/upeWXLv2NsJz57X0LMEt4I3Qa9EnBCltpsc7CSpN
         XD5+gBV2bY10D3UuU8YMNeivSCeCD3pe74fGZhlyKFscTXaqi4mpL0n/7p/dFIATMSIt
         qofw==
X-Gm-Message-State: AOAM5322Oqpmeaq2Dg3tVmZKXnKHxWQufjd7yZ/7oqdfVAQ8S6409pZu
        Kr+ybUWJgYPgYgvAyCsCa21EEihQdiY+xEx2qhg=
X-Google-Smtp-Source: ABdhPJzqDooqZwOE0YjQrsjcpEmem0zXEJV07XNDhqgxJ/u3SybsL057qODmeQhGhIf39JSGfZvs7koK6tKG6SV8Ed8=
X-Received: by 2002:a25:acd1:: with SMTP id x17mr3364243ybd.51.1632793998923;
 Mon, 27 Sep 2021 18:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210922234113.1965663-1-andrii@kernel.org> <20210922234113.1965663-3-andrii@kernel.org>
 <270e27b1-e5be-5b1c-b343-51bd644d0747@iogearbox.net> <CAADnVQJvpTOBcOOUJtDPR3b=o2QCpzSog1_v=wiVQ72uC+U3-Q@mail.gmail.com>
In-Reply-To: <CAADnVQJvpTOBcOOUJtDPR3b=o2QCpzSog1_v=wiVQ72uC+U3-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 18:53:07 -0700
Message-ID: <CAEf4BzbWD9EfR4XB4yqXw6km35jcYf6=arjowZBicTiCLBCtqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 9:12 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 8:14 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 9/23/21 1:41 AM, Andrii Nakryiko wrote:
> > > Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> > > extra characters. In reference_tracking selftests also drop the usage of
> > > broken bpf_program__load(). Along the way switch from ambiguous searching by
> > > program title (section name) to non-ambiguous searching by name in some
> > > selftests, getting closer to completely removing
> > > bpf_object__find_program_by_title().
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > [...]
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > > index fe818cd5f010..7d0256d7db82 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
> > > @@ -16,31 +16,31 @@ volatile const __u32 IFINDEX_DST;
> > >   static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
> > >   static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
> > >
> > > -SEC("classifier/chk_egress")
> > > +SEC("classifier")
> >
> > Can be a follow-up, but lets just deprecate the whole "classifier" terminology
> > for libbpf since tc BPF programs do significantly more than just that since long
> > time and it's otherwise just a confusing UX. The whole "classifier" / "action"
> > terminology is just remains from legacy tc. See also libbpf.h's 'TC related API'
> > where there is no notion of "classifier". Given you have SEC("xdp"), lets name
> > all these in here SEC("tc"), and for compat we can keep the old "classifier" name
> > as a hidden option in libbpf if we have to.
>
> That's a great idea. SEC("tc") makes much more sense.
> Let's do it as part of this series, so the same lines don't need to be
> touched twice.

Sounds good, I'll send a new revision.
