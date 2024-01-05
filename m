Return-Path: <bpf+bounces-19089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB763824C0F
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A5B287488
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B5A32;
	Fri,  5 Jan 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqUNJRmU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C162186A
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4ABC433C8;
	Fri,  5 Jan 2024 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413371;
	bh=EBcIgNUvTNJjAgApAZJwEf7hxvrmG8LbasRpx3FHMK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqUNJRmUaR43O1o9PQWK9luLjU4UInP2vHG5YPVX1Clw1xBkkC4egQCwc1E05US6X
	 oeEJirFXIMijODcRtHpPwWBltCmleuJmYVlsutmPBbtEWy5Iqk7mb4dRioZ3uj4xEW
	 N9yuzv6HZ3NczZRNjMJqFS/8x9QYsvVoIyzqDCeoZIjq0PuOJRu903cwBAmz4RiF0D
	 kRRpZrASXzjU0u4EidkZY2OXG1+6s/TzXOYOMm7zmpLTAVUvi663L3tqf33xpFGNXL
	 e7Tuf7KUfJ5vqoV8+607qS5aKKpgSlKsXP4jpRsP3+4rcjZSqoFesc0f6Z8gDfLuCn
	 kyM/Upbn9lNSQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 6/8] libbpf: add __arg_trusted and __arg_untrusted annotation macros
Date: Thu,  4 Jan 2024 16:09:07 -0800
Message-Id: <20240105000909.2818934-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __arg_trusted and __arg_untrusted to annotate global func args that
accept trusted and untrusted PTR_TO_BTF_ID arguments, respectively.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 2324cc42b017..e6967a999ed9 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -190,6 +190,8 @@ enum libbpf_tristate {
 
 #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
+#define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
+#define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.34.1


