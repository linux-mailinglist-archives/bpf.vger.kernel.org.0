Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3477330E769
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 00:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhBCXdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBCXdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 18:33:23 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728FC061786
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 15:32:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j84so1371636ybg.1
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMebJTakS0Ke+LXbRio76EZDaorwfOZaoWoKW/e63MU=;
        b=LfbBUMwPaGZb+00JAaebiz87H+cT+H/1cnOLdBdFHltt6KMDaFryeNoJvRHrFc2bCs
         dqMoV2FUCjCTCuS32diLy6RqaWJF/aySsS5177Yxynk/AcYRljBUZPx0ibqZKsgTqokY
         Bn9xCUbyPVgdsxOxuPc/xaNe+8RJtHhW1381KLBj6p+D6fs0K/8pE5pEB8zg6Abg2FSp
         a2IuvdqIXUS85adscYpiWUEfu7/Jc6ND6zKvH2axquhpnsCv8BMTLxssPdn9Gu5O9Rlq
         4mZoO+3DzqdKyykCOsUW0YM/2jPw3adNePT200nDTHKLQ+T8pNyWHpZNSH+ow/23vYWm
         brSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMebJTakS0Ke+LXbRio76EZDaorwfOZaoWoKW/e63MU=;
        b=qNqSg3xcXhxiuagbYzEO+92cB4VvrpmaRtX2zvMRVALm0c/AMbWMIwgnKU5Dc1n3fw
         lDwsLrrP74OeW3KTacLeG5xaxkvaVeSnd9xbkC2IiUP9pOCejAx6fODWbJg2eWj9ekn6
         ko32bMLz0A6HfVAkvRcozZJK+jw+SOKQUZAMOq2DGTiEpJRGaMFUcbZrEoI6bF8SubW5
         KfWBHSUg2qMJm8Jifw76nJxRUaCfIwaq55omgJN0ju5ZZ3/V5RBaLUG6ZPvn1pzoKXfZ
         gFoNORbXEsjhkFIw6EJOvICttbFsunJtO6RIy2DgLjBZGu/ZIj8v+ShTciaxIp5shCUd
         UVtg==
X-Gm-Message-State: AOAM531S44gfz7iddjhuV1EhmRhykEFpJ/6MXKz/H8JWlfhuzNWjPw3X
        XVjRHWZGj3sZ1ZNAXLZolfcV2SgZQArGwnEWy57HaLvafRceuw==
X-Google-Smtp-Source: ABdhPJyNu7Z16HZYFJcb4R5ULunbTOhTAw5dxh2PHXVXzzkfZvKC4rirdWcNz2ydRZn1jYIwdFWaGsU8qPtiQWi8fsQ=
X-Received: by 2002:a25:d844:: with SMTP id p65mr7535937ybg.27.1612395162321;
 Wed, 03 Feb 2021 15:32:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
In-Reply-To: <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 15:32:31 -0800
Message-ID: <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Chris Murphy <lists@colorremedies.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 2:44 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Feb 3, 2021 at 1:26 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > qemu-kvm VM starts with kernel 5.10.10 but fails with 5.11.0-rc5.
> >
> > Libvirt folks think this is a kernel bug, and have attached a
> > reproducer to the downstream bug report.
> >
> > "I've managed to reproduce and found that virBPFLoadProg() logs the
> > following message:
> >
> > in-kernel BTF is malformed\nprocessed 0 insns (limit 1000000)
> > max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n
> > "
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1920857#c4
>
> Looks like the bug was introduced in 5.11-rc5, the problem doesn't
> happen in rc4. As I mention in the downstream bug, I'm unable to
> compile a working kernel for bisect between rc4 and rc5 to find out
> the exact commit that introduced the problem, due to many messages
> like this:
>
> Feb 03 15:05:47 kernel: failed to validate module [coretemp] BTF: -22
> Feb 03 15:05:47 kernel: failed to validate module [intel_powerclamp] BTF: -22
> Feb 03 15:05:47 kernel: failed to validate module [irqbypass] BTF: -22
> Feb 03 15:05:47 kernel: failed to validate module [intel_powerclamp] BTF: -22
> Feb 03 15:05:47 kernel: failed to validate module
> [x86_pkg_temp_thermal] BTF: -22
>

The important and very relevant part from the bugzilla:

Feb 03 15:06:26 fmac.local kernel: BPF:        sched_reset_on_fork
type_id=6 bitfield_size=0 bits_offset=0
Feb 03 15:06:26 fmac.local kernel: BPF:
Feb 03 15:06:26 fmac.local kernel: BPF:Invalid member bits_offset
Feb 03 15:06:26 fmac.local kernel: BPF:

Do you have full dmesg with output from the BPF verifier? Also, what's
the kernel config? Which compiler and what version, etc, etc? Please
help to reproduce this with as much information as possible. Thanks!

If you can share the vmlinux itself, that would help as well.

>
> --
> Chris Murphy
