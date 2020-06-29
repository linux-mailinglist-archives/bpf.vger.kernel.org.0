Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C370820DFD7
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgF2UkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbgF2TOM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F13C008640
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so15854369wrw.12
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAaMon7PoyrZX3q0I4IJTvqbNcCBFKr4aXa1atrLwm8=;
        b=cplsWQXJjW+tLIs6ePCa8ACMhZ3nHnpxRQ1GdkyBDU7KAtvJDLEJlHUXELif24tBRZ
         V90M3+PBHs4bBE6cOi70twQOtYuLbwYAybpFMJYhZW5Ir3iGXY9QR5+O6Lcd8W34R7uE
         VpCpbobkUdpFdLFthDdocXGyuMfamRBdvJWEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAaMon7PoyrZX3q0I4IJTvqbNcCBFKr4aXa1atrLwm8=;
        b=l9RwrYqK24PmvQbl1RFhYoXI+ZxPq6yVF0ZszADEyV4EnMY9xIhtrRyMWwXS0iNVLg
         YdYCNwzRJK2vhLR3Nq3V019IX88fZ9OfMaAN9BnfN4Jk/H5dHpBUd79+5WImmh2whZPR
         j1Pnb3301gTdaPXuD+kX66bui4QaNc5F6ayFnOZ13+QikYVoGpugBNpnitrOwT4HkT5j
         giy+T5bF+Yz4DYMPKnP7jZO8312CVG3bcteory/mWUJSKebNVpE6Qi8ljP7pGPmAx4Ds
         WhBW1RK5Skm8DNWhLmlcYvGMCzZzqx2w064sU0Rlf59yQUZhEuxd19HN6MV/Aa3gXWia
         yDiA==
X-Gm-Message-State: AOAM533sASSRMMlRYFtDLne+b8fvVN0++tpF7wTiUwzU2ISe8ut2Bagf
        ywPNAZTkW0W33fJbufveT7y9ZQ==
X-Google-Smtp-Source: ABdhPJw6aTvEKV/iiJj0fT6ZG80zObh21uc3SDgh3TtVE/Nuy32j1DWjqYJLlPD6RnC1mQsv8/ZzSw==
X-Received: by 2002:adf:ab08:: with SMTP id q8mr15873184wrc.216.1593424783641;
        Mon, 29 Jun 2020 02:59:43 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
Date:   Mon, 29 Jun 2020 10:56:24 +0100
Message-Id: <20200629095630.7933-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both sockmap and flow_dissector ingnore various arguments passed to
BPF_PROG_ATTACH and BPF_PROG_DETACH. We can fix the attach case by
checking that the unused arguments are zero. I considered requiring
target_fd to be -1 instead of 0, but this leads to a lot of churn
in selftests. There is also precedent in that bpf_iter already
expects 0 for a similar field. I think that we can come up with a
work around for fd 0 should we need to in the future.

The detach case is more problematic: both cgroups and lirc2 verify
that attach_bpf_fd matches the currently attached program. This
way you need access to the program fd to be able to remove it.
Neither sockmap nor flow_dissector do this. flow_dissector even
has a check for CAP_NET_ADMIN because of this. The patch set
addresses this by implementing the desired behaviour.

There is a possibility for user space breakage: any callers that
don't provide the correct fd will fail with ENOENT. For sockmap
the risk is low: even the selftests assume that sockmap works
the way I described. For flow_dissector the story is less
straightforward, and the selftests use a variety of arguments.

I've includes fixes tags for the oldest commits that allow an easy
backport, however the behaviour dates back to when sockmap and
flow_dissector were introduced. What is the best way to handle these?

This set is based on top of Jakub's work "bpf, netns: Prepare
for multi-prog attachment" available at
https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/

Since v1:
- Adjust selftests
- Implement detach behaviour

Lorenz Bauer (6):
  bpf: flow_dissector: check value of unused flags to BPF_PROG_ATTACH
  bpf: flow_dissector: check value of unused flags to BPF_PROG_DETACH
  bpf: sockmap: check value of unused args to BPF_PROG_ATTACH
  bpf: sockmap: require attach_bpf_fd when detaching a program
  selftests: bpf: pass program and target_fd in flow_dissector_reattach
  selftests: bpf: pass program to bpf_prog_detach in flow_dissector

 include/linux/bpf-netns.h                     |  5 +-
 include/linux/bpf.h                           | 13 ++++-
 include/linux/skmsg.h                         | 13 +++++
 kernel/bpf/net_namespace.c                    | 22 ++++++--
 kernel/bpf/syscall.c                          |  6 +--
 net/core/sock_map.c                           | 53 +++++++++++++++++--
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
 .../bpf/prog_tests/flow_dissector_reattach.c  | 12 ++---
 8 files changed, 103 insertions(+), 25 deletions(-)

-- 
2.25.1

