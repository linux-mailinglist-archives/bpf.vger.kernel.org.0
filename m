Return-Path: <bpf+bounces-33623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F6923E5C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F8285190
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154B1891A7;
	Tue,  2 Jul 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frNB2o+5"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093A16F858;
	Tue,  2 Jul 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925467; cv=none; b=Ybu4TXnxOoeelJkK2BPax4QScKjDZRqY5mtvjocQjLrk242OK5RAWTU3npg2tX0CIaMTQ3uwQwmHkf2WDSj1vG1CF7FR0lB8BvjV1K4xF6izf3wjoq/m9Xeu84LCAZBt1a95lsewq+HwjNGnnwiOBKWv/F2j6M2dONPjBbi01Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925467; c=relaxed/simple;
	bh=wcCKkAf9LeZlQUUgB4iwi//wVVqoNwx/15yAOShTGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIYYk8s68wMRmK1kXcQNs4qa4MzD6GOAJUReODVMwQPRoeCBdXALxnF09ut5BbB7lPlH2FcwVaFXKQ2KbaYb2EVOMjJUhaM8x60RCxL9VvuIryDedzqiF2feVesL3pa18/y4cs8GfqjZAxRI22oaHxYO2Z3ZDmyh8USwJpURNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=frNB2o+5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aE50TOJGmMs56D5keFB0ZpbHVyMbTxUF2K2Gl2vDliA=; b=frNB2o+56C+04ofDDQrQj97WAp
	pUYuSQh9p+/dyvHA/b6yticybkp99022dvqOn+oxFUs/UjeiDTVOAsTK7huR0sZ1hSZxTTN17enmi
	078itthmAcewlpWUGNvGlXODMEPNJbi+Ob86V6UC20QnaB0nx8cDoeL5cPA03xEK4HEERohMkXkNa
	aiRm7rNuJOTCD9xO9S1XiLMzi4j7X/cVCnDA7gjXbLX8wf8H5laAQSk6p5aFghy++HnNNtoV8ewwH
	D+lbxcaXkT8CgdxFf60OEL6+m9q4pY5Gu69QJ353cGe/auzFh06h7wJrUP4XyQCs0x+Tnov1Pqzdv
	AogRD0uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOdB6-00000009p2E-0pO1;
	Tue, 02 Jul 2024 13:04:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA86E300694; Tue,  2 Jul 2024 15:04:08 +0200 (CEST)
Date: Tue, 2 Jul 2024 15:04:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <20240702130408.GH11386@noisy.programming.kicks-ass.net>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701164115.723677-2-jolsa@kernel.org>

On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:

> +static void
> +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +{
> +	static unsigned int session_id;
> +
> +	if (uc->session) {
> +		uprobe->sessions_cnt++;
> +		uc->session_id = ++session_id ?: ++session_id;
> +	}
> +}

The way I understand this code, you create a consumer every time you do
uprobe_register() and unregister makes it go away.

Now, register one, then 4g-1 times register+unregister, then register
again.

The above seems to then result in two consumers with the same
session_id, which leads to trouble.

Hmm?

