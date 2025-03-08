Return-Path: <bpf+bounces-53645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED7A57A8C
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F33B3403
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72C1CAA6A;
	Sat,  8 Mar 2025 13:39:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309A1C6FED
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441157; cv=none; b=UwS800y78zyhLWfZh5QOzvRex/CsBPhvs2Ld7DjWM7MWfZU2JWNXy8dkm2R8Sok9S/X9dd7ukkO4yQloX387+lz27Eb0yCeKzN0p5qKE0F1zoCuVzxyHUHcOpSVJCRDTkbnaV9L3MYKrleFgkkYEFCI1W/ImB3NVI0Lcm+DLWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441157; c=relaxed/simple;
	bh=v3iW8C83mYC7j1QkyleEzH8asJ9feXIubUtMbx+pBMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8dlRJOhpWwsGesk6LbIw85b9R6wNPeCKC2CKiaUM83iOXHNG/VSWOm2fyjZeTYbD18dF/ZTwBDYWn3lXEEaCXwrf7U/ciFZP3c2XChMw5JlZlI6LA1iKq13lz4h6/POIwyuMbYdI+bReNXAXvAm0m/gRb/1MtScqsg+MKaY60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z944K6fZVz4f3mHH
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CD0A1A1587
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S4;
	Sat, 08 Mar 2025 21:39:03 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 0/6] bpf: Support atomic update for htab of maps
Date: Sat,  8 Mar 2025 21:51:04 +0800
Message-Id: <20250308135110.953269-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DZr1UWw1xuw4fKF47CFg_yoW8ArWUpa
	yI9F43Kr18tFnFqw1fGw42ga1rJ3Z7tw18C3ZFqr15C348tryxXr1xKF4a9r93A34ruryF
	vr13trZxW34kZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The motivation for the patch set comes from the question raised by Cody
Haas [1]. When trying to concurrently lookup and update an existing
element in a htab of maps, the lookup procedure may return -ENOENT
unexpectedly. The first revision of the patch set tried to resolve the
problem by making the insertion of the new element and the deletion of
the old element being atomic from the perspective of the lookup process.
While the solution would benefit all hash maps, it does not fully
resolved the problem due to the immediate reuse issue. Therefore, in v2
of the patch set, it only fixes the problem for fd htab.

Please see individual patches for details. Comments are always welcome.

v2:
  * only support atomic update for fd htab

v1: https://lore.kernel.org/bpf/20250204082848.13471-1-hotforest@gmail.com

[1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg-14d1fBYWH2eekudsnTRg@mail.gmail.com/

Hou Tao (6):
  bpf: Factor out htab_elem_value helper()
  bpf: Rename __htab_percpu_map_update_elem to
    htab_map_update_elem_in_place
  bpf: Support atomic update for htab of maps
  bpf: Add is_fd_htab() helper
  bpf: Don't allocate per-cpu extra_elems for fd htab
  selftests/bpf: Add test case for atomic update of fd htab

 kernel/bpf/hashtab.c                          | 148 +++++++-------
 .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
 .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
 3 files changed, 289 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c

-- 
2.29.2


