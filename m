Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E6595221
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiHPFkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHPFj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 01:39:56 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0C6C121
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:26:42 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id s129so8507984vsb.11
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5Qu/W3MFB9cfLPtKAkApluok3IV+7iCared65QSDIW0=;
        b=XsjznxesIHKB/fja4xLmaqwEchS18Gnp895Kn9oDrjLJgEzBGyBuuaW3g1PhoHTlyS
         kQoVx5C8lv1u/SkTnG9RStoOPc7I0vTMuAzalfW0AIEgDIXW5UjyS+wvjrPERtY+jls4
         IMrqflCpeGV/PKQpMfyU/p564Cdhhn+2J0oftQ4+OsuRCfZi7FZ0erZ5exsc8ZEOTkZ6
         yCGvubF6lj05E7X2BC3yooMuO3nqakUxdWI0FnwyTo0VhTm3fFLiV68MbVYaHf3JhHj3
         LIa+L5MbkMuFVfEuYwyCqpZuibYQ/++7mC+QKJNl0WQFGBsUUdmgtn/6wJuaqPNrS0q8
         3+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Qu/W3MFB9cfLPtKAkApluok3IV+7iCared65QSDIW0=;
        b=EjPTxzCrHDnmfF9uMHIC2GKpLV7Hq3qegg/IPwEQNWQU/zr3hhwGne2kcBuZjAsxUd
         TsTmBjcGCUJ8HVurkvI165lhwLpHa+GQWDSAeDRXarF/ztJ/GvjXAHadHpyAPxt2uzY7
         KRzRDqKIfbUkuPTQZtO6BZYKpB1kJ4wyMqCjt/vDg2UlKFHq6FnG27wokikhtmMb7zDP
         aauQ4uqQ4ZyGr1HQYZjZbw9WiX9/UT5BOIB/22w63OIwJXAi8fy2Gj77JdponCLZfkIi
         aK+o886RMLcg6RJXWysYdsZSNrq9zCUWr0Ih2VO+3ISm4x+HP3ORqdekszplq0SojYe3
         d8Jg==
X-Gm-Message-State: ACgBeo2Zbcn1TaYaVfQvoH5EGmx0aVcwaPkFpZcAfVWPWz9PF2cV86Ce
        YRgbaB/9y1yc8m/R3E+UiAN9xZu7ybi+XoiSEHhFPN4Cd84=
X-Google-Smtp-Source: AA6agR6FjcxVZySezBsif/0gyvJXBRCd02GvP/rUTqUfkXisVVsBpxw4jUXPVr6a5s3p/1vmoy2f4dFX0y7/SGcRXRM=
X-Received: by 2002:a05:6102:3119:b0:388:713c:7eb6 with SMTP id
 e25-20020a056102311900b00388713c7eb6mr7595341vsh.34.1660602402014; Mon, 15
 Aug 2022 15:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
In-Reply-To: <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 15 Aug 2022 15:26:31 -0700
Message-ID: <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Hi Vincent,
>
> On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> > Hi,
> >
> > I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
> > machine, I also compiled bpftool from bpf-next on same machine, when
> > run bpftool on same machine, I got :
> >
> > ./bpftool feature probe
> >
> > Error: bug: failed to retrieve CAP_BPF status: Invalid argument
> >
> > where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere else?
>
> Yes, bpftool calls cap_get_proc() to get the capabilities of the
> current process. From what I understand of your output, it looks like
> capget() returns CAP_BPF: I believe the "0x1c0" value at the end is
> (1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
> (1<<(CAP_PERFMON-32)). You could probably check this with a more
> recent version of strace.
>
> Then assuming you do retrieve CAP_BPF from capget(), I don't know why
> cap_get_flag() in bpftool fails to retrieve the capability state. It
> would be worth running bpftool in GDB to check what happens. The check
> in libcap is here [0] but I don't see where we would fail to provide
> valid arguments. Just in case, could you please let me know what
> version of libcap you're using when compiling bpftool?

I think I installed libcap through centos distro

[root@centos-dev ~]# rpm -qi libcap.x86_64

Name        : libcap

Version     : 2.26

Release     : 4.el8

Architecture: x86_64

Install Date: Mon 14 Jun 2021 02:35:08 PM EDT

Group       : System Environment/Libraries

Size        : 129682

License     : GPLv2

Signature   : RSA/SHA256, Mon 15 Jun 2020 06:31:12 PM EDT, Key ID
05b555b38483c65d

Source RPM  : libcap-2.26-4.el8.src.rpm

Build Date  : Mon 15 Jun 2020 06:28:10 PM EDT

Build Host  : x86-02.mbox.centos.org

Relocations : (not relocatable)

Packager    : CentOS Buildsys <bugs@centos.org>

Vendor      : CentOS

URL         : https://sites.google.com/site/fullycapable/

Summary     : Library for getting and setting POSIX.1e capabilities

Description :

libcap is a library for getting and setting POSIX.1e (formerly POSIX 6)

draft 15 capabilities.

>
> Thanks,
> Quentin
>
> [0] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_flag.c?h=libcap-2.65#n12
