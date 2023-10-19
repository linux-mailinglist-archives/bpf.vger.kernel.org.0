Return-Path: <bpf+bounces-12656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD407CEFC6
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554A5281EA0
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81413186C;
	Thu, 19 Oct 2023 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1CzkTHp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A17C2
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:01:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF22198B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:01:36 -0700 (PDT)
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
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qtM68-00GRvW-25;
	Thu, 19 Oct 2023 06:01:32 +0000
Date: Wed, 18 Oct 2023 23:01:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: [Bpf] [PATCH] bpf, docs: Add additional ABI working draft base
 text
Message-ID: <ZTDGPJFegKuwZiOe@infradead.org>
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002142001.3223261-1-hawkinsw@obs.cr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

A little style nitpick on top of all the useful comments from
David:

> +An application binary interface (ABI) defines the requirements that one or more binary software

Text documents and any other bulky texts should be spaces to 80
characters.  This should just be a very trivial reformat.

