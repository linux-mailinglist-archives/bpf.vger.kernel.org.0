Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71E229BAD
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbfEXQAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 12:00:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33577 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXP7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 11:59:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so10561319wrx.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTU8ZvQGukDYiT1iBEhaciWthxQj5tSMJzxivJb2X1g=;
        b=Co9GxXET5rTh0Gix9SpGtQXpoW7PfAsPOzE4RvtRidzZoKoaH/7aXuFpxXZqijZTW5
         VQpH43xlsRCoJpE3daQdOwG8owbA8EqUhSn/7bi+lnRdr5qbWDzXUo3qFT20Us01qhCy
         +OpZp4cOR2+U9YWVmhvXfDVQhLk8sgHXZ/OW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTU8ZvQGukDYiT1iBEhaciWthxQj5tSMJzxivJb2X1g=;
        b=ldUkXgsqJtrYuKU9JRFlRA8CX3f3Vumn3K3k/+I9+T7zOCRwqAmUJqOiMG9Q3KbFwz
         DXMIcSrND7dlu5YVTz2l3bRddRvIXvBLd0pRukLyuEkeBD8orGGS0cx2IQX9Vmttw7yr
         4uqgI6Kla7E36Gae14wzTUrfjEQy+A4qiE4ivRw20L/ZiMcIwCggHHOqlgr1zxQYY4aO
         /TZkQvtxRgKtrp7DNGn8G6bsAVH3Kn0zLZgYeyfCZCBbSB+lgDcrGQ82MkIsPn1u7Fm+
         reV+SvSW4ivdXaYtQQY096TeyMSqZNGueHFwqNsOI10Ds9ELDvvUKJcFG7iPaHE0S0ot
         J54w==
X-Gm-Message-State: APjAAAXRHs33BMa8NGNlBNn5W/Glb0xqDVk3zoozOsicTiVPmbDcwiXl
        GHrxk9ljcj1JX491WKFs/DUpew==
X-Google-Smtp-Source: APXvYqyA0nKVvtW4KzkZUeSSbuyLcKqJJfWlj5TiUYJ11BV86ItffK7JLzlBB5qMe/JE64Q0wWetkA==
X-Received: by 2002:adf:e408:: with SMTP id g8mr31393993wrm.143.1558713583663;
        Fri, 24 May 2019 08:59:43 -0700 (PDT)
Received: from locke-xps13.localdomain (69.pool85-58-237.dynamic.orange.es. [85.58.237.69])
        by smtp.gmail.com with ESMTPSA id i185sm4535054wmg.32.2019.05.24.08.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:59:42 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
Subject: [PATCH bpf-next v4 0/4] sock ops: add netns ino and dev in bpf context
Date:   Fri, 24 May 2019 17:59:27 +0200
Message-Id: <20190524155931.7946-1-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm taking over Alban's work on this.

This series allows sockops programs to access the network namespace
inode and device via (struct bpf_sock_ops)->netns_ino and ->netns_dev.
This can be useful to apply different policies on different network
namespaces.

In the unlikely case where network namespaces are not compiled in
(CONFIG_NET_NS=n), the verifier will generate code to return netns_dev
as usual and will return 0 for netns_ino.

The generated BPF bytecode for netns_ino is loading the correct
inode number at the time of execution.

However, the generated BPF bytecode for netns_dev is loading an
immediate value determined at BPF-load-time by looking at the
initial network namespace. In practice, this works because all netns
currently use the same virtual device. If this was to change, this
code would need to be updated too.

It also adds sockmap and verifier selftests to cover the new fields.

Partial reads work thanks to commit e2f7fc0ac69 ("bpf: fix undefined
behavior in narrow load handling").

v1 patchset can be found at:
https://lkml.org/lkml/2019/4/12/238

Changes since v1:
- add netns_dev (review from Alexei)
- tools/include/uapi/linux/bpf.h: update with netns_dev
- tools/testing/selftests/bpf/test_sockmap_kern.h: print debugs with
- This is a new selftest (review from Song)

v2 patchest can be found at:
https://lkml.org/lkml/2019/4/18/685

Changes since v2:
- replace __u64 by u64 in kernel code (review from Y Song)
- remove unneeded #else branch: program would be rejected in
  is_valid_access (review from Y Song)
- allow partial reads (<u64) (review from Y Song)
- standalone patch for the sync (requested by Y Song)
- update commitmsg to refer to netns_ino
- test partial reads on netns_dev (review from Y Song)
- split in two tests

v3 patchset can be found at:
https://lkml.org/lkml/2019/4/26/740

Changes since v3:
- return netns_dev unconditionally and set netns_ino to 0 if
  CONFIG_NET_NS is not enabled (review from Jakub Kicinski)
- use bpf_ctx_record_field_size and bpf_ctx_narrow_access_ok instead of
  manually deal with partial reads (review from Y Song)
- update commit message to reflect new code and remove note about
  partial reads since it was discussed in the review
- use bpf_ctx_range() and offsetofend()

Alban Crequy (4):
  bpf: sock ops: add netns ino and dev in bpf context
  bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
  selftests: bpf: read netns_ino from struct bpf_sock_ops
  selftests: bpf: verifier: read netns_dev and netns_ino from struct
    bpf_sock_ops

 include/uapi/linux/bpf.h                      |  2 +
 net/core/filter.c                             | 70 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 tools/testing/selftests/bpf/test_sockmap.c    | 38 +++++++++-
 .../testing/selftests/bpf/test_sockmap_kern.h | 22 ++++++
 .../testing/selftests/bpf/verifier/var_off.c  | 53 ++++++++++++++
 6 files changed, 184 insertions(+), 3 deletions(-)

-- 
2.21.0

