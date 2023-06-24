Return-Path: <bpf+bounces-3375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED173CCCC
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1092810D2
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0ADDDD;
	Sat, 24 Jun 2023 21:38:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D0A953;
	Sat, 24 Jun 2023 21:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA3C433C8;
	Sat, 24 Jun 2023 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687642716;
	bh=kZAZb8VwwdIozLgwV01VFij8RmxnZ2PC2T5Y1l9pcz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nM19jKx9x9KMKtEpyDc7sr8mSvWThZPm1yBUzajTeSMnkI666n1hlA4rRFPad4UYf
	 IosXa/RuVJMwLjxO7oh86IfPsZAu3vZrcbhUGi4hnazgL2uZ2eibtNkqFaSbWCmj0O
	 4q1AgqVfDlKyAcWncbNYfpqV0udWaQ2xwVvtvshQqOTQTSd7Qx+dopA1lhWhquMxTJ
	 yTHK+PY5i8P+go6Oi/K8qFvdSkjwX0NYRM8Kn298gu85yue+buUXD9Ua2ZV/cCKkDW
	 XAEXZMMHE0LHX85A7rpz2kQj3HYbRYYLSxA8VuyhqcT7lGUTs4HrKKscx7j612wYrO
	 YnKzIpw3EJz9Q==
Date: Sat, 24 Jun 2023 14:38:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@google.com>, bpf
 <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp
 metadata
Message-ID: <20230624143834.26c5b5e8@kernel.org>
In-Reply-To: <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
	<20230621170244.1283336-12-sdf@google.com>
	<20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
	<CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
	<CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
	<CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
	<CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
	<m2bkh69fcp.fsf@gmail.com>
	<649637e91a709_7bea820894@john.notmuch>
	<CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 19:52:03 -0700 Alexei Starovoitov wrote:
> That's pretty much what I'm suggesting.
> Add two driver specific __weak nop hook points where necessary
> with few driver specific kfuncs.
> Don't build generic infra when it's too early to generalize.
> 
> It would mean that bpf progs will be driver specific,
> but when something novel like this is being proposed it's better
> to start with minimal code change to core kernel (ideally none)
> and when common things are found then generalize.
> 
> Sounds like Stanislav use case is timestamps in TX
> while Donald's are checksums on RX, TX. These use cases are too different.
> To make HW TX checksum compute checksum driven by AF_XDP
> a lot more needs to be done than what Stan is proposing for timestamps.

I'd think HW TX csum is actually simpler than dealing with time,
will you change your mind if Stan posts Tx csum within a few days? :)

The set of offloads is barely changing, the lack of clarity 
on what is needed seems overstated. IMHO AF_XDP is getting no use
today, because everything remotely complex was stripped out of 
the implementation to get it merged. Aren't we hand waving the
complexity away simply because we don't want to deal with it?

These are the features today's devices support (rx/tx is a mirror):
 - L4 csum
 - segmentation
 - time reporting

Some may also support:
 - forwarding md tagging
 - Tx launch time
 - no fcs
Legacy / irrelevant:
 - VLAN insertion

