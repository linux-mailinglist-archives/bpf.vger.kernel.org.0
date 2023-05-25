Return-Path: <bpf+bounces-1215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578917109A9
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B50E1C20E84
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F29E564;
	Thu, 25 May 2023 10:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82123D2EF
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:15:10 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA719C
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:14:53 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E57CDC16950E
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685009692; bh=jmlX5iO7YSl4EQSDDQDaWCa9TcsJQiFy2pxILFd8khE=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=y/8iA2TQPMsvliA8/q6W2nQXBiPdufOCjjKDcOEo/P8m0jU26rBEeyA5UXGD6fjq+
	 EdAHP7X5oQ3smgqhb9enbIMdx2pzTf3RsayPJVcLU6Nkp4Egl0bW4xYB20ee6sk5gH
	 ZfZHGMPLPREPvQvkHfe1jC+DRRiKYnRogL2J/qJc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu May 25 03:14:52 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BC5AFC1519B1;
	Thu, 25 May 2023 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685009692; bh=jmlX5iO7YSl4EQSDDQDaWCa9TcsJQiFy2pxILFd8khE=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=y/8iA2TQPMsvliA8/q6W2nQXBiPdufOCjjKDcOEo/P8m0jU26rBEeyA5UXGD6fjq+
	 EdAHP7X5oQ3smgqhb9enbIMdx2pzTf3RsayPJVcLU6Nkp4Egl0bW4xYB20ee6sk5gH
	 ZfZHGMPLPREPvQvkHfe1jC+DRRiKYnRogL2J/qJc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8B64FC1519B1
 for <bpf@ietfa.amsl.com>; Thu, 25 May 2023 03:14:51 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gnu.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNEDNfURdCIm for <bpf@ietfa.amsl.com>;
 Thu, 25 May 2023 03:14:47 -0700 (PDT)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 60B69C15106A
 for <bpf@ietf.org>; Thu, 25 May 2023 03:14:47 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q27zV-0005FI-Pk; Thu, 25 May 2023 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=nXHJIle7hbsHQLvhkLv2aKGhOe4kH//yvisqUnCm/ig=; b=Zf7XQ2Y7AZLKWpEQgrAQ
 PolTJrNEgPZHeI0yJm9exh1GTcEfp357lTk63oybfNOjSHlOip3xU5aCBOVkV83OlVZ4X/NEodI+X
 MVYcGeXcC+99h+tPrMbjnApu8lzN/GcX2S/XycvysQrVtgCOlu46VeIXl83RyYjLB774+eHacG8Tn
 jp1w+NsAU+Ly9yDYEvmZqpJhx4W9d0F6RPLTrSv0hW/36t0jViHPLcJHEtXGmRrgwhbkI1nLvwYfo
 Z7Ni4yFRg6vhWlHAIbbnTd1qFfKX4yMIN1WOmeBKbzKpMKbj9TjXRkdhQPkhCjX2HEKZYAWrpHTjt
 7+0Sz6lsq6Kh7g==;
Received: from [141.143.193.74] (helo=termi)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q27zV-0006eS-DI; Thu, 25 May 2023 06:14:41 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Vernet <void@manifault.com>,  Michael Richardson
 <mcr+ietf@sandelman.ca>,  "bpf@ietf.org" <bpf@ietf.org>,  bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Erik Kline
 <ek.ietf@gmail.com>,  "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Dave Thaler <dthaler@microsoft.com>
In-Reply-To: <ZG8R3JgOPHo7xn61@infradead.org> (Christoph Hellwig's message of
 "Thu, 25 May 2023 00:44:28 -0700")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
Date: Thu, 25 May 2023 12:14:29 +0200
Message-ID: <87y1lclnui.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zdK1hUoYVI6uzr2C2GPjO6CoR3U>
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


> I'm really lost in this discussion.  All aspects of the ABI are
> a required part of interoperability.  And one of the promises of
> this IETF eBPF project is to provide for this interoperability.
>
> This is a very different situation from the binary ABI for Linux
> or Windows, which has traditionally never been interoperable between
> vendors, odd examples like iBCS2 [1] notwithstanding.

The situation is not that different from the perspective of the
producers of the programs.  Even within the context of a single system
the different vendors of compilers, assemblers, linkers, libc, and other
tools need to coordinate and agree on conventions so they all produce
compatible programs which are able to interoperate and run on the
system.

The psABI is what provides for this interoperability, and it works just
fine.

None of these psABI are maintained as standards in the strong and strict
sense (ISO, ANSI, IETF, whatever) and I am just wondering about the
convenience of doing so for the BPF ABI, given the nature of these.

I reckon the perspective from the system side may be different.
No more binary program solipsism :)

Example:

If I understood correctly from the thread, an IETF standard document is
not supposed to be updated regularly.  Instead, it is expected to be
carefully designed to rely on "codepoints" so all additions are optional
and are released in their own document or supplement.

As someone who uses ABIs on the toolchain side, and who contributes to
some of them, I am personally skeptical that schema can actually
accomodate the reality of an alive and evolving ABI, especially one as
young as BPF.  The resulting "authoritative" documents risk to be
outdated more often than not, and end being a curiosity that nobody
actually uses.

I would be happy to be proved wrong, and of course the WG is free to not
share my concerns, but I have to voice them.

> I'm fine with watering down the wording in the charter a bit in not
> beeing too specific what documebts we want to work on for the binary
> compatibility, but I think having it is essential.
>
> What do we gain by not having the full binary interface in the working
> group scope?
>
> [1] https://en.wikipedia.org/wiki/Intel_Binary_Compatibility_Standard

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

