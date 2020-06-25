Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0678520A0A6
	for <lists+bpf@lfdr.de>; Thu, 25 Jun 2020 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405363AbgFYOOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jun 2020 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405359AbgFYOOC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 10:14:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E522C08C5DB
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 07:14:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so6716263ljo.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldn6FBnq77DB/yy/XXlMExQzH2a0FQzjuDXigv4+ejk=;
        b=d+d5TAasDL3beWsWjtWjkBkMWstxF9TJO5DH5OlLAaQ9c9ShjBooa0622Q8PfpH2kC
         F5iCdXwutjHic5+M8O6rk8DxWnqVuoiBFi7+cRHPJGL8SgCDR7/zwvB3Ft0ODaGXN6Mw
         mNHbA6pgB0CSm2AU3MoHohtNLIqU/oad+FxNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldn6FBnq77DB/yy/XXlMExQzH2a0FQzjuDXigv4+ejk=;
        b=iN3wGhtfu+UaKSbEO456vqEerOOjSKPsDLsvGesJtmwDA5e0NdtuDkEc9ouwYVeD3e
         IyLHSXayCz4n5IlAEniMejTMkmtYJrWu51Q244GcUF+j6VXR5MuqfTCIVQ4foe059Il0
         p7CCC27g2FX5upvpBCPnCWB0ubctBbhXm4TNM2r25xlqyZ8LZUUS4iTdOb37GIDU5fJF
         z2WkRwvjs7C6wzaPJSdbMGeOadowQjlGAumiKQknePerl+/t1x9ZpEmfYP3T8P5a8uIZ
         i+MLHjQC6A/lp2M4GWERIqzqB39ktOH5qPRCLbdCr0U3Gp3/OZnbty4Pb8NFzotA5p80
         8EPw==
X-Gm-Message-State: AOAM533KrsHmZovRWX9+FFHg3lz7nD5J7y5pe9kGpHE9YvWGMPIFk1/D
        St6C+eN9ae6ddVXSgyeOyK1oh8C8JA6EEw==
X-Google-Smtp-Source: ABdhPJwwFS1QNZO155U1/cGCWMoyVuUuoyBNOXZB1e4mVW1gwol8Rd4yERtyfBw6vj+9q5SbvvEONQ==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr16570156ljj.371.1593094440144;
        Thu, 25 Jun 2020 07:14:00 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id z2sm5609698ljh.72.2020.06.25.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:13:59 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next v3 0/4] bpf, netns: Prepare for multi-prog attachment
Date:   Thu, 25 Jun 2020 16:13:53 +0200
Message-Id: <20200625141357.910330-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set prepares ground for link-based multi-prog attachment for
future netns attach types, with BPF_SK_LOOKUP attach type in mind [0].

Two changes are needed in order to attach and run a series of BPF programs:

  1) an bpf_prog_array of programs to run (patch #2), and
  2) a list of attached links to keep track of attachments (patch #3).

Nothing changes for BPF flow_dissector. Just as before only one program can
be attached to netns.


In v3 I've simplified patch #2 that introduces bpf_prog_array to take
advantage of the fact that it will hold at most one program for now.

In particular, I'm no longer using bpf_prog_array_copy. It turned out to be
less suitable for link operations than I thought as it fails to append the
same BPF program.

bpf_prog_array_replace_item is also gone, because we know we always want to
replace the first element in prog_array.

Naturally the code that handles bpf_prog_array will need change once
more when there is a program type that allows multi-prog attachment. But I
feel it will be better to do it gradually and present it together with
tests that actually exercise multi-prog code paths.

Thanks,
-jkbs

[0] https://lore.kernel.org/bpf/20200511185218.1422406-1-jakub@cloudflare.com/

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>

v2 -> v3:
- Don't check if run_array is null in link update callback. (Martin)
- Allow updating the link with the same BPF program. (Andrii)
- Add patch #4 with a test for the above case.
- Kill bpf_prog_array_replace_item. Access the run_array directly.
- Switch from bpf_prog_array_copy() to bpf_prog_array_alloc(1, ...).
- Replace rcu_deref_protected & RCU_INIT_POINTER with rcu_replace_pointer.
- Drop Andrii's Ack from patch #2. Code changed.

v1 -> v2:

- Show with a (void) cast that bpf_prog_array_replace_item() return value
  is ignored on purpose. (Andrii)
- Explain why bpf-cgroup cannot replace programs in bpf_prog_array based
  on bpf_prog pointer comparison in patch #2 description. (Andrii)

Jakub Sitnicki (4):
  flow_dissector: Pull BPF program assignment up to bpf-netns
  bpf, netns: Keep attached programs in bpf_prog_array
  bpf, netns: Keep a list of attached bpf_link's
  selftests/bpf: Test updating flow_dissector link with same program

 include/net/flow_dissector.h                  |   3 +-
 include/net/netns/bpf.h                       |   7 +-
 kernel/bpf/net_namespace.c                    | 162 ++++++++++++------
 net/core/flow_dissector.c                     |  32 ++--
 .../bpf/prog_tests/flow_dissector_reattach.c  |  32 +++-
 5 files changed, 160 insertions(+), 76 deletions(-)

-- 
2.25.4

