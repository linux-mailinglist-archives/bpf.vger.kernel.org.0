Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B13B321C
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFXPB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFXPB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 11:01:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A77C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 07:59:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d2so8137210ljj.11
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5Af/F0RmtdZJaaM4A4ftcPZxj+C6ieZjclwoHh13Kc=;
        b=OuLfJ5S9M+bTjtperCT65qqeQPvaGLoy+V1ScPqwnNLlhwt60KifDTIKRoj2MWlCZC
         4bEAw3HBog77tcChDUcb+2tFVBH8lW5D4O2j3VvMEOnRDEwvkbD5iU7nC9A1ZeFuQn0B
         kQKF9xuo+bod0cz/YuL4a0k9N42gfhjG5dXMM/i1LgqveSPzbfbpFGYu7RCWqlKxiVdo
         +1tGsJKH4+s0v2VkXvvFKkdM+iM36KiL1EwkQJBdA7AaOfs8z1Ob8iFx7OqR4YL0JJk+
         lKjrVh5ctZPVfaP9KK8anFuiMiTt5Aw759y7fL2IksZnQ1Ou3UPITDP9ctoaB5NL4hCr
         QxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5Af/F0RmtdZJaaM4A4ftcPZxj+C6ieZjclwoHh13Kc=;
        b=YyBdJZZDOErJu2YP9gYIkBU1l/CnYIbJXRY/BlZ+1lFhoPsrtbu8LuoW6ZHfi0XleZ
         quUfu4WR3lg3T3SMjiAi3a7r8XPXkEL8dkA1GNxZCXrROJE7g5t6dURFPBHQdepQ1iGZ
         lSCew1eZ7swLgUe3NcnfgPqwJpsJ5BEKVD0iLSMB6OS6B4faMw4hFfyUz0sd/Ih5tRIv
         5D8sNZHkFW4Z+Q7nSphRqsr7OQr4v4dpi/eSoyOHcMM/zxTKNTUXiHjQC+XnU6vqx9EJ
         Ltdw9ruwDTS56Tsv2EynlUZPIQoNQyMJD75E8mOnjdnfVF1SlUXjBzW8lRIcJp8f3dZB
         5mAA==
X-Gm-Message-State: AOAM530nXJV/5o7A62VXo236kTFUizwMrC/9my5oxR7DTu+bGHzyHoev
        ygPbMeINeDZ893izavbJdVme+mAIrwnfqjpn5L4=
X-Google-Smtp-Source: ABdhPJyZkIOCJcRLz8nrja7NxQQjXYNsSXh9Q8wMc5WcrbysCtMkIwW+EC3NM42TRtoM1Z7nBnb637HVIN3Jh8azfCI=
X-Received: by 2002:a2e:7e0e:: with SMTP id z14mr4355228ljc.21.1624546747262;
 Thu, 24 Jun 2021 07:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk> <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon> <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk> <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk> <CAJ8uoz2jgEJUb7Yj25HUrVX66PDde2o74GHsq21SdUtQESRkPw@mail.gmail.com>
In-Reply-To: <CAJ8uoz2jgEJUb7Yj25HUrVX66PDde2o74GHsq21SdUtQESRkPw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 24 Jun 2021 07:58:55 -0700
Message-ID: <CAADnVQKv5SLBfnBWnEBFqf0-DQv+NZuixGiCVx1hewfQFhHSKg@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 6:08 AM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
> >
> > and libbpf could do relocations based on the different meta structs,
> > even removing the code for the ones that don't exist on the running
> > kernel.
>
> Just wondering how this will carry over to user-space and AF_XDP since
> it sees the same metadata area as XDP? AFAIK, dynamic linkers today
> cannot relocate structs or remove members, but I am not up-to-date
> with the latest here so might be completely wrong. And it would be
> good not to have to recompile a user-space binary just because a new
> NIC came out with a new BTF ID and layout, but with the same metadata
> member name and format as previous NICs/BTF IDs. But I do not know how
> to solve these things in user-space at the moment (except to have
> fixed locations for a common set of metadata, but that is what we are
> trying to avoid), so any hints and suggestions are highly appreciated.

CO-RE is not a kernel only feature.
The BTF tests in selftest/bpf exercise most of CO-RE purely in user space.
The libbpf needs to know the original BTF and the target BTF to
match one to another.
One option for AF_XDP would be to write a bpf program to be run in user space
and let libbpf handle relocations.
Another option is to teach llvm x86 backend to support
__attribute__((preserve_access_index)).
The work done by llvm BPF backend can be copy pasted to x86 backend.
Then standard x86 binaries will support dynamic struct layout.
imo CO-RE for x86 backend would be great to do regardless of xdp hints.
It's a straightforward copy-paste. Only need to convince x86 llvm maintainers.
