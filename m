Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FF5C11C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGAQbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 12:31:06 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54481 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfGAQbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 12:31:06 -0400
Received: by mail-vk1-f201.google.com with SMTP id w137so3660829vkd.21
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Hpk2/HOQHvfBVy9PRqwSIyvQNicnJjMAmm/xrZF8TLY=;
        b=nQV1jzz67Ra7/sE4GMgvu4vle7yKaa+RoY7+C/wvdCMMGfDafqJ0SvSaUNPPOVrZnQ
         M4ARhJpo1XokggAYW7ZPHOdIFeSO091+H6nbxoED3GFNuSWOBkEzTANPdBCWv36t2BK1
         EqrqESUrVC6TcVsPHopKcoxg2e1hVKfOhfNSRQgk5QhEvmobcuRRD910Hdtlxg3f9hj6
         kMiuhC7VFzmq/kIokZYIvYYPWB7HTDLltwdoJNXigZPzvUkq9QkOoP8zr75rCtGHHv+9
         0nniR0Qva7c9BGycCcwkKgikHe5jGs6lpavHE9VMA6JfJq6pZ3YKx/QDc7ARIY/uPTjk
         MA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Hpk2/HOQHvfBVy9PRqwSIyvQNicnJjMAmm/xrZF8TLY=;
        b=T0OXqoQEpmGiG+bwMwRsvBbz1xXbuYb1P5KzzxYMMt0/5QQZjB1ebmoeZ7Nqlh09V7
         3JerHs4EB8sTFMlN4+cRuf9ikOpxNZJRam13FAy2OkDw2v66sL1sLwxpV9MVnli+WWHl
         xBtuOMyCcbC+mL/rH7CswYXxV2hWg/fuwr2lVgT29X2IS41f0RlpL3/tvVpnjV0574ee
         ZT5UTIvLOb8kM/7dA7r162NlDOwhFSImBDkZMdP2oAWZaHF13BL1Kg8l6bqn50DmXjPO
         3h4sLpAVIHh24/oEWwtklvacmWRjIrNdK5AC7+mcLw4q/DdRDZSzCLPDJ/YpQGCVwgD7
         H1kQ==
X-Gm-Message-State: APjAAAUtMl86SpCm1x6UFBTz/CKD/veDxRKWk9VSTCwpqvT/Tv0jAHDM
        Ppq3xKa77dw3KBJWtlBJKvbOzh0=
X-Google-Smtp-Source: APXvYqzak49YiI/f5chbYe5zglmIxd9QJKqUV/71MhqZQTxuui9yCSsgFUqi5HwQ6EiNu/OtDVWLQ84=
X-Received: by 2002:a1f:a494:: with SMTP id n142mr8582411vke.49.1561998665373;
 Mon, 01 Jul 2019 09:31:05 -0700 (PDT)
Date:   Mon,  1 Jul 2019 09:31:00 -0700
Message-Id: <20190701163103.237550-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v2 0/3] bpf: allow wide (u64) aligned stores for some
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

v2:
* Add simple cover letter (Yonghong Song)
* Update comments (Yonghong Song)
* Remove [4] selftests (Yonghong Song)

Stanislav Fomichev (3):
  bpf: allow wide (u64) aligned stores for some fields of bpf_sock_addr
  bpf: sync bpf.h to tools/
  selftests/bpf: add verifier tests for wide stores

 include/linux/filter.h                        |  6 ++++
 include/uapi/linux/bpf.h                      |  4 +--
 net/core/filter.c                             | 22 +++++++-----
 tools/include/uapi/linux/bpf.h                |  4 +--
 tools/testing/selftests/bpf/test_verifier.c   | 17 +++++++--
 .../selftests/bpf/verifier/wide_store.c       | 36 +++++++++++++++++++
 6 files changed, 74 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/wide_store.c

-- 
2.22.0.410.gd8fdbe21b5-goog
