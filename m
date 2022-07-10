Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07156CC17
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJAi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJAi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 20:38:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743712A9C
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 17:38:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os14so3403975ejb.4
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8ewB62WGOKPyH3dguLCxJYshiiBjeE8pCehH/VaqiM=;
        b=oMPKlBUk3hKD/UAe7Ns4ruY0MH9aSstGL19JrOwLS5htMxE3F9NLGfOG83xymy7pQZ
         LvUgCwape17qcCaIY6yyJKg1ozvlMhHF4PGO25DfymRBxLXa8YMUCXCwrfjeOBgoaxAS
         +11jruGGRA2CUP0B0/1J1yv+vSUZfYN4MOz1y6ivXJleDSUoJ2JIIXRzFQQMnFNW3PIF
         S7MHzk/w06H3M6dz/FD0B9stJbO3qh/Cv9l8LJnTX3al5wkp955Dg4Y2tBuzhIqc34oh
         K5OvNww6L8rshR7Wd8W3nJb5N25nsLyxo2VkMwDQ4eH7nDENJkkzAUMQr+0GXDsbn4wo
         6Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8ewB62WGOKPyH3dguLCxJYshiiBjeE8pCehH/VaqiM=;
        b=j9fllufw9sDOI4sC9HFzcqmFjRrAEuPgJRaQrvO7IV23/+dahjWii3rgQNkORdIL8y
         qycXdtTe4GrYDwHL77nWvZpiQmEIKofF5e07Y/5Lpm5kK6nOdhTrrVcTViCDEbGWD3iF
         RRv0Hw3iZu8nmfz9HC+KmVwxucOb68Q//+6xsZrOjrI0nD1ppUPQOdtaXm1jV86hehlL
         G3a8OlC4Tp/Vh2Nr62/JLctJfeNfKoSXCG1j3FGgEv5hPFGYyPuGOxmtFy+Fdw5n4Uu6
         IuRccD/zzTXPMb2AcW4LXxVq6WkHNILhimVZVZPpwdqVGLqm3EHHoW0fPwgOUM6P/VEI
         sXtQ==
X-Gm-Message-State: AJIora85xVGbIfmGka7oEEgsRdtEUMwugdIQq9fK94gMNrZ0mZ5rybw7
        nGNONp8KS1nZNaACv+neeQ28Rh67l2VYLNYBnng=
X-Google-Smtp-Source: AGRyM1tzrSQKEBWYsAjZ/siLnJjs3kVjTJ2X6dLMargAtpFIVqtboC2lJ94qT0r9z5vIQh9xrne4xvEAytJB9S6GWnA=
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id
 y9-20020a170906518900b00722dc81222amr11233742ejk.502.1657413504219; Sat, 09
 Jul 2022 17:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
 <YsgU1kjVndNjJhI8@krava> <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
In-Reply-To: <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 9 Jul 2022 17:38:12 -0700
Message-ID: <CAADnVQLeEz8NLf9b4reOKdyrtneHcv4ExSGn7Z8ysk1nYSayYw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
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

On Fri, Jul 8, 2022 at 3:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 8, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > > Maybe we should do the other way around ?
> > > > cat /proc/kallsyms |grep sys_bpf
> > > >
> > > > and figure out the prefix from there?
> > > > Then we won't need to do giant
> > > > #if defined(__x86_64__)
> > > > ...
> > > >
> > >
> > > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > > bpf() syscall is particularly bad with also bpf_sys_bpf):
> > >
> > > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > > ffffffff811cb100 t __sys_bpf
> > > ffffffff811cd380 T bpf_sys_bpf
> > > ffffffff811cd520 T __x64_sys_bpf
> > > ffffffff811cd540 T __ia32_sys_bpf
> > > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > > ffffffff83abc410 t _eil_addr___x64_sys_bpf
> > >
> > > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > > ffffffff81024480 T __x64_sys_mmap
> > > ffffffff810244c0 T __ia32_sys_mmap
> > > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> > >
> > > We have similar arch-specific switches in few other places (USDT and
> > > lib path detection, for example), so it's not a new precedent (for
> > > better or worse).
> > >
> > >
> > > > /proc/kallsyms has world read permissions:
> > > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > > unlike available_filter_functions.
> > > >
> > > > Also tracefs might be mounted in a different dir than
> > > > /sys/kernel/tracing/
> > > > like
> > > > /sys/kernel/debug/tracing/
> > >
> > > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > > but given it's done once, it might not be a big deal.
> >
> > we could get that also from BTF?
>
> I'd rather not add dependency on BTF for this.

A weird and non technical reason.
Care to explain this odd excuse?
