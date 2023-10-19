Return-Path: <bpf+bounces-12658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38907CEFCB
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6C281EF1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2417FD;
	Thu, 19 Oct 2023 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="P3Xainwf";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HdWrKIqk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1CzkTHp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759C1FBA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:03:54 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B159116
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:03:52 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 22506C1519A2
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697695432; bh=7QREE2kMv6zCqhAPHL2efltZPoMbaF6IjK3X2BpieXY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=P3Xainwf42LXP/9y+lww4Go2T0n7dU1mfy+1kNXLsLXhiBE5ryd/VfrRSe8jXCxXh
	 /ZEaH5yXUS0XCTzwG9JhSrJ4kX3+nU6R5zY1rqU3MZC4hVmF1aIyVkwNXy/xwBro7t
	 WuciQFiJ3w2CVRrhrNUA5vQVf3YD940wZ7JQ7aCE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Oct 18 23:03:52 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DBDA9C151997;
	Wed, 18 Oct 2023 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697695431; bh=7QREE2kMv6zCqhAPHL2efltZPoMbaF6IjK3X2BpieXY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HdWrKIqkLMimUH3yKVDIRX35CiUaZ0GKNFhCQKRmkpn/jP+tAYaT03ZJhkWBC80Na
	 4hNIuZQ1ZqnDVvRjSeFLKksSCz1ElErEOSDPNDx1zJVspFdAjIEj54j9g7oynaO7yy
	 1tdlk/20cjo9M9R/i9gQB3+32nSqexjgTBotJhnA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C48D9C151998
 for <bpf@ietfa.amsl.com>; Wed, 18 Oct 2023 23:02:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -4.405
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6el-HKlqEcJ for <bpf@ietfa.amsl.com>;
 Wed, 18 Oct 2023 23:02:14 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DE26BC15199C
 for <bpf@ietf.org>; Wed, 18 Oct 2023 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zKy2wNaYKORtkieVCIKaIMBMg2DkWo5pfgwu0j8SZSo=; b=T1CzkTHpGKbpMfC4BVeYNkl7Je
 ZpAmEtHShkEp9QQXbANyIxrLZlnKNn0Q7klaBJfgwB8pTlEVaZX/mbCo5f+v2lnESB0QQccBvx0bp
 Rlmp1DgQWmhnWW9ooXrG0Be3olj+sr4s4CzFvHyPV62gTbJ8kUMvydbwmbtTHMyP/ucu+Q/rQ6LUT
 MacNH9iA49tJlZTMuFSzocqeYewgYll0KSKPDe5YKjKDzVJnxgJod5XXLtQOtyuvYrhFgcNMCsm/W
 y3RtQKR8nryY4SvCHZVRY5jLlqr0+hPYJEk6VXEsuvfTmfNzBS7VeP0FwINbSsl/wI4u29+Sp46Kk
 OzAj8FmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtM68-00GRvW-25; Thu, 19 Oct 2023 06:01:32 +0000
Date: Wed, 18 Oct 2023 23:01:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Message-ID: <ZTDGPJFegKuwZiOe@infradead.org>
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231002142001.3223261-1-hawkinsw@obs.cr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/OKmg36K2bWcH7Ad7xYvhFlELPjM>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Add additional ABI working draft base text
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

A little style nitpick on top of all the useful comments from
David:

> +An application binary interface (ABI) defines the requirements that one or more binary software

Text documents and any other bulky texts should be spaces to 80
characters.  This should just be a very trivial reformat.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

