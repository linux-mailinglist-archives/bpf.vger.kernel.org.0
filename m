Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF2619D64
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKDQhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiKDQhB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:37:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41C27156
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:36:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d3so832724ils.1
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yoi4SgoXxG2si25isu4xW2Q1SrdJci1qbnXfZSaIdso=;
        b=rn/JdTuEssdkW6hUEJf4Zna2IuyZLWDt6rCjIriPeTVt2Biv37aoNoh4tb3l+rZJ1H
         HGe9XFZjCXsQSwYR9muntOCyUNYRBtRHRI16A6dmU+VqTFUbmQstyEw9yu3GK4SGiu6L
         xJ7gFzBPdKoKYZoe6zQbiTcJcSxf04cM7MzzLuzzWb+w65pLfhp2QAQQ3+L2YY1wnrL1
         o6EuR75woA4qcHnn+P0dNE4skVUXBI0uyWs3MmzQQmPuXxfmCK33bz1KEhF9kMqHME9U
         av5/4htku5unbPD9qbWq+TnagkpFrf/SlFbJAfzIAhpLTi4ZH8Cb8D+pAX1U1TdEFOYx
         Vixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoi4SgoXxG2si25isu4xW2Q1SrdJci1qbnXfZSaIdso=;
        b=FayMPXR/yp8hTzIC4sD9jf5vkZ3eyR53XDlFCcD43e2+Orb+WGacoAk2ryGKkxcIRl
         sOR25G8mWEHDhQ/O6fiomDaVp6PxTa88yaQj3sxhMEdAHe3kTg8LjoTe8hTnjTo7SAwq
         X6ndrrQ60pAGifckfq2I8lQUUmexFKmtDp//IFFbZV9IgDhkxhsSv5gqfCiWKMNoHm0Y
         P7AdzXekci6fJjZFp9kCIp5U3tfYwHwYmJ5Rp1NTxDo7919A9NVH3vOVJwAT6gcDG73g
         v2yurorWOig+RVcAwgwLH3+E7Nx290z55pBFizxwdfdpIwwprdgpDQoHhlSY9lZ/M8Yo
         MpJw==
X-Gm-Message-State: ACrzQf1+vM3jzqRbdZGzUoAy3gp/othojhlV0PV6YB+5yJaQ2B/Papdz
        D1aYUNOa04l+0kTlnT0CIMXQbPsupDNjKIE3bnv/DA==
X-Google-Smtp-Source: AMsMyM648QwPmPn4H6x1eIoT9HB9DcnyMH+EQwUDCdb/Izl5tNCcsM30bie3hIC5qM2EoVXFtlUIfXtvJiWU66i1ubM=
X-Received: by 2002:a05:6e02:d49:b0:300:d893:a3f8 with SMTP id
 h9-20020a056e020d4900b00300d893a3f8mr5335739ilj.53.1667579818679; Fri, 04 Nov
 2022 09:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYKmr0daXhCSkvNZYgx_rDuBaq1OExnw=AEMJ+fSzaHwg@mail.gmail.com>
 <CAADnVQ+MgOdgQYXPWUOyqs4p7nFKtHCj_H1V_AWkYfnosy2PBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+MgOdgQYXPWUOyqs4p7nFKtHCj_H1V_AWkYfnosy2PBg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 4 Nov 2022 09:36:22 -0700
Message-ID: <CAJD7tkYA61FBsAEuzHCt2evK1NLyBrKy2wAsXcWzdQNq=v+LKA@mail.gmail.com>
Subject: Re: Question: BPF maps reliability
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Nov 3, 2022 at 11:28 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 2, 2022 at 11:48 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Hey everyone,
> >
> > TL;DR Are BPF map operations guaranteed to succeed if the map is
> > configured correctly and accesses to the map do not interrupt each
> > other? Can this be relied on in the future as well?
> >
> > I am looking into migrating some cgroup statistics we internally
> > maintain to use BPF instead of in-kernel code. I am considering
> > several aspects of that, including reliability. With in-kernel code
> > things are really simple, we add the data structures containing the
> > stats to cgroup controller struct, we update them as appropriate, and
> > we export them when needed. With BPF, we need to hook progs to the
> > right locations and store the stats in BPF maps (cgroup local
> > storages, task local storages, hash tables, trees - in the future -)
> > etc.
> >
> > The question I am asking here is about the reliability of such map
> > operations. Looking at the code for lookups and updates for some map
> > types, I can see a lot of failure cases. Looking deeper into them it
> > *seems* to me like in an ideal scenario nothing should fail. By an
> > ideal scenario I mean:
> > - The map size is set correctly,
> > - There is sufficient memory on the system,
> > - We don't use the BPF maps in any progs attached to the BPF maps
> > manipulation code itself,
> > - We don't use the BPF maps in any progs that can interrupt each other
> > (e.g. NMI context).
> >
> > IOW, there are no cases where we fail because two programs running in
> > parallel are trying to access the same map (or map element) or because
> > we couldn't acquire a resource that we don't want to wait on (that
> > wouldn't result in a deadlock)., situations where we might prefer the
> > caller to retry later or where we don't care about one missed
> > operation.
> >
> > Maybe all of this is obvious and I am being paranoid, or maybe there
> > are other obvious failure cases that I missed, or maybe this is just a
> > dumb question, so I apologize in advance if any of this is true :)
>
> It's a correct summary.
> The reliability of map and local storage is certainly required in some cases.

Thanks for taking a look and confirming my thoughts!

> The "new generation" map types with bpf_obj_new and explicit
> map operation will make it easier to audit all the code when
> memory allocation can fail or recursion prevention can kick in.

Makes sense, looking forward to that!
