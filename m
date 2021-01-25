Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0778B302F46
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbhAYWnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 17:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbhAYWn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 17:43:29 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12394C06174A
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 14:42:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f11so17319949ljm.8
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/ZLCFpqvvSBK9CS6fYLer3j0rF5eV//tUXfQU1el68=;
        b=DhT0cPn81bc9ZNXJhjFuhiNkLfOifgAQLJya4ostZuqvLbLPifjxR8oPGgDCHbxS9t
         FdJrpomkI/NkZGXiTVeAJ+VsY7znYgxPuTmwJRqhK7Wewc2+eSf64xsmnPfPhz0yk+Lu
         eINws5gJ0ezzzUlECYY+fKaUWrsHxR/Bb20kfGJIwBDwSep7AvlOrbZgq2KocIjOUcj6
         vNbUIYK1bNC2RuA2N9ZzrGq9vcegf/4+i7MmFvCFAq+YUSdX8vLByJM797HPg3S4WSYp
         UD4QexUCtSkkt2SGUCfdpqaJ12I2PiU0rsPFsH8OOfHANfYt980cNg87uNqi76TR7PWl
         /lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/ZLCFpqvvSBK9CS6fYLer3j0rF5eV//tUXfQU1el68=;
        b=fqKCzHieuwFLXOeHo20dCqqHFyUJTCMiRf1FesH65u5Z9OVMdwqMmfAxehATVtvth/
         oWERypVNAgICMZEd+82u5gpzSDr9oOttYAwxF/gErxUU8gGm3PphkFQO+zlZH299EGkY
         pDuQiTRiwqL/XZvJm99Lw3lxrZcREuzaJhq/a3SUhht4ZiC3LjbEWNex4DugnEMKxzgX
         h9aq4PMILgSnKz7TxFEsJ9qtc88DRA/Db9irgYZxo+JGPTYBhjFuGt+HALLetmkuySak
         dCIJz8DzrfExz1NMehLv9mr1+689p4DIfN3NkbZsi4B93w+Ka5R4HL4VgE2u3qRVRF5T
         34sQ==
X-Gm-Message-State: AOAM5302tXPuoifEo/k2LpENdptQF+dNt9wAMv2rAV1lzmLu58eBahHt
        46fkS4f0aEs+Ff/sFfV2Z1gJnTieyp/1oCMDxfr+VH87
X-Google-Smtp-Source: ABdhPJzuNg/c+Ug/qy4rrGdmEiaCTzih/g2gamXGWYzC6quaEROD26nMqs0kXB9niz3FRqyCaibMDjdlRLZUYMsb1qI=
X-Received: by 2002:a2e:5ca:: with SMTP id 193mr1291771ljf.236.1611614562524;
 Mon, 25 Jan 2021 14:42:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
In-Reply-To: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 25 Jan 2021 14:42:31 -0800
Message-ID: <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Paul Moore <paul@paul-moore.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hello all,
>
> My apologies if this has already been reported, but I didn't see
> anything obvious with a quick search through the archives.  I have a
> test program that behaves very similar to the existing
> selftest/bpf/test_verifier_log test that has started failing this week
> with v5.11-rc5; it ran without problem last week on v5.11-rc4.  Is
> this a known problem with a fix already, or is this something new?
>
> % uname -r
> 5.11.0-0.rc5.134.fc34.x86_64
> % pwd
> /.../linux/tools/testing/selftests/bpf
> % git log --oneline | head -n 1
> 6ee1d745b7c9 Linux 5.11-rc5
> % make test_verifier_log
>   ...
>   BINARY   test_verifier_log
> % ./test_verifier_log
> Test log_level 0...
> Test log_size < 128...
> Test log_buff = NULL...
> Test oversized buffer...
> ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13

Thanks for reporting.
bpf and bpf-next don't have this issue. Not sure what changed.
