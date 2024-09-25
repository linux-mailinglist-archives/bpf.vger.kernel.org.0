Return-Path: <bpf+bounces-40280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A589852A8
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 07:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45441F22226
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12221547E3;
	Wed, 25 Sep 2024 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="bZ8xZ+Vv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQrD7cB8"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA341C94
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243651; cv=none; b=XajGZL67HA1hc783OjnOiTqGFfaHT4DkECgrgY8Yh1Yv3lSfkFQHZOAQfQJGGUUubz2FD5BrwzQ5R4Kl29soFpZQjVwrqlTOc2xFDM0Rkl4dtm3Y/ORZOk6z431yiHX0udhZ34YX311VQfOqts1tZkJVDTBb2PyjGW2J2AYjCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243651; c=relaxed/simple;
	bh=d6ndLUTHRZssq0XD7FkvTmJphLYy5Ca+MdsoJ9RE6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5CwnefGN/LS40sw6V8DENq+tHT5++dN5+E+VlVo9w7EgWSl06pTAGb2l+Rq/O8hwVooDvyhuRXPV98LTCQ8qvMN/Emh914ddyym3GTrlmAmPKUzjRQtOJ8gDSrkTYMrdYkcQN/gijgrShJut9b5hRBBByYHnQRWIKmZuoJakUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=bZ8xZ+Vv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bQrD7cB8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A13F5138061B;
	Wed, 25 Sep 2024 01:54:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 25 Sep 2024 01:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727243648; x=1727330048; bh=uiqNMJRCRe
	70PjsriiGUGtZ/F9jUb8u3TgUbOOaFqrc=; b=bZ8xZ+Vvnv5UUQcnHn90S1IzrH
	d3ysfouTg9ILsxWnXMtTbCu+XDGYCsHj62Jsw9LG236BYheya2uMXYIpsVPPvK1G
	npDZ1EidTYm5dKe+gmnLyW6eRo5iIviMqoVSUaKp/s3ZyvceA1A10JkbjGFIVG3L
	KIQfcZpOvLNnlDFATjaiJbMe9EEQ6mFjJgVZybLqnuIxg3oXMMownoCYco5m3ald
	MqoJMZsWaeSdISAq8w2POD+9LdNTNYoewDht01ulyBaAWt3bKhMsnp/S4pv3+78G
	e9Ojk961PNg9SJ3ZsLRUYxdOUr8E3v4wiqM0AsgBY4YkNNW6QoNNAXpFiwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727243648; x=1727330048; bh=uiqNMJRCRe70PjsriiGUGtZ/F9jU
	b8u3TgUbOOaFqrc=; b=bQrD7cB8BgtR/S6Ii8YIlo4C6khNlIQENfvIgM3+AK9z
	h9ux46yGx0ZIjj37r28qcXh7ATmXS4r3KoGRCPbYzrIxPP+jX7TH7OAwuNLjK4yg
	dIlvQ8LiGnLdyilf/k5RR6ft8LyxlxeXZE2lnp92oJObO4Wa+26fT9SYlL1HcdVC
	CinOGmMJZzUxEd52sH8lsChxs9nn+WiH3I4+mVf+zD8hxCAcJFJQSMCtw9KYvvXR
	4iyE0IUhne2wAMYWcZ53Dzv4Vm77bcSXI0OGF9LnEzvSTWoMuymbpzZjoabRe4Z5
	F3gHjzYO6jeE4jMUT9GOY0kxuoQbjR+I1DFhT9XmOA==
X-ME-Sender: <xms:f6XzZv9PrZky2QUx-LWKjNsclRDWH08knyi1V9GR_8yOnCuo26Hssg>
    <xme:f6XzZrtFtE03gjwPl-MyLT9ITz3liqcfT28cEhVgEpAdym-hrSTyJHRq-WMHlUDuN
    6LgiaNKDeQ9hhkg8Q>
