Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA06EA1D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfGSRbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38181 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGSRbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so23811807qkk.5
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+Qb0POuR4wN23lP6vdZxirzjkMGnzcMXuS8+eCatfw=;
        b=QL9FQS4OGOTKWXL/tOuUyxohZvIcbQU8c/d0K7SnHSoW+yrFdBrBsI62/THEp/uzbZ
         idRTIO8wiDY1Llj1ScYUZediKCbhOSPlPZq9lSYJs2hJe1RiiQxf1J3OkR0v5xthdH3t
         4EZ3W8uhtMvcDrONZU3AXCminmf/8oMTRzOVjXkmYnQSQLVicDZSDnw4r3FfTElVdlQK
         mm4/Ea6CATBZ8ObvxswBvc8ENZ91iyn7FPLcOA0PPqHwDhy6ORK7dgzjBJlolgvMU7HG
         RFM721/56ePRC5QOo3+LTrNAg0JY/RSwMJ8MRtJQFg9+Y8xVYyki1X8aexWwLGNGXveA
         s5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+Qb0POuR4wN23lP6vdZxirzjkMGnzcMXuS8+eCatfw=;
        b=LcJvmu+RB01LqWWR/2GgoBM/xG2b4r+mCQYbVTJPLsOL893NF6LUHaAdVGsQjI5sJ6
         eHaqfBHooSEJeRviHrmCqrImedzvAJe8laP42Nb7BQKEuarSSLRVaRru3N/d3xGJ9Pcv
         +3k80oOoMDg9FmFXLgpL5ZbNyPWupeFHgrOFyuCMqb3sV9jE+P+CCFviR3itEVWIv3ex
         8UnZfd0ZCLcw04oomHiWV8p68oINIXreeF6FNi/Ie9cicbHz5eIQRNoiG9K7I1xkpAjJ
         TZJmv4p0ObxvhRzzeC8nAX1PBWrBb3SPm29L+4ISW4SZubKcFxwVVQcW7Nzy72WuhWj1
         U3PQ==
X-Gm-Message-State: APjAAAXNvAehr6eOaZ0NLHg6OAr6xRLPRzjqYKn55tAbJc4OxDVx/leK
        6l1PhuPjPUTRZd1tGVS9PzFcRw==
X-Google-Smtp-Source: APXvYqzZ+nUNXO3agCi1x3WJEjfyZzXZPSTNwuhfk8AFcsBFuO8gFLRkSHLq3Z6BeFOzgJTvU47JMQ==
X-Received: by 2002:a37:aa04:: with SMTP id t4mr36141162qke.359.1563557460706;
        Fri, 19 Jul 2019 10:31:00 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:30:59 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf v4 00/14] sockmap/tls fixes
Date:   Fri, 19 Jul 2019 10:29:13 -0700
Message-Id: <20190719172927.18181-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John says:

Resolve a series of splats discovered by syzbot and an unhash
TLS issue noted by Eric Dumazet.

The main issues revolved around interaction between TLS and
sockmap tear down. TLS and sockmap could both reset sk->prot
ops creating a condition where a close or unhash op could be
called forever. A rare race condition resulting from a missing
rcu sync operation was causing a use after free. Then on the
TLS side dropping the sock lock and re-acquiring it during the
close op could hang. Finally, sockmap must be deployed before
tls for current stack assumptions to be met. This is enforced
now. A feature series can enable it.

To fix this first refactor TLS code so the lock is held for the
entire teardown operation. Then add an unhash callback to ensure
TLS can not transition from ESTABLISHED to LISTEN state. This
transition is a similar bug to the one found and fixed previously
in sockmap. Then apply three fixes to sockmap to fix up races
on tear down around map free and close. Finally, if sockmap
is destroyed before TLS we add a new ULP op update to inform
the TLS stack it should not call sockmap ops. This last one
appears to be the most commonly found issue from syzbot.

v4:
 - fix some use after frees;
 - disable disconnect work for offload (ctx lifetime is much
   more complex);
 - remove some of the dead code which made it hard to understand
   (for me) that things work correctly (e.g. the checks TLS is
   the top ULP);
 - add selftets.

Jakub Kicinski (7):
  net/tls: don't arm strparser immediately in tls_set_sw_offload()
  net/tls: don't call tls_sk_proto_close for hw record offload
  selftests/tls: add a test for ULP but no keys
  selftests/tls: test error codes around TLS ULP installation
  selftests/tls: add a bidirectional test
  selftests/tls: close the socket with open record
  selftests/tls: add shutdown tests

John Fastabend (7):
  net/tls: remove close callback sock unlock/lock around TX work flush
  net/tls: remove sock unlock/lock around strp_done()
  net/tls: fix transition through disconnect with close
  bpf: sockmap, sock_map_delete needs to use xchg
  bpf: sockmap, synchronize_rcu before free'ing map
  bpf: sockmap, only create entry if ulp is not already enabled
  bpf: sockmap/tls, close can race with map free

 Documentation/networking/tls-offload.rst |   6 +
 include/linux/skmsg.h                    |   8 +-
 include/net/tcp.h                        |   3 +
 include/net/tls.h                        |  15 +-
 net/core/skmsg.c                         |   4 +-
 net/core/sock_map.c                      |  19 ++-
 net/ipv4/tcp_ulp.c                       |  13 ++
 net/tls/tls_main.c                       | 142 +++++++++++++----
 net/tls/tls_sw.c                         |  83 +++++++---
 tools/testing/selftests/net/tls.c        | 194 +++++++++++++++++++++++
 10 files changed, 419 insertions(+), 68 deletions(-)

-- 
2.21.0

