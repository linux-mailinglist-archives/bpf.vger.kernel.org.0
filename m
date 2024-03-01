Return-Path: <bpf+bounces-23196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D186EB60
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9941F23D98
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082955917B;
	Fri,  1 Mar 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9Zonze2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B658AA5;
	Fri,  1 Mar 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329568; cv=none; b=P1U4odYPl77CkJre4JNoXYf1SI8IjtYvrbwk1sMuqjhPX9HVHXLScULDm7Ys7Soudnhvonq1tfxs5Yn81rqXmfL4V4I7ecWToXB/zKbBcvpDY/j3fpNNUfZCzPyE+c1gTmvkvrHpF5xeGANPM9Av+KtJZ1CBpa2KYy0X6YSbgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329568; c=relaxed/simple;
	bh=woz4TafViIxMnemWHEsJ2YzbFK1ksbE8Ar3l7vrOaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5SJhfCbQVaDdiwpym4Dc8RR398FR+5WrO/M4rp3bXW/PfcLFQ2NrcB7Hy9jpJOZaadCwe80Kg3V/35qareJ8Y1gN+49+vHpS5BmXAci4xZXgQo3GdmvqfHmt5XLOBScQuFt4jgWcNA01jAnIFQ9eFQ7S/whYQaMDhULcW6rf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9Zonze2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E4DC433F1;
	Fri,  1 Mar 2024 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709329568;
	bh=woz4TafViIxMnemWHEsJ2YzbFK1ksbE8Ar3l7vrOaAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9Zonze2UPMOUpuATj3rzblKx0TFP4IzZ5P9mTVOFljfXo37om450s12aAwnVdnJI
	 zUR62enjrFKbM2EyqhKteSbAkEY9QyP4AplrbGvqGPbF4illE4QOZMD40OaQy9mhDN
	 9VlqwStnXsgDeehfCtFNzuUSoKGJPr3nDVqUT8G3ypkyKIUIIZG0u229tS/Ak5rkpR
	 xdlhn2tn32+bKCyqxBwcZmnGY7/ERJR6hLUldfDh9byyo86TkTMyPEWEaWUFPuDP0n
	 hmu0J0mMwWkPP6JNAVwXb+x0syVnBXD4bokcv2qvhks9VOX1FR8xA8TGrrrkjAdQCH
	 g0t79cNLWHZXg==
Date: Fri, 1 Mar 2024 18:46:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, acme@redhat.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH dwarves] btf_encoder: dynamically allocate the vars array
 for percpu variables
Message-ID: <ZeJMnNuauQgor67O@x1>
References: <20240301124106.735693-1-alan.maguire@oracle.com>
 <ZeHzK52IeDx2aZfP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeHzK52IeDx2aZfP@krava>

On Fri, Mar 01, 2024 at 04:24:27PM +0100, Jiri Olsa wrote:
> On Fri, Mar 01, 2024 at 12:41:06PM +0000, Alan Maguire wrote:
> > Use consistent method across allocating function and per-cpu variable
> > representations, based around (re)allocating the arrays based on demand.
> > This avoids issues where the number of per-CPU variables exceeds the
> > hardcoded limit.
> > 
> > Reported-by: John Hubbard <jhubbard@nvidia.com>
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: John Hubbard <jhubbard@nvidia.com>
> 
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

Applied, its pushed out to the repos on the next branch, tomorrow moves
to the master one.

Thanks!

- Arnaldo

