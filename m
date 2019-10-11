Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6DD3B1D
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfJKI3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 04:29:52 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38303 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJKI3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 04:29:51 -0400
Received: by mail-lj1-f171.google.com with SMTP id b20so8956221ljj.5
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nmdN7JMNTYscQBNR+E6gnmp9TFuIjTpURDuQtDu+M4=;
        b=n7u2TRWNa8qxxSFP1TwtwI0Su6xhZ9xX4XDfCGGz4usGI1NpGKzsW/FtgucGHfwI1y
         3yGfl/HTCTBxHRyrvDJ5P0Wi9gTlNvzFotCMy4wtAmZqSYSNPqZSu61DCYzgkKXwjToO
         Db8LZXHEosk7MaGKGE6M0FPVPNlNKLiH/0yzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nmdN7JMNTYscQBNR+E6gnmp9TFuIjTpURDuQtDu+M4=;
        b=nH6aD40/nM4jz/JdoqASI4KTqlbKsHHB47sDHKqGpebEb2MSdFuWH6fyg9YJsaS4ky
         NV3nmu5ayqcD1LIRT6eom8v5xELXgsJOPOzwAi7OlVX9cd/W67l5u/8Ef3R19EsophOZ
         DHfCSrlSWjVqHF0HzFYn4ZW4jzlMltfXxdpZewovZEzTyiDzHqQjjU0QVw/82gvOsQ4B
         W2L+/gsE2Z1inxiqlMH0M+/b8Ju4VXwtoEhtkhgy5bgnnApgyQThMdwpRSrF8kMmEJdN
         J4GY9SZWLQqXQ4xaILik6oZHMqooHuSRrsakYx+hlWz0VfwvXGH/CMTthlzLh1WR9Wc4
         Lyfw==
X-Gm-Message-State: APjAAAVkB3ro/0Cu8uh3/LP24ehpokFGemNiTZjyI8q4T9ONPF8mAHH9
        hxhQmUXduLURa5Una5cMKxkMOy4QIFw4lQ==
X-Google-Smtp-Source: APXvYqyCnKNdd5sWBsH5XbyhBusHqKTGyY1Y7HhI2kSe5CnqmCRvFgD/hycIF5bzYsMHzU17/phdow==
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr7906155ljl.126.1570782587831;
        Fri, 11 Oct 2019 01:29:47 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h25sm2240656lfj.81.2019.10.11.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:29:47 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next v3 0/2] Atomic flow dissector updates
Date:   Fri, 11 Oct 2019 10:29:44 +0200
Message-Id: <20191011082946.22695-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set changes how bpf(BPF_PROG_ATTACH) operates on flow dissector
hook when there is already a program attached. After this change the user
is allowed to update the program in a single syscall. Please see the first
patch for rationale.

v1 -> v2:

- Don't use CHECK macro which expects BPF program run duration, which we
  don't track in attach/detach tests. Suggested by Stanislav Fomichev.

- Test re-attaching flow dissector in both root and non-root network
  namespace. Suggested by Stanislav Fomichev.

v2 -> v3:

- Rebased onto recent bpf-next 63098555cfe0 ("Merge branch
  'bpf-romap-known-scalars'").


Jakub Sitnicki (2):
  flow_dissector: Allow updating the flow dissector program atomically
  selftests/bpf: Check that flow dissector can be re-attached

 net/core/flow_dissector.c                     |  10 +-
 .../bpf/prog_tests/flow_dissector_reattach.c  | 127 ++++++++++++++++++
 2 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c

-- 
2.20.1

