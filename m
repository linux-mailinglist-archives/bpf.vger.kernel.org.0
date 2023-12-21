Return-Path: <bpf+bounces-18502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B546F81AF1D
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9AE1F23505
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE0C139;
	Thu, 21 Dec 2023 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PKiuYFYr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Q+Tp+w2+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7G4Gowp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0357BE4B
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 255D0C05E02D
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 23:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703142464; bh=Vgm0Yrkfobs3zpmxb/uJjXX0IoRM3FSdLxtTpT5OthE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=PKiuYFYrQyyc0ydYEiXtO4rpT6rsCEbBj90NaAr4k8L3rMnNTFhLiWvgsTdm2bbIx
	 KGfohw5joF30DMFRQqSG9SCi/vNCgC73oJCAOjAfTuOdYDKo62ojdZYWI1aSaiPRE4
	 FAa5XOzxMzs+qDnli1Xa5qfsp7iKUADYpsdKypn4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Dec 20 23:07:43 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CA1E1C0900A8;
	Wed, 20 Dec 2023 23:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703142463; bh=Vgm0Yrkfobs3zpmxb/uJjXX0IoRM3FSdLxtTpT5OthE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Q+Tp+w2+r+zLvvhlyia18+3g1GSohgsLhn5URo/OtMssfotC82LLoVqALgB90rpGq
	 MLDGSb8F/e7OaCromhz/1n+jJNA8/CiC0NVxOTbGdpranz08eJmCOT46XhPnHGf6m6
	 xqtLXE3iL8YntLvDeeCS9afiSmrEvR5GzuqEcIkY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F04BBC0900D3
 for <bpf@ietfa.amsl.com>; Wed, 20 Dec 2023 23:01:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVYEj-6h9RWh for <bpf@ietfa.amsl.com>;
 Wed, 20 Dec 2023 23:01:08 -0800 (PST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 93E18C0900CD
 for <bpf@ietf.org>; Wed, 20 Dec 2023 23:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WgSuIT2NBDUdtfjNASaE2uehI2DEDcypBzqXZftgAyg=; b=L7G4GowpweruwUNjOpHQHGWnQt
 nkIVACetLM8oNAg1XLNz7/ZRx21aDdnpvXOTiVNUKTdR/lnBfEUsrcAUQGOqu/MJzwbCoA9wsqPP/
 eYm9u9pBpLQbxlUFSJBHa83xOKSswFABdULrxS73hN0Z/bYDtx1LXXGjkzyTdO88tN9SK89+X3TMN
 cAdQ2R29itShT3hg67Qk5hJfibI1TBf8kx2vvXLvhNk0c3khKyHUjBY0p5/IJrdYBsJqQY0p0yppY
 fcR33/xxRrp8aJGzFmx1S+WhvTyYuhsodrb9Ye70JJ6jXSdYrvKOTJu+dk8ZNoEDNXi+GYYdfoOc8
 MuVfR1rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1rGD3D-001sAi-2y; Thu, 21 Dec 2023 07:00:59 +0000
Date: Wed, 20 Dec 2023 23:00:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>,
 Christoph Hellwig <hch@infradead.org>,
 David Vernet <void@manifault.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <ZYPiq6ijLaMl/QD8@infradead.org>
References: <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/47ce-wXvAx4YobsmJly7GPbGNmU>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

On Tue, Dec 19, 2023 at 07:28:10PM -0800, Alexei Starovoitov wrote:
> Right, but bringing the verifier into the "compliance picture"
> makes the ISA standard incomplete.
> Same can be said about nfp compliance. It's compliant with an ISA,
> but the verifier will reject things it doesn't support.

Yes, that's a good point.  Especially for anything call related I think
it's fine to say they are a mandatory part of the basic some coarse
group, but a given program type might not support it, but that is
enforced by the verifier as the compiler should not have to known about
the program type.

> All ld_imm64 and call insns look the same. The compiler emits
> them the same way.
> The src_reg encoding is what libbpf does based on compiler relocations.
> 
> Then the verifier checks them differently and later JIT sees
> _all_ ld_imm64 as one type of instruction.
> Same with call insn. To x86/arm64/riscv JITs there is only one BPF CALL insn.

Yup.  Another case for ISA supported vs program type supported (and
enforced by the verifier).

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

