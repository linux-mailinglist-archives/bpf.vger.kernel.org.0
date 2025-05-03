Return-Path: <bpf+bounces-57308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75EAA7F83
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D827F1BA2DB4
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7E1C701C;
	Sat,  3 May 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ps7tzs1O"
X-Original-To: bpf@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADA4C98;
	Sat,  3 May 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746262250; cv=none; b=t058AqOmK3HSX/csjg9YpdncBGPu1ysygFTiKmHZIoyeaRrhv56q2TZvEVBU23F1N5TJqI2afpc+RgoKMy8ks24L/9TKX1jdI1Hcg+BK6DFspgz2ZAPCIRshb9os8rxqNQ4jjTAZzaF4o8Iow2UZMllYPOWzqVMfMmOo5KdCiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746262250; c=relaxed/simple;
	bh=bRhZX7qJzEylBDKKpnJJPz7YbZmQ68Vz6HGR/JF11xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1+0bmkNViow3l7elHKRgyU9zM4LZ5coKbQpMx0aj9HG0MYjZ7OZBLdrtRRbE0OMM75Kz7Va7kTijlQSbE+uM3XMFbDaNzJXkoUFk7Sj1tp9IRFXefTn+m5+yDeu/nWd/Zsf3CAxX8/p9Owx0ro/MGh+BGZCl+LxCQaH7stY8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ps7tzs1O; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1746262239;
	bh=o/Ut0OjC7st/CMVCyN/mvb1GP04XULU8ewBoN+Ftf2E=;
	h=From:To:Cc:Subject:Date:From;
	b=Ps7tzs1OmXTYnkSYMNQYFcIAOWCyGgtBEL/GAilrSeCGyUT3pMemGBECLGtlKuvFf
	 NNMCZbxJygqEDxS6vSsTcZhakLqpGbVAXN26sylnQEhG6sGpWney0PSs3rmfsctTA/
	 o0tH7EPTqwNjhcJYNXptdwCNueCIVM+7RhlxD5Z8=
Received: from stargazer.. (unknown [113.200.174.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6039D65992;
	Sat,  3 May 2025 04:50:36 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Mingcong Bai <jeffbai@aosc.io>,
	Alex Davis <alex47794@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] bpf: Fix BPF_INTERNAL namespace import
Date: Sat,  3 May 2025 16:50:31 +0800
Message-ID: <20250503085031.118222-1-xry111@xry111.site>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit cdd30ebb1b9f ("module: Convert symbol namespace to string
literal") makes the grammar of MODULE_IMPORT_NS and EXPORT_SYMBOL_NS
different between the stable branches and the mainline.  But when
the commit 955f9ede52b8 ("bpf: Add namespace to BPF internal symbols")
was backported from mainline, only EXPORT_SYMBOL_NS instances are
adapted, leaving the MODULE_IMPORT_NS instance with the "new" grammar
and causing the module fails to build:

    ERROR: modpost: module bpf_preload uses symbol bpf_link_get_from_fd from namespace BPF_INTERNAL, but does not import it.
    ERROR: modpost: module bpf_preload uses symbol kern_sys_bpf from namespace BPF_INTERNAL, but does not import it.

Reported-by: Mingcong Bai <jeffbai@aosc.io>
Reported-by: Alex Davis <alex47794@gmail.com>
Closes: https://lore.kernel.org/all/CADiockBKBQTVqjA5G+RJ9LBwnEnZ8o0odYnL=LBZ_7QN=_SZ7A@mail.gmail.com/
Fixes: 955f9ede52b8 ("bpf: Add namespace to BPF internal symbols")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 kernel/bpf/preload/bpf_preload_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 56a81df7a9d7..fdad0eb308fe 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -89,5 +89,5 @@ static void __exit fini(void)
 }
 late_initcall(load);
 module_exit(fini);
-MODULE_IMPORT_NS("BPF_INTERNAL");
+MODULE_IMPORT_NS(BPF_INTERNAL);
 MODULE_LICENSE("GPL");
-- 
2.49.0


