Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153C2FA5CF
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406477AbhARQPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406012AbhARP7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 10:59:50 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198BC0613CF
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:09 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id k67so4712526wmk.5
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D4HKQ9ve+LXBAweMKIFSbFpamqqEnWzLMG5X0/dA8Fo=;
        b=rtcYL5vlKu3VhOsCxnmJoAWjp4gHrbNQpG6XbXP8oSa+m26o9g0iVBh2l5yfw8yjmr
         sQ3qsZ9dz73Y1AGXK87kqF/gKEpMu7H6dEO6bVgRhZBeS9Ly7MyMmZHCmM4kfVe8gUSS
         pjHyD4/s9TcrJ8SA0nUswc9515PQkOPCbMP1w071cHiVq+bWb1lTLsYDA380KQtcSveG
         p7Sk4PkNk3GZ2gOQujsD8nWsyeMyFeFhrKzZVCPpCADHfZb1nMQK6NZImrw/o+bsba/K
         0xWAo24qdWWGzmkJOgIpZOZjvp7ENsGqFuSTUt1LbOqpnoK+hFgFu+MAH17WUoOkaK8M
         dluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D4HKQ9ve+LXBAweMKIFSbFpamqqEnWzLMG5X0/dA8Fo=;
        b=U0GjPIgCJoYdmZvkGh4omYxmrUYEXkXOj4iwgNMaJ+YinrDILuvWYmnUKBbvLyppB8
         MtLzbWKToM7q52jQqWHlTcWDku0MNBMfu6kdWMECMlPRFlpgN1a0Xpbe/eFXTlmSk1ey
         hFtqZlXOyd3WoFlz4U2SakI8kIE32D91eXcgPxE6Bj83DC4iTZVXxgCQyZh6nY98tlGV
         rub4ymiEp+8Yb690gKWhQOzEsesqcctF4nDXvEPDOxVFIRvhrozdWJw2qOuQ2Am00O4Z
         vnEExHn1Lo0U6aPOB8uepKKrcOnkF1zfeJmNwKR9lbYRTjcihFAY3cS9g5UoCTvQV8n/
         VY+A==
X-Gm-Message-State: AOAM532QDh2oojG0PNqNdJ3tnlf9NpVa8+M3U8vhD35up6V4JqoDrnyP
        Snve1axGerPJ9PFkcs6zNfkZwuqT+atgj/2imbDmNXkqSX0V2hs4ic/CuEUAr6+7QCjzCnqU/nB
        oDuXEfOV9HA3C3NIy4vHoK3Lv6cGfPTTpTPGxTg47CIfA0T90sKfrRwtX2IHy32E=
X-Google-Smtp-Source: ABdhPJzZa+eg/F4Yo6Vl/+ZRJLWtT7QkClHZxtgI+ifkMymW08QjfUb11pGeC9KQCX91kGOJCkmJJA1ySMQ0Wg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6000:1811:: with SMTP id
 m17mr142493wrh.67.1610985548197; Mon, 18 Jan 2021 07:59:08 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:57:34 +0000
In-Reply-To: <20210118155735.532663-1-jackmanb@google.com>
Message-Id: <20210118155735.532663-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20210118155735.532663-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v2 1/2] docs: bpf: Fixup atomics markup
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This fixues up the markup to fix a warning, be more consistent with
use of monospace, and use the correct .rst syntax for <em> (* instead
of _).

NB this conflicts with Lukas' patch at [1], which just fixes the
warning. The scope of this one is a little broader.

[1] https://lore.kernel.org/bpf/CA+i-1C3cEXqxcXfD4sibQfx+dtmmzvOzruhk8J5pAw3g5v=KgA@mail.gmail.com/T/#t

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index f6d8f90e9a56..4c2bb4c6364d 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1048,12 +1048,12 @@ Unlike classic BPF instruction set, eBPF has generic load/store operations::
 Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
 
 It also includes atomic operations, which use the immediate field for extra
-encoding.
+encoding::
 
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
-The basic atomic operations supported are:
+The basic atomic operations supported are::
 
     BPF_ADD
     BPF_AND
@@ -1066,12 +1066,12 @@ memory location addresed by ``dst_reg + off`` is atomically modified, with
 immediate, then these operations also overwrite ``src_reg`` with the
 value that was in memory before it was modified.
 
-The more special operations are:
+The more special operations are::
 
     BPF_XCHG
 
 This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
-off``.
+off``. ::
 
     BPF_CMPXCHG
 
@@ -1081,18 +1081,19 @@ before is loaded back to ``R0``.
 
 Note that 1 and 2 byte atomic operations are not supported.
 
-Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
+Except ``BPF_ADD`` *without* ``BPF_FETCH`` (for legacy reasons), all 4 byte
 atomic operations require alu32 mode. Clang enables this mode by default in
 architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
 ``-Xclang -target-feature -Xclang +alu32``.
 
-You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
-the exclusive-add operation encoded when the immediate field is zero.
+You may encounter ``BPF_XADD`` - this is a legacy name for ``BPF_ATOMIC``,
+referring to the exclusive-add operation encoded when the immediate field is
+zero.
 
-eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
+eBPF has one 16-byte instruction: ``BPF_LD | BPF_DW | BPF_IMM`` which consists
 of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
 instruction that loads 64-bit immediate value into a dst_reg.
-Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
+Classic BPF has similar instruction: ``BPF_LD | BPF_W | BPF_IMM`` which loads
 32-bit immediate value into a register.
 
 eBPF verifier
-- 
2.30.0.284.gd98b1dd5eaa7-goog

