Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED53067EB
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhA0Xav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhA0X3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 18:29:36 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9FC0613D6
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:28:55 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b8so2257389qtr.18
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 15:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=aV8qow/FlZNu0c81xilee4C+KbHK/rtvK4HJqpkcS4A=;
        b=VCZP39zYXsZwenkBzMAEwnx+ULlIDbDyV9VqrO2RXlCODqfqoM8m+f2LuS8tbf7V6o
         XPmuce1SrV+D3Wuk3eV00rY3bi4ISIRmkUmjfButeyBCR1l+GToQDJyaUr/cpR2D04C4
         L5g5rv7IkxLVU5ZYR765RhqG6v7UPkX5aSZVOctk3vbfmFglMURMkeRyGdw2IgSHQN+r
         jEIAojqQd7q79xL/M65GyGVJePQSGJTo39wiviUkAm48pPI7PUjuxcFVqHCt8xnGSC3h
         t3guGwx4K0tnxlMREJAPaYgzpB3hitQxgrhCDkKtHbSuHYt5lhi/IQhgcXZUbzFZtSwl
         0KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=aV8qow/FlZNu0c81xilee4C+KbHK/rtvK4HJqpkcS4A=;
        b=tTfVv6CR0QUSJhLcgYJv/O3pjtlKEegKIWkYzw1lspOujqS/8Fct8t+w9vtBuiO3c/
         1tfxtJlIpe+TL96WPPaVF8w0GLkgKlzLHYbN+Q+gGDn1/ebgOW5yy1QrRtt48Tbzh4d5
         CTWhlxGAhMods2KIo4lPiWV/vctTMrHIW9Bun0v/sjVhl4GvejQIWBIMq3ZrFQokkmyX
         RjaP5647Ky35eLtyJ2TM02z7MTD+EAu1isiD3F7cPqUEOe4E/oQsC7M4MdKHrpFJYXgB
         4LgR2D3NH3xihN3S3lxIYoe/yjJsFohV1ztVjspwd7AfzSTYRMOLyPfPDo/PAztmnNRp
         xXpg==
X-Gm-Message-State: AOAM530uGEMn8M+9nbHXQuDvHVDfFp2feqVBPX5UKsXTZf83L8ZAg48K
        KvuGO/xSdE/qPzS7jD3ASdNR6Ig=
X-Google-Smtp-Source: ABdhPJz6V+ya64pFDx3wSNHefGAy0VN+OCOjr0JVgJ7jbCXMNtCj/yuI+U4WnwEEisUsYWxjq1gQmBU=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:ad4:53ab:: with SMTP id j11mr6120275qvv.1.1611790134978;
 Wed, 27 Jan 2021 15:28:54 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:28:49 -0800
Message-Id: <20210127232853.3753823-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH bpf-next v2 0/4] bpf: expose bpf_{g,s}etsockopt to more
 bpf_sock_addr hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We'd like to use the SENDMSG ones, Daniel suggested to
expose to more hooks while are here.

Stanislav Fomichev (4):
  bpf: enable bpf_{g,s}etsockopt in BPF_CGROUP_UDP{4,6}_SENDMSG
  bpf: enable bpf_{g,s}etsockopt in
    BPF_CGROUP_INET{4,6}_GET{PEER,SOCK}NAME
  selftests/bpf: rewrite readmsg{4,6} asm progs to c in test_sock_addr
  bpf: enable bpf_{g,s}etsockopt in BPF_CGROUP_UDP{4,6}_RECVMSG

 net/core/filter.c                             | 16 ++++
 .../selftests/bpf/bpf_sockopt_helpers.h       | 21 +++++
 .../selftests/bpf/progs/connect_force_port4.c |  8 ++
 .../selftests/bpf/progs/connect_force_port6.c |  8 ++
 .../selftests/bpf/progs/recvmsg4_prog.c       | 42 +++++++++
 .../selftests/bpf/progs/recvmsg6_prog.c       | 48 +++++++++++
 .../selftests/bpf/progs/sendmsg4_prog.c       |  7 ++
 .../selftests/bpf/progs/sendmsg6_prog.c       |  5 ++
 tools/testing/selftests/bpf/test_sock_addr.c  | 86 +++----------------
 9 files changed, 167 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_sockopt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg6_prog.c

-- 
2.30.0.280.ga3ce27912f-goog

