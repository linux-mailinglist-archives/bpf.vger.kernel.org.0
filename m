Return-Path: <bpf+bounces-12657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF17CEFC9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F77BB21280
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A62186C;
	Thu, 19 Oct 2023 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYYMs1iO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CE17C2
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F51FE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iy7K0NNvOe9ObcQHxgus7YO71fkHVQ1hLDFILqCrRlk=; b=FYYMs1iOBBa1lnCFpe7XgPKhET
	4f7q4R7cHZsa4FEqNt9f7YyF65jFwK+d/fHXBi9tB04/hGA0UtLPYEjiFYbBFA9gaOq678/levoCb
	TLCPvkpJ/lbmRFzgcGffSLBD/qrB0EZ2sgQQIAyiML3EN0rZS/ASTwoGIh1mQdTXbMTgt4pKElSak
	Sxm0+1bdh1qaMCF8UkQeFjWl0mcDHVOwx+DiOUC6QA9vAOLdST3c1qgTv7i9GI0Cnok7zWqEwLa71
	6n5DMUZXAdCDiv1RTS5rJjzkcwHIVMTUI87Qu+nHYPrjuqRJYCov/CLcn0vt5XlzfzLzvGXSFViyn
	vhNw1+Qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qtM7C-00GSIN-1D;
	Thu, 19 Oct 2023 06:02:38 +0000
Date: Wed, 18 Oct 2023 23:02:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] ISA RFC compliance question
Message-ID: <ZTDGfppgSnpKjaYz@infradead.org>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 29, 2023 at 08:14:12PM +0000, Dave Thaler wrote:
> Now that we have some new "v4" instructions, it seems a good time to ask about
> what it means to support (or comply with) the ISA RFC once published.  Does
> it mean that a verifier/disassembler/JIT compiler/etc. MUST support *all* the
> non-deprecated instructions in the document?   That is any runtime or tool that
> doesn't support the new instructions is considered non-compliant with the BPF ISA?

Unless we clearly designate optional extensions that that can clearly
be marked supported or not supported that is the only way to get
interoperability.


