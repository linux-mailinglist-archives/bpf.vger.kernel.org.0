Return-Path: <bpf+bounces-55260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEDA7A9BF
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D479A3B7061
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92316252915;
	Thu,  3 Apr 2025 18:52:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A15151992;
	Thu,  3 Apr 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706351; cv=none; b=k9fx1PN196ZaNQ3dS/cgxg1RA5Tcig193NovyHBDSdwIp+XuZWowPkiy8FIaYn0+mYxKZIsMxNrabQmGBecLuoNxx/OY+yGx4eDGrnYQH4oeJCb8m2QTsbNKxscl3uA49t90TPJ1uKggSK9xavbO9E9V4flqymzZ7/MLw0sJ/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706351; c=relaxed/simple;
	bh=rPBeeVw+hSGNJ0imsf4aVFsK2hBYvU7VDNP8lY4u6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxayCOxrldlEuBqT/WXqkjIhVsyl5ZcQ8UmEPO0SZGKEMhR+5F2VHnKZpz7YoTedGNE5rxpOacDdDVtpnX4MK9uX8vNsrVDWht6Qd/F/0lAUsJdiolNDjTKJtZYSPiuC1q2p3wg7Nd5WyXwRY/hBn5phVYQXD7HSCNBWwMsTTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0ADC4CEE3;
	Thu,  3 Apr 2025 18:52:29 +0000 (UTC)
Date: Thu, 3 Apr 2025 14:53:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
 mhiramat@kernel.org, ast@kernel.org
Subject: Re: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe
 timer callback
Message-ID: <20250403145334.04ac4511@gandalf.local.home>
In-Reply-To: <20250403175619.2QB0oWe_@linutronix.de>
References: <20250403171831.3803479-1-andrii@kernel.org>
	<20250403174917.OLHfwBp-@linutronix.de>
	<20250403135331.1b8e8fc0@gandalf.local.home>
	<20250403175619.2QB0oWe_@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 19:56:19 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-04-03 13:53:31 [-0400], Steven Rostedt wrote:
> > On Thu, 3 Apr 2025 19:49:17 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > > +	/* See free_ret_instance() for notes on seqcount use.    
> > > 
> > > This is not a proper multi line comment.  
> > 
> > It's only proper in the networking code, but not the rest of the kernel.  
> 
> I wasn't aware that uprobe is following networking standards here.

It's not, but I know that Andrii works a bit with the networking code.

-- Steve

