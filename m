Return-Path: <bpf+bounces-11564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CB7BBFBD
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720CA1C20A6C
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C603FB1B;
	Fri,  6 Oct 2023 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mInSNLtt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7B3AC2E;
	Fri,  6 Oct 2023 19:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39F6C433C7;
	Fri,  6 Oct 2023 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696620701;
	bh=Q7zwpcJxQRtUxVNDSB8lv/dWjHOWr8CPrXyivyBBXEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mInSNLttltzWAQns5eTthws5U0HEsOHcWjvCtmKQ3xy8OmJj69aDMZ4T2gj+oYbme
	 TtIw/DvxOf5qUQIqhKOT51TDbq0gtYy5/RJh0i//DsEPixnOr9n0QFsg/o6e2OvZeD
	 LdHwWDoN8aXeoKdOWUBnarkYecoJZCX/yZ244sujD700asGMflyjDMkcSmeDH7KwMX
	 0ynWdLqev1yyPhTcsNKiQbAziD8S4TuJuxtkdbb43OAqrwSK9LcvqUGoDHsw8qfsY1
	 gcDq80Ubxv66IYXsJXbNvDUxivoTaGy61ouaMsfVblGYVjxAenuF6DdoU8MDqj4+Mz
	 2tsNcL4gGU0ZA==
Date: Fri, 6 Oct 2023 12:31:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Paolo
 Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Message-ID: <20231006123139.5203444e@kernel.org>
In-Reply-To: <20231006154933.mQgxQHHt@linutronix.de>
References: <20230929165825.RvwBYGP1@linutronix.de>
	<20231004070926.5b4ba04c@kernel.org>
	<20231006154933.mQgxQHHt@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 17:49:33 +0200 Sebastian Andrzej Siewior wrote:
>   - Moved xdp_do_check_flushed() to net/core/dev.h.
>   - Stripped __ from function names.
>   - Removed empty lines within an ifdef block.
>   - xdp_do_check_flushed() is now behind CONFIG_DEBUG_NET &&
>     CONFIG_BPF_SYSCALL. dev_check_flush and cpu_map_check_flush are now
>     only behind CONFIG_DEBUG_NET. They have no empty inline function for
>     the !CONFIG_DEBUG_NET case since they are only called in
>     CONFIG_DEBUG_NET case.


Other than the minor nit from the build bot - LGTM now thanks!

Acked-by: Jakub Kicinski <kuba@kernel.org>

