Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9265327A715
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1Fu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1Fu5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 01:50:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E412DC0613CE
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2020 22:50:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 67so53470ybt.6
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2020 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFcQejXEVui3rfrQE34kQ2VdPQ542OatrseITDIQSD8=;
        b=WXhEitkpbuURXduefUX6Cq2hiD+Bj4XvMcswGMBHi6B2OoTuZiuX4jA8xOGB31A6e9
         CmGa5G+p3mpaxUoWrhH61lvIhx7zyqg0VkQ4JuUNWMJQiMRpKXN4sCNanZljh+xVwUIl
         SmsXR7Ce+1WJniqM215Nmg629RfaGLFL0OUZe0cMsODMb1+Zg+NMOCiJJXusktR84+K2
         BTUaScWmiYwsBaJG5CH6FI5HvFhpa4NUTqrRLtN7DuqqqCoKFRrn3v8fLa4zRinT21Ra
         PWB9Tj7mFUy+g9RuZ0AU0h81EmnSnWmC69sNVSwuutE+sdKpBcITR77cIbHcEsv033lR
         fp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFcQejXEVui3rfrQE34kQ2VdPQ542OatrseITDIQSD8=;
        b=GlCrN8dibsbfakClCsLU3cwk2Qg7/rjOHnI7+qwwhgw1FEvviTT8ne2Wo+2kwJV1qu
         YSkz0xL6HTy28g/0mBbBpC+10TC3KvWyVHroQnPPejGkFVdYGXmmc+txshJMNZ3kJ0fe
         JIk7bEps17SQlF/226NnTSITH+SWKS8YcOqcS2eSVzko12eLKtYkjjBHOLfkltJjhabu
         ikNX5XRGi9V4ZNnJhOPy2E1W+BU4ykIzqyPryzVbzn6vgAKv480852JyfW1HlYZheEe8
         b4P03V2Uy/XqC0caG5afuc7ylBc98CqqTzeP7q+9ICXOUev9kc+h1nFkRsmvInEKmgFI
         nhNg==
X-Gm-Message-State: AOAM533nwQ8+q4fb+z4/4XcIjoeBHrviIWQbP71u3euRzU9qx/vyeEIK
        ojQ8tg9xTBn+lj0Z+VuqXt90TeqfW8Hytc1g/gsZ33zbQOE=
X-Google-Smtp-Source: ABdhPJyW/AeK/KKLQd1XPH0AgtfZHQ+AOxzr0EKvx3Fk1MfdaMkPsVLuLMp3F3ymCFd5n76DmG5XuOirovanRF5Wvro=
X-Received: by 2002:a25:8541:: with SMTP id f1mr12232809ybn.230.1601272255336;
 Sun, 27 Sep 2020 22:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
In-Reply-To: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 27 Sep 2020 22:50:44 -0700
Message-ID: <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 4:58 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> Hello,
>
> I'm developing a tool which is now based on BCC, and would like to
> make the move to libbpf.
> I need the tool to support a minimal kernel version 4.14, which
> doesn't have CO-RE.

You don't need kernel itself to support CO-RE, you just need that
kernel to have BTF in it. If the kernel is too old to have
CONFIG_DEBUG_INFO_BTF config, you can still add BTF by running `pahole
-J <path-to-vmlinux-image>`, if that's at all an option for your
setup.

>
> I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-tools of bcc,
> but both only deal with newer kernels, and I failed to change them to
> run with a 4.14 kernel.
>
> Although some of the bpf samples in the kernel source don't use CO-RE,
> they all use bpf_load.h,
> and have dependencies on the tools dir, which I would like to avoid.

Depending on what exactly you are trying to achieve with your BPF
application, you might not need BPF CO-RE, and using libbpf without
CO-RE would be enough for your needs. This would be the case if you
don't need to access any of the kernel data structures (e.g., all sort
of networking BPF apps: TC programs, cgroup sock progs, XDP). But if
you need to do anything tracing related (e.g., looking at kernel's
task_struct or any other internal structure), then you have no choice
and you either have to do on-the-target-host runtime compilation (BCC
way) or relocations (libbpf + BPF CO-RE). This is because of changing
memory layout of kernel structures.

So, unless you can compile one specific version of your BPF code for a
one specific version of the kernel, you need either BCC or BPF CO-RE.

>
> I would appreciate it if someone can help with a simple working
> example of using libbpf on 4.14 kernel, without having any
> dependencies. Specifically, I'm looking for an example makefile, and
> to know how to load my bpf code with libbpf.

libbpf-tools's Makefile would still work. Just drop dependency on
vmlinux.h and include system headers directly, if necessary (and if
you considered implications of kernel memory layout changes).

>
> Thanks,
> Yaniv
