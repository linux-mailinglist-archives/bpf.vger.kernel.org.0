Return-Path: <bpf+bounces-41147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0039934D1
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8F528391F
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106C1DD535;
	Mon,  7 Oct 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YxAdut7y"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1F18D624;
	Mon,  7 Oct 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321776; cv=none; b=OmIb/2rxdt+L80tLV6dJgDz3w3eb6oytuDsQNa0sAjUbzqj4mBbG/FnNns2Es5BkD6odTVPvrtlRH3sajs3sH+sy1claLvJLeYz1Zg9LbbT75uqt255Q6U1voB+6FKzkpmSqz3Zvw2gthhgL4FQjOugLH/GUD7ZBlXhueyVmwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321776; c=relaxed/simple;
	bh=+b1vUlAmwYTgWXyFBjBjJlUPz3odLVnyTihbLMu3rdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlFzBXOqi4BkeG06Uz0d2STzVVL/rJdiOgW4xapMTmZ/toopAw2lAF6qULkgywVLiuaTVhE9l91ubCej0S+cozpDy4Rc1ikCo/IhDdmQNGvUYumbBB2GOLrG+Wx/f0vulBLlwvJYEj6XSrmwwVRHuD03x6xtIHZNbImcw/T9UMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YxAdut7y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zy8hGqUA1SAyN6xEA/83zxjhBM/kpgCtGV+CcUwyJJw=; b=YxAdut7yOxt0ze7QhL0Bd4sLCC
	AjJlc0rrEqfoLqP8TzdSOZCR5HpH+MvPSgUsE+WpSF2lipT+HMoRuSkKQqP+2fI+rg169ofh5Rj4D
	yCUxCdfvzkCdcO5yI/YICxa+rZkaZ5aV8NfLucTfOcWo0B0vDsK2tMfimr/uMy0bezxLZXNp9UHrZ
	CwWKnCQH8YOdYgLmRWZ8uKp+0U7aPq4Y1Kg7CPYlCFXgSxeHBbsi3MJnslZf0TAKFWffuD6A4+e4M
	8vKdsWpdBSlAI1CaroEsnnJqrSQdavRjYeecg2pss/uoJtKPUErXmcXicXpMBr/pjDh3Ka57bG2TP
	LbbRutAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrRY-00000001eaA-2TsL;
	Mon, 07 Oct 2024 17:22:48 +0000
Date: Mon, 7 Oct 2024 18:22:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
Message-ID: <20241007172248.GQ4017910@ZenIV>
References: <20241007164648.20926-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007164648.20926-1-richard120310@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 08, 2024 at 12:46:48AM +0800, I Hsin Cheng wrote:
> Fix integer overflow issue discovered by coverity scan, where
> "bpf_program_fd()" might return a value less than zero. Assignment of
> "prog_fd" to "kern_data" will result in integer overflow in that case.
> 
> Do a pre-check after the program fd is returned, if it's negative we
> should ignore this program and move on, or maybe add some error handling
> mechanism here.

We already had a mechanism there - the one you'd just disabled.
Namely, storing an unsigned long value with MSB set at given
offset.

