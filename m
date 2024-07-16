Return-Path: <bpf+bounces-34917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3069327C4
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBC51C2274F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A919B3CB;
	Tue, 16 Jul 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b="ncr39HUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EPlJ2ClV"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0E199EA8
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137604; cv=none; b=oGfQns+CtAeHMnSjaGzXE6Z02+xfe7M1sM0L5qFh996+Hg+YqIdDBg10E84lgYt52StcjpzWmSKlMOADcdniwux86HRnnZyM10dpn2aWHpZgYnk6AxA2F+gnj6XCDqXuNUvdz8JA2DD+GxSOntzAiLYAwvnihKftKW1aKSx6rjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137604; c=relaxed/simple;
	bh=TYXWU39byUfCBApIPywX8CIem5Scft1HtBLWD3Aruak=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=KIPZHhxcS7CPipRCDN5rl37WBQ+nFKA603U/WmGdpZ/gIYTyImCws0OEzMhfNqcGXSeqvZOVxn75IGAX3px/3Fbf8bXAbibsithrxH3IDUxPczKbA9rY+JNMcQWh0dg51JBfMO03vGbcWHwmo4vGTrZnPuAVYBKaBZjo15g3Uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk; spf=pass smtp.mailfrom=dtucker.co.uk; dkim=pass (2048-bit key) header.d=dtucker.co.uk header.i=@dtucker.co.uk header.b=ncr39HUA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EPlJ2ClV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dtucker.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dtucker.co.uk
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5B3911481D4
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 09:46:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1721137601; x=1721224001; bh=8n
	h3Tyi0RCUt5rOCe1UZr3Tcb2+xj8iYxSUHXWX8Q1M=; b=ncr39HUAc64ySFHs6b
	wCYziMGevQpZr+lYHytsiG2G+SYeXKMoY/muxEhqAX/vzmTFu7FOSUAuL++ie1cP
	R5BS0Gindt2wMv0vXx4/Ou9tWz5tXHpzKwbpEA/McPCYvK29P26LWB7skf/nUH2a
	NIHxMTy4Jg+loC3fHiuIcm4KpRZE20wBHCgVqNaUhXtXIvaDcn4jQ5BbwtUkoBkA
	utXgdxVOo5QJSvVH7OEPKxZHDR22f9vil+Tur/fxWZeYLU8Vt6xupYqzofYEhAys
	a6bQ0WKMUTt+vMJP0weKYlLkUk1H+nK8jS4xpC0Vurtlj71CBXCCF5YnImMwCWzT
	4dGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721137601; x=1721224001; bh=8nh3Tyi0RCUt5rOCe1UZr3Tcb2+x
	j8iYxSUHXWX8Q1M=; b=EPlJ2ClVet40OyossXlGZnggYXyCE4irxm/K/Un5uX3k
	zCUR+FR5fuA7KzEFr9XOWCDPN77NqOCgvZPw1/pme3ae96EN1XRZIlNrunZwWI5D
	wHhDKiBcfFSE19VMzOSE01T5a/7BpPkevZcCX/gJWtD6/zc6Ceo+ma/RzrTtzazk
	njSC3Aelcjlqb6cjoKEna6kgNBkWRHXRM00v71uhIc4mgFnQzX7jNfBmXEPQtkHU
	HXG3XUindSXFhnS75b4nOnoPUtyVLoJoYViuTfs50/C3cjjB7mLuRyjgnntf+60B
	mYqUiCnV6TuPBpum5ZfcGzYTMbz3jnBSN22d+/KzkQ==
X-ME-Sender: <xms:wHmWZn7xlI8FW7PLBsGFVBUO0nvHAkN22JW7TwLWKXgs6ObskhcpRQ>
    <xme:wHmWZs4igB-97Zr6AlLj7zIQhIIkBhz06LeOlaoQUIea_rKN-SHBQS_B4uhBNGjuG
    vLaTzor-zmqN1IrJQ>
