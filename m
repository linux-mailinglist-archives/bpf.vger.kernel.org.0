Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2131E851C
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2Rho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgE2Rhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:37:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2AAC008631
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:29:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so86406pfa.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g6Xmv8Aoic+dGmRE+DHUL3CUzcIpKcgQcYn9ErwDWD8=;
        b=SsIDa+EtPdUVsVc+T2wflPrc080k7bUdJ6ZFv3IuoatzBaTljDqWAvugITuVDzxOOu
         RTttTq+IE0IYz0QU5o325iEezdG8LOTC8f591S9tPGLZpPJJWcO2AZEmpCqjbXV8OHV1
         9d+sbt1hv3is/q3YxBhFx+mh/s35EISlHGhykNNv+IV5ClnfuThvO0L+yTOvMjJnZH6b
         mDqERX5XnEzD9eGG+oBLzBhzyRmsfI9/SG9n4YEIFSgiGSyd+B21VBSb/2inykBDUqMO
         7U8NRKDeLtJLBKBIlAaqUlg6VZnd1L+GFH3ZsGLsyVFfMEXswwNffGd0RZkR6BvmbIpa
         U7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g6Xmv8Aoic+dGmRE+DHUL3CUzcIpKcgQcYn9ErwDWD8=;
        b=b+DHHk2qK6LWZ7Qgf4v/Y1Fv+L7N4Eg8pWavQNL1kCKbqmpQzqSSehgZnt+XafJolf
         4DX081ZuD2clHg6gOQ05BpAdHIJtPbowvBCy4EDytraapegJIYJjblvBXdtt4q7HQ+J7
         LY6nWxat1Y1JMmhwM5872TWT7VB+q6xEn5EOquFQ7AxL9uUBFPKuKH56sm++9KFHl2Zw
         6ovOdVsGs69zH/2SkfXO6T2X724qi1fbsafIPqw127KbfKUIwS3b2lnDXZWhjU6moUxW
         kxhTl+XIvMYX1ViHjP0B3QVPQX9/P8PX8BqivYTJknI6wxkCCXUioaUJ2sUfsCku1wMM
         thgQ==
X-Gm-Message-State: AOAM530LIQmBNQ85iHALMNUtP5ztqN/mLmv9FHq0LMqpjJpETwlm2Js2
        MAojsXA9W4Io7MsegrsPJ0y1BqT2
X-Google-Smtp-Source: ABdhPJzTv5S99Sacn38rJ2nTNyk0Uafcump07ru90F5jTHlNB+h6S+xESqPsnylfligoVMjz6Vge3g==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr9328073pgq.382.1590773371450;
        Fri, 29 May 2020 10:29:31 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id k18sm884044pfp.208.2020.05.29.10.29.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 10:29:30 -0700 (PDT)
Subject: [bpf PATCH 3/3] bpf,
 selftests: add a verifier test for assigning 32bit reg states to
 64bit ones
From:   John Fastabend <john.fastabend@gmail.com>
To:     yhs@fb.com, alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com, kernel-team@fb.com
Date:   Fri, 29 May 2020 10:29:18 -0700
Message-ID: <159077335867.6014.2075350327073125374.stgit@john-Precision-5820-Tower>
In-Reply-To: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a verifier test for assigning 32bit reg states to
64bit where 32bit reg holds a constant value of 0.

Without previous kernel verifier.c fix, the test in
this patch will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index fafa540..58f4aa59 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -535,3 +535,25 @@
 	},
 	.result = ACCEPT
 },
+{
+	"assigning 32bit bounds to 64bit for wA = 0, wB = wA",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV32_IMM(BPF_REG_9, 0),
+	BPF_MOV32_REG(BPF_REG_2, BPF_REG_9),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_8, 1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_6, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},

