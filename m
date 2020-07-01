Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C4211414
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGAUNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgGAUNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:13:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B1C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 13:13:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9so26628856ybm.20
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v6dVb+t5YtMhhe8MxWPTY495SB+nxeaD+wVMCzdQ9nA=;
        b=bJe4miMmZpbTJsCfJuPoEUU1JE27OLDDaK5QvjiDa/4iP/QGYH1CdgxrZ46Cb04EBZ
         nbQwgsZ6yye193TqKeUaJy6fYN3QhMdh5xZP4aUA6Hqp+EeFg5iFI2chbrdASirjIo5w
         EBM5sXsGXRrohx51+zQuEzdXV5vvEoC964dXiOSywJhAeO3dXzXORjC2XhYQuMG+Ea8W
         BNAwQ9kfABBnyvZKX/pQpPO3OLa7DWYpa+1pgXdKP13PS7JJEecBaEgKY73UMmMMyHfo
         oAlBaqxGNZ0H/W29yJTTP65fOtz2hrTCUBQCdgzfzyC55HQDpoqKOgiz5JbC9+w2KScy
         /GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v6dVb+t5YtMhhe8MxWPTY495SB+nxeaD+wVMCzdQ9nA=;
        b=MXtFMv1dBs4GkdxubVtzawOfW/vE2TOEn5dvaooYymLojaEEvaxYGULonqlHYAp5Vq
         G3Xyndx4bj1UGm21pjLVXe2sR62xcmFHRXVjIoByYgIswW4jrGWn5olm1OrsrzExYsbh
         Ld0H6yf3yGQNVauRhAOtCCUe+aTLRmR3+hcQt+knlDDYruf/zHXlHTIRYWGKbxvF1wo3
         nwd/7JEEbSy26mKQ+Rh1orNiH9ygZ0Y3lV+E+G1i975uQK1WDmEwdLeIwIuRaKM8P7oC
         VlVw2V18WNzoDQpHxQ33kog5P43dwtNPrxPR2BZcBhS6975r0Q+bSKHdxLZwDaNMhoei
         yvnQ==
X-Gm-Message-State: AOAM533UYqzVbcmS8aGcRz/iTutSA3dK8LuewjaivzV8waId50B1Eflj
        2uDcX+bIv9g5RLSEajfBvuaZagY=
X-Google-Smtp-Source: ABdhPJxj95U0PSjUNE1OcP64ka8AMqly/AwfeUjPpTQxpnHwkWtpN63hV6iSt3AgGZT78m7oRSUdgSs=
X-Received: by 2002:a25:2d63:: with SMTP id s35mr45473807ybe.367.1593634389333;
 Wed, 01 Jul 2020 13:13:09 -0700 (PDT)
Date:   Wed,  1 Jul 2020 13:13:03 -0700
Message-Id: <20200701201307.855717-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v3 0/4] bpf: add BPF_CGROUP_INET_SOCK_RELEASE hook
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sometimes it's handy to know when the socket gets freed.
In particular, we'd like to try to use a smarter allocation
of ports for bpf_bind and explore the possibility of
limiting the number of SOCK_DGRAM sockets the process can have.

There is already existing BPF_CGROUP_INET_SOCK_CREATE hook
that triggers upon socket creation; let's add new hook
(BPF_CGROUP_INET_SOCK_RELEASE) that triggers on socket release.

v3:
* s/CHECK_FAIL/CHECK/ (Andrii Nakryiko)
* s/bpf_prog_attach/bpf_program__attach_cgroup/ (Andrii Nakryiko)
* fix &in_use in BPF program (Andrii Nakryiko)

v2:
* fix compile issue with CONFIG_CGROUP_BPF=n (kernel test robot)

Stanislav Fomichev (4):
  bpf: add BPF_CGROUP_INET_SOCK_RELEASE hook
  libbpf: add support for BPF_CGROUP_INET_SOCK_RELEASE
  bpftool: add support for BPF_CGROUP_INET_SOCK_RELEASE
  selftests/bpf: test BPF_CGROUP_INET_SOCK_RELEASE

 include/linux/bpf-cgroup.h                    |  4 ++
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          |  3 +
 net/core/filter.c                             |  1 +
 net/ipv4/af_inet.c                            |  3 +
 tools/bpf/bpftool/common.c                    |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/libbpf.c                        |  4 ++
 .../selftests/bpf/prog_tests/udp_limit.c      | 72 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/udp_limit.c | 42 +++++++++++
 10 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/udp_limit.c
 create mode 100644 tools/testing/selftests/bpf/progs/udp_limit.c

-- 
2.27.0.212.ge8ba1cc988-goog
