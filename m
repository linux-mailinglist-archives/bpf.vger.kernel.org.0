Return-Path: <bpf+bounces-79430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E948D3A237
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E13E530164EE
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926A3502A1;
	Mon, 19 Jan 2026 08:55:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137052737E0
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812956; cv=none; b=cyXBBiKyNbUuseYaVyToVKP9vf/FFqEQa20hJ0a9JpCHxjVXSFvr/O68O3UDKADeBlcZzulAM0O8MAinSgBSISjmFPOHWmFx5GQRSbJmBBAuTOZjnLPS59kVPnpbg+DgcQ5+f+gD3vVsXPJghhZYhNPDwOKNK2yrdMeFjB1u7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812956; c=relaxed/simple;
	bh=gOhvDH93zh8NkI1rdZSQOghpr0vaj99Y6w+lE8eph2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssalXLqFuZh4HORsqtGbwDaoqvwabwL+uEoZnhy5T9tY04nkPXzEafwKp5I8iF5DQ2fP7PVfG5ua8tNs0CQWjX+LKcT1uw0dBAXTpOiz/+TxPJPYZntx2gdaEYtm+msnylpF32N7qR3vBkV6q2p+TgZDxreD+ANvYf23ohDzNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.146.110])
	by mtasvr (Coremail) with SMTP id _____wBHt4Rz8W1plPwUAA--.2182S3;
	Mon, 19 Jan 2026 16:55:16 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.146.110])
	by mail-app4 (Coremail) with SMTP id zi_KCgA374Vv8W1p4GvDBA--.48919S2;
	Mon, 19 Jan 2026 16:55:11 +0800 (CST)
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
Subject: [PATCH bpf-next v5 0/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
Date: Mon, 19 Jan 2026 16:54:56 +0800
Message-ID: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgA374Vv8W1p4GvDBA--.48919S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgEQCmltN4UddgAAsA
X-CM-DELIVERINFO: =?B?LhlJRQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9KFgznEAH4auKavWXd7s/Kqnp72LWYVu47AW1z/EyI6qIU9Vrjxz8F6EmG779ozFRnav
	VzXR8IES8SA/qA3mnfm795tMF2osc7HeYfTOI58u0HcCMVWIzWlXlu+6s623Gw==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw18uw4xur1UJFy8Kr4fXrc_yoW5Xw15pr
	s7JFnxGr1vyayIyry7A3yxZrW5Aan8tw4xWrnYy3y3Za15Zry8WFWxKrW5Cr9xtrZ7W3WF
	vF12qwnFva4qvFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Changes v4 => v5:
1. Rename helper functions `__reset_reg(32|64)_and_tnum` to
   `reset_reg(32|64)_and_tnum`. (Alexei)
2. Replace plain C division with `div64_u64` and `div64_s64` for 64-bit
   operations, ensuring compatibility with 32-bit architectures. (Alexei
   & kernel test robot)
3. Fixup an indent typo in selftest file `verifier_div_mod_bounds.c`.

v4: https://lore.kernel.org/bpf/20260116103246.2477635-1-tangyazhou@zju.edu.cn/

Changes v3 => v4:
1. Remove verbose helper functions for "division by zero" handling. (Alexei)
2. Put all "reset" logic in one place for clarity, and add 2 helper
   function `__reset_reg64_and_tnum` and `__reset_reg32_and_tnum` to
   reduce code duplication. (Alexei)
3. Update all multi-line comments to follow the standard kernel style. (Alexei)
4. Add new test cases to cover strictly positive and strictly negative
   divisor scenarios in SDIV and SMOD analysis. (Alexei)
5. Fixup a typo in SDIV analysis functions.

v3: https://lore.kernel.org/bpf/20260113103552.3435695-1-tangyazhou@zju.edu.cn/

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
  bpf: Add range tracking for BPF_DIV and BPF_MOD
  selftests/bpf: Add tests for BPF_DIV and BPF_MOD range tracking

 kernel/bpf/verifier.c                         |  299 +++++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../bpf/progs/verifier_div_mod_bounds.c       | 1149 +++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |    7 +-
 .../testing/selftests/bpf/verifier/precise.c  |    4 +-
 5 files changed, 1456 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c

-- 
2.52.0


