Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2228C5CA
	for <lists+bpf@lfdr.de>; Tue, 13 Oct 2020 02:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJMAb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMAb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 20:31:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E29C0613D0;
        Mon, 12 Oct 2020 17:31:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so6361088pfn.12;
        Mon, 12 Oct 2020 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXZNvLUHIPZhcUjRnKBWUfl+DzXXg5MXS7WMTuKeZqY=;
        b=EgkGa/BElavLOO5do8aI/LDI65T4SLmDW8j8GtvnCsMqRBTuzcnVjgwuSdSDywqjvi
         68gLb90unNImwgG+pg5B/c302jrN06h2wiOsbrS6lxh8EQjYlmK7IUQnSGU/kv2q8QG+
         EWOBIoZOyIobyfZvWYXKxuZwSKTVUMEXBgX4ZSAm7NcGssu/qudmnUEzxRGMANa3Lou5
         MjTF8Aw/QRattq1J+RTgiH8N7u0DTN9vVgQp0Ylvdjn8NkAptoEbXZ5eu6oXV79TtK/9
         bHTxA8tUDVroDUdUEZK0RaWfRT1RH5IBbwfF+F6lF8u/pZVT/m/Yzov79xfTFFBkwVbg
         PhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXZNvLUHIPZhcUjRnKBWUfl+DzXXg5MXS7WMTuKeZqY=;
        b=h0fCnwrb3Y6jDD9yEabwzibnpPIuzU1L0jCRqE0jKv6y5GEkDz1bGAKLzpX9jBWz0l
         C5HIHLT4wW99G27KFaDUr8qpOKqRbzzkRArn0n/tcLWVwZ26uTfbOeNndveUgIWglAJ4
         /Nlfhib3lRkRE/G5kwwvLyllF1rZtqDBEyQNJY9ttUVSPEzGJyzfsvNnuOygf3DRWhoW
         pfQUyyHwN3J9f0xMpUFGwDjESx8BC9gkGvpsCFGnsMtzdEOWOEMe4B1tpEcsa3F/fPuW
         E+J3IBrqU8007SfySQpU8QMtvQucIu+d71AY/4NDKSA55JLGO7PhQwt90v27ZkqsF1Ag
         aGzw==
X-Gm-Message-State: AOAM5305oUzY+mcHMr64wylcS1psWmiaq4avncJJH+qwaxEkm/0QNWTg
        H0lrBw7ampNDyG1WLbB7RNunKh/GEJRGG59mZJ4=
X-Google-Smtp-Source: ABdhPJwg5QbybFtaIctqSCgVoJcBwsMrZ8yltrreNaMkzpkUU1M8W2QrCl9Pfc1cKWvkAdOBW1KhWVjQhmcp1iD+GHE=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr25657902pfe.11.1602549086984; Mon, 12
 Oct 2020 17:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook>
In-Reply-To: <202010121556.1110776B83@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 12 Oct 2020 19:31:16 -0500
Message-ID: <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
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

On Mon, Oct 12, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
> I think it's fine to just have this "dangle" with a help text update of
> "if seccomp action caching is supported by the architecture, provide the
> /proc/$pid ..."

I think it would be weird if someone sees this help text and wonder...
"hmm does my architecture support seccomp action caching" and without
a clear pointer to how seccomp action cache works, goes and compiles
the kernel with this config option on for the purpose of knowing if
their arch supports it... Or, is it a common practice in the kernel to
leave dangling configs?

YiFei Zhu
