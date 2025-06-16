Return-Path: <bpf+bounces-60713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90021ADB286
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BA77AA516
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F62877D5;
	Mon, 16 Jun 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KyrJdwze"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9F2BF01C;
	Mon, 16 Jun 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081843; cv=none; b=sw2Rx6ZckfgfPGpLJU9RPs+gCUPV/E1aeuTIVEq+ZOHR81wZ3cyqWWJ+bz5nyY7rRu5bMg5J9vNAV+vmNaHlOXEAiPFw/ZuYV40OpyzzvFqN9/ewyX+W6zUU/qWF+AbDaiIG9LkcgSpmmxzk3ZO+yswLHVrotgD+m80Kq58VdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081843; c=relaxed/simple;
	bh=+x9sfLGwpIjbHh8f17FciYjgMRNava5SEnnbb4NlD90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4uYI6UNyFwX131kiIPJSHAkLKBzWRrc7W3LPWZzNVkTuL6EN2G+d72JD7jBid/AnI2myjOuVOi1WPVYvOLB9QJ+ZjNalu+EaV0ckb5xzyED3iPAZgwUw6tubwXDW9zwN1EDX/KvJImHFoc0IqQiq1aU7oEbZrse4BLmH3pcJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KyrJdwze; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tX
	tsdxbCeislA/mf7Gi/p/1iYJQhWAtKJw7QjyUyEr0=; b=KyrJdwzehGiRPbGIlM
	Px5Xb2sd+l9xfvChnwm7FOKYd++9htuKIA2aE1vrLKr5yaDrPlNapQEphhzPo5cb
	X9s2KrR65vOVM1uo2k9GpyMEyc3G3nnFcqO+ow/x7YSOaCovQekYpJvWlR5OY08k
	z0PuVa7Z83lHu0Y/pnwhNvErw=
Received: from 192.168.0.118 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXnx4XIVBozSQVBA--.35262S2;
	Mon, 16 Jun 2025 21:50:16 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: qmo@kernel.org,
	ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATCH] bpftool: Fix JSON writer resource leak in version command
Date: Mon, 16 Jun 2025 09:50:14 -0400
Message-ID: <20250616135014.12327-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXnx4XIVBozSQVBA--.35262S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrykZFy3GFy8ArW7KFyfJFb_yoWfWFXEg3
	yUXr4kXrn5tayaka18C3yfurW0yFWSgw4DCFn2kr13JFWUJwnxXF1ku39ayas8JFZrGr1a
	ya93X34fGa13AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRZnYwPUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJw1uvWhQG8Bu5wAAsT

From: chenyuan <chenyuan@kylinos.cn>

When using `bpftool --version -j/-p`, the JSON writer object
created in do_version() was not properly destroyed after use.
This caused a memory leak each time the version command was
executed with JSON output.

Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)
Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index cd5963cb6058..c8838196a3bd 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -164,6 +164,7 @@ static int do_version(int argc, char **argv)
 		jsonw_end_object(json_wtr);	/* features */
 
 		jsonw_end_object(json_wtr);	/* root object */
+		jsonw_destroy(&json_wtr);
 	} else {
 		unsigned int nb_features = 0;
 
-- 
2.44.0


