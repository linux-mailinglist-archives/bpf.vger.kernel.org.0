Return-Path: <bpf+bounces-22072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3679856164
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3250E1C227D7
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D26128837;
	Thu, 15 Feb 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZg993Fl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfYx62Wq"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF68433B1;
	Thu, 15 Feb 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996198; cv=none; b=hxaNhdoHlmzdlJWJnsaP8eQJjSUODVO5elUvEz5kuiuZbMOchlMvGLmAxy/Lrr3Ys6PqeWsjIX42H/DprEAjBPmIFSmvSmPIHcx+3qj5271vwUjsHVG+7SPpoSCZWU+mAADYq9O0OMrQJZ33haTX2DrlTyasUsrv/bLjA2hXq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996198; c=relaxed/simple;
	bh=wrH086cxryhvyGq4VLH7w3q0kaPWmYXaAkLrmX5E290=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtubsAwVLpRdkipco45BFI8jucP18a6FYl8lTZ1V/NhBjQdz6Ry079KS5hBDes+avNcwZUgJlWqMburl5q0Pa0eauM8GULXlEL8Jhm6Wv1EyfLBlj0sPmckJGQFzOwISrjDEfqQreU3S7mvbxX++EhL56YMeTQVTXf7yAlowi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZg993Fl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfYx62Wq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707996187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrH086cxryhvyGq4VLH7w3q0kaPWmYXaAkLrmX5E290=;
	b=bZg993FlO2IroH51kj5bEF2hKzukwOy29jF/xYbewzkdYx2pDO798Vo06eFPI7wIG9vHPu
	cl/x4Gj1EE531PxUuNIu/NGyovFDuC9m92BFsYGEf8J7k4safKw158jBiYlOpNxN9wiS0I
	F2CvkJsoBFRo0RRlNbimj85Rc7PVqOPlF5thmhqMSgJIaKyJMxJWbBORuCuf7NVykoj/tb
	rMHdrVMbqZwgGu4j580qVyzSM7xh7QQBw0yA4jcYeygBywuNk3w5mK7LGbNo+BMP2aGZC6
	toH2fRobgmWo4h6T/72IYfbJnQNENwa1/jjtfHcAvksmPhhMQ2CtTLvz3XI9uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707996187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrH086cxryhvyGq4VLH7w3q0kaPWmYXaAkLrmX5E290=;
	b=dfYx62Wq9iH+RrIA+K3w/cYvFVtbir63FhLXN0ySNjolbzoer0jhDJKqOZkquHSUK/H5xT
	yw3VOtFMtYPX0XDA==
To: Hou Tao <houtao@huaweicloud.com>, x86@kernel.org, bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-kernel@vger.kernel.org, xingwei lee
 <xrivendell7@gmail.com>, Jann Horn <jannh@google.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Yonghong Song <yonghong.song@linux.dev>,
 houtao1@huawei.com
Subject: Re: [PATCH bpf v3 2/3] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
In-Reply-To: <20240202103935.3154011-3-houtao@huaweicloud.com>
References: <20240202103935.3154011-1-houtao@huaweicloud.com>
 <20240202103935.3154011-3-houtao@huaweicloud.com>
Date: Thu, 15 Feb 2024 12:13:37 +0100
Message-ID: <87o7cidlpa.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 02 2024 at 18:39, Hou Tao wrote:
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

