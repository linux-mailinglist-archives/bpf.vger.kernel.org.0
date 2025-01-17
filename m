Return-Path: <bpf+bounces-49181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C1A14F28
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91348161952
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD51FECCC;
	Fri, 17 Jan 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqwXxLm7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7161F63F3
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117120; cv=none; b=qdzJwgJbAizmKhtA9LrBVErgIaU1hi1n9xKdCdDobi6gxM37K9IvzfGIOQ/vV9MY36hYnGUm+HfMRbnz4+L29bgbMMe96XgL5ni+mIFM1J6gsYmxHKupF/mndhAdiVs+6QO1BPF+WL4oWO292TsZIr7FPTlJIwxXVtYYvvnSNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117120; c=relaxed/simple;
	bh=J5SeEmKcyMudLEvDETs243Ojg7MgATdJdi0jKjlOi38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oE42TsEDRJohvNnAVEHFtPTRpnZCxS/JDlJYa4fDf+SoCTR2muuqGObsjjG1LYW3U7wXVpxVk0iDo+TSJhrm/0FYzDBY/GBx3YWpr5qlErE46skHAsG5Zzl9ks7rACTkvMEpkoYX/jICKFoUkFdJKErm+MNmuoH3MGynE11k6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqwXxLm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E6DC4CEDD;
	Fri, 17 Jan 2025 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737117119;
	bh=J5SeEmKcyMudLEvDETs243Ojg7MgATdJdi0jKjlOi38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YqwXxLm7hqv2YciE+SSNeknW5DUBcf1aERbTDRniRqyqthA9zEP64wfBBv+gIr7tD
	 uczRprHP0vpwF4vp674YLXiqSzyWP10mLXaDJH34tK5VdilHxgQiraivGex/jP4xFq
	 5MOo/J2ODqsjhm21UwGt49EjWjJ826J4GT/Cgsn8U7vXlUuA47iDR4waJ5kHUDRSlJ
	 e8dM5rGOoneDn2ebgTodnhdjjthC8GmOqSod3rUYMOxExxQOpXjCRg32REsQUq6uu/
	 PK+aJd3aaWmsNh0jX8AWULtcAltOhqjO3yIhog5jy6RCAfk6DdyPyXfFFUw/pUDkNZ
	 g+J5Mm3KkXSYQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F31AD17E7860; Fri, 17 Jan 2025 13:31:46 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Free special fields after unlock
 in htab_lru_map_delete_node()
In-Reply-To: <20250117101816.2101857-2-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-2-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:31:46 +0100
Message-ID: <87r051oc3x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> When bpf_timer is used in LRU hash map, calling check_and_free_fields()
> in htab_lru_map_delete_node() will invoke bpf_timer_cancel_and_free() to
> free the bpf_timer. If the timer is running on other CPUs,
> hrtimer_cancel() will invoke hrtimer_cancel_wait_running() to spin on
> current CPU to wait for the completion of the hrtimer callback.
>
> Considering that the deletion has already acquired a raw-spin-lock
> (bucket lock). To reduce the time holding the bucket lock, move the
> invocation of check_and_free_fields() out of bucket lock. However,
> because htab_lru_map_delete_node() is invoked with LRU raw spin lock
> being held, the freeing of special fields still happens in a locked
> scope.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

