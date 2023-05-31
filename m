Return-Path: <bpf+bounces-1482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4471747E
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74271281082
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B11C32;
	Wed, 31 May 2023 03:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D521385
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966A126
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:48:17 -0700 (PDT)
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
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Col-00Fwsm-03;
	Wed, 31 May 2023 03:48:11 +0000
Date: Tue, 30 May 2023 20:48:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler@microsoft.com>
Cc: David Vernet <void@manifault.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michael Richardson <mcr+ietf@sandelman.ca>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Lorenz Bauer <oss@lmb.io>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <ZHbDekB0KderhSTl@infradead.org>
References: <20230523163200.GD20100@maniforge>
 <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
 <ZG8R3JgOPHo7xn61@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
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


