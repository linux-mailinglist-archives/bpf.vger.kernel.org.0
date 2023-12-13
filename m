Return-Path: <bpf+bounces-17683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE8811A43
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B7CB212A6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532A4E1A0;
	Wed, 13 Dec 2023 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="U+pkM0Cw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="U+pkM0Cw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OoLuFdXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17271B3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:00:29 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9513FC15107F
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702486829; bh=3Wy6pYTnDyFpM2qs1SMxdzsJ53kAzfqo1dL3PaFK+y0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U+pkM0CwSnelUGfwybG5E6YOAHMED/IR8XKKKM824meA3bNOo/ku9ii8BOZ30USws
	 8onA0kWzsji1vZdwGlKILscXZl4CVMqiKW9mEQacwjYrR0CefiwBgSjV6FnNBQOXdt
	 HVC6XuIUNi295B0ut23k1y9Hdij3NYVYJ/0Q97mE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Dec 13 09:00:29 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 27709C14F5F1;
	Wed, 13 Dec 2023 09:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702486829; bh=3Wy6pYTnDyFpM2qs1SMxdzsJ53kAzfqo1dL3PaFK+y0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U+pkM0CwSnelUGfwybG5E6YOAHMED/IR8XKKKM824meA3bNOo/ku9ii8BOZ30USws
	 8onA0kWzsji1vZdwGlKILscXZl4CVMqiKW9mEQacwjYrR0CefiwBgSjV6FnNBQOXdt
	 HVC6XuIUNi295B0ut23k1y9Hdij3NYVYJ/0Q97mE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 80C7AC14CEF9;
 Wed, 13 Dec 2023 08:59:26 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.104
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4L7SFPw-ScjG; Wed, 13 Dec 2023 08:59:22 -0800 (PST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E18C6C14F5F1;
 Wed, 13 Dec 2023 08:59:18 -0800 (PST)
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
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rDSZo-00FWSp-1s; Wed, 13 Dec 2023 16:59:16 +0000
Date: Wed, 13 Dec 2023 08:59:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 Christoph Hellwig <hch@infradead.org>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20231212214532.GB1222@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/fSgrV7MrHmC0_yXROILd5Sm7nnw>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