X-ME-Received: <xmr:f6XzZtAKLHaBOFplYhCicBs79K06i_Nffd2a00pn5joX8gcJUiNCU53814VtzT47pErzH0rGDJGVL_uk_V5Zr_7BDmxJbG9fr9KYGBqjORCrTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    efhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpedtjeekudelieetvdefgedvgeejhefhvdfggfejudeutdegveeivedthfehfeelkeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghnthhrgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrshhtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprh
    gtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiek
    jeesghhmrghilhdrtghomhdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlih
    hnuhigrdguvghv
X-ME-Proxy: <xmx:f6XzZrfmGn91SYXEV6XlFB9fi8LslMlj0hnqjLiaKyl3sgqmdfKjRw>
    <xmx:f6XzZkNqtOjQKTymiRqZQezHm80Gxpra5bn_Powj9iKtYq71L4MFZw>
    <xmx:f6XzZtkM9LzNEF7r1Wp1UGo2-U2JuTUYhecHvG6r6bc8-C0uqc2W4w>
    <xmx:f6XzZuv_HTAhDLc9YLiOB76ZmLVCJ3GeDQWIQItPYbDXpWASKq_6jA>
    <xmx:gKXzZjojo8N_VujldbEntEQISZhxu48a85Sj4x8c5R92tEQvlTxsSycQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 01:54:06 -0400 (EDT)
Date: Tue, 24 Sep 2024 23:54:05 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: vm: add support for VIRTIO_FS
Message-ID: <yxpa6ifnn4hzlhvi3tyzint564s6dzei2lxasb7l6hnfuv2q5i@fhxjci3jojbi>
References: <20240925002210.501266-1-chantr4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925002210.501266-1-chantr4@gmail.com>

On Tue, Sep 24, 2024 at 05:22:10PM GMT, Manu Bretelle wrote:
> danobi/vmtest is going to migrate from using 9p to using virtio_fs to
> mount the local rootfs: https://github.com/danobi/vmtest/pull/88
> 
> BPF CI uses danobi/vmtest to run bpf selftests and will need to support
> VIRTIO_FS.
> 
> This change enables new kconfigs to be able to support the upcoming
> danobi/vmtest.
> 
> Tested by building a new kernel with those config and confirming it
> would successfully run with 9p (currently what is used by vmtest), and
> with virtio_fs (using a local build of vmtest).
> 
>   $ vmtest -k arch/x86/boot/bzImage "findmnt /"
>   => bzImage
>   ===> Booting
>   ===> Setting up VM
>   ===> Running command
>   TARGET SOURCE    FSTYPE OPTIONS
>   /      /dev/root 9p     rw,relatime,cache=5,access=client,msize=512000,trans=virtio
>   $ /home/chantra/local/danobi-vmtest/target/debug/vmtest -k arch/x86/boot/bzImage "findmnt /"
>   => bzImage
>   ===> Initializing host environment
>   ===> Booting
>   ===> Setting up VM
>   ===> Running command
>   TARGET SOURCE FSTYPE   OPTIONS
>   /      rootfs virtiofs rw,relatime
> 
> Changes in v2:
> * Sorted configs alphabetically
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/config.vm | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selftests/bpf/config.vm
> index a9746ca78777..da543b24c144 100644
> --- a/tools/testing/selftests/bpf/config.vm
> +++ b/tools/testing/selftests/bpf/config.vm
> @@ -1,12 +1,15 @@
> -CONFIG_9P_FS=y
>  CONFIG_9P_FS_POSIX_ACL=y
>  CONFIG_9P_FS_SECURITY=y
> +CONFIG_9P_FS=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
> -CONFIG_NET_9P=y
> +CONFIG_FUSE_FS=y
> +CONFIG_FUSE_PASSTHROUGH=y

In fs/fuse/Kconfig I see CONFIG_FUSE_PASSTHROUGH defaults on:

        config FUSE_PASSTHROUGH
                bool "FUSE passthrough operations support"
                default y
                depends on FUSE_FS

So is it necessary to set here? I suppose if it matters that we're sure
it's enabled, it's better to be explicit.


>  CONFIG_NET_9P_VIRTIO=y
> +CONFIG_NET_9P=y
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_VIRTIO_FS=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_VSOCKETS_COMMON=y
> -- 
> 2.43.5
> 

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

