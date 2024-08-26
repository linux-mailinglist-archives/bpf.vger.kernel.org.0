Return-Path: <bpf+bounces-38086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E695F648
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA21C219E9
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12865195383;
	Mon, 26 Aug 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv1dYe7J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED08194C71;
	Mon, 26 Aug 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689096; cv=none; b=HIMNLPojq6yDOd1Sew96FIrI7ThH98P7nyEuc7X0BwmYwUXcHoyTG20A5TxdD/EUN5kUKZ6IgMcx3yLdwjvxp+TG0HXgbG62mtDTb11MMvOmppKwWMNCxdSaHMTk6bv+lKKXsgAJK+DmiOUQoer+lWQUaUWWm7OzGbX65UiXiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689096; c=relaxed/simple;
	bh=YvHB38TnuDcEcarFJGsv4hAnlMZjd57PrQfn3PObeJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2cGahkEUkEmF1mAVjP6k8btfeEI2BAe/8zbI5d5S/Vi79hl0QttDOg1aWcRouwD3lsMQ5XDOeQg2UfohOb+wjycEhOyry5znpgkH6ZTh/AeTHTnjqizoK/UOTDjXl2YrijTYL8U9fWCKvzA0rLbNY64YLnPMcNlyAseiy/0MgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv1dYe7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8792C52FC0;
	Mon, 26 Aug 2024 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689096;
	bh=YvHB38TnuDcEcarFJGsv4hAnlMZjd57PrQfn3PObeJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv1dYe7J6UquSigvHFJMtP6mgIXghyR3SprwIPZWQCDPX16rQidR9t3sADljPlZMZ
	 Lpe7Fj41/o8E4X9l3KoRnCsPtC2urjqVCHTo0lCWkfHr6CZWUfIMFCaim0zq2j0PFL
	 QaHAmjaSobfXryDCyqMfTeqarDtyUiOEdk6db9l/IkJ3GHJQjaTY06GOA012+tMKsU
	 N/+EMv13DKAMtgios1xNo6SRkpQEoNiHLN+5SqbyAS+shyKhT96Dtmn7OZXLdhte5V
	 dPYJz/RHKc0ZcKJ+q4RZx93a0WVnw+ZhnLdcinL/JVx1FW7X3Oy0P3X0uMmSj6yyYo
	 qq/4Cphm+yeEQ==
Date: Mon, 26 Aug 2024 13:18:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/2] add distilled base BTF support to pahole
Message-ID: <ZsyqxJbItYZqKwBD@x1>
References: <20240729111317.140816-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729111317.140816-1-alan.maguire@oracle.com>

On Mon, Jul 29, 2024 at 12:13:15PM +0100, Alan Maguire wrote:
> Patch 1 updates the libbpf commit to use latest libbpf with
> btf__distill_base() support; patch 2 adds support for the
> 'distilled_base' BTF feature, used to support resilient
> split BTF for kernel modules.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Alan Maguire (2):
>   pahole: Sync with libbpf-1.5
>   btf_encoder: add "distilled_base" BTF feature to split BTF generation
> 
>  btf_encoder.c      | 50 ++++++++++++++++++++++++++++++++++------------
>  dwarves.h          |  1 +
>  lib/bpf            |  2 +-
>  man-pages/pahole.1 |  4 ++++
>  pahole.c           |  1 +
>  5 files changed, 44 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.5

