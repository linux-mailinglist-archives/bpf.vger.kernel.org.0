Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4935451F51
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfFXXyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 19:54:37 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41761 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfFXXyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 19:54:19 -0400
Received: by mail-vk1-f201.google.com with SMTP id f125so7051707vkc.8
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=XvJQB8hWrOW/SRpeI4tK10iYplodRxP7G102eNBFBqwIMqTgenq6LtYA3UW7T7ITUh
         thRvMJiDtniUB1muyhRW4m0OusgO2K0NXGpZmryrjGn7XtYQmOVnLnrgGwwgyOWfShV8
         xfHcMGtR1GM/LLQqBhE/yjinnKHbkILzy1lRqSNTcUV6NAMQolBDUCJWyNRUMfNrmTQQ
         FiQQQBS7vYwvSmP8HHvCTyDerVit/r1FsvvzcJF4TwX2RPJk35qgc4KBiUp+F8o0SFdp
         XH5fcmKm4j9ciAseV8FHibjrvG6SYiePUrx1fypcNHazdghb88UFwh9fJBOco3mjJypH
         VNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=OtrJDZ7d2D8IZEMkJB/RE6ePl5KaLshLG8PROtXkNV9U5AHOzBa1bKBTmG6niAMrss
         k7ponoa75BXfgjYS4GSVHpCi/nq9hz4if+LpMSKXtSpL5Rmtv+a5o7TV9mujL6gSn2JF
         LpMNt9FB8hvqaS67gl+vWf/q/7m1tepJVRtuFmNsKjrvBNtZ2xHzo0a2Aw7d7FJJfKxg
         G5hcL+EZyi/ss/Ln5r7SuqhsZMoBPdNJhNWHfMz88o7hyhsL5KEfYU9Ja0N0EvRxFhix
         WI+7ptrFeOmDJyIlWnCy8gH+LO6+EMJqn3eRJib0Rflj9IK5cMJyJCZFpJ9WEerCNyG+
         WLZA==
X-Gm-Message-State: APjAAAXqEh8qWYsdljaazwsm4iFjDbgGkeN0B3U2Dr42+C3Jaixz4pxt
        pQQI1RO16P9yy1vSi8miIAIKVuY5yvWvx7R0
X-Google-Smtp-Source: APXvYqyfoVxlgRd5tAjiNz4zlZpLlPBxbOYJd+sVBprlJOt9sCpkadgDf+EMfW+nT+HAQz7dmb4j1cWMKVLw0Nti
X-Received: by 2002:a67:ec8e:: with SMTP id h14mr49850337vsp.17.1561420458245;
 Mon, 24 Jun 2019 16:54:18 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:53:32 -0700
Message-Id: <20190624235334.163625-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/2] bpf: Allow bpf_skb_event_output for a few prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

*** BLURB HERE ***

allanzhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 33 ++++++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

