Return-Path: <bpf+bounces-13529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEE97DA481
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403B82827D1
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EEB64C;
	Sat, 28 Oct 2023 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4LQDcAK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46D630;
	Sat, 28 Oct 2023 00:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC97C433C8;
	Sat, 28 Oct 2023 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698454216;
	bh=NYgCCBDHbEbm8NDWR2MFk9rmJsQIHpqcX78i8+6zTkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4LQDcAKes269DLKsYxfm6IR4RphkGjoYVbEIhr4AAAchZboDPt5j6pMDee54KJa2
	 EA60/4tOTYDHFGK3j5ICVfQLf9wwNHF11y2b7s2OreZBUMibJmAI0X3lMGKuxFqPTT
	 3CwpoVQdjs/4oP+c5+9LNTe4YaAs54bQFsb7Lqf9VzncvqbUJ4mG/xYVTFTAeoJTae
	 glxWaz7XIK2Vq/ZT53Ay37LQ6egn0jR30MlbE6CB3X7dOr8Sr0qR11p6xpjWiByWGy
	 tZ5Wb2li1ttW6vijhelZoGxy9HRVW8bvsbc8Mtt9LgrcJj1w9AFjBzJnzSNUBCglDA
	 Ij6vOZifknCpA==
Date: Sat, 28 Oct 2023 09:50:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, bpf@vger.kernel.org, Francis Laniel
 <flaniel@linux.microsoft.com>, stable@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028095011.d3fce4fbeb80a1b1e06a1689@kernel.org>
In-Reply-To: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
References: <20231027233126.2073148-1-andrii@kernel.org>
	<CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Oct 2023 16:37:29 -0700
Song Liu <song@kernel.org> wrote:

> On Fri, Oct 27, 2023 at 4:31 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> >
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> >
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Acked-by: Song Liu <song@kernel.org>

Good catch! Thanks!



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

