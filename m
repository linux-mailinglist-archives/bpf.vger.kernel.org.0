Return-Path: <bpf+bounces-59053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126DAC5F13
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBCC3BB6FE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B731BBBE5;
	Wed, 28 May 2025 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JspyGYBx"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8EB1519BF
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398123; cv=none; b=mGLRuAFSJkt3ZylHPqWlnTGV9EpKNP+e4FiSlAPQQGwbW+XFZy4zhQvvWB6gLf7PjRWBGpwRHKZTV4escjLx99l+XAppgHm6tx0nOYu0N9nNribKtaygxT5/lSgTnsS5zJZaW8TfCu7Rgi26tyJ66dWQRoSYr34fGFkzV2pdE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398123; c=relaxed/simple;
	bh=lvsmthVwQm75zzifF/TYaqCUrGhqLrPuuBw6dWuKctM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvLnMt6cF4YohnRCJYzeVx2kf9NeTmqYApJBSJH8RupQsNB6VmTqZAgqxiQYqHiQt4KR5Q40HyVrrxMTMQMp0rDSd0MXSnVWk2W0eivwtu69w7Ak16OC4biSHZft/IYJs/OGhmMi7MwxXgBxO7Nu0PFjYQPtRzEBADwOrCWu1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JspyGYBx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b9
	EzOYBUsP/pkWd+7hAzIkED0pBjXPBPzqYMz249K68=; b=JspyGYBxTZd6FW+7Ql
	ffnFoYnEMmBSArhZS+VESl0m+eueJ1qJkdLHStx4SDBSDeIU40efULB0C9OVre4Q
	OH+XOxGu8xG11rIZdC7oP1TEbnNdVxlvHU/Rpqs9jkSDSfq4s0Bey9s+6gg9HQIK
	GHLdt7fBSiKC/BXrnuZGnfwfw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3r9r8bzZodjvjEg--.29809S2;
	Wed, 28 May 2025 10:07:57 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yangfeng59949@163.com
Subject: Re: WARNING: suspicious RCU usage in task_cls_state
Date: Wed, 28 May 2025 10:07:55 +0800
Message-Id: <20250528020755.33182-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4BzaNbLF7DEZvtm6Sg4hmQEqnGsxrYgZKvss1baA-sUHJyA@mail.gmail.com>
References: <CAEf4BzaNbLF7DEZvtm6Sg4hmQEqnGsxrYgZKvss1baA-sUHJyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r9r8bzZodjvjEg--.29809S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1DCw48Jw1DAr43JryDGFg_yoW8Jr45pF
	s7AF1Uuw4jgF42gw4IvrZ8XFnYk395uF4UGrWrtF1UAF9Fgr93W397Kw43Cas8ZrW7Ka17
	Xw42v3ZIkw15taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUK2NAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVgxbeGg2b80H1wAAsV

On Tue, May 27, 2025 at 16:39 Andrii Nakryiko wrote: 

> On Tue, May 27, 2025 at 1:38 AM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > syzbot found the following issue on https://lore.kernel.org/all/683428c7.a70a0220.29d4a0.0800.GAE@google.com/
> >
> > Related source code:
> > BPF_CALL_0(bpf_get_cgroup_classid_curr)
> > {
> >         return __task_get_classid(current);
> > }
> >
> > const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
> >         .func           = bpf_get_cgroup_classid_curr,
> >         .gpl_only       = false,
> >         .ret_type       = RET_INTEGER,
> > };
> >
> > static inline u32 __task_get_classid(struct task_struct *task)
> > {
> >         return task_cls_state(task)->classid;
> > }
> >
> > struct cgroup_cls_state *task_cls_state(struct task_struct *p)
> > {
> >         return css_cls_state(task_css_check(p, net_cls_cgrp_id,
> >                                             rcu_read_lock_bh_held()));
> > }
> >
> >
> > So, do I need to move bpf_get_cgroup_classid_curr_proto back from bpf_base_func_proto, or is there a better solution?
> 
> I'd try to fix that rcu_read_lock_bh_held() check. Can we use
> rcu_read_lock_any_held() instead?

Okay, thanks. But it seems that rcu_read_lock_any_held() does not include a check for rcu_read_lock_trace_held.


