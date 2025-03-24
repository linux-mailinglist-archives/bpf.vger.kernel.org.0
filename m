Return-Path: <bpf+bounces-54595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B50A6D4DF
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FF716D511
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9E2E3376;
	Mon, 24 Mar 2025 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBj5LZfx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3A2505CF;
	Mon, 24 Mar 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800582; cv=none; b=FSiKagDJsxsx/25SWU/yMUwQ43a9E7tIinBJP0QlgsNxOlQmlNGS3JgGqf5hHUvxD5CrY0MrOb7Cz5i4DM1q2qo1G8r2l7uwJNRR13FmPhOFsyS/LXphTU+5AV280Cd3D+TJXxaR75CJCpqkg6SsORIzIIt8kPz4QjtWtmlHlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800582; c=relaxed/simple;
	bh=JSUdGazAmz6LBM0jLnWsCHf3QHtK7b1YmV5op+kF/eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTQSe6d05qxUNkfhpqsk9lPAbcEQD29IaiEaTchiy4IKCHAUuvoid4XRcLyImyUtLzR89pXydGBoG5Z7uEJ2IxeeGoS/NWcKWL6RHtgI7+UWGtLSyJjSibWPDkvgi0fBZhQgcCf3pJlorIHyODU62NIDWZY4V5mrSgh0z5zoWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBj5LZfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF39C4CEE4;
	Mon, 24 Mar 2025 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742800581;
	bh=JSUdGazAmz6LBM0jLnWsCHf3QHtK7b1YmV5op+kF/eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBj5LZfxve5cmrhWDISfxEo6blCjzsrMdBrjY0CKRQz4ssHHtAjp/Kx5I10Mj+l6x
	 cMhw1SRAJUKOVfP9+9PFxVLxyy7Fkr96mejZoYU4N+h6CndON3jVfQ0cckS+dzZclj
	 BNjCcZNJSjmCC+lRH1Dw7Psvp3zlx844TcKewPbnuee5v/BO/PHeVl3IS5pc3jMEzw
	 dUZ22wBAeX0da+VKwwmdSOiuLV9/44HK78astaCWEa5YK/2oRgE6/8rWCSWJsmwfei
	 HDv4oau33VLhzz/Zqam98rl7UlElbKLySvghgc2ZxYOfgF/ClRcyLJm/jbb/MZAXVq
	 yoVNSE3/0plWA==
Date: Mon, 24 Mar 2025 08:16:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-EGvjhkg6llyX24@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>


* Eric Dumazet <edumazet@google.com> wrote:

> > What's the adversarial workload here? Spamming bpf_stats_enabled on all
> > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > user if bpf_stats_enabled serializes access?
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > Does anything undesirable happen in that case?
> 
> The case of multiple threads trying to flip bpf_stats_enabled is
> handled by bpf_stats_enabled_mutex.

So my suggested workload wasn't adversarial enough due to 
bpf_stats_enabled_mutex: how about some other workload that doesn't 
serialize access to text_poke_bp_batch()?

Thanks,

	Ingo

