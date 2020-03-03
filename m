Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC851786BE
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCX4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:56:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40271 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCCX4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 18:56:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id l184so2329724pfl.7;
        Tue, 03 Mar 2020 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8gDt4+hKLFEVUT2875HZHL2GUBm9at3uoIUJ/mCCI4=;
        b=EWc6ytjvGgIM9CPsIuRtdRj7fSSnF3G0MyQk/9TJkcVNCTJcp8ob0LqyblK66ZjQ/y
         hArGfUegHFur9Flsc1QdJdVrI25B8ycSY5oBB6K2c8bv7zDQATa/DI3E0xux1EejQafW
         s/Psl9Dn5u6QMtFhpLs1MvV6FQSuGoS9ZkIaFIAmbbN3DfFUhAeXSqS/ZB0K9OS4wMEx
         ZKO+lD3dLySP0/Q2Ua2PwsQCfeynrKfoBvvK6jFiUEgT0gK7fE7nStmFZiRpOQcQRCPu
         ShyndO2nUCe/gUhrGR5ElWkW4zxmwkccuxBJXCZ/ma3FHmL1+pkMVL1sYtFwKYjMMxs2
         V1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8gDt4+hKLFEVUT2875HZHL2GUBm9at3uoIUJ/mCCI4=;
        b=C7b+2X6gbrEpxRHwxZRpzmG1YwQ0rmyhpmt4Kx3eq3Wenf0KR46PFhN7vfv6/F13OE
         4QAjkYG1/zJfTynwnzEyw5tm7yLEVTXB2hciffSvuoAgRjZk2A57/+CTas3jfmONqkZ2
         P4OsYVroI9XoBwn0YSJ54i61GjRaW3iEU2MqEnqm7DAfyU7WSumWE5mXNSTY938pM9p9
         A7jb/2fluSW/tKlJidmmXhfCkAbwH2T+4/vbZfzIyP0Wuxd7Y+KWWpWDDndhEEvxgWM5
         NzlRp/N8y1w88OiEuVDU8rSH6CWcasNYTd/R6MzIx8P8NMQDhpUaPIhHCRMI53cWSVEv
         ebpg==
X-Gm-Message-State: ANhLgQ3Z5FJJJlMyP1GSibhcP1zEQMNJLvzaaohwnp21CSq3bxJWJZTE
        Uxkg2q7j/Js6sddwJkEuNfhNZkM+
X-Google-Smtp-Source: ADFU+vsAaImrpowO4my/J2luF3xHzX9kk5ExySiUOtQqOLJulGboUZgtWWuVBm3+VadjOoaf57hKsA==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr232054pfi.210.1583279768806;
        Tue, 03 Mar 2020 15:56:08 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::4:a0de])
        by smtp.gmail.com with ESMTPSA id u5sm3262803pfb.153.2020.03.03.15.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 15:56:07 -0800 (PST)
Date:   Tue, 3 Mar 2020 15:56:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200303235604.mdlamwx4z2ws3fzy@ast-mbp>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-3-kpsingh@chromium.org>
 <CAEf4BzZJ2E2rmyz7k4F7s=EXPbaAX7XncvUcHukX_FYDWeD7BA@mail.gmail.com>
 <20200303222812.GA5265@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303222812.GA5265@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 03, 2020 at 11:28:12PM +0100, KP Singh wrote:
> > > +static void align16_branch_target(u8 **pprog)
> > > +{
> > > +       u8 *target, *prog = *pprog;
> > > +
> > > +       target = PTR_ALIGN(prog, 16);
> > > +       if (target != prog)
> > > +               emit_nops(&prog, target - prog);
> > > +       if (target != prog)
> > > +               pr_err("calcultion error\n");
> > 
> > this wasn't in the original code, do you feel like it's more important
> > to check this and print error?
> > 
> > also typo: calculation error, but then it's a bit brief and
> > uninformative message. So I don't know, maybe just drop it?
> 
> Ah, good catch! this is deinitely not intended to be here.
> It's a debug artifact and needs to dropped indeed.

That spurious pr_err() caught my attention as well.
After further analysis there is a bug here.
The function is missing last line:
        *pprog = prog;
Without it the nop insertion is actually not happenning.
Nops are being written, but next insns will overwrite them.
When I noticed it by code review I applied the patches to my tree
and run the tests and, as expected, all tests passed.
The existing test_xdp_veth.sh emits the most amount of unaligned
branches. Since then I've been thinking whether we could add a test
to catch things like this and couldn't come up with a way to test it
without burning a lot of code on it. So let's fix it and move on.
Could you rename this helper? May be emit_align() and pass 16 into it?
The code is not branch target specific. It's aligning the start
of the next instruction.
Also could you add a comment to:
        align16_branch_target(&prog);
        for (i = 0; i < fmod_ret->nr_progs; i++)
                emit_cond_near_jump(&branches[i], prog, branches[i],
                                    X86_JNE);
        kfree(branches);
to say that the loop is updating prior location to jump to aligned
branch target ?
