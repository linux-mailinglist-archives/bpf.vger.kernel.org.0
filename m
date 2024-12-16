Return-Path: <bpf+bounces-47068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33CC9F3C89
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 22:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B9188D5A8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA951D5AD1;
	Mon, 16 Dec 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khyo0naS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2181D4607;
	Mon, 16 Dec 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383200; cv=none; b=mqbhncTaawA+HglvOOeewRAgU0PBst9wJOji4OViX9Fg+BTvXHCaNmB7GUj75AZgkIbNz0eHs/3WgNn3rSANW+qmn3fLAwnv4P6Zu71g7bg/9jOBgSau4nqo5eT2mzkrdquXnHQsntxAw0FZqMkmZ9Irxmn+h5dyrzHfGEgP2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383200; c=relaxed/simple;
	bh=wB7B7edacrirY7tBXvab0TpJ07BUYElgMdzaYxuoGDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbUFqSw7OS504Sbyp73OfNyEk5qa6kOaUi2VCa0NMMx+jXyfUNI40g9YjR5V6aHDg8Bc6jZaF8k+d5/o+Sw/YeGNqcyH/272+0tCiXJDI7o5qehxi1R3yhy/42QizRmkt62TDLD2bcFo4qysMvc/wHnlmS7Pl+m8fyzGnBmcyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khyo0naS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C53C4CED0;
	Mon, 16 Dec 2024 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734383199;
	bh=wB7B7edacrirY7tBXvab0TpJ07BUYElgMdzaYxuoGDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Khyo0naSGi5kIOBIm1pgNWxxXYylxRRhoNQVeL/62lraAJeYDpBvQRZ77mPIK4RGT
	 JVTWtweAHJ33H8ayZot5mlGSDYVNpSBjecwS22Dv8MvyuI4wclDtOVwuKtgwxvHju8
	 zKok6OVTkLRmk+sg1dIziRQOTE8t+G3KA7TMRs8qDrSo3bKgq6JIbTKFRfhp5BjZx3
	 eMmdh8Pk0xgSt2jax2LOIXKrnbdVkPMwGmY8GXNc4OUV6zFpFIrAFUNDGYIjYFpg19
	 Yi/WM9PBZlODw7jPngbs+1yLbf5eIfrnIOjHa1ZsikIZimVlzdSJIq/H17PCAV/iS4
	 9BlKRYOX0hVmw==
Date: Mon, 16 Dec 2024 18:06:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] bpftool: Link zstd lib required by libelf
Message-ID: <Z2CWXKVj87gmWjF3@x1>
References: <20241215221223.293205-1-leo.yan@arm.com>
 <20241215221223.293205-4-leo.yan@arm.com>
 <fa534569-b3e0-486d-a0f9-25523f404aed@kernel.org>
 <20241216163033.GA700645@e132581.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216163033.GA700645@e132581.arm.com>

On Mon, Dec 16, 2024 at 04:30:33PM +0000, Leo Yan wrote:
> On Mon, Dec 16, 2024 at 11:23:29AM +0000, Quentin Monnet wrote:
> > 
> > 2024-12-15 22:12 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> > > When the feature libelf-zstd is detected, the zstd lib is required by
> > > libelf.  Link the zstd lib in this case.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > Tested-by: Namhyung Kim <namhyung@kernel.org>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > Reviewed-by: Quentin Monnet <qmo@kernel.org>
> > 
> > Thank you! And thanks for the updated commit description in your first
> > patch, looks great.
> 
> Thank you for continuous review, Quentin!

Applied locally and test building now, please holler if someone thinks
this should be processed somewhere else.

- Arnaldo

