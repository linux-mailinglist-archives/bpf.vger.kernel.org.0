Return-Path: <bpf+bounces-68492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC41B594CA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3CD3A9A4E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740162C029D;
	Tue, 16 Sep 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3Ee/3+z"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAB221DAC;
	Tue, 16 Sep 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020848; cv=none; b=OtinLMGWKd+FULRkkBuuK//6fhrGS909q+sjwzuTft+N7LmFYvcuHwPxzhoArBGa6wjMR+DMAn6d2gMrEBpJMqEDGn5lrY3wu/t45gJStokPYJ1STcTYAKinSoxXA1QEd0cO89t63aKhZFNgb6BqJ+4sRpvCAe+bQpz1UDdqh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020848; c=relaxed/simple;
	bh=+OWiZv2VMXqRku/2iN5XTPGd4eORHe80LYaSmX9dnUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjSaEHokrJv7yOSPdib8Jg2K9slMUBbeAKGAMsV+mBJLomutflQBiS3TDeoVObW0wM0FrQMD8Uq8P2hOc1Jbf+J7kbXQLDPac8gRn1MXJiTdSNetYnRgDGGs1/8dxaOzNsF9TdT0utdnfotD6Pe7AgZklu1/5HCLISIpjoVhqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q3Ee/3+z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pqLjTkoGRTLgRGg9sVdY95cKq2ea+0UQO3//Lbp1x3s=; b=q3Ee/3+z/2HHdhhg5n6bdCcTke
	fGlpvk+IQ0C9HHb9nmEKd7Lu4H4J5nMNNnUV9NZdjctNpPqu0tJPaTcZ6Mzsjtz67BJ9IPoZysWYg
	06GECffxcNa3yDEVebZQLioBOqQrcMBJag06YjeKRd6A1UMrc1R8RCHjmJoNQo1sXW3Fuj/cF8/yJ
	TsE63u9bCDMSOAo0+siglPc3yJF69xkkLqld/o1PpBYzOEkpL0rchcnyKxPVSJnJKfvPK/6iB7mQX
	qH/2w1dt6W8+1twbC22fB4C8u47e+4coGjPjj/nPr+RXiUp0S+WoBqfIGcX6g6yMCD0mYhf/ofRlx
	lZvu3pqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTWj-00000007BId-1geD;
	Tue, 16 Sep 2025 11:07:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E572B300230; Tue, 16 Sep 2025 13:07:12 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:07:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: ast@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	tzimmermann@suse.de, simona.vetter@ffwll.ch, jani.nikula@intel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
References: <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828060354.57846-3-menglong.dong@linux.dev>

On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:

> +/* The "struct rq" is not available here, so we can't access the
> + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> + *   typeof((ptr) + 0)
> + *
> + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> + */

Please fix broken comment style while you fix that compile error.

