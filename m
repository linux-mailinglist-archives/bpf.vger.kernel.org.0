Return-Path: <bpf+bounces-58581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C837DABDE80
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7333ACCB2
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70CB2517A0;
	Tue, 20 May 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WyV9fTbs"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA391DFD84
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753850; cv=none; b=d53SzbYkQfPBQOzf+GcRh6wotrbpXHC6g2Mnm26wuczLno0ceVpWclvC8qJ+f2QW8CiD9fLwnyt7e0/2MPlwT6EtedY8K3l5vD5uLep3NE585B00N8buGkNp9FgwVUveyjClFTb0YrbtKA6ADFI59NwVDQbWWdgapahn4UK3WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753850; c=relaxed/simple;
	bh=2un06VrPK/WUBLF3bKsicFJw3OV1P3KcckXmpF5KCZ4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=tNYUC2d8tEATfYh+uvOVqIK/DGB9DdsGTNdouDTTZW0PqnYYGd7cbrHrXXMFWs7runBa7Fm97O8BnOHUbrWPwaFNjce+QXk1lRYiq2/SpWzHPTh6Kik9axeSWfqG1E7lzwz/VVP2BO5jNWdAuN2ZJkCsu3MrzUBfpYM+b4b+5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WyV9fTbs; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747753836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEX1jHUrub31rPVQwtog69oMgdloGivRIBG2sjKnaXg=;
	b=WyV9fTbsu4lxkfYNnEJh/F1W91jONFvvTP8k7RKIjUdMFfryWEiGiONMWLuQdW/JJL9blK
	XdrLd2ziLkffSiX2jy87Y7613p3BApHjZvemx5OIxCmOoafvfTNfc8rkoEHxwq/gyGY4Xc
	00cCcauZG5jc9VCy9cvf0JbuLvR1k6A=
Date: Tue, 20 May 2025 15:10:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e568d71aa0c1f7397c755ce6f0a71540931ebc3e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix concurrency issues between
 memory charge and uncharge
To: "John Fastabend" <john.fastabend@gmail.com>, "Cong Wang"
 <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Cong Wang" <cong.wang@bytedance.com>,
 "Alexei Starovoitov" <ast@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250519200003.46elezpkkfx5grl4@gmail.com>
References: <20250508062423.51978-1-jiayuan.chen@linux.dev>
 <aCorf4Cq3Fuwiw2h@pop-os.localdomain>
 <20250519200003.46elezpkkfx5grl4@gmail.com>
X-Migadu-Flow: FLOW_OUT

May 20, 2025 at 04:00, "John Fastabend" <john.fastabend@gmail.com> wrote:

>=20
>=20On 2025-05-18 11:48:31, Cong Wang wrote:
>=20
[...]
>=20>=20
>=20>  Solution:
> >=20
>=20>  1. Add locking to the kfree_sk_msg() process, which is only called=
 in the
> >=20
>=20>  user process context.
> >=20
>=20>  2. Integrate the charge process into sk_psock_create_ingress_msg()=
 in the
> >=20
>=20>  backlog process and add locking.
> >=20
>=20>  3. Reuse the existing psock->ingress_lock.
> >=20
>=20>=20=20
>=20>=20
>=20>  Reusing the psock->ingress_lock looks weird to me, as it is intend=
ed for
> >=20
>=20>  locking ingress queue, at least at the time it was introduced.
> >=20
>=20>=20=20
>=20>=20
>=20>  And technically speaking, it is the sock lock which is supposed to=
 serialize
> >=20
>=20>  socket charging.
> >=20
>=20>=20=20
>=20>=20
>=20>  So is there any better solution here?
> >=20
>=20
> Agree I would be more apt to add the sock_lock back to the backlog then
>=20
>=20to punish fast path this way.
>=20
>=20Holding the ref cnt on the psock stops blocks the sk_psock_destroy() =
in
>=20
>=20backlog now so is this still an issue?
>=20
>=20Thanks,
>=20
>=20John
>

Thanks to Cong and John for their feedback.

For TCP, lock_sock(sk) works as expected. However, since we now support
multiple socket types (UNIX, UDP), the locking mechanism must be adapted
accordingly.

For UNIX sockets, we must use u->iolock instead of lock_sock(sk) in the
backlog path. This is because we already acquire lock(u->iolock) in both:
'''
unix_bpf_recvmsg() (BPF handler)
unix_stream_read_generic() (native handler)
'''

For UDP, the native handler __skb_recv_udp() locks udp_sk(sk)->reader_que=
ue->lock,
but no locking is implemented in udp_bpf_recvmsg(). This implies that ing=
ress_lock
effectively serves the same purpose as udp_sk(sk)->reader_queue->lock to =
prevent
concurrent user-space access.

Conclusion:
To avoid using ingress_lock, we need to implement a per-socket locking st=
rategy into psock:

Default implementation: lock_sock(sk)
UNIX sockets: Use lock(u->iolock) in backlog path.
UDP sockets: Explicitly use reader_queue->lock both in udp_bpf_recvmsg() =
and backlog path.

As of now, I don=E2=80=99t have any better ideas.

