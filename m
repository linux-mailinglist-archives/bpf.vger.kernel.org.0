Return-Path: <bpf+bounces-22131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC8857573
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 06:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BA287D26
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994511733;
	Fri, 16 Feb 2024 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Px1/TqOq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnEF6t3c"
X-Original-To: bpf@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A6C15D
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059810; cv=none; b=YVDWg/QYJeCT4GN0hgwsIM00X1ZKqR8y+TlKkMADmJ8LpuXYpvxx+VxJxC6YXKNcIe07F3QKOV2xNUz0oR2T0ecdUMULsBFn4noDfL76fhyF9UiA465MxAmo4Pw7EfzVwd60kMuDV804Mxd1VTQh+5kcHmSmkaJ/Rxqsun67mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059810; c=relaxed/simple;
	bh=dLEPQ52pPjxHYhnINN5A7zfGQ4KtGpP9p3ny2HoJhxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3oUYK0vSU+TxkTU95APGQUEJ6DoiYjpQpUv6HqES+jruBN60szMTjKGmgAHpaKWq1X6LI15/ZyiBjpNgdN+89oSBcFvhn1Zz2vj34mM/qRf58jIGksJiHtU/IoNhtQxYwDjgqUNaIhBcwU7vTBdACbixjmdv/oFjsLZxI6hV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Px1/TqOq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnEF6t3c; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 7F8D83200A4C;
	Fri, 16 Feb 2024 00:03:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Feb 2024 00:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708059806;
	 x=1708146206; bh=aEzo+N7tJsaCTlc8GAVUCM726Y+9q3UQM6yZ+dfZ8Qg=; b=
	Px1/TqOqMn9Vm/X0296PV2y8/s8DAF7jZ1BmT0VP9PRHglxIt1YxnJiZ7jJK433h
	sYgEfYmr70dWcFWMWuBL37oF6CX4IGOP8TDaibP+JD9dBAl061Xb/5C1XggrwZTU
	jjyDCaeFypF74VO7VZchfeqNq8LGZEUp3un6MDnhH+J9FDewih71zbah6tejAx1T
	f2CgmNuOLClqJSACw8SPXb3Pgl6Zvi0ewzrRZprMUVXXei7jUOCN+bDcWnB88urj
	aJAKuZXn21CBl9YIzS6oknsbbGK8nkKm+U7ABhxaNNWgFi/gi62jRVIoisCxkbRg
	wsDPM3tnJjgxC3GdeKix/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708059806; x=
	1708146206; bh=aEzo+N7tJsaCTlc8GAVUCM726Y+9q3UQM6yZ+dfZ8Qg=; b=j
	nEF6t3czLkMVLotEDfdJdSZ6BhyIljk038on5OFxaV8bE0UDaSzeaXKiL/0dMP7u
	/hLZhVbJBmohBhkb418duw1d1q+hjrmmf4jeElWM+r7LYUMblfK97RYEdMlx3KvR
	tjJ77C3YGlfsI6Tms6o0Sa44x60RqZzoi7RowBSMucIZrH/hPq/paX6nX/juV/B9
	MXHj+bq2dXFjTTXPe/yFd+4IHrTVnqdcDDCBpmjZK2y2ghs53xbHW6eIBMtCvrKv
	pKxyleXsa9pAvxmi9OPvpB7sPDZQn1tPmBuKuFqBScxb2nVJ1vbVGEylC9/kxW5O
	5qjRYv7zQxiGRCHzfcfVg==
X-ME-Sender: <xms:nezOZTW8n5E_8U-NXKxK7M9_qz4aRTvHeQw2eFBZ1EUabdyXvWTn2Q>
    <xme:nezOZbnc7EJ8jXp5gIyaj_U6E79IWWTHNW65UOrQiYlkYCQbl5EdXq5Ta8aPWxGBL
    2nvMxim0I5MLaLuqg>
X-ME-Received: <xmr:nezOZfaIFC3Cpye2D1CgIXtKMUd9EyofgTTXpvD_M-8tCgnZU9NYUIUJqEd6Q6_-d8pyj0MTu4Mh-_9IMWZI387k9sVR0CXF8H1dcgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tddunecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepudefiedtieehffeuffelffegheegjeekteekgfdtkeefjeeh
    ffejtdfgkeeiteelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:nezOZeXAdoD_KGhUKJQFL8JHsQRIn1Podrcl8D2JV1lxyMkL-Ys5fw>
    <xmx:nezOZdmjPQko_ol-xAu8D56pyqk_vvO9Jh6Pd7ite40svg_s-9ODbQ>
    <xmx:nezOZbdVZguD54xpF8tw0vo43pksvBkPHIT1fZav54hcZHSf3qiTpA>
    <xmx:nuzOZWCGCO5LbtOlItvsNm_2dPqUYbWODDx5xO4sqhg9ndbgKmrQog>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 00:03:23 -0500 (EST)
Date: Thu, 15 Feb 2024 22:03:21 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <void@manifault.com>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Segmented Stacks for BPF Programs
Message-ID: <g2eynf5qrku2y5g433syeftgp3l2yg2sqawmvcee37ygezkslx@tklh2vnevwhx>
References: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>

Hi Yonghong,

On Wed, Feb 14, 2024 at 11:53:13AM -0800, Yonghong Song wrote:
> For each active kernel thread, the thread stack size is 2*PAGE_SIZE ([1]).
> Each bpf program has a maximum stack size 512 bytes to avoid
> overflowing the thread stack. But nested bpf programs may post
> a challenge to avoid stack overflow.
> 
> For example, currently we already allow nested bpf
> programs esp in tracing, i.e.,
>   Prog_A
>     -> Call Helper_B
>       -> Call Func_C
>         -> fentry program is called due to Func_C.
>           -> Call Helper_D and then Func_E
>             -> fentry due to Func_E
>               -> ...
> If we have too many bpf programs in the chain and each bpf program
> has close to 512 byte stack size, it could overflow the kernel thread
> stack.

Just curious - overflowing the thread stack would cause some kind of
panic right? And also, segmented/split stacks for bpf just reduces
likelihood of stack overflow due to BPF prog stack requirements. In
theory, a deep call stack due to fentry probes could still occur, right?

[...]

Thanks,
Daniel

