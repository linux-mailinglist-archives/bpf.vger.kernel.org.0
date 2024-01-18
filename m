Return-Path: <bpf+bounces-19822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BC831D9F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85CC1F21630
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD502C1A0;
	Thu, 18 Jan 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPvXjPvT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B42C190;
	Thu, 18 Jan 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595854; cv=none; b=H0+COZe1g5Q3o+XjOxefzbWlZG/qzd/jNzjAiEmWVBvIDJdGMAfON3Oj0oahIbA+mWWpU5G98gBhTteSYQy71oRMzaiDxCeugkwKHSHOkkv05SI1e1P2LP9UNOj/QZQU3cJgIrQJAgGUNB9jiv+TMx4b7npkx7wHs+rdr8xhObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595854; c=relaxed/simple;
	bh=78qDvdoU8MNssGDZJwgtmCe+PdOvJ+qmDgSWEuv1VDQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=JnNLgE2sZj6agODuHoX7DiEEao0ooNT8+TwSJuz83/kKh3g4MS4P1x6g1ehL1dPLCZBsZrq8rUytVSrVvEk5D8RGZtowhzhv3b8artoFhn8euvShf+1TMLPXKYOsoW35V+QG2kVViCGO8KAEmYfGIJjuiywbf1tdvVQmCZcz+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPvXjPvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04491C433C7;
	Thu, 18 Jan 2024 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705595853;
	bh=78qDvdoU8MNssGDZJwgtmCe+PdOvJ+qmDgSWEuv1VDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPvXjPvTnBGU4VL398n3ldYn2txi+kr5JmTsgFrmJAwtS43X6azylVtz6ap+vsQs7
	 yHTvfVc6cRK1Xxifzd33twBhf3WGMdFq7a0CGJKhAe4eu4XSGoWg/kH+kEs+51uDoZ
	 ScKotZl0BVYE8G2A9y34fy3DEBB9j09uSLdzagZTAq134QGpQEv0Zml3CDqWzYuZJj
	 yRrAVtS4crcM7Fc+gxohEp4m8l4Pm8TQN3UTYwgyBFInh/WSk61c8s+25le/LyuBr0
	 Q++2IeFfQrX3qcGwyju5yUhvg5N+X6dDSjcPRKHcOr3rcc0uN9m4LkxH04EEq50ZqE
	 cZ7iwqm2zzZtw==
Date: Thu, 18 Jan 2024 08:37:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao Luo
 <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak Doshi
 <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
Message-ID: <20240118083730.5e0166aa@kernel.org>
In-Reply-To: <87bk9i6ert.fsf@toke.dk>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	<20231215171020.687342-16-bigeasy@linutronix.de>
	<CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
	<87r0iw524h.fsf@toke.dk>
	<20240112174138.tMmUs11o@linutronix.de>
	<87ttnb6hme.fsf@toke.dk>
	<20240117180447.2512335b@kernel.org>
	<87bk9i6ert.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2024 12:51:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> I do agree that conceptually it makes a lot of sense to encapsulate the
> budget like this so drivers don't have to do all this state tracking
> themselves. It does appear that drivers are doing different things with
> the budget as it is today, though. For instance, the intel drivers seem
> to divide the budget over all the enabled RX rings(?); so I'm wondering
> if it'll be possible to unify drivers around a more opaque NAPI poll API?

We can come up with APIs which would cater to multi-queue cases.
Bigger question is what is the sensible polling strategy for those,
just dividing the budget seems, hm, crude.

