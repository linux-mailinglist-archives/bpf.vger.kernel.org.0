Return-Path: <bpf+bounces-42975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199289AD8A0
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E251F22CD0
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DA1FF7B3;
	Wed, 23 Oct 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRae2lnm"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3F1A7265
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727326; cv=none; b=if0Lfzh87zi7VbhYNUVgKYcCCrWEtOc88n6ZjYEJUG+zWwE96yCmw7wDkf81inGLCp1pCGSRaHDldasrKdKluTkrZFmjAkFGbgnLXAbBL+iDjBzp7e6Yocl8bk04N77pI9J5W6GNk7LjY+yeDitjDoYCuK+7yqFbb8uTgFzVYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727326; c=relaxed/simple;
	bh=7HDICpPHsebJv3BzIzIi1/AHx2X/2Qv1uWN4chBGU+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mITBrOSK9ZhLnqGNFe/VvCN602eiJvaypSbz06eIHGUPswDA4qNjdlxddf3WYXuxMO/iaXildX8prfmb0tTNpR+Kyn2BmIVjt6sAK9NvafB5eW57wCJFTx88j6oJEqX6rGHZSC4TIdP1vMimNrNNf8gUsfrZW4L6pEwL+p679v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRae2lnm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC3+xARsUKd/viABjpsb1scja9lwPh9MOMLQdWqqcS0=;
	b=iRae2lnmQ9a/6jkWcALqwxivOBUNjZZ7gkhGyKtXk6eSDUiwHNJrvSmsaN1XDN7grcS90I
	jE3EDfiIw7PJALmPgxJU/8yHUYRc+Mu6yCsD7kuqK+9smTnw+zBAHcetoy+CszZhmxFeSR
	d5Hk58vg5H9WwpWgZvmOTQmmoLMLCw0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 07/12] libbpf: define __uptr.
Date: Wed, 23 Oct 2024 16:47:54 -0700
Message-ID: <20241023234759.860539-8-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kui-Feng Lee <thinker.li@gmail.com>

Make __uptr available to BPF programs to enable them to define uptrs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80bc0242e8dc..686824b8b413 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -185,6 +185,7 @@ enum libbpf_tristate {
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
+#define __uptr __attribute__((btf_type_tag("uptr")))
 
 #if defined (__clang__)
 #define bpf_ksym_exists(sym) ({						\
-- 
2.43.5


