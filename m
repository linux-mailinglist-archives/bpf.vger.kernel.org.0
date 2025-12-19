Return-Path: <bpf+bounces-77078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79348CCE128
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323FB3072AF8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6D16132A;
	Fri, 19 Dec 2025 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="plEQHP2R"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0213FEE
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104373; cv=none; b=BMfcC7I/8thj5NKEWIKL6xb8U78JsIFFybvimg4XakI/ATl9dz3LeldmTJcBkoCR0irNoomb6VPW2N8xszNt9HlLw4xtpTB3rs7uHGaEvL7zGds0UAIT5LIiqpRr0mwHn10ZK0co2Eznw1bfIcYqp/cVpAti72Gi/WShxpGUmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104373; c=relaxed/simple;
	bh=VuNfMpTBm0CUYXaO+t8aSyvTsMROnkknWppmR/tAKfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uscGDbpF6v1IEjjRXgvBVkOVEP5wSQ3DRGiGmxt2UCVqEeIanuJEWzNagL1udQ8Rx5+QZapwiS5HE2veDWkxTc9zdj+4np38jOgWQcL8b4RJBX8aww8ilYKAfO9w7FxVju3o2ZMkt2UUdXpTz5wsRw+MQFtHRHy2FZ5nvuS0iXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=plEQHP2R; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766104364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aayb7iWI2Jbv+ieS21a4aukFU/2uaqV3fIN+m3cIAm4=;
	b=plEQHP2RfL1PyGGeHmRumyGMaY4HeewxcQj9wztJ0L5KnXcXB4bzmo/nR8Y4fRxWM+/e3t
	VnPwtdd9IyTXL3wNLqVq32IytLWJeQSHGa8+Lg1wr8YeRa5txusVCHcJhcAX/lMphSE9iY
	hmZQpSUn/d3CgH+oTois+LrJ0LJzL6o=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v5 4/8] resolve_btfids: Always build with -Wall -Werror
Date: Thu, 18 Dec 2025 16:31:43 -0800
Message-ID: <20251219003147.587098-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251219003147.587098-1-ihor.solodrai@linux.dev>
References: <20251219003147.587098-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

resolve_btfids builds without compiler warnings currently, so let's
enforce this for future changes with '-Wall -Werror' flags [1].

[1] https://lore.kernel.org/bpf/1957a60b-6c45-42a7-b525-a6e335a735ff@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ce1b556dfa90..1733a6e93a07 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -70,7 +70,8 @@ HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
           -I$(SUBCMD_INCLUDE) \
-          $(LIBELF_FLAGS)
+          $(LIBELF_FLAGS) \
+          -Wall -Werror
 
 LIBS = $(LIBELF_LIBS) -lz
 
-- 
2.52.0


