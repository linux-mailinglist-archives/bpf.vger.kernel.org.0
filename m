Return-Path: <bpf+bounces-53960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B237EA5FB17
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1105B3AA828
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB81269B15;
	Thu, 13 Mar 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYOxa1NH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2E26989F;
	Thu, 13 Mar 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881898; cv=none; b=KX3bc2Aj6uiZACkO1cSPTCvz4a1m1dkvCaYKY8VdXZTrVYc2t5KbRoW4cC59Us7vqQgAJn4GRNLVZGfthFunmMDbGCmmWrndJOGaGtAazaU0g7fgCNjZ6OGhF9t2uTI1FPQGStl+/mdcIFNnpY5W1+TRNYHtGsjLX0Ko1VC5epA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881898; c=relaxed/simple;
	bh=Sodsf7HEBDKc4i3BBcS2HMDG0a3gGr5cNt7xJqLTHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1G01AbXdZxhibn4Jp0q6Gjt8XXOeAagXoNJa8uOpous79zqGn5UUN55fTx5JGwl59VhyyU6ynmtgmF+2NUmbWZu1I52X8585Fbb/hlAK8bhxrTm5S9xplOlWBclSISo2KJQL53LSnwZPOTHKO0zTHlso4t4MtbhCn/d6Ge5tzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYOxa1NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5434C4CEDD;
	Thu, 13 Mar 2025 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741881897;
	bh=Sodsf7HEBDKc4i3BBcS2HMDG0a3gGr5cNt7xJqLTHsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYOxa1NHaRXY2ASRpdiuNbWE5e6tI1NSOWEyE6sUp3Q/LIxvU3Y4+AxhvYESxdg9N
	 xUiNFZqd2dAglctmmZ6bZL4lpPXx8qiYQNnb8Mik6hyLbrzxjEBQtyqSBEYAg5CzA6
	 S9BIN2g9QGUjDDKJB97pWVzz4+GSs3YVeor0pjKU=
Date: Thu, 13 Mar 2025 17:04:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in
 build_id_parse()
Message-ID: <2025031306-alumni-crinkly-5c0b@gregkh>
References: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
 <2025031100-impromptu-pastrami-925c@gregkh>
 <CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>

On Wed, Mar 12, 2025 at 11:03:18AM +0800, Chen Linxuan wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2025年3月11日周二 19:14写道：
> >
> > On Tue, Mar 11, 2025 at 06:05:55PM +0800, Chen Linxuan wrote:
> > > Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> > > Handle memfd_secret() files in build_id_parse()") to address an issue
> > > where accessing secret memfd contents through build_id_parse() would
> > > trigger faults.
> > >
> > > Original report and repro can be found in [0].
> > >
> > >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > >
> > > This repro will cause BUG: unable to handle kernel paging request in
> > > build_id_parse in 5.15/6.1/6.6.
> > >
> > > Some other discussions can be found in [1].
> > >
> > >   [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> >
> > You dropped all the original signed-off-by and changelog text.  Just
> 
> The original commit is based on commit de3ec364c3c3 ("lib/buildid: add
> single folio-based file reader abstraction"). `git cherry-pick` result lots of
> conflicts. So I rewrite same logic on old code.

Then keep the original commit message, tell us what the original commit
id was, and then put in the signed-off-by area what you changed.

There's loads of examples of backports in this format on the stable
mailing list, look at them for what to do.

thanks,

greg k-h

