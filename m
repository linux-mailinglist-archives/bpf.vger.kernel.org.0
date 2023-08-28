Return-Path: <bpf+bounces-8850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972D78B4FE
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E161C2094B
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6B13AD1;
	Mon, 28 Aug 2023 16:00:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AF134A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:04 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2FCA;
	Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d78328bc2abso3069388276.2;
        Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238402; x=1693843202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luyLmajpmSyQ8FebgnWKEdKBcRafu1L+AJoXX7hfZQI=;
        b=IvOALZMMuIfD0W8khI8mAte4s1jW9Pb09uKT3i6AQp+lLkJYlLfa1RjqJF1jZFqizX
         yUYHKBjy5/Pi2tf0f16XfvVxZ/meZE7fy0odIwYbB5zDECmaiF/ix5I1jkbFqbLA0OdV
         FFrAaCRWtQ8RIVxZs6EoNktPJK8TBs72qKRd4LbhwBWu6OH9gOJ9fQ8SoJ7nWmsfrXX7
         dhwu5jZ4mWlC2YFh/t6RjgCJ0rwXxRuSkft65GRkicIZcv67ojfKojEfmOTM06lvmwZh
         6jcrVRI+ORfIGhbsEJCg+s20O6St9APms7cewAKapWPRH9uq//S0kCozmFYEMIC0Hr2E
         TzWQ==
X-Gm-Message-State: AOJu0YxNLTxZk3AVTgKLBtmTESmOgWWRy4u9ymdmw8bpn/g+i+hag1Lv
	pCFabqJyS6IR/GjSyAnrOQ5lujczF9GUTg==
X-Google-Smtp-Source: AGHT+IFKAhMgLqOjdorlnMf8KBNdknwsYtmf6Im5SJlixfCReU/29DcUaSpBUMJDWJM43ox04FmyQg==
X-Received: by 2002:a25:a264:0:b0:d78:7e1:a715 with SMTP id b91-20020a25a264000000b00d7807e1a715mr10874158ybi.18.1693238402050;
        Mon, 28 Aug 2023 09:00:02 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b19-20020a25cb13000000b00d20d4ffbbdbsm1747053ybg.0.2023.08.28.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	hch@infradead.org,
	hawkinsw@obs.cr,
	dthaler@microsoft.com,
	bpf@ietf.org
Subject: [PATCH bpf-next 2/3] bpf,docs: Add abi.rst document to standardization subdirectory
Date: Mon, 28 Aug 2023 10:59:47 -0500
Message-ID: <20230828155948.123405-3-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828155948.123405-1-void@manifault.com>
References: <20230828155948.123405-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As specified in the IETF BPF charter, the BPF working group has plans to
add one or more informational documents that recommend conventions and
guidelines for producing portable BPF program binaries. The
instruction-set.rst document currently contains a "Registers and calling
convention" subsection which dictates a calling convention that belongs
in an ABI document, rather than an instruction set document. Let's move
it to a new abi.rst document so we can clean it up. The abi.rst document
will of course be significantly changed and expanded upon over time. For
now, it's really just a placeholder which will contain ABI-specific
language that doesn't belong in other documents.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/standardization/abi.rst     | 25 +++++++++++++++++++
 Documentation/bpf/standardization/index.rst   |  1 +
 .../bpf/standardization/instruction-set.rst   | 16 ------------
 3 files changed, 26 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/bpf/standardization/abi.rst

diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
new file mode 100644
index 000000000000..0c2e10eeb89a
--- /dev/null
+++ b/Documentation/bpf/standardization/abi.rst
@@ -0,0 +1,25 @@
+.. contents::
+.. sectnum::
+
+===================================================
+BPF ABI Recommended Conventions and Guidelines v1.0
+===================================================
+
+This is version 1.0 of an informational document containing recommended
+conventions and guidelines for producing portable BPF program binaries.
+
+Registers and calling convention
+================================
+
+BPF has 10 general purpose registers and a read-only frame pointer register,
+all of which are 64-bits wide.
+
+The BPF calling convention is defined as:
+
+* R0: return value from function calls, and exit value for BPF programs
+* R1 - R5: arguments for function calls
+* R6 - R9: callee saved registers that function calls will preserve
+* R10: read-only frame pointer to access stack
+
+R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
+necessary across calls.
diff --git a/Documentation/bpf/standardization/index.rst b/Documentation/bpf/standardization/index.rst
index d7b946f71261..a50c3baf6345 100644
--- a/Documentation/bpf/standardization/index.rst
+++ b/Documentation/bpf/standardization/index.rst
@@ -12,6 +12,7 @@ for the working group charter, documents, and more.
    :maxdepth: 1
 
    instruction-set
+   abi
 
 .. Links:
 .. _IETF BPF Working Group: https://datatracker.ietf.org/wg/bpf/about/
diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 4f73e9dc8d9e..cfe85129a303 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -97,22 +97,6 @@ Definitions
     A:          10000110
     B: 11111111 10000110
 
-Registers and calling convention
-================================
-
-eBPF has 10 general purpose registers and a read-only frame pointer register,
-all of which are 64-bits wide.
-
-The eBPF calling convention is defined as:
-
-* R0: return value from function calls, and exit value for eBPF programs
-* R1 - R5: arguments for function calls
-* R6 - R9: callee saved registers that function calls will preserve
-* R10: read-only frame pointer to access stack
-
-R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
-necessary across calls.
-
 Instruction encoding
 ====================
 
-- 
2.41.0


