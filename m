Return-Path: <bpf+bounces-74276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03109C51468
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96506420818
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723392FE591;
	Wed, 12 Nov 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="inncpehu"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A022F5302;
	Wed, 12 Nov 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937943; cv=none; b=td7+SuBZ0Jo1TkhujtG1RZJqNUhYr1sYX6LkFVIL6Jl/SOU9Eik197XZmGlGc6neuSQj0vh6OeWwQDwBo0UY3RAmq2tAGNiCFr5Qqkf6aBXYu/5pkUmZz2gFRk21nSZqvLe8i9pcM04mF70/iMaPObzQT+bce+qxVoF6/iG54QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937943; c=relaxed/simple;
	bh=9amyeYc92k+dh3EErWyp+iwvLmzuSYuv7EQjPxC75lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrTBtR2zg179RkdFO5RiK0ZZxShpVOxWsvB2UUBqK5JTzpYz6gJnx2HmnIcnCir1IicSGhDe0DcL5ikJaYcEUhMeNWMHhy1UVaEo+CLObVxq+4EHRgsHxo27ugo0biS04i9Vd3NiK+67dasQCFrS3PAvpsyJCH04JmwR6Ft3Q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=inncpehu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d5y4d47dqz9thT;
	Wed, 12 Nov 2025 09:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1762937937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NwBu444Fxxr5f31vIxL0G3G0TwtuKwmojIyCJCoDA=;
	b=inncpehutSLukdPOHHtzwKdWCFiBYZ0zxnYlwpfHMevTmw5TXoxZ1h8pZcrQPcEt2NGXR5
	Zz1v6n/JwOIsw8iuIZWupwTgaugSOCMbouBdgLBKGinx5SK5JFTaVbr4IMPVO360qZBuWJ
	fYiEDs+CYe0kTuL/LGEB7Vki2xhDFdAd+P1fmBpMVDtrfoia/DzyEBnbOm27Bn8DJ6EyVu
	RLZchl1fNjqG413ueK5fCv1i3lKaqlrKE5SjWxCAySEZ9Xjea0aTy47v+ewS98EJsIg1eb
	G1BzifhJt4HCOhTnf8rArKhWNmrqfWodulbwKa5u/cLo3JHyFXxeZr5VjKZPAg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Wed, 12 Nov 2025 14:28:44 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <mdlw2a6pjibyn4flt6a3a74mvd4pyuckzoieiz4owbkzrkrpyy@k4lkhzim4sow>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
X-Rspamd-Queue-Id: 4d5y4d47dqz9thT

On 12.11.2025 08:40, 'Lecomte, Arnaud' via syzkaller-bugs wrote:
> I am a not sure this is the right solution and I am scared that by
> forcing this clamping, we are hiding something else.
> If we have a look at the code below:
> ```
> 
> |
> 
> 	if (trace_in) {
> 		trace = trace_in;
> 		trace->nr = min_t(u32, trace->nr, max_depth);
> 	} else if (kernel && task) {
> 		trace = get_callchain_entry_for_task(task, max_depth);
> 	} else {
> 		trace = get_perf_callchain(regs, kernel, user, max_depth,
> 					crosstask, false, 0);
> 	} ``` trace should be (if I remember correctly) clamped there. If not, it
> might hide something else. I would like to have a look at the return for
> each if case through gdb. |

Sure, I can do that.

> 
> Thanks,
> Arnaud

-- 
Regards,
listout

