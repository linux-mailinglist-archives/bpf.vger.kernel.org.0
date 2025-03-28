Return-Path: <bpf+bounces-54853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770DA74955
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1581891EA2
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0521ABD7;
	Fri, 28 Mar 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od0lmCZE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2690219E93;
	Fri, 28 Mar 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161984; cv=none; b=PieYllGKkFx7diuKS020o5hkJPnIK5jtvdIfCQXhgzgV/Hnq65aWUfOAbNVWerdl/FQkx2ZPrajw6cEH5supv58EuPJDbPLApEztUtErq4Eso2hY9FgbiGKyOizQQmJ84NsfxcbyDHLh9ZToAnaL/ewXndzt3cXYpqoO2ufp5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161984; c=relaxed/simple;
	bh=VpclY77LC2UScTUAvSmsEmH/yJZOtBuiJg7uhPWchSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZjWwktc2eQZ/DrODTQ2Xf3e588mRWBh2Mgw75TibV66GDQfKoYlja8/zFH7bb98o3MZR5cz4/ImU3w+F8xu7QYwmIDVY9NGdmOkgIcoL8aKjyVUL2Bu0Vz+tNz855BXsr9Kt4IIUL0tiym1BD6ieAVlmGfCvwECvuyAkGt01x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od0lmCZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EBBC4CEE4;
	Fri, 28 Mar 2025 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743161983;
	bh=VpclY77LC2UScTUAvSmsEmH/yJZOtBuiJg7uhPWchSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=od0lmCZEqeq2uaZAtSxzMBD16GJUjxtNFigaGLkpuhGZQTG59fUuRB4e/5iW2AZc8
	 wXxjNMcbgGI7rQYdQ+nYl9Agi8fUTJVnfTdkXhlBq/rB2qZwX322gvoyWgWW7wXErh
	 uNU8WaDEgpDId/Aste1gXn7/8+NZsQDGWHgOymIqn4SH1e5YMDziquqUWlDJll3bpF
	 wv4vyKKPWNmiTkhCrYEnVR7qjG8p+eebGSo44+xPUSsnhH7p/WLseo30U1f6G9GORI
	 WMFDlJhYsdX1C0b83xju02cA9nI2ZP63VBJKELG4Nql2MRrTuCWddHpVgsWCBA9RlX
	 XLkv9kMyffk3A==
Date: Fri, 28 Mar 2025 04:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
Message-ID: <20250328043941.085de23b@kernel.org>
In-Reply-To: <17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev>
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
	<67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
	<17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 09:15:53 +0000 Jiayuan Chen wrote:
> I'm wondering if we can directly perform a memset in bpf_xdp_adjust_head
> when users execute an expand header (offset < 0).

Same situation happens in bpf_xdp_adjust_meta(), but I'm pretty
sure this was discussed and considered too high cost for XDP.
Could you find the old discussions and double check the arguments
made back then? Opinions may have changed but let's make sure we're
not missing anything. And performance numbers would be good to have
since the main reason this isn't done today was perf.

