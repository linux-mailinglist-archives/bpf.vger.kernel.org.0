Return-Path: <bpf+bounces-64034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC87B0D8B5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E841AA13FA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E42E4990;
	Tue, 22 Jul 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SF6WVNh2"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BE1E32D3
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185563; cv=none; b=ZABrW0XIAdksTZN2h1Ncx3Qxx/tOQ23/17smnTbIJH3oYpj4bmAT3cPRfQp66UKhFqz5urySv2W22+cv93ufyAgIFyqXhHZ/cc2/tkA3RbKncIgkyrUNhW4BaJIa4ZoPKIRxM3y8//Z6LrZRq6pBi+PWwkCGSO+XojU9b/2hb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185563; c=relaxed/simple;
	bh=leNGTHvWWp46LZgpi1BTmu0wvBgAK2ri4Pf1+TdGgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5mh3opAtJDY/zeI6/B6/2/jqtQpdHrJrG1bYyvEIlVNifdhnkRZ2SQgIVgTPWjfTwCyuP+WlERsYBZOStRdXklYZ30x4qYn1unNnMl5+3ChRodzcE/prSVBYRtw5NWECoFBtAqs2duuDv0Kt7FHN1FfcwNxqton94RX3XL5zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SF6WVNh2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753185559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7UAU5cTx6BEldPZMK7N1hTK4sqGjpRmtie4vkjgCL8=;
	b=SF6WVNh2CRTN1u7oMFJCGrmBqPNYRS7OYStOpDp/qdV0j3J68xW+FmLFqo+zlbJ2MkLE5j
	8T/hXOcYNsfkBF9EMhELaGSa+Ix9Xoh8wXOz/ymPwdUc2vvua/ld9HDc6M3xSA3NgBrzNc
	JDb5k7I8ywtWvbICl5ynXcRhUJAPuZY=
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
Date: Tue, 22 Jul 2025 19:58:15 +0800
Message-ID: <20250722115815.1390761-3-chen.dylane@linux.dev>
In-Reply-To: <20250722115815.1390761-1-chen.dylane@linux.dev>
References: <20250722115815.1390761-1-chen.dylane@linux.dev>
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


