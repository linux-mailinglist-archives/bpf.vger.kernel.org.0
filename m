Return-Path: <bpf+bounces-53710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C83A58ADD
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 04:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E26188A9E8
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D331B4257;
	Mon, 10 Mar 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="UFPXGI7q"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707825761;
	Mon, 10 Mar 2025 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577614; cv=none; b=Y/b/B3tY7huWPJPwAP0tEIyy6kOUISYYH9/Ot2WSjTG3ZpBaKyT5ItgBJfb+2dIPNo20WG4W57PnBJ0CkqbIubXCMAK0uLq0X6oDArgA8dhP8MlQlGyrj1gCjF40IKCMBhoJX/3XlSC/p3ytr3qjedcRxeVSi/yUryS1cLCtWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577614; c=relaxed/simple;
	bh=f0k56qvsMhHdVRFz0QM/+Bghg7k+qB60yoKABxJ9b1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFEuwP3Z/Kt+/aNxyVD8FCSkf1cmfCjizDc+p2Xs2w4exovlvuBBPJFEUYnYcYdsE4juKTp1v1fbUSis7/yg3zAOEkRIDNe4ivSc+XhHgurcYv11yb8MDTIFYeyfSsCbYCHRbxIETKoLjV+t7BZ2LTP4Vusgd9mmRFZbWuvv/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=UFPXGI7q; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741577552;
	bh=F5DYTblmaHizCFECd/mw4UoRe44G105xCaXSNa1BSk8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=UFPXGI7qKw257vc/i1qmnJMtAL6XDcbfe/BcfrWdF8UerBHfTidkSVM8yK6rf2jdt
	 Bi3D5VAimpomFLNoVMF2bEOoEBGHTdFqkf61lG8bDq4icpG4QqAk0/YaDY1kb8dDAl
	 tnXT9I4zTuThP3VGaZT0hkXOBosFRgsfPex0IA/w=
X-QQ-mid: bizesmtp91t1741577543t5z8ofco
X-QQ-Originating-IP: +kaqd/DxV6IMruITGncQdVFlxOnMDUpyUV3edS5dF7k=
Received: from black-desk-ThinkPad-L14-Gen-2 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Mar 2025 11:32:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11214409611350112389
Date: Mon, 10 Mar 2025 11:32:20 +0800
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jann Horn <jannh@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-ID: <6C251C41A8C9FE1F+Z85dRCJilpuUgaWZ@black-desk-ThinkPad-L14-Gen-2>
References: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
 <20250306150811.a2a5fbf0919f06fb5f08178a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306150811.a2a5fbf0919f06fb5f08178a@linux-foundation.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NXz5KUaIchMRB9msCr4+jgmoXfX/SeQEDW52rahJ+oRHZR0+0KJC77vq
	LGaFkELVoJ8h5BQbh+znvEREOJzuq3uKTlP22kNTA7TFRC1Kt6mmBT8ScFA/fqlVGJVsCxS
	jRRWiCOsu/y6UqVJL5P4Sn2MU/5bFpV7RHhDXrkS6YK0ViTPlf4rmbl1dIeMNHGqVsVc+i+
	BbFqAkAC71xOo66S/5qmWUNYgEvEGtcyX7P0xdDArSqW7zjqsrszhc8EAeftsISOmPT5Ssd
	IFErpJL0DRqUNkmpniuACDg+3hJkE9mUYjszvWAmXRIqDn5IYbiFwr/HJWcSimfZPT6zA/r
	s9Sc+Jcl6q8xGXzVcOwO1lXoMQtF/tVf8UULzvMdNI2mFrHc7gH1ZYXluWSykv0tFVWyjLn
	TCv0myYKr3jVXLjFb8pFT9p/g6PYQsOyIbvQqTGfBahYNRQPY6oY/20WTpvpyiPbbdty/9n
	SA8KkdF7eOWJl7JGv/ZaANyMP90Eo3FO+hzrHyjFzX1nwR3Yl5QSjaQ4GtekfGyFkWVEUHw
	gt9agBZYQsvMQ8sTmt8r4dXhmVvu0GCMuvKCLWshXPleq42RKtsPG4/38H5JmtA3jlxHE/d
	pU0wiE+QcaRx+u9h8HOcTIVTBPen20LIW9M7tZvbfT+o9Hm7fCeyJGxDXJ7sD8iUA1nOcAM
	zUp+rBSVvTxzVw3TV3F/ppodK9bQJS0h+i/deo+TpugQ8BjzgC+4T3njpYvhVIrw33JC4ov
	ruk98j4g1J98w/d4MyW+eWmzmBMmpU9FBUozbUZhraqNHJ7KsytlSLw7H+lVKoKnMX4CofI
	oJj0aT8Ln8Vb6y5leoWG9FvBGg8/GYGAwr2TZZ+/YFqRkBLlA3qSad0LlJ6+QM+9FA4rLVj
	nVWsTwo2klDmhAR7D3UtsDUuR97W1XrZVssAoPLgx6HIRGmiY9kswBXR7mDw2FfJS8sqNJn
	FIX+8QsVJvbwzLFCYbO6NechYG2vHje400mI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, Mar 06, 2025 at 03:08:11PM -0800, Andrew Morton wrote:
> On Thu,  6 Mar 2025 13:06:58 +0800 Chen Linxuan <chenlinxuan@deepin.org> wrote:
> 
> > Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> > Handle memfd_secret() files in build_id_parse()") to address an issue
> > where accessing secret memfd contents through build_id_parse() would
> > trigger faults.
> > 
> > Original report and repro can be found in [0].
> > 
> >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > 
> > This repro will cause BUG: unable to handle kernel paging request in
> > build_id_parse in 5.15/6.1/6.6.
> > 
> > ...
> >
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> >  	if (!vma->vm_file)
> >  		return -EINVAL;
> >  
> > +#ifdef CONFIG_SECRETMEM
> > +	/* reject secretmem folios created with memfd_secret() */
> > +	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
> > +		return -EFAULT;
> > +#endif
> > +
> >  	page = find_get_page(vma->vm_file->f_mapping, 0);
> >  	if (!page)
> >  		return -EFAULT;	/* page not mapped */
> 
> Please redo this against a current kernel?  build_id_parse() has
> changed a lot.

stable/linux-6.13.y and stable/linux-6.12.y has commit 5ac9b4e935df
("lib/buildid: Handle memfd_secret() files in build_id_parse()").

stable/linux-5.10.y and stable/linux-5.4.y do not have memfd_secret(2) feature,
so this patch is not needed.

> 
> 

