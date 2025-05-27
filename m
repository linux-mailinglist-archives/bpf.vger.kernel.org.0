Return-Path: <bpf+bounces-58973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D002AC4A60
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D52E1890227
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE3248F70;
	Tue, 27 May 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bxDHPc3F"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF41F50F
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335092; cv=none; b=ETOTJ9jxlEDzA2VV9H2UpsCX+0re0Ix5bWZ4AiDwEl0gsygxFnjnhTqu4RWaRfNgoUDJSXYWS9T9RsGQjI51TMVX4jRH4LTCRaOaVb1lXoQhDDxftVaJ0oJ5a5exkS1W0mHZgjiSPG6la6LIVB06DRYRWZLPiscj7A73OdjepSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335092; c=relaxed/simple;
	bh=vpH/QVZr8on7EeyigICYoJsrLBDrwtGI+GM/02h72/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tP16vm4zMWZ3NemcAJIkqxbtP3So+Pmvnf7UBrVeVm+DkPA6y4GvCjAgNco++TzNnwpUdJa5PVP6PVshaRCuMT3ai3Z2s1SXd+wh+uHlrl0TOwWHF3NuMCV9+ZFKJeAQ/zGNBsYuzVnF001CU/sncnYU28KHq9JeQMjKvh4U6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bxDHPc3F; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=O7
	mKkkwTrExcAY3DwzLFQW0loKAquF2TM05egbBKeNw=; b=bxDHPc3FqcEaUgeNNQ
	XWAxIn2d00s67C6CYDBam7lUWxGisW7+dM9zMhkUJQtNclULx6WRA3DoOAs35Sdz
	uck17R8UgNJ/1jjaC+wO2W0Few6QrgVXuvwunK3YIlotwiv/n5ge/8Vp3dCpASuV
	QW5lHb/6SiDc6+lsHbJ3daqI8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXpIDJeTVoyaHLEA--.803S2;
	Tue, 27 May 2025 16:37:30 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	bpf@vger.kernel.org
Subject: WARNING: suspicious RCU usage in task_cls_state
Date: Tue, 27 May 2025 16:37:29 +0800
Message-Id: <20250527083729.285734-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXpIDJeTVoyaHLEA--.803S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1xKr18KFWxXFW5WFyUKFg_yoW3ZFg_C3
	W7tr93tryvkws5Ga1UW3sxA397t3ySkr1vgr4UAFsrZan5XFW5t3W8tryay345WayvvF15
	KrnIk3WvyFsIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1jjgDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTQ9OeGglQBmbdAADsM

syzbot found the following issue on https://lore.kernel.org/all/683428c7.a70a0220.29d4a0.0800.GAE@google.com/

Related source code:
BPF_CALL_0(bpf_get_cgroup_classid_curr)
{
	return __task_get_classid(current);
}

const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
	.func		= bpf_get_cgroup_classid_curr,
	.gpl_only	= false,
	.ret_type	= RET_INTEGER,
};

static inline u32 __task_get_classid(struct task_struct *task)
{
	return task_cls_state(task)->classid;
}

struct cgroup_cls_state *task_cls_state(struct task_struct *p)
{
	return css_cls_state(task_css_check(p, net_cls_cgrp_id,
					    rcu_read_lock_bh_held()));
}


So, do I need to move bpf_get_cgroup_classid_curr_proto back from bpf_base_func_proto, or is there a better solution?


