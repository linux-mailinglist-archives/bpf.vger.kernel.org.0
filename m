Return-Path: <bpf+bounces-17956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974781416B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBDC1C22515
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70366AA7;
	Fri, 15 Dec 2023 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TZfagQVI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wL0m3xKX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z+c7Su/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D924107A5
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EFACEC151064
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 21:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702618304; bh=P0bNO7gbZtUSzwg+RE8hyY2faUFt+80Kw6WwhSWGPK8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=TZfagQVIymPk34Z1y/jxYzVa6WtbH5DZ/7jvoaDAqScYLSK4iN7+MAUoppJGXkeRg
	 9H44gBosUrS3QAlZ17TknGhK6V9OwlnAGuXhGJWvav0jJvHPFwHRVb3z1m8S3ykzKB
	 MSLuhf4kwy8v6PAkFurNwpdH+gwi2RRIrbL2ZGRQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Dec 14 21:31:43 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4A56DC14CF01;
	Thu, 14 Dec 2023 21:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702618303; bh=P0bNO7gbZtUSzwg+RE8hyY2faUFt+80Kw6WwhSWGPK8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=wL0m3xKX99SoLOA6mRdAAq91Ajs04Gp5UC0VgrKwJ2tG1A998cN8YTaKkXxk3ozmy
	 2swjroR8sgCwKz3ctxT3NX+3WzwlNnqUcWMMlJqywnqpSrnefnrA5wU8MDj8CdXBmP
	 4bYEORSpl6UUr3YNWmX97TG8bo8TA1qGocXANWR4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 01522C14CF01
 for <bpf@ietfa.amsl.com>; Thu, 14 Dec 2023 21:29:58 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fjtt_x7a1dTq for <bpf@ietfa.amsl.com>;
 Thu, 14 Dec 2023 21:29:53 -0800 (PST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9A0D3C14CEFC
 for <bpf@ietf.org>; Thu, 14 Dec 2023 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CtQY7KcTCGUbqzxXM2TcGqfofhXPlN3NkzbGgokG5XI=; b=z+c7Su/y35aW7BVvydk4qKg0N6
 fpWjylJIiX85R7eB8p5OD1KSAX/v2LKoE1HdHs+TMwdbl13OdrxWcJ9Zh5QlHfhVVEE+CJZ8+/tFm
 wBj9PS92GbJnHXi/asdNcFVPzzoA57eh79tuDWRAhgCYAw+lVbWLp/qn8WY6EKDY+bd8Y8gdFpoaE
 vkS74aSqnIwb4dGyNVSYiK5Q17mSVJihefbAgBEQmGoW/N5b4Je90wK5WQenpzdvZ+ge9juXzEu85
 kGMjIWs2vwHakfJNXg2LcDcCa8CBHv45tiObQLJdECglUjYSgJ3NmgN5M1Z8GNjJserVTLOBbkpAE
 eSPXLQkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rE0lf-0024GB-35; Fri, 15 Dec 2023 05:29:47 +0000
Date: Thu, 14 Dec 2023 21:29:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Message-ID: <ZXvkS4qmRMZqlWhA@infradead.org>
References: <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge>
 <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214174437.GA2853@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/jtz9uytxb_3R7CJ0LOnZ31SuR6s>
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

On Thu, Dec 14, 2023 at 11:44:37AM -0600, David Vernet wrote:
> > > Why else would they be asking for a standard if not to
> > > have some guidelines of what to implement?
> > 
> > Excellent question. I don't know why nvme folks need a standard.
> > Lack of standard didn't stop netronome.
> 
> Christoph? Any chance you can shed some light here?

netronome is a single vendor implementation.  You write for their
device and the standard is what they accept.  NVMe is an open,
multi-vendor standard.  You need to be able to write your code against
the spec and run it on all devices (that implement the required
features).  NVMe also needs another open standard as the reference as
it just can't point to a void.

> I agree that there's value in instructions having specific meaning and
> encodings, but my worry is that (for device offload) the value would be
> minimized quite a bit if a developer writing a BPF offload program
> doesn't also have some knowledge or guarantee of what instructions
> vendors have actually implemented.

Absolutely.

> If we were to do away with conformance groups, then I as a BPF user
> would have the guarantee: "Any hw device which happens to implement the
> instructions in my program will behave in a predictable way". If that
> user doesn't know what instructions it can count on being actually
> available in devices, then they're going to end up just implementing the
> program for a single device anyways. At that point, how useful was it
> really to standardize on the semantics of the instructions? That user
> just as soon could have read the specifications for the device and
> implemented the prog according to the semantics that the vendor decided
> were most appropriate for them.

We need the concept in the spec just to allow future extensability.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

