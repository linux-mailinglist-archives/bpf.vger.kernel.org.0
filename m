Return-Path: <bpf+bounces-73224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82953C27863
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 06:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CE1B22EB7
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9527466A;
	Sat,  1 Nov 2025 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMtPtvso"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BE1E231E;
	Sat,  1 Nov 2025 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973904; cv=none; b=PZCTlF6a1Yd/Mff1RXrIcTkyi+UoGtFqIsxhDjsy2VQi1Cj4WfMYZRa5/AhoIbN6DBbyH7WbanGZ0arWdbkONnNDiSutqUs4n/YQB91Jr4gy/IEGwTdM4UzR9J5nuFUec6zlcw4rxO10mbtjmXN5Y1png+M9Slqf/tiy0nKPg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973904; c=relaxed/simple;
	bh=PzuIANretVlJ+/5XVSLxnTOpbgWbF/+fa/hXznRs/Xo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iolI0/JDVYFEkS4ZreOgy/shFRmGi1SkmfpUXl+wLwvcXcPbdug7luxSOSieCwS4PV9mKSjIpz0PVOd8rtlVZ0Eq/M6fvX0NA1vk+J6ZA+SwAfitjTH/S1IXmkwBGQm0cGnZX6O5VtCqutdaJzi1pZOzl3ai+Sy+VrfZWS9bz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMtPtvso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37687C4CEF1;
	Sat,  1 Nov 2025 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761973904;
	bh=PzuIANretVlJ+/5XVSLxnTOpbgWbF/+fa/hXznRs/Xo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CMtPtvso0cGt88NYNPdZKPHJ2B4r397VAX0M5cNNfIkcR2VSflXzBuwVHCAXVNo5d
	 WGYYj5sw9xKxna1o7v8TSN6QWMOsFr75azwaqEck5eOBdkvpNRNMH+hdo4SM0/PgsY
	 ngPjZ2hnmk21YrFv4scyju2nLStyI5mLr011DdK3MkUOcWa0WWJebfr8Mv0ykVd7Rn
	 5TxngedR+++O655KgrAHMqHxx/PYlgZCg93mdH7PnA8dC6gloArfP61MxVkdogNAmv
	 2LcKKXBrb+IpiIc1usSfzm6k+Vh5VQyT0HXFhvBiNYo+aUEYdsOso5toE8zYG2J3WK
	 /Dq6ssZz4x8eg==
Date: Fri, 31 Oct 2025 22:11:44 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bnet-next_PATCH_v4_1/7=5D_net=3A_Convert_prot?=
 =?US-ASCII?Q?o=5Fops_bind=28=29_callbacks_to_use_sockaddr=5Funsized?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251031170520.0b8486cf@kernel.org>
References: <20251029214355.work.602-kees@kernel.org> <20251029214428.2467496-1-kees@kernel.org> <20251031170520.0b8486cf@kernel.org>
Message-ID: <3BF4FE5C-376C-4FF5-8D1F-D5088D5DA6A1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 31, 2025 5:05:20 PM PDT, Jakub Kicinski <kuba@kernel=2Eorg> wro=
te:
>On Wed, 29 Oct 2025 14:43:58 -0700 Kees Cook wrote:
>> Update all struct proto_ops bind() callback function prototypes from
>> "struct sockaddr *" to "struct sockaddr_unsized *" to avoid lying to th=
e
>> compiler about object sizes=2E Calls into struct proto handlers gain ca=
sts
>> that will be removed in the struct proto conversion patch=2E
>
>I fail to spot whether the new type is defined :)
>Or is the new type not defined at all?
>If it is probably best to have that as a separate patch=2E

Arrrgh=2E Yeah, what should be patch 1 got skipped=2E I will try again! =
=F0=9F=98=AD


--=20
Kees Cook

