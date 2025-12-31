Return-Path: <bpf+bounces-77574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E8CEB6FE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2FF3016998
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568E2E7179;
	Wed, 31 Dec 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q5sdxncO"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271701A9B24;
	Wed, 31 Dec 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166270; cv=none; b=Ww/sXAQqCfhTJGNyB5n579mUwtwu8U4hdUt1YWHgid7YX5PD9+mGdZ/xO0BbmYadDLhqR3ezvWEiyDZ/FFnhHL3JKOcIM6pNwO3pZUXU/C+zj1Khz8QkKMx0XTtf4XHyvm37iZsXn3J2tLQOLYL5syUp7Y3K4MeLhiVCHN3XMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166270; c=relaxed/simple;
	bh=Zlr8igzRc16z679zIhNQxrbZKzltVk+ksogckIx/LVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXzUsDTBxHzi+xGUk3RoySMPjs2lEL5lIUgr76UavCQebRENoGpuQYpt5hi6okzb0uHo5szsui4vx7ubZKXmFPQC2u1oPEenuGnIEEBbei7wFoHh7bDQ5yIhjg7KL8GJIlyw0doodjZM5jeHAIpbFLf+SoHfChhYY03xIEYoBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q5sdxncO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ps
	Isr/ZKWzzFXnbvWofDraa78HCMu3Ml29mdAFbHK1U=; b=Q5sdxncOXeYfcERc7P
	t3H3tSm0ieTOdKyrM9uwvshZvjvDgrah+cdUX86VK/IBBXVus+22qJUxWEusFTW7
	RiGyxueQrAbSxbJA669GZpgrC8XIOp4THE8vuo0MSOdTZZKNOocOL8qmgzbKfgbg
	eQKZbL9EBziL6BOPHlYIvYAsM=
Received: from hello.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDn7_rP0FRps24xJA--.330S2;
	Wed, 31 Dec 2025 15:29:22 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: ameryhung@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	buaajxlj@163.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
Date: Wed, 31 Dec 2025 15:29:19 +0800
Message-Id: <20251231072919.1018961-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAMB2axOZeGGXiO-6uXOa0HUefDjoU+7_287K3au0EMLxnWu=4g@mail.gmail.com>
References: <CAMB2axOZeGGXiO-6uXOa0HUefDjoU+7_287K3au0EMLxnWu=4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDn7_rP0FRps24xJA--.330S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUKw4UtrWrCF43uF4kJFb_yoW8Wr1DpF
	4UtF9xCanrta48Ar1vqw4vywsYvry0kr13K3s5X3ySkF43XF1qqr1Ikr1YvFy3ur4q9F1S
	vF1ava4qk34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRo89ZUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbDABPX92lU0NPjkAAA3+

On Tue, 30 Dec 2025 22:18:00 -0800, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3f0e9c8cefa9
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 69988af44b37..2bc27ece5cc5 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1768,6 +1768,9 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
> >         ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> >         storage = ctx->prog_item->cgroup_storage[stype];
> >
> > +       if (unlikely(!storage))
> > +               return (unsigned long)NULL;
> > +
> >         if (stype == BPF_CGROUP_STORAGE_SHARED)
> >                 ptr = &READ_ONCE(storage->buf)->data[0];
> >
> >
> 
> Hi Liang,
> 
> I don't think we can do this here due to backward compatibility. The
> return type of the helper is RET_PTR_TO_MAP_VALUE. Your proposed fix
> would require adding a PTR_MAYBE_NULL and existing BPF programs would
> no longer pass the verifier.
> 
> Did you look into why the storage pointer is NULL in the first place?
> 
> BTW, there is also another similar report and a work-in-progress fix
> [1]. Do you think this is a separate issue from that?

Hi Amery,

Thanks for pointing this out.

Sorry, I initially missed your earlier WIP fix. Looking at it now, this
does seem to be addressing the same class of issues where
bpf_get_local_storage() can observe a NULL storage pointer.

I'm interested in this area and will take a closer look to see whether
your patch also covers the syzbot report.

Thanks,
Liang


