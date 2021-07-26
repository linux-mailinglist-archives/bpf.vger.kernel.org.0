Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2C3D50D7
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 03:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGZAea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 20:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGZAe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 20:34:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E36C061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 18:14:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id oz16so5457364ejc.7
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryQYkrrVINVPbgH0gm34QxPZkbRVhRYAj4QW1cghauc=;
        b=VdtZWk8aMBFYmIWggG20KY2E59KyrHo2A2S7G+MXYjYxTzO2hEbATVTXCjr9/5ZPhd
         6oiX2fHYR27IAWoQ7LDjWcU3RNtczIKrbNaP/kO62BLFog1nCth/hJLfpR/iWu7Tp/4p
         XLP/S5pmXr/I4RvzFta4cvsrbiaidX69HmYypLb8DxMHgiQcuvZfbU2ADtCq88DEzdhV
         CxGBHVxiXvw5ZLKA0Q2ZJ2BJ6swHd9AqkI295et/dlMqqsRAGGh2VO24XHvA3Tzg9/8b
         cN9U1TJTwyjYQHytlFNpuJa2OA6mLVBxnzCdcCyI5evX7aT3NqePObFU52NKqxgfdlbu
         XBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryQYkrrVINVPbgH0gm34QxPZkbRVhRYAj4QW1cghauc=;
        b=C2hwcjkx0m9ZFBSMs1LwPWD7b1Gez38ob6RegXjKmMUHt2tBhbHtNeH/nxaqGED0Ky
         yuoRIBnJS3RWW+/9pJ/04gyPAr4CSzetLBolPtUf0xWv1bkXWELqjh5DBHDFmIJIZMNO
         NvA6lCnGvXxQ/UtRpohv5xsOX90IrmyvzpDA5q1Cnco07dYF1RPbTaDUDTdQKmOvj9D1
         UofNFD30Zx0EvxHGMniyUyZr34OZcNHJ9bNm86FdL9r/Sy9D3/FizA+basTGqIsErA4n
         jil7oPQmavQed8HniDffNJFuDBuAceTlGOMZI5GHpQC0k7lIlNKDr5IkRxK3bxpa9KRR
         sMIg==
X-Gm-Message-State: AOAM53250MAPd8XnUTSRmRtYwoKxoBetsCVsOAhxHTiuRFvVgfMbSEJj
        VraRyPK8CJd0deVzfwd+vtzHwQy8Sm70+Xxz0xU=
X-Google-Smtp-Source: ABdhPJwa/w02ZS8ssFHzZHiGv1QjeagJT/5LSi1E2Gekm9p4eGKSphj5ag7wPeiYW/+J3zZowXXaqehesjxgnadN7QI=
X-Received: by 2002:a17:907:1b1b:: with SMTP id mp27mr14542186ejc.538.1627262095635;
 Sun, 25 Jul 2021 18:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com> <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
 <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com> <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
 <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com>
In-Reply-To: <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Sun, 25 Jul 2021 18:14:44 -0700
Message-ID: <CAK3+h2w=CO8vvo_Td=w08zKxfko1DA96xk4fvCXvUA1wLZvOMA@mail.gmail.com>
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 25, 2021 at 6:01 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/25/21 8:22 AM, Vincent Li wrote:
> >
> >
> >
> > On Sat, 24 Jul 2021, Vincent Li wrote:
> >
> >>
> >>
> >> On Sat, 24 Jul 2021, Vincent Li wrote:
> >>
> >>> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>
> >>>>
> >>>> Hi BPF experts,
> >>>>
> >>>> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> >>>> failed to pass verifier in kernel 4.19, the error is like:
> >>>>
> >>>> level=warning msg="Prog section '2/7' rejected: Argument list too long
> >>>> (7)!" subsys=datapath-loader
> >>>> level=warning msg=" - Type:         3" subsys=datapath-loader
> >>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> >>>> level=warning msg=" - Instructions: 4578 (482 over limit)"
> >>>> subsys=datapath-loader
> >>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
> >>>> level=warning subsys=datapath-loader
> >>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
> >>>> level=warning subsys=datapath-loader
> >>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> >>>> level=warning msg="Unable to load program" subsys=datapath-loader
> >>>>
> >>>> then I tried to run the PR locally in my dev machine with custom upstream
> >>>> kernel version, I narrowed the issue down to between upstream kernel
> >>>> version 5.7 and 5.8, in 5.7, it failed with:
> >>>
> >>> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
> >>> no clue which commits in 5.8-rc1 resolved the issue
> >>>
> >>>>
> >>>> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> >>>> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> >>>> level=warning subsys=datapath-loader
> >>>> level=warning msg="Log buffer too small to dump verifier log 16777215
> >>>> bytes (9 tries)!" subsys=datapath-loader
>
> The error message is "Log buffer too small to dump verifier log 16777215
> bytes (9 tries)!".
>
> Commit 6f8a57ccf8511724e6f48d732cb2940889789ab2 made the default log
> much shorter. So it fixed the above log buffer too small issue.
>

Thank you for the confirmation, after I remove 'verbose' log, indeed
the problem went away for kernel 5.x- 5.8, but the
"Prog section '2/7' rejected: Argument list too long.." issue
persisted even after I remove the "verbose" logging
for kernel version 4.19, any clue on that?


> >>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> >>>> level=warning msg="Unable to load program" subsys=datapath-loader
> >>>>
> >>>> 5.8 works fine.
> >>>>
> >>>> What difference between 5.7 and 5.8 to cause this verifier problem, I
> >>>> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> >>>> that would make the difference with my limited BPF knowledge. Any clue
> >>>> would be appreciated!
> >>
> >> I have git bisected to this commit:
> >>
> >> # first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make
> >> verifier log more relevant by default
> >
> > both the cilium github PR test and my local dev machine PR test has the
> > verbose set, for example, my local test has:
> >
> > diff --git a/pkg/datapath/loader/netlink.go
> > b/pkg/datapath/loader/netlink.go
> > index 381e1fbc8..00015eabc 100644
> > --- a/pkg/datapath/loader/netlink.go
> > +++ b/pkg/datapath/loader/netlink.go
> > @@ -106,7 +106,7 @@ func replaceDatapath(ctx context.Context, ifName,
> > objPath, progSec, progDirectio
> >                  loaderProg = "tc"
> >                  args = []string{"filter", "replace", "dev", ifName,
> > progDirection,
> >                          "prio", "1", "handle", "1", "bpf", "da", "obj",
> > objPath,
> > -                       "sec", progSec,
> > +                       "sec", progSec, "verbose",
> >                  }
> >          }
> >          cmd = exec.CommandContext(ctx, loaderProg,
> > args...).WithFilters(libbpfFixupMsg)
> >
> > if I remove the "verbose" change, and run the Cilium agent without
> > kernel commit 6f8a57ccf8, the problem is gone, it seems commit 6f8a57ccf8
> > is related
>
> Remove "verbose" should work since the kernel won't do logging any more.
>
> >
> >>
> >> this commit looks only dealing with log, accidently fixed the PR issue I
> >> have? my PR use __bpf_memcpy_builtin() to rewrite the tunnel inner packet
> >> destination MAC address, somehow related?
> >>
>
> [...]
