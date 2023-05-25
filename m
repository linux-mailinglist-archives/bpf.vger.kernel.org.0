Return-Path: <bpf+bounces-1209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB88E710693
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AF21C20E67
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54ABE6A;
	Thu, 25 May 2023 07:44:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28BBE51
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 07:44:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C0910C3
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FArhRYBG4hLs81GjlG/1gx4kisZ0PHnJyr4vVmIJfJw=; b=JGUa3wKezXP9h8RJNNZzcpg7wX
	C9k7CSzeVW/g4b88XXJ5brXGMG+30ZgpoGoF56eHy/UvodHCKbHI7sPZgvkoxzuyJCqdvC9qFiCwD
	JEjErKH1Tj51eebhBTYbnXCuvRDT88M6vObI9S8BY6W15u5rItGBB9YTzZd4LAA0H4lS04HkqA9df
	+dZIkjHCh4RuAq22Um/0KNSZVhNGFVoPsX35Zy1VrEgNfaL7Hh7/C+e4/gxEJW04BOKN//BuYXu9y
	CbUGlEUy7yICQvZVQtLORgeOowTI7e6oVW/Q+o/rdTrySrV79SeYYBPmjmNI164/gIQ1us33q497c
	8bhn01rA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q25e8-00FrUy-1s;
	Thu, 25 May 2023 07:44:28 +0000
Date: Thu, 25 May 2023 00:44:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Michael Richardson <mcr+ietf@sandelman.ca>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <ZG8R3JgOPHo7xn61@infradead.org>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523202827.GA33347@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'm really lost in this discussion.  All aspects of the ABI are
a required part of interoperability.  And one of the promises of
this IETF eBPF project is to provide for this interoperability.

This is a very different situation from the binary ABI for Linux
or Windows, which has traditionally never been interoperable between
vendors, odd examples like iBCS2 [1] notwithstanding.

I'm fine with watering down the wording in the charter a bit in not
beeing too specific what documebts we want to work on for the binary
compatibility, but I think having it is essential.

What do we gain by not having the full binary interface in the working
group scope?

[1] https://en.wikipedia.org/wiki/Intel_Binary_Compatibility_Standard


