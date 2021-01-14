Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1C2F6954
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhANSTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbhANSTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:45 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504AAC0617A4
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:32 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u14so2963116wrr.15
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=ejJx5SL1fxsjwfzzDNBu77jDzM3gbctXjuLEXIC3R0xMOGwoQYZOxS2JvSgYX0pkXg
         BXiXTH+qpyB2ubLuXMn8VO3P+2XHRd9MeE137iyXchQPCm847DnT3AJKSiy4uwQZ1UI8
         /Oc42tfCquYcp6sSW1If1t/HCdJA7h3Gflnw6EUDdo7t143KiehHYxwe9nJFVVMHJXIh
         V+h2JlzkAPAv+oDLUuRfL8H5N0x6CITgrNe7LQHEkdrh2qnu3ClCFI1R9cWo03OVfRPi
         muOfMn91THVE3jIZYdDlfpEEhfp5VUSXNRxf71aaJC0BGfUQP/EREaKjqRXlydjOrFBP
         mGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=VEI/rEo6/2GsPygy9Fo7Jw9IZNi+NNkgmuxPPyDgAtVezhxdoBict6Cv+kuhfgtTP1
         NbtJqfGCf75MB+xY3jSHhp7eJ05KZ/k8mza5HqCpauzgFCd2RiiQarE7A3j/ZJ4ah07m
         7WOITHVlSC2S7G72u1ubqKuDw74Lv+x/sc8RgEUkEKHEe4UzztHowlbiD8QBaV/8xxic
         GJ+1QGg5qMB8IjO6SsGSpn4/eUlocOek7zwPkLfdHbpsJdye1dMNCpoi9fWK9oVgz5uK
         7NBltKFvbVEBBQVHO4bAYE5a4RkoaITvx42szAW0c83V+JRVbkvYMzUegzu64hbGjeqs
         BQzg==
X-Gm-Message-State: AOAM533lD6h2S7lIFOACmJEan0J/K1ybAn8xi9rabKPlGZdbVjHP782a
        2VPgHUaqlnURl46mwDAMKrsfRzwUbFMLhmx7d4vU6y+dCgL4rQ2ikTXXdxoM9u3Ik8eZ25yjMYP
        nxRLnoqMVc4QE5A9H2Rq4a0+RhwBaZXWTjJFfxx8f67wLiJ+pBU7EL5ZoDKABN08=
X-Google-Smtp-Source: ABdhPJwIi3mz/1SY+6oE7+tGQR4TG4Ys8wjpCeHeJPoKZHE0TxLj8pwGF4emyEHgJecZi38QdAkxaELMDCwY1w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:decd:: with SMTP id
 i13mr4665456wrn.144.1610648310534; Thu, 14 Jan 2021 10:18:30 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:51 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 11/11] bpf: Document new atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document new atomic instructions.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1583d59d806d..f6d8f90e9a56 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1053,8 +1053,39 @@ encoding.
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
+The basic atomic operations supported are:
+
+    BPF_ADD
+    BPF_AND
+    BPF_OR
+    BPF_XOR
+
+Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
+memory location addresed by ``dst_reg + off`` is atomically modified, with
+``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
+immediate, then these operations also overwrite ``src_reg`` with the
+value that was in memory before it was modified.
+
+The more special operations are:
+
+    BPF_XCHG
+
+This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
+off``.
+
+    BPF_CMPXCHG
+
+This atomically compares the value addressed by ``dst_reg + off`` with
+``R0``. If they match it is replaced with ``src_reg``, The value that was there
+before is loaded back to ``R0``.
+
 Note that 1 and 2 byte atomic operations are not supported.
 
+Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
+atomic operations require alu32 mode. Clang enables this mode by default in
+architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
+``-Xclang -target-feature -Xclang +alu32``.
+
 You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
 the exclusive-add operation encoded when the immediate field is zero.
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

