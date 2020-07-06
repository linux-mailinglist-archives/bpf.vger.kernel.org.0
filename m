Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7902161C3
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 01:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGFXBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFXBb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 19:01:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD90C061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 16:01:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 13so15456040qkk.10
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zfjWJ6Kwfn0uVYtL+zJHmMiVSetjlcrktQ7Z2CR+TLw=;
        b=jsQXGmYdGz1XXDJ6DR6B6MSGIXnxDQzudZ1PQb4CYwATq0QpefcW0n5Qiz1J6xkGZp
         7W/dDwZHXObRsMfa5zhl7xttaAbzB8EwBs7tUZGDIrphEvuiAqAwUmlLo/dSLqIPv2g8
         z8CSJ5u5F6SwEg9k1G8V6EudiUiwQRb2srffPTVYdyvRthT4l61b1wXCvmOyY6cCxvkJ
         XZ0shoYnz1+1CyKu3j+OQFhCYFLOCA7epi4PHAXjzvjWvST4aFkmCa6ReRGWCgxxVdGl
         cNGdQU+nbhiyNFM3DF2Zls8Efkx/2Zx6cqXAT0CS+ld+UOMDGy+fMNYw0S76k1zTf1AS
         lcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zfjWJ6Kwfn0uVYtL+zJHmMiVSetjlcrktQ7Z2CR+TLw=;
        b=M2PxN+jd+UwmqJjY+/OYFQmOP508ehiCIeNZNDVNY8QBpihOF8Ei29sNHFRO9x7Kgd
         sfD4/Z8hoYLbcUjCZVTUuuWJ7DssChbxe0rm625DXwNcqWwkCzMkuT+naaNR0q/GDP2K
         qqV/lfhaDYDrfOHE2VvCUuzU9lfP1FQMB0ks3ajlZE1gL6DHEmrpN+VK96xq7GP3dc6r
         cJq+5fTNnBx+69ocm4uSDq7f28nQpOicq4Fwu1h7VQtbPfuL2VJd9sDJDXbNx5ia4Xta
         G3yp4viqgh706cMHQ+BGFmM1EAeJaP8myzq9N1gpD6NL/uCqFtSI7W1bQnXEXbuceGc5
         yRVA==
X-Gm-Message-State: AOAM530GZ5+OOS17Ixa2j/Pbyb/tOSkudZhR2t6dgsxtcocNyb2725GJ
        8lX12uo+3j0i6yBYoFW9+0OqGeU=
X-Google-Smtp-Source: ABdhPJxmFW+V4kCByhY3xRy3EjvLT7oS2yjf5u9n4aXpfm0+SrhHDB57xuzQrylcU3o5ta/sIjw0vqo=
X-Received: by 2002:a0c:f281:: with SMTP id k1mr44316612qvl.219.1594076490419;
 Mon, 06 Jul 2020 16:01:30 -0700 (PDT)
Date:   Mon,  6 Jul 2020 16:01:24 -0700
Message-Id: <20200706230128.4073544-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v4 0/4] bpf: add BPF_CGROUP_INET_SOCK_RELEASE hook
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

v4:
* initialize global BPF vars (Andrii Nakryiko)
* simplify error handling (Andrii Nakryiko)

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

 include/linux/bpf-cgroup.h                    |  4 +
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          |  3 +
 net/core/filter.c                             |  1 +
 net/ipv4/af_inet.c                            |  3 +
 tools/bpf/bpftool/common.c                    |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/libbpf.c                        |  4 +
 .../selftests/bpf/prog_tests/udp_limit.c      | 75 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/udp_limit.c | 42 +++++++++++
 10 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/udp_limit.c
 create mode 100644 tools/testing/selftests/bpf/progs/udp_limit.c

-- 
2.27.0.212.ge8ba1cc988-goog
