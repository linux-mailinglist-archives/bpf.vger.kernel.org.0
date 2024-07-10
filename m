Return-Path: <bpf+bounces-34371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20F92CE2C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F77287315
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881918FA02;
	Wed, 10 Jul 2024 09:29:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52B84A5B
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603764; cv=none; b=faMd7UEAnlkl/A31ltOhqTpt5M0HqjTgCxfdsOE4KyRrUTu59ts5ShAB28z0fnQGRh0hn7IVcSYgYTji/HpNG5DGEjtn7+Nlat1Kg7U2JMIobHqzv5zFtevgNU/pXTDbT+ICbMhaTbvmjcftQOS9ommz6+u+p+KfzTNaVZi2dLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603764; c=relaxed/simple;
	bh=S1WeR/OyACfMzeh4TDkMigicDJE9EghHb9u9Im53g38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1GscDcVpFT04fr6HzgQfYje+A0xUCKPFWEKa9dHfs8n1tyjw822zrKsBTTX/Y0I8Uv39OXzSei4ZYFsiy5yKfxsr/myXNDByzXK/FjNPGaL7qVyHXkrghhlisCrY5jOeH+MHTG0uF7DBJ2bYHNRUgfh0JWqyYRTIYuR3+ZS6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJsxY2Wmrz4f3jMB
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 35F7A1A0D9A
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:18 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP3 (Coremail) with SMTP id _Ch0CgCXpF5jVI5mTxF_Bg--.1219S2;
	Wed, 10 Jul 2024 17:29:16 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	hffilwlqm@gmail.com
Subject: [PATCH bpf v3 0/3] bpf: Fix null-pointer-deref in resolve_prog_type()
Date: Wed, 10 Jul 2024 17:29:01 +0800
Message-Id: <20240710092904.3438141-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXpF5jVI5mTxF_Bg--.1219S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr15Wr1fArWkGrykXryDtrb_yoWkXFX_A3
	yxKrykJ397KFWF9FyI9Fn3ZryDCr48XryktF1jqrZrXrW3Wr1UArs3G3s3Za4F93y0qFWq
	yF4DAa9avr13ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

v3: 
 - Add a small selftest for the BPF CI, and split 1-patch into
   3-patch series as recommended by Daniel.
   https://lore.kernel.org/all/d16b4f29-8966-464f-b530-35e39fda3f46@huaweicloud.com/

v2: 
 - Fix libbpf_probe_prog_types test failure reported by CI by
   adapting libbpf code. (thanks for jirka's reminder)

v1: https://lore.kernel.org/all/20240620060701.1465291-1-wutengda@huaweicloud.com/

Hi,

This series is going to fix null-pointer-deref in resolve_prog_type()
for BPF_PROG_TYPE_EXT.
Patch 1 is the kernel-only fix, patch 2 is the libbpf one, and patch 3
is a small BPF selftest.

Best regards,
Tengda

Tengda Wu (3):
  bpf: Fix null pointer dereference in resolve_prog_type() for
    BPF_PROG_TYPE_EXT
  libbpf: provide a valid attach_prog_fd before probing
    BPF_PROG_TYPE_EXT type
  selftests/bpf: Test for null-pointer-deref bugfix in
    resolve_prog_type()

 kernel/bpf/syscall.c                         |  5 ++++-
 tools/lib/bpf/libbpf_probes.c                | 13 ++++++++++++-
 tools/testing/selftests/bpf/verifier/calls.c | 13 +++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.34.1


