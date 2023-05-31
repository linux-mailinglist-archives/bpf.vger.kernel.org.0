Return-Path: <bpf+bounces-1483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7771747F
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4810E1C2083A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF401C32;
	Wed, 31 May 2023 03:49:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C61385
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:49:15 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC493
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:49:13 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6C2A8C151B22
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685504953; bh=3Zo82bOrdPy76wIOCXOrGjK2omqCciKwhxCHlF/t4LI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kZOIOPzHiqdBj4G2rB59KjKiEyhZipT3llNFpf8kxAS+X7eh7hHUcvSOnPvfPR0O4
	 cA8BaI/6MWOm6PB8xDSnP3fS1wBi4SN3okJWJpDiN5qGyZNhnIq/R12urMXMEMXb86
	 paqNHuXx2Qs1aGIJwKMYY31blAEgoDfM3p9yDh7c=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 30 20:49:13 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 23440C151085;
	Tue, 30 May 2023 20:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685504953; bh=3Zo82bOrdPy76wIOCXOrGjK2omqCciKwhxCHlF/t4LI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kZOIOPzHiqdBj4G2rB59KjKiEyhZipT3llNFpf8kxAS+X7eh7hHUcvSOnPvfPR0O4
	 cA8BaI/6MWOm6PB8xDSnP3fS1wBi4SN3okJWJpDiN5qGyZNhnIq/R12urMXMEMXb86
	 paqNHuXx2Qs1aGIJwKMYY31blAEgoDfM3p9yDh7c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0814DC14CE40
 for <bpf@ietfa.amsl.com>; Tue, 30 May 2023 20:47:49 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.086
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
 with ESMTP id pYEbpbkcmAIh for <bpf@ietfa.amsl.com>;
 Tue, 30 May 2023 20:47:43 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 46BEDC14CE33
 for <bpf@ietf.org>; Tue, 30 May 2023 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zVbhNCZE0akM4TMQAplqYgu5nBRjcZJqi1ar0ws/0o8=; b=F67HbLSa0QsRlettVzdXy1/fnw
 xNjGV0yAOm6x1OUONrpXWwLJ3zvTMQdUpQmfQE6I2CWym/UPev4rtXdch0lqXdPWYZD03P30l7ce+
 norAd6fSsqjinmG+EedzE4HVnyn0BaurGtxyd3y3XayrvJDvicRYfW0rvqohlVnY+0Sp7KOzY8F1T
 iVnUK0KjHEQreHb04emYkALj2jFZCSNKfLAw7kmjk34L5Z2ReLtXUzu3+y8c6AuY7BzXXEoAeTZ5V
 +fQLZzG0/K1NMhUb+j0ye3mnABbXt0kkObbZHsphTex0KBqgA9X5RMsupfrVOXuOe0kUjdGdxB558
 MlsoJukQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q4Co7-00FwmS-2B; Wed, 31 May 2023 03:47:31 +0000
Date: Tue, 30 May 2023 20:47:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler@microsoft.com>
Cc: David Vernet <void@manifault.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Christoph Hellwig <hch@infradead.org>,
 Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>
Message-ID: <ZHbDU6E6CmGT5wD+@infradead.org>
References: <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/3Oio6dAedzt3MWOtbF3_Xrws6W0>
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

On Fri, May 26, 2023 at 05:01:57PM +0000, Dave Thaler wrote:
> In an email last week to the list I mentioned Informational as a possibility.
> I don't have a strong preference, but I have a weak preference for Proposed
> Standard status.
> 
> As an implementer, I would want to make sure that ebpf-for-windows,
> PREVAIL, and uBPF all do the same thing, ideally matching Linux for everything
> the former projects support, to allow using consistent tooling.

This would be even more important for any of the potential NVMe use
cases.  Compared to even ebpf-for-windows it is a fairly niche use case,
and the last thing we'd need was our own ABI and toolchain.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

