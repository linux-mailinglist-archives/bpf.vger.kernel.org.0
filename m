Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7613D4E4A
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGYOmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhGYOmc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 10:42:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40FC0613D3
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 08:22:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c11so8612094plg.11
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DKPf+sLAtl+Jfu5xFH1HFSHWQjyJHMuLfqwJAAL9V1I=;
        b=RyEF3kEmCv6XYQYzOk9r4eMC1hnA7PQbkoewT10+Q0kx0XiYjfNnh9LxGxMhjt0Ao3
         LFr2NXoWgNeJr1799Rv99nFH/7Itva34ZF+o30/+SWQofzOCYpgaWZdJ4XIRqJCpC6BW
         hZvTPp4oDUTiVZ+UWsP1PViGMxMG9hkVcDvZQhun5SSOa0rGT+TRIijsm8mXrp3KkXCF
         iknEvzYNzyJ/HET/hi8bbtmI6efD8XO8pMLnexqACbrEj3/DjTBjg/VrtyGYWcbFr8I4
         U0Ezyjua82gIsnWJopXIvoZyFytBqwFU+yFR3iSyL9ELOfSlXYjy4+tEEDUsyxC1wYyU
         9x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DKPf+sLAtl+Jfu5xFH1HFSHWQjyJHMuLfqwJAAL9V1I=;
        b=DvUPtP3MAnwtd4QjQgRs92k0lZC4zCVR9nwoJaCMK2FqL1blqS+xDFCk/6OURyB5+I
         sHnzkUu5PNO1a3KhxJy+5UTW811gr12QaVSYCbezKAT4+qkXF2fYiB3PAZsTdK8vRDWj
         HHL9HTjP/HKyK59WeVJi6amBi3N82S0VqNoJVlpYnuEA7LBJ5wIDu0uRSAexdcbi1YBX
         i+cwWg2AE7KM6lxYNWYJ7Q/oo36SbqmSr3RPeCAdLcKADCfrucsqsfQ/AmrAF0wr6p17
         VBWYgPhGskA31/+tIq/XakcZDqPqK8gwZQOX6idybX8TQuuHsP/6YBNwgPOoxl02Omur
         IoBg==
X-Gm-Message-State: AOAM530ZTfXJl4YLca3UCCv4i8PAeMcNT9m+03KNM94auMG5SPSquG4P
        imVn1u3A6mM6q/4wy47KUz0=
X-Google-Smtp-Source: ABdhPJy1PKgJrkJ/6dTi/mhiUBvSQgOcXDh1RqcAmUlzKS6z4+iGRUdghfryDBDee67AO8kbAufVQw==
X-Received: by 2002:a65:63cf:: with SMTP id n15mr14179579pgv.392.1627226561465;
        Sun, 25 Jul 2021 08:22:41 -0700 (PDT)
Received: from sea-l-00054165.olympus.f5net.com (c-73-19-16-93.hsd1.wa.comcast.net. [73.19.16.93])
        by smtp.gmail.com with ESMTPSA id b21sm39354466pfo.64.2021.07.25.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 08:22:40 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date:   Sun, 25 Jul 2021 08:22:39 -0700 (PDT)
To:     Vincent Li <vincent.mc.li@gmail.com>
cc:     bpf@vger.kernel.org
Subject: Re: Prog section rejected: Argument list too long (7)!
In-Reply-To: <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com>
Message-ID: <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com> <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com> <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org




On Sat, 24 Jul 2021, Vincent Li wrote:

> 
> 
> On Sat, 24 Jul 2021, Vincent Li wrote:
> 
> > On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >
> > >
> > > Hi BPF experts,
> > >
> > > I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> > > failed to pass verifier in kernel 4.19, the error is like:
> > >
> > > level=warning msg="Prog section '2/7' rejected: Argument list too long
> > > (7)!" subsys=datapath-loader
> > > level=warning msg=" - Type:         3" subsys=datapath-loader
> > > level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> > > level=warning msg=" - Instructions: 4578 (482 over limit)"
> > > subsys=datapath-loader
> > > level=warning msg=" - License:      GPL" subsys=datapath-loader
> > > level=warning subsys=datapath-loader
> > > level=warning msg="Verifier analysis:" subsys=datapath-loader
> > > level=warning subsys=datapath-loader
> > > level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > > level=warning msg="Unable to load program" subsys=datapath-loader
> > >
> > > then I tried to run the PR locally in my dev machine with custom upstream
> > > kernel version, I narrowed the issue down to between upstream kernel
> > > version 5.7 and 5.8, in 5.7, it failed with:
> > 
> > I further narrow it down to between 5.7 and 5.8-rc1 release, but still
> > no clue which commits in 5.8-rc1 resolved the issue
> > 
> > >
> > > level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> > > 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> > > level=warning subsys=datapath-loader
> > > level=warning msg="Log buffer too small to dump verifier log 16777215
> > > bytes (9 tries)!" subsys=datapath-loader
> > > level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > > level=warning msg="Unable to load program" subsys=datapath-loader
> > >
> > > 5.8 works fine.
> > >
> > > What difference between 5.7 and 5.8 to cause this verifier problem, I
> > > tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> > > that would make the difference with my limited BPF knowledge. Any clue
> > > would be appreciated!
> 
> I have git bisected to this commit:
> 
> # first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make 
> verifier log more relevant by default

