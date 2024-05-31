Return-Path: <bpf+bounces-31028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433038D6462
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60040B2CE51
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC291BF40;
	Fri, 31 May 2024 14:19:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF63207;
	Fri, 31 May 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165142; cv=none; b=l6A6Lq37q0kijSVxlMmcyugB/2/J0OYJIDdClTjp91NVnqPFG0l8qL2Ae2XtS49GjJo6gH8hsGNKTqJGd2RqYvYudWpz+TWrt4BNoEhPTqVrlcb/HieaGmgJtU/03AvJOg/TBEPp9808sQSTWRr4zDc/vX38TK9cAHdztHX/uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165142; c=relaxed/simple;
	bh=T/tgrZGzX5kIIAohjtVlP0R5LHdtPEasggR6Q5BYNRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3oX/OBWKjTARjQLFjZswQvJzXY0Y2MwlNbxyuImh2kefnCODxr7joZ20H1dIDs9jtNu1oVKhmivP/Ddp6WXoCYEBANUAg/tgbSZ0okEZ2cqv91Wvn3gVfuNiY0bSdYEh3exPcjVXRAbd1lMRPsjl3JMNdkiu6CcGoFYjgrTAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 44C742F20242; Fri, 31 May 2024 14:18:52 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 16A922F2022C;
	Fri, 31 May 2024 14:18:52 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kovalev@altlinux.org,
	dutyrok@altlinux.org,
	oficerovas@altlinux.org
Subject: [PATCH v2 5.15.y 0/2] bpf: fix warning in ftrace_verify_code()
Date: Fri, 31 May 2024 17:18:44 +0300
Message-Id: <20240531141846.50821-1-kovalev@altlinux.org>
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

[PATCH v2 5.15.y 1/2] bpf: Convert BPF_DISPATCHER to use static_call() (not
[PATCH v2 5.15.y 2/2] bpf: Add explicit cast to 'void *' for


