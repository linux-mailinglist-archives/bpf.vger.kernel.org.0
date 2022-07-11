Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2B570852
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiGKQ2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGKQ2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 12:28:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6EBE3E
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:28:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so6941265eda.3
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqEI8Il5uAZvj4G3tagisSZR47WmODJe3t0eKveEOZo=;
        b=EMDUxtgUl6IeRMdJ+6b4G4WGAKBJ95HZhMS3A6iBS9Yrog0eJ7j0/nlEhBZhPg0T/G
         Af1WQksHyI0QRnDwqol2fopP4GdOheexGQyzo1HLxVUQG0jFyLQXZvWhqwwStwerskAl
         dawA7/cB1cJ8gafDBwJX5gS5yQYMg9SjN0jSnNbVGFfAKHZFektLC3VgVly5JUkACL+3
         8YEWxQdKsXGj5onaYevZD8y5ZTWmUP5TCdLPrgLbOQM23DGD3EPAu+hhYhrg0PsxDuVj
         XvuXOW6E1XP9S0VjToM6ROMjLZRLwdA2BoLnWTus9BPC72oweDwebgAqXoAwJBmMqPKe
         H4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqEI8Il5uAZvj4G3tagisSZR47WmODJe3t0eKveEOZo=;
        b=LxHqp4wSjpEpkjtFgmZJbFqNNsdLmhKS2jqZFpZDC0siYUZZ+OnYIf+fr7CmZWpGci
         rdViwe4P86bJ9hEYXHg+Z/etF449Xh6HhSgbrtgCZ83pxP1SKXsDEPOuKqNK/LpCYVCc
         uW//WXKRZA9h6UYAfrXiy4CLKTVT9C4sTDIaahoqPMo4mPc6Cdgvko5OgH34Ugz7Estz
         qSmpvfDc8oDQ/fkyhS/Tmq8IjGAjZY9vcU8uZifROrdoh0AwdWEu4WAlKOKFIa4RJgQU
         vInK97SUYhyrRy20P/vwqJsDn2Bv1wWz3aw7t1j/fHKfzsV8FE/nID/KUeOF1HbYTQsT
         N8dg==
X-Gm-Message-State: AJIora+FGcqekC+UfFiIEr42OLl918D8p4CWhjjdTQjMSSQskscMMUjZ
        F+RMu/efvqIZxJtSb11EU8gUe850NGk99vagNkCSJdTsrKA=
X-Google-Smtp-Source: AGRyM1sGsQtyXnwsCiiQxE7jh+Lm7puS345kpERWQowvR2qih4cXUVjCmfGen+1Rx5y86UUE+EaCHYHbS+O1DDy+Iyc=
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id
 n4-20020aa7c784000000b0043acaa875b9mr12052416eds.311.1657556920782; Mon, 11
 Jul 2022 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
 <YsgU1kjVndNjJhI8@krava> <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
 <CAADnVQLeEz8NLf9b4reOKdyrtneHcv4ExSGn7Z8ysk1nYSayYw@mail.gmail.com>
In-Reply-To: <CAADnVQLeEz8NLf9b4reOKdyrtneHcv4ExSGn7Z8ysk1nYSayYw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 09:28:29 -0700
Message-ID: <CAEf4BzYKkf0A1LqLqbjUqO6CMWDRVqg9OBizfwuZL-0p4ioRJg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Sat, Jul 9, 2022 at 5:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 8, 2022 at 3:05 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jul 8, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > > Maybe we should do the other way around ?
> > > > > cat /proc/kallsyms |grep sys_bpf
> > > > >
> > > > > and figure out the prefix from there?
> > > > > Then we won't need to do giant
> > > > > #if defined(__x86_64__)
> > > > > ...
> > > > >
> > > >
> > > > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > > > bpf() syscall is particularly bad with also bpf_sys_bpf):
> > > >
> > > > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > > > ffffffff811cb100 t __sys_bpf
> > > > ffffffff811cd380 T bpf_sys_bpf
> > > > ffffffff811cd520 T __x64_sys_bpf
> > > > ffffffff811cd540 T __ia32_sys_bpf
> > > > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > > > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > > > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > > > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > > > ffffffff83abc410 t _eil_addr___x64_sys_bpf
> > > >
> > > > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > > > ffffffff81024480 T __x64_sys_mmap
> > > > ffffffff810244c0 T __ia32_sys_mmap
> > > > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > > > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> > > >
> > > > We have similar arch-specific switches in few other places (USDT and
> > > > lib path detection, for example), so it's not a new precedent (for
> > > > better or worse).
> > > >
> > > >
> > > > > /proc/kallsyms has world read permissions:
> > > > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > > > unlike available_filter_functions.
> > > > >
> > > > > Also tracefs might be mounted in a different dir than
> > > > > /sys/kernel/tracing/
> > > > > like
> > > > > /sys/kernel/debug/tracing/
> > > >
> > > > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > > > but given it's done once, it might not be a big deal.
> > >
> > > we could get that also from BTF?
> >
> > I'd rather not add dependency on BTF for this.
>
> A weird and non technical reason.
> Care to explain this odd excuse?

Quite technical reason: minimizing unrelated dependencies. It's not
necessary to have vmlinux BTF to use kprobes (especially for kprobing
syscalls), so adding dependency on vmlinux BTF just to use
SEC("ksyscall") seems completely unnecessary, given we have other
alternatives.
