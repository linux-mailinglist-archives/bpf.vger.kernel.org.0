Return-Path: <bpf+bounces-42956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816B9AD63E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D5BB237F4
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093281E7C2C;
	Wed, 23 Oct 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqfCHuAG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC081E7C28
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717252; cv=none; b=VP2gZlEEell8scby7MdM1pYjdURrUCciL353E7bt1NfdOwOqUjAW//rfgvpE+XEmyDAN86b4umCSaJV95XaWNoWibLWYBg+hvbtrB+oO24v8M8MPDmWVa1GHCPBV8CIadKMNsDnkwr6f25I2xEJNzanIbmr9l0VJiXUvatdHzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717252; c=relaxed/simple;
	bh=JF6th0MQcm6dBvAcvVXaOWS/3NGzrLzEQJSETxwmoa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKPXRgvq3NUoC0ESzQmWAF5pjv74sIwS6t/WTc0EHMpbeaPVkjB1XJ9YMBET9xVYeENh+rkkAkf94pzytZF4rQCy5tFKmONEHWv61ChCl/ocxZYIt4Ee2bVdxrhd1r8g2GtBbxkx6hq+GzN9Zuw+4IgjvoHscSV4yDzNcEPTzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqfCHuAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14064C4CEC6;
	Wed, 23 Oct 2024 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729717252;
	bh=JF6th0MQcm6dBvAcvVXaOWS/3NGzrLzEQJSETxwmoa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqfCHuAGGoPBlLSVVrJ5Rjxke0F/s3UEQU3W/duih9/mRhR663eUCx0nBfNScHMIZ
	 5HNA8O0XhcJ0LpXzYIMEgX1taIg/aqCyZQsPNtWTIeHTGfm2OKmW40i3t4tQG4zXmE
	 QiI5/lt7vFZywigktaz2+Vy1tSjz8eboWXWeaH34+gUV20AV0AH72svG14rwxjA+oA
	 jrsvIXn+J4n+9Kcd8cDesCNOUgrV3JvfMutTiNyE4LKRf67WLV3n8lP3Bg+DJojHjx
	 eLb4GFUPWcsvYJH9IsdmR36vauh+hLUZS6RmxF7Qi5t/Ul2/3ZTrbfnOc7ygDxH0IK
	 u9WeD4XzO2cdg==
Date: Wed, 23 Oct 2024 11:00:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kernel Team <kernel-team@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct
 ops programs
Message-ID: <ZxlkA7AiHJkG8r9M@slm.duckdns.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191400.2105605-1-yonghong.song@linux.dev>
 <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
 <b280e12b-b4e8-4019-ad29-23808d360aee@linux.dev>
 <CAADnVQLEy+VXVeP96DK=U8wTL7Yj_=bTuxz5FBcVgDT346-2qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLEy+VXVeP96DK=U8wTL7Yj_=bTuxz5FBcVgDT346-2qA@mail.gmail.com>

Hello,

On Tue, Oct 22, 2024 at 01:19:58PM -0700, Alexei Starovoitov wrote:
> > The __nullable argument tagging request was originally from sched_ext but I also
> > don't see its usage in-tree for now.
> 
> ok. Let's sync up with Tejun whether they have plans to use it.

Yeah, in sched_ext_ops.dispatch(s32 cpu, struct task_struct *prev), @prev
can be NULL and right now if a BPF scheduler derefs without checking for
NULL, it can trigger kernel crash, I think, so it needs __nullable tagging.

Thanks.

-- 
tejun

