Return-Path: <bpf+bounces-34948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E460933C12
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405741C22954
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76117F393;
	Wed, 17 Jul 2024 11:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B4BA4B;
	Wed, 17 Jul 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214993; cv=none; b=uCJyNbVuADmRJSvPzSUP9p/StV6fgV8sv7SP+0D3wFTAhG6LBOMcHgSMtdpsN/SlfwDFWb9xbcqM7pf2dsvv8e/WuVB14XDq12hY58fB1eMkVerdk16trlQaW1fsX739BcY/dh6TG9W/igiIex/5IjEpYNKxTudqH4NaDgnBsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214993; c=relaxed/simple;
	bh=roq3Kh+/ovFClUmAW7vgp3cQisHyeRk+vUYTDOvwbUQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iaxqcAUmMJ1SSVIhPpRl+jFv+rWGMvU8GkNTGfFeDLTe73GLusbTw+tfRdlAT+r/A+3ipcyG+ZQjrF0+yanwWT4cZ4SCY6qk0d/xekbte1kpSytn4/zxllS28gWdf8I9KPTzvjuZMFInC7ueNA6cHJigMLPIMfD4gWn5PRYu7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.148.37] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADHJ5DQp5dm5RfUAA--.34821S2;
	Wed, 17 Jul 2024 19:15:28 +0800 (CST)
Message-ID: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
Date: Wed, 17 Jul 2024 19:15:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Lin Feng <linf@wangsu.com>
Subject: [PATCH] bpf: fix excessively checking for elem_flags in batch update
 mode
Content-Language: en-US
To: ast@kernel.org, daniel@iogearbox.net
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltADHJ5DQp5dm5RfUAA--.34821S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5WFyUWr15Gw4rury5twb_yoWfJFc_u3
	yjqr18KrZayr13KFWFkF40grWDKr1Dtrn7uayDXF97JF1DXrZ5JrZ5AF9xCF98CrW7W3sr
	uFsrWrZ0qF45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_
	Jr0_Gr1lYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_
	Gw4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUeNyCtUUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Currently generic_map_update_batch will reject all valid command flags for
BPF_MAP_UPDATE_ELEM other than BPF_F_LOCK, which is overkill, map updating
semantic does allow specify BPF_NOEXIST or BPF_EXIST even for batching
update.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d51..d85361f9a9b8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1852,7 +1852,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+	if ((attr->batch.elem_flags & ~BPF_F_LOCK) > BPF_EXIST)
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-- 
2.42.0


