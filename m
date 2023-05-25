Return-Path: <bpf+bounces-1243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC57112C1
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BD028155F
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395E200A1;
	Thu, 25 May 2023 17:44:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936391F937
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:44:53 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24610C7
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:44:25 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0DDE5C1782D7
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685036620; bh=SyCYsV1H8lZIM+SHh6PXkIPBithsDIpeb9twI4lNm3g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=GO0Awf+fhbRFoK0YY3TB+Frh/ITppyohDr3KAxEeUrSEJF/jn8zqhIe3sBmGXON6L
	 lLJvJg5Wt0n48wE0EfnNb4rDsOW+Y1ho2bXzE6BrWPJTipnuXqbkOMdh64tyIaUUex
	 L65nnuTKC5HeDXswWwa97EGg9GAvvoPNecUurobU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu May 25 10:43:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B2812C169521;
	Thu, 25 May 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685036619; bh=SyCYsV1H8lZIM+SHh6PXkIPBithsDIpeb9twI4lNm3g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VB4dA7eZK7qXrvjfeBz82QwyenMWtiVsGJGDlKKBOREKJcWWGhqP1laHsREz3OHag
	 Nh+OULqiUSZ8xr/nK8ODxls3sCZaK1btO68GAWNN0HDyBbY+/JWZxNYQswLp729m3F
	 CxPNl6ePecMLd6vw9cnatswcnt6vWMCvPu/skw6o=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 500F6C151545
 for <bpf@ietfa.amsl.com>; Thu, 25 May 2023 00:44:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.095
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eh1njCuMdrCX for <bpf@ietfa.amsl.com>;
 Thu, 25 May 2023 00:44:36 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9BB04C151544
 for <bpf@ietf.org>; Thu, 25 May 2023 00:44:32 -0700 (PDT)
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
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q25e8-00FrUy-1s; Thu, 25 May 2023 07:44:28 +0000
Date: Thu, 25 May 2023 00:44:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>, Dave Thaler <dthaler@microsoft.com>
Message-ID: <ZG8R3JgOPHo7xn61@infradead.org>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230523202827.GA33347@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/AHivtOLnEIjURTa7rEbLxqdMah0>
X-Mailman-Approved-At: Thu, 25 May 2023 10:43:38 -0700
Subject: Re: [Bpf] IETF BPF working group draft charter
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

