Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64956C404
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiGHWF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGHWF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:05:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BF9CE38
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 15:05:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n8so173585eda.0
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXU51OK0HEudXgpS61jawtfK+ibB7PwOvPOK1QAUqnQ=;
        b=qtcYeOtrk+uhB/m5fNZW7AtGUQCdkH6DGYDtawaQKazLP5DsZTbZwAilabM9p8X2zL
         o7u229oUIWgO8VhzhLmIiLxiU9ZWco1jYNv9+xibZePk796QV8tiEgLA3T9VzmlDc8ZI
         bawQQpfy+LD1eWrg2x+05bC6aU9gyERbmBalxp7MUViv5cFLaOxOvzTb63XmlD6N0wuP
         k0FWYaO7v9WoKUSkBvyJZqWEY3lqWLU1iJfk/ryULdUdLrc5VLziYt5yDtjrLbe/hCPp
         F4zMzUvdOlilgZZ7dPhrjkSLCHbzEEIUEXWvroDyC5Moq8W/dV9tlF4xaanJQPYB3xpu
         gGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXU51OK0HEudXgpS61jawtfK+ibB7PwOvPOK1QAUqnQ=;
        b=jYoRGD0+ZXclU9RcGGpeuRD7xCcX22eTJsqoC6AuLJiDvIkV9QEJ8cN95TnaQP7t+s
         4rXBsoy7JzcdPILUYDlJSJkI5td3BskN44Af4cMw3aeYzFuq/eQmZFfjV29sNVlJ4Vmv
         tdWDUQ+MDKu23To9OWNiQMO+Im6J1A5wB/5d8M7kXjgg6XSqb5cqs2Kso9eJe638ipiZ
         bzt9hXmj+aK4NO+42QszqGSrf20/ntvAQlzUxHN3UJh3z2oPtq/DhwcZULMr2VNi/hNG
         zl3YJuIz7Kz37EZY3ilz3ut8y2yI9IUDetJMp0/Q2fkzGdmeBTe65imBtfTQMEBh6CvF
         F+Ig==
X-Gm-Message-State: AJIora83uOXtEAEV3bYupiCaNZFUJgrUU8Byv+t8UXSUP7SO+VNPnnUG
        ycM9/PtI1PYJ/jUo0f8eWdnzFU4KHe1ZFhayxkw=
X-Google-Smtp-Source: AGRyM1uDOzX8/u2vAJkdCB5XQdIlFQyOh/QZsjEq4nhhnJsbmCCVKGFD9LOejsIZbQEyt0gknfVzj37+k7BkHm6lXGs=
X-Received: by 2002:a05:6402:50d2:b0:43a:8487:8a09 with SMTP id
 h18-20020a05640250d200b0043a84878a09mr7691337edb.232.1657317953498; Fri, 08
 Jul 2022 15:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com> <YsgU1kjVndNjJhI8@krava>
In-Reply-To: <YsgU1kjVndNjJhI8@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:05:42 -0700
Message-ID: <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Fri, Jul 8, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > Maybe we should do the other way around ?
> > > cat /proc/kallsyms |grep sys_bpf
> > >
> > > and figure out the prefix from there?
> > > Then we won't need to do giant
> > > #if defined(__x86_64__)
> > > ...
> > >
> >
> > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > bpf() syscall is particularly bad with also bpf_sys_bpf):
> >
> > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > ffffffff811cb100 t __sys_bpf
> > ffffffff811cd380 T bpf_sys_bpf
> > ffffffff811cd520 T __x64_sys_bpf
> > ffffffff811cd540 T __ia32_sys_bpf
> > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > ffffffff83abc410 t _eil_addr___x64_sys_bpf
> >
> > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > ffffffff81024480 T __x64_sys_mmap
> > ffffffff810244c0 T __ia32_sys_mmap
> > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> >
> > We have similar arch-specific switches in few other places (USDT and
> > lib path detection, for example), so it's not a new precedent (for
> > better or worse).
> >
> >
> > > /proc/kallsyms has world read permissions:
> > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > unlike available_filter_functions.
> > >
> > > Also tracefs might be mounted in a different dir than
> > > /sys/kernel/tracing/
> > > like
> > > /sys/kernel/debug/tracing/
> >
> > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > but given it's done once, it might not be a big deal.
>
> we could get that also from BTF?

I'd rather not add dependency on BTF for this.

>
> jirka
