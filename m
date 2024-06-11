Return-Path: <bpf+bounces-31852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA0E90415E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B7628A993
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E703F9F9;
	Tue, 11 Jun 2024 16:30:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD43839D;
	Tue, 11 Jun 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123434; cv=none; b=sMIRmh+aXPVbsqigzU1Fqt3pnry5G/kr+b37cF97C6mwLRGWVX5U+uUkMYhLiykt0MeMK44Bbd8zcK6tlglB4C+zJ/18c3+VBf1m6ahhNYQWkD19LJz0gshASy7IRkeDvBy8+FoPeMvNGmuXALXRecBPzDAuRqIlPKAzEmywMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123434; c=relaxed/simple;
	bh=5cpAqCueMiul15O4cnq2Z/clOXb3h3yGx7cGR9jOKg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acnjW9bJ8WDWDdd+6PFuYPehxnpgfP8dqtAoc2Q53Ksj3K1TfjtcnPIoHE0NK1/qXmMCB+hWw1O6Tl6yw6xBL7QSwfczKNhZuT5Ds2/EsDSkdGCAdZ42tu8puzKdGCXel9Go0/yEdfk8jd3LfVjVnbTEENCaLAVtC/nPk41S5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A34C2BD10;
	Tue, 11 Jun 2024 16:30:30 +0000 (UTC)
Date: Tue, 11 Jun 2024 17:30:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maxwell Bland <mbland@motorola.com>
Cc: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>,
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] cfi: add C CFI type macro
Message-ID: <Zmh7pIpTlexcCyOL@arm.com>
References: <mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4>
 <cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2@44gvdmcfuspt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2@44gvdmcfuspt>

On Mon, Jun 10, 2024 at 01:06:33PM -0500, Maxwell Bland wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently x86 and riscv open-code 4 instances of the same logic to
> define a u32 variable with the KCFI typeid of a given function.
> 
> Replace the duplicate logic with a common macro.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

This patch is missing your signed-off-by (the same with the second
patch). Since you are submitting it, you should also add yours in
addition to the author's s-o-b.

-- 
Catalin

