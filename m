Return-Path: <bpf+bounces-31032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7788D6464
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757071F21C0C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1031C6BD;
	Fri, 31 May 2024 14:22:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A862208C4;
	Fri, 31 May 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165357; cv=none; b=cUY3VnIMIwiXl+nVnAL1WGvjrrTdEb9jCsABy1yhFTqOibk+ooEN/Y+r6E/xb/aEFqP52dnRO1rxP/hlqRErh/qptXDMp33q0cN+RY9xtVnaVkzVMgK+QbAa6PXDOrDSoyge7dofNzWJPleQNNAql0ganSmLeManonhFBtK70xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165357; c=relaxed/simple;
	bh=F+yy/4YYtrR9gORVXUp7B1vHxhm3wJ4+6lZ4yeR4XoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8WJ0a/2ZRwszlt2bkl18woPSNBpmUA1L4sCVKXlxQmkz51ddm2Ux1kQmrTfg7d3P4R9NmiA7bA2vDpJDC6lDqLunvfCmoJHs6XQHdnSXOheJ+vb3HQLyVy4pwnBsDhKWx7OS4ZdyPfvyWn3Ro4kvVxBuTCelFQ9xiHKsPGEBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 7BB4A2F20243; Fri, 31 May 2024 14:22:34 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 3E7662F20241;
	Fri, 31 May 2024 14:22:34 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	dutyrok@altlinux.org,
	oficerovas@altlinux.org
Subject: [PATCH v2 5.10.y 0/2] bpf: fix warning in ftrace_verify_code()
Date: Fri, 31 May 2024 17:22:29 +0300
Message-Id: <20240531142231.51068-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was found by syzkaller.

The reproducer and the detailed warning log can be viewed here [1]

[1] https://lore.kernel.org/bpf/20240129091746.260538-1-kovalev@altlinux.org/#t

Capability cap_sys_admin is required for reproduce and on kernels with panic_on_warn
enabled it will cause the system to crash.

v2:
Added an additional patch that fixes a build error by the clang compiler.

To solve the problem, it is proposed to backport the following commits:

[PATCH v2 5.10.y 1/2] bpf: Convert BPF_DISPATCHER to use static_call() (not
[PATCH v2 5.10.y 2/2] bpf: Add explicit cast to 'void *' for


