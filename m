Return-Path: <bpf+bounces-34982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AC934726
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FBC282FA5
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503093F9FB;
	Thu, 18 Jul 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OK96QppL"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEA800;
	Thu, 18 Jul 2024 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277146; cv=none; b=Uuqzcso9Vkg2I06qZeP4GEm27MzHISlKG7urPvhwkNspkdblMQ8Wbkm48kOE1crD23bXNPKGdG7Sl2TBBAhCr0ANgHYJSMzUNHAhD/1TCzcs0IqJ9sDxwOI2RIHEQ/BcG2oixHjQxI6PR0WSAdPPkGhuJxr11dxroblhGOv6Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277146; c=relaxed/simple;
	bh=AHE/exxIC/GVu8KrXuIJpWf3GMf6rRdL9In6Hys9Aug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u54MefqU5msCCN5kvLHAsNcjnBNystzM2Nylg5oUH1AsaiQ1VEeCaaJOidtB1NxUx9o5qpEOsWvkk+ghncRftJWZiPLYw7zI0xyYV7irOqp7v54ls30OKltOFXE0nyg1IyOyThBuJf5ZetQXoKGW+s6/r1wzjKCVW1Vag74jGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=OK96QppL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721277141;
	bh=nZ8Os7OjJ+T31mYxH8zBOPqMWZ2Rhz1IZxjZyJjTNQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OK96QppLpdw3gwSvIOppK3dtb0PZapVJyY7jE6TH1R2uEgKf+GCvjX4kXkisOGaRN
	 pjSnU95yKIhayJ+5rwdhlUklkfO5afMZHq9w2aJVDStjhHoPQOA6t2/eO0S6MFJ5yE
	 iSdMv0jLOLfIKb8vhSSpcp/jmGqa/wkm9EwxJf3zWkeMMqB7MFLGZ2/t+XVYKhJYPS
	 dHz36/VraOUwwCiPPyWpq7AKoo0TTwR72gCbH7pgMOadJfPIqLz2iSIWEGdJn9z7zv
	 kL9DvLJaAGxZ9F4cJIbxDsljPiq2r6GsOGCPJjbqElkBnL5Wp3Ij+fPjRlqP0qI55v
	 v8eihWXHOSyUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPfzS6f49z4w2D;
	Thu, 18 Jul 2024 14:32:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the powerpc tree
In-Reply-To: <20240718095428.56145ce1@canb.auug.org.au>
References: <20240718095428.56145ce1@canb.auug.org.au>
Date: Thu, 18 Jul 2024 14:32:19 +1000
Message-ID: <87plrbwca4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> The following commit is also in the bpf tree as a different commit
> (but the same patch):
>
>   358492fc426f ("MAINTAINERS: Update email address of Naveen")
>
> This is commit
>
>   afcc8e1ef7bb ("MAINTAINERS: Update email address of Naveen")
>
> in the bpf tree.
>
> Note also that commit
>
>   e8061392ee09 ("MAINTAINERS: Update powerpc BPF JIT maintainers")
>
> from the powerpc tree is almost identical to commit
>
>   c638b130e83e ("MAINTAINERS: Update powerpc BPF JIT maintainers")
>
> from the bpf tree.

I'll drop them from my tree.

cheers

