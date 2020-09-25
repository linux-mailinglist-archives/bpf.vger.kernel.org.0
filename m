Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C456277CB8
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIYAQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 20:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIYAQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 20:16:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DADC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 17:16:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so700611edq.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xIf+Wd02QlRb8dihS/DiLbBEmJ1zW6xAEVbZ5dS26E=;
        b=F0LNJat78CdDpEaqZQuJ1tqYitJYzbyqPAVCgU18z7GFkfA1gi8abPuI4hVEqqNjrO
         7qCIQUkxAI8zgQLp6PDo1dx9GDy0tpvikrn94cKA25Mw9Wd+CoYHKC1yZ9q7T16cQQTP
         H/U9JPG7AON51/TYdL6xeqM6iEgi+a5lpR/BMpU/gSs626kra6z2IKHMZURbKhbDWw58
         6hjmQKMFCy0B2LOAm2Bil0vYBlPkNu7nqxMWYn/VdN+36tDP8DNnEU9pi+Ogx8r10v1s
         Lg4LyJNKT6TRNahT1JulTgdRE1uBn1YZNSvD0yr2jskQl+ue+H+AxIuqrs1ABIGv450a
         0QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xIf+Wd02QlRb8dihS/DiLbBEmJ1zW6xAEVbZ5dS26E=;
        b=ehBYc4Wvh1taIbj/A2H4FFh7GM1snHC6b+NS3TX5MzWHZIDqCunWodZOPZQ0McuJhG
         duUfDr1NU8D93kTF+mERqd6LCj9iN0KqtlH+3EF12bSZMk3Z2kiMbwx1LTTPEqjkyh/M
         7JAqZW2EU3QkyPDaOWC3bwJkLdtmlGGGOufrpDKnRNX8Xpq9WNaiSVVzWZmt102QFw/b
         +JrtSuqA8vFNdOTTiPXDUsX/C4fOSW/1tlujIeUq5kRGbhIEpaiG7WVXZ35YViFxYGWH
         tey8TLAUa/gOI1rb0hKrVFv+mkClYtAS76P7Q0j2TisA71HH/U3Uh/uuVfHdf5fwr+PK
         u4Lg==
X-Gm-Message-State: AOAM531MD2XpizJFA02VTaje9O9QLfNZ21EBvlTqJGs2oA1LItU70198
        Ps1BgzJV/J+lc/4Aw2V+4tUDw+MAujVwEBjRt2idcA==
X-Google-Smtp-Source: ABdhPJxKKrQDdHZi95Ynf871qKWysLRg5gjvkYXRdU159HiWVv61BCzjOFRKE4h3CAptn9KbJU134l/l0xSFubL6Qkw=
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr1354480edb.386.1600992977013;
 Thu, 24 Sep 2020 17:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook>
In-Reply-To: <202009241658.A062D6AE@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 25 Sep 2020 02:15:50 +0200
Message-ID: <CAG48ez2R1fF2kAUc7vOOFgaE482jA94Lx+0oWiy6M5JeM2HtvA@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 2:01 AM Kees Cook <keescook@chromium.org> wrote:
> 2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
>    haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
>    it must be dealt with), which means seccomp's idea of the arch
>    "number" can't be the same as the AUDIT_ARCH.

Sure, distros ship it; but basically nobody uses it, it doesn't have
to be fast. As long as we don't *break* it, everything's fine. And if
we ignore the existence of X32 in the fastpath, that'll just mean that
syscalls with the X32 marker bit always hit the seccomp slowpath
(because it'll look like the syscall number is out-of-bounds ) - no
problem.
