Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF543D4C57
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 08:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhGYFfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 01:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 01:35:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A656C061757
        for <bpf@vger.kernel.org>; Sat, 24 Jul 2021 23:16:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2308754pjo.1
        for <bpf@vger.kernel.org>; Sat, 24 Jul 2021 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lkObuEePlYNJcU5Un/aHauA4wm9VPkkLpXJDim1D4Fk=;
        b=Ne+bSFwiizIV1R7cKbVZDXXO917I0yLp+yTn8sWSb+74hnch6vZ+htukgQY4343eY8
         TeUzsn/uJB3Wnzx119+x4nRXG/QnO9h4VUBT8kuiTP19fkNJfSFoyvjy1hvnVPccXs5Y
         7wXQ9bnR7KdaQkOYYsuoTgQEjPC4AZP4qm4MNsl6coyZRbCrsPUu6KSRzTERsFLCpcYA
         EGq9YoOdgX5XPxvr4GHhnHS5IsZTYlzMUR96qLmo9b9ZFtHMfBlVfUacnFUvVLdbh5hE
         c/YR5zA+TfSzevwVgnfhmuyNujTinddVPcyGabDeilta19S3nFT6YQSMDjze7mX6TQL8
         VosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lkObuEePlYNJcU5Un/aHauA4wm9VPkkLpXJDim1D4Fk=;
        b=DvmFLWnrt2lSReRY2if/Pktd1OkfGu2qu4VZZUZj3X2WeWzAodEJD6xMBAM+L0lMxu
         n6qAcuzWTIZjqkcKI6Rb9QwRps+uRvDLtq+ykLizSu8DwlyyeO4rK0Sj6xhKT5pjil4F
         gUc/yFGhMs7an5zmFCErPDAdC66/2OyrqNcokkaZSNUqXKq/ZPbKaeuGcrhy2qKJ9QEE
         Udl261SaNYGBsWyuXa9GJkWdbqF0tR4bLFJT8SHEpP7T4jnKAJRdN04sfUIKL5aWWLWJ
         9Ru1yLwYgkXRqxUHoatnYQIugear+pH7GFGhusO68AquX3z6g4ufLv8+jlivgpGurMVY
         QBng==
X-Gm-Message-State: AOAM531Zea2VZQM2gqwI3UB6FiFDznNL+xEbC9o0UCKGLKUPH/Vd5y1M
        1CinfMoq0Zm2gPOIFnMZ8y8=
X-Google-Smtp-Source: ABdhPJyMUQ3Psc2xFy05gMvoemU0nK/NhSwfPTCFVJL7VHmiJV7xeezF/tbg3+3q7xudAIaA+2id/Q==
X-Received: by 2002:a65:678d:: with SMTP id e13mr5045067pgr.135.1627193778525;
        Sat, 24 Jul 2021 23:16:18 -0700 (PDT)
Received: from sea-l-00054165.olympus.f5net.com (c-73-19-16-93.hsd1.wa.comcast.net. [73.19.16.93])
        by smtp.gmail.com with ESMTPSA id t205sm12134168pfc.32.2021.07.24.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 23:16:17 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date:   Sat, 24 Jul 2021 23:16:14 -0700 (PDT)
To:     Vincent Li <vincent.mc.li@gmail.com>
cc:     bpf@vger.kernel.org
Subject: Re: Prog section rejected: Argument list too long (7)!
In-Reply-To: <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
Message-ID: <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com>
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com> <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Sat, 24 Jul 2021, Vincent Li wrote:

> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> >
> > Hi BPF experts,
> >
> > I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> > failed to pass verifier in kernel 4.19, the error is like:
> >
> > level=warning msg="Prog section '2/7' rejected: Argument list too long
> > (7)!" subsys=datapath-loader
> > level=warning msg=" - Type:         3" subsys=datapath-loader
> > level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> > level=warning msg=" - Instructions: 4578 (482 over limit)"
> > subsys=datapath-loader
> > level=warning msg=" - License:      GPL" subsys=datapath-loader
> > level=warning subsys=datapath-loader
> > level=warning msg="Verifier analysis:" subsys=datapath-loader
> > level=warning subsys=datapath-loader
> > level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > level=warning msg="Unable to load program" subsys=datapath-loader
> >
> > then I tried to run the PR locally in my dev machine with custom upstream
> > kernel version, I narrowed the issue down to between upstream kernel
> > version 5.7 and 5.8, in 5.7, it failed with:
> 
> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
> no clue which commits in 5.8-rc1 resolved the issue
> 
> >
> > level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> > 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> > level=warning subsys=datapath-loader
> > level=warning msg="Log buffer too small to dump verifier log 16777215
> > bytes (9 tries)!" subsys=datapath-loader
> > level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > level=warning msg="Unable to load program" subsys=datapath-loader
> >
> > 5.8 works fine.
> >
> > What difference between 5.7 and 5.8 to cause this verifier problem, I
> > tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> > that would make the difference with my limited BPF knowledge. Any clue
> > would be appreciated!

