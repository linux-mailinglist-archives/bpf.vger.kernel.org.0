Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6839C194
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhFDUup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 16:50:45 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37748 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFDUuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 16:50:44 -0400
Received: by mail-lj1-f174.google.com with SMTP id e2so13221468ljk.4
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJoBFivS9/0L7b0TyZ5GMRGBdgGvt/mvxhidNZqt9mI=;
        b=onVGtoT7NpNRKABSYMZk7zDCWBe91qf/hrR3u+ADQfJr4t1DmPpVjI4SW4ztG2zEkA
         GrzzZqpRZ0PLTN8/m/xiAZhec4kS3faRbG2LNGCu6n214IBAz6ylr//loNqA6UC6n1NN
         fj1gKOiisC+bSA00hvUDgg+5KPTlyrPlk2dr3M79iwlv2KaNkQMtiPYi7UfGavWF/6ei
         RJu2DoDq3dM5IuYsyptU9AzFGwptZfUTIoztNG6cY7Un1znUQvzRWvSnb/oWHyHxsu60
         /qhSprpf5EMCLsjCrrilDOIj+KaBGNpgSiZb3PgnUWHq13gzCNOYHAdl4gaxsoKNZyLu
         0Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJoBFivS9/0L7b0TyZ5GMRGBdgGvt/mvxhidNZqt9mI=;
        b=P3iBII7vMve4gRQj/1CEI8vOyAVcjRsORrVBQeN/mMwOF5D+jPsX8scOh2ilYGgPZ6
         HzoeKPQa0H4mmve7Z4qZdQ0NAErGjqKPl/lHxJ3xan509UCwmeA822pKD2QmAE5FSud5
         qwbQRzpjtYA3qbXJ9tIAMifpcssh+IcYxSW8yjp1EION1+qtjDX9G9X4jIrxmj8+Tu7m
         qx+Zg3jlvCQdUItQr1ndDNP7dD48kQjCcIiXVNsKQP9+kRb1G/UwLuqEVOCu9b9JnG9S
         4aKcm4AZKZdzvDdbA9dPV10elcK1n73TFR+FHok0/378vS3WhP5VPlTF9FLs+pWR9HCy
         uJkQ==
X-Gm-Message-State: AOAM530oLR4AH4/JJSsC/JLNoHYCU2R2iUlCmJJbi8VxN28okoHm9uvx
        U+hjAeT/Yj+jLpnGP+H2rHb8JF2R1oYDTnZDYn4=
X-Google-Smtp-Source: ABdhPJyLmOMO1B+x+PztMUWY/NupwMXvnnnfSySBh433HwyrKufIyff4JmZqsRBXUwswUfx3flo24fm9qlMWoUjrI0U=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr4590088ljo.180.1622839660690;
 Fri, 04 Jun 2021 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
 <20210604061303.v22is6a7qmlbvkmq@kafai-mbp> <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
In-Reply-To: <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 4 Jun 2021 16:47:29 -0400
Message-ID: <CAOWid-f_UivcZ1zW5qjPJ=0wD1NM+s+S9qT6nZuvtpv0o+NMxw@mail.gmail.com>
Subject: Re: Headers for whitelisted kernel functions available to BPF programs
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 4, 2021 at 12:11 PM Yonghong Song <yhs@fb.com> wrote:
> On 6/3/21 11:13 PM, Martin KaFai Lau wrote:
> >
> > Making the kfunc call whitelist more accessible is useful in general.
> > The bpf tcp-cc struct_ops is the only prog type supporting kfunc call.
> > What is your use case to introspect this whitelist?
>
> Agree. It would be good if you can share your use case.

At the high level, I am trying to see if we can use bpf in the drm
subsystem and gpu drivers which are kernel modules.  My initial
motivation was to use bpf for dynamic/run-time reconfiguration of the
drm/gpu driver (for experimentation.)  But now that I learned more
about bpf, I think there are quite a few more things I can do with it.
(Debugging during GPU hw bring-ups, profiling driver performance in
live system, etc.)  I have been looking into bpf with kprobe and
struct_ops.

In terms of kernel module support for bpf/btf, Andrii told me about it
last year and I see that his feature is in (I was able to do a btf
dump file for /sys/kernel/btf/amdgpu, /sys/kernel/btf/drm_ttm_helper,
for example.)  The next thing I thought about was having helper
functions from kernel modules and Toke pointed me to Martin's patch
around "unstable helpers"/calling whitelisted kernel functions and
this is where we are at.
