Return-Path: <bpf+bounces-44582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9E9C4D05
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C19228A312
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A018205E0A;
	Tue, 12 Nov 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJVC4FPh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D061DFE4;
	Tue, 12 Nov 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380689; cv=none; b=WLrr8PSc3SYlr6QTXFse1jDPlzPBZBgL5zpdF+5CFe6dBWHlarYchIwgtvIgMdPxLk7wVEYb+Sp1PklxVKLOI4DIv6CcRz+BJQrMIpvJhnw7eRQwTAGJW+CHqUwZf80dwft4zhpe7UT/nqsBY/P3PStWO8y9LH/KijfhUVZ+vxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380689; c=relaxed/simple;
	bh=Hc9dgDWe1K9rdImKS8+TSxnAd59S+ucijqCsZs0nvhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoIqADi6yr1EVOYGB/7cLbTuIkTV2vWaS4WOek/Y+bqzPMF4iJOr0O3XfiyHoji52dUw9cC4yKonTI3w6Et05DZhKtbEzy3V4gRGDFwIw0fDTMTH4J/UUr+sQBABz2XQQFl2S50ub0TC8ZYqT57CjXDbuNYKSpezxYEVMEiWlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJVC4FPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B8C4CECF;
	Tue, 12 Nov 2024 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731380689;
	bh=Hc9dgDWe1K9rdImKS8+TSxnAd59S+ucijqCsZs0nvhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJVC4FPhXJZd0DxOccq49+oGu4Fl9RudggWjtK5bbZ8YvRzP3NODyb16mZE+YZv/o
	 ymnyWhcPSRl3XExexTNRVu4no5ZdkGeDFKO4diyAqFLMvtR3UZJ8OBFIfHTPWAcptl
	 n6Th5jKXbp4+eiQpd1qz9KdocRK5E+ZJUQlnOwO6xyGdh62aYUZcfY+vZSmpeBG6NR
	 6l7FVxDaDYkjKlWojRmB/Wiv0kq8VutE435BMO19aBRvcLTmnx3qbO7f9uW4Z3ugfp
	 J7zhwgsmmVoZ68yWqIZ2syDdiWdOrEDjChZuCuFMvqmbvsnnmLKk2NOlAWd0dJjbJ6
	 OGHeyepU6X+5A==
Date: Mon, 11 Nov 2024 19:04:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] ipv4: Prepare bpf helpers to .flowi4_tos
 conversion.
Message-ID: <20241111190447.43d6c542@kernel.org>
In-Reply-To: <cover.1731064982.git.gnault@redhat.com>
References: <cover.1731064982.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 17:47:09 +0100 Guillaume Nault wrote:
> Continue the process of making a dscp_t variable available when setting
> .flowi4_tos. This series focuses on the BPF helpers that initialise a
> struct flowi4 manually.
> 
> The objective is to eventually convert .flowi4_tos to dscp_t, (to get
> type annotation and prevent ECN bits from interfering with DSCP).

Daniel, feel free to take this or we can take with your ack..

