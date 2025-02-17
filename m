Return-Path: <bpf+bounces-51703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673AA37988
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C83AF392
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6A84D0E;
	Mon, 17 Feb 2025 01:53:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EB13B293
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757205; cv=none; b=NbM4By/eXfkzrwhNMYZy/OSapuawN2rbzolKfQpzk9uH/cDLLtVVO+gA/97MjyH9PsSlF8uLtC8Of1mbLmGK3dZ+KHqCBMGNrCwUZS0tuGa83KtD2Cbn+DLkepFk7BQCNi4uUiMZf6j8CAgoS3tep1kd/DwkeVrjt/GQq/ZCrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757205; c=relaxed/simple;
	bh=At5bU5rzY/lGDJ+n0zXUsHlZl8KiWINoWZ4TVuttpkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dBbsDe5fD3ZDsHoST/0pCpfKKfdKiXlVD/LJ0WpbOZz8XfxfahLYzQ2wYNjb12whLfVpqAENaC6mN5IGG9Zz9SEYHC4CyqCUZ6IHXJUV55yD+QNVjF1KoTP+VXttc0d6nnS/rhGf05M+Kwn94C/OhTbt490lYTX9yTwTSNoUva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Fj5zrtz22swf;
	Mon, 17 Feb 2025 09:50:17 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id A26EF1A0188;
	Mon, 17 Feb 2025 09:53:15 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 09:53:14 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH -next 0/5] remove unnecessary -EOPNOTSUPP callbacks
Date: Mon, 17 Feb 2025 01:41:17 +0000
Message-ID: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh200013.china.huawei.com (7.202.181.122)

Remove unnecessary callbacks that simply return -EOPNOTSUPP for following
map operations:
- map_peek_elem
- map_push_elem 
- map_pop_elem
- map_delete_elem
- map_get_next_key
These operations are not supported for certain map types and can be handled
by generic map code instead of having redundant single-line callbacks.

Xiaomeng Zhang (5):
  bpf: Remove map_peek_elem callbacks with -EOPNOTSUPP
  bpf: Remove map_push_elem callbacks with -EOPNOTSUPP
  bpf: Remove map_pop_elem callbacks with -EOPNOTSUPP
  bpf: Remove map_delete_elem callbacks with -EOPNOTSUPP
  bpf: Remove map_get_next_key callbacks with -EOPNOTSUPP

 kernel/bpf/arena.c             | 30 ------------------------------
 kernel/bpf/bloom_filter.c      | 18 ------------------
 kernel/bpf/bpf_cgrp_storage.c  |  6 ------
 kernel/bpf/bpf_inode_storage.c |  7 -------
 kernel/bpf/bpf_task_storage.c  |  6 ------
 kernel/bpf/helpers.c           | 20 ++++++++++++++++----
 kernel/bpf/ringbuf.c           | 15 ---------------
 kernel/bpf/syscall.c           | 30 ++++++++++++++++++++++++------
 8 files changed, 40 insertions(+), 92 deletions(-)

-- 
2.34.1


