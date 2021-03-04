Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4F32CD52
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 08:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhCDHGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 02:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhCDHGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 02:06:36 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD79C061574
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 23:05:56 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p186so27420994ybg.2
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UIpalyzZhY0VSQwJcf30AoOuabGWGzwllajlMZCdSs=;
        b=HZzLKDQzMIOuYqGu2qN9cKyvG8+QjtCzp4GlS3Cezo6GJwCMl9bE4QyG1WzSbPP2tw
         PCufhviZWLcZcDMWZoPeV+CtxDph9Gynd0CwLDC7o6mIY4bffvmFVRyphbAFqqJzKDBA
         tamGaMotkxqV8p1cm9uTPSQBjEa9GHaqY+/Y5ViJpYSwbnmCrSaVnQVMqXJcUWgvuUHp
         25t8JwxhdYFaVrS1EOfMUXCXBJLe4QyAHgXcpqRuFe0I0/xjLMP48btUtEswEXPs4epH
         dsaBbCn9D7faFpIf9aiWMd2eAtwajhC7+hnujAnY5QyzAi0VcADz5LCjoyZ2ZhTDYhjT
         CsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UIpalyzZhY0VSQwJcf30AoOuabGWGzwllajlMZCdSs=;
        b=OhoZwTs4dNWflc093ZAveJihJ1+EJXr41Ela9TrZwbM8vzYbwTUYXxKHx6D/4EazPV
         HZeODMvyoMnmbvYLOGN/y+tCHna27nDBlDbcZyaI6RLS2ztuExxfKL577OA3Amn9xCnL
         ZlHqi/zExhYXbxKowD3eCpOellq6iCqRQ3UQQs0JnuxRdRzexc15h1np2+KggMm6uRPO
         EttsooHZ6A5bMKY1os2jv2KvfDgpdf6ojUTtQSP+XUATKoi4hPDGOjqbD/BippS9aGtE
         7MgGNcCZWfzmooCoMNYBIckOYHdVbO6iawbUNxOM1BEJhNeUFQVYNLq0sBO+NcFygGZJ
         Ni9A==
X-Gm-Message-State: AOAM5311xPzMtLF3smaesSAO26RhNmVWjngSHBWnFKgj0WMfJ0Upu53N
        9nz9k+z+4N86XnY4npHNokY20py9x51zhyQDV2I7KQP5uKM=
X-Google-Smtp-Source: ABdhPJzl9fE5ggxDJnEcNcGYgh6J0993kj9UZ7BQXN+BcFkWSUe3wFvIS63vYCuTBnNUOwG34wxydRBllg1o5r65iic=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr4383848ybc.425.1614841555127;
 Wed, 03 Mar 2021 23:05:55 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210303181457.172434-1-rafaeldtinoco@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Mar 2021 23:05:44 -0800
Message-ID: <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Vamsi Kodavanty <vamsi@araalinetworks.com>,
        rafaeldtinoco@gmail.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021 at 10:15 AM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> > > From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
> > > Date:   Thu, 7 Jan 2021 17:31:11 -0800
> > > To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc:     bpf <bpf@vger.kernel.org>
> > >
> > >
> > > Right. Libbpf only supports a newer and safer way to attach to
> > > kprobes. For your experiments, try to stick to tracepoints and you'll
> > > have a better time.
> > >
> > > But it's another thing I've been meaning to add to libbpf for
> > > supporting older kernels. I even have code written to do legacy kprobe
> > > attachment, just need to find time to send a patch to add it as a
> > > fallback for kernels that don't support new kprobe interface.
>
> Initially I'd like to thank you *a lot* for this thread, it helped me
> creating:
>
> https://github.com/rafaeldtinoco/portablebpf
>
> showing up exactly what was discussed here AND I could run the same
> binary in v4.15 and v.5.8 kernels as long as BTF was generated with:
>
> https://github.com/rafaeldtinoco/portablebpf/blob/master/patches/link-vmlinux.sh.patch

I was wondering if it might be useful to have a script that would use
pahole to do DWARF to BTF conversion for existing vmlinux image (e.g.,
from /boot/vmlinux-$(uname -r)), assuming DWARF is in that vmlinux (or
could be found somewhere nearby), and then would spit out only .BTF
contents as a binary file, which can be passed to libbpf on
bpf_object__open(). That seems useful and there have been at least a
few cases where people tried to use CO-RE on old kernels
pre-CONFIG_DEBUG_INFO_BTF, but were always confused by how to get that
BTF data.

[cc Arnaldo]
It would also simplify things a bunch if pahole had an option to emit
.BTF into a separate non-ELF file, instead of modifying vmlinux
in-place. WDYT?

>
> Specially the attach_kprobe_legacy() function:
>
> https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31
>
> I wanted to reply here in case others also face this.

Great, glad it worked out. It would be great if you could contribute
legacy kprobe support for libbpf as a proper patch, since it probably
would be useful for a bunch of other people stuck with old kernels.

>
> Only bad thing was kernel v4.15 missed global data support as showed in:
>
> https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md
>
> But using perf event was good enough for an example.
>
> - rafaeldtinoco
