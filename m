Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07343B983
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhJZS3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhJZS3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:29:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3675C061745;
        Tue, 26 Oct 2021 11:27:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t184so340890pfd.0;
        Tue, 26 Oct 2021 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8MHfbr/h/oCaPvOavFxnKFNIvOBGsa++z17VUpzTuY=;
        b=gNl/g+F2Em5sxOb14g5D+x6Mdr9Xd1fc7Onej5+HHjPWRzRliJIUmqSYvjF5ep4eZP
         uAhkRaIc+q6ZqGLjUmH4mHqqXBIx1rpCLh9wa4oEsdCs2zLNXVwIAxjnvyvzBsSlJw22
         RHpX0wODi4uAT8B8V6FqG18lAKQjTEBW/yyvquTJYAA2zwDchL8Tm836c3AX6wjapIi8
         IxmbMU4JWAVZoTjVfLs++ekSRAby07YstdgG2frUXy571x4LopeSb7umk5ynYOghc1Fi
         WOiFayj/uz4z41YUWXEQIMUhCKXHCnW9RAmgqVLBArNmv6PnXMRyphlMd2LMTtsf6/JD
         1sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8MHfbr/h/oCaPvOavFxnKFNIvOBGsa++z17VUpzTuY=;
        b=Jv6GpT61q0Hd1/Y+uT/TutlJAX+liYiJHeiPkad5/Sjh/uNRNppHkBl6uSyJzAL8ZZ
         22fEL5PYwUSVLgvPc9DWZGh7/BKrm/dyGlhcTeeukkirKC/TOvC0cSRJV/dkHMiD1O10
         vR5g5n6RrV4q2jAh1pfPH66uJeM6mFh6gpjaoc3+xhAOrLDXw8/TrbhVnp9/O8e5Neta
         QAeLv+c/7+7Oh6xkLSvPNk/8TuIqHkwvwI7h0YEDAVAxMDjKVSmG7OxPliIdJZ/d29pj
         gsdj214SQddiZTs+Fj+xpJ6frY4X8i0IMnf1i5NEqdPM11MMZEdIgzv6NNhoPi4neauz
         eTWA==
X-Gm-Message-State: AOAM5325yj5nOosD4JrB63y/GYXdlk9Sb1hkRWJK+8PIO58BVm4jN7a6
        cxym+Ez49rE+HtMCSdjcCRQgvwpk7OYFZncYLGY=
X-Google-Smtp-Source: ABdhPJz8FhcwmzMHAHU8hhAYz40pRLnbG/B+FdfaCNf5xoa+2kEkXwVqCFSu9bh/KZCts4EZLzHwWKOpM4VrGrnKq98=
X-Received: by 2002:a63:4f57:: with SMTP id p23mr20260824pgl.376.1635272828098;
 Tue, 26 Oct 2021 11:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211026120132.613201817@infradead.org>
In-Reply-To: <20211026120132.613201817@infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 11:26:57 -0700
Message-ID: <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 5:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> These patches rewrite the way retpolines are rewritten. Currently objtool emits
> alternative entries for most retpoline calls. However trying to extend that led
> to trouble (ELF files are horrid).
>
> Therefore completely overhaul this and have objtool emit a .retpoline_sites
> section that lists all compiler generated retpoline thunk calls. Then the
> kernel can do with them as it pleases.
>
> Notably it will:
>
>  - rewrite them to indirect instructions for !RETPOLINE
>  - rewrite them to lfence; indirect; for RETPOLINE_AMD,
>    where size allows (boo clang!)
>
> Specifically, the !RETPOLINE case can now also deal with the clang-special
> conditional-indirect-tail-call:
>
>   Jcc __x86_indirect_thunk_\reg.
>
> Finally, also update the x86 BPF jit to catch up to recent times and do these
> same things.
>
> All this should help improve performance by removing an indirection.
>
> Patches can (soon) be found here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
>
> Changes since v2:
>
>  - rewrite the __x86_indirect_thunk_array[] stuff again
>  - rewrite the retpoline,amd rewrite logic, it now also supports
>    rewriting the Jcc case, if the original instruction is long enough, but
>    more importantly, it's simpler code.
>  - bpf label simplification patch
>  - random assorted cleanups
>  - actually managed to get bpf selftests working

Great.
The patchset didn't go through BPF CI though.
See
https://patchwork.kernel.org/project/netdevbpf/patch/20211026120309.658539311@infradead.org/

It's a merge conflict. The patchset failed to apply to both bpf and
bpf-next trees:

Cmd('git') failed due to: exit code(128)
  cmdline: git am -3
  stdout: 'Applying: objtool: Classify symbols
Patch failed at 0001 objtool: Classify symbols
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".'
  stderr: 'error: sha1 information is lacking or useless
(tools/objtool/check.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch'
