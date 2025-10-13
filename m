Return-Path: <bpf+bounces-70837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2357DBD607B
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 22:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D006F3AF393
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA12DCC06;
	Mon, 13 Oct 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="GjG2szOi"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369422068F;
	Mon, 13 Oct 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386027; cv=none; b=UWZjgxFdeTFMbo0oOf4dCsnjBvC1PgP5ZLI/n47mv9VWrNgzrUAUf1Aa0NChBqDUOQk9ErygWAhLNDlB5nnEl1lqC5/ZJTwsS1zvpdRXSxSf19R8Ma7Uigb8CWMw66sYcf8xqbGmlY54XqIursNlEWICvpnXhZPUDri76imuiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386027; c=relaxed/simple;
	bh=GQI5oy5kZ5VX2KJ0AYos3m5DLxXYIHJJmOpX1xhm8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC9/2OHPOwErw/pNTph8nq7BvaI2tzjuUwk8N4/xzBDmgBtRcoeB5jdi6P5RzWu+P0YzD0Q/UMSDdPEbf/ZmIoJ28DbzLbMPHuO/A4lO7Zjufa2zDXHGTlMKFzNmCA5TMnYV5P5qVgQJp1jRKF64K76jv2PHq9pRO0PBdNAtmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=GjG2szOi; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4clpKC19y5z9t8w;
	Mon, 13 Oct 2025 22:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760386015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81IUPPFMJcLJ1wFKQUYlhB5r6ec30JsWd3hfWvHQv2I=;
	b=GjG2szOiWY+irzcRbn1xtNyF++jjckTJjjUzW2IoVSzfrzznrgJXWHPVYZyUfB8UI0sCuc
	YzD13/qk7LsdnT4ILgMurMVQsXL2MO1KHbNcWu565DTf7oiswTV9Okwi24HGPWZ9iXSWQY
	dyaZtUYkoLuBOzoAJGVJ8ESMoJRHRzmEnCBtxMPPk2wAOtWtXEim/t0YJp1HerlJJoSv6N
	Aco8KhbVX5dz1g5w4QYvQe9BByE9Hls/To241DR4aWxbgcwo21bZP043llGeb9BFUhjopR
	4QCpYpnQMkU9aHZrhmtQMRfs0VZRFfTqMOBfu7e3lQnwDENjGbTKHCBPv8i5pw==
Date: Tue, 14 Oct 2025 01:36:48 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	khalid@kernel.org
Subject: Re: [PATCH v3] bpf: test_run: fix atomic context in timer path
 causing sleep-in-atomic BUG
Message-ID: <wox3agrrleq5ba24kjm3iyobelzo5ag45qukqouqs3k5mxyu2y@jfbyou4kuy4g>
References: <20251013171104.493153-1-chandna.linuxkernel@gmail.com>
 <b7fa9c76-f343-42d0-9c47-6a1af0deea2c@linux.dev>
 <u63lefbfseajkacl5uixafvvtlcwnpypxwqnrbgc5ec5c3tciy@prxb2yriebfy>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <u63lefbfseajkacl5uixafvvtlcwnpypxwqnrbgc5ec5c3tciy@prxb2yriebfy>

On 14.10.2025 01:31, Brahmajit Das wrote:
> On 13.10.2025 11:35, Yonghong Song wrote:
> > 
> > 
> > On 10/13/25 10:11 AM, Sahil Chandna wrote:
> > > The timer mode is initialized to NO_PREEMPT mode by default,
...snip...
> Yeah, my bad. The v2 is mine, which I send few mins before Sahil
> 
> https://lore.kernel.org/all/20251013171122.1403859-1-listout@listout.xyz/T/
https://lore.kernel.org/all/20251013171122.1403859-1-listout@listout.xyz/
> > 
> > In the future, please submit new patch set only after some reviews on the old patch.
> > 
> > I also recommend to replace e.g. [PATCH v3] to [PATCH bpf v3] (or [PATCH bpf-next v3])
> > so CI can do proper testing for either bpf or bpf-next.
> > 
> > For the title:
> >   bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG
> > Change to:
> >   bpf: Fix sleep-in-atomic BUG in timer path with RT kernel
> > 
> > The code change LGTM.
> > 
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > 
> > > 
> > > ---
> > > Changes since v2:
> > > - Fix uninitialized struct bpf_test_timer
...snip...

-- 
Regards,
listout