both the cilium github PR test and my local dev machine PR test has the 
verbose set, for example, my local test has:

diff --git a/pkg/datapath/loader/netlink.go 
b/pkg/datapath/loader/netlink.go
index 381e1fbc8..00015eabc 100644
--- a/pkg/datapath/loader/netlink.go
+++ b/pkg/datapath/loader/netlink.go
@@ -106,7 +106,7 @@ func replaceDatapath(ctx context.Context, ifName, 
objPath, progSec, progDirectio
                loaderProg = "tc"
                args = []string{"filter", "replace", "dev", ifName, 
progDirection,
                        "prio", "1", "handle", "1", "bpf", "da", "obj", 
objPath,
-                       "sec", progSec,
+                       "sec", progSec, "verbose",
                }
        }
        cmd = exec.CommandContext(ctx, loaderProg, 
args...).WithFilters(libbpfFixupMsg)

if I remove the "verbose" change, and run the Cilium agent without 
kernel commit 6f8a57ccf8, the problem is gone, it seems commit 6f8a57ccf8 
is related

> 
> this commit looks only dealing with log, accidently fixed the PR issue I 
> have? my PR use __bpf_memcpy_builtin() to rewrite the tunnel inner packet 
> destination MAC address, somehow related?
> 
> [root@centos-dev bpf-next]# git bisect log
> git bisect start '--term-new=fixed' '--term-old=unfixed'
> # fixed: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
> git bisect fixed b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> # unfixed: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
> git bisect unfixed 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
> # fixed: [ee01c4d72adffb7d424535adf630f2955748fa8b] Merge branch 'akpm' 
> (patches from Andrew)
> git bisect fixed ee01c4d72adffb7d424535adf630f2955748fa8b
> # unfixed: [16d91548d1057691979de4686693f0ff92f46000] Merge tag 
> 'xfs-5.8-merge-8' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> git bisect unfixed 16d91548d1057691979de4686693f0ff92f46000
> # fixed: [098205f3c688885394ed1f670a6a7cb4a58728a3] Merge branch '1GbE' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
> git bisect fixed 098205f3c688885394ed1f670a6a7cb4a58728a3
> # fixed: [da1a782a7140fab22f2dfe8453d7b73c786d73de] net: ipa: kill 
> ipa_cmd_dma_task_32b_addr_add()
> git bisect fixed da1a782a7140fab22f2dfe8453d7b73c786d73de
> # unfixed: [aa8a6ee3e3fc4001e952de37660fe71826da8189] docs: networking: 
> convert team.txt to ReST
> git bisect unfixed aa8a6ee3e3fc4001e952de37660fe71826da8189
> # unfixed: [5b95dea31636ce93660930d16172fe75589b2e70] Merge branch 
> 'net-smc-extent-buffer-mapping-and-port-handling'
> git bisect unfixed 5b95dea31636ce93660930d16172fe75589b2e70
> # fixed: [3316d50905f0e551d4786767d827589960a8cb83] bnxt_en: Split HW ring 
> statistics strings into RX and TX parts.
> git bisect fixed 3316d50905f0e551d4786767d827589960a8cb83
> # fixed: [c321022244708aec4675de4f032ef1ba9ff0c640] selftests/bpf: Test 
> allowed maps for bpf_sk_select_reuseport
> git bisect fixed c321022244708aec4675de4f032ef1ba9ff0c640
> # fixed: [50325b1761e31ad17d252e795af72a9af8c5a7d7] bpftool: Expose 
> attach_type-to-string array to non-cgroup code
> git bisect fixed 50325b1761e31ad17d252e795af72a9af8c5a7d7
> # fixed: [8c1b2bf16d5944cd5c3a8a72e24ed9e22360c1af] bpf, cgroup: Remove 
> unused exports
> git bisect fixed 8c1b2bf16d5944cd5c3a8a72e24ed9e22360c1af
> # unfixed: [6f3f65d80dac8f2bafce2213005821fccdce194c] net: bpf: Allow TC 
> programs to call BPF_FUNC_skb_change_head
> git bisect unfixed 6f3f65d80dac8f2bafce2213005821fccdce194c
> # fixed: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make verifier log 
> more relevant by default
> git bisect fixed 6f8a57ccf8511724e6f48d732cb2940889789ab2
> # unfixed: [0a05861f80fe7d4dcfdabcc98d9854947573e072] xsk: Fix typo in 
> xsk_umem_consume_tx and xsk_generic_xmit comments
> git bisect unfixed 0a05861f80fe7d4dcfdabcc98d9854947573e072
> # unfixed: [71d19214776e61b33da48f7c1b46e522c7f78221] bpf: add 
> bpf_ktime_get_boot_ns()
> git bisect unfixed 71d19214776e61b33da48f7c1b46e522c7f78221
> # first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make 
> verifier log more relevant by default
> 
> 
> > >
> > > Thanks
> > >
> > > Vincent
> > >
> > 
> 
