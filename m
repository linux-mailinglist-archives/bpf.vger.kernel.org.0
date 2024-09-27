Return-Path: <bpf+bounces-40413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE35988686
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65291F24489
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D291BFDF0;
	Fri, 27 Sep 2024 13:48:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919A1BF7F3;
	Fri, 27 Sep 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444896; cv=none; b=ckS0gn57SUI7aMefd69j2xyXCx2m5K0C1EbxYOo3JE5Zm2cJeZ5Zz5S8rir1UEyCXq8eDZxd1URT8dt9DYcpmu9SU1QeaQZHZjv3WQfc4QsLdEd7H7aGv3me6sP7lHc4Oc6QDZNIwMXh4+Hgg5xWjAJpsxmz6EBXtkY4p1yEr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444896; c=relaxed/simple;
	bh=lGhmkiqk2uE0nTDyxg9t2dnn4V+iFrF2q/x3QW1QxOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jzchhhzEPwOVHs5ORpM9ifOryizOmEgw5pQHugPg7h+G+XbEvHmHBD82NaEQbVAqF6ZTccAKX383OENUQf481xYsWBuOuZtunXoGXmONLwD+chtIPHqnjZrG7WSfyTwfqFImn91/5h+mV5/Nd8HTOzdqB1l3GVsRVdkEhe4nxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFWxp3BmFz4f3jkd;
	Fri, 27 Sep 2024 21:47:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA2A81A0359;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHvMiYt_Zm3kQCCg--.422S2;
	Fri, 27 Sep 2024 21:48:08 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10 v2 0/3] Re-adapt "bpf: Fix DEVMAP_HASH overflow check on 32-bit arches"
Date: Fri, 27 Sep 2024 13:51:15 +0000
Message-Id: <20240927135118.1432057-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHvMiYt_Zm3kQCCg--.422S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryfurWUXFykXFW3Cw4xXrb_yoWDXFX_Cr
	4IyFykGrZ7Aa4kWayDC390yrWUG393A3ZxXFn3Wr1IkFs5JrZxXFZ5AryqvFy7Zay0vFn8
	A3WI9w1xtw4fZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwzuWDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
accounting [0]. The commit cannot be independently backported to the
5.10 stable branch, otherwise the related memory when creating devmap
will be unrestricted and the associated bpf selftest map_ptr will fail.
Let's roll back to rlimit-based memory accounting mode for devmap and
re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
on 32-bit arches") to the 5.10 stable branch.

Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]

Pu Lehui (2):
  Revert "bpf: Fix DEVMAP_HASH overflow check on 32-bit arches"
  Revert "bpf: Eliminate rlimit-based memory accounting for devmap maps"

Toke Høiland-Jørgensen (1):
  bpf: Fix DEVMAP_HASH overflow check on 32-bit arches

 kernel/bpf/devmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.34.1