I have git bisected to this commit:

# first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make 
verifier log more relevant by default

this commit looks only dealing with log, accidently fixed the PR issue I 
have? my PR use __bpf_memcpy_builtin() to rewrite the tunnel inner packet 
destination MAC address, somehow related?

[root@centos-dev bpf-next]# git bisect log
git bisect start '--term-new=fixed' '--term-old=unfixed'
# fixed: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
git bisect fixed b3a9e3b9622ae10064826dccb4f7a52bd88c7407
# unfixed: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
git bisect unfixed 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
# fixed: [ee01c4d72adffb7d424535adf630f2955748fa8b] Merge branch 'akpm' 
(patches from Andrew)
git bisect fixed ee01c4d72adffb7d424535adf630f2955748fa8b
# unfixed: [16d91548d1057691979de4686693f0ff92f46000] Merge tag 
'xfs-5.8-merge-8' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect unfixed 16d91548d1057691979de4686693f0ff92f46000
# fixed: [098205f3c688885394ed1f670a6a7cb4a58728a3] Merge branch '1GbE' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect fixed 098205f3c688885394ed1f670a6a7cb4a58728a3
# fixed: [da1a782a7140fab22f2dfe8453d7b73c786d73de] net: ipa: kill 
ipa_cmd_dma_task_32b_addr_add()
git bisect fixed da1a782a7140fab22f2dfe8453d7b73c786d73de
# unfixed: [aa8a6ee3e3fc4001e952de37660fe71826da8189] docs: networking: 
convert team.txt to ReST
git bisect unfixed aa8a6ee3e3fc4001e952de37660fe71826da8189
# unfixed: [5b95dea31636ce93660930d16172fe75589b2e70] Merge branch 
'net-smc-extent-buffer-mapping-and-port-handling'
git bisect unfixed 5b95dea31636ce93660930d16172fe75589b2e70
# fixed: [3316d50905f0e551d4786767d827589960a8cb83] bnxt_en: Split HW ring 
statistics strings into RX and TX parts.
git bisect fixed 3316d50905f0e551d4786767d827589960a8cb83
# fixed: [c321022244708aec4675de4f032ef1ba9ff0c640] selftests/bpf: Test 
allowed maps for bpf_sk_select_reuseport
git bisect fixed c321022244708aec4675de4f032ef1ba9ff0c640
# fixed: [50325b1761e31ad17d252e795af72a9af8c5a7d7] bpftool: Expose 
attach_type-to-string array to non-cgroup code
git bisect fixed 50325b1761e31ad17d252e795af72a9af8c5a7d7
# fixed: [8c1b2bf16d5944cd5c3a8a72e24ed9e22360c1af] bpf, cgroup: Remove 
unused exports
git bisect fixed 8c1b2bf16d5944cd5c3a8a72e24ed9e22360c1af
# unfixed: [6f3f65d80dac8f2bafce2213005821fccdce194c] net: bpf: Allow TC 
programs to call BPF_FUNC_skb_change_head
git bisect unfixed 6f3f65d80dac8f2bafce2213005821fccdce194c
# fixed: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make verifier log 
more relevant by default
git bisect fixed 6f8a57ccf8511724e6f48d732cb2940889789ab2
# unfixed: [0a05861f80fe7d4dcfdabcc98d9854947573e072] xsk: Fix typo in 
xsk_umem_consume_tx and xsk_generic_xmit comments
git bisect unfixed 0a05861f80fe7d4dcfdabcc98d9854947573e072
# unfixed: [71d19214776e61b33da48f7c1b46e522c7f78221] bpf: add 
bpf_ktime_get_boot_ns()
git bisect unfixed 71d19214776e61b33da48f7c1b46e522c7f78221
# first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make 
verifier log more relevant by default


> >
> > Thanks
> >
> > Vincent
> >
> 
