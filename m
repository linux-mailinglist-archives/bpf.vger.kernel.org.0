Return-Path: <bpf+bounces-65233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A06B1DD35
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E47721ACB
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4E21D5B0;
	Thu,  7 Aug 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNdSYha0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1F43AA1;
	Thu,  7 Aug 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754592379; cv=none; b=d1qilJ/fsZ2TgF0bdkp7enDuyGhSO1JqwUaPS9/97nhEiI/Ek18d/cwzdtlhx39/rQQLyFpGTwPAN6JZN7Bhr+dBRhMDjEpH94mGjJCYs8Zkr74e2yqy81DUhRZ/a27K41gfs8xnEWCtbrsTssYBQEYG1sqZ6OSGzlPEFgQd/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754592379; c=relaxed/simple;
	bh=M5iooSWADWZDAW/74nh66Q2XQJd1pnNLeogIJ92NeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVZj36Ua4sM345nThpht0COw+lbtNHQ70SBBfzsrMMOIYiQqK1B2IT1RSH39aCMzO5iw4oSpAyn8JU+P4eXs4k+arT4CZs2iCUYWsHzAOuq7ZYFs/I9jZ57tverjtdqxVvqWGhNzwM+wrz+PizmbOhm8gDCzZxRQxM266Kn8V8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNdSYha0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650EC4CEEB;
	Thu,  7 Aug 2025 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754592376;
	bh=M5iooSWADWZDAW/74nh66Q2XQJd1pnNLeogIJ92NeEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNdSYha0kJ0kEGMZE+1R423BlZQKaayN/VRqxTHHjaxqgajESTcuMKoGFvpf6qdF0
	 GoW16CMLE0QLjaqoCzEB8AwIm+Yd80+V58AGa4+IyRJZFYmvmn0qI7LF9yurdblHKh
	 8aLEMqrCeqFJelGVmAKZpFep1NhkDyHrzhAYZTvlfbgrOjTM5EMR6WPKeMSUpUiJNG
	 cFvqokONosKrirdGfY5sdiVoxPbr63AZefb5W24lkTDmEHyryASfH6iSs6btfsxOjs
	 SvCj7i+GAgN86iyqhbObBWFcGd3SA/OrOe7q0PT2Ia26aS7DgDUgNrPFEhLfSBau2b
	 0GYqZ9Yuc0HNg==
Date: Thu, 7 Aug 2025 15:46:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
Message-ID: <aJT0dE0QRgzrAFgo@x1>
References: <20250807182538.136498-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>

On Thu, Aug 07, 2025 at 03:25:34PM -0300, Arnaldo Carvalho de Melo wrote:
> 	I've finally managed to act on some idea I shared with a few
> folks while in Montreal, namely using unmodified pahole to generate BTF
> for each .o right after it is produced, i.e. with this patch:

The patches ended up not flowing to bpf@vger.kernel.org, sry, but the
series is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=btf_archive

Cheers,

- Arnaldo

