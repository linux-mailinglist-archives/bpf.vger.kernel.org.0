Return-Path: <bpf+bounces-45843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D063D9DBCF6
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 21:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F1D1646BB
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB421C4608;
	Thu, 28 Nov 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1JPsXRq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120919D88D;
	Thu, 28 Nov 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826419; cv=none; b=GEI4kTR+PZU+9qHlmvB2MJtSpdCiJDN5Y/SNzCy7gAR5SGOa+JuhvKrkSXdd2yCMPRo0MtqQjTLc6HG7VfCYnOCDuzyE3T/LzkJhBWyrqcWjQmUEKTWNzgpTZfqLgcIp1LzCbogdGfwGJu27AeJ6ZoW5nOPMqmH/PB3zuBDEh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826419; c=relaxed/simple;
	bh=DjUNoDxGOes6NStt1rsO2oxo4hxPVSN2oDP5tPRjJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aiV/Y8QcSeexWDjF2ATeF6rSliwdEXyzBkMG0UdTOc+2p1Libkyfg8WWFZzkXvbpr7Q8kJa1hBsjIxqraLy2Th9dkiFQBQN5kgRz0fLfhZH3wZeLPIxP+7U9LSBbmDpmaEp02ERUJFBJjgEN4DRTrpGKKcWsElvkL5zSeVo6uRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1JPsXRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B5C4CECE;
	Thu, 28 Nov 2024 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732826416;
	bh=DjUNoDxGOes6NStt1rsO2oxo4hxPVSN2oDP5tPRjJEM=;
	h=Date:From:To:Cc:Subject:From;
	b=Y1JPsXRqm5rPACua5fTDr8p1tR5wmhf8/RDfQAbE+cLdq4DSSGpkF1gJA2BQ1E8Nt
	 dDnJy1EJjR/RvkwMRS2f52vEJe0QLMG7xB2b1lQPNWGb1cMg7vGuZ3K0XgHppnPotG
	 RW1nz0FoFEjfZhSqeDL1gX0/LX2hYy9a7+LuDkPdvFmbsiarACmfwZTFtnKT1FUUm6
	 OQjL/7XytVqTlyLTrBFyx+546HIhtHbUI3yRm2kpvDTPA9LPftLxjgyufIgohF1c0q
	 SXFl/CUuPp7zeqy0rtQGyWQO2ileI0u91N11fzpSE5L7a29AQFJjiCASiTGORkpQKq
	 dvsiu7u8Sfl5A==
Date: Thu, 28 Nov 2024 17:40:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>, bpf@vger.kernel.org,
	kernel-team@fb.com, dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFT: Testing pahole for the release of v1.28
Message-ID: <Z0jVLcpgyENlGg6E@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	Please consider testing what is in the master branch both in
kernel.org as in github:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git
https://github.com/acmel/dwarves.git

	So that we can release v1.28, we want to follow the cadence of
the kernel, i.e. since the kernel was recently released, we should
release a new version of pahole, and this one is long overdue.

	We'll then try to release v1.29 shortly after Linus releases
v6.13, and so on.

	Alan Maguire accepted to co-maintain pahole and as soon as he
gets a kernel.org account he'll be able to help me in processing
patches, that we expect to continue with the current fashion of being
tested and reviewed by as many developers as possible, its greatly
appreciated and a good way for us to keep this codebase in shape.

Thanks a lot for all the help,

- Arnaldo

