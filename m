Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBE4379C9
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhJVPZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhJVPZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 11:25:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4665C061764;
        Fri, 22 Oct 2021 08:22:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 187so3906904pfc.10;
        Fri, 22 Oct 2021 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPV0SOtCu/yXKv9zO0cN5aVANicEEw9KJSfvSTImqto=;
        b=odNLzMLxZ9cAj4JdTtszB5nuwSJQknxM58RXmUAmEbRnKRq5XeMMiGZfSL30dtee5t
         7erSp1G5t14ZGy2ezAOXvelO8ml166elpjbizNaaZmlymRP6seFlkhne8hp0UnE3yX1Q
         V5ILKSLMERmRJSgp76ROGkgOL2N5HyWkIJgNuEdltV9iRRfc58AnXmK4KeXiUHv0zV1C
         KAkfPpT13X/+/qjMIlkgQvVFr41QuKZsbMpaLNbzlHjo2mpvgTJFBu3vQ3Ij+LP83e3G
         IRrD1YwkgW5vT0T3eXb14Ph5UuSB6OmfrfcjVSJzuvndd2LVvl/tqiQk2iCGHLTULl5v
         KfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPV0SOtCu/yXKv9zO0cN5aVANicEEw9KJSfvSTImqto=;
        b=UjByS1gE8NhNaBR8CayYLf9rcI7Hu85sBI55dkvMN/+lWUqN5ylnXKoQhNmYHdHPAn
         ooeeRWD+6KlGodUhRPDjXQXbqlZOVRfEKr/eQR46eEyrewlBRsyysUHfbQeB+Apnz53D
         EzvHJ9+3y+Y5noVCek+m9a/arG/60y81y7vM6rR5Vqw3DBPnpCmT9vxbLnmyzK8KbEtE
         KQzgS+miI20FSGUEsjkPaGiuGnl9Rrsjd3V7COyGbd3KbrDqbiTSRP6U0BVGniX4lsgn
         NIaLxJbEivnGkTWONxLHPZVZMZvVF4vWyIbC8Gccz15MrfY7/CMry+Qd+zzAWPuL2z5I
         f8lg==
X-Gm-Message-State: AOAM532ISJva6u7vNYiFO+LcVqiUq490JFCsO9XvMZv2wGNhqfx3OIav
        tSYdUA/ISgCaonWj6BxWBpOxTkOrX8MoHcr3CjM=
X-Google-Smtp-Source: ABdhPJwwkR18dVyVmL97wgHjLqmJwwBDyXLz847Lh8zP1zfVQu6ODHj755rQnl4IUNEh6i3+RXeV/c2JHQ11YrNsCVc=
X-Received: by 2002:a63:374c:: with SMTP id g12mr275892pgn.35.1634916167065;
 Fri, 22 Oct 2021 08:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net> <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
 <20211021233852.gbkyl7wpunyyq4y5@treble> <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
 <YXKhLzd/DtkjURpc@hirez.programming.kicks-ass.net>
In-Reply-To: <YXKhLzd/DtkjURpc@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Oct 2021 08:22:35 -0700
Message-ID: <CAADnVQKJojWGaTCpUhkmU+vUxXORPacX_ByjyHWY0V03hGH7KA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 4:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 21, 2021 at 04:42:12PM -0700, Alexei Starovoitov wrote:
>
> > Ahh. Right. It's potentially a different offset for every prog.
> > Let's put it into struct jit_context then.
>
> Something like this...

Yep. Looks nice and clean to me.

> -       poke->tailcall_bypass = image + (addr - poke_off - X86_PATCH_SIZE);
> +       poke->tailcall_bypass = ip + (prog - start);
>         poke->adj_off = X86_TAIL_CALL_OFFSET;
> -       poke->tailcall_target = image + (addr - X86_PATCH_SIZE);
> +       poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;

This part looks correct too, but this is Daniel's magic.
He'll probably take a look next week when he comes back from PTO.
I don't recall which test exercises this tailcall poking logic.
It's only used with dynamic updates to prog_array.
insmod test_bpf.ko and test_verifier won't go down this path.
