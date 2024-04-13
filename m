Return-Path: <bpf+bounces-26700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC658A3A68
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 04:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8262846C9
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 02:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1751AAC4;
	Sat, 13 Apr 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJNKv5/N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF031865C;
	Sat, 13 Apr 2024 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974288; cv=none; b=E/mSOAxpFg3T1pZDy8sdVRWMXdTjKKs4Htm9kmXmcXZW9jruBjIoLN81WtpdmLRf4igqKsrB7Kq5qyO4w6wxLV+iKTXYIbSxwoCeugzugNTQD3AIHsa1/8ZIh4Zjp5ngFsBpR3jEf4qXbGJ+JA0SsBoNxn7Q7ytnpohYjzm0oS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974288; c=relaxed/simple;
	bh=K//9Hcjv/NtcL18GMBZ3/qLgmdN/uoN2Qy4xDwZxj8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6KJy6ns36Li5Eb8jIo5sIDtUogvIe+KD3TWOqbq2tRp0Nsd1+S+J89ExiorQi/G4JOajM7yPJMKPvg4q2jJv2LJ/4BfBHVYIreaH3C3ZaYrBOLXAQAhlY3WVqx6jvFZQ8ZjUSgzLIui+qTAf1Uf9bI0pcr6vwS5Zcp6m9WBQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJNKv5/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E078C113CC;
	Sat, 13 Apr 2024 02:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974288;
	bh=K//9Hcjv/NtcL18GMBZ3/qLgmdN/uoN2Qy4xDwZxj8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJNKv5/NPFXO9KmDBnsbYQHUSdlBDyLfy3jyB6xvOT8nK+StDPFXS1YDHMlhEZJX8
	 MYDidoTYasOB9hUVhAQZp57dRh64VEPxQysn+xfryfy/0qtNP0XBeQdhpNh+R9kQ37
	 qZHi4Q6Yeo0pzRjq44hG3FPmx/zl0fayJHBBbShLqIALr6/US8q0mAKiU+0dtZc7kx
	 ybjI1O9Uv0R96WZrLGJ2sU+F+zIimEKVOhX7KKIZqJzpJlMr7bjQFEgrQBO0H1AkPj
	 SPaZYCidt8Nluu3PWadUJzQCJd3gPMLzKNFh4NnWJ1P9lE41fGLsJdevaBgO+K9f7d
	 nSEiFAg7gt7XQ==
Date: Fri, 12 Apr 2024 19:11:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 ast@kernel.org
Subject: Re: [PATCH net-next v6] virtio_net: Support RX hash XDP hint
Message-ID: <20240412191126.1526ce85@kernel.org>
In-Reply-To: <20240411085216.361662-1-liangchen.linux@gmail.com>
References: <20240411085216.361662-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 16:52:16 +0800 Liang Chen wrote:
> +	switch (__le16_to_cpu(hdr_hash->hash_report)) {
> +		case VIRTIO_NET_HASH_REPORT_TCPv4:

Please indent things according to the kernel coding style.

Checkpatch finds 2 problems in this change.
-- 
pw-bot: cr

