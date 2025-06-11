Return-Path: <bpf+bounces-60292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6140DAD48DB
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C8D189D5C5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8B17A300;
	Wed, 11 Jun 2025 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfFZNpRb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB613F434
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608832; cv=none; b=O3Cn+J3PbhHXaJQzaxHwIrf8k0pSizwUt+3HbVrZW6pZ0fOTquFTO4cCAqDCBkaZr5OCad//kMoUyMkP0QVTLEUntDHPQcO4DSj9A3rIbY0FgysH3CZtRBAjJAKV0HZXTZcnYOIUFysE2Ix+2H51pmAenrNUz1dXE1LYYonOiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608832; c=relaxed/simple;
	bh=Fiq58Sa4QePsxdWSTj3XvjPLT5ZNgz4LG8iWzPI+yak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dP/6EggR37a0n+FlXEiBpeTeVc9Hk7YFdOUObsdUsJ+tOx6/tmJxrYH5+OvNGPE9EvDVvGGZ0DyD/f1EtaZr/EtIj7vd5zy+6CI1bcTyDZiHWoN+P1pSOFoWs6BT+edekTkosM35ogMl7Q1vUI/uKBeOaL572Tol0j819r8rWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfFZNpRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749608828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9oH1uonxI0Sglm5wymhiE86CF0kAPtwdmbbSnYdghw=;
	b=BfFZNpRbnH3DKI22B5FF8xMOaSkCPT0MYS/3x36yk8+I7cseoiXXczpWdqoddFeutlplk+
	ZMX5uHPZitvgwFTbSx9kav6CzN8VPnFG52J3H00VgY1M43viL8jcCGfnktShbeNqv4Kfkb
	QuewnckmOu4qfe6nSqbYvmkgt2sUCwE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-s--suC9ZMbGOjfaj68MQBA-1; Tue,
 10 Jun 2025 22:27:05 -0400
X-MC-Unique: s--suC9ZMbGOjfaj68MQBA-1
X-Mimecast-MFC-AGG-ID: s--suC9ZMbGOjfaj68MQBA_1749608824
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E8FC19560B7;
	Wed, 11 Jun 2025 02:27:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C032E19560A3;
	Wed, 11 Jun 2025 02:26:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] tools/kexec: Introduce utility to build zboot image with bpf section
Date: Wed, 11 Jun 2025 10:26:44 +0800
Message-ID: <20250611022646.7970-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The series '[PATCHv3 0/9] kexec: Use BPF lskel to enable kexec to load PE
format boot image' [1] makes the kernel ready to load PE files with .bpf
sections. These two patches integrate the zboot-bpf image builder into
the kernel source tree, so users can conveniently generate the final image
with the command:
    make -C tools/kexec zboot
Later, the infrastructure for UKI can also be organized here.

To facilitate the review, I have pushed the whole series, including the kernel part,
to GitHub [2]. There is a slight difference from [PATCHv3 8/9] 
"kexec: Integrate bpf light skeleton to load zboot image" in [1]. This
difference is made in the function get_symbol_from_elf() to accommodate
clang's behavior, which combines the section header string table and normal
string table into one.

[1]: https://lore.kernel.org/bpf/20250529041744.16458-1-piliu@redhat.com/
[2]: https://github.com/pfliu/linux/tree/kexec_bpf_v3%2B

Pingfan Liu (2):
  tools/kexec: Introduce a bpf-prog to parse zboot image format
  tools/kexec: Add a zboot image building tool

 tools/kexec/Makefile              |  89 ++++++++++
 tools/kexec/pe.h                  | 177 +++++++++++++++++++
 tools/kexec/zboot_image_builder.c | 279 ++++++++++++++++++++++++++++++
 tools/kexec/zboot_parser_bpf.c    | 157 +++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_image_builder.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

-- 
2.49.0


