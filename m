Return-Path: <bpf+bounces-66224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50531B2FD37
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E638CA06C2F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EF323C515;
	Thu, 21 Aug 2025 14:43:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF201C8633;
	Thu, 21 Aug 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787391; cv=none; b=VPgpIp1PaQYuoonE4yySKTiDsMFv/NrN74r0DkmM0z/15rE2ZPJmLH+ZOLfocaWllNp31m50hK8/J8hzyP+blVQHXO9+0TKOmjeqpjHF908pJFlkD45r1+XafDtm+1A22LUzEQFYe7qlXVdAaIo37ingUdaur/gFyOplndVMD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787391; c=relaxed/simple;
	bh=CsN4eU3evTNdrqK03JAhq8/VxGqGePsdXOj1BPeP5OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMsYi5Q9CPGr8zkrl4Q9A7WAu5mEvuyid2EJAmgxr8jwI3+p7TEy0JvnESzoImueQH6MZ+VfckJZNhHixNJN44Y11k09VkRycAabXLMGl1ILxZ698ptpbIrkwrcWy2RPq3yeqr1ZtNTjuS9AR2CulwFFxzr1Z27GTS7C5lotnOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxvdJ4MKdo_HgBAA--.2681S3;
	Thu, 21 Aug 2025 22:43:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsF3MKdo0NpdAA--.294S2;
	Thu, 21 Aug 2025 22:43:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] LoongArch: BPF: Add more feature for trampoline
Date: Thu, 21 Aug 2025 22:43:00 +0800
Message-ID: <20250821144302.14010-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsF3MKdo0NpdAA--.294S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF17Ar4rCw4DJr1DGrW3urX_yoWkWrbEkF
	93KFyDCw48Wa4YqFy29rn3Ar9ruFWUGryrCF4qqrZ5KryxZr43Ar4vv34Duw1v9rs3Xa98
	KrnIvry0vryxuosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
	Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HSoJUUUUU==

Please ignore the previous version, the code is a mess.
Sorry for the noise, this version fixed the mess code.

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


