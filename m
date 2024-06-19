Return-Path: <bpf+bounces-32483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EDD90E136
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE5B1C22118
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE646AD32;
	Wed, 19 Jun 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUyFSoZo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F763D0;
	Wed, 19 Jun 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718760202; cv=none; b=jEP12vt778nqjioENPr1pkzObqNw7YQe8TnvSIVySoBR2t3mog5PLiBgALeFCNxWDhMoslunhInswdRS128lmPlKY1QQR8RUP832si7hC1CwIS15JgS/JiDQRotqTmLsG/vq/bLi5Hofd/9mbwx0wepewPy2WRPae6nIiDuki3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718760202; c=relaxed/simple;
	bh=cImVFBApoWwLCfZUf3w5ykyQczqaH4KE43FkF55OJDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6w6LP1IjzFG4E9sBm1/jJ5D+4adaj7+DQ3j3+crCbU4H0GuNbptE3RlfrvUqyuZIDv+nszoP2/yr5mXrKUAKG5IjC6c+HxMXi7RuM8phkkhN52SXNDQVNx1xujhqQyFXHx+q4BBIMPZq7n12xsADJaM+afDmhyyKmlIDGqxOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUyFSoZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EA3C3277B;
	Wed, 19 Jun 2024 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718760201;
	bh=cImVFBApoWwLCfZUf3w5ykyQczqaH4KE43FkF55OJDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUyFSoZoknG6zP6PfXNDTsPbWkaQatkItjeObaAnSBeS5tSftmlCyrU3mrUyclGey
	 IzQnj6dqYFYmNMZBmbHau1klJXqmxpsAXwdWjx7naiTi/HNNgtXtYpDM8WzuT0wgfe
	 t0HtSJNbhQHPA9nJvjFj555XP20Mb9uDMxOBlUi0aGX5uYsyTG79T7UrAI46R56qbG
	 udcOa5bRvahHyM9ks6AxG41rOhRdvkc3jz4l537ZstrRPnTzfLCpWzzXJSFog71+AJ
	 W8dr9ID44QzVuYDbck1LUvq7K732D9MiS1UJdOB9lLddb2Jd/eOvvNgr5YXih9932E
	 nomRNrK89wA1g==
Date: Tue, 18 Jun 2024 18:23:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] xdp: remove WARN() from __xdp_reg_mem_model()
Message-ID: <20240618182320.3352f030@kernel.org>
In-Reply-To: <20240617162708.492159-1-d.dulov@aladdin.ru>
References: <20240617162708.492159-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 19:27:08 +0300 Daniil Dulov wrote:
>  		if (ret < 0) {
> -			WARN_ON(1);
>  			return ERR_PTR(ret);
>  		}

nit: the brackets are no longer necessary, then

