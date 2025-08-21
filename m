Return-Path: <bpf+bounces-66216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08BB2FBCB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E80E1BA0104
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A02472A5;
	Thu, 21 Aug 2025 14:01:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014071F4281;
	Thu, 21 Aug 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784894; cv=none; b=BprdOOrAWVvk3uMBUvq6ZrKkUhA62n80XT38WLRZlWUJXNVLN5pXAi+88pB+yVreYFi6ZAmgk63Q8qW4YxGBA5tfugUAiERp7zc7bssORGK1gWkLzmqejQ8JGe28g7wZtjao/I9E6+OL8j72m1j25ZMJ0DEJdFUy919aN8/v/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784894; c=relaxed/simple;
	bh=3ehpm10K5W8NSlHoWMV6jzSx1aXWo0UGSFSZEK2dpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/B5CC7RYGMwtyzhGfi59VZjAjKNHlj+sPXxPpxNWkdcBirM8XulUYUjDYuHeaPKJLVRZaO4HcVKblnX4yDphLQ5lHqSCIrPKp2jwukLqjoOlsQhAHQx7JzkZnb7EsYPCBwVO4+Ey8CIVPmCg8lvgvuqBR6aBlha1HyPlvdPAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx2tG2Jqdo93UBAA--.2738S3;
	Thu, 21 Aug 2025 22:01:27 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpeSyJqdorsZdAA--.26328S2;
	Thu, 21 Aug 2025 22:01:23 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] LoongArch: BPF: Add more feature for trampoline
Date: Thu, 21 Aug 2025 22:01:20 +0800
Message-ID: <20250821140122.29752-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeSyJqdorsZdAA--.26328S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF4kCr47AF1xWF4DCrW8Zrc_yoWDWwcEkF
	yfKFyDGw18Wa4YqF9Fqr1fAryDuFW7JryrCF48XrZ5Kr17Xw45Ar4vy34Dur109rs3Xa98
	trnFyry0yryxuosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wryl
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWU
	AwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x07j5GYJUUUUU=

This is a RFC series, based on Hengqi's series [1]:

  LoongArch: Fix BPF trampoline related issues

The initial aim is to pass the following related testcase:

  sudo ./test_progs -a tracing_struct/struct_args
  sudo ./test_progs -a tracing_struct/struct_many_args
  sudo ./test_progs -a fentry_test/fentry_many_args
  sudo ./test_progs -a fexit_test/fexit_many_args

but there exist some other problems now, maybe it is related with
the following failed testcase:

  sudo ./test_progs -t module_attach

so just RFC for now, I will address the comments and send a formal
series once there are no problems.

[1] https://lore.kernel.org/loongarch/20250821091003.404870-1-hengqi.chen@gmail.com/

Tiezhu Yang (2):
  LoongArch: BPF: Add struct arguments support for trampoline
  LoongArch: BPF: Add 12 function arguments support for trampoline

 arch/loongarch/net/bpf_jit.c | 84 ++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 23 deletions(-)

-- 
2.42.0


