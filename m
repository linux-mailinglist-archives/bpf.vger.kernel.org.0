Return-Path: <bpf+bounces-77563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268ACEB2F7
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 04:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2C03031351
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2422798E6;
	Wed, 31 Dec 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A92Ksb5o"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1B27AC5C;
	Wed, 31 Dec 2025 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151263; cv=none; b=s2GikXf/ZYWzI1JbVs9aYZjgNks0sPdiZ7G+Pxb7/OKOY703J1kKE+ltvSE8GAVm4WXMJhTFR3HQfeKsAgQmoIU+4BXyF2D0S6Z2IS0d4x0AgEEfPNcdhC5sIkGze/L/ArFJIEdFczswI5g6aRu1CEwxhouUpe7xX0NZqSGm1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151263; c=relaxed/simple;
	bh=eF4lzxfurdEkr5lJeVdCG7Db4GdxUabVbr3og5Rp0to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPAcKOL6ZH2s60REgM+HemtrUU4uJfxRplAqXNnjie23YSDOxCcaWhWRJJlFbjcx4je1Tkk0MXx3nkNCm7Rmkf6hGwlnlifVP9VhbdVcToz38K70Kq+rS1+QLoR0q4uBqT8hACydOl9Wa/pVNMN1AEilqZauSHdJ60BHhuKHHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A92Ksb5o; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lN
	1yPOh+SetVp3e3T8DZPAME4gbgLWVgpv+1uWtZYyY=; b=A92Ksb5oVxwdRD67Tr
	i4o/XZ9wW987lXV+287rUpjwG/+7V2StCvprlIV1dRDNDP29pSy819d4YDyuYZBU
	mIdqsT+Y2CH1D1K3jynUDeulOFRdE3qPU1nwITvK9g1re1HG6eY+8sIT/r1i1VdE
	KUER9Xju3X2uMZwFyi5l7XI3U=
Received: from hello.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXEsjilVRpd40bJA--.1603S2;
	Wed, 31 Dec 2025 11:17:56 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	liangjie@lixiang.com
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
Date: Wed, 31 Dec 2025 11:17:54 +0800
Message-Id: <20251231031754.299998-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <69546dea.050a0220.a1b6.0306.GAE@google.com>
References: <69546dea.050a0220.a1b6.0306.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXEsjilVRpd40bJA--.1603S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWF1DurWkKrWfur1DuFW7Arb_yoWxWFc_Cr
	4UX3W8Krn8ua4a9w1jgwsxKFyUtr9xtF1v9w1jgFWkCF4DA3yrJFn3JFy3ZF9xGwn3GFZx
	AF9xWrn2qF1rZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1vzutUUUUU==
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbDAAQOLmlUleQAHgAA32

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3f0e9c8cefa9

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 69988af44b37..2bc27ece5cc5 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1768,6 +1768,9 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
        ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
        storage = ctx->prog_item->cgroup_storage[stype];
 
+       if (unlikely(!storage))
+               return (unsigned long)NULL;
+
        if (stype == BPF_CGROUP_STORAGE_SHARED)
                ptr = &READ_ONCE(storage->buf)->data[0];


