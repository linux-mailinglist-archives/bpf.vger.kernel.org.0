Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C062F3CED
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438081AbhALVhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437038AbhALUsX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 15:48:23 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D570C061575;
        Tue, 12 Jan 2021 12:47:43 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e22so7006641iom.5;
        Tue, 12 Jan 2021 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PUnqZbs5+Royz4WGHui/7WAHJXMTS7Yr1QlZSxAOkYg=;
        b=XF2eQt+aj4MbJYA3MK9Dcw0P2tJt46wXh4kVKOKsCFDScxCQ/K3olTWbx2UvkE8NAr
         LT6N5InHvjeNbn3iHCuCGqYoyaYr7XN/ZU2I7ppLsiyVF5H8fUyJwpALOPGFH+DjUfMa
         44JjBPC8nL6YLrRx6ZB2dMKe1UTHpMsqotqrL4xFNikb4YyiWorwmHv2WbsiUk4ydMd2
         LWJuMq1Vl1LFAXWSqEmtTckxZuacMbDzPT20MKx63TcvwUqugIxNgZPYtpvvWSAqt2xr
         Lkzdbb06wKBt2VSMEVbs7CYB1RU9+zGrSsG4+OQsniB5V42Z0i0tpV7joUszMsTQs6W6
         E1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PUnqZbs5+Royz4WGHui/7WAHJXMTS7Yr1QlZSxAOkYg=;
        b=rpaOCdEtLEnWi5WqkZ1o/Gdv9GvkXL4UrQa4w1OMA/7BrzN68JIGvfCunHZE8zBHy6
         TNM76UwNk6OvTKef7HBroDkD62RthcF7FacyuSdctm3unOhIekkusKJOU4dovFVQFJS1
         uwuewD5XkwO0TmfoJOQXLH5tXP4pAlW8B36iJ0VqT7HSQJhcmiQ+CsVtm+NV7tq6pX3i
         EXNo7Eg7g795mDw0cU1B10MnQm/JZh9n42+s03NvMAZ553WuK3WRrT+jcrYzs2iY3XKJ
         hA5b+OkKiUXnRSkt5FfXStG1IDrZcXL6db5a+FiDvbHnQNUWMQWQ0+KrNMVEIPr3rsd6
         bgjA==
X-Gm-Message-State: AOAM530JgfFrSnDEMdct4xE8tiawUT4RT/T+e91t0i4J+fds0G7q/rPK
        H/GPgEZBqM+L5lAYk8AJDg5Q571qTGCS0ECnqWQ=
X-Google-Smtp-Source: ABdhPJx1AwNsufN9566bzX52HSPhB8f5jrJzB0w0PQjcfYygiNosQ5/Unl59qeyxFQRmhCHH4P73UNzSFZTEu4e69Ds=
X-Received: by 2002:a5e:d70e:: with SMTP id v14mr679967iom.75.1610484462528;
 Tue, 12 Jan 2021 12:47:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava> <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
 <20210112104622.GA1283572@krava> <20210112131012.GA1286331@krava>
 <CA+icZUXNEFyW-fKH_hNLd+s7PB3z=o+xe=B=ud7eA5T3SW6QFg@mail.gmail.com> <20210112162156.GA1291051@krava>
In-Reply-To: <20210112162156.GA1291051@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 21:47:30 +0100
Message-ID: <CA+icZUU8MFFJMqFRAN7ekRzupPrS6WS5xGChUaFcjq2hfqW_wg@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Is it possible that someone tests with Nick Desaulniers's DWARF v5 patchset?

With b4 tool installed:

link="https://lore.kernel.org/r/CAKwvOdkZEiHK01OD420USb0j=F0LcrnRbauv9Yw26tu-GRbYkg@mail.gmail.com"
b4 -d am $link

...should give you a file which you can directly apply with git tool.

File: v3_20201203_ndesaulniers_kbuild_make_dwarf_version_a_choice.mbx

As my selfmade LLVM toolchain seems to be no good choice I jumped to gcc-10.

I see gazillions of DW_AT_ and DW_TAG_INVALID (0x48) warnings:

die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x1c2a25e> not handled!

This might be due to DWARF version 5 patchset.
I did not check DWARF v2 (default) or DWARF v4 choices.

Beyond this, I noticed:

$ git grep LLVM_OBJCOPY scripts/ tools/
scripts/Makefile.modfinal:              LLVM_OBJCOPY=$(OBJCOPY)
$(PAHOLE) -J --btf_base vmlinux $@; \
scripts/link-vmlinux.sh:        LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
tools/testing/selftests/bpf/Makefile:LLVM_OBJCOPY       ?= llvm-objcopy

When only passing gcc-10 as compiler and ld.bfd as linker -
LLVM_OBJCOPY=objcopy is passed.
Means objcopy from GNU/binutils is used.
As far as I understand the code you want here llvm-objcopy
(scripts/Makefile.modfinal)?

I did a next tryout with gcc-10 and LLVM=1 means use all equivalent
LLVM tools to GNU/binutils.
Means use llvm-objcopy, llvm-nm, llvm-ar, llvm-objdump, etc.
Please see the link below under [1].

En plus, I tried pahole with Jirka "Convulted" Olsa (JCO) fix by passing...
   PAHOLE=/opt/pahole/bin/pahole
...to my make line.

Again I see that DW_TAG_INVALID (0x48) warnings.
Can someone enlighten me what that means?

Finally, with all that warnings observed I could "successfully"
generate Linux-kernel Debian packages.
I do NOT install software I do NOT trust - not booted - NoNoNo...

Thanks.

In the dark,
- Sedat -

[1] https://www.kernel.org/doc/html/latest/kbuild/llvm.html#llvm-utilities
