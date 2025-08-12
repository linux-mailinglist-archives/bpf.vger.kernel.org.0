Return-Path: <bpf+bounces-65467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB256B23BB0
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4871882344
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0FE2E03EA;
	Tue, 12 Aug 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgNXA+nr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EA1A9F99;
	Tue, 12 Aug 2025 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036869; cv=none; b=nmk7E8PCZZKnDig1CaY29t4tRtwzpuHQpO20bgZICoi0uIyVjFSE5ysDmdqiBDFcHVSfwv4zrtIN3qJJ36GBXWLLpMhdNiFa9rN3mS5FbLpZYWhRf2stqcvzx+vTme7DfCX8USHyyKRhaTbNlVMJTQQ3vNL40/PJDGHN9oS+XZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036869; c=relaxed/simple;
	bh=7sKkeVsqF1JriTBRhVeKYa7iymeyEuiEv7yqiQpD2Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSTdm3toRIvzXDXRyVrOAM91SO9nO3DgSnghNGB8ymawyw06BJo4Ugi4we8iZhmiJDtiwwBymFKa5sk9deOs3mzE0pZBMe1CgTyaHHNju4lumxD21PzXnEMX2BDpx4cDaP8JOqk2+S+/U0ARFBbrKkTh/ugIPkKJrloege1BAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgNXA+nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA20C4CEF0;
	Tue, 12 Aug 2025 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755036869;
	bh=7sKkeVsqF1JriTBRhVeKYa7iymeyEuiEv7yqiQpD2Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgNXA+nrVVqPY6MEcYpSuoIFONTeMAx4OK8TrU/qxxayWfUAyuxTLUFpu3dl/nA6A
	 2FWoHOEiJdMaYyAQ6qXI4HkzfGbMeJVOPnU7Lw7l4ggb7C+6vrDNvJu0UiDLYxV5Ry
	 iUHqhFuu1gWT+6bsJjMJwJJnzjo43gSQuB1/3ptItA780TrsljsazjezfAlPo99eNJ
	 mE8qHLErR0wzwKxWCiFhx0tesX+rW5KRM0yr20qmLCgnv96sNXaXMjs0uIGqIoDDgi
	 E4E/oXgQKNkDonQgrKGvl1jqFeZPhTlOwbNTi3JeYE4A6D1E/TcLiOKrxrwDqqdeeU
	 EGzw567XmNptA==
Date: Tue, 12 Aug 2025 15:14:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: masahiroy@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, linux-pm@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
Message-ID: <20250812221424.GA488781@ax162>
References: <20250606214840.3165754-1-andrii@kernel.org>
 <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
 <CAEf4BzZDkkjRxp4rL7mMvjEOiwb_jhQLP2Y2YgyUO=O-FksDiQ@mail.gmail.com>
 <CAEf4BzbJpTZ9P-Deo7Oeikyd3vW953goAw3gYvTPzvDfEWj2hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbJpTZ9P-Deo7Oeikyd3vW953goAw3gYvTPzvDfEWj2hw@mail.gmail.com>

Hi Andrii,

On Tue, Aug 12, 2025 at 02:55:22PM -0700, Andrii Nakryiko wrote:
> Seems like this has fallen through the cracks... I guess we can take
> it through the bpf-next tree, if there is no better home for this?

Masahiro recently turned over maintenance of the Kbuild build tree as of
commit 8d6841d5cb20 ("MAINTAINERS: hand over Kbuild maintenance"). I am
happy to pick this up in the new Kbuild tree but I have no objections to
you taking it via BPF with

  Acked-by: Nathan Chancellor <nathan@kernel.org>

if you would like to. I suspect it matters most to the BPF folks anyways.

Cheers,
Nathan

