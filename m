Return-Path: <bpf+bounces-63974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD94B0CEF5
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3781884CCB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8D189B80;
	Tue, 22 Jul 2025 01:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502913632B;
	Tue, 22 Jul 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146256; cv=none; b=eWVowmL1RhXjVeXw8FcKtrK6iqsa04iAllEcI2QE+Yl9hYaYqY9rtbwWuMdmRTY41bx6Utq7XpLILLxiKP+QFtF/qLcDSkKh/tOPXZxxi79CWPGalLPnEK8rxm8Gio900NJBYMgmz3aj+w1zjy+jHHAPG5Y/cunPXBHTlvwyCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146256; c=relaxed/simple;
	bh=4Vb7pB2CF/ujkYptFndBbZgwip9sEyFNiI3GLWzde6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7+M9wBngNH/+j82eVKn3EsqE2Vb8Y+uQkWRRXyD/sJgMlJEJrSqPSOHc3xF7QZQv3NA8sco85n0DoJLg6noZLBbolYevP15Y1doEZjywGr15x4VdvQZvOKNl8yW3e65CU6UgPvxl7H2CJNhX6veMlDUFsiQPOPN0dunDDsgvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0e-687ee38a93ef
Date: Tue, 22 Jul 2025 10:04:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250722010405.GB45337@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
 <20250721081910.GA21207@system.software.com>
 <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvTPTmaGxOtTtKi9Y97qhYjzGJRgSc43RaEw04oM2MrGNbJbF
	YiKpiihiK6IYLUXrBggoWBUKAmETQTEQ3OpWENFEUUCgVZaALWr07Tv/f/Kd+3B5Wm6TTOE1
	YVGiNkwVomCljPTb6Mvzkz7Eqf0yUiVgzstlIeenDjJbbO4puwBBb98bDoZLaxD0VD9kob2q
	G8HVyy4azA3xDDjz+mn4WNPKQY51AzRnfGKg5FghDa2nalkwxA/QUNrXwcFhWxYF5jt6DhoL
	jBI423+dhkJ9CwdPi80sOHKHJfCp0sBAnekGA12p1TQ0GwOgxjIRXI+/IqjOK6TAdTKdhecX
	iik402Rh4UN8M4KmqlYGUgePs5B2yIhg4Kfb1pHcK4G0Bw4uQEmqvnbS5O6NVxSxlz2iSJHp
	HUcs1mhyJ0tJTtibaGLNTmSJtTuFI29flLCk9vwAQ4reLydFth6KGI50sOT7x9cM6Sx7zm4a
	FyRdGSyGaGJE7cLVu6TqJ99/UBH1El1tm4nSIwtzAnnxWPDHL8suUn8594hzJGeEGbjH8BR5
	mBVmYbu9j/bweGE2tibku1nK04KZw03GdM5TjBOCcKO+dEQkEwA7nQ2MZ0ku1CNsuZ32p/DG
	dRfaRi7QghLbhz67c97NPjhziPfEXsJqXHL698oEYRouL3hIeTxYeMbj3vx76PdLJ+OKLDuT
	jATTf1rTf1rTP60F0dlIrgmLCVVpQvwXqGPDNLoFu8NDrcj9nzIODu6woe7GLZVI4JFitMxX
	H6eWS1QxkbGhlQjztGK8zHXfHcmCVbEHRG34Tm10iBhZiXx4RjFJtti1P1gu7FFFiXtFMULU
	/m0p3muKHsXMidrApeiT7bqlN5XtQcE5V+ZSFRfXXLr97dpMR2ZC+xrvlPrp85TLi6f6dlQk
	NZrRtnDfwLVPNuY6/WfGk66tbeKX7V/GrF93fnCX78l37Y4614q2VedulS9JajlqGJtY4bPP
	6LcusFoXWL5Z+fosROdELAuo2wKOc3ER9/Z7JYxSMJFq1SIlrY1U/QLTl+eMSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z+7w8HJ1I76JReiWGlFxWuJCn3wUBhRRFFEjjy51aaxmWmR
	rJQuQ01LIeeMRaWpE2uWbnmh1LyUlWwU6+olMyzxNl3esjYr8tuP5/K+Xx4G99KR/ow8KUVQ
	JUkVEkpEiHZuzVyr/ZwhW3fDtgb01UYKKqfToKzXTIK+ohbB5Mx7Gn41tiFwtLZT8L1lAsGt
	m04c9K+yCJiqnsXhS1s/DZWmOOgpHSSg4WIdDv1XOijIyZrDoXFmhIbz5rsY6Gs0NLSUdJLQ
	XZtLQsHsHRzqNL002B7pKfhk/EXCYHMOAZ26cgLGCltx6MmNgTaDLzifDyNora7DwJldQsHr
	okcYXLMaKPic1YPA2tJPQOH8JQqKz+UimJt2XRvJmySh+OknOmY13zI8ivMPyt9ivL3pGcZb
	dB9p3mA6ydfcDeW1divOmyouU7xp4irNf3jTQPEd1+cI3tIXwVvMDozPyRyh+PEv7wh+tOk1
	tcv7gCgyQVDIUwVVeFS8SPZi/Ad2ootM6xjQYRpkILTIg+HYjZwxc2qRCTaIc+TYkJspNpiz
	22dwN3uzIZzpwj0Xixic1dOcNbeEdhvL2QNct6YRc7OYBW5q6hXhDnmxXYgz3C/+ayzjOosG
	Fj/gbChnXxhy6YyLA7iyBcYte7BRXEP+n4gPu4p7XNuO5SGxbklbt6St+982ILwCecuTUpVS
	uWJTmPq4LD1JnhZ2JFlpQq7FlJ6dzzejSVtsM2IZJPEUr9RkyLxIaao6XdmMOAaXeIud9S5J
	nCBNPy2okg+rTioEdTMKYAjJCvH2fUK8F5soTRGOC8IJQfXPxRgPfw26T9PbAirH2/26J09b
	sw+lJXzz9RkILI3dy41EntoR3vewN7nsp7A7YpNH0wu/opcbDu6vibso998yfDvy65Aj2r+q
	3lNxW3O5S/tkvnKLOJgQPQshdYGOM3HGDnPYTmPKx6Bjg/GtnkMFw9aSU2EGpWV6ma9Sm7i5
	yrZHH310zCQh1DLp+lBcpZb+BmVWSeItAwAA
X-CFilter-Loop: Reflected

On Mon, Jul 21, 2025 at 10:49:37AM +0200, David Hildenbrand wrote:
> > > This will not work they way you want it once you rebase on top of
> > > linux-next, where we have (from mm/mm-stable)
> > > 
> > > commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d
> > 
> > I just checked this.
> > 
> > So is it sufficient that I rebase on mm/mm-stable?  Or should I wait for
> > something else?  Or should I achieve this in other ways?
> 
> Probably best to rebase (+test) to linux-next, where that commit should
> be in.

I will.

	Byungchul

> Whatever is in mm-stable is expected to go upstream in the next merge
> window (iow, soon), with stable commit ids.
> 
> --
> Cheers,
> 
> David / dhildenb

