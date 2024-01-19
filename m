Return-Path: <bpf+bounces-19883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC783279D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE24F1C235FD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4063CF5F;
	Fri, 19 Jan 2024 10:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263A3CF4B
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659879; cv=none; b=EmtCV25NGRQ5U7/ZTjLjjjPBkh1CxpYM/f4MEBth6Vqq4U26RGwCxuyzQcNKQfz3IwJL20U/skQjS3I45J2qyI3w7vFgKpRC0aVPKm9jn6zciCpgNVW0p442ADfTLF5Exgfw3Y5Oj91mk/3VSDJBvNsxQUWrK3kRWOh94F5GJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659879; c=relaxed/simple;
	bh=DtbjQTcTZjqo5Te7YgwoOyM5D4AuPWXGFH4onXClE1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luC/58f9WKZXFTvX1OHEHzXDRw2EergZtrbBobuiUktlt6d0Y6i4u7c4I4BNp8vHHFcKyZPZra3q71dW/jd/4GTSx+ITdzI5kd+8egs+MsVaWSpZxkRVbdGywUlMJtdIiWXaCfXZMCd7Gy4OzvkhG0tsJAF/On1ZsfdPQ/8W3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGbMH3MFHz4f3m6f
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9E8491A0172
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHfTapl+I07BQ--.50408S4;
	Fri, 19 Jan 2024 18:24:33 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 0/2] Enable the inline of kptr_xchg for arm64
Date: Fri, 19 Jan 2024 18:25:27 +0800
Message-Id: <20240119102529.99581-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBHfTapl+I07BQ--.50408S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	3rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set is just a follow-up for "bpf: inline bpf_kptr_xchg()". It
enables the inline of bpf_kptr_xchg() and kptr_xchg_inline test for
arm64.

Please see individual patches for more details. And comments are always
welcome.

Hou Tao (2):
  bpf, arm64: Enable the inline of bpf_kptr_xchg()
  selftests/bpf: Enable kptr_xchg_inline test for arm64

 arch/arm64/net/bpf_jit_comp.c                             | 5 +++++
 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.29.2


