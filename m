Return-Path: <bpf+bounces-42013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F399E639
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5DC1F24BDA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369631EB9EC;
	Tue, 15 Oct 2024 11:39:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174971E7C34;
	Tue, 15 Oct 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992362; cv=none; b=I4xr2kzwNOvXtizF2PC7lRL/KuNzxOQ07za09WneaIje3Eq09mjUg/bPX6frd2GAbFJsAvc9RINHz4dKrM3bTdUmoqEkC2i+41cAKsH5CFwwZiyetKcJ/SE7FQV7e5L2p9vQYlbKbJ3jTFguZgxfPuZdw42e3y8S23odnGidxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992362; c=relaxed/simple;
	bh=Qoevy3HsJ2F1T21Ko4XdJUAf8D3PMpWFP3mtbgztVfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0mFPHSsXQYBtSme6MfJdu+vryT7Tlj7Jc8iznYqCm+YgknyvGduD0vKFyU7u00yj4EZsU19HWv2YPBiDKf0CuB4AnzhV+S/O8Q1/uAGDPr8lViFCH8bV+4jkDE4qG5BOewWW95/LZ+g01eiAeBqxWnZarhIY1zEwJs1IokAJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxQYhlVA5n4n8dAA--.42725S3;
	Tue, 15 Oct 2024 19:39:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMCxbcdkVA5n6E0uAA--.9583S2;
	Tue, 15 Oct 2024 19:39:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Add jump table support for objtool on LoongArch
Date: Tue, 15 Oct 2024 19:39:09 +0800
Message-ID: <20241015113915.12623-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxbcdkVA5n6E0uAA--.9583S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtrW3JrW7JryUJw1ftrWfXrc_yoWDKFc_Gw
	n3ua4kCr4rWay7tFyjqrn5WryjkF48XFZYya4vvr47Gry5Ar1DWF4j93Z0vrWkKrWfuFs8
	GrWktF1vkr1j9osvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==

This series is based on 6.12-rc3, tested with the latest (20241012)
upstream mainline binutils and gcc.

The first three patches are to support the jump table of switch cases,
the last three patches are to support the jump table of computed gotos,
patch #4 is a small change of kernel/bpf/core.c, the other patches are
related with tools/objtool and arch/loongarch.

Tiezhu Yang (6):
  objtool: Check various symbol types for jump table
  objtool/LoongArch: Add support for jump table
  LoongArch: Enable jump table for objtool
  bpf, core: Add weak arch_prepare_goto()
  LoongArch: Define specified arch_prepare_goto()
  objtool/LoongArch: Add support for goto table

 arch/loongarch/Kconfig                 |  9 +++-
 arch/loongarch/Makefile                |  5 +-
 arch/loongarch/include/asm/compiler.h  | 13 ++++++
 kernel/bpf/core.c                      |  9 ++++
 tools/objtool/arch/loongarch/special.c | 63 +++++++++++++++++++++++++-
 tools/objtool/check.c                  | 20 ++++++--
 6 files changed, 109 insertions(+), 10 deletions(-)
 create mode 100644 arch/loongarch/include/asm/compiler.h

-- 
2.42.0


