Return-Path: <bpf+bounces-29636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4608C3FCC
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460DB283449
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFD14C593;
	Mon, 13 May 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJkrPmXV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCD14A60A
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599627; cv=none; b=PADJcyzRLHHxaz5344yL6R1AAWjCOEVLSAdoDACSrg+uCrBDfhFxmORn5VwbCyyaPc1D46ENi8Ys5WtTr7lF1MYLB/OvwJKtRqLFgHslX/YqN/UOsKzCjirrqJv7OQqBjCE3+5VhW4t9l/LK66Xu/P8yt5W/zRR82Czy8jy9uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599627; c=relaxed/simple;
	bh=0k5DBiev6Hez4iRlP0Z+hV0EZ/1rw9D59hE5bmw14XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pwypmmc1njj4F9tqNcNoUwsgOX34L5WRCGwE1kZ6NNp0gU1eq3FgOoAt5cRw9xRrKOZjjLEmu6+GdHvYSP9eZkgMmV1FtY1v96mVuDMYQV63NiP1MpNAnjw2bdCVkWqjsxXR6ARmwrW9rUMDzZsZ67MR1N8c0JHE07sq19mBSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJkrPmXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715599625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54evBAuhpnIbgDCbHAgBJwdKwEdND6gn70BNk2pLCuo=;
	b=PJkrPmXV+acSWWWK3uqRpsZQDUphBLA3arwEH/onpOMwdhhsdy/Dd/SDT8zRJTB+mx8VwJ
	JsCWwZ+TkcYiWSssGt/tJ5Ce3BotmNmBOjPaRk1JTBxSSoH5KjSqwNZAqSmO8PaK5vyqSv
	0COuiNVSY6EHn5Ft3pKZDLVKSef1znw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-b22GMANPMli0g95TKxwUrg-1; Mon, 13 May 2024 07:27:02 -0400
X-MC-Unique: b22GMANPMli0g95TKxwUrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D328025F9;
	Mon, 13 May 2024 11:27:01 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC691C00A90;
	Mon, 13 May 2024 11:27:00 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH bpf-next] bpftool: fix make dependencies for vmlinux.h
Date: Mon, 13 May 2024 13:26:58 +0200
Message-ID: <20240513112658.43691-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

With pre-generated vmlinux.h there is no dependency on neither vmlinux
nor bootstrap bpftool. Define dependencies separately for both modes.
This avoids needless rebuilds in some corner cases.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/bpf/bpftool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dfa4f1bebbb31..ba927379eb201 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -204,10 +204,11 @@ ifeq ($(feature-clang-bpf-co-re),1)
 
 BUILD_BPF_SKELS := 1
 
-$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 ifeq ($(VMLINUX_H),)
+$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
 else
+$(OUTPUT)vmlinux.h: $(VMLINUX_H)
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-- 
2.44.0


