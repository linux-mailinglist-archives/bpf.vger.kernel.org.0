Return-Path: <bpf+bounces-70908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1168BDA28B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6CB18830A9
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D72FE05B;
	Tue, 14 Oct 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgtFYdsI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C32FD7BC;
	Tue, 14 Oct 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453527; cv=none; b=XTqVcm2DXoJQQIlIbQSYdB4CPEnr0hbs3V+OOb1Wk10Oew1S9VpuwyOjaN2eKHgFg2RSkq/J0cnPv1tKp+dCh2StchD+sbPY9ZoZZ4EIhFzWpPtHYtxG6VX785FW4CMj+L0B5pQiCr5fZg0sOjo6oirkcKdNqRhVz2bRtcpXc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453527; c=relaxed/simple;
	bh=dXxH4+BCkV70G2cUOYaRDyMCMT92iXGER7n8AbGM3As=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IigVHpJJzYpgqejpxGv2rDO0MFEb87QiHYnWIzhZ8NOB50RORjDgG2XkyKZeliTCMRUeDITidjHupWij46HDubPe7/hO/nrhxKJ9qlSWlLtf4gDiY2/tjXZMZCJ8/8tKi6tpjorWhyiI7px1A/KU/uVa5CCkzZ1TPrDHvB/EM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgtFYdsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B697C4CEE7;
	Tue, 14 Oct 2025 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760453523;
	bh=dXxH4+BCkV70G2cUOYaRDyMCMT92iXGER7n8AbGM3As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MgtFYdsIZvkvkL3H4Aj00ppBACazuQ6mbX3kIhfPCZopy2f7MNDY17TYjpeNZ4r/H
	 1aM3OKvqVs5CvZyHZb/2+8is5TjPF2h4jn8EdMTDD2RknG+WNk1Eo4W8puzvMVW2xs
	 CLl/KK8sjl3xdULn/kEAFBfHcUPtPUGpg9cCKVPHiFpo+Hccr4NZRa+xW/HMYCN6sM
	 7yvYHcwv9aObZ4o2KTIf+iYSQzF1WgUGgLNLbr/e7LCQ0Yqt14xgwWgajdaKWvj+gD
	 x7i0Jw6kbZbiWKPDgEI0eRxhU/51sgsSMPuFbC1xxeXA+DrZt+dM1B+8KtHZRfmud/
	 X57pLQJNm+QoA==
Date: Tue, 14 Oct 2025 23:51:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fprobe: optimization for entry only
 case
Message-Id: <20251014235159.fdfc2444582ea15de822c0b4@kernel.org>
In-Reply-To: <20251010033847.31008-2-dongml2@chinatelecom.cn>
References: <20251010033847.31008-1-dongml2@chinatelecom.cn>
	<20251010033847.31008-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Menglong,

I remember why I haven't implement this.

On Fri, 10 Oct 2025 11:38:46 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> +
> +static struct ftrace_ops fprobe_ftrace_ops = {
> +	.func	= fprobe_ftrace_entry,
> +	.flags	= FTRACE_OPS_FL_SAVE_REGS,

Actually, this flag is the problem. This can fail fprobe on architecture
which does not support CONFIG_DYNAMIC_FTRACE_WITH_REGS (e.g. arm64, riscv)

 * SAVE_REGS - The ftrace_ops wants regs saved at each function called
 *            and passed to the callback. If this flag is set, but the
 *            architecture does not support passing regs
 *            (CONFIG_DYNAMIC_FTRACE_WITH_REGS is not defined), then the
 *            ftrace_ops will fail to register, unless the next flag
 *            is set.

fgraph has a special entry code for saving ftrace_regs.
So at least we need to fail back to fgraph if arch does not
support CONFIG_DYNAMIC_FTRACE_WITH_REGS.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

