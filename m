Return-Path: <bpf+bounces-12659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E97CEFCC
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358A3B212B5
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9C17FD;
	Thu, 19 Oct 2023 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="fw1v313b";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ApU8FJjX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYYMs1iO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDA186C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:04:03 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8BF12D
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:04:01 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 153D8C1519AE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697695441; bh=9jIfV+ccN/3jTighuIXILj3np/VaR5HZMkVR8iGWtvM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fw1v313bk4Ux2SIkGJUOzexDJdBaNEBHs3yzNpn853aGvzXiPsrTc/cC2LxDKGNHr
	 pBr8HnyBQEab2q0Igs6U1uTC7gBxXhAnoNGTyWCNQDANrgjjdIFd8PgMh+L7y6BSwT
	 B0xBV5stG563gwAruKMH8IektRDh1t+F6+VbKDqU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Oct 18 23:04:01 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D71F7C151997;
	Wed, 18 Oct 2023 23:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697695440; bh=9jIfV+ccN/3jTighuIXILj3np/VaR5HZMkVR8iGWtvM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ApU8FJjX28C3ggQVElti3DYGWmacll26Hgsn9VGe5vNtFlJdm4esDlDxs+sp3U2RT
	 euFqm8UZbhVNLztzgHXDoBhbJAWoqUXaAmYjzroepdyyycJ8ACbHABimvqeV8z76Oo
	 VD3W5qb0PhXKWY1LLTIoCiKyU5M6MDw2yTEFQ8Gw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 33085C151997;
 Wed, 18 Oct 2023 23:02:44 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MTBsuGyGUGa; Wed, 18 Oct 2023 23:02:39 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 61AFCC15199A;
 Wed, 18 Oct 2023 23:02:38 -0700 (PDT)
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
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtM7C-00GSIN-1D; Thu, 19 Oct 2023 06:02:38 +0000
Date: Wed, 18 Oct 2023 23:02:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Message-ID: <ZTDGfppgSnpKjaYz@infradead.org>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wP9pZJzAnS9lDCQLFHTO7AFkOlU>
Subject: Re: [Bpf] ISA RFC compliance question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

On Fri, Sep 29, 2023 at 08:14:12PM +0000, Dave Thaler wrote:
> Now that we have some new "v4" instructions, it seems a good time to ask about
> what it means to support (or comply with) the ISA RFC once published.  Does
> it mean that a verifier/disassembler/JIT compiler/etc. MUST support *all* the
> non-deprecated instructions in the document?   That is any runtime or tool that
> doesn't support the new instructions is considered non-compliant with the BPF ISA?

Unless we clearly designate optional extensions that that can clearly
be marked supported or not supported that is the only way to get
interoperability.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

