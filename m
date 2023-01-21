Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB3676642
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjAUMmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Jan 2023 07:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAUMmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Jan 2023 07:42:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1D3018C
        for <bpf@vger.kernel.org>; Sat, 21 Jan 2023 04:42:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx13so20093321ejb.13
        for <bpf@vger.kernel.org>; Sat, 21 Jan 2023 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBiJih9FPAQXRMwCysKlJs26GOPs7+pj7DmA9XlYnmo=;
        b=WbEgwhmgwY9SwP1pEzmtfUQLMpcU6bbBfYSywRdQGmEK1DvWpxZ9PsglXIybLfYCtl
         Iv09x0+qzXSl89CBp22mWyR1898wIknzj1Q23n/SdQUi/538nqlJDgJgFoISC7b4jsyA
         ucWVJ49NDtWcNizmY2PIEZhnIZZgfdqbLv2dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBiJih9FPAQXRMwCysKlJs26GOPs7+pj7DmA9XlYnmo=;
        b=t8WPAqlDrtMnSVqrbq92GW0kFk88JIzSSZ7Fv3Ge9JQwU469KL0heF6ZheHVY5l4bH
         OY1DaquRywsi26v4GFUsK00wqVoiAOev1A118pWCWctRwKs5hYatOA3WNksFa4wAKRLh
         Da9CtevzztfrUvZgQ/1V4EE6GigAAzNIQ+e3MV3xM6b3+4ZI2vpK8bSmu9aKYViPCshg
         FQjlnFCYcNAvwGlqz8V7ZCB2w3S7x9jI4mCUfaIredu0jclOq5rzbc4c8u/CLJuRQDPh
         H1AbR1iSLjMDbev3qgcMz1buPqZexyc5NlNEWKCW3s83YtQ93gMRxLQNfr7TzGQw5v5z
         s1fA==
X-Gm-Message-State: AFqh2kocN4X/0A4V8i2ne/S8vhO9glJ3XtaM666s9s6gD/LjJZ9+PUQF
        x39Fw8gd+4lv83ISFIV8xnak4Q==
X-Google-Smtp-Source: AMrXdXtMKXOz5D9tyRLwid+dD/5b9HIIrz5yIH78joJSl5FfBd9ukmljUHbvRTHrn7sfQJK1lhvhlA==
X-Received: by 2002:a17:907:a2c6:b0:7c1:92b2:fa9e with SMTP id re6-20020a170907a2c600b007c192b2fa9emr19827014ejc.59.1674304924805;
        Sat, 21 Jan 2023 04:42:04 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id vw22-20020a170907059600b0084d43def70esm7765788ejb.25.2023.01.21.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 04:42:04 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf v2 0/4] bpf, sockmap: Fix infinite recursion in
 sock_map_close
Date:   Sat, 21 Jan 2023 13:41:42 +0100
Message-Id: <20230113-sockmap-fix-v2-0-1e0ee7ac2f90@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbdy2MC/22Nyw6CMBBFf4XM2jF9xCiu/A/Coo9BGktLWiEaw
 r87Ye3ynntvzgaVSqAK92aDQmuoIScO6tSAG016EgbPGZRQWkipsWb3msyMQ/jgTXuhLy0X9gr
 8sKYS2mKSG/mTlhgZzoV4eyg6sPMAPcMx1Hcu30O7yqP6a1glCvTaGS9aRSTFw8W8+CGaQmeXJ
 +j3ff8BhnJLYMUAAAA=
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com,
        syzbot+04c21ed96d861dccc5cd@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set addresses the syzbot report in [1].

Patch #1 has been suggested by Eric [2]. I extended it to cover the rest of
sock_map proto callbacks. Otherwise we would still overflow the stack.

Patch #2 contains the actual fix and bug analysis.
Patches #3 & #4 add coverage to selftests to trigger the bug.

[1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com/
[2] https://lore.kernel.org/all/CANn89iK2UN1FmdUcH12fv_xiZkv2G+Nskvmq7fG6aA_6VKRf6g@mail.gmail.com/

---
v1 -> v2:
v1: https://lore.kernel.org/r/20230113-sockmap-fix-v1-0-d3cad092ee10@cloudflare.com
[v1 didn't hit bpf@ ML by mistake]

 * pull in Eric's patch to protect against recursion loop bugs (Eric)
 * add a macro helper to check if pointer is inside a memory range (Eric)

---
Jakub Sitnicki (4):
      bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
      bpf, sockmap: Check for any of tcp_bpf_prots when cloning a listener
      selftests/bpf: Pass BPF skeleton to sockmap_listen ops tests
      selftests/bpf: Cover listener cloning with progs attached to sockmap

 include/linux/util_macros.h                        | 12 ++++
 net/core/sock_map.c                                | 61 ++++++++--------
 net/ipv4/tcp_bpf.c                                 |  4 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 81 +++++++++++++++++-----
 4 files changed, 111 insertions(+), 47 deletions(-)

