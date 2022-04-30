Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A6515A26
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 05:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiD3DdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiD3DdO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 23:33:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7EC0E68;
        Fri, 29 Apr 2022 20:29:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so8661276plh.2;
        Fri, 29 Apr 2022 20:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUmNcNsDoCzcF14FceqgfCt2WsRT+h9Jn//RzzgixQg=;
        b=ovNwRnZQhd3q2zYaM7FygEnhotz760Al/ruwyRTkj52QSuCz45g4xJzsiHX7WCOdBz
         edjiZI0mJ+3T8W6iH4tcnj4dAwhggeIAqTYfh3HXvEU6onBiLHKNBh1aFJqzP9mtHBdO
         tvh1emm+tRTF5drn6eweQ350RW7u/WX70iiuqLKnbpUD6Lq589GzIkI2cDCgzy+FXckK
         hv2wi+Pcf2G+DS0DL3pthyNkpfRst6pPJmQ7GPHNAHcQeW0KDc7+mQoh6p6vZCRmweZA
         N60KGOpaTaE1rLbBGzAgZJPY8ZVY7ausZDaYULNdjpMO6XRywNlmJjzZNeqaHzDfgudV
         7pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUmNcNsDoCzcF14FceqgfCt2WsRT+h9Jn//RzzgixQg=;
        b=7JXVqmk2ddByvwCDCpJLLB7btsaZgQavin7QOYs3Hiu2akA+o/X6R20D0ah9nvA0zJ
         iNxVmhmX8ez3Mjxv+3MaVB+qSaLpjZNHYlMEmtRpUvT+WpD3wlGITerdbrklJaOvn5fz
         DgRK4Avoz8JFnbamA5d9BwnkoNxWnpRtyp4froJhwYguRk/5bRr5Zx1wEgUlxMG5fIBL
         R8lGi4a24icXG7BQBgFpyBBl8Em066Rvu7MNGNV30cL6rd3kdp2pRp94L6czwIxy/cKL
         Hyr3oN+mp8YUAXdiUpG8IMZUYq3T1IxHZnb6nK0gDLVzcUnaiua1ZpRvUXwTOyDLvhc0
         QNTw==
X-Gm-Message-State: AOAM5327uVMQh3vq7bq/a02DAPS8C8Nc3bdlVogph59Y1BbKuj5USN/+
        y3KiFivx2ABj5HRsYj0ptMkhT5OioR8XedhYjCQ=
X-Google-Smtp-Source: ABdhPJwERSAY3QNsvQUlhC83me5byVTRuvYW57IaU9RoZHoVGKIjwvtOX4pzakqd1CFQAvCFraQapEsEarG0+Q1kknU=
X-Received: by 2002:a17:90b:33c8:b0:1d9:9023:1103 with SMTP id
 lk8-20020a17090b33c800b001d990231103mr2344557pjb.26.1651289394183; Fri, 29
 Apr 2022 20:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-4-benjamin.tissoires@redhat.com> <20220426041147.gwnxhcjftl2kaz6g@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLWxtZcs-ynzAaF4hGf6zPF5wAni3Etzb1_XrvQpx2Jxw@mail.gmail.com>
In-Reply-To: <CAO-hwJLWxtZcs-ynzAaF4hGf6zPF5wAni3Etzb1_XrvQpx2Jxw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Apr 2022 20:29:43 -0700
Message-ID: <CAADnVQL3U5Gz_spmdTsC6zOuR=XLEMppwn+=bkyOsSt0=7pP7Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 3/7] error-inject: add new type that carries if
 the function is non sleepable
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 12:52 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Apr 26, 2022 at 6:11 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 04:07:36PM +0200, Benjamin Tissoires wrote:
> > > When using error-injection function through bpf to change the return
> > > code, we need to know if the function is sleepable or not.
> > >
> > > Currently the code assumes that all error-inject functions are sleepable,
> > > except for a few selected of them, hardcoded in kernel/bpf/verifier.c
> > >
> > > Add a new flag to error-inject so we can code that information where the
> > > function is declared.
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > ---
> > >
> > > new in v4:
> > > - another approach would be to define a new kfunc_set, and register
> > >   it with btf. But in that case, what program type would we use?
> > >   BPF_PROG_TYPE_UNSPEC?
> > > - also note that maybe we should consider all of the functions
> > >   non-sleepable and only mark some as sleepable. IMO it makes more
> > >   sense to be more restrictive by default.
> >
> > I think the approach in this patch is fine.
> > We didn't have issues with check_non_sleepable_error_inject() so far,
> > so I wouldn't start refactoring it.
>
> OK... though I can't help but thinking that adding a new
> error-inject.h enum value is going to be bad, because it's an API
> change, and users might not expect NS_ERRNO.

Not sure about api concern. This is the kernel internal tag.
bpf progs are not aware of them. The functions can change
from sleepable to non-sleepable too.
allow_error_inject can be removed. And so on.

> OTOH, if we had a new kfunc_set, we keep the existing error-inject API
> in place with all the variants and we just teach the verifier that the
> function is non sleepable.
...
> IIUC, the kfunc_set approach would solve that, no?

Makes sense. Let's figure out an extensible kfunc_set approach
that is not centralized in verifier.c
