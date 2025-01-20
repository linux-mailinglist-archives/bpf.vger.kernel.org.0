Return-Path: <bpf+bounces-49304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB4A1742D
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 22:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D0616A8C9
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7501F03CC;
	Mon, 20 Jan 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrZHI+V+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7B19048A;
	Mon, 20 Jan 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408750; cv=none; b=q6+RI+zSD/2vp9viVUyhyqk0P2m8OepDNI7PXfBnriKeOUKTpPf0G1L7aqAvq/WzEd242opHgsam9sVy5xYc5uLYF/Oo4nxftl+hJ+ExtgNAOsDAoSAKa9aAUKDzsERNK83m7Luf8e09RuMrBN7n7E1rWW0LLO+ImJZvbHs9ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408750; c=relaxed/simple;
	bh=B1BouRyk9Kxq6ru6W1Q0+s3KiqSsAI8th/Bk/m4e+gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lywcqvlPpDzewJjlJA0FCZEqqU/Ozr0cll6vQQf8lvz7ghNUNN8m7CGndJzTrqrayhVcOz8htlTKtrthz552JapMkcknAiTDwL2woJsSdU2+Elmm59KysHhMiV7MLHyyFts4MWyo9RorJBxjlt8MnYS3ZWezvcQQOyhDEI9ebgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrZHI+V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4048C4CEDD;
	Mon, 20 Jan 2025 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737408749;
	bh=B1BouRyk9Kxq6ru6W1Q0+s3KiqSsAI8th/Bk/m4e+gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrZHI+V+aEHdTMbfL1QIX3vqE8dyrNTpkhi9Y3GZQ5fZktEyrHK+uscwotAxXL3rq
	 NV1XFtRCrzZQWg8v8JzswswLT4OHZ4L17wIlIVaDMzk1+YsSm8lGUnNYh07Pl5JJMy
	 1UtPSCQbMEREuuu+T3PYvLCE8VPqUANWeSITYvpcG6HPrlVf638rEYAVdktyGRuTgE
	 ++HgksDuLtvrbUiDUe/L6rcvXxz8tf2AchlG3lBrIpDU+JiH9HV5ku8S/JPoTHoHQf
	 B44zrJcIWKMGpPTje+HlndKz47QEzj9h42vNo9lmypUgu+JP1ZfWhzEYewWkO4Plh5
	 G8x8rgBw32KNA==
Date: Mon, 20 Jan 2025 13:32:26 -0800
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, luto@amacapital.net,
	wad@chromium.org, ldv@strace.io, mhiramat@kernel.org,
	andrii@kernel.org, jolsa@kernel.org, alexei.starovoitov@gmail.com,
	olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com,
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net,
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501201331.83DB01794@keescook>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <20250119123955.GA5281@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119123955.GA5281@redhat.com>

On Sun, Jan 19, 2025 at 01:40:22PM +0100, Oleg Nesterov wrote:
> On 01/18, Kees Cook wrote:
> >
> > On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> > > Since uretprobe is a "kernel implementation detail" system call which is
> > > not used by userspace application code directly, it is impractical and
> > > there's very little point in forcing all userspace applications to
> > > explicitly allow it in order to avoid crashing tracked processes.
> >
> > How is this any different from sigreturn, rt_sigreturn, or
> > restart_syscall? These are all handled explicitly by userspace filters
> > already, and I don't see why uretprobe should be any different.
> 
> The only difference is that sys_uretprobe() is new and existing setups
> doesn't know about it. Suppose you have
> 
> 	int func(void)
> 	{
> 		return 123;
> 	}
> 
> 	int main(void)
> 	{
> 		seccomp(SECCOMP_SET_MODE_STRICT, 0,0);
> 		for (;;)
> 			func();
> 	}
> 
> and it runs with func() uretprobed.
> 
> If you install the new kernel, this application will crash immediately.
> 
> I understand your objections, but what do you think we can do instead?
> I don't think a new "try_to_speedup_uretprobes_at_your_own_risk" sysctl
> makes sense, it will be almost never enabled...

This seems like a uretprobes design problem. If it's going to use
syscalls, it must take things like seccomp into account.
SECCOMP_SET_MODE_STRICT will also crash in the face of syscall_restart...

-- 
Kees Cook

