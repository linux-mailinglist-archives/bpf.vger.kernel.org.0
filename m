Return-Path: <bpf+bounces-77040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACACCDA52
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40BA5304699E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685C2472A8;
	Thu, 18 Dec 2025 21:08:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6F27462;
	Thu, 18 Dec 2025 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092083; cv=none; b=ovcP28x66cdjRIDqycNtLCPB4IqWQg2rgInRVmOHRzO7mvUAXnqTw0v5eikVURQvrODAdyexzBHEF6CvuxnR8JZ/C4FVaVfTbNFZkDKRXtv0AjMjvZCfJkL+a+NMXD0gGT/3VSNv4cLdzS2jCyGD78xYhUmLgmHlVg0JfuHVEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092083; c=relaxed/simple;
	bh=E2FwBckpiiOIAS5tdKEfyRMGf9MZsikrpZBOyJS988Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEIMLi1jaqEZZcM3ewfB/HLPLRrxlp0dNixy4VYh9eWbgAZiqtFMHNKScwjLcDwIOhN6BtVL+GAuspK4IlBaL1kmuVymG8f5dLjrFa2pMymg1GWx1UgYL0HvSHQwGgIBp8BuPJpaTQT3dHjoAoSBFqvtOF24F8xgFXyBjom1+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A53141602F9;
	Thu, 18 Dec 2025 21:07:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 9EF2D20011;
	Thu, 18 Dec 2025 21:07:46 +0000 (UTC)
Date: Thu, 18 Dec 2025 16:09:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: liujing40 <liujing.root@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, liujing40@xiaomi.com
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi
 link
Message-ID: <20251218160925.3c02a721@gandalf.local.home>
In-Reply-To: <CAADnVQKC312JbOhjQZmMN-Me2V0GQ9qxoHeQkF+=PbYk0zc9KA@mail.gmail.com>
References: <20251218130629.365398-1-liujing40@xiaomi.com>
	<20251218130629.365398-3-liujing40@xiaomi.com>
	<CAADnVQKC312JbOhjQZmMN-Me2V0GQ9qxoHeQkF+=PbYk0zc9KA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 9EF2D20011
X-Stat-Signature: iwysajycygtdyospk7a1mj6kztxu814o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+tSico+CaEonIRKrRoJhNE6Hc+gfEkW78=
X-HE-Tag: 1766092066-835782
X-HE-Meta: U2FsdGVkX1+zLF/oswfTpTV+r5DPZ4w3WD/QZSlnX8tw5EhN8+rNukK3FS74mWRfhIcC1rUUFp/sFKN9RH+rKCTzFif5T1ymqmfkBX+W7EPrueDDXSl/HDhVxzNZjDebjWURYnpNQhn6hy2C0V1XB4exlyqRS0uJ6x+pn1/pZMTG8dr2CBvHwMsLU5x1LFtfXdE/sNYPtl0yRpSik1ccS7xzatF/z1upPknQ5TbTmoiQ49aL5dpC0ePnsomnIEXvb4/NCgstDLofhF/8O7oqiJ83PmEbxvIBoZRws+V9HTAk7Tt/9M5cRQR91NcnJb/OQg3AG39gx42E0P0xj+e2EDtwkgOKH9H6

On Thu, 18 Dec 2025 09:53:16 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> > +{
> > +       for (int i = 0; i < cnt; i++)
> > +               unregister_kretprobe(&kps[i].rp);
> > +}  
> 
> Nack.
> This is not a good idea.
> unregister_kretprobe() calls synchronize_rcu().
> So the above loop will cause soft lockups for sure.

Looks like it could be replaced with:

	unregister_kretprobes(kps, cnt);

Which unregisters an array of kreptrobes and does a single
synchronize_rcu().

-- Steve

