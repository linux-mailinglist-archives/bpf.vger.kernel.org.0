Return-Path: <bpf+bounces-29919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4564B8C81E2
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0205C28281E
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5C2E417;
	Fri, 17 May 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfMrcaQ7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140B2561D
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932628; cv=none; b=oCTLmJ8zRmq0lvtR6bsoSF+Mr+qMgVLbPJwSHRMNvviBZgYyCILg3VEuyH0sxgUjlbF+c5kmHL7WtDy5lDUjwrO86+8i1nLdERaXjYffLGGPdyk0GDdVRU0mpJXY0xM2xg8kPof7Ho7/6b/7lFyHZxNtKPHXNFevJYhBHnY0lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932628; c=relaxed/simple;
	bh=j4mDDIQXQY6Yt0ARbhylixXExzCaLztKBD5Eb//BJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEuRbY1fNH4pmaR3r0QyzaNN5cl7HN7FYa3mvG+9zkeFgXJFWlnPC7wPrNBH/iafyyKS9W1/zMriZTzjex19Pbr+YbIKWO61SAd9LglILx8uZvMLwWhxJ8KySGlDxTd2yMJ0r5KEiPqTmoGFlqshOkG/EaV7O+NoBjViVWW69fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfMrcaQ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+jG2UN45Z0JvX/V83PsUb5yMQORYV9ShWj2nAq73LA=;
	b=AfMrcaQ7jSHWoT0RH5nny082bxCUOZ0Mz/S1FKj7I62u5gL8cKpqwGCMqK7YNhP5Suow8G
	+pIazk5r/aBS8WQnkzk8WRZlxzOm5FodymAPokerM035HSzq1a2Wjzsacny3f3hBO1ivYh
	nQiOAK/vZqQJ7USkkeZOFT925I/ZKNw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-_AF1HgkKO6uhxaIdJBA8cg-1; Fri, 17 May 2024 03:56:59 -0400
X-MC-Unique: _AF1HgkKO6uhxaIdJBA8cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19FD6800074;
	Fri, 17 May 2024 07:56:59 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8184828E2;
	Fri, 17 May 2024 07:56:57 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 1/5] powerpc64/bpf: jit support for 32bit offset jmp instruction
Date: Fri, 17 May 2024 09:56:46 +0200
Message-ID: <20240517075650.248801-2-asavkov@redhat.com>
In-Reply-To: <20240517075650.248801-1-asavkov@redhat.com>
References: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add jit support for JMP32_JA instruction. Tested using test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 8afc14a4a1258..3071205782b15 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1053,6 +1053,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_JMP | BPF_JA:
 			PPC_JMP(addrs[i + 1 + off]);
 			break;
+		case BPF_JMP32 | BPF_JA:
+			PPC_JMP(addrs[i + 1 + imm]);
+			break;
 
 		case BPF_JMP | BPF_JGT | BPF_K:
 		case BPF_JMP | BPF_JGT | BPF_X:
-- 
2.45.0


