Return-Path: <bpf+bounces-1484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40625717480
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2041C20C1A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE71C32;
	Wed, 31 May 2023 03:49:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1D1385
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:49:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FBEC
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:49:23 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5668BC151B08
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685504963; bh=FyowkVhgJVTAx0PIkTGld7aAhxU1Q4iyaDLCxuW87/g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=twd5V6E/8BcVXHInzMBuI7s2RUn18KJeZZ6w1YPmhnwxo8Da9oPTGYhQwbfI67gjA
	 F/Mc6A9Y6CJvWHBmcwmUGAo8//SV6D3ovmLIFqHh88sBSEFjqCRDy1fntf6ajBxHUb
	 1xejf9h2zVK4RggYzZeAg0s1SE7K3b61JAuJzC7Y=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 30 20:49:23 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 47DB5C151085;
	Tue, 30 May 2023 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685504963; bh=FyowkVhgJVTAx0PIkTGld7aAhxU1Q4iyaDLCxuW87/g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=twd5V6E/8BcVXHInzMBuI7s2RUn18KJeZZ6w1YPmhnwxo8Da9oPTGYhQwbfI67gjA
	 F/Mc6A9Y6CJvWHBmcwmUGAo8//SV6D3ovmLIFqHh88sBSEFjqCRDy1fntf6ajBxHUb
	 1xejf9h2zVK4RggYzZeAg0s1SE7K3b61JAuJzC7Y=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AF1FBC151085
 for <bpf@ietfa.amsl.com>; Tue, 30 May 2023 20:48:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.094
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EffHvEcUEftp for <bpf@ietfa.amsl.com>;
 Tue, 30 May 2023 20:48:17 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 564D2C14CE40
 for <bpf@ietf.org>; Tue, 30 May 2023 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wCnX+YDHx/AhIXhenNc6RBhTEoOZPIAS4TYXOtx74Ic=; b=YZZ+BC17nKvZPcQxNPxtZKAxYW
 NWBnAL+i2nX+PpL8kR9r3cQhCdKamLwr4PsZ0eCmLLg3y1UJvHPJhc6zh3NPOzwkfIv7DBC7hSFVb
 FM2JXXStLWGTVVow9PPaeOtVT6c8pi5IB/b7YEWnpBJaIJjmR6lBEZbx7csXac1Zz7eakT1+KSXb5
 mMcSc5GD2XMhSIHjF5CKmtU15SJ1i8EBlrgYUcJuW3KMJ+dAizlmTzuf+hQWDyi/eDyHyMvGDihHY
 F0zC7l6v2Sw7stmsy5PcZ2embd92G6tcqZprvaWC1/bKaFNNnKAvMER9GMa2ZFMus1L4jNi0aPEV8
 JD8apWsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q4Col-00Fwsm-03; Wed, 31 May 2023 03:48:11 +0000
Date: Tue, 30 May 2023 20:48:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler@microsoft.com>
Cc: David Vernet <void@manifault.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Christoph Hellwig <hch@infradead.org>,
 Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>, Lorenz Bauer <oss@lmb.io>
Message-ID: <ZHbDekB0KderhSTl@infradead.org>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526171929.GB1209625@maniforge>
 <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/k9KRGycG3iYrB4BNxogxH03QJqg>
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

On Fri, May 26, 2023 at 05:30:11PM +0000, Dave Thaler wrote:
> David Vernet <void@manifault.com> writes: 
> > Thanks for clarifying. Erik, Suresh and I met yesterday to try and find a middle
> > ground that addresses everyone's concerns, and we came up with [0].
> > 
> > [0]:
> > 
> https://github.com/ekline/bpf/blob/ekline-patch-1/charter-ietf-bpf.txt#L31 
> > 
> > Does that sound reasonable to you?
> 
> Yes, other than some punctuation nits (https://github.com/ekline/bpf/pull/7).

I can live with it as well.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

