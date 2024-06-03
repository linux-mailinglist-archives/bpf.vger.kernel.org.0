Return-Path: <bpf+bounces-31252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E68D8A21
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B81C23C70
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851113B2AD;
	Mon,  3 Jun 2024 19:27:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C6137748;
	Mon,  3 Jun 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442830; cv=none; b=AusiQV0tu7bS5MmtRvEDTeE6zO8MpTkPJ1X8VCaqrBlo8/kLjAqPZYloUXKo5DR09sNKHkLT+pcjbFM2zYCoxxenIdLo1AJdBjYVZiwBkP8J713oGBFF0mlg9Xkq3npoCNK3LZm4HcB7JiRmZJqe7SNxWP4hYGgHc0oRXJH97CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442830; c=relaxed/simple;
	bh=X4Y5oxKxs00wWrWKIghJZ7QZja4AWcSliWr1zt5dwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOcOD6RX3E/lasi901xyBHki2kBXuiLekUjlQ3TPmgq3Oa5rq8r/owhOC1PxSVUXn7vlH1lb4PO7+IFQLC6pAUEYo12NTnHCmZL5pnD5ubCT40yZ7F06XXyiRVpKlgEw84o/tZkQsq5tDmi2lg5JZ/gaQge2sUpQvbm2dDDwfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id E6634302732A; Mon,  3 Jun 2024 21:18:33 +0200 (CEST)
Date: Mon, 3 Jun 2024 21:18:33 +0200
From: Mark Wielaard <mark@klomp.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Mark Wielaard <mjw@redhat.com>,
	Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <20240603191833.GD4421@gnu.wildebeest.org>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
 <Zl4AHfG6Gg5Htdgc@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4AHfG6Gg5Htdgc@x1>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrote:
> Couldn't find a way to ask eu-readelf for more verbose output, where we
> could perhaps get some clue as to why it produces nothing while binutils
> readelf manages to grok it, Mark, do you know some other way to ask
> eu-readelf to produce more debug output?
> 
> I'm unsure if the netdevsim.ko file was left in a semi encoded BTF state
> that then made eu-readelf to not be able to process it while pahole,
> that uses eltuils' libraries, was able to process the first two CUs for
> a kernel module and all the CUs for the vmlinux file :-\

I haven't looked at the vmlinux file. But for the .ko file the issue
is that the elfutils MIPS backend isn't complete. Specifically MIPS
relocations aren't recognized (and so cannot be applied). There are
some pending patches which try to fix that:

https://patchwork.sourceware.org/project/elfutils/list/?series=31601

Cheers,

Mark

