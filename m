Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE41E85032
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfHGPrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 11:47:24 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36128 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGPrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 11:47:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id a5so52701407pla.3
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FB7cYJl37GdYtFaxc/8cPlb39n5o+VtlMRz941XZmBs=;
        b=YYfYso7jj0Mt0nR7vmsPM8MVIm3znMDXfEARxHjBpImFO7k9Gr51Trr80tjEgKQq6t
         DXPZZxmH1K7ngOnSHFCwqrHwnyp7C+npwOR187yn4zinqHX7Z2bn4OjD1l386zK2kKer
         eKZHXMzb8U52EaJOQyXTfwtzIbFgHP2MLYriTXnPzUWovi3C+CCRIOp1Cw0jCjzrlB1Z
         wCq2JTl20CpFZtTMpUTH5QI8S88K+XwdOhwUa48H5gLLoJjlpDdC98zvcx4K/SIqF9Rh
         mfQG9pOMrCXJXvvf8RHFQMfV3bGLJaqJ6MNThk9HbAd2b2Z2bRhDZsijgUqE8q1m0bzU
         B3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FB7cYJl37GdYtFaxc/8cPlb39n5o+VtlMRz941XZmBs=;
        b=mpGhm3QHP13FhUWopAwB9WrT+0E847apc95EwEy8Q235l2/t2Noml/zIDkUjmDQ7WB
         mLNPeZWnGrtqQB09sBu6X0W0FnHAyjwJkNRrtD8Arm9VUOzs6oGC9724W3I84IsWsFme
         cYJ2rip25yasbHUgYLj8dwrMcSQ/4Tp9xCR2I1P03nvwn2khzTXk2N4JWqi55H8+GAvc
         CCHDq6Y6lL++ufY9HfF5KOYApVrfHYFUOrwxfpZoYtNGXJjlFEixmgpCFKrDLTC7i56q
         gqDgD+99mSBnfrefAR2sNVPWtx0cvsv3kHk6ScRQp3A6+PYFtQ83k7G7alyakzZZym0Z
         /PiA==
X-Gm-Message-State: APjAAAWEpyVPnwulsYYMd0jo3JKmBbirIYV1lg8be6QgwTwTmG771wtB
        fgLJ7Syjxrr3xMsLNnQorIXwBLM=
X-Google-Smtp-Source: APXvYqxOBipQ1nU/PK2ksfFxIR3S5nRdfHn+QDw0GR5JnLLwvqoTfG3AsFq82CUxRqQwIatZ+sLRSCI=
X-Received: by 2002:a65:4341:: with SMTP id k1mr8276047pgq.153.1565192842902;
 Wed, 07 Aug 2019 08:47:22 -0700 (PDT)
Date:   Wed,  7 Aug 2019 08:47:17 -0700
Message-Id: <20190807154720.260577-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next 0/3] bpf: support cloning sk storage on accept()
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently there is no way to propagate sk storage from the listener
socket to a newly accepted one. Consider the following use case:

        fd = socket();
        setsockopt(fd, SOL_IP, IP_TOS,...);
        /* ^^^ setsockopt BPF program triggers here and saves something
         * into sk storage of the listener.
         */
        listen(fd, ...);
        while (client = accept(fd)) {
                /* At this point all association between listener
                 * socket and newly accepted one is gone. New
                 * socket will not have any sk storage attached.
                 */
        }

Let's add new BPF_SK_STORAGE_GET_F_CLONE flag that can be passed to
bpf_sk_storage_get. This new flag indicates that that particular
bpf_sk_storage_elem should be cloned when the socket is cloned.

Cc: Martin KaFai Lau <kafai@fb.com>

Stanislav Fomichev (3):
  bpf: support cloning sk storage on accept()
  bpf: sync bpf.h to tools/
  selftests/bpf: add sockopt clone/inheritance test

 include/net/bpf_sk_storage.h                  |  10 +
 include/uapi/linux/bpf.h                      |   1 +
 net/core/bpf_sk_storage.c                     | 102 ++++++-
 net/core/sock.c                               |   9 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/progs/sockopt_inherit.c     | 102 +++++++
 .../selftests/bpf/test_sockopt_inherit.c      | 252 ++++++++++++++++++
 9 files changed, 473 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_inherit.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_inherit.c

-- 
2.22.0.770.g0f2c4a37fd-goog
