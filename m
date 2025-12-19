Return-Path: <bpf+bounces-77108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE15CCE3A5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8235530CC972
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE528751B;
	Fri, 19 Dec 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jfKSWNB5"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A76284670
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109670; cv=none; b=JP0yjao+zKunYLzFC8L6bvuMvPyo99SgounSmMs4jf3ggeHlCUzQmek0QKAknibu+RCMgBi6jy418yT6X1rN88WGW8Xfeu1glfcA1YCJSbF3Nwzj4Pe3CEgS6Mv8gM5TTaH9KDHAfpwl1h8wVERGALTDXIH7Wo43hEvlHKaVgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109670; c=relaxed/simple;
	bh=VuNfMpTBm0CUYXaO+t8aSyvTsMROnkknWppmR/tAKfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3RjXJYDGdjFBWr01Dfx0SK+GGqm9romEaF6ZtNj0rqDDVOVjErzfMrkUQQoFYeJdIgr3tzNYMxmm/dy/9+OSx4PTuBzNyUW2RfnSELKxJMjd/9Zul0HiochjofFUAk1pgufQlZXgqqQuNYe/31DTZq48RfRxO1nMwiGkVBIRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jfKSWNB5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aayb7iWI2Jbv+ieS21a4aukFU/2uaqV3fIN+m3cIAm4=;
	b=jfKSWNB5Zw0D8r89UMylhXfa9y5MQeOa4KUtvApvMTBVZXzDaDwcFQgBcWuF9T1xMfts04
	6BJRbAGALErdsa3e14+AOnaCZ1a3/9CKGFbdF16PNW4SaJNGZ70ywyXqu5F7yYdnj/OA6c
	vj93+6taKHijoBdcnfSEvvR/ysA1QJA=
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
Subject: [PATCH bpf-next v6 4/8] resolve_btfids: Always build with -Wall -Werror
Date: Thu, 18 Dec 2025 18:00:02 -0800
Message-ID: <20251219020006.785065-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251219020006.785065-1-ihor.solodrai@linux.dev>
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
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


