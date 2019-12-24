Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386D5129DE3
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 06:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfLXFs1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 00:48:27 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35645 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfLXFs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 00:48:27 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so7066370qvi.2;
        Mon, 23 Dec 2019 21:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chyirdOESrcyZYls0O4S3CM7+3ie23NclpnHj9Q8TZ8=;
        b=QTatrIDibvsfq4PIGOcDpegqvGeyTx/uyaEzHEx87OT9YjFBlXGYfYtaSXgB63vHsr
         P7WkavE0s+JmgT+ohyprAJLIXh1/A4tDK7Z58DCZ1Oi/r0qlHzB+5oSEOCZLspyrj3tb
         w7PZTpQxl+XtGtUjxC3nemQ8Oq+U5fql2TvIkoMBtU5HpKmfH65tsV8rRWmSa5fEst0A
         rmM2uGFabc6Cm23pE79n7ePT3/LdX2tfKcSwtBJ7z/J2pa8meORoVjuiBGmEc4wlTSUn
         xLDlsapm3n8DOGqBAGIf1Ksjw0VTGJytiNfJzq5vlSL156SFmVvQvkCNY1O4i9Ch7AMG
         V9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chyirdOESrcyZYls0O4S3CM7+3ie23NclpnHj9Q8TZ8=;
        b=MTPEIPuREeRkyKq+IMr66NfRBYzHM3LeQ9dl8EtVBJOYfLI96TMcoLwSSj22/o4Ncs
         W3Y+M1BEXLMukkgVRXcNlwMZq6Er3QJ5f9HxgXrsP9cT8MFNog4VE3IkyTbIT03CTeur
         aVhe3HXdib+P8GUZjdY4gGX2uDz+flXgJmJU+azltsAGLBcM9pH1vjPChG3ytVyzkuq5
         EVw6WMJiKoT6ktAdP4psBrEg4o5VHjijawTJorQP6xc8fcMyahzqsCF+jOVxL2t5sx+N
         cnTgu7bJWu9Ebf1uY1xZnlrvZbrcp3vs10zMhhCDuUpNPsixGRHtxdgVLRyk6sy01EIC
         pOvg==
X-Gm-Message-State: APjAAAX7kUJS6Q4pZTQ0xo2GvLXvjTZg49X2WZyN16PLNPf2Em5sfsrO
        QEN453FS3mSE6gZoQL1NUupOxZIGWN4mNQHZofQ=
X-Google-Smtp-Source: APXvYqyrl1A6qr+sRbltNuz0bedudNwNw9G+4NxHPfCUvFEVv0wsJxTDoCR7jgt8O1rGoz8FIm9AYLmdrDYss5hRiMw=
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr27799530qvb.163.1577166505897;
 Mon, 23 Dec 2019 21:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-8-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-8-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 21:48:14 -0800
Message-ID: <CAEf4BzZQYnSv+0nEkgt1kovXdtqMNv5hMhLdCWkJhUS-Lr3hyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/13] bpf: lsm: Implement attach, detach and execution.
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> A user space program can attach an eBPF program by:
>
>   hook_fd = open("/sys/kernel/security/bpf/bprm_check_security",
>                  O_RDWR|O_CLOEXEC)
>   prog_fd = bpf(BPF_PROG_LOAD, ...)
>   bpf(BPF_PROG_ATTACH, hook_fd, prog_fd)
>
> The following permissions are required to attach a program to a hook:
>
> - CAP_SYS_ADMIN to load eBPF programs
> - CAP_MAC_ADMIN (to update the policy of an LSM)
> - The securityfs file being a valid hook and writable (O_RDWR)
>
> When such an attach call is received, the attachment logic looks up the
> dentry and appends the program to the bpf_prog_array.
>
> The BPF programs are stored in a bpf_prog_array and writes to the array
> are guarded by a mutex. The eBPF programs are executed as a part of the
> LSM hook they are attached to. If any of the eBPF programs return
> an error (-ENOPERM) the action represented by the hook is denied.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  MAINTAINERS             |   1 +
>  include/linux/bpf_lsm.h |  13 ++++
>  kernel/bpf/syscall.c    |   5 +-
>  security/bpf/lsm_fs.c   |  19 +++++-
>  security/bpf/ops.c      | 134 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 3 deletions(-)
>

[...]
