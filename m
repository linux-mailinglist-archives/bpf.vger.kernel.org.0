Return-Path: <bpf+bounces-69181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3FCB8F444
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9046A17EA7F
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02A261B8F;
	Mon, 22 Sep 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bc3o7szC"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F782F28E0;
	Mon, 22 Sep 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525564; cv=none; b=lRVZucogzDzbiMIlFLqLTLK2vx96bwJ6s8px2WIMb31NZtszcJHKbvU+aNYDCLeN9dQ5bPa/7J7TDstygM3JgXUUHK6baXP9ibUZFRJ44yH0vJSvbYJNScmWezCtdrzGyOn9IK0KUTcxe51SleAVpTBW0Y4+1rDJOVWb+ft6GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525564; c=relaxed/simple;
	bh=mBuYqkk9XBn45bCeKhY48qBq4bXsfeCHlqO1L+em0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPj6zhyFeKxLyw17hWtEwojdtIaEV3RzYQSj87xSCdrVDrEC+k1ym6DaNd5um4UveNjHiu1oPWL35KLKb1LsLWDDUfILWtQOBV16Hxp5SMPUoTulP/m4PuL15Gz3H8n8DKrRmgQ/HpD62aOLCSnhykYEuRZ3P/C4V447/OTI6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bc3o7szC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sDWU/mkcISSSDLAaLSQjGGCYA6jUCsyh7xl/dHp0eDk=; b=Bc3o7szCqCWTdqUdHbDk+UMdPC
	OP6lPMwHlszVLmqtkeaXLs7lM5w1TRmKRdF+n46LIjDZIgfpd6VdXzJoeGicF9PLVtpJWJpwL/FAB
	MeQVXUcvvXMPhpIz9JkQGSkOqsVq3HnlEgdYehvD7hKpsqVkirSCloynH6dK477Z18SxBSy8iwXNc
	ZR/CKLQuyrGcdrwMQzsJJuwAXD4FzxZnlrT1qswbibne7Mg+yyOdzu9Dha0td+NhYyf0M2VWKA+EU
	+BnLwMqfP674UxhIDDxF9a6mv9XMWLrcIj+NXdID8LgyFzLWfCHOnbaTRSwEwZr0L8Xz9iTafjRPJ
	AZCK7KYg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0apM-00000008FXw-1Wjt;
	Mon, 22 Sep 2025 07:19:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3A71300230; Mon, 22 Sep 2025 09:19:11 +0200 (CEST)
Date: Mon, 22 Sep 2025 09:19:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: menglong.dong@linux.dev
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250922071911.GQ3245006@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>
 <20250922065248.GO3245006@noisy.programming.kicks-ass.net>
 <6196970.lOV4Wx5bFT@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6196970.lOV4Wx5bFT@7940hx>

On Mon, Sep 22, 2025 at 03:13:38PM +0800, menglong.dong@linux.dev wrote:

> > Anyway, I don't mind making is_endbr() invisible to tracing, that might
> > just have security benefits too. But I think first the ftrace folks need
> > to figure out how to best kill that recursion, because I don't think
> > is_endbr is particularly special here.
> 
> So, does this patch seem useful after all?

The use lies in making it harder to find/manipulate endbr things.

> OK, I'll send a V2 base on your following suggestion.

Hold off until Masami/Steve have fixed the ftrace recursion issue. After
that we can do this.


