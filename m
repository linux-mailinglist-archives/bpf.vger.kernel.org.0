Return-Path: <bpf+bounces-35305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D0939786
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA3B282301
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0EC12E1D4;
	Tue, 23 Jul 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewShE5nQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE2839F1;
	Tue, 23 Jul 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695325; cv=none; b=UBGuvA+m6IN06xN7cPppndd08OrgISeXLJ+I5sN+0XTom+Z0vE8Qmu/yKuAnIh8uAGPLYO7LEE72IGnAiUHlZ/uijQrKMi8eizWINFtLgXIa9+FgdK566ZFZsN+D09SLcP0wvcQIKfhfY4AJFPr6+Ag5iN+7FqhLqB6ge41dNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695325; c=relaxed/simple;
	bh=/41HBvfFSP6AhCQ1Ns3XYDuDGNmEIQjGYI4PFKv/NRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtxDyxcS61vP92IDWQUFyXHEuytpoahBDfKqosika5V6BZGaAI+3yytLpMgcHoB3WvGgtO1KYA1uVshgaoFukn2DLtlNetIcDVPim7ebG+kOTgw0qFc+9yT7I0khz20t1bj3gCc9n10ZhOYW+g98PEtWoB1pbdjwqb4Ono23ZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewShE5nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B26C4AF0A;
	Tue, 23 Jul 2024 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695325;
	bh=/41HBvfFSP6AhCQ1Ns3XYDuDGNmEIQjGYI4PFKv/NRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewShE5nQk/UHSQNSWccSBo8u/k4PGDuXybcVr/3ayk+Xmth1dPRgMNRa+qt4CgGZy
	 LnQFD25bpDA+LLoCCb+kStzIRQKRlm2ggwy/gSpeHxUWEYZ8b/3lg43JUKiKlXNxvn
	 1NyLZ9XDM8oSS0UxflCoGB0gn71AO2s1qtbVPj7fsQod7I/IflFe6FPirgCGvjg1uj
	 zmrIPc4899YktnHAq8POAD/NNsJO+WSJTaz5DCIGMPdg581CqIMuECP9j0ctrnV7R2
	 2FF1380Bf8ZE8kUUaOQt4E60liFWZyio2Bu2j6RHV0Sn1ntLqASueoH8/2fSYKNtVD
	 5Dio3uF7tVYrw==
Date: Mon, 22 Jul 2024 17:42:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
Message-ID: <20240722174204.0eedd139@kernel.org>
In-Reply-To: <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
	<CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 15:27:42 +0800 Jason Wang wrote:
> I wonder why this series is tagged as "RFC"?

I guess it's because net-next is closed during merge window.
I understand that the situation is somewhat special 
because we got Rx merged but not Tx.
Do you think this is ready for v6.11 with high confidence?

