Return-Path: <bpf+bounces-42552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57F9A5887
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86280B21842
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3B12E5D;
	Mon, 21 Oct 2024 01:28:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C41BC3F
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474086; cv=none; b=K19fHyN76z1EUKx9ho7AsbPvqTPDRAe04FKr5pZbzBb4GHH80xGgDqqfYUwkiKoJvovYWkMHFKrhNkBg2ccDPTGcdWGrTMZ3aRLIFAU6TXhd2V+hdBMUrbWbCwZsWjCMxoFR3Xkc+emhwJ2sBeO3VuYW0T+/aBYXj6Fai1IeAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474086; c=relaxed/simple;
	bh=FxE4hBRImd6TQgABYG1LUZ2TaE/ivkf7nN2thlViXIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKEAfXljfkHcCf+aX2vC3BFW6bSEaYsHDjTjOtxCVIXvDixwHTOajfqwfWtj00ufASw1ExAlKwZt9e8nDhciBM0WR71rsfOxVklfqT2DLTAta4INDfX7juoMqXN+cZwf+PE+zidAlQVAa0FsclSNOKlb/j9A+oLZBlLnbBhVaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XWyNZ4lMPz4f3jjx
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DACF51A092F
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S4;
	Mon, 21 Oct 2024 09:27:53 +0800 (CST)
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
Subject: [PATCH bpf v2 0/7] Misc fixes for bpf
Date: Mon, 21 Oct 2024 09:39:57 +0800
Message-Id: <20241021014004.1647816-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8tw1DWF1UZrW7GFyxuFg_yoW8Ww4UpF
	WFgw15Wr48JFW7Z393Kw1I9FyrGan2gFy8WFyagw1YyFy3ZF10gr18Kw4Y9F98JrWftF1S
	qr18KF9Yga4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set is just a bundle of fixes. Patch #1 fixes the out-of-bound
for sockmap link fdinfo. Patch #2 adds a static assertion to guarantee
such out-of-bound access will never happen again. Patch #3 fixes the
kmemleak report when parsing the mount options for bpffs. Patch #4~#7
fix issues related to bits iterator.

Please check the individual patches for more details. And comments are
always welcome.

v2:
 * patch #1: update tools/include/uapi/linux/bpf.h as well (Alexei)
 * patch #2: new patch. Add a static assertion for bpf_link_type_strs[] (Andrii)
 * patch #4: doesn't set nr_bits to zero in bpf_iter_bits_next (Andrii)
 * patch #5: use 512 as the maximal value of nr_words
 * patch #6: change the type of both bits and bits_copy to u64 (Andrii)

v1: https://lore.kernel.org/bpf/20241008091718.3797027-1-houtao@huaweicloud.com/

Hou Tao (7):
  bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
  bpf: Add assertion for the size of bpf_link_type_strs[]
  bpf: Preserve param->string when parsing mount options
  bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
  bpf: Check the validity of nr_words in bpf_iter_bits_new()
  bpf: Use __u64 to save the bits in bits iterator
  selftests/bpf: Test multiplication overflow of nr_bits in bits_iter

 include/linux/bpf_types.h                     |  7 +--
 include/uapi/linux/bpf.h                      |  3 ++
 kernel/bpf/helpers.c                          | 45 +++++++++++++++----
 kernel/bpf/inode.c                            |  5 ++-
 kernel/bpf/syscall.c                          |  2 +
 tools/include/uapi/linux/bpf.h                |  3 ++
 .../selftests/bpf/progs/verifier_bits_iter.c  | 14 ++++++
 7 files changed, 63 insertions(+), 16 deletions(-)

-- 
2.29.2


