Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B376F2631CE
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgIIQ1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731141AbgIIQ1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4EC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:27:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so3025249wmi.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8N07NVYi5UYkKb3yp3FNFxrUHuP1+OyZDP7tDDSo8c=;
        b=YbEW63s5Fbc1ATUe2OH2j7PRTBPOkjgorqe2ay3u5gr+CkJHKNwYME87JlcKNTnnGF
         Z7iq1EAXB9/iYO+iz12BEX2t5ZSPV72k4qftgQm9leJpb2UqiVcx5oVawt0fnljQBreT
         xtMdt3IihjstIdIiyrV2yVmIFqinttATVAwlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8N07NVYi5UYkKb3yp3FNFxrUHuP1+OyZDP7tDDSo8c=;
        b=L9yCYF7Go9T3hHTjN6W4RnmxA1t9onUjPfpAgIgogm5mL2KqgZEaRW/cKsjbhZZtZn
         GaxzhsbXlQUy+MBxITCVXofDk8jMjsqj1aTqrCc5HDWARy+RQ5uFcP/6h74zQOUkZd6g
         jBrtjcTg7LrRRBGaaWInfOdu2Wc/CsdqyOhbUS+nYp2ui0X11olvEI4kb5IqbRaxqck/
         t9VznboT6u9yeV9rL0h9Aj58/TlXiWLErSVY0XSsmEF1q6nvhFAwlE9O3TGqyuX5cNnH
         20iDXvIcGR1ZEQA/7GH2duFfimonU+3hT7zp5uJ8VT/sjwtei/Zfu/JD48P5siTwURvd
         ArJQ==
X-Gm-Message-State: AOAM533X9NfnrQvqUhWZVhHXpfz+YaVGISHGKJbYSyeM5sFCBhTDKmPP
        cdcFlROcfmhxgUhAt9Bdpxq8lg==
X-Google-Smtp-Source: ABdhPJxdc6hHYHSXfuw1vyPlDLgN5OXVyAujj5OtcPEkl5h+I7xP6BxPNh6qwPoWJVwTdhMsdvEaXQ==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr4312232wme.136.1599668862883;
        Wed, 09 Sep 2020 09:27:42 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l16sm5644276wrb.70.2020.09.09.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:27:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v5 0/3] Sockmap iterator
Date:   Wed,  9 Sep 2020 17:27:09 +0100
Message-Id: <20200909162712.221874-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've decided to drop the changes that extend BTF pointers from this series.
They are a lot more work than I anticipated, and I don't want to hold
this up more.

The context for a sockmap / sockhash iterator contains the key, and a BTF
pointer to a socket. Iterating a sockmap will yield a NULL socket if the
slot in the array is empty. Iterating a hashmap will never yield a NULL
socket.

I'll add support to call map_update_elem from bpf_iter in a follow up to
this series.

Changes in v5:
- Drop pointer to struct sock shenanigans

Changes in v4:
- Alias struct sock* to PTR_TO_SOCK_COMMON instead of PTR_TO_SOCKET (Martin)

Changes in v3:
- Use PTR_TO_BTF_ID in iterator context (Yonghong, Martin)
- Use rcu_dereference instead of rcu_dereference_raw (Jakub)
- Fix various test nits (Jakub, Andrii)

Changes in v2:
- Remove unnecessary sk_fullsock checks (Jakub)
- Nits for test output (Jakub)
- Increase number of sockets in tests to 64 (Jakub)
- Handle ENOENT in tests (Jakub)
- Actually test SOCKHASH iteration (myself)
- Fix SOCKHASH iterator initialization (myself)

Lorenz Bauer (3):
  net: sockmap: Remove unnecessary sk_fullsock checks
  net: Allow iterating sockmap and sockhash
  selftests: bpf: Test iterating a sockmap

 net/core/sock_map.c                           | 284 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  89 ++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  43 +++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 +
 5 files changed, 424 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

-- 
2.25.1

