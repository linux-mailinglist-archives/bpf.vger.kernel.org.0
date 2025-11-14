Return-Path: <bpf+bounces-74562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 808CDC5F4CA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31BDD35F557
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374C2FB0B4;
	Fri, 14 Nov 2025 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOl10M2F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605D2F9DB1;
	Fri, 14 Nov 2025 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153651; cv=none; b=r5MHugcnOtMNMCp2mggSVcD9LmbQFmUVMy46yyBJanXoLDx1TiEN4R+ki70IPP6AjN6DE/WsFAcnNV06K6u2NfUilPVYfP3g6ZJoSVWCjrVIw9CZHF5BZDEKVlnBJU9K/99gRY8JiHGwJWPfjbz8LIOnjqrVYtRUwIX2dKIJFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153651; c=relaxed/simple;
	bh=9Rn+j27YqsCiy8IBahTgon9NGRAbHXc5LTFSb+CP4i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+7vU+aNu3RIUowJQOESU8a2pimI+N/WCKHK9BfIWCh1yr3eYuQ//000fmUGOrGfS3Ie/sZ+3PXKvB9dOiUNJgmsNwLCD/1SCXdqZrfeNAinrIqnB/WOKlAg770c0AnlSBNX/tY7zeQhb9j3ttogxDCpCMZsDdvB9hsCV9jf3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOl10M2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62746C16AAE;
	Fri, 14 Nov 2025 20:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763153651;
	bh=9Rn+j27YqsCiy8IBahTgon9NGRAbHXc5LTFSb+CP4i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOl10M2FcgJ9JON1Wq03S5B5JCrcVzMSl2gQGjyC4JP8p2tY4Ao0FfithDDv6Kiuy
	 /35arqsjOpf0erxtP5T3f24gbSFlAwjHERHBLQh321O+jcPtmr3k3cjgmXuo7u7ry+
	 AwhA6Wx+WB/z2ZLvs1d2sLv62sSiOyYPES9sOzoabguSeQI6JEgNSIAnNWXw2UafJ9
	 9UesFZZf6f2S6ozDSHBlIPOWAdlxn7TBZIKQMG9v+eOq06XnF/O1Z1X6xsdkU23SjL
	 KKrk65lyTlr0G4Qdhhzb4v6LnIqLLK2FnmXkEc9hgvSshJBHL0DpK1pMPh9WooHbh0
	 L1t474N9RKTPw==
Date: Fri, 14 Nov 2025 17:54:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	dwarves <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF
 funcs
Message-ID: <aReW7z_xjpD6ZCXG@x1>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
 <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
 <aRaPnq2QJN1iFF_3@x1>
 <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
 <aReWlPqSGWnj8sPf@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aReWlPqSGWnj8sPf@x1>

On Fri, Nov 14, 2025 at 05:52:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Nov 14, 2025 at 03:40:36PM +0000, Alan Maguire wrote:
> > Yeah, I think if we can augment CI to cover more we can narrow this
> > window, aiming for zero as the test coverage improves.
> 
> So the 'next' is an artifact for CI usage, i.e. if we just don't
> announce that it was merged, do it for the CI sake and then when it runs
> and don't detect any problem we go ahead and merge into master and
> announce that it was merged, nothing of this drama would take place.

BTW, I looked at the patches, ran tests and merged next into master,
pushed out to master in both kernel.org and github.

- Arnaldo

