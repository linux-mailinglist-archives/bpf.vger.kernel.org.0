Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382D44396E6
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhJYNCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233343AbhJYNCW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635166800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=qA0I4/+z2GGotAPzClR23nYM/h7wOlk9GbkFHt3Tads=;
        b=PUCEdAYq6K2AETkvTPLbqvAuyBxwtvAWqzB4Nz7nRVXrdoqdaYHQ1CfZAI9iSerjLdqJia
        6GYVkCzynRVhY6E/0ovI3Pl8g1S0Q30htOy9Zc7di27KDEMceigxfb408XCbDLzDwxxDKE
        bpDTwOJ5R5lZ8MOVhbuxz/xeCVfALjs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-bb8RSlvaP0-F4uJSzSPjpg-1; Mon, 25 Oct 2021 08:59:58 -0400
X-MC-Unique: bb8RSlvaP0-F4uJSzSPjpg-1
Received: by mail-yb1-f199.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so17330651ybe.20
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qA0I4/+z2GGotAPzClR23nYM/h7wOlk9GbkFHt3Tads=;
        b=w7Ne6ww+gkwqNg/m3v8XFzw0daH+L5mXDHi9CZRcySFNlOWzId+7U3gVaPIMgY2XPG
         HpCkomTT0b5EvxEwzwdkeqULf75JkhAe1TBdd+uX5SwGLzoKabjdOknj+hqz6OtEKpj7
         qpZMQzydr2b6vHicdm0mOfQRc8i4T0PF/elDn1YsnGz+NTSLfOVMGO8mD37tV+JtUAIP
         Vipa9TcxoTGhZkRGYsUs6QJNuDPB54noD6Njjc9j5RZsY2uKeMWn3W06DbUdyzsbdTk3
         c+Wwdng6pCh4W00Tm7Sz476ZfjG1VuNvFS6ka6VuFlg3YZC/qm5rLUwWZg+L/i6aEal/
         nhOQ==
X-Gm-Message-State: AOAM533wguUCUkLCXsV1hRHUnijf9qHYexuUcEYHrVP4ESL4KQrfHF0P
        hovMOpX+85Ma4nHTn0etPl621nYYQALUhQLHzCPB38+C3Q/FKetmh6XrVIC7gxfQ7er/YTK6P1M
        MwcTGGlScgb2nRKs8BYI0SGcQBR+2
X-Received: by 2002:a25:b59a:: with SMTP id q26mr1112241ybj.518.1635166797617;
        Mon, 25 Oct 2021 05:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLKGxfRM1ZkAoM4kM3RUu1DN69aIxRcpRPVR3OtR6cZL/MwWEZzIriE0cklyFJc7+ou2V21eEwcYSHzhFXxqw=
X-Received: by 2002:a25:b59a:: with SMTP id q26mr1112211ybj.518.1635166797318;
 Mon, 25 Oct 2021 05:59:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Tucker <datucker@redhat.com>
Date:   Mon, 25 Oct 2021 13:59:46 +0100
Message-ID: <CAOJ0YmrUNbw_qMP_FHmoYejS1JRaKCkD69S5xYS9gxsWAPX4rw@mail.gmail.com>
Subject: eBPF Documentation
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello eBPF Community!

I wanted to follow up on an excerpt from the "Happy Birthday BPF" email [1].

> Despite books about BPF and pretty complete documentation at
> https://ebpf.io/what-is-ebpf, developers and users complain that the
> documentation is spread around.

As one of those users who has complained, I'd like to explain why and
propose a solution.Before I do, I'd just like to say thank you to
everyone who has contributed

Current State
=============

Firstly, the documentation at ebpf.io does a great job of describing the
basics, but defers to the eBPF & XDP Reference [2] for more depth.

That guide is a treasure trove of information, but , there are also notable
omissions:

- A definitive list of program types
- A definitive list of map types
- Information about which kernel versions they were introduced in, what
they are intended for and perhaps even some examples
- Documentation for bpf-helpers outside of the manpage

This documentation partially exists in bcc [3], but with bcc-style
syntax examples. Certain program types are a little more complex and
require documentation of their own (see: man tc-bpf) or [4] for
BPF_PROG_TYPE_FLOW_DISSECTOR. Other types seem to have no examples or
documentation available outside the kernel source, for example
BPF_PROG_TYPE_SK_SKB.

For understanding CO:RE, BTF and program lifecycle I've found the blog
posts on the Facebook eBPF Microsite [5] invaluable.

If you're working on a loader other than libbpf, you'll be reading man bpf.

If you're working on a compiler or VM, the official documentation for
the eBPF instruction set is here [6], but it certainly helps to have
this unofficial guide [7] as a reference (and the aforementioned eBPF
and XDP reference covers some of this too) as well as this blog post
[8].

... and then of course are the libbpf/bcc/wrapper docs ...

Desired State
=============

What I would love to see is the following:

1. ebpf.io is the home to all official documentation
2. Documentation arranged from bottom of the stack up
  a. eBPF VM Instruction Set
  b. ELF File Format, BTF and CO:RE
  c. eBPF compilers
  d. eBPF Syscall Interface
  e. eBPF Program Types, Map Types and Helpers
3. Docs that then point to the API documentation for libbpf, libxdp,
bcc, and various other libraries.

I'd be willing to help pull some of this together if there's some
agreement that this is necessary and the breakdown is correct.

Thanks in advance,

- Dave

[1]: https://lore.kernel.org/bpf/20210926203409.kn3gzz2eaodflels@ast-mbp.dhcp.thefacebook.com/T/#u
[2]: https://docs.cilium.io/en/stable/bpf/
[3]: https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md
[4]: https://www.kernel.org/doc/html/latest/bpf/prog_flow_dissector.html
[5]: https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.html
[6]: https://www.kernel.org/doc/Documentation/networking/filter.txt
[7]: https://github.com/iovisor/bpf-docs/blob/master/eBPF.md
[8]: https://pchaigno.github.io/bpf/2021/10/20/ebpf-instruction-sets.html

