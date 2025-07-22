Return-Path: <bpf+bounces-64041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CB5B0D907
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105AF7AC4EF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC47F2E9EA1;
	Tue, 22 Jul 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIUa+6Bd"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CD2E92BB
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186211; cv=none; b=tdrBhAj86VJYkRh8hqq87rX4GqPRrvIGI/2mKOPXZ3USPezQeU24feeTxjYfnabSuU63D92qqweW5rIBmnimxdG84amT+NvYYwZGvgCAnJd3SCpqhv0jGstJjtqymEfQElcQGxoxrg+d4l+mhGm7BzBcEekQQkul1FsyUKuoTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186211; c=relaxed/simple;
	bh=leNGTHvWWp46LZgpi1BTmu0wvBgAK2ri4Pf1+TdGgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEdKnqYjTe/IGUvybo0HZz5R41VRh9iCoH2Z1JUDEhPWosjth62ABAVuGL4vY71FyLb0hnavz4pQjDwkOn7sTNb5Bsg/7gRok4GUmTIKTcOy5EF95sgEgmUNsUBKDRHJ2su+nCz6eW3Aqm4pus1xy6jj4DUkg6tqLhkr91SX9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIUa+6Bd; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753186207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7UAU5cTx6BEldPZMK7N1hTK4sqGjpRmtie4vkjgCL8=;
	b=vIUa+6BdHYPWQifTT9xBkjF05gU9moTtZOkwkV/bbHc+Ei3fO+g35huvjPgHqgXBupdr0p
	tK+8BHLd0HUCHPDtjm3z8sFnZJBlr54jwzh03JC6ZbSmFzKb30rkWZj/qMNSV9zyX/a/Ww
	soTJncBCMhCMFR0doKDHJB7fmWFqbUo=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 3/3] bpftool: Add bash completion for token argument
Date: Tue, 22 Jul 2025 20:09:12 +0800
Message-ID: <20250722120912.1391604-3-chen.dylane@linux.dev>
In-Reply-To: <20250722120912.1391604-1-chen.dylane@linux.dev>
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit updates the bash completion script with the new token
argument.
$ bpftool
batch       cgroup      gen         iter        map         perf        struct_ops
btf         feature     help        link        net         prog        token

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a759ba24471..527bb47ac46 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1215,6 +1215,17 @@ _bpftool()
                     ;;
             esac
             ;;
+        token)
+            case $command in
+               show|list)
+                   return 0
+                   ;;
+               *)
+                   [[ $prev == $object ]] && \
+                       COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
+                   ;;
+            esac
+            ;;
     esac
 } &&
 complete -F _bpftool bpftool
-- 
2.48.1


