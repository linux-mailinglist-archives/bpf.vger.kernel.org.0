Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01B624D853
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHUPSN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHUPSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 11:18:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F55C061573
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:18:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs17so1736123edb.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW86S+wOpEKW8Kx1XDDlLAS9uMUipxyI6cdNEFb3Vyc=;
        b=gE1uffvkQ25P/5633mrrWxh8bc7NtDkX3krN3YHGog8ioySgsKwYrYIjKpLUwJEqj0
         /cB3n1LkfGWtRU9dZn3uY8rYFUa88pVyEB2MDEHXGzj03D6nIcV5rvssfwfp37+/xUfq
         u+LPKbKan9sXbY233/JYB0+SuRDm11ph2ehAQvn1fk7IFhnfISd62SqoSRkOo9rg47sO
         fsa3mKa5hBfYnLJzQnUEqFVs7IqyycEiHSMa/23WU0wIobD3bWR+Dyr5WOkSUhxSOo/e
         QtPgrJhHhV7CIRluNvapatdHo/7riRekygzRlKkmxv1NtNvlxYM2kJ2uuiAD0y65o3MJ
         fZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW86S+wOpEKW8Kx1XDDlLAS9uMUipxyI6cdNEFb3Vyc=;
        b=pIjP2nRkfQAvUHdlcLYRe/bUfnZNpoQ4LQTaRuA1CvIEa8bZa+Ev3qy/ZNRj8X+hp9
         dDfGU6S2908MZNZtLJRpQjMWkhkFb11Nyq4Hz5Ti74MEYAtuhKLbuxyBG86YMi4YgCgx
         KV/IiaTJbJiQIFmh08ZFFQQcjS18TnizzNW1izbUM5OxFzTFUYoqCXViiR9DSr1DDSyx
         FuNy7+02m9d2Y/0NWmkma2QlPa3h2T0uWTm9A4sS4CmiHWyv5MTGVv9lEkct0eF5LGpU
         WJAGL0AbdALd2CkPf9sjwu9xkYmG+VidnhWjuu9vSZl4xmzEFt4xJokIgfRyMfmKUQ9h
         +cwg==
X-Gm-Message-State: AOAM531pE7+APA1LIkyGUjsXiund7tfy7vUJn6QVvNX6WOemRVLMHuoq
        /asZz9+l1c0aYz5SWM8Zr/FB5w==
X-Google-Smtp-Source: ABdhPJwMNB68/r/+Pn1Djk2McNP2tPUKyR/yeSAbMTRbuPvKKlWLlLS4F9/9jsYD8g4maRjcgs/p+Q==
X-Received: by 2002:a05:6402:3130:: with SMTP id dd16mr3250341edb.55.1598023085801;
        Fri, 21 Aug 2020 08:18:05 -0700 (PDT)
Received: from localhost.localdomain (223.60-242-81.adsl-dyn.isp.belgacom.be. [81.242.60.223])
        by smtp.gmail.com with ESMTPSA id qp16sm1482709ejb.89.2020.08.21.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:18:05 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mptcp@lists.01.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
Date:   Fri, 21 Aug 2020 17:15:38 +0200
Message-Id: <20200821151544.1211989-1-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously it was not possible to make a distinction between plain TCP
sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.

This patch series now enables a fine control of subflow sockets. In its
current state, it allows to put different sockopt on each subflow from a
same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
BPF programs.

It should also be the basis of exposing MPTCP-specific fields through BPF.

Nicolas Rybowski (3):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  mptcp: attach subflow socket to parent cgroup
  bpf: add 'bpf_mptcp_sock' structure and helper

 include/linux/bpf.h            | 33 ++++++++++++++++
 include/uapi/linux/bpf.h       | 14 +++++++
 kernel/bpf/verifier.c          | 30 ++++++++++++++
 net/core/filter.c              | 13 +++++-
 net/mptcp/Makefile             |  2 +
 net/mptcp/bpf.c                | 72 ++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c            | 27 +++++++++++++
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h | 14 +++++++
 9 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

-- 
2.28.0

