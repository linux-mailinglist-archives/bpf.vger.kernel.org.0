Return-Path: <bpf+bounces-57491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E627AABB87
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B961899217
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14236239570;
	Tue,  6 May 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OVKs2PAM"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B002367AD;
	Tue,  6 May 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512461; cv=none; b=jvEhcR/85q3grbEydxBY4pAAGlm+9I41iOaX/UAlinMimT7iX67rDQimUIQ66F6a1u57Ow+h7gwRlHzXqco7UCBWuqfMCFoXZj3NXbr6Z/zitMncUV6eyRlBHvUFFJBCibTewVrPen3VjzxkH6eOz9DrEv83XoMPj7Eu65KCjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512461; c=relaxed/simple;
	bh=TKUFE8wmFwAk4C2sZUbsAIKED74IQzd8LjOpb+Ey0S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzQCu3mjE1x5961jM3gGYI/yRZe/awWP9osGvEn3htqCwQPd/BCDmwsi6vGprjVmR4C0oqKWN2YRlGm8TkVlQuWCq7XDh7RHxbRAXHc7hVefmsd2sauq/ng8O2As60/Ysa/+ESsHbzLDAYXuQYuM5DdUScUdDezc1Olw+dec/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OVKs2PAM; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e79TK
	fMpOR14QOUNlBYcpIeyddYsN4zu4B2wlXjR6r0=; b=OVKs2PAM0oF9HQVKnWTgh
	9xZROsrNnp+WvHCu78C+prfvi+RT/up4SJC6Pw0yi/twV4vcDlcOxWGS0ib8HLiE
	uQP9je9N3v85/ChleC+K3CdU6SxZFGxfcgBgW8+JsVc77Kn6N3UmcUVHl/miIehs
	9YYicGF/gfDQfxVfcsUOZg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3L2DvqRloHPICEw--.39461S2;
	Tue, 06 May 2025 14:19:28 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	htejun@fb.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next] bpf: Allow some trace helpers for all prog types
Date: Tue,  6 May 2025 14:19:27 +0800
Message-Id: <20250506061927.95882-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4BzbJ0eaiiaCukaJV0JmrzF6fsbwOxszQUV3pL+MAJT25rw@mail.gmail.com>
References: <CAEf4BzbJ0eaiiaCukaJV0JmrzF6fsbwOxszQUV3pL+MAJT25rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L2DvqRloHPICEw--.39461S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF43XF4ftw4fKF1fury7trb_yoW5XFW5pF
	s3GFyakw4ktF47W343tw4IvFy5A3yxJr1UGasrKw1rZr42vr9rXr1UWr4fWFyvvFWxGr4I
	v34q9FZ0k3W2qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrgA5UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhJFeGgZovXSLAAAs1

On Thu, 1 May 2025 11:11:52 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Sat, Apr 26, 2025 at 11:39 PM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > if it works under NMI and doesn't use any context-dependent things,
> > should be fine for any program type. The detailed discussion is in [1].
> >
> > [1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com/
> >
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> > Changes in v2:
> > - not expose compat probe read APIs to more program types.
> > - Remove the prog->sleepable check added for copy_from_user,
> > - or the summarization_freplace/might_sleep_with_might_sleep test will fail with the error "program of this type cannot use helper bpf_copy_from_user"
> > - Link to v1: https://lore.kernel.org/all/20250425080032.327477-1-yangfeng59949@163.com/
> > ---
> >  kernel/bpf/cgroup.c      |  6 ------
> >  kernel/bpf/helpers.c     | 38 +++++++++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c | 41 ++++------------------------------------
> >  net/core/filter.c        |  2 --
> >  4 files changed, 42 insertions(+), 45 deletions(-)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 84f58f3d028a..dbdad5f42761 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -2607,16 +2607,10 @@ const struct bpf_func_proto *
> >  cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> >         switch (func_id) {
> > -       case BPF_FUNC_get_current_uid_gid:
> > -               return &bpf_get_current_uid_gid_proto;
> > -       case BPF_FUNC_get_current_comm:
> > -               return &bpf_get_current_comm_proto;
> >  #ifdef CONFIG_CGROUP_NET_CLASSID
> >         case BPF_FUNC_get_cgroup_classid:
> >                 return &bpf_get_cgroup_classid_curr_proto;
> >  #endif
> 
> this is the only one left, and again, it's just current-dependent, so
> I'd just move this into base set and got rid of
> cgroup_current_func_proto altogether (there are 5 callers, let's clean
> them up)
> 
> > -       case BPF_FUNC_current_task_under_cgroup:
> > -               return &bpf_current_task_under_cgroup_proto;
> >         default:
> >                 return NULL;
> >         }
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e3a2662f4e33..a01a2e55e17d 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/btf_ids.h>
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/kasan.h>
> > +#include <linux/bpf_verifier.h>
> 
> why do we need this include?
> 
> [...]

bpf_prog_check_recur in bpf_verifier.h.


