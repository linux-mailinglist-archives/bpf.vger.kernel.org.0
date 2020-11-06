Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDE2A9CBE
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 19:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKFSyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 13:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgKFSxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 13:53:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91354C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 10:53:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b12so1073871plr.4
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRJJey7O8hp51w9PTtLKZJy616pOmHfVs3BwFqC0oO0=;
        b=rNwN/rqWebtsESHuRn/MGvxoi0wkXa1rRYRdWV1F+zKP+fSVL0F29OKFfPR4ngMkXN
         /uS9TyonnwuXf+aGTGrwCtBCPsSsa2EsEfv10+U79x7vRBDuayv+O7dRRCE1nvmi55tU
         i07z1dQ5qtUCrP10SaMXh38jQbqrhpD43X5NyEEQe48+IXUBnlKjTezunY7VgdvJgTlC
         VgLOOsu75l8e6fUs7CgfMDH1XwQI3F+GOf8n0yZsnMYG1OBX0vp9V/G8Yq46w+2mHq7B
         AbtZCMIWJrmkMpAv8lZCbz2OLx4FWkqj11E711UHPxM3epnQO+0kUWVlCycLXIq++dtn
         XOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRJJey7O8hp51w9PTtLKZJy616pOmHfVs3BwFqC0oO0=;
        b=XDyvfAmRmO2RT+ht6BTazjAKJy+sqbk6sx4RtwUWIx+mX9gi5Jt23KrHM8I4AvZMNc
         9gt2VujUctVxXsSrvi64oYuqDwpBAYY0gMrKrrj4Tn98Ankd9e0yryx4Fe+kF5tTF58W
         qHRq+jSW7X/PhA+D3TjJBQAmfoyqyuo/mdzT1AwYBEbk8mnC4Qvs4fkdszZR/tg9OJFh
         16cCQUktAf/LbdzXhAIf8EjKCU/f5qfSQooLiKHcniJWtaBH2NF9xowDKX8Oi/IuUumK
         mV1U6nBh1gHDFQuJ4pHKjcEB+ZFwNWNZapEdfDAhhcc2Pyzrvbw2ompzGKAakO0o2ria
         fkhA==
X-Gm-Message-State: AOAM533VZrjLyubGyHcfKUhFZlWHE+d5MZQvtQzStefDH8/GKvQiHE7r
        loSDOnG34QDeA+mJS72TgaWjAvoJPHPHUZQWRBPUNQ==
X-Google-Smtp-Source: ABdhPJw6GqGjgwtpuqR4bfJAjFjDaDXFbi04oPiePSF9XHXOOBCHNkH1fai0h/cxRRG6fLzKrbg5xtN+5Iu3qu+/e3k=
X-Received: by 2002:a17:902:328:b029:d7:cc2d:1ee7 with SMTP id
 37-20020a1709020328b02900d7cc2d1ee7mr6576pld.10.1604688781870; Fri, 06 Nov
 2020 10:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20201104191052.390657-1-ndesaulniers@google.com> <CAADnVQL_mP7HNz1n+=S7Tjk8f7efm3_w5+VQVptD2y7Wts_Mig@mail.gmail.com>
In-Reply-To: <CAADnVQL_mP7HNz1n+=S7Tjk8f7efm3_w5+VQVptD2y7Wts_Mig@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Nov 2020 10:52:50 -0800
Message-ID: <CAKwvOdk8DdKEuSYW2j0LUeNVoFa=ShXPKBTvpUHakG-U9kbAsw@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: remove version check for BPF Tracing
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 8:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I can take it through the bpf tree if no one objects.

Doesn't matter to me. You'll need to coordinate with Andrew though,
since I got the email that this was picked up into -mm:

>> This patch should soon appear at
>>     https://ozlabs.org/~akpm/mmots/broken-out/compiler-clang-remove-version-check-for-bpf-tracing.patch
>> and later at
>>     https://ozlabs.org/~akpm/mmotm/broken-out/compiler-clang-remove-version-check-for-bpf-tracing.patch
-- 
Thanks,
~Nick Desaulniers
