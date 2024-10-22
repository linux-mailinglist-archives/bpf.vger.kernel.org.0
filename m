Return-Path: <bpf+bounces-42768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BD9A9ED5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C142B2302C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD661991AB;
	Tue, 22 Oct 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXEaFHEL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9C157487;
	Tue, 22 Oct 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590224; cv=none; b=HAuRLYPmdNKpttfJ7oTJe14vBRhqecRo/fuuZLuyDEHpGRdROKqxATTS+K6hAK8cZrQ7ONCcDw4yGXE7YfUi/ehot+Naj0AvXzYbGQ5qP4yfOr9HjZdnur+i7b+EAUUOnI1Pc231I9RqwvtPAQiU+sgG/tqMbEn5NXX/ZyIGSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590224; c=relaxed/simple;
	bh=zeeVl7APGlbH3uWRJJBJkixFlhu2fnjZ1tXyVT6k3/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trVxihIk/eCj6ruSYe+F7yAS34RcQzKmWXRhRkVbisll5XNpNcjFL3KJ1lU3NwNgPuFmtxa5i5OGAyk1birrJSFjmLHiJoO9T2LLsIUjzu8AFB4fF0XsQCPmFChD0l1ntYw4XjUJaokybDScjOKeqMQSyIeSbSUtfZQ5bJuqlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXEaFHEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A85CC4CEC3;
	Tue, 22 Oct 2024 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729590224;
	bh=zeeVl7APGlbH3uWRJJBJkixFlhu2fnjZ1tXyVT6k3/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GXEaFHEL1YOD5j88cBLPwpH3AI/i0JaVBzDsxTaXEGhLvIjURcUnr2PUvoC32s6ZZ
	 vtg16rXEzHayIMSOCpgw2HuC0aAsbApMUsZ7iffbRCvi/vZwWV3KWXJ/2tQgK32Vzs
	 r13Y4TVZJawGK2S5Ew4qs2tKJ9faFemZJDQOjiEbnNIYeP7SpBUZCBZ2qy6+YS7YeZ
	 DUPIlyuYG5DFDhcUlYlwsFK8klkPXmDYD+EeVnvfeindTYfC2OrDhwmrpU83/IToCf
	 vhNOKvP6m/dfWVg+52jEYkFjszM6gl6F/IArJrFzhrt9cxt9nKQFGCXKpDpXGY1xv7
	 5nXR+YBmg2fcw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A3249160B2CA; Tue, 22 Oct 2024 11:43:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Byeonguk Jeong <jungbu2855@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
In-Reply-To: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:43:41 +0200
Message-ID: <87a5ewiib6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byeonguk Jeong <jungbu2855@gmail.com> writes:

> trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> full paths from the root to leaves. For example, consider a trie with
> max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> .prefixlen =3D 8 make 9 nodes be written on the node stack with size 8.
>
> Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRI=
E map")
> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>

Makes sense!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

