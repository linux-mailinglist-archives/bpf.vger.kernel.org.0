Return-Path: <bpf+bounces-69562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931AB9A7B3
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567273AE25F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860782FB98F;
	Wed, 24 Sep 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvwKr/By"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04322127E;
	Wed, 24 Sep 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726430; cv=none; b=rn+sgoqkX0TWf39wy6Apc5s3lcsKI+Gbf1AlD2ytvTLP0A2Cl1JKNICgPxgfYrhxSgKRsBiVYPz3Inl9sZJKGVLu/LUwTSTQjsH8a5PLuaeuy9pkXcJP0pKeB4ZmfV/25nXBqNButE9DhgOl268eibcAemsB7JAPTBRIRV5QaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726430; c=relaxed/simple;
	bh=vEKqMMl9gq8XJP5yzSG6Ur1oeXw00042GkxtizM3cxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhT2D5I1kzKwTzarTv0NYkU8OKpiQjb9nec2sjnE1e41p4tj73QqdwVbzeSS7Zh4qXF6pKMSIU7RH7Y/lD6kie/WYHyYAkExzB8R2QiSw0vSopuUfnUntGm8TkmJY+rd/D+yDdfOUZwIWaAHtYg0OMaVYhelU9KVx4rRmqwHLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvwKr/By; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD6C4CEE7;
	Wed, 24 Sep 2025 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758726429;
	bh=vEKqMMl9gq8XJP5yzSG6Ur1oeXw00042GkxtizM3cxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvwKr/ByVG4DL2HwzUaIEii1G/oWO7ClDo+CrZTerZ/8rqpViaibrrCDDE1OSE1/E
	 VgMXBW5nZ3u4s6Q2Kta8kZkuOZ/VrjOF8OmaeLFWZSuxamkGg54L3//JfcElrKAfVc
	 2nq8eKsDtm+WFqwhsK3bLIfTGDuMNqXkH0SbWR6nRZKTqw2c1JHf66xOkCC2w3ZfgT
	 +odci2AcUG+EFTDSi8Pi49gJlaOAx15LdEM1hXP2E9Uda83BlzTSsrX7YCaQyLJ83L
	 +K2cx7b+uqh5nR3gH7J8YYfHNEElizWcnphtPKZ7ULmYeCEclmtjmPZsdxEnEpg4qa
	 07Cn8LyXOawlA==
Date: Wed, 24 Sep 2025 11:07:03 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <20250924110703.2a0ced1b@batman.local.home>
In-Reply-To: <aNQCDwYcG0Qo00Vg@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
	<20250923215147.1571952-3-jolsa@kernel.org>
	<20250924050415.4aefcb91@batman.local.home>
	<aNQCDwYcG0Qo00Vg@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 16:37:03 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> I have bpf changes using this that I did not post yet, but even with that
> there's probably no reason to export this.. will remove

I'm interested in seeing these patches, as the ftrace hashes were
supposed to be opaque from other parts of the kernel.

-- Steve

