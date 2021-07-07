Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637EB3BEEB7
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhGGSbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhGGSbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 14:31:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293FC061764;
        Wed,  7 Jul 2021 11:28:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i4so4672770ybe.2;
        Wed, 07 Jul 2021 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK1b4T+tdxLj0ZaLZLl27Y238eANKisrNhi/wvZNAG0=;
        b=c+gd0uM455Z5mJVonXFgsTe8dnzKXZqgjhsDfaDk98+xKhm1V/FETfwxBDUcSBeQ/Y
         alcEQYAIrFiiAHT741iN/VM35WV0zi/Z1KwCKTFZ7NinPMkURdhMQfx/gupYfjMdxCEN
         z1abS5/XscvX05GlmChkEba9sZkZCQqb8RpUhrqSD+xQ3ZfZDNU1DnZcXrkfta7wh+V/
         qvKrA6KlAygZH68ZIc3bdzBvbZdJB8pHWICdmDAQWafHva2qDWr6kvqywDa+D7Hl36vR
         9cMWNoD5HCCbJ2S7WNVTt42nlUQ7VGxffaKKcY4WB62hwK/avAOi++P1BEO7daQNzUT2
         LRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK1b4T+tdxLj0ZaLZLl27Y238eANKisrNhi/wvZNAG0=;
        b=ukGh/pgHE8mnpZEYf86z+xpXAXFm1r3UOh+xOF0dWImc7SOA5DsuTEBGqG2kyhx8OY
         MjeHJelmwgnzF5W4ySR6kbx2RypQWsPFoC2LQ4M1dV1CoNQ13h0XgSFr9UldT7IyaPrT
         aJMycqnQt601Pzb55SRd9DEl61m8EwpJT6hm9MmeCZzazH8feM4jGJRU02ttl2N58mCX
         wSKG93QB6u+rUUZH1LpurNVj14Dz5gYdYark+5ZmeNWiS3o1GeOI7lam9C097OFRmAmG
         nZvk00K+K/kN/lkvHRfb4Ac3UOqgBDds4sHTWxEci9F/t1enhafNtKvXLGoEUjYLZeZR
         GqNQ==
X-Gm-Message-State: AOAM533SqofKj9y/WZnPVIdzdqf3/k5pUtq/vutmKi6tRjLi6Pv8unXX
        rqFRa/ALWC+7XCMJ5XWmoBnqiTCpYNsKec5Gdu0=
X-Google-Smtp-Source: ABdhPJxEZ9a60B15EkYK6EsPieQQ3WOyERQAF+OLp2bWcEh9iRZIzH1BUe5bI9A0Suj4Iy+dwtNl+Fi3V9C7QE8PWGA=
X-Received: by 2002:a25:b741:: with SMTP id e1mr34963002ybm.347.1625682501624;
 Wed, 07 Jul 2021 11:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <162399992186.506599.8457763707951687195.stgit@devnote2> <162399994018.506599.10332627573727646767.stgit@devnote2>
In-Reply-To: <162399994018.506599.10332627573727646767.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 11:28:10 -0700
Message-ID: <CAEf4BzY1D7NsrBwt3nLFRbaESb7b5pR9arLhrg8OmOAfxi+kaw@mail.gmail.com>
Subject: Re: [PATCH -tip v8 02/13] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_symbol_descriptor()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 12:05 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Replace arch_deref_entry_point() with dereference_symbol_descriptor()
> because those are doing same thing.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>

Hi Masami,

If you are going to post v9 anyway, can you please fix up my name, it
should be "Andrii Nakryiko", thanks!

> ---
>  Changes in v6:
>   - Use dereference_symbol_descriptor() so that it can handle address in
>     modules correctly.
> ---
>  arch/ia64/kernel/kprobes.c    |    5 -----
>  arch/powerpc/kernel/kprobes.c |   11 -----------
>  include/linux/kprobes.h       |    1 -
>  kernel/kprobes.c              |    7 +------
>  lib/error-inject.c            |    3 ++-
>  5 files changed, 3 insertions(+), 24 deletions(-)
>

[...]
