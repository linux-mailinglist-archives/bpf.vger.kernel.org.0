Return-Path: <bpf+bounces-70971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C45BDD1A2
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157CA188702A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BBE3148B5;
	Wed, 15 Oct 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="avjmYPc9"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B838313298
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513130; cv=none; b=UDNPJoJs5IcOokRiosScxmFuX7qiZdCHXBQGTrEmqlfzc0AbZCp3DURRzRbGqlg7NlaSixx5UwWv5zglNOhdi+bsV6y3195bUC4wRCDzljVxDpvCB24EwKTvcFaGQQkDP26PU7IeNmg+98yNtNOBNXZPU2SqrVFPh0fQB8S1DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513130; c=relaxed/simple;
	bh=BYd06zXNWJAWVsC42sA7TNqo7aIoHecPhYgrtsCvFDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcgM4WYYiQ3JvG2eVIOWN9HxBrT2uHPORH8x4uDDWthruhtW/bakQ8NwsUxwT5g2lKf33PEAwLsfpp62e2IWv/LSo3CsZecVTcd33meRa4jRMHwgMDvsZ8O1XKB/2Rc+4gbV38r5jgiHZItZmguIvIFL+NoxTnsdF9QZZrKra1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=avjmYPc9; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760513126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRsEDmLBtMEKaQR4y6sp1pKVNHv635qhRHMthSlRzFQ=;
	b=avjmYPc9E7j9ny8g+ObpSyXGMAeIAcYXqbTZfumaf4q9CbesrR8jIlqrtVK0uO2rhEq3mU
	lLs4d3kzKgLppX9K4s2beo4X0UDTx6l3nwpBcUcsGEPC9v1X8OeNxUxnGzJ0Y20QZPEv4W
	OMbfa7KIThlEeaIVOuT8ov8ffna5qcw=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fprobe: optimization for entry only case
Date: Wed, 15 Oct 2025 15:25:18 +0800
Message-ID: <5930027.DvuYhMxLoT@7950hx>
In-Reply-To: <20251014235159.fdfc2444582ea15de822c0b4@kernel.org>
References:
 <20251010033847.31008-1-dongml2@chinatelecom.cn>
 <20251010033847.31008-2-dongml2@chinatelecom.cn>
 <20251014235159.fdfc2444582ea15de822c0b4@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/14 22:51, Masami Hiramatsu wrote:
> Hi Menglong,
> 
> I remember why I haven't implement this.
> 
> On Fri, 10 Oct 2025 11:38:46 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > +
> > +static struct ftrace_ops fprobe_ftrace_ops = {
> > +	.func	= fprobe_ftrace_entry,
> > +	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> 
> Actually, this flag is the problem. This can fail fprobe on architecture
> which does not support CONFIG_DYNAMIC_FTRACE_WITH_REGS (e.g. arm64, riscv)
> 
>  * SAVE_REGS - The ftrace_ops wants regs saved at each function called
>  *            and passed to the callback. If this flag is set, but the
>  *            architecture does not support passing regs
>  *            (CONFIG_DYNAMIC_FTRACE_WITH_REGS is not defined), then the
>  *            ftrace_ops will fail to register, unless the next flag
>  *            is set.
> 
> fgraph has a special entry code for saving ftrace_regs.
> So at least we need to fail back to fgraph if arch does not
> support CONFIG_DYNAMIC_FTRACE_WITH_REGS.

Ah, I have be working on x86_64 and didn't notice it. You are
right, we do need fallback if CONFIG_DYNAMIC_FTRACE_WITH_REGS
not supported. I'll send a V4 later.

BTW, is the FTRACE_OPS_FL_SAVE_REGS necessary here? I guess
not all architectures save the function argument regs in
fentry_caller() like x86_64, that's why we need it here :/

Thanks!
Menglong Dong

> 
> Thank you,
> 
> 





