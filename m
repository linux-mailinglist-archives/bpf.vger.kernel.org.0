Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370733D48B5
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhGXQXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Jul 2021 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXQXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Jul 2021 12:23:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B02C061575
        for <bpf@vger.kernel.org>; Sat, 24 Jul 2021 10:03:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u12so5752058eds.2
        for <bpf@vger.kernel.org>; Sat, 24 Jul 2021 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fvvzSkrxynUlYRtuZiPjXihIfM7iW9pBn/vgaIiTrxQ=;
        b=JtVSmfrygVJ6YkOFZeTUHiCiz8OXNlcZ1HAVMDx7X4UtNEg2ukDiI/KYhDwEBYQt6g
         41AznrhI1IYRIvA6ssdrB1SLkE9DSVmaCzXHAHN/b26YpcvB4K236SKrxLEMagcaPMuq
         IwB5xW6lo+sB0zPpZlVJAXQlV3Rvt2FamweYZUxIynuU7Z/qB5YO15f2ygChkkzcRG2y
         E5WWoF5/fEYjCBXGRJukglaHXO/8tqhxqFgeLX6rsRVpMabMl1tKcZFPl8cXMP1iVUfg
         fwMS2/AUAipNWvme/A6lTYIHaPzEolZ9GnGi5n9Kud3PhcuuXLGo+Z5gFCxuNs2geRmv
         gcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fvvzSkrxynUlYRtuZiPjXihIfM7iW9pBn/vgaIiTrxQ=;
        b=JadMhFlVXhJo9Tt9BaSAlQOb0+pCi+qUQubuvn7+awSyxDXGq3oTtT2szyJdjx2b2u
         916YB67E0bKV7/dIrX4hhg5CG0ETwSaiYmPm5HzHzVBQRnbgH3xtv6mgerMbnAPR4q0P
         INgAYMmP29R54A16/CA5SZO7Ye/kEeXhq+dApB44nH5f2fQoWGcSxVkGYYHfvSrHE0Cz
         1PWPCzd6frmZYnH1breFiB63XRXws1I8SI/71+yeK6iLW/+RwIeWTNbnhxbnZQtuV3Gy
         xl0LAYujbOBGKFwRD/scBKRDqumtzA0ixRvhEJaLBG4S9c5pLfbcp7goXin+1RtBAOd1
         BBMA==
X-Gm-Message-State: AOAM533oDoOHnvXkApjUuJtsL3Uw+XNUT0sjmoaa5MY8tTfD+LeUPQpg
        COi83MZogikd/CLx26FRZiOTVziGPIgCUaXlAdmWGIby
X-Google-Smtp-Source: ABdhPJwr81TZmD7fBoQ7tMNL2PkUR8N0Q6LVbDizbyfheGRmi8iaIvSxZC5m6ay8YDNvmVS+pELLTO73i2N7X75EzTA=
X-Received: by 2002:a05:6402:60e:: with SMTP id n14mr12107987edv.363.1627146233367;
 Sat, 24 Jul 2021 10:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com>
In-Reply-To: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Sat, 24 Jul 2021 10:03:42 -0700
Message-ID: <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
>
> Hi BPF experts,
>
> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> failed to pass verifier in kernel 4.19, the error is like:
>
> level=warning msg="Prog section '2/7' rejected: Argument list too long
> (7)!" subsys=datapath-loader
> level=warning msg=" - Type:         3" subsys=datapath-loader
> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> level=warning msg=" - Instructions: 4578 (482 over limit)"
> subsys=datapath-loader
> level=warning msg=" - License:      GPL" subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Verifier analysis:" subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> level=warning msg="Unable to load program" subsys=datapath-loader
>
> then I tried to run the PR locally in my dev machine with custom upstream
> kernel version, I narrowed the issue down to between upstream kernel
> version 5.7 and 5.8, in 5.7, it failed with:

I further narrow it down to between 5.7 and 5.8-rc1 release, but still
no clue which commits in 5.8-rc1 resolved the issue

>
> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Log buffer too small to dump verifier log 16777215
> bytes (9 tries)!" subsys=datapath-loader
> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> level=warning msg="Unable to load program" subsys=datapath-loader
>
> 5.8 works fine.
>
> What difference between 5.7 and 5.8 to cause this verifier problem, I
> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> that would make the difference with my limited BPF knowledge. Any clue
> would be appreciated!
>
> Thanks
>
> Vincent
>
