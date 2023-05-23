Return-Path: <bpf+bounces-1105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC170E1D2
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA11528143C
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDD200AD;
	Tue, 23 May 2023 16:32:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739D21CEA
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 16:32:13 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72689CD
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:32:11 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C525DC151B00
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684859530; bh=iVNHnUJV8UbWloP0mWFUX4pUTauzf2De42UYy0INmfM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=BNVeviMzfxpYJByfBLpWAb6LhBukwAwASSUkQO65oUdwn7jCdK5+HCvNb74tYBunD
	 NHbvQaleqQqWTWzYldELlycAM1ePABvkdqWDB2pCRzyceSPNy0iSe0SieeNrisqYwC
	 fWlA/B8VrpIfCHxjTJaSSNqy1CwVtEhsBoQU/N5A=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 09:32:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7AA0EC15109C;
	Tue, 23 May 2023 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684859530; bh=iVNHnUJV8UbWloP0mWFUX4pUTauzf2De42UYy0INmfM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=BNVeviMzfxpYJByfBLpWAb6LhBukwAwASSUkQO65oUdwn7jCdK5+HCvNb74tYBunD
	 NHbvQaleqQqWTWzYldELlycAM1ePABvkdqWDB2pCRzyceSPNy0iSe0SieeNrisqYwC
	 fWlA/B8VrpIfCHxjTJaSSNqy1CwVtEhsBoQU/N5A=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 258C3C151097
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 09:32:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.553
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ek6QbxTrpZm for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 09:32:04 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CB435C151075
 for <bpf@ietf.org>; Tue, 23 May 2023 09:32:04 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-75b0f2ce4b7so3460385a.2
 for <bpf@ietf.org>; Tue, 23 May 2023 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859524; x=1687451524;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fxaaxZmnkZ6/IheHqrPi/4FP/lLx6cJmznjM+Jz/cU=;
 b=EJ2MgYukNj0yGApCXNVN/s9K8uLad2otQ0Ub8bHUaG/TSUoO57uoNoA1qoWqcENdTh
 gObciiZIyg4ody0aIlZsh9UEaKy2RVGHMGAUE4GnZMFV5N7R5abivVMxGA9zTqcE9jiT
 QM5gQSMCXpfU8yE2oB8uMk3gfcQ5inz6qU2Z2Y9Zdk0WKPHX0zHFKx189l7VYQjn0acu
 xnO1ucnTleCeiul8HnhGg5iFb39SuERGCHCH5/pkiodn3SgZk0YHsmPVBT3HqAklTvhC
 DKD0NDizPM0WZO+XYp1aUgNN27uQHUfARqt/LB+oVcT1Wjko/PQe7TCwcTuH+ya942rY
 y6yA==
X-Gm-Message-State: AC+VfDxESLgF0PGwoh2vP5KAF2CJzA7dS0/io9DIdjl0Z6/Kxdn/jPG9
 QzNb3uUy5L2kjFapxYYXu/k=
X-Google-Smtp-Source: ACHHUZ5rWPuUauTb5eE9Xh6sGhOy0DHmGAQS2gxUEGH8U/A67JLtx7HbZrPrnbzc1XoQchjZ81IwdQ==
X-Received: by 2002:a37:c16:0:b0:75b:23a0:d9e2 with SMTP id
 22-20020a370c16000000b0075b23a0d9e2mr4226770qkm.56.1684859523560; 
 Tue, 23 May 2023 09:32:03 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
 by smtp.gmail.com with ESMTPSA id
 m6-20020ae9e006000000b0074e4b1fe0aesm2608428qkk.94.2023.05.23.09.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:32:03 -0700 (PDT)
Date: Tue, 23 May 2023 11:32:00 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>, Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <20230523163200.GD20100@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/qM7hm95yinI0b3O-EnhJJLFwuas>
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

On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> Jose E. Marchesi <jemarch@gnu.org> wrote:
> > I would think that the way the x86_64, aarch64, risc-v, sparc, mips, powerpc
> > architectures, along with their variants, handle their ELF extensions and
> > psABI, ensures interoperability good enough for the problem at hand, but ok.
> > I'm definitely not an expert in these matters.
> 
> I am not familiar enough with those to make any comment about that.

Hi Dave,

Taking a step back here, perhaps we need to think about all of this more
generically as "ABI", rather than ELF "extensions", "bindings", etc.  In
my opinion this would include, at a minimum, the following items from
the current proposed WG charter:

* the eBPF bindings for the ELF executable file format,

* the platform support ABI, including calling convention, linker
  requirements, and relocations,

As far as I know (please correct me if I'm wrong), there isn't really a
precedence for standardizing ABIs like this. For example, x86 calling
conventions are not standardized.  Solaris, Linux, FreeBSD, macOS, etc
all follow the System V AMD64 ABI, but Microsoft of course does not. As
Jose pointed out, such standards extensions do not exist for psABI ELF
extensions for various architectures either.

While it may be that we do end up needing to standardize these ABIs for
BPF, I'm beginning to think that we should just remove them from the
current WG charter, and consider standardizing them at a later time if
it's clear that it's actually necessary. I think this is especially true
given that we don't seem to be getting any closer to having consensus,
and that we're very short on time given that Erik is going to be
proposing the charter to the rest of the ADs in just two days on 5/25.

Thanks,
David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

