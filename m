Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A539345A
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhE0Q40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhE0Q40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 12:56:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B98C061574;
        Thu, 27 May 2021 09:54:52 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r7so1568496ybs.10;
        Thu, 27 May 2021 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b+QDKRCvkdmEo44u5UFShewK4OXzLmQT14NjfQF8mM=;
        b=Gx5kyyT2g7cjTWhrgI/v1xNiuhMCo4OJB/oGhDQVq2S+vEPpM7F0351zgRidXT07KL
         SZTR9sx8AJuDssXMiojE/M56FPCEPqXyVcpzie6MbaZmU+TKIvtkGok+T2WQieO1oUZX
         2BEDuv6qnwmKpFJ9kysoMuKeuGk74j7jlBi83q4Dq2yWXK7vLcb6dZtmUeFsYYWtBtkW
         4wJ8yRETzTuqyQbSYZ+1Giq8TmEwlbRYkVdehFPZYngQ/SCnl8lmCjr37u4G5FaOTDGU
         1/5OJJ7OBavXRI3bHj8LKjQRiLQ601tE+LjhiI+yuBZb4pOe3VESkJ2vAiX0fHS56tsL
         vZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b+QDKRCvkdmEo44u5UFShewK4OXzLmQT14NjfQF8mM=;
        b=H5KcJlfL16ubhb3Kf4oV1YddoMYnFmVyyYnXeaY6Ox7cIl5a9XR3lHIItg+pyOZ9fm
         ZxXsVOIN6dq4tLglZYpybOuxQ2gizXt6HImes29a67SwSoISTvpBLRQbmA+Vn2WCnXle
         wRQNF8JGsCuqwDfg4tA+maI8il6bz1RM3cQmXqYpYJOnPd7UB4ZJyh7V0T13wSFlrnmH
         6DY9Q/wFY4GNMhdpeeRn9GmAp5RhGJpZfzebCKnwHAfONIp576mWU1eM4hUuhoZVHQ5K
         a+dRgPay3AUQXREMg7AVXAv6p2nFcwDJCDPczNa4QOOQ/whI2U1WEl9HxWkDrrgZGWcw
         CIiA==
X-Gm-Message-State: AOAM531UP8PUYYWuJkFdfPxZkaP4q0RQbeZX33webReeUkwi0AwtZS2E
        jDlyDp37th2TJQMwLEaIo5NhYC30KWsxz3amNl0=
X-Google-Smtp-Source: ABdhPJwpFxDCvjoKBgQsSj1wJtHkhfT+dJlLc9Yc/yMBz3fQOR2R7y8/yjQ+v6UO+8zbFdlbjAOEsruLlqZ5l9SKFQE=
X-Received: by 2002:a25:1455:: with SMTP id 82mr6152662ybu.403.1622134491327;
 Thu, 27 May 2021 09:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org>
In-Reply-To: <YK+41f972j25Z1QQ@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 09:54:40 -0700
Message-ID: <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
Subject: Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi guys,
>
>         Its important to have 1.22 out of the door ASAP, so please clone
> what is in tmp.master and report your results.
>

Hey Arnaldo,

If we are going to make pahole 1.22 a new mandatory minimal version of
pahole, I think we should take a little bit of time and fix another
problematic issue and clean up Kbuild significantly.

We discussed this before, it would be great to have an ability to dump
generated BTF into a separate file instead of modifying vmlinux image
in place. I'd say let's try to push for [0] to land as a temporary
work around to buy us a bit of time to implement this feature. Then,
when pahole 1.22 is released and packaged into major distros, we can
follow up in kernel with Kbuild clean ups and making pahole 1.22
mandatory.

What do you think? If anyone agrees, please consider chiming in on the
above thread ([0]).

  [0] https://lore.kernel.org/bpf/20210526080741.GW30378@techsingularity.net/

>         To make it super easy:
>
> [acme@quaco pahole]$ cd /tmp
> [acme@quaco tmp]$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> Cloning into 'pahole'...
> remote: Enumerating objects: 6510, done.
> remote: Total 6510 (delta 0), reused 0 (delta 0), pack-reused 6510
> Receiving objects: 100% (6510/6510), 1.63 MiB | 296.00 KiB/s, done.
> Resolving deltas: 100% (4550/4550), done.
> [acme@quaco tmp]$ cd pahole/
> [acme@quaco pahole]$ git checkout origin/tmp.master
> Note: switching to 'origin/tmp.master'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by switching back to a branch.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -c with the switch command. Example:
>
>   git switch -c <new-branch-name>
>
> Or undo this operation with:
>
>   git switch -
>
> Turn off this advice by setting config variable advice.detachedHead to false
>
> HEAD is now at 0d17503db0580a66 btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> [acme@quaco pahole]$ git log --oneline -5
> 0d17503db0580a66 (HEAD, origin/tmp.master) btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> fb418f9d8384d3a9 dwarves: Make handling of NULL by destructos consistent
> f049fe9ebf7aa9c2 dutil: Make handling of NULL by destructos consistent
> 1512ab8ab6fe76a9 pahole: Make handling of NULL by destructos consistent
> 1105b7dad2d0978b elf_symtab: Use zfree() where applicable
> [acme@quaco pahole]$ mkdir build
> [acme@quaco pahole]$ cd build
> [acme@quaco build]$ cmake ..
> <SNIP>
> -- Build files have been written to: /tmp/pahole/build
> [acme@quaco build]$ cd ..
> [acme@quaco pahole]$ make -j8 -C build
> make: Entering directory '/tmp/pahole/build'
> <SNIP>
> [100%] Built target pahole
> make[1]: Leaving directory '/tmp/pahole/build'
> make: Leaving directory '/tmp/pahole/build'
> [acme@quaco pahole]$
>
> Then make sure build/pahole is in your path and try your workloads.
>
> Jiri, Michael, if you could run your tests with this, that would be awesome,
>
> Thanks in advance!
>
> - Arnaldo
