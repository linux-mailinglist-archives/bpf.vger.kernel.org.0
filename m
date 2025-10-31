Return-Path: <bpf+bounces-73088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA1C22D27
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 01:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B75418869BF
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515401FF1C4;
	Fri, 31 Oct 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE4pmfa9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FB17C77;
	Fri, 31 Oct 2025 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871819; cv=none; b=pVlgqbe4Fx41+mqjXNREl8EMxspZnRmWCr/ApoPptGtHM7jlFxshSC4Phsje4XTlbpl99OaqU/yZm/mWA/I3bZl690/rLzHrXr+d9qkOYOZQFUGu/TkwG14skAPm7OJpZC3kqG/qZfbhq2yXmV6JRSrGwLwUehySV2+gU8uYdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871819; c=relaxed/simple;
	bh=HbM7gMoVX8jsj6bLdXZC/72JdLg6TPgOiocJwLHLyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4mufXqD7xLViquiY3/4WGMoV2NGGUiy5ESvUok7HS/lZPomH8RFJiu3ANK8YYJbJ6UCVu38aZXdWl+L/4t+rb3IY7s4okz2S9eaW2sX4zcKNZsyLCKl/+3D8DCyO9HulofZRXnwjlBuOm7G7eM6/tA0xQqsMnCF9hFtJ4N9jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE4pmfa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045C8C4CEFD;
	Fri, 31 Oct 2025 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761871819;
	bh=HbM7gMoVX8jsj6bLdXZC/72JdLg6TPgOiocJwLHLyIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EE4pmfa9hsqFDEqALNPGB2xb+AoFrPh1qEJvlDDVPAKbTOVs9pxMeZT2GjCby/n3t
	 Mjix1XIpbmhw2HqZae834AxSCh4v8JWWCuvW8XpXz+xQLqGe0L4cTiwVKwx2+/+KI7
	 5eKCJrohox6UJ4QBXNwMCtYjnOaBrCX7VZKHc5aexXeC3F0UisK5lnN/Q9ivejDL/A
	 Qj88MxaEOWSpFJzuwOtXibDjvvDjD+Sph5hLB8dJu95j2q0WAFW0S9rBIt1d/SUqNy
	 ipi+y2uNmbJAGcYaVbwGv/MRR9f8dctrgP+TRSsF8/eoeYuNu5plB1UkJJw7UU53fW
	 y5KG0Uvr6iizQ==
Date: Thu, 30 Oct 2025 17:50:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
 <netdev@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: Reorganize networking documentation
 toctree
Message-ID: <20251030175018.01eda2a5@kernel.org>
In-Reply-To: <20251028113923.41932-2-bagasdotme@gmail.com>
References: <20251028113923.41932-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 18:39:24 +0700 Bagas Sanjaya wrote:
> Current netdev docs has one large, unorganized toctree that makes
> finding relevant docs harder like a needle in a haystack. Split the
> toctree into four categories: networking core; protocols; devices; and
> assorted miscellaneous.
> 
> While at it, also sort the toctree entries and reduce toctree depth.

Looking at the outcome -- I'm not sure we're achieving sufficient
categorization here. It's a hard problem to group these things.
What ends up under Networking devices and Miscellaneous seems
pretty random. Bunch of the entries under there should be in protocols
or core. And at the end of the day if we don't have a very intuitive
categorization the reader has to search anyway. So no point..
-- 
pw-bot: cr

