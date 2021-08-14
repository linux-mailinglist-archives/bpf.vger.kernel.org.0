Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F53EC068
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 06:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhHNE2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Aug 2021 00:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHNE2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Aug 2021 00:28:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E6C061757
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so18274443pjv.3
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98Zw1c+cW5zD1PWqvSDU2uTGAumLzHONU8NOH1AIF5I=;
        b=Q+n9F+W0iE4jTCL7Mvp/I7AUBl/CYg8DmsQPZ4i6rESsU+NiRwyMPe1ELQzycWiJ8T
         iggFvHBQbvcCOT6Sua9JJFxeOEd3LtZTdAKpsa4WRUlg7zpCdxLRuqsUlzrS6po9rGfz
         jXLRF2llxEaxYAf7qGq82p826zRhYLSXo7jzpsFzjGSRy9XakD7ilP5FAmc0ytA/or+0
         ayZMEL5jOexlgyz9V90nQKpWTqfag//EM49J8A25fBmcfop3KI74YPmFKqU9on4aARwR
         DwPvMrogbTwjkq67njC4A4Srh9Ct0YAM81FkIadcCcwJ3oOCwbuo0W1MCLLozxCTDrkG
         +0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98Zw1c+cW5zD1PWqvSDU2uTGAumLzHONU8NOH1AIF5I=;
        b=gXoeKTE77gQlf0L5DsbdThV5FLMfemZqzxcbsw8pcuaN9dYUDA0tPtTqfwNxa4ZkDP
         865pP4CsCV7BDUi57SQVZWwBuSs4fHSY/daGy/sOGu44AxUFBYYd8zGni7kDbJc2ZgOW
         6b7qC4V1AxnFm6r7OjxYqMy95zVGqAZKCx+NRWfq3waKSZX7HDvjRyhzY+9c9vPGX+qh
         Xjbq5vfnafMU14GmnVB0fUy7oaHIVmM5V0jOyNLIXySBPMRDfPAThlu0FI6redyOE4fK
         Jnt2onN6tXfWQfhkPnbhDo5wtfo1QVPNnqPckyF4Lz39PznQZ62J11mpvXbZwu8NBCqi
         /rNw==
X-Gm-Message-State: AOAM533WIcLkm/k/93gwqBbydju/BacBBn3+jXo4KXBVxfxzeTFUqOB2
        s0jYE2QJG4EzKtnTiolPn0FScg==
X-Google-Smtp-Source: ABdhPJy0AfUvyfScZ2ucRHa6sdvW6SPNRE1ZDCUTnaKBo7EpZklVX/JTPRSeVA0q0AspMMzlCRwnmA==
X-Received: by 2002:a62:5291:0:b029:397:6587:1af6 with SMTP id g139-20020a6252910000b029039765871af6mr5497726pfb.47.1628915282938;
        Fri, 13 Aug 2021 21:28:02 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id q21sm4420492pgk.71.2021.08.13.21.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 21:28:02 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rao Shoaib <rao.shoaib@oracle.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 0/5] sockmap: add sockmap support for unix stream socket
Date:   Sat, 14 Aug 2021 04:27:45 +0000
Message-Id: <20210814042754.3351268-1-jiang.wang@bytedance.com>
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
 net/unix/af_unix.c                            | 91 +++++++++++++++---
 net/unix/unix_bpf.c                           | 93 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++----
 4 files changed, 187 insertions(+), 53 deletions(-)

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

v4 -> v5 :
 - add two missing READ_ONCE for sk_prot.

v5 -> v6 :
 - fix READ_ONCE by reading to a local variable first.

For the series:

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

Also rebased on bpf-next
 
-- 
2.20.1