X-ME-Received: <xmr:wHmWZuc9HDrzTaM4X3jvDqsyXwu82liOd4uB23ZcLchOqh1UhSaFKYiZXcbsBw9teI6y0EIC6mzFahNyHE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtjeenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgvrhdr
    tghordhukheqnecuggftrfgrthhtvghrnheptdfgkeeiffelgfekffevheeivdetgefgge
    ejhfegleekieejvdefkefhgeeugeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepuggrvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:wHmWZoJRe8UPFkliqgwryHNlc14ThDWJOzLELL_ILLB_GCclvFQb_A>
    <xmx:wHmWZrJE2PyvngVim2If-9yh5MRw3vdWS-886aX1AfNS4kqlL-AoQQ>
    <xmx:wHmWZhzIyyZqJ8_92SoPBQ53RpklimDFBeSs8VxQF9JJI8lr2MQaIg>
    <xmx:wHmWZnLt-s7oz06PGe5C5aTii2ytjMZeVrO0aeFnjemQbRsx1R2LRg>
    <xmx:wXmWZhhLpq0XloSP9MZ5_jPFviw6SD2phAjSf8A7ZowaRV_q-oGb5By3>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <bpf@vger.kernel.org>; Tue, 16 Jul 2024 09:46:40 -0400 (EDT)
From: Dave Tucker <dave@dtucker.co.uk>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Question: How is BPF Token supposed to work?
Message-Id: <ABBF5150-2913-4BE5-80B2-AC8432C4526D@dtucker.co.uk>
Date: Tue, 16 Jul 2024 14:46:28 +0100
To: bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Hi,


I=E2=80=99m attempting to implement BPF Token support in Aya using the =
implementation in
libbpf and the kernel selftests as a reference. However, I=E2=80=99m =
hitting issues.

I'm performing the following operations:

1. Creating a bpffs (using fsopen, fsconfig, fsmount) for my UID/GID =
1000 with
   =E2=80=9Cany=E2=80=9D prog/map/cmd allowed:

   $ mount | grep /tmp/bpffs
   none on /tmp/bpffs type bpf =
(rw,relatime,uid=3D1000,gid=3D1000,delegate_cmds=3Dany,delegate_maps=3Dany=
,delegate_progs=3Dany,delegate_attachs=3Dany)

2. I=E2=80=99m creating a new userns with bwrap:

   bwrap --unshare-user --unshare-ipc --unshare-pid --unshare-net \
       --unshare-uts --unshare-cgroup --uid 0 --gid 0 \
       --bind /var/lib/images/fedora / --dev-bind /dev /dev \
       --bind /tmp/bpffs /sys/fs/bpf --bind ${PWD} /home/dave \
       --cap-add CAP_BPF --proc /proc -- /bin/bash

3. I=E2=80=99m then executing my BPF application inside the userns:

   ./xdp-test


However, what I=E2=80=99m observing is that my program is failing to =
load.
strace confirms I=E2=80=99m getting -EINVAL from BPF_TOKEN_CREATE.

$ strace ./xdp-test
...
open("/sys/fs/bpf", O_RDONLY|O_LARGEFILE|O_DIRECTORY) =3D 9
bpf(BPF_TOKEN_CREATE, {token_create=3D{flags=3D0, bpffs_fd=3D9}}, 152) =3D=
 -1 EPERM (Operation not permitted)
=E2=80=A6

I believe I have CAP_BPF inside the userns also:

$ getpcaps 2 # pid of bash
2: cap_bpf=3Deip

My machine is running on Kernel 6.9.4.

The only difference I can see between my code and the selftest is that =
the
selftest os performing the fsopen from within the userns, which looks =
like it
is deliberate in order to check you can=E2=80=99t set delegation options =
from within
the userns.

It=E2=80=99s quite possible there=E2=80=99s a bug in my implementation =
but before I try the
same operations with libbpf directly I=E2=80=99d really appreciate a =
sanity check
that I=E2=80=99m using BPF Token in the correct way first.

TL;DR

If I create a bpffs in the init user ns, then bind mount it into a =
userns,
will BPF Token work?


Thanks in advance,

-- Dave


