Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA0164B84
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSRG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 12:06:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 12:06:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so1117318ljm.10
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 09:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUZWb5O4+qPTff+g4CnwYoBVjN7IEr4Cen31vzQXnbI=;
        b=AN5Az6wX9Fog8zf3+AdY0uRnVdVLk25AZJNj+NYVZS5kGBuvKY6V0jyxocZOWgYn3e
         faLXpdS15fMT89VJL6Pf8N578wZLjd6SvYYYs6BvJinGioek0VIb5NkEEh+LbW/GpBI1
         uutb98hU3bPXviI3oyI+eirqlLBzUUHrID1Sf6sw6wW0wGL9t3QuBdKbY0D1XdnDNM5/
         luYA5COvaSHd7PqGktXW+7cFovjvrxbzPxneXwVpqhI5cgCFURDAfh6KB3e7Y/on7kUR
         FlzIwABiW+u3kxMcVD8JMah5jmG5ow9gwEsl7v112Nqzm/CZq8DMJ7oI7hXGb7BI42OI
         n6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUZWb5O4+qPTff+g4CnwYoBVjN7IEr4Cen31vzQXnbI=;
        b=W50pD6n3xhFLxF1pYBID6anECJ/ESPvNVhSlr8SUtT3J442piZkeYmOWuXuXLYtDuF
         qLJufDyu/De3++vri/lVAaGqJLenWOZ1M4VZRy5Kof/6m/0+9Oo/Xr66zbu6llxgZtle
         /93Nv/6/M33ahOjNVXY17fh6d+sgcMjPjkKftiLW2h9L1hLHwojzJEvFvf+6Obm8oJdO
         qkHRxA5NUNznMA4L5+czBX1mo2KcsIGyDrrtLI1sKWSVLQvboEQsaD9ZkJWsU0sWwTp+
         R8gvY/FffToUJ1+/0QfMTObbDN6dIHtHPhyH5gfOr6PUxiqlBBjdRouJNoWy6fsl/Rjc
         IKVg==
X-Gm-Message-State: APjAAAXR9KXDRdm2i9w+eAr4sGlDLE4AiGQabTpoo9r3BZMiUBR74BNo
        nItnhZIaKSudDUdEqlmI/rZyYdKHPl+RT0K6cjzTlA==
X-Google-Smtp-Source: APXvYqzk8WHl3VtgSM5vaMr3IERAOITgyPyxaxA1J+ZEp8jKHsNbNAY/mza7weRHEWABTjtA4uha6RSD2TLUFWCZ6Lk=
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr16664493ljh.138.1582132014385;
 Wed, 19 Feb 2020 09:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20200219004236.2291125-1-yhs@fb.com> <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
In-Reply-To: <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 09:06:43 -0800
Message-ID: <CAADnVQLWJ+F8w0g9XaLbNHZEXKbcQeXt+AiAZX7gMX=L_PWrhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to -mcpu=v3
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 8:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/19/20 1:42 AM, Yonghong Song wrote:
> > The latest llvm supports cpu version v3, which is cpu version v1
> > plus some additional 64bit jmp insns and 32bit jmp insn support.
> >
> > In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
> > probe into the host system. Depending on compilation environments,
> > it is possible that runtime probe may fail, e.g., due to
> > memlock issue. This will cause generated code with cpu version v1.
>
> But those are tiny BPF progs that LLVM is probing. If memlock is not
> sufficient, should it try to bump the limit with the diff needed and
> only if that fails as well then it bails out to v1.

with hundred parallel clangs running and all stamping on the same rlimit
I don't think bumping that limit can work.
Also building on older kernel should still do v3, since build should
produce selftest binaries for the same vmlinux as this kernel tree.
We hit this issue with github/libbpf CI. The vm used to do the build
was too old. So far we cannot build vmlinux out of latest tree,
boot into it and only then build selftests inside. It's too complex
for CI system.
So we build vmlinux and build selftests in that CI's VM, and then boot into it
and run selftests.
Upgrading VM is an easy fix for now, but the issue will cause the problems
later. So imo fixing selftests build to predictable -mcpu=v3 is the
most sensible way.
