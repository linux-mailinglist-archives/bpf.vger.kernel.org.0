Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E74688ED
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 03:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhLECba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 21:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhLECba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Dec 2021 21:31:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1696C061751
        for <bpf@vger.kernel.org>; Sat,  4 Dec 2021 18:28:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A47C4CE02C7
        for <bpf@vger.kernel.org>; Sun,  5 Dec 2021 02:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E881C341C2
        for <bpf@vger.kernel.org>; Sun,  5 Dec 2021 02:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638671279;
        bh=J5Za5iP6rf79HdmZwkk1JfX5sUbB42hmpRG+I0u5cNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zs2bFY+nvGP2xHkQ6PUrFoNJOpu8QHIS6NIridhoV34IVTF4wzzm7VC9V8GThS+bQ
         UvP3hpODAJNknIwnTkmxtlg/FUDfYWcOeTG0GzeOClErPusoiqgmbNE4bzhsUypxzl
         lzWwNY+Km8B8ybYndrfWkBhu0gvDDDlSYY4WG+ACtzYnRRf7q/m5182IN5mLmtYcNZ
         EQwvTHMhjygiReURZNQC7a76io5yWbzefTDSR7F3/ra5w/PnCKtJ58RKtQx7lDJ4bI
         yK1Nn63SoO4Pn/ZhmASwrTIY4z5iDhUTmp8eU8mvtmoU+p1LaqVj5wgCIamJgzLcY8
         NFLJd60t1MCjA==
Received: by mail-ed1-f53.google.com with SMTP id r11so27805682edd.9
        for <bpf@vger.kernel.org>; Sat, 04 Dec 2021 18:27:59 -0800 (PST)
X-Gm-Message-State: AOAM530qRs7Mc0iWsCNfQhRPrTpWRwP4NrixjWDfmpDE2wi7fNmcTuux
        tMJAP90I91yNPx1XPQkpW5so6eEniALaQALDgg/73Q==
X-Google-Smtp-Source: ABdhPJz9KvGs1YhILMk/3MqwijvqUFgzSo48M/OR5SWW9Ufh+ARSaIQ8cv7P1mP45di4lMM+I4P3B5nJRNPoEMg0+rA=
X-Received: by 2002:a05:6402:42c6:: with SMTP id i6mr40613603edc.223.1638671277921;
 Sat, 04 Dec 2021 18:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1> <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1> <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
 <20211130023410.hmyw7fhxwpskf6ba@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7+V=ui7kS-8u7zQoHPT3zZE6X3QuRROG3898Mai9JAcg@mail.gmail.com>
 <20211130225129.GB641268@paulmck-ThinkPad-P17-Gen-1> <20211204010152.GA3967770@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211204010152.GA3967770@paulmck-ThinkPad-P17-Gen-1>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 5 Dec 2021 03:27:47 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5h+MaGxhYH-vhQQdqzbiVs4p2GVMnBWMjoA0xE9Tz_aw@mail.gmail.com>
Message-ID: <CACYkzJ5h+MaGxhYH-vhQQdqzbiVs4p2GVMnBWMjoA0xE9Tz_aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
To:     paulmck@kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 4, 2021 at 2:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 02:51:29PM -0800, Paul E. McKenney wrote:

[...]

> > There are probably still bugs, but it is passing much nastier tests than
> > a couple of weeks ago, so here is hoping...
>
> And this is now in -next.  Please let me know how it goes!

I was able to rebase this on linux-next which has Paul's changes and
ran it with:

root@kpsingh:~# cat /proc/cmdline
console=ttyS0,115200 root=/dev/sda rw nokaslr rcupdate.rcu_task_enqueue_lim=4

The warning about the nested spinlock in the raw spin locked section
is also gone and I don't
see any other warnings. Will send the rebased series after doing a few
more checks.

- KP

>
>                                                                 Thanx, Paul
