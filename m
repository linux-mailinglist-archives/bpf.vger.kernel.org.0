Return-Path: <bpf+bounces-20348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635983CDDF
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D175E29B09F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E941386C4;
	Thu, 25 Jan 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIApeheM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232281339BD
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216132; cv=none; b=XkvqVT6QJhkweUkKVhKJd7IjMUoD8SpbbvRqKtuWcSf4JCuat31K8bH5EM9d7cnSPgva/N3SIO705RyiCiFyGdwC128KFyVa7Numrk12REQg18a2qrVRYGQT/Jt1iA4e/vLSLtrg4neONGYHEBmAfr6pyN3fWFbEzGMYALhYnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216132; c=relaxed/simple;
	bh=Hzsr4eLCh5p9TR7uC6mc5BtlF6RQS4wCOV+S8by9cO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVQBt/GGvAi04Jp9TYunCDOODHtClUO61tkk4pdNzMxIUydUpqSogIVV21y50xceJ69B91KKdyycqs+i8Fi25CcSr8/bTJWvlfG2k/0q424aWcpjTNIcMvEUPdqjiANr1on9L13Fh6JaJ4c6lvNH3XLDWPmtn/gp2TIru0NmICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIApeheM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0FCC43394;
	Thu, 25 Jan 2024 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216131;
	bh=Hzsr4eLCh5p9TR7uC6mc5BtlF6RQS4wCOV+S8by9cO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIApeheMIEFyqoIniWV6+kIrqcW/kJMhAHzrsGtqbwtAu1urm+xs4ILMqubMEosOe
	 wKcGly1C+9KZ2LTMOPRPIjFFJcDSStKoWK6mfEXIT/HhB8j7YPUg5f2zN6ktJ5a0jN
	 Q3cZd9doSklAj0dqLMGHPSw4Td/lGsOMY+igCuu+edVBUZk0i/7sjwt/X8SWtCcJ4T
	 iOHFEBiPn9ZKsHSqhy8gi3Gpbc9fPydJ0tyM+fEK2leNOTHnvTDMwm4j5vOKIfQeRo
	 mkwNbFF91W3sAYPp1ObGglNdYHjCaciLOc084xU9cBXuTJpEnDj4QYTAS/aRMZdaBk
	 W3/56KJWJ9Lxw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 6/7] libbpf: add __arg_trusted and __arg_maybe_null tag macros
Date: Thu, 25 Jan 2024 12:55:09 -0800
Message-Id: <20240125205510.3642094-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __arg_trusted to annotate global func args that accept trusted
PTR_TO_BTF_ID arguments.

Also add __arg_maybe_null to combine with __arg_trusted (and maybe other
tags in the future) to force global subprog itself (i.e., callee) to do
NULL checks, as opposed to default non-NULL semantics (and thus caller's
responsibility to ensure non-NULL values).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 2324cc42b017..5f5901187c94 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -190,6 +190,8 @@ enum libbpf_tristate {
 
 #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
+#define __arg_maybe_null __attribute((btf_decl_tag("arg:maybe_null")))
+#define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.34.1


