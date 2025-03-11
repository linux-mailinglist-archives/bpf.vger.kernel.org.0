Return-Path: <bpf+bounces-53803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73BA5BEA4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B755016FCC1
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F218253B6D;
	Tue, 11 Mar 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ef+fzoWO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03BC22D4FD;
	Tue, 11 Mar 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691687; cv=none; b=l7BBH7oVCMR1pniGnIUFUr2MgV1ERgcC3VHyAD1ftfCzHIWqs8mdfJJ6NNG2jmh1qL9V3QBXGpNKZvNhu7Y1xAn+oBO491nMlb2TmgTBUGN0fWqUWSf+sb9iOLpqjStFhKmOZFZoFhyE+XydpIbe/2BWdVDEd9Mc/eZlwTqcrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691687; c=relaxed/simple;
	bh=NsbwoYuOc8TjNu/BedDdrpYil/xgrNL/Le/UmwKzotw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3mHTv98avQJZJEwT2i88rCtuUT/GeMPzcql+43b7e4dZffeznu+o7+HyDLXmdh63d8JRqMj/2otNTiJmsBdEsn6GVYqP+w3g8HaHxbecKe0shtv9xaqx3IXh53hKZ0aRDI/ghap0hKLylQ62I2/fMPPT8xJlsuRAY4eulflgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ef+fzoWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F4EC4CEED;
	Tue, 11 Mar 2025 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741691686;
	bh=NsbwoYuOc8TjNu/BedDdrpYil/xgrNL/Le/UmwKzotw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ef+fzoWOncZwpPmM3cZy2wEnuwm0HwpMRV2bvPqkhV2C0hDzghYYk4F+0LH/Hluty
	 Ql8y/F5regP7c2S803DdzE7ojlTt4D7YC+qOgnb6U31DVLEto+WTlxhTcL3WmlrdbJ
	 0WKAD24nWNEYQmjStm/oosm1OXWmonCkf6VcilWU=
Date: Tue, 11 Mar 2025 12:14:43 +0100
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
Message-ID: <2025031100-impromptu-pastrami-925c@gregkh>
References: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>

On Tue, Mar 11, 2025 at 06:05:55PM +0800, Chen Linxuan wrote:
> Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> Handle memfd_secret() files in build_id_parse()") to address an issue
> where accessing secret memfd contents through build_id_parse() would
> trigger faults.
> 
> Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> This repro will cause BUG: unable to handle kernel paging request in
> build_id_parse in 5.15/6.1/6.6.
> 
> Some other discussions can be found in [1].
> 
>   [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u
> 
> Cc: stable@vger.kernel.org
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>

You dropped all the original signed-off-by and changelog text.  Just
provide a backport with all of the original information, and then if you
had to do something "different", put that in the signed-off-by area.
THere are loads of examples on the list for how that was done.

thanks,

greg k-h

