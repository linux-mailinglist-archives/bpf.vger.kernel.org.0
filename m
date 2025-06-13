Return-Path: <bpf+bounces-60570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BED6AD80FB
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23863B83EE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17325223DF6;
	Fri, 13 Jun 2025 02:28:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7F34CF9;
	Fri, 13 Jun 2025 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781716; cv=none; b=apV2MiFkmdJILe76jCmbQ+c3qSojMabPAMMDH2VILpC92y9tvsDWP27S0eTqMAVnHpQtNq5cyj5aJPFmoRpBGBCVVG8C1gqhInaQkq9fBg9BJi7J/YSf9BTxKL70vBPUODdHqattg6Mpmvwq23hvMDSO+ccHAWQDWKSBlOBYIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781716; c=relaxed/simple;
	bh=iOs1L4NIOZyQK9486zEGSy8J5viLC8mNIVx7iNPVSo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gv2tXigCZbhEEPTjKYYLUflkL4f1GiMPiaqvH7EEYfEdhFbDJ0wm8Aq2OW18jY53F3KWIKybaMt0bWHZ8jk5YTmbQvNtCkcEABOjsIL55Ma+5EMDE7aqsFo21If8wjJR7rjWhsnU/xdWLecUqiR+5Z1gq9uv7Wn+rtRkb5m3aSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2F763160AD9;
	Fri, 13 Jun 2025 02:28:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id A153E20030;
	Fri, 13 Jun 2025 02:28:30 +0000 (UTC)
Date: Thu, 12 Jun 2025 22:28:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2] xdp: tracing: Hide some xdp events under
 CONFIG_BPF_SYSCALL
Message-ID: <20250612222829.29817207@batman.local.home>
In-Reply-To: <20250612222652.229eaa9c@batman.local.home>
References: <20250612182023.78397b76@batman.local.home>
	<CAADnVQKEosaLbpLg4Zk_CcDSKT+Jzb3ScKQWBA51vLHt-AoQ8A@mail.gmail.com>
	<20250612222652.229eaa9c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A153E20030
X-Stat-Signature: tz4opxtxea3rmmf5436zrzucdee5c8j5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LY8ouoVMEBS83hqnPGAKja8nZSul9RzE=
X-HE-Tag: 1749781710-7210
X-HE-Meta: U2FsdGVkX19EdnVgXbNNYZRgvT3PpYGbhG1vIuMISp6DQDbBZn5sFKeX+FLbnq5HNxuJ+iK5BiX47hYI2LcRB6A3BAffH3UE6ODSM5wDyoxOGFCGIAeXBd268etc2x7L0kh2RfnV3ehUnJZLg6z2CRlPZ2VNDqQdgM8gQGcK0LjCwZC3+LuIfkUqiWRinID1klNIEuwRnvH9Fejs0u1Qc7/xDpmAR9qYWtqVc4S8VOGQl3b/QZG/P2Fip6o6TAlAYekkejAMPU6RcBLRcqMK1QmoHxn3YtwXQEElRTAMuOcdZsiI4nW0sf2tqav3I8JeCU0q2Q9HM0cnIhAsFoXjVpIsP0FUNPkGMAFOCdStIKe31YkQf0DhYqDGWpZIdcnlA66aYe0ybgUJz8ea3+Aa8g==

On Thu, 12 Jun 2025 22:26:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > We can certainly take it, but you mentioned you're working
> > on some patches that will warn when tracepoint is not used.
> > So do you need this to land sooner than the next merge window ?  
> 

BTW, if you are curious about those patches, I just posted them:

https://lore.kernel.org/linux-trace-kernel/20250612235827.011358765@goodmis.org/

-- Steve

