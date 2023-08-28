Return-Path: <bpf+bounces-8854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71F78B506
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B6A280DDB
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09513AEE;
	Mon, 28 Aug 2023 16:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACC134DF
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:16 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9152CA
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:15 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 41984C1522D3
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238409; bh=myVHlHPhOUO45BmNc7O2aV08eiwlHEZlSNgjsnu0IdA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Q82Z50/IH+S1MvAA5Pqp495x0vVjYUq5m4rXA4mj8RqzFyQdbvOsp93CF9sRhFEoK
	 YbmDgs3zV3NmIMQt3xPUnf4DKUTI+DVNFDiCn/3xVwnVpIf2UVeXHxvrgbbXHRIPzv
	 cAzlbMzyWs2O0zJDqPIO3AXMKOWM12xhN5LtDFKU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug 28 09:00:09 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2DC89C15109B;
	Mon, 28 Aug 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238409; bh=myVHlHPhOUO45BmNc7O2aV08eiwlHEZlSNgjsnu0IdA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Q82Z50/IH+S1MvAA5Pqp495x0vVjYUq5m4rXA4mj8RqzFyQdbvOsp93CF9sRhFEoK
	 YbmDgs3zV3NmIMQt3xPUnf4DKUTI+DVNFDiCn/3xVwnVpIf2UVeXHxvrgbbXHRIPzv
	 cAzlbMzyWs2O0zJDqPIO3AXMKOWM12xhN5LtDFKU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B0E77C1524A3
 for <bpf@ietfa.amsl.com>; Mon, 28 Aug 2023 09:00:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.407
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsMms3YrJLZu for <bpf@ietfa.amsl.com>;
 Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0C4C5C15109B
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:03 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-d7485d37283so3295268276.1
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693238402; x=1693843202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luyLmajpmSyQ8FebgnWKEdKBcRafu1L+AJoXX7hfZQI=;
 b=B/WJIvnaYH4N6FNd9f7jYPNtiabqz61vR4VqWaMMRzyffWvpzVSw/xwrT7EupIcE/6
 0lb1xMk6dksyteXyP5NUbPqSUipm3jGXRLvJSVvh1uM9GOeEcGGb9wn/ubOicL11Zk/W
 XqyUP4DXAVkNGh92YC/aFvP8RuCVRkqa85GsX4Pmg1A3bXFT5nZi00cJ09X8O0RXLKsd
 d1xuw4qDAlqs5yFvHUt7I7dn/i3shUYuviZNtgq9T/qtqS236KiWnRiFBUgm3zDgZzL8
 kRWbn25KzrnWeDZhu8ntgdU5Rvi6/0uczaVe7qFDYWIRQFm0OyAqD/+Hnnqdm/ZqwXvz
 3A4g==
X-Gm-Message-State: AOJu0YxcpmomprFXvIzW9L88lh8pWD1eD4Hv8Zyep8MwK5YRY2xGkpxd
 XHvR4I5rueufA9Ki+i7z5RA=
X-Google-Smtp-Source: AGHT+IFKAhMgLqOjdorlnMf8KBNdknwsYtmf6Im5SJlixfCReU/29DcUaSpBUMJDWJM43ox04FmyQg==
X-Received: by 2002:a25:a264:0:b0:d78:7e1:a715 with SMTP id
 b91-20020a25a264000000b00d7807e1a715mr10874158ybi.18.1693238402050; 
 Mon, 28 Aug 2023 09:00:02 -0700 (PDT)
Received: from localhost ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 b19-20020a25cb13000000b00d20d4ffbbdbsm1747053ybg.0.2023.08.28.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
 dthaler@microsoft.com, bpf@ietf.org
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
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/7e6MtTT2MQUcRltGUGc4TTRWn-k>
Subject: [Bpf] [PATCH bpf-next 2/3] bpf,
 docs: Add abi.rst document to standardization subdirectory
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

