Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7D5A050C
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiHYARA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiHYAQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:16:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916D8606B
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:16:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so19493202ejb.13
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kCz09irjxY9YaHQep0oAlZ3lBrB3BblbrjYoXYiA4aY=;
        b=ITbrRwY7USYG3/TGHrty44UPt9sJc4odl//myOMocK1xJGvsAMvsXabrPxdbchTVJW
         Drqdm2QLQaNhT/+vSg8GFN/+xL2L25YHh79/r0gwjea7oqeWQ+e+BhtmynqcaBvAQega
         4n1MnhZyhXIf8DT7GPr7bCe5Jh2IkYUf3e9QSgoYe8O60ItcXBGQWCveO9AH75OY5lcA
         S/+7Q0EQOQBU14xoVYqWyzhsf+kDKuLVmHHu/IZEKkG9F7ELdDZ3XybAmyXsD58MHoVL
         2CiBVXTK1CHg40hcWhAXD7rAKV/Gz6ZbyIi46HrSMoHSgjjLtjC2t62eQx08HIUejDqU
         GLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kCz09irjxY9YaHQep0oAlZ3lBrB3BblbrjYoXYiA4aY=;
        b=4qIcnIZS1vUdm2oxVrf9aO9Y2cDenyvQmq3XHPG6HHnMGF7cfYTIWfUxNt/cg4+g1y
         GQ1a2vCE4A9KkTZ642yWqDsTHi961EngkEpFHJkSYB0q/oeDSc6l3X2hCcA3ElRo5mxW
         yNo33dD2N/ixV9Bm68y23eplz8hOTP1qnfCimPXjBI+KqwwdBYg4U/z7sySphinmoDhI
         /YExGWrlWo2WiNC3KnR3NsgfsEZ9A4AkActlpMMt+D2Ejq4LcxZnjG3omHCA55xAxRMw
         j3217JA05z3pCAYvVsYGMAh8vSM/8ub2BOCoXO+h3fBG3a39pJGIck8Y6vK0NrPYhCCW
         pShA==
X-Gm-Message-State: ACgBeo3H+cZsuJxhuiP3DARBacahPNYWlkX1YDAWYLIB+5Wcrc12+82g
        ct3auCUpditq22Dbk9afynFaBa//NncAIPJ/p18=
X-Google-Smtp-Source: AA6agR4Rw4qAYL9MLvTCk4zyY6F3vqn5Bp8OXH4zlCs0HCUoiTtpKCAlszjhS6lpgMaSdHHBKnB9sOE5j7WHkba0RlE=
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id
 z21-20020a1709063a1500b0073d80bf542cmr808205eje.633.1661386615832; Wed, 24
 Aug 2022 17:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com> <CAP01T75WHh_zCgM6uf=W5uQzJSWODnsZNy0g-Wj2Z+KOoDW_FQ@mail.gmail.com>
In-Reply-To: <CAP01T75WHh_zCgM6uf=W5uQzJSWODnsZNy0g-Wj2Z+KOoDW_FQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 17:16:44 -0700
Message-ID: <CAADnVQKt-i3SitwjMkGGG9mEsKh=Hmjg1C-omkhLw_pg6gaQVw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
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

On Wed, Aug 24, 2022 at 1:03 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 19 Aug 2022 at 23:42, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce any context BPF specific memory allocator.
> >
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> > Front-end kmalloc() with per-cpu cache of free elements.
> > Refill this cache asynchronously from irq_work.
> >
> > Major achievements enabled by bpf_mem_alloc:
> > - Dynamically allocated hash maps used to be 10 times slower than fully preallocated.
> >   With bpf_mem_alloc and subsequent optimizations the speed of dynamic maps is equal to full prealloc.
> > - Tracing bpf programs can use dynamically allocated hash maps.
> >   Potentially saving lots of memory. Typical hash map is sparsely populated.
> > - Sleepable bpf programs can used dynamically allocated hash maps.
> >
>
> From my side, for the whole series:
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks a bunch for all the suggestions.
Especially for ideas that led to rewrite of patch 1.
It looks much simpler now.

I've missed #include <asm/local.h> in the patch 1.
In the respin I'm going to keep your Ack if you don't mind.

Thanks!
