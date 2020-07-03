Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DAA21323D
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 05:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCDei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 23:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 23:34:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7EFC08C5C1
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 20:34:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so17557258lfc.4
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wli8ZcJVLYQtZApOQ4JVDxFTolfDVKYqXzyK7UfBOE=;
        b=XkXiNIaFugtsbR5MF0IvoekJeeOpbXuPFGZ5DuEEReeRvY3Jg69vp+irshARRv8GRT
         dFOpxpATFrJ36zAWxQIxPZ86OZe7w/NSoYwqQ0MEpjCplgxLXcnZwTk8yKUXpfchQw5R
         AafWJzGSEByYHSIXtQjx9ZMAT17Ww4IKv2954=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wli8ZcJVLYQtZApOQ4JVDxFTolfDVKYqXzyK7UfBOE=;
        b=Uc3vEGbu2lprIJkOxwpfQY1ilIQaFDG5EnEoW2ntwLn7xiamm1hrflrTPV/VMlY4z7
         aws0jgDLfiV4u3OrSeMom/YpZV0wdpIKCkIfBVS26rwr0pSvXhn5NgkEdQdx8SFiEX74
         i7Fi73W0R71AEsofD7l+whS9o0koRXO6rypDEQOZsyaXR5AgTXrI12/VBLU4H4AUs/Ch
         akpN/FOh3onOf9pW6uzUxDoiweVQ4pBmVTtOm1deFXhygw3Op6ZIe2WYSF6GskvgQtuj
         UrEOrCToWP3qZiZ62dy+vHui2mIuZIBDGCfYCTPqF/9jWTrIJQLBxwAaa24wkfit1aou
         6VlQ==
X-Gm-Message-State: AOAM531bx35kp+R52lzo/vW4Dc9R5UvLvATtXxPcERRo9cZLww0696qC
        MNlGASpA8oRAz9assJRK7fGtkls5OqE=
X-Google-Smtp-Source: ABdhPJwwNSBSSQwBHH21YJIrXNKvVhN8eNSjR4472A2bUBW6IVo86HXODsyYjRyFDfN80MGG/eajPA==
X-Received: by 2002:a19:2292:: with SMTP id i140mr20344792lfi.95.1593747274302;
        Thu, 02 Jul 2020 20:34:34 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2sm4125108lfr.48.2020.07.02.20.34.33
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 20:34:33 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e4so35123735ljn.4
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 20:34:33 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr15442024ljn.421.1593747272949;
 Thu, 02 Jul 2020 20:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200702200329.83224-1-alexei.starovoitov@gmail.com>
 <20200702200329.83224-4-alexei.starovoitov@gmail.com> <CAHk-=wgP8g-9RdVh_AHHi9=Jpw2Qn=sSL8j9DqhqGyTtG+MWBA@mail.gmail.com>
 <20200703023547.qpu74obn45qvb2k7@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200703023547.qpu74obn45qvb2k7@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 20:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBi3sjtL0JNzcPTYEOFomU9Oqz_vD=oHznxyQYGBRi5Q@mail.gmail.com>
Message-ID: <CAHk-=wiBi3sjtL0JNzcPTYEOFomU9Oqz_vD=oHznxyQYGBRi5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Add kernel module with user mode driver
 that populates bpffs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 2, 2020 at 7:35 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 02, 2020 at 06:05:29PM -0700, Linus Torvalds wrote:
> > On Thu, Jul 2, 2020 at 1:03 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > The BPF program dump_bpf_prog() in iterators.bpf.c is printing this data about
> > > all BPF programs currently loaded in the system. This information is unstable
> > > and will change from kernel to kernel.
> >
> > If so, it should probably be in debugfs, not in /sys/fs/
>
> /sys/fs/bpf/ is just a historic location where we chose to mount bpffs.

It's more the "information is unstable and will change from kernel to kernel"

No such interfaces exist. If people start parsing it and depending it,
it's suddenly an ABI, whether you want to or not (and whether you
documented it or not).

At least if it's in /sys/kernel/debug/bpf/ or something, it's less
likely that anybody will do that.

               Linus
