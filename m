Return-Path: <bpf+bounces-42987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B99AD928
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D741C21C69
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF92557A;
	Thu, 24 Oct 2024 01:23:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088661CAB8
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733035; cv=none; b=OGxQXW+XGUiDKDxegWYruN5PXYQgFI5Vt92BLpMDyirKt3pUZ2Dd4B9pwade9Ntvr0f10mP1KZ6WLI7UL/3oavJezPrxEYCQ1nkA6rKfKQirDIvdVnal6Z465gPfTmVxruHoH2YQj2ZJ2g8LpDHwcHxiUx7YSc5FGOLusLf7pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733035; c=relaxed/simple;
	bh=2sVslz2BzyJL1XJUh+pH48U15uZJn5DHbptghamXpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFXirSKkOn7gkrlJLPuY2U9KGSsGPeDdw/xyoMAVAy0sJWL7eRCyH5AuvGpwloowunCIPKUpMhixoEL1BHJCgbe2mOohaqlYS6SrPOGdEmRd2RJMxZdHtCoIH2l5EXGdjr8zC8r09xFPQzUX4g/dPIw5CBv3MCiehhC1bGcOgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYp8M70Wsz4f3jsY
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6CAA31A0194
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMihoRln4mXLEw--.33103S4;
	Thu, 24 Oct 2024 09:23:47 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v3 0/2] Add the missing BPF_LINK_TYPE invocation for sockmap
Date: Thu, 24 Oct 2024 09:35:56 +0800
Message-Id: <20241024013558.1135167-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMihoRln4mXLEw--.33103S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW8tr4fCw1kJry7GF48JFb_yoWDGrg_CF
	W8KryrGw18u3W3JF4jyFWfZFyFkrZ5Zr1DWayrtFnxZr95Zw4kXw1kGry3ZFykW3W0yFZ8
	GF95A3yavwnxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UZ4SrUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The tiny patch set fixes the out-of-bound read problem when reading the
fdinfo of sock map link fd. And in order to spot such omission early for
the newly-added link type in the future, it also checks the validity of
the link->type and adds a WARN_ONCE() for missed invocation.

Please see individual patches for more details. And comments are always
welcome.

v3:
  * patch #2: check and warn the validity of link->type instead of
    adding a static assertion for bpf_link_type_strs array.

v2: http://lore.kernel.org/bpf/d49fa2f4-f743-c763-7579-c3cab4dd88cb@huaweicloud.com

Hou Tao (2):
  bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
  bpf: Check validity of link->type in bpf_link_show_fdinfo()

 include/linux/bpf_types.h      |  1 +
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/syscall.c           | 14 +++++++++-----
 tools/include/uapi/linux/bpf.h |  3 +++
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.29.2


