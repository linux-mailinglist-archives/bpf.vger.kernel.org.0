Return-Path: <bpf+bounces-20729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763BC842541
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEDB27D7D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85066A32C;
	Tue, 30 Jan 2024 12:46:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05ED6A028;
	Tue, 30 Jan 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618777; cv=none; b=SvkcWvsP1Gt8qTinz5kVIxNOe1/4Rk3bAPHMsugSWM9XucH6jjOtlJa3msGsCIDdCJJrL0HKIfpdKFoTIsvqDRvnHK/ani+7fo807xHlwKINqSMQnapRpg8k4vgN7jGhWMXxs86JEjyljboGeyOzDXxNaGZlKbv55u9aT4xHlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618777; c=relaxed/simple;
	bh=/2gNL+Nc1XG3pfVM7gWrWXvlaCVPPhQKgII5jy8R/lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t63ZiXUa5GfymKCVCC7UZRfA3P3h49Rl2Kp/GuICf16cDXwJpvETKXerl+OfP2ynsIYWDYrgMhFdO467R3MFpmq7lBeqgXoG1PMn98yQhbTyFgzOrnYGU/Byr5dtSb99RJ8wcByHHnCK9oT8Hmop3ecy3WT/XT8xIGAaJieJcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPPzc4m6sz4f3lg0;
	Tue, 30 Jan 2024 20:46:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 262291A0199;
	Tue, 30 Jan 2024 20:46:11 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgCXZg+S77hllrfLCQ--.28270S2;
	Tue, 30 Jan 2024 20:46:10 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/2] Enable inline bpf_kptr_xchg() for RV64
Date: Tue, 30 Jan 2024 12:46:57 +0000
Message-Id: <20240130124659.670321-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXZg+S77hllrfLCQ--.28270S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfWw47Jr48Xr1kXrWkJFb_yoW3AwbEkr
	y8Xw1DXFyYvryIvF4UKas8t398KrW3Xry5ZryIgF42yw1aqFs8ZFWku3s3JryUZrs3Zry7
	JF4DXFWIyw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0
	eHDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

This patch is the RV64 implementation of inline bpf_kptr_xchg()[0]. RV64
JIT supports 64-bit BPF_XCHG atomic instructions. At the same time, the
underlying implementation of xchg() and atomic64_xchg() in RV64 both are
raw_xchg() that supported 64-bit. Therefore inline bpf_kptr_xchg() will
have equivalent semantics. Let's inline it for better performance.

link: https://lore.kernel.org/bpf/20240105104819.3916743-1-houtao@huaweicloud.com [0]

Pu Lehui (2):
  riscv, bpf: Enable inline bpf_kptr_xchg() for RV64
  selftests/bpf: Enable inline bpf_kptr_xchg() test for RV64

 arch/riscv/net/bpf_jit_comp64.c                           | 5 +++++
 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1


