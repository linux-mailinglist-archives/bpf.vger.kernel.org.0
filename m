Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297D82FAAA8
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 20:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437384AbhARTxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390389AbhARLhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 06:37:39 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D77C061575
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 03:36:58 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id o17so8154666wra.8
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 03:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7VlZADSbyrVyyYmUXQ30hZbrflrNZLEBF2PfK5aqyNc=;
        b=dtoGcWzQToR89vu/K7XereUaEEAYu9I1Ky5pNZFzRMGMG1COV6q9Zs0hqEtH0Edm4r
         C88R7SYMAEkbu+moMRWXH1xf72Pzw4MLEp4DLH0ABlKbhkQ31cMTzhmqQqYMVDfM05cd
         1efL7+7UnXGSuvW7r6q0RhTzF2tvLttIiYwbtUfO5eAE+rij0iOyN+Bs6zyoA+79B63L
         SOHp+ZnsA+4XsSyL+5pbaOJ0OoKxMBY6ySwt5MXJlWduo46bvS1xUxcB2VnoHGABQGhK
         86yr5+9CwtoUvsXF3Ghrno6qlw9CrO4+FeXU7KTMvRFCeV7708plHJhtaJRacCOH98lA
         VCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7VlZADSbyrVyyYmUXQ30hZbrflrNZLEBF2PfK5aqyNc=;
        b=Cw1ABXCV/rZqIRW2co8uAVMcFUtW633Z9jMxgSbCuQDixwx8CRPfe1UgSKSXEX4oOX
         /Ea/j6r4A+KUhCY+ctMaHnsJky8rUnZoTL7+qW1hKQzRBIgIOEx5o5aoat8wEF4wP+TN
         kjF8mcxD7Ftlp3x7TNmfhKZEi5j8a86A0pGwgI6gb58jF2bp6I2pVMy6Ern5GY6UIF0C
         rBVnp/icwz7UJCMj6Lb2HAwW3viGDB87K0VZ0ncMoXYSqmU0pl2Nj4VKRX9YSS8XecqD
         Nyfm08JuKKFzJVsb3ZKGjq2+e85FhFbMqgAb8FDv3uZKCoO4Va/97o390ICyyTQJHypP
         jhug==
X-Gm-Message-State: AOAM530A9zw63iMTJHvxlHA83sE9RQcn7V3hGMnmF+AQEqFLl3ojNtm9
        AyOvR7o13XgOrVKQZI2wbf4Jfe90n6NKO5PuMZ+V3PQSMj+UfsD2EyqNP5UnkEjvkxJFUTMWANL
        BN4Q/9AHk3Xat/66velFB9b7VmShyefju76QQvg8pZzEsfHw0w4QgjA4dm0JCxRE=
X-Google-Smtp-Source: ABdhPJzM3Fdf4dsPy9tvb82QM9BMNZIshizqWTmCqkVUz/+oHp0nossQwzrYEPVXi2JP4cPfY74DPxVbnbEfyw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c779:: with SMTP id
 x25mr457521wmk.138.1610969816926; Mon, 18 Jan 2021 03:36:56 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:36:43 +0000
Message-Id: <20210118113643.232579-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next] docs: bpf: Fixup atomics documentation
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
of _). It also clarifies the explanation of Clang's -mcpu
requirements for this feature, Alexei pointed out that use of the
word "version" was confusing here.

NB this conflicts with Lukas' patch at [1], here where I've added
`::` to fix the warning, I also kept the original ':' which appears
in the output text.

[1] https://lore.kernel.org/bpf/CA+i-1C3cEXqxcXfD4sibQfx+dtmmzvOzruhk8J5pAw3g5v=KgA@mail.gmail.com/T/#t

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index f6d8f90e9a56..ba03e90a9163 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1048,12 +1048,12 @@ Unlike classic BPF instruction set, eBPF has generic load/store operations::
 Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
 
 It also includes atomic operations, which use the immediate field for extra
-encoding.
+encoding: ::
 
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
-The basic atomic operations supported are:
+The basic atomic operations supported are: ::
 
     BPF_ADD
     BPF_AND
@@ -1066,12 +1066,12 @@ memory location addresed by ``dst_reg + off`` is atomically modified, with
 immediate, then these operations also overwrite ``src_reg`` with the
 value that was in memory before it was modified.
 
-The more special operations are:
+The more special operations are: ::
 
     BPF_XCHG
 
 This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
-off``.
+off``. ::
 
     BPF_CMPXCHG
 
@@ -1081,19 +1081,21 @@ before is loaded back to ``R0``.
 
 Note that 1 and 2 byte atomic operations are not supported.
 
-Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
-atomic operations require alu32 mode. Clang enables this mode by default in
-architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
-``-Xclang -target-feature -Xclang +alu32``.
+Clang can generate atomic instructions when ``-mcpu=v3`` is enabled (this is the
+default). If a lower version for ``-mcpu`` is set, the only atomic instruction
+Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to
+enable the atomics features, while keeping a lower ``-mcpu`` version, you can
+use ``-Xclang -target-feature -Xclang +alu32``.
 
-You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
-the exclusive-add operation encoded when the immediate field is zero.
+You may encounter ``BPF_XADD`` - this is a legacy name for ``BPF_ATOMIC``,
+referring to the exclusive-add operation encoded when the immediate field is
+zero.
 
-eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
+eBPF has one 16-byte instruction: ``BPF_LD | BPF_DW | BPF_IMM`` which consists
 of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
-instruction that loads 64-bit immediate value into a dst_reg.
-Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
-32-bit immediate value into a register.
+instruction that loads 64-bit immediate value into a dst_reg.  Classic BPF has
+similar instruction: ``BPF_LD | BPF_W | BPF_IMM`` which loads 32-bit immediate
+value into a register.
 
 eBPF verifier
 -------------

base-commit: 232164e041e925a920bfd28e63d5233cfad90b73
-- 
2.30.0.284.gd98b1dd5eaa7-goog

