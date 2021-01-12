Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972AB2F347A
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390744AbhALPor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405332AbhALPom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:42 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5244C061382
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:43:04 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id g82so634551wmg.6
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=pp1KxffCDPqB9jIy9tx75GpgmaQQZyM9ktvJ18nRXiTSgY7iOlYcn/aLrbZzWn9QhQ
         J/ttqRDHk0CFmqUEVoF/OXmko556O047ZO0EVK9glyXSWKTuMLlQorx/q78jwJ26WHz5
         a7jiDA1y0IMP/vKZh3ImwFFrYjN6o0PMJNeb8vxYLINl4WR9fhirFJVJGDDNgxeup7e6
         HVVxQtkxslABlElQVoeaJ1axZjXe/0P/VA9WuMgcEdzcWAkcSmy4OFclaKppnT6Ai+CT
         YVbBl66fxFfNzgLvWFVTaGDa32TvibyRjWcgAK7xh5hWThS5AFcwo53DS0PmFOExlBUJ
         Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=mmF7e6PV4DQ6WxG/w3b3vqgg+yxdUbWdT8nfYyPv+5DGypbsOTdvm5Yp/oH9V63H2u
         zO+rCvdOCL38hauR0uZHPUO33iJUhjUP+g8UqS8AhAe2dNNuiBelhLx6iAdpAluk11D/
         mMF1wWvD7i3TBeNzdHLdlR5xRVTztbvC7DRsOOYG+ezf6jestHYyYA2tFp3IuTWa4TG8
         j0V6AR9YcTqeQ5S/BlsfgueQOjrMQz0pgwIbtAwhF3aChWShpjXAKZbs4Mdmw3yelRsX
         J6DHiXzg754KUOtI7hnS5UUXsHwdIGfdcZSnznhhYckXFtAdJzRVKx0bgcrTKx3z4NWy
         LsgA==
X-Gm-Message-State: AOAM532d+Xs3uSw+8lhsbr7kw+5BpfxyZ3DfnnzXVT8MMdlJiY+egJmU
        kG0HnUmw+SugwL2PJGe6gwmiEeyTFP+4qIX3ceAncTeGhOGN64zUhvQDJRPMhuKsRXiariWFzNb
        jBg9BJyAAYLlTjwQS6MG3Arm8Ncg4mRWbcuXO60eVvHu3Q18BuDoerMrdm81aDO8=
X-Google-Smtp-Source: ABdhPJxKXRDMn4Swgqsq5vJ++TLfR8yTk5ESZ6D3Nee36eQ5/bT/AD1pIEtCXDfHqc3vQ2hiyXTwFrwdGi08yw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:e4c5:: with SMTP id
 b188mr3649502wmh.78.1610466183095; Tue, 12 Jan 2021 07:43:03 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:35 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 11/11] bpf: Document new atomic instructions
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

