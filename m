Return-Path: <bpf+bounces-55636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89AA83B4B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14449444DDF
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D311DA0E1;
	Thu, 10 Apr 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw0DLouD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195113D81
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270466; cv=none; b=YZVnznt5wEnO1l3/N5kuzszWIVDZnWdrlww6rtGF3HrRfslyUBnPjnKbFJPSJJSVIEPG0ueC5KDEdOl8HwEi2hAkBB21vXGM7QHyNt6sqEXEI3YB+dwz4oamZI4YF7Q3hL7daaZ7vdbT15RPYP+UWuvIJXTAu916YVdFODwj/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270466; c=relaxed/simple;
	bh=vt6mknZ7+sC0mNdyGmOwZaugtThTxABezgQeKxiN74k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUpNqcYRy9+cbReZtdh4a9pHq6eRFy3R2U1A5ZXTLBaB1h3R8PTgseDOfNE3sjQq/q7jITyTQuQe7dwZpfAvLBZOZ9CHHKHBRmGfrnw7VcyAlGBGoXIkHEdFE34xzu7zlFF10Wo9jKwAq/7hfBsuxLDbWLtQrqWH1fvAr99sAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aw0DLouD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744270464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hUKh85SawJXQ9gIUyKo3C3ph1tVSVb43a5cr+zjYnI0=;
	b=aw0DLouDr3+FgGj5GX8/+29qmJhKYq269zIwCEzvElzQYqi+an/DhWJSaMWUJCwrBLcmv5
	0tGF0b+yRkEY/pJ5kSUsNF7YKV9FqsbIDVGU7CtJT5BfEx3bZPo1KmAr1S0ele28kNWIgL
	SqV/mCsMCW1RSqb+Pe+A47dchg57dRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-x5g7UozgPDuF9uaU8cTv1Q-1; Thu,
 10 Apr 2025 03:34:18 -0400
X-MC-Unique: x5g7UozgPDuF9uaU8cTv1Q-1
X-Mimecast-MFC-AGG-ID: x5g7UozgPDuF9uaU8cTv1Q_1744270456
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A50C1180035C;
	Thu, 10 Apr 2025 07:34:15 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFE3219560AD;
	Thu, 10 Apr 2025 07:34:11 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf] libbpf: Fix buffer overflow in bpf_object__init_prog
Date: Thu, 10 Apr 2025 09:34:07 +0200
Message-ID: <20250410073407.131211-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As reported by CVE-2025-29481 (link below), it is possible to corrupt a
BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
This can be done by setting a symbol (BPF program) section offset to a
sufficiently large (unsigned) number such <section_start+symbol_offset>
overflows and points before the section.

Consider the situation below where:
- prog_start = sec_start + symbol_offset    <-- size_t overflow here
- prog_end   = prog_start + prog_size

    prog_start        sec_start        prog_end        sec_end
        |                |                 |              |
        v                v                 v              v
    .....................|################################|............

Currently, libbpf only checks that prog_end is within the section
bounds. Add a check that prog_start is also within the bounds to avoid
the potential buffer overflow.

Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..d0ece3c9618e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (sec_off + prog_sz > sec_sz) {
+		if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
 			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
 				sec_name, sec_off);
 			return -LIBBPF_ERRNO__FORMAT;
-- 
2.49.0


