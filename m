Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6154C35E4EA
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbhDMRW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 13:22:29 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:42507 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhDMRW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 13:22:28 -0400
Received: by mail-qk1-f174.google.com with SMTP id d15so5655491qkc.9
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wI/+rBX/o3gQX8aK29t+8LwdIgeCADt3sq9jxR4OClw=;
        b=Euze0Rhb4eDKc/5PfqRI4ogHfbAKtUhknYBijKfYV6DqoytRP03mRWxrQOavsxux45
         teM04XL+atDreXk4G0QQBNhjDHsgHKsOCLkLqWQdxMzdmWBOcfN1cdhX6zaWAuj/L96u
         eXngGpW0aKNbTqLVxqjHTaqj4t5Ir+aSRwAexiVOge/JYlV0QcXnbN7x19tcfCDMtha0
         BmE7UUsrbjhhbBfat5Q2IUKe2Cbr9zOno1ngs5Ljrm0Af0yqLrcywkt5HXeaEULL7ttb
         IkEXCMuTP25S4OJCcfXgvnp6glYn+bDDrCSxpp1zt4HsaUNbpFy8AODL4KNnBEO6YAHi
         QVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wI/+rBX/o3gQX8aK29t+8LwdIgeCADt3sq9jxR4OClw=;
        b=aqFighN+enPCnxhjFuJKi7aTbj9otWlizzHf9B2/xbGYEgddODjhkSBi7Hfm/bH9Az
         nraPVhnYFgOTpKAX2gk7oZPXsi5En064wLmGp/ItIJnxyppKUWJgMWKGZi55G4/+qcwf
         0I8wLBYpyKDEJEmkgBPM72+2YSJqw+DvW55gS4P74tEWS3k65Z0cLGr2hzKHTjTQMqxS
         7Lf6ndGYqI3wqEo5Bc+XKei7FE7NVgeM3/xQ0Q4ELWym/tmsAeIiv4Tmt3dx290BPEWh
         CgHE6bVViElMlq2AeEWTrPSrzFTYEHb8fI4CUPkIojigO+JIeUUCXPKkMakwCQNQ8udF
         0NiA==
X-Gm-Message-State: AOAM53346FSkHfS+XH2KsbN9dynZ4Mo4YMCfCFlCTFSJI2Nia5xLw/ER
        8dizBkFlmBOdLNnObAYZDcPifCNGUK0nKPQ7ncoCOg==
X-Google-Smtp-Source: ABdhPJxbrMdSh8La1h3woquZfue6Wq28zDi4SAsvfCQvM+Qp1voGLuv3L16pfp30x1Jwvdt1vUihBNaWUDibbqomwQI=
X-Received: by 2002:a05:620a:146e:: with SMTP id j14mr10089456qkl.424.1618334468448;
 Tue, 13 Apr 2021 10:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000046e0e905afcff205@google.com> <0000000000002c193805bee0f97c@google.com>
In-Reply-To: <0000000000002c193805bee0f97c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 19:20:57 +0200
Message-ID: <CACT4Y+bEt4rPp-WdDe5gs89bNBjwMe0OSuwCyOT1eioKPjXYyA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_trace_run2
To:     syzbot <syzbot+845923d2172947529b58@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        coreteam@netfilter.org, Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Patrick McHardy <kaber@trash.net>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>, kpsingh@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        mchehab@s-opensource.com, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, mmullins@mmlx.us,
        netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 1, 2021 at 5:39 AM syzbot
<syzbot+845923d2172947529b58@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit befe6d946551d65cddbd32b9cb0170b0249fd5ed
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Wed Nov 18 14:34:05 2020 +0000
>
>     tracepoint: Do not fail unregistering a probe due to memory failure
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123358a1d00000
> start commit:   70b97111 bpf: Use hlist_add_head_rcu when linking to local..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e0ca96a9b6ee858
> dashboard link: https://syzkaller.appspot.com/bug?extid=845923d2172947529b58
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10193f3b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c729b900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: tracepoint: Do not fail unregistering a probe due to memory failure
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix:
tracepoint: Do not fail unregistering a probe due to memory failure
