Return-Path: <bpf+bounces-77832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BECF3CDA
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD0BA30E1E09
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA433E35C;
	Mon,  5 Jan 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkhxWcw0"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172233DEE6
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619467; cv=none; b=m3rzjupnXi6aIO3MZ4ZCe/MoS1sd5AY5Uls0768soMgZKzixcl5O0MvUOFYjy3h6U8TznO3GXmX7jtM1oKU/tg/3ITrtv6vyjQvINdAzNnFTgb4UOI0Ai6idHFl/bssqlCs4mAeYwhU+TTBQV9u67sMvbll6i56zYReK0VIKg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619467; c=relaxed/simple;
	bh=ME9tcwYyhEFkcAlT3lWouAPFCjBAMKMHb3ZkPMJxkaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHPbU+oSXJQHPot5jYM10Ky3gvpqjg9hiextewZ6SFlwhsx1sxUGjBbBeTZsCH//D6UZOBJhK5ckQglNy/Ei8t8hhY1Enabe+em67xE5Jykppd85CgxIyqzgk+XZsPCSfZ0XxFVY6J7RWtYvWNmQO2uB4v3jcJNjC3puNgBD7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkhxWcw0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767619453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ME9tcwYyhEFkcAlT3lWouAPFCjBAMKMHb3ZkPMJxkaY=;
	b=fkhxWcw0ZntTKUjHRp4oOQZ92KF73o59A6whc0wPUZbFWMSAnJYPsWAU7UUScF6yUJaDlY
	FmnEb2DaNumN4HYtM51JahqM1cjS+8/wiShD/lNXOaZCDolY8pbhSFdiREiqiaYYqa6dCY
	91NKWF01xOVvYWmUB4crF2V5s8cj2AE=
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev,  john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, shuah@kernel.org,  aleksander.lobakin@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Dongliang Mu <dzm91@hust.edu.cn>
Date: Mon, 05 Jan 2026 21:22:54 +0800
In-Reply-To: <87y0mc5obp.fsf@toke.dk>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
	 <20260104162350.347403-1-kafai.wan@linux.dev>
	 <20260104162350.347403-2-kafai.wan@linux.dev> <87y0mc5obp.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2026-01-05 at 11:46 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> KaFai Wan <kafai.wan@linux.dev> writes:
>=20
> > This fix reverts to the original version and ensures data_hard_start
> > correctly points to the xdp_frame structure, eliminating the security
> > risk.
>=20
> This is wrong. We should just be checking the meta_len on input to
> account for the size of xdp_frame. I'll send a patch.

Current version the actual limit of the max input meta_len for live frames =
is=20
XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), not XDP_PACKET_HEADROOM.

The original version not set xdp_buff->data_hard_start with xdp_frame,=C2=
=A0
I set it with the correct position by adding the headroom, so there is no n=
eed=C2=A0
for user to reduce the max input meta_len.

This patch is failed with the xdp_do_redirect test, I'll fix and send v2 if=
=C2=A0
you're ok with that.
=20
>=20
> -Toke
>=20

--=20
Thanks,
KaFai

