Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989FA5C215
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGARip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 13:38:45 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56004 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGARip (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 13:38:45 -0400
Received: by mail-qk1-f202.google.com with SMTP id p206so14171266qke.22
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VhhjU+dhc2OnLbXyOvN7JuheICcflJDik1TIim+dZiU=;
        b=gqzqkLs6EcPPRoDLF0WCI5WN8FUKzET91YJn+uqtYDD5c2adFZn5ddjgHiLSk9+Cr2
         MK5B4r7MCb5QgbfKqCnUjEX5jkT9EXfqcn+QJ+qOJwapISFbcLaJQfF5ejEknoJpasNu
         /55FR6O0AnIq1wvN6/aoUuCaqNTLdc/auhHlPwTg0J5sdAY53BckqCmG/xhVGSjF8yRw
         zm9nzaDZmKZUo622owtSikb3Edn/dXeN9+cIDpf5NNGIqpO7gMSgkXDbshIpyGVOoWY6
         hJilurWFIF+BdbO+j0FVYvvhIiR5ydoYcu3e/yGPtui14qBpelo+MnIig3tmmEgaHdTt
         w2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VhhjU+dhc2OnLbXyOvN7JuheICcflJDik1TIim+dZiU=;
        b=GCpPe/4LVQbjesYNnvlco7s8XE/9YmbCsVxIFscVBNLnIXDJv70hPNpJTmZnodjtPa
         RvVCpGUJpTRnHHiaMVIKK6oDYjWdqPawBa5PlG9GQkjd8gan969jF86/hLG/N751NBnA
         ONcNwKWZlNVNojqwTMPOAq70T2+CFfttXAbEYYJpalcG23REnkNd1AcnzccxifYsbI3C
         g5NKs7Ul7fBtY2SKacpMxBdbQ/noGJVKCMNJKMW4NnPXkAGG5KEgsVlKsAWXDrnE5UVK
         5MYTCVNMxLT6p/GUSwOo+aREnY/dfDchn7oVyrnHgtbLVrOBfKVZO+UXNV36I1uQnKBN
         tiQg==
X-Gm-Message-State: APjAAAUqm+IRcj30IudAR452sc1dMTyrfXeZPm0aXyfzjuUHHErX4rm1
        Nfy7pKs781PnNLfcquB+JL+CqAw=
X-Google-Smtp-Source: APXvYqw1qD9uArrWR3xNBdq2hEChF+GRTszxapDyqeex2RJtazRohxOS1lY3G1rkkfRn84bJfMX7yXo=
X-Received: by 2002:ac8:2b51:: with SMTP id 17mr21361241qtv.206.1562002724084;
 Mon, 01 Jul 2019 10:38:44 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:38:38 -0700
Message-Id: <20190701173841.32249-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v3 0/3] bpf: allow wide (u64) aligned stores for some
 fields of bpf_sock_addr
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clang can generate 8-byte stores for user_ip6 & msg_src_ip6,
let's support that on the verifier side.

v3:
* fix comments spelling an -> and (Andrii Nakryiko)

v2:
* Add simple cover letter (Yonghong Song)
* Update comments (Yonghong Song)
* Remove [4] selftests (Yonghong Song)

Stanislav Fomichev (3):
  bpf: allow wide (u64) aligned stores for some fields of bpf_sock_addr
  bpf: sync bpf.h to tools/
  selftests/bpf: add verifier tests for wide stores

 include/linux/filter.h                        |  6 ++++
 include/uapi/linux/bpf.h                      |  6 ++--
 net/core/filter.c                             | 22 +++++++-----
 tools/include/uapi/linux/bpf.h                |  6 ++--
 tools/testing/selftests/bpf/test_verifier.c   | 17 +++++++--
 .../selftests/bpf/verifier/wide_store.c       | 36 +++++++++++++++++++
 6 files changed, 76 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/wide_store.c

-- 
2.22.0.410.gd8fdbe21b5-goog
