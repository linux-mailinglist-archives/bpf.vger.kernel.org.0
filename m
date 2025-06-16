Return-Path: <bpf+bounces-60732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D7ADB554
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0683E188AD24
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C025A2BB;
	Mon, 16 Jun 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ASMgfdZq"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD22673B0;
	Mon, 16 Jun 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087654; cv=none; b=ZG6zS/wSXA51vnwZWTJCxMz0cXfxpl0ER4bzdtewV4S0+5OPzvuwVPrinI7fyOI9iN03H0Sp+Eu46OAV0SRC/MG36WpTKr1PuIlYILEyzbQcI99zL79xd+snaVpC4mTTfOCwT2lehEWwcexnbg6hljxXUe2m20x7xIPG+2c0rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087654; c=relaxed/simple;
	bh=bFypPdmHodzDB769ehmri/gKsSwWgk6uPf+N+xzQ9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rd3MqHWIE2l1VWK/sXEarKgAZSfL5HomOObgVgZJ+rzUWhKNlJ8BgZsOEY+kvo5m93Bes3tuTGhWJPs56FOGchojcpxvErYoDkqIr7Mwl7jK1VLSZGI6m4xw9rJWy4qh4DSAroXCnJUV6M4yiC52pLy+ROysfP36mb1Z4PGJs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ASMgfdZq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=J+
	0SkBUVgLu1eOAdirL/u/9mwz+vic9m4DHm10Ihphg=; b=ASMgfdZqAOsLB1N8z6
	0McAwQnW0vZYmdtpZ9AeXrw8wJgLhZSmB/iFyqOCqbv2F8C/nt8FPKn9IuLyQKLq
	TBobqNmaXs/cXECOu71d2sXl3SCcZCWkkNpse7XpugLkxDouXpMLH16G6bB2H0R9
	rN1aJLgTMHc3kTdBJSW34VVVk=
Received: from 192.168.0.118 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXYnTYN1BoqTKGIg--.16500S2;
	Mon, 16 Jun 2025 23:27:21 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: qmo@kernel.org,
	ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] bpftool: Fix JSON writer resource leak in version command
Date: Mon, 16 Jun 2025 11:27:19 -0400
Message-ID: <20250616152719.28917-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXYnTYN1BoqTKGIg--.16500S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr47GrWDGr4rAryDAr1xuFg_yoWDurbEgr
	4DXr4kXrW5KFW2qw40k398ury0vayxGa1DCr17tr13JFW8KwnxXr1kC39xtas8ZFyUur9x
	Aa93Ar93Ja13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKoGQUUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiUQVuvWhQNWMwfAAAsl

From: Yuan Chen <chenyuan@kylinos.cn>

When using `bpftool --version -j/-p`, the JSON writer object
created in do_version() was not properly destroyed after use.
This caused a memory leak each time the version command was
executed with JSON output.

Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
Suggested-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index cd5963cb6058..33c68eccd2c3 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -533,8 +533,12 @@ int main(int argc, char **argv)
 	if (argc < 0)
 		usage();
 
-	if (version_requested)
-		return do_version(argc, argv);
+	if (version_requested) {
+		ret = do_version(argc, argv);
+		if (json_output)
+			jsonw_destroy(&json_wtr);
+		return ret;
+	}
 
 	ret = cmd_select(commands, argc, argv, do_help);
 
-- 
2.44.0


