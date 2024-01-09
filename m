Return-Path: <bpf+bounces-19260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F83828901
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46601C243EF
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EBE39FDE;
	Tue,  9 Jan 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rp35JrSc"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57C39FD5
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zTqIpFvqZDLD2t13ZwguVPUzOc8nsxZ9Gap2elMEjxA=; b=rp35JrScp4GBOEHORdKuwLQ9Oq
	IA/3JcvGr8bQpPvwyFDVCGUGqBAoYahuWqq1aML2CRLCPp4xtPCiAtlb8yk2tE45nYIJekzyuDdYZ
	BpsorJ32HVL41tbMF5ZbNn49r3MrDqo5CA9LL0dtgPuMXXf2Pz2vAR1cs6U+0UtrOpdF+GNI/wbrC
	0klkGwtC3E3Mx2hORMf3C95pVGlaHrIg9wFHpIGCpjSeCMTDRag9bZee3T7T+51yJMcTvvtHR1qti
	/dGOKbFWguGFOl2tvTJuc909RaxsTuG9m6VVcRkZWn99j06QQgn+FMf7r/C5MAheEr/Nnx7sAxArL
	vv4A2KCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNE03-008fjT-2x;
	Tue, 09 Jan 2024 15:26:43 +0000
Date: Tue, 9 Jan 2024 07:26:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Vernet <void@manifault.com>,
	Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <ZZ1lszzrzF5IpNFk@infradead.org>
References: <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge>
 <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org>
 <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 08, 2024 at 01:51:21PM -0800, Alexei Starovoitov wrote:
> Here is how I was thinking about the grouping:
> 32-bit set: all 32-bit instructions those with BPF_ALU and BPF_JMP32
> and load/store.
> 
> 64-bit set: above plus BPF_ALU64 and BPF_JMP.

Sound good, modulo the sets beeing exclusive or includig others, but
that's really a semantic thing for the standard and doesn't have
an affect on the implementations.

