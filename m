Return-Path: <bpf+bounces-44665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C49C610E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1490F283311
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3C218331;
	Tue, 12 Nov 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XszYhadn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45C209F51;
	Tue, 12 Nov 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438623; cv=none; b=D6shJOiXCH0Xwn6rTkBBIErWscXt4rjsMH47gGg4l0KGMxfIttrocwQt/bGA1WpxwIHngFMotvKTXezF4cIkjA+H24TRuoocFULSBszTkrcm9SPQ6H8M3UL85A8Jo52FAir7KEQ+jdio/fX/3kWjzOK/nnmW5ABTgYjPu266igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438623; c=relaxed/simple;
	bh=HcjUAhjQn/OHFO1MH9kom4hrvBpbhV1AItujNGav2NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEptxxnvB66qMDYxu3WteXVwcrWYBIRBSmCVjjWtZA4SUF9PQJuo7SrYqSkbjuVLK1i4AQLx1Uqpyx22s/zHzXOfSvZIN3wMYLgd7XdAIb1VUFbkRkkNwQnEqmdQ2SY34k2sRASEswL2IKV+pgfCf8l2ElJXz9gbdDt9B6Pr+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XszYhadn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE0C4CECD;
	Tue, 12 Nov 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731438622;
	bh=HcjUAhjQn/OHFO1MH9kom4hrvBpbhV1AItujNGav2NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XszYhadnOYq4AHsrRyYmHmIWjF5a6EonA/hH4Yu6KBRnMSD8hR461hdZjfU5ZIM29
	 Zf/bFoiU6r63nhQG18hv8b+dol2szg5U0fI/u4h486z4nsiPaw6kevk+v0kBKtReD2
	 yepaNMoW87pTHU8uynKBt4YBsEY6xayx3IpGDVd7Z5+WTJ6BBEsiES7ot2bZBCQhVW
	 6RynbXR0V6nd83qO2kX+vZkn/mV0GVhaqGLy4tdnCc57bMWOaQr8KAO37e2yym5/xx
	 6O05bBuUxXTw5j67niUcx1ZU9UrgpsNCm68oMkvk+fUgElERM+3EXwb2b3mZyptBh2
	 3dSohNez5+5/g==
Date: Tue, 12 Nov 2024 16:10:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Message-ID: <ZzOoGJBiL-l6BfQd@x1>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
 <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
 <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
 <5e640168-7753-413a-ab00-f297948e84ef@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e640168-7753-413a-ab00-f297948e84ef@oracle.com>

On Tue, Nov 12, 2024 at 06:33:38PM +0000, Alan Maguire wrote:
> On 12/11/2024 17:07, Yonghong Song wrote:
> > On 11/12/24 8:56 AM, Alan Maguire wrote:
> >> On 12/11/2024 01:51, Yonghong Song wrote:
> >>> On 11/11/24 7:39 AM, Alan Maguire wrote:
> >> "for one of internal 6.11 kernel, there are 62498 functions in BTF and
> >> perf_event_read() is not there. With this patch, there are 61552
> >> functions in BTF and perf_event_read() is included."

> >> These numbers suggest you lost nearly 1000 functions when building
> >> vmlinux BTF with pahole using this series. That's the part I don't
> >> understand - we should just see a gain in numbers of functions in
> >> vmlinux BTF, right? Did you mean 62552 functions rather than 61552
> >> perhaps?
 
> > Sorry, really embarrassing. it is typo. Indeed it should be 62552 functions
> > in BTF instead.
 
> No problem, makes perfect sense now, thanks! I'm trying to reproduce the
> core dumps Eduard saw now with this setup; I'll report back if I manage
> to do so and see if locks as Jiri and Arnaldo suggested help. If so a v2
> along the lines of Eduard's suggested change plus locking might be the
> best approach, what do you think? Thanks!

So the idea is to try to see what are the data structures that are
being corrupted in the features we use from elfutils libraries and check
how they are being protected via their non-default enabled experimental
thread safety locks and then use it before calling their functions that
would use those locks.

At some point we need to do some feature check to see if the lock is
enabled there and avoid adding it from pahole's side.

I.e. a transitional strategy to keep pahole -j feature that works with
older elfutils versions as well as with modern, thread safe ones.

This was used with the existing libdw__lock we have in the pahole
codebase with, AFAIK, good results.

- Arnaldo

