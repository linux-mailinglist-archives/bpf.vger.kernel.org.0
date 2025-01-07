Return-Path: <bpf+bounces-48124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6AA0432D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA611624D1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C31F2398;
	Tue,  7 Jan 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdGM3X40"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9E1F238A;
	Tue,  7 Jan 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261461; cv=none; b=B7/iNKM8KBrNOs1wKL+FC2AtWTydQ4PCD0UgIr9itqO12w8rqIhdEsjzOgng4H2n2sqURObZ+qMyuNQ2/NQ9nGM7/3muMfnN+5QfgcD1Tw8qKnZpxHwoxVK5P6g4EhBFjFj+amXTWFf7iOMLXctq44GhMOPgLjb9SnjYBkLGvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261461; c=relaxed/simple;
	bh=qJzjlETX7LeS0DXplnQvRn5K3Ju/fkOM7qqiIKai7bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz+cVXtKo5Kq3YddOWRLPStNLYuBTvbw+nU3jHxS00flXRNjgLSJDHgbu5ThT1smZYD5+TyPZ9RN/mk7dMlFi7exA8Y+LoQad2PyOKjCbi3TtB6zthJYuQh9mcDOAhU37uX+YiLv28GpTL7L81hF7qgdDpkm7iz1qpHYohqz9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bdGM3X40; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LqehdsfcI50oCVlJ1AA/1AKOJ10IfePPnL9tXWi/O3g=; b=bdGM3X40XB0h8JW7XTeJswGNaD
	zybEDZR7MkvrJkFU8igICuEsAOwuRktdavQJ4mduiZbxv+NeO+nNjtXkHmGMRdfmQ+fzFVgIhtGYc
	/UeuOayWO7z9M5d0cOAsPI887uzl4BRL7QneTIFLZExZswyg3rYE8ywDa6771AXMEJitBnwJyAJnu
	3oTnkbmVUqts3Tyq06r2V/LWVHHcKA3vuTeBFnZ9rYz7aLuBQmE5wnURVGR4zjs4sPOTgK55Z4HYC
	pHG9ICFsB1bQn86CK8/F2MQRvkIBUIqxR6B1TPPdoMGNHHnTmmVLETaXO2QEfhkV93E+26CpPMpyU
	eUjB/eHw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVAuy-000000099wz-0NVd;
	Tue, 07 Jan 2025 14:50:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31DD330057C; Tue,  7 Jan 2025 15:50:51 +0100 (CET)
Date: Tue, 7 Jan 2025 15:50:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 07/22] rqspinlock: Add support for timeouts
Message-ID: <20250107145051.GA23315@noisy.programming.kicks-ass.net>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-8-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107140004.2732830-8-memxor@gmail.com>

On Tue, Jan 07, 2025 at 05:59:49AM -0800, Kumar Kartikeya Dwivedi wrote:
> +struct rqspinlock_timeout {
> +	u64 timeout_end;
> +	u64 duration;
> +	u16 spin;
> +};

> +#define RES_CHECK_TIMEOUT(ts, ret)                    \
> +	({                                            \
> +		if (!((ts).spin++ & 0xffff))          \

Per the above spin is a u16, this mask is pointless.

> +			(ret) = check_timeout(&(ts)); \
> +		(ret);                                \
> +	})

