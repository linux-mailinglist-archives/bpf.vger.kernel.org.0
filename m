Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D44985A7
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiAXRDY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 12:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiAXRDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 12:03:20 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E837C061401
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 09:03:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e9so629888ljq.1
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4LPuie2gZC/4gV/HI33snifTw+KkH8sPMZQ+z2ss9g=;
        b=GMNghxZcUBO0n0fyg056ZLP7pohxEmoQNb+q9Gx3aJL7yN5OgP3L3sAXKKeG0FS2FZ
         Z6pDM9krJxdYNIX5JVA7jIf5PVEaWB3PGmkC7PzXiUasK0mbo88jhYgwCX1k5jbVbMqb
         sJ3IiMLRCt+4TpzmjqS9TqholOAk3g9plbBE2UYD+tiolZfJWQ8Tpv/UiU12e2qoNkKc
         ODqMMR230gAhWRVkS6W1VlA7aC/0QEKLOCbIpRFoA5Y/sHPFuo5qFoGPwmFbwk3Sb3qz
         8/5ZUZJrGisb4JDzOH3FxSWlIGyw2MCJJOMZVNMiLFQ1TAbmhgYe1jIk4F2YTgopqVaN
         sjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4LPuie2gZC/4gV/HI33snifTw+KkH8sPMZQ+z2ss9g=;
        b=yJNvwfS9Gig0ceb44AQuxcS0hWQ2uO9Jlpp2q0+Ux3eqJBl0z6azxYQHq2Qwrao2hP
         O/8PIZevO62Zg2FDVGD6G140wqN2OJuhQMDif00YIHYtdxUKihYo7ihJWzZIbq8q7y73
         x35Tg639/cYmlmRyvvVIlYJEuV0pWb7Y1MQE7tm9qWGVvhX54OsBhL1n0qOJOxie+hnA
         bI3JDmEQ0COrbRx4kFCKpeRIasJnQLpKNfSrUCy4KKQXr5HQi/12pG47+LaUUMXdAGM+
         fhNEOwYDUgYzFrPiwFwM5jjYIisBzKS8Y11uXXlPSmsWW9gAsumolYuKBoSxiBqbVv6X
         KAww==
X-Gm-Message-State: AOAM530lymNzkYW+IEv13jMPqBXfaRj1VNa8c/JeEUH9dlbzvCUTD3Ez
        dGU2RPqDCeYpuI/30b/F/SMVYN07n0FfN7ziw2HHMw==
X-Google-Smtp-Source: ABdhPJwIH+cyPsq9bO3FdraGj6OvSy6jgmkNSoCj6ohDecG2rjLAnn9SJiY8LIXwnWs9epmvSWObibUgPiIYbVjqz4c=
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr12244345ljp.401.1643043798747;
 Mon, 24 Jan 2022 09:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20211118192130.48b8f04c@xhacker> <20211118192651.605d0c80@xhacker>
 <CAN37VV6vfee+T18UkbDLe1ts87+Zvg25oQR1+VJD3e6SJFPPiA@mail.gmail.com>
 <YeqkIKUsdHH0ORxf@xhacker> <Ye0cCI8aAC8rL1IE@xhacker>
In-Reply-To: <Ye0cCI8aAC8rL1IE@xhacker>
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
Date:   Mon, 24 Jan 2022 22:32:43 +0530
Message-ID: <CAN37VV4H=ts6GU1aV6M1mZk+SRb-3n3R_nz9Ao3_W1zcEKW4-A@mail.gmail.com>
Subject: Re: [PATCH 11/12] riscv: extable: add a dedicated uaccess handler
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jisheng,

On Sun, Jan 23, 2022 at 2:50 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Fri, Jan 21, 2022 at 08:16:51PM +0800, Jisheng Zhang wrote:
> > On Thu, Jan 20, 2022 at 11:45:34PM +0530, Mayuresh Chitale wrote:
> > > Hello Jisheng,
> >
> > Hi,
> >
> > >
> > > Just wanted to inform you that this patch breaks the writev02 test
> > > case in LTP and if it is reverted then the test passes. If we run the
> > > test through strace then we see that the test hangs and following is
> > > the last line printed by strace:
> > >
> > > "writev(3, [{iov_base=0x7fff848a6000, iov_len=8192}, {iov_base=NULL,
> > > iov_len=0}]"
> > >
> >
> > Thanks for the bug report. I will try to fix it.
>
> Hi Mayuresh,
>
> I just sent out a fix for this bug. Per my test, the issue is fixed.
> Could you please try?
>
> Thanks

Your fix works as expected.

Thanks,
Mayuresh.
