Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0802C3EBD
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 19:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfJARhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Oct 2019 13:37:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50240 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbfJARho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 13:37:44 -0400
Received: by mail-pg1-f202.google.com with SMTP id r24so9157352pgj.17
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2019 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3+w4QsZSJoLh853gBsFQX1yVGVE86OfZ0POYrmn9pHU=;
        b=EKLc4BdVvrOA881KZYHEn6ikBQGKo5TVuNhmnxKpZVyWpOn45UQ6LoQyiOxOx7L3hC
         mS3/3bAje8xM3gD1wCAsNpKY5mjWKNa/VF3Qz1Bo8Ds0b7JImYv9gPI1wlbKmTMvRO+D
         ZOOOMgU9Oxd/GpCEXArPBkf0RpH8/sef+NwED+gM8hTMZjtfLkPqU+AJ5jK6GwGQlksn
         2GoKJ8aD5hc1j3KTNEpy8xco2s657h+8msI8UttOH5kixwSEtJongK3rMLvzD7Bi2Hv1
         UKNLkTc9jNHtufNJdVoQbvS/KncrjsHzpTe/cFiSCYGEtTsz7GXG1ktsrtxbWC6kIT/8
         mAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3+w4QsZSJoLh853gBsFQX1yVGVE86OfZ0POYrmn9pHU=;
        b=XJ5emef6cQgSGOMCAW3fQOmOosjqZ+8Rl31xO7h3d9lb/hENvJwIp71Y3siz4AET/+
         u5zb63rGP3fmZJd91B6zRPEysJwSGQ2wQ0As7HA55bJDBIp2RqeJBCABxLVsYodBQv11
         F3SmNWiUVF8zFGCOQYh3acZLvCKglgyKFDYSlaeMDc87C+YG8GhJN+9BTjfVyYMpa07T
         OhXU8crjFNjxgi/Leb111aKKGwGDVnogrjVW0NK/ONOuHXlTVdCV0sJCLJUrA6y1zBEO
         z/8Fc3/MF8GDLarSqKktZsjcPi0zd0ZJglp603b/lQjgSEEI+Z+lqDz87kpuLHn/UKGv
         H7Fg==
X-Gm-Message-State: APjAAAXcZG3BSj7BS8VTa2+/i08pH1RATNhJYYb3fBOuP0zERu+kXT9D
        kn3xc7hLfvyyDjOcw2MTsEasm4vrK+wI
X-Google-Smtp-Source: APXvYqzh7leVxFKHdDQPmZYu3Us5x9qMqvVeWemq0AVPn1urC7cQbYSuTPtSo0OyKCw3z1h198Q2hecUAQG9
X-Received: by 2002:a63:4924:: with SMTP id w36mr15608050pga.113.1569951463622;
 Tue, 01 Oct 2019 10:37:43 -0700 (PDT)
Date:   Tue,  1 Oct 2019 10:37:26 -0700
Message-Id: <20191001173728.149786-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf 0/2] selftests/bpf: test_progs: don't leak fd in bpf
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series fixes some fd leaks in tcp_rtt and
test_sockopt_inherit bpf prof_tests.

Brian Vazquez (2):
  selftests/bpf: test_progs: don't leak server_fd in tcp_rtt
  selftests/bpf: test_progs: don't leak server_fd in
    test_sockopt_inherit

 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.23.0.444.g18eeb5a265-goog

