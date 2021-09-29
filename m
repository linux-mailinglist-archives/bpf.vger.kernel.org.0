Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865CD41BBC0
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 02:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhI2AhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 20:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbhI2AhD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 20:37:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B2C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 17:35:23 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h2so1458779ybi.13
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 17:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HPlemPOU/JnzjuSHQkOnr4JnH5bfxxSmIK+onGbvYVI=;
        b=LaED5Ynvp4Y5saAH2f9VerPhlBo6dnZtjr6NRwnitKnFJJVgRwZM7yLqDE9XN+7MGw
         m05mjVJiJ6sEXapZqB0L5tGLuYM2YeFK0BBjY2oTaPETiJvo8pIxADbhJreZ/S4nQD64
         RmTvAdI7VWbjwmYK5hoGHtIuXLuTr82AJE4v/uiqOJlmOBBSpusVSzzxKYVbRKmIDX+i
         xdynMEyEQzJod0V9cxW6MFYilXmFopBLK8Tx7GOvWb2gzxENOAxnbjVmQDWWd1UXaPQ7
         GrDxZHr1IJoyf+3DdcSry1d3Or8tqpd24vcn0T17Ax47S0LxFHHCbUnShRMLCzcGPssr
         dy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HPlemPOU/JnzjuSHQkOnr4JnH5bfxxSmIK+onGbvYVI=;
        b=1p7NnPhWlXkL/lLzfecLzgxipPm3l3pGuiU89/Cp3y2ThUtDNLLh3AFXWl3r+KuW6x
         A4D8psGr9zfxRNBpbYheidCcaANWdMM1xtZy1ZgF+LZ8eUIuF08q0R+EhwIEJzUdn9Ry
         fnRrC53gqha9I6JQ208pPbetqe0LOKzWUPcrcy8mh0cCklgXji9Kpr2DmylpPyFo8Zoa
         e2TP3Y8CeBww6YjYYmMdCkUQ2i3HRaHwnTRJJNIFl7lSS+f05VR7WYg00A1jlKxCP95X
         YHJCSu+uqzZOLEKpuKCkFZM3mrJZLKBZOkYFoWBUf8ojjcwopR6TD2xMhJcWrX8Ej36I
         4QTw==
X-Gm-Message-State: AOAM532Iu4c9Q1DrQK/1MhFvafmWnHR+kgu6D6sTqWXtLKTghzkF6lMf
        SE98hWcrSqai2SmfVdAfeDieTNLfgGmCuV5OL2A=
X-Google-Smtp-Source: ABdhPJyGWSh38OY/k7uRUoA9Eg7yQzcGsTQe9MgAvHjPqrWHGyfgNA4XUg+0i3a9oeQsmFg8FZSVLbr6Z8Sn/lPa/g8=
X-Received: by 2002:a25:1884:: with SMTP id 126mr10124789yby.114.1632875723032;
 Tue, 28 Sep 2021 17:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210928054608.1799021-1-memxor@gmail.com> <874ka4ke5q.fsf@toke.dk>
In-Reply-To: <874ka4ke5q.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 17:35:11 -0700
Message-ID: <CAEf4BzYshONnQDD45dGN_TCei8MbYvJhurCrpDOQ7KaMWjBKew@mail.gmail.com>
Subject: Re: [PATCH bpf v2] samples: bpf: Fix vmlinux.h generation for XDP samples
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 6:47 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> > declarations that would cause a build failure in case of version
> > mismatches.
> >
> > There are now two options when building the samples:
> > 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> > 2. Override VMLINUX_BTF for samples using something like this:
> >    make VMLINUX_BTF=3D/sys/kernel/btf/vmlinux -C samples/bpf
> >
> > This change was tested with relative builds, e.g. cases like:
> >  * make O=3Dbuild -C samples/bpf
> >  * make KBUILD_OUTPUT=3Dbuild -C samples/bpf
> >  * make -C samples/bpf
> >  * cd samples/bpf && make
> >
> > When a suitable VMLINUX_BTF is not found, the following message is
> > printed:
> > /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
> > for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> > VMLINUX_BTF variable.  Stop.
> >
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>

Applied to bpf, thanks.
