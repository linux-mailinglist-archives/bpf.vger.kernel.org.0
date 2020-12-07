Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D02D15AD
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgLGQJw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgLGQJv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:51 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA7C0619DA
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:37 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k23so5518475wmj.1
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/lv6DrUY5wlxHYDqv4wuxYv1KAcmfbWk3hb5TBKA9OQ=;
        b=qrAzvndx/RfGimRH9rKkjCXl5R5vcp0lJ2luB3NAF1M0qm2i6C92p+0/ZdytUErKZ4
         AeQ4lopdDG6WorylJp4LWT5Rv9Lz4cpcHvwZ6WsMtTB49032zXcDT2WI5pFmckzGKUPq
         2AyIjpbjtG/r6lmJvHb4oQL5MWxVTTAXq+eKY8OiepizFdmsojaPbdkvZLDYTPfujo/e
         CgN4INGp/TCJVRnSDwgoH6Tfz6bX1O+6qTfyNwp0CG2G5KX+Sk6786JDajTfaLUBKzRb
         yPrL8w3uDWn/sNQ9MzknDV517kpssAZOCpY4HzttuLEsXHcgyEzzvjuqkdfMDnVP197o
         ffGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/lv6DrUY5wlxHYDqv4wuxYv1KAcmfbWk3hb5TBKA9OQ=;
        b=ibsQT5ElcQ9M5iScz2tGDiqiMb1BwVY9XUn7H1sd5qPnFZ+XbUkEsoiJA9A3IKwPyM
         2z9l3KohNpo5U3aVAdFwzgnLNjtAmompximKiZT82uxlMYcGxTinHfIcwVJgfSLjcXVc
         HVoHeszgXksBWrYhG2phg+/llUpzaDLZf6Yu6rlu6ytydyZjvIiD0ICYoEZYkEmRjNdI
         iO6UY1lxUMtzGZwDODj6vPRn8GA66pmgyMm1k42rplkkxvAGn+LJrIgHwgOqb5Ugtk2B
         Xjj3a7QXRBuSyhBglqiou6DosRQlQBaKDu89qVPN0mXi+ALZzaBxAVLLibjlnv31EbjD
         EJ1A==
X-Gm-Message-State: AOAM532ouSYoYKk33rUVk8LMVq84m9S6WD7Cogb0zgCHv0+jcHLO1ZAh
        gRaWWKi9rsJ/VerSzTFABedrJVcx/WWAxw7pu/vJ82humTH01PFAruPAi2s8S+UKYzVfFptbCyL
        2mb7C1ujP5XEm6eP9I0pmC7zwSyRHB8gnrQPoqIcdupKrDDBrx0lPgBDU38zdhEc=
X-Google-Smtp-Source: ABdhPJxzkxIq0ByuLG8V4MG6Y6ki3FwPpCc3rrTeLj6hrKEf2B7w308rHmXjLVsALm2O3c/Kego1U7170Hty2w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:5585:: with SMTP id
 j127mr19812912wmb.169.1607357316448; Mon, 07 Dec 2020 08:08:36 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:34 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 11/11] bpf: Document new atomic instructions
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

Document new atomic instructions.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1583d59d806d..26d508a5e038 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1053,6 +1053,32 @@ encoding.
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
+The basic atomic operations supported (from architecture v4 onwards) are:
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
 
 You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
-- 
2.29.2.576.ga3fc446d84-goog

