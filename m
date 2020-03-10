Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC70918054C
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCJRr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 13:47:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50997 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJRr1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so2412877wmb.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sm+RIRurvpUkZS4E9RanRJ73By12BSdauAG4RhCW2E=;
        b=ELH/Ip42uVvbWA/BFPyev/SEzJ7NL+KX3fygBRqkiQ066qcqNWyAZ+KMX3pEg75x5Q
         +4ZXjXW6Bpeth+O38LDEePB4XtPzPoTPLC1+LT16ZWA4zZ26uXFW7MMiFmyURGGteFTT
         xOiezu4IdZXkwgOdWbXkd1RLCqTldD2Pg5NLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sm+RIRurvpUkZS4E9RanRJ73By12BSdauAG4RhCW2E=;
        b=dnC5cjVk75FBjIrYTTnZBTxFdJC3SXuyyWH2ViyFHFyNExXNY+K104dORtA8MqS1Jr
         OAm6wDyJ9yQUuO/s64w53461aLfWEZDY3wQbAk0aODF0ehzStk1UKsr0Ot049QCBX/Jm
         +0yg7u9lssZLdlmp1Kp5L0/L5wsuza0z6L7VD3lBDml+4pKhQ5Uo1hqb9Q+vBJarpdmf
         jYCLZgR4CACUiO0819Gc/uRojs7H4WbvPcwaqmcFvwKxR8E7kTLY3bbTUB/J/Yaq0GR9
         gJTK8vumdCv1bP+pWjECflTSfhuIycbnr8iuL7yp7qs0K08vJwfSuWi29s8k3v6sFC1m
         SCjA==
X-Gm-Message-State: ANhLgQ2xa9tr/IqiQP5HpZEocb1sPYXXPbUcQvjHyCa2Og+VO6jG2F/T
        D2/t+ZWj1JDlbRFNN96A9Exq8A==
X-Google-Smtp-Source: ADFU+vs8TqAcr4yKNiomhYgviN9AM/t3RXh3yhHz2b7lpnJHfqzi4c0bzjtVoadm3ocM19TIq9w9Nw==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr3257771wmb.58.1583862445878;
        Tue, 10 Mar 2020 10:47:25 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:9494:775c:e7b6:e690])
        by smtp.gmail.com with ESMTPSA id k4sm9118691wrx.27.2020.03.10.10.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:47:25 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 0/5] Return fds from privileged sockhash/sockmap lookup
Date:   Tue, 10 Mar 2020 17:47:06 +0000
Message-Id: <20200310174711.7490-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We want to use sockhash and sockmap to build the control plane for
our upcoming BPF socket dispatch work. We realised that it's
difficult to resize or otherwise rebuild these maps if needed,
because there is no way to get at their contents. This patch set
allows a privileged user to retrieve fds from these map types,
which removes this obstacle.

The approach here is different than that of program arrays and
nested maps, which return an ID that can be turned into an fd
using the BPF_*_GET_FD_BY_ID syscall. Sockets have IDs in the
form of cookies, however there seems to be no way to go from
a socket cookie to struct socket or struct file. Hence we
return an fd directly.

If unprivileged access is desired, the user can create the map
with value_size = 8, which makes lookup return the socket
cookie. It would be nicer if this behaviour was controllable at
the time of calling bpf_map_lookup_elem, but I've not found
a good solution for this.

Patches 1-3 do a bit of clean up, but I'm happy to drop them
if they don't make sense. Patch 4-5 are the interesting bit.

Lorenz Bauer (5):
  bpf: add map_copy_value hook
  bpf: convert queue and stack map to map_copy_value
  bpf: convert sock map and hash to map_copy_value
  bpf: sockmap, sockhash: return file descriptors from privileged lookup
  bpf: sockmap, sockhash: test looking up fds

 include/linux/bpf-cgroup.h                    |  5 --
 include/linux/bpf.h                           | 21 +-----
 include/linux/bpf_types.h                     |  2 +-
 kernel/bpf/arraymap.c                         | 13 +++-
 kernel/bpf/bpf_struct_ops.c                   |  7 +-
 kernel/bpf/hashtab.c                          | 10 ++-
 kernel/bpf/local_storage.c                    | 14 +++-
 kernel/bpf/queue_stack_maps.c                 | 18 +++++
 kernel/bpf/reuseport_array.c                  |  5 +-
 kernel/bpf/syscall.c                          | 23 +------
 net/core/sock_map.c                           | 67 ++++++++++++++-----
 .../selftests/bpf/prog_tests/sockmap_listen.c | 26 +++++--
 12 files changed, 130 insertions(+), 81 deletions(-)

-- 
2.20.1

