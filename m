Return-Path: <bpf+bounces-54195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA7A6525B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0077B3B88C2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D44923FC61;
	Mon, 17 Mar 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28W/+NQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZuxdFD+"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42022E41D;
	Mon, 17 Mar 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220536; cv=none; b=FwbZL5lTe1yNq18lMn2Gf3dJTKEdBZflJevoJO1PKn5r9HWkeFU6VlBz7WKAORc6WHGnj5cmHFMSv0Dg707APXeJOdGgZlmv1RiIHhMxnEdZAj0yRcCyHhBLOCcHCP9OVdYAsgyidIG47DMSBA1QkdJfl+J7O5NIqKapzyR2rBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220536; c=relaxed/simple;
	bh=LaBllksMXNcHn9jcIH65hwRzMgxWyFEhpdNoPDS8o4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6cBQHmxvDjSCx+Ond+ZsDbbFIEDVPEivbo/7Udmp+Qfut0S6ubdhDKnMm/CbgBqBEBPgQYw5qdV4dt11XLki+atVRvMJxfCf1jqHrLtoYSKxvFpvaRcSxSHe//1s+7YVK1yeDR4tzXdCnrEcamQ4/eWqwzVgyzWT/VlC3He/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=28W/+NQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZuxdFD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 15:08:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742220532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VmJSsk64HA0bX+prW9/tesp5wyAHGS66/Z9Jcapr34=;
	b=28W/+NQdCpo9WjR9RGG7NwmtBraaBCW+jXmjkTxWvOwnmGczMH/urrf/4t3o71lDB6uP0s
	MZm4oWIh0M0lH7cphRgV+TfXMpY36hUasSUfoyCWU1goy/zhPdI2J81ZwbEWtO7F/rpo3t
	AnctrlF+/7sIH1pSt0W2ncsrqbu66yJu09wqsVHmdUXvgUq1g7a/8cdOhH4QVHwFgqgOKO
	BS0u+5ZlBL+DmxLvhVOQJ5uN1sk7M5dXTHJsm5MGt2nmrifWPs+VKMP7+ZT74hxStJR4RT
	CnCfZseTTD8k0PHrS8ssLKoycGbZFl6JpSYSVGq+EqyoQTcQ+z3hnd2NSDhN4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742220532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VmJSsk64HA0bX+prW9/tesp5wyAHGS66/Z9Jcapr34=;
	b=FZuxdFD+2Nr3gdbrCj+PMZO8cVs8PDeIgVhjzjRjn3XsN/g928yrG0t6SR/4vpEx9y1AzY
	4qk8qNFfjN+KmeDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Subject: Re: [PATCH stable] xdp: Reset bpf_redirect_info before running a
 xdp's BPF prog.
Message-ID: <20250317140849.H4eSnqFl@linutronix.de>
References: <20250317133813.OwHVKUKe@linutronix.de>
 <2025031733-collide-dad-203a@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025031733-collide-dad-203a@gregkh>

> > I added the commit introducing map redirects as the origin of the
> > problem which is v4.14-rc1. The code is a bit different there it seems
> > to work similar.
> 
> What stable tree(s) is this for?  Just 6.6.y?  Why not older ones?

I didn't say just v6.6.y. The commit introducing the problem is in
v4.14-rc1 so I would say all the way down for the supported trees. Just
let me know if it does not apply for some of the older kernel.

> > Greg, feel free to decide if this is worth a CVE.
> 
> That's not how CVEs are assigned :)
> 
> If you want one, please read the in-tree documentation we have for that.

I don't need one but it is tempting to go through the new process :).
If it does not make your handling here easier (since you have two
different patches for one issue) there is no need for it from my side.

Thank you.

> thanks,
> 
> greg k-h

Sebastian

