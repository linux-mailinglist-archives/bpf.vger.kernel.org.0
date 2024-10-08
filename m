Return-Path: <bpf+bounces-41215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBE9943A4
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D431F22694
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69F1C2309;
	Tue,  8 Oct 2024 09:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC618C900
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378312; cv=none; b=NXJAXS0txNnPMFAl32LkDK8LVr4+bzVt1X/pCTR5DjurQ+5OyTDXDmaEQndX0K6msoHvPZOqQxXUxr7ESKQk4cuP8K3CIjt83aXVjkJVeP79uEiMzy0AP2b/BVmFbVJdvkXQxFlGEKZo2D2onxRAptWCDX55q9zT6lCM1RA8fLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378312; c=relaxed/simple;
	bh=Vj38HuPD0FeLda463RqNmUmIlqtdDrsUCOocTMRumUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTijMuxv179dFKgzxwrAIq8qON6mKOU2V+A9Sfc7MdkCCWzfE7FwOigyMYklGVdvEKAzR4Upb8nKK73Of5KKV7AYsKF3ZX4AZGkE6Ni4n8ta/K1dVAvuLhXmUdfiB0yXP3KdwtdHVpPUDgb6bTGFGEDnRjS10gUUd16q1nC4NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9815tsTz4f3lfj
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5D8131A0568
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S4;
	Tue, 08 Oct 2024 17:05:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf 0/7] Misc fixes for bpf
Date: Tue,  8 Oct 2024 17:17:11 +0800
Message-Id: <20241008091718.3797027-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyUArW8Wry7uw18KryrtFb_yoWkGFb_uF
	Wrtry8Gw4UuFn3K3ZYvFs3ZrWFyan0vr48uF95Jry7ZFy3AF4rJr48tryjv34UXF4DArW3
	JrsrX3yv9w1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ4SrUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set is just a bundle of fixes. Patch #1 fixes the out-of-bound
for sockmap link fdinfo. Patch #2 fixes the kmemleak report when parsing
the mount options for bpffs. Patch #3~#7 fix issues related to bits
iterator.

Please check the individual patches for more details. And comments are
always welcome.

Hou Tao (7):
  bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
  bpf: Preserve param->string when parsing mount options
  bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
  bpf: Check the validity of nr_words in bpf_iter_bits_new()
  bpf: Change the type of unsafe_ptr in bpf_iter_bits_new()
  selftests/bpf: Test multiplication overflow of nr_bits in bits_iter
  selftests/bpf: Pass a pointer of unsigned long to bpf_iter_bits_new()

 include/linux/bpf_types.h                     |  1 +
 include/uapi/linux/bpf.h                      |  3 ++
 kernel/bpf/helpers.c                          | 30 +++++++++-----
 kernel/bpf/inode.c                            |  5 ++-
 .../selftests/bpf/progs/verifier_bits_iter.c  | 40 +++++++++++++------
 5 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.29.2


