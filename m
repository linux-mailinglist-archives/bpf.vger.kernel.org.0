Return-Path: <bpf+bounces-17681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB36811A31
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C8A1C21197
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307D3219C;
	Wed, 13 Dec 2023 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OoLuFdXR"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1821DAC
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=orJVMjR7jVrNlAzsEKDkXK8eWd/iVLh2GJI+1vlzcZI=; b=OoLuFdXREyYJSC98gCRXNJf3Oc
	To9wO83VrGXwHTbr8e7g/BLeNIfJlvokP/HUY0j1Lgz1RjceHzfYfABfgOIbQCWqrvhWFcAeHWtLi
	1CzjYl3VEajIWuQw0bYjypFz+8bMfgpLoAtvqnR7l/LHd0nAQitWdsmTJ966faGl5teC7Hjtiw0xX
	MpJa/UNLPpUKYSQ2IY6Q3+1784fq3cPKPkRe7qpqz36LNrl51MsimVsYBTQC2pU8PVTnhkrI5W3tj
	Ilim5PxeB4rva8AGMBJtpZm7Fi0WJh0cACScPmlSGH0LT8R+YWwQYqVq5OgRt99JAx5+WTRaCus8Y
	ZFKCqazg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDSZo-00FWSp-1s;
	Wed, 13 Dec 2023 16:59:16 +0000
Date: Wed, 13 Dec 2023 08:59:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
	Christoph Hellwig <hch@infradead.org>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <ZXni5GGX8iI+fN7t@infradead.org>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212214532.GB1222@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 12, 2023 at 03:45:32PM -0600, David Vernet wrote:
> > I think we should do just two categories: legacy and the rest,
> > since any scheme will be flawed and infinite bikeshedding will ensue.
> 
> If we do this, then aren't we forcing every vendor that adds BPF support
> to support every single instruction if they want to be compliant?

Yes, you do.  And if we have use cases and implementation restrictions
that ask for not supporting some that would be the biggest reason to
have more groups.  I brough up some examples where we don't need e.g.
atomics.  I've not really heard from implementor that implementing
the instructions is a burden for them, though.

> I think it's reasonable to expect that if you require an atomic add,
> that you may also require the other atomic instructions as well and that
> it would be logical to group them together, yes. I believe that
> Netronome supports all of the atomic instructions, as one example. If
> you're providing a BPF runtime in an environment where atomic adds are
> required, I think it stands to reason that you should probably support
> the other atomics as well, no?

Agreed.

> From my perspective, the reason that we want conformance groups is
> purely for compliance and cross compatibility. If someone has a BPF
> program that does some class of operations, then conformance groups
> inform them about whether their prog will be able to run on some vendor
> implementation of BPF.

Yes.

> FWIW, my perspective is that we should be aiming to enable compliance.
> I don't see any reason why a BPF prog that's offloaded to a NIC to do
> packet filtering shouldn't be able to e.g. run on multiple devices.
> That certainly won't be the case for every type of BPF program, but
> classifying groups of instructions does seem prudent.

100% agreed.

