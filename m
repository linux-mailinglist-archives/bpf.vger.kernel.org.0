Return-Path: <bpf+bounces-78686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB8D18175
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0F4305435A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEA32A3FD;
	Tue, 13 Jan 2026 10:36:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A7328638
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300603; cv=none; b=pQvC8jSMJ46YApM2zHT2KIf/7gQ62S+C44RcKnxcuztPlV1dZLhD11EZlx1CTS7sUGuhazcJjZyFemmApeWcMID16aa/9X7DzmOR5ENIEbMRWfprPb2K4QWesFso8ytU+Ypu2BVDcAyhMY5k/4v4ymYX6T8tz9qSNVsfNEEEHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300603; c=relaxed/simple;
	bh=FExNkUbalhhQd+6D4AY2k/YVafve2S4xJglq6rMTDPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkB7jAH1EZMQUCHvihBMX1Mcq0UZXpiEu3wkpzlZDwt62b86WMmGidbfh73AwZjk2SDFz7KjD4PUVYqaclQtUylFvqy7LOWOXtlU55jm47UhXhE/g9ShHHuk7pYFeSEJnaCZ4UiW6dINKWIIeHTIA0WjBqGfrKTVZjU19N6YypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wAn1FUUIGZppli6AQ--.5801S3;
	Tue, 13 Jan 2026 18:36:06 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHim0TIGZppciSBQ--.11589S2;
	Tue, 13 Jan 2026 18:36:03 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v3 0/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
Date: Tue, 13 Jan 2026 18:35:50 +0800
Message-ID: <20260113103552.3435695-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHim0TIGZppciSBQ--.11589S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAggFCmletwUeXgADsD
X-CM-DELIVERINFO: =?B?1egbngXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9B+mI5GDwxuQL0PB6Ii/1UocuRltjxuCpulrqia+ILTpvRYMyOY4Dn2vTFhXsp0Oq/BE
	Rr4Vcg5C7DwbRuqdurhMyUhPCZbW0X/fGaAQhratGTirJVlFCA8o76jhdfW1XQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWxCw4rGF17XFWrtw4DJrc_yoW8WrWfpw
	s7K3ZxKryvkay7tFy3CFy7Zry5J3ZYyw47urn3Ar9xXa1UAFy8WrWxKry5Cr9xtrZ3W3WF
	vF12q3ZF9a4qyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

Add range tracking (interval analysis) for BPF_DIV and BPF_MOD when
divisor is constant. Please see commit log of 1/2 for more details.

---

Changes v2 => v3:
1. Fixup a bug in `adjust_scalar_min_max_vals` function that lead to
   incorrect range results. (Syzbot)
2. Remove tnum analysis logic. (Alexei)
3. Only handle "constant divisor" case. (Alexei)
4. Add BPF_MOD range analysis logic.
5. Update selftests accordingly.
6. Add detailed code comments and improve commit messages. (Yonghong)

v2: https://lore.kernel.org/bpf/20251223091120.2413435-1-tangyazhou@zju.edu.cn/

Changes v1 => v2:
1. Fixed 2 bugs in sdiv32 analysis logic and corrected the associated
   selftest cases. (AI reviewer)
2. Renamed `tnum_bottom` to `tnum_empty` for better clarity, and updated
   commit message to explain its role in signed BPF_DIV analysis.

v1:
https://lore.kernel.org/bpf/tencent_717092CD734D050CCD93401CA624BB3C8307@qq.com/
https://lore.kernel.org/bpf/tencent_7C98FAECA40C98489ACF4515CE346F031509@qq.com/

Yazhou Tang (2):
  BPF_DIV and BPF_MOD
  BPF_DIV and BPF_MOD: new tests

 kernel/bpf/verifier.c                         | 326 ++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_div_mod_bounds.c       | 781 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
 .../testing/selftests/bpf/verifier/precise.c  |   4 +-
 5 files changed, 1115 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c

-- 
2.52.0


