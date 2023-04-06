Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C36DA2A1
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjDFUYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDFUYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:24:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAFAB
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:24:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-93e2e037121so155535366b.0
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680812674; x=1683404674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29W/VgxdWr4VFm/r+xHkcM9I1nCM97GYWmulaX8opBs=;
        b=ku2sWfX70RdDPWQdlIQkVdc8lHpfi1ylTTgdyPF9axlpuo7grQy/TVCYXhrmtt0CTY
         f/ZegC1+3SYGkqS251GsxgGojx1/QXOWiRY/7n6pA0xGoVene3bZ3YvQD7nuvlPmSHAR
         DqsGbX6P4IRk+GSbVQ37QKKFdUQShtRLN6kVgkdIi4maiRe3TPz0Cd1ZIa6CkMM5BdiP
         JhLG6AF4fvdU5cPOOpAx83KmFWrzi6m9eRltgYipTHpDhqigYqpHfVXVtAGlpmkbwX6/
         GYruN2TIFmqTmiuRqxUqIPPLyw0L7TJTZnkQGuiE1fuDEtVsdiy8gkg2/WpKOPoVDdhJ
         4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680812674; x=1683404674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29W/VgxdWr4VFm/r+xHkcM9I1nCM97GYWmulaX8opBs=;
        b=x/+m0L6Y/8igvKCXqRZbrctATBVoROyKvJ1+LCUnk6yjvbBljIQpRZiW1jqwOHn1kH
         VlqSCjhQdqEJLYJivuARjXTFotYBfIJcpXE8I4mquw69KTHnCb0Z0nUedXbeqggRc5lb
         KcVTv5sh6fojRbUZ9QLu6DFUAxWoR2zgCv35brrIB849Z+r/B4iB1iNBcS51ORMk33aD
         HRJc2QJLENmxo8ZjVds+BPIFnboEX0k+afceWWjhUZK/8DYqOTm9EP56bw8BPeLt7fOw
         r6DGJ8Pd4o1Qs1OicpaKjGm+l53NKfgc+xXP0XgmaTOFXZTPwiAIXAoW+QBvI2Q2uCuB
         PHOA==
X-Gm-Message-State: AAQBX9eqq0mDKEEElDxgXXgSegUqMMZI3RI13bqUmsF4W1JchXmeHGc8
        VaWnkSD2V0h3ObjX04DEhcHD2CP2oG/AYFezZjY=
X-Google-Smtp-Source: AKy350arbSe4VfZ/Avn5z9Qcrme3/n8M09wKP+2XOAhlB6sgjEKhjytm3jK/W1MwHdtJmR0TP7+5fok38pkSbFqMNd4=
X-Received: by 2002:a50:d6da:0:b0:4fa:3c0b:74b with SMTP id
 l26-20020a50d6da000000b004fa3c0b074bmr419465edj.3.1680812673736; Thu, 06 Apr
 2023 13:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
 <ZB8LX/BKPgvzfvcm@der-flo.net> <CAADnVQKyRpg=-uxCH6eNxPfvUCS8tKSe-AV-1304rRdTYxG1JQ@mail.gmail.com>
 <ZC8ovRMLxL5ehzWu@eldamar.lan>
In-Reply-To: <ZC8ovRMLxL5ehzWu@eldamar.lan>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 13:24:22 -0700
Message-ID: <CAADnVQKFfPZEoPHPFm+4qBAirz4LmD3U8hen92Wac=jS+ofqZA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Florian Lehner <dev@der-flo.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Rik van Riel <riel@surriel.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 1:17=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi,
>
> On Sat, Mar 25, 2023 at 12:47:17PM -0700, Alexei Starovoitov wrote:
> > On Sat, Mar 25, 2023 at 7:55=E2=80=AFAM Florian Lehner <dev@der-flo.net=
> wrote:
> > >
> > > With this patch applied on top of bpf/bpf-next (55fbae05) the system =
no longer runs into a total freeze as reported in https://bugs.debian.org/c=
gi-bin/bugreport.cgi?bug=3D1033398.
> > >
> > > Tested-by: Florian Lehner <dev@der-flo.net>
> >
> > Thanks for testing and for bumping the thread.
> > The fix slipped through the cracks.
> >
> > Looking at the stack trace in bugzilla the patch set
> > should indeed fix the issue, since the kernel is deadlocking on:
> > copy_from_user_nofault -> check_object_size -> find_vmap_area -> spin_l=
ock
> >
> > I'm travelling this and next week, so if you can take over
> > the whole patch set and roll in the tweak that was proposed back in Jan=
uary:
> >
> > -       if (is_vmalloc_addr(ptr)) {
> > +       if (is_vmalloc_addr(ptr) && !pagefault_disabled())
> >
> > and respin for the bpf tree our group maintainers can review and apply
> > while I'm travelling.
>
> Anyone can pick it up as suggested by Alexei, and propose that to the
> bpf tree maintainers?

Florian already did.
Changes were requested.
https://patchwork.kernel.org/project/netdevbpf/patch/20230329193931.320642-=
3-dev@der-flo.net/
