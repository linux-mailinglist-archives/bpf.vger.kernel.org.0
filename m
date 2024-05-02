Return-Path: <bpf+bounces-28443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645C8B9BB5
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5122B219EF
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3213C662;
	Thu,  2 May 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUysGepP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9A83CCE
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656916; cv=none; b=JMN5Z75cIqq0U7Jqwck+TyGG5XQ8t3yDL6hBeyTTFEfjdcxAS8IB5W+TWkQamSHwwly+aWVUPCr/PVbatK8lAT38Flw29NsRxLlooaxtd7TIbFMZOXnT1Yxs9hVrTlXvSLgLskpB4ymDBMk4T4Uk4EWOuZHU3m49OPygZCzH6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656916; c=relaxed/simple;
	bh=uXiiEc49gyJlcB3cUGtvNaLwAg50LhovFpPKHuk1lEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZsCLxnMG/zjRqNf38YPi/TyQX4VrNyYqfX6itNWqFSTeXE0nDE7G6BXiTUql+Ovj8fwxCUAz+Vt5Ax2bwfcUTJe9MzjfKZP/6axikpBlOCPVCwCHfSoxOs/3AVwLnLZuVVd4uuk8fVsgInGMaSI85ApWFbjMEmYSfxHm/tKNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUysGepP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7472C113CC;
	Thu,  2 May 2024 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714656916;
	bh=uXiiEc49gyJlcB3cUGtvNaLwAg50LhovFpPKHuk1lEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUysGepPXftd25fg0FmWE/X6xcUNto1yhtff3Trbb+2r9duIl1OEP3VcQnp15sm2N
	 Nt0qugLiNm3Xei5Jt+rt32saTa3zZUERm82ik+rAIa5hMpAvwNePn0aAq6LBvwG/hv
	 O74vLOt7PdkfAS8dcZqn08xZLNNUVIBRkXF3lMVSDtYqMd89XZDxZpcz/AewN6l71u
	 NRY+AEguG8OhsowkZaSk5tgvKBg8/mGvvk8/4lvDRTxP9aKfnpDiFAQ3jzVW7O+cC3
	 X9xzPUVi4fPaSiwucyUEKCFjI5QR6eTT+VFbaUWI69eWrSEmfGQRiZwrN4eHac/OxM
	 tBMy1Gc6wu+8Q==
Date: Thu, 2 May 2024 10:35:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
Message-ID: <ZjOWjjUmgCdNsXkD@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
 <ZjE85q0SJ1sve25u@x1>
 <2jjkwylnz7rjqkjpjb5li3n7g32uhrhx2uzwwthtgfqdf6bwzl@yjmuy24buoyl>
 <2bc24644-0289-48c5-8118-8be4fc1658a9@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc24644-0289-48c5-8118-8be4fc1658a9@oracle.com>

On Thu, May 02, 2024 at 12:49:26PM +0100, Alan Maguire wrote:
> On 01/05/2024 00:00, Daniel Xu wrote:
> > On Tue, Apr 30, 2024 at 03:48:06PM GMT, Arnaldo Carvalho de Melo wrote:
> >> On Mon, Apr 29, 2024 at 04:45:59PM -0600, Daniel Xu wrote:
> >> Also 'decl_tag_kfuncs' is not enabled when using --btf_features=default,
> >> right? as:

> >>         BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),

> >> And that false is .default_enabled=false.

> > I think that `false` is for `initial_value`, isn't it? The macro sets
> > the `default_enabled` field.
 
> yep it's the initial unset value. Specifying an option in --btf_features
> flips that value, so for initial-off values they are switched on, while

So --btf_features=something may mean "don't use that feature"? That is
confusing, perhaps the '-something' come in handy?

> initial-on values are switched off. I _think_ the intent here is to tag
> kfuncs by default, so we can add tag_kfuncs to the set of options

Probably, if they are present in the file being BTF encoded.

> specified in pahole-flags for v1.26. We won't be using "default" there
> as we want to call out the flags explicitly.

Sure.

- Arnaldo

