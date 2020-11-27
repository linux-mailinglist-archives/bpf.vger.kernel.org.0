Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE912C6B2D
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbgK0R6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbgK0R6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:18 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8173C0613D4
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:16 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id t17so3666393qtp.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NXuOTf1MPK8TRE6mj0XMAIGn4tL+u51UNs4Z0qmP7TY=;
        b=LCxzFfeyElEsmKF10zxjGXjZC+9NCkcHcJd6YRlac2ucNzBm813nhfgUEbO8tX89ls
         uJr5UW8Z8IRDcmuGXFQ/8rJiigwxIuAKf5yT4AfIY9qJwFSvgKFliJ3NIoQZ83jdEeUq
         tskA4y84dkkwdYQtTZDEHSU1EPauPDbzchuuBVKw0ZjiSGEoIQImlRJVAbZV3eglnt3D
         QDmy2ThtjXPWPgev/zPS/yKySFkL6ADja18SIHDYn4IAe7hiaR6j7IWcFtGvZl9mg9JM
         xEN0wBlt10RwJ6c/Dm+oDBwFniegP0SehwWazCNcDQvnLOQc8D/2sXRRmdlLe8omOh2r
         tqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NXuOTf1MPK8TRE6mj0XMAIGn4tL+u51UNs4Z0qmP7TY=;
        b=eTG4DY+nOY+55Cwf50x28AeULfkSjQzAhuLUdUed8O8mX0lIebihsQJERBKAjKnMy5
         0lwKc/Wj0IXmFKOE0OABWnyjO8w2lpNl/xnuWcWAg0I+IoKxuLc24NSIOOX76zU6g8SV
         Ibhk7Sis9UrDxttGqGoTwT4MFIax0euOc0zycuJ48ymiCDIvEEcn5h/O0ood/vufk2TR
         jvYd0MkPOYF1YCgv7gbo80NnGGjME1FOJAeEQ1VcGXpj4vJ7BAZQAxUeR2qAX3RjoPeA
         u5IyODGxF6JtgqUANToE9zqhozhgftuCac6hWlcG1tBegLafGg6NBCVTP8uekrXk6aMc
         shPQ==
X-Gm-Message-State: AOAM530epVmIYYWqMxrotL/A17q+6p8DbQ0vyt4sWq/By7HTVA4flMH0
        maK974++q0qB375Fk+LYV541Haim+8m14OElGOLIpEigsk8GSl787BLAGRc/MG5gUb9hhQ2NoVN
        bwXLYJzwWpMuv6D483p6obeTJgORI3FG+rFRZtlzjpet5cuC+mMpsOAxd48OhReM=
X-Google-Smtp-Source: ABdhPJxPJl813Avj63aZPEpIBc12NcoU1YbQ5PNvAh5FhZ/HCmrzSxW3HvxObE/cCykzTQtXo1QWJ4L8I0EJ+g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:4725:: with SMTP id
 l5mr9499075qvz.51.1606499895963; Fri, 27 Nov 2020 09:58:15 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:38 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-14-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 13/13] bpf: Document new atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1583d59d806d..c86091b8cb0e 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1053,6 +1053,33 @@ encoding.
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
+The basic atomic operations supported (from architecture v4 onwards) are:
+
+    BPF_ADD
+    BPF_SUB
+    BPF_AND
+    BPF_OR
+    BPF_XOR
+
+Each having isomorphic semantics with the ``BPF_ADD`` example, that is: the
+memory location addresed by ``dst_reg + off`` is atomically modified, with
+``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
+immediate, then these operations also overwrite ``src_reg`` with the
+pre-modification value from memory.
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
+``R0``. If they match it is replaced with ``src_reg``, The pre-modification
+value is loaded back to ``R0``.
+
 Note that 1 and 2 byte atomic operations are not supported.
 
 You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
-- 
2.29.2.454.gaff20da3a2-goog

