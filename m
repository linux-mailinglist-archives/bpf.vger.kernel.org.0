Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3393D4460
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 04:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhGXBhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 21:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhGXBhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 21:37:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F7C061575
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 19:17:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e5so3210600pld.6
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 19:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version;
        bh=KQ9PaIynX9STecpxjVPu+uVqxknwNnM7DP9VHmBQsO4=;
        b=KPPHeIsppUyhyppoABXcySoUiu2+ddA3ZboUBj8UwhjlZo1UoCiYPSVkVdNzZnJbpC
         Sge/PWcEmAQD1RZQzZh23s56BEdNEuqwdXrTf3gX0tZqks/jkDj/vRXyfsKIRz/1T111
         WmAA+nJ+JwSONIn/04DqdjiluJoobqYIdu5oiq76ZSNtfqj+9ba9E045acAZcjLShb/m
         8o3xYJxlrBnYxM+FNdvQgZxiPA9Cpc2DadgCE7R3g/UxoJ2rilDupdJJ5U4DQRWHq8Sh
         0mXSMgAAfTm4a9T2xorE2Q+QNOjFOPOZSBgCthYqnii8B2l2GpaO/YFrFZW8jfjcOTpi
         g92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version;
        bh=KQ9PaIynX9STecpxjVPu+uVqxknwNnM7DP9VHmBQsO4=;
        b=MLZ9W44HBcexbjkpc9iHrMuEk2ChB1Y6ftPbNCKCXVpQIpV7pYkf5f/zfZnEIhtHJh
         gQNmBvRLMEsR3RM7qbKxE4UKLVr2QIrji6fyCtuRb+5pcybhk33Bjep5jdujb0JqWH3/
         vX4QmKTDLVOFeoGm/1eDe4W7NebFifqt64DviwgxwGy+1ddjS9NDyHyUWByas5dWRzGb
         6vUqvDUz2y8gCm1nWgCtUUYJA/ThFd/I4OEgy9w2j6h7iErkj4P28kp2ni/h86MF8G/7
         LeliaC46ruoiVJdcDhcMtTQKdvsKG4XTpIS5bZjQNH18MM0hH9qPYlOqHraciU8t2z/C
         3qUg==
X-Gm-Message-State: AOAM531k+/hKNJaloxDIjhnQCsMPV7eIcW04409y2nNfXYUTVShaeMQW
        1Ys+PUbOYGtpMNhYuGuqQHQQjrNBjYg=
X-Google-Smtp-Source: ABdhPJxauBL+csz4Okv5kCG4lj8Wte7Clkep4KlO5x37oRZpE++kdspIPBetuM5GALAQu5lAKWltkA==
X-Received: by 2002:a17:902:fe97:b029:12b:e3f2:f5d5 with SMTP id x23-20020a170902fe97b029012be3f2f5d5mr2423835plm.74.1627093077112;
        Fri, 23 Jul 2021 19:17:57 -0700 (PDT)
Received: from sea-l-00054165.olympus.f5net.com (c-73-19-16-93.hsd1.wa.comcast.net. [73.19.16.93])
        by smtp.gmail.com with ESMTPSA id a20sm7114551pjh.46.2021.07.23.19.17.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 19:17:56 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date:   Fri, 23 Jul 2021 19:17:53 -0700 (PDT)
To:     bpf@vger.kernel.org
Subject: Prog section rejected: Argument list too long (7)!
Message-ID: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi BPF experts,

I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
failed to pass verifier in kernel 4.19, the error is like:

level=warning msg="Prog section '2/7' rejected: Argument list too long 
(7)!" subsys=datapath-loader
level=warning msg=" - Type:         3" subsys=datapath-loader
level=warning msg=" - Attach Type:  0" subsys=datapath-loader
level=warning msg=" - Instructions: 4578 (482 over limit)" 
subsys=datapath-loader
level=warning msg=" - License:      GPL" subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Verifier analysis:" subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Error filling program arrays!" subsys=datapath-loader
level=warning msg="Unable to load program" subsys=datapath-loader

then I tried to run the PR locally in my dev machine with custom upstream 
kernel version, I narrowed the issue down to between upstream kernel 
version 5.7 and 5.8, in 5.7, it failed with:

level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn 
0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Log buffer too small to dump verifier log 16777215 
bytes (9 tries)!" subsys=datapath-loader
level=warning msg="Error filling program arrays!" subsys=datapath-loader
level=warning msg="Unable to load program" subsys=datapath-loader

5.8 works fine.

What difference between 5.7 and 5.8 to cause this verifier problem, I 
tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits 
that would make the difference with my limited BPF knowledge. Any clue 
would be appreciated!

Thanks

Vincent

