Return-Path: <bpf+bounces-22708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF05862D6E
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 23:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7737281105
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC41B949;
	Sun, 25 Feb 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kekMzeaZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33EED9
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708900704; cv=none; b=Vuum6NxDMPO9v8pwd+7AcXGMdPvVPOVRqff3zUQMIeeUFv+dABIQWALnD5log9tOnj4LpzAxWy62oLh69k/++cdLnYns1974aM8wUF1uW4tsfKTXDANmSpu1JDV28T9hXdBsHU9/k2hbTNK5wrZqXTwrrzD1RNds4Fe2ODhtC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708900704; c=relaxed/simple;
	bh=AbOPEIQXdwToN5MAZdg9bPKykOGYI7NT5yNP8Jhdrfw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JCRpSVZ/JAwDOJTjyp9Ok0EYUK1kd8STJzOGrAFc66Fc5EV0dk+Nzc30m5eKfiup/slLPJ6ALbHVBZs7CQH6MxhYuf9mn606fMRw03XzDjPfXSPQsp20LAaX/cRMinZ2kHgckoJ+G8RbII8dUDSimxgu8QYJ7s9JmILL9Etu9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kekMzeaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE8FC433F1;
	Sun, 25 Feb 2024 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708900704;
	bh=AbOPEIQXdwToN5MAZdg9bPKykOGYI7NT5yNP8Jhdrfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kekMzeaZ+nuFfBcu9YMAL1hq21lL8sifRc1I69Jd730x55HicVFlkLZVUn/vF2W/d
	 YKTVoVaiAyJLvoijPBYN1p/a0p7GdPiN+LioQHdxDQ7UKA0AK/bcSNaLGNcknmvfIk
	 3dCJTldtAoCi1pVKW2eOgD0A/oxA4BrfkkxNaUb9eRULe+SwQO8sd77REP7/3BsKAJ
	 cu8qUhxe7c7qbkFVILCp9NIx/O5dtob9/Vmfjixaowj1nOf65bT1ilVR1cll6SJKck
	 BfG6CzCSiA2dzi0YOaCz8McnJvx9eA5taVOT0j3xZgqceiMsDmJnbFvNMIzfIBF7ZM
	 BE2OG4IIdhrig==
Date: Mon, 26 Feb 2024 07:38:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 lsf-pc@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] multi kprobe updates
Message-Id: <20240226073819.e049b1b3c2c7fa9fb8f6cd4c@kernel.org>
In-Reply-To: <ZdcfedGHCwxOI29a@krava>
References: <ZdcfedGHCwxOI29a@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 11:18:33 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> There's few ongoing kprobe multi features that I'd like to give an update
> about and discuss.
> 
> - Support to execute bpf program for both entry and return probes. This
>   way we don't need to create 2 links when we need to run bpf program on
>   entry/return probes of the same function, first rfc posted [0].
> 
> - In addition to above feature introduce shared 'session' data between
>   entry and exit probe accessible from bpf program, originally discussed
>   in [1].
> 
> - Allow to use per program re-entry checks instead of current hard coded
>   per cpu re-entry check, or just change to per program check directly.
> 
> - There's ongoing development of patchset moving fprobe implementation
>   from function tracer on top of fgraph tracer by Masami Hiramatsu [2].
>   As kprobe multi link is implemented via fprobe I'd like to give an
>   update what this change means for kprobe multi link.

And now I updated the series.[3] This changes the ftrace_regs accessible
registers according to the context. In entry probe, no change, but exit
probe can only access return value, return address (as instruction pointer)
and frame pointer if available.

[3] https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit@devnote2/

Thanks,

> 
> 
> [0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
> [1] https://lore.kernel.org/bpf/CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/170723204881.502590.11906735097521170661.stgit@devnote2/


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

