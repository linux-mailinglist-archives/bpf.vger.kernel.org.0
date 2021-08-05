Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540713E0D9A
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 07:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhHEFOJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 01:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhHEFOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 01:14:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38DC0613D5
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 22:13:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so5672592plg.8
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 22:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqSJLdzYBiQGMhcj1u7bHoXE7egAMmO44r4bYkCkGKo=;
        b=b+n1TkeAtCj+qnYZpSEJIylDr0/oSP6BMf41PPHp4DKcfq5gAveZNLRXKLvVQjxl0H
         fak7EC+x1IRv258amj8GvVwUebQE7Dy07PiG3TJCtt13Y8QJOctpOv8btT8xnftXZrNY
         6jzdzNxPD97BdT2Vk+3KwjrdYqkdPKSpt9nexc+c9viuk4T5rrduSQPN4PLse77zdoMb
         CHxh85YIQg2lbU9AobV+1T0OyvlgCOTuqUd7Abse5gY0FfxNrtZ2fzkSZtRjZ5FyXn0p
         0oBQPy18eCCsTgcMB/TPuG+0HPDgtD7Y0IXa/m+ncy1BAlX3oEE4K1RYzLdplmJpQ3ln
         mKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqSJLdzYBiQGMhcj1u7bHoXE7egAMmO44r4bYkCkGKo=;
        b=gYYiwjN81O0lehCIeodBeywbY3g2PrtWjECCj5DzhFyTVKTGS5H2lZXHzY23/ofD0x
         zLQrZH5ucDCnBwCFY+R43lzP1tFTzs61Zp3yz36Fz5cjtwlXTfQI85/3nqpz5k0nb7jr
         oE77nJZx8u8nXNj7KxLqROf5JohDGzm81imS4nGGFoHpHmrucckyhE5LbZDtmwFdVhtv
         Jvk0d1BHCdfjcDlDFAaF9yMdoypSTxxqX1z5+0o0iIUF/8d1zAY3bzUpPk7VIaDqGlIz
         uwrWSo0weuhes+GWgnq92crMrqEe5XIN2LUu42IT5o3jyFPAHkbmLzlM/jmIbOfRRaW6
         btqA==
X-Gm-Message-State: AOAM533WFLJeZYlu4+QnGpKDsa6AN/3rOyKK+prpJXgjF9YNRSWOjTSR
        88+N0RGUc/WEt9r7fNOtgToWzg==
X-Google-Smtp-Source: ABdhPJye6rJtRdEjpdsoDQRsQw0YueRo2rs1+kvIURi/KQkXOQWLZqz8KE3ILOQ4CwNjyYAY46/CoA==
X-Received: by 2002:a63:a1c:: with SMTP id 28mr1258262pgk.445.1628140434918;
        Wed, 04 Aug 2021 22:13:54 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k4sm4201098pjs.55.2021.08.04.22.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:13:54 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/5] sockmap: add sockmap support for unix stream socket
Date:   Thu,  5 Aug 2021 05:13:32 +0000
Message-Id: <20210805051340.3798543-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series add support for unix stream type
for sockmap. Sockmap already supports TCP, UDP,
unix dgram types. The unix stream support is similar
to unix dgram.

Also add selftests for unix stream type in sockmap tests.


Jiang Wang (5):
  af_unix: add read_sock for stream socket types
  af_unix: add unix_stream_proto for sockmap
  selftest/bpf: add tests for sockmap with unix stream type.
  selftest/bpf: change udp to inet in some function names
  selftest/bpf: add new tests in sockmap for unix stream to tcp.

 include/net/af_unix.h                         |  8 +-
 net/unix/af_unix.c                            | 86 ++++++++++++++---
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 4 files changed, 183 insertions(+), 52 deletions(-)

v1 -> v2 :
 - Call unhash in shutdown.
 - Clean up unix_create1 a bit.
 - Return -ENOTCONN if socket is not connected.

v2 -> v3 :
 - check for stream type in update_proto
 - remove intermediate variable in __unix_stream_recvmsg
 - fix compile warning in unix_stream_recvmsg

v3 -> v4 :
 - remove sk_is_unix_stream, just check TCP_ESTABLISHED for UNIX sockets.
 - add READ_ONCE in unix_dgram_recvmsg
 - remove type check in unix_stream_bpf_update_proto

-- 
2.20.1

