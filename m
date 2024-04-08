Return-Path: <bpf+bounces-26134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D61089B655
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 05:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B09B21BC6
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F742913;
	Mon,  8 Apr 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyUYHtHT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BB6FA8;
	Mon,  8 Apr 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546224; cv=none; b=tYVArEFvIjb9BxOJeej0SG4DkBmoury+EqI3cpEGWh4M9JEkLAF1xIAMZoI19zR3xffVPq8hqtFYLptwaaN9U8VKIGud+KQAQZiYRofxSbf/jouhVgR+6vs8oCnx3W0k/VethtUL62oazUNiS5ZZewk7l8o1NrII12vAOsDmiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546224; c=relaxed/simple;
	bh=88xy5ncDJIYZXTN7bl3r8g56wJn0PxbweOPTs/roHCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UcZuCi6fTHrFAo9WkRiC1h+Rbp9s98vYQ9VszgNMdaCLnUvBKGnppPo6MwIrjTGcc8fQHh7OM/UQWaj79YLVWrrykYjFpNjHFzjSJkIVxqDSA4uvCYBRNUkJR6j44AQTwPAreTSEv18TnR+Y/+IwJug3H+b2CIaN4FLuBcBi+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyUYHtHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18CFC433C7;
	Mon,  8 Apr 2024 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712546224;
	bh=88xy5ncDJIYZXTN7bl3r8g56wJn0PxbweOPTs/roHCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZyUYHtHTQhKODKjnshXcOh/ThkToFRTSnqBmTTyiXmfdqVvUGvDpFgtFv6y0CX0i2
	 N+uf4vuOTZqzxAAvYglXPWOiWX7Tm+xP7RdhHcU8+vfaxRLIWBBJGR72blU3qHKrmZ
	 UR6eb37f4kkGT8pkfjWoiQPXUVYobVQWTY32f171Dbtql4XC3LvYqLkfNefKr3TWdn
	 GZin3RVDKASvgMnXdND7GADgx0SxhLAR8If7Q89aua45ku3iFhqkAHBYrQYiCjNK8c
	 jH8BkDVU1shiWB+keBsxv3JFuZS3F6Gc9bGhE02ZZrjaA5gAli5PCr5cDBRCqTzsvk
	 LD3bvQZJCP3UA==
Date: Mon, 8 Apr 2024 12:16:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240408121657.5603eb93a55ba22a29b0c24b@kernel.org>
In-Reply-To: <Zg-8r63tPSkuhN7p@krava>
References: <20240402093302.2416467-2-jolsa@kernel.org>
	<20240403100708.233575a8ac2a5bac2192d180@kernel.org>
	<Zg0lvUIB4WdRUGw_@krava>
	<20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
	<CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
	<20240404095829.ec5db177f29cd29e849169fa@kernel.org>
	<CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
	<20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
	<20240404161108.GG7153@redhat.com>
	<20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
	<Zg-8r63tPSkuhN7p@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 10:56:15 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > 
> > Can we avoid this with below strict check?
> > 
> > if (ri->stack != regs->sp + expected_offset)
> > 	goto sigill;
> 
> hm the current uprobe 'alive' check makes sure the return_instance is above
> or at the same stack address, not sure we can match it exactly, need to think
> about that more
> 
> > 
> > expected_offset should be 16 (push * 3 - ret) on x64 if we ri->stack is the
> > regs->sp right after call.
> 
> the syscall trampoline already updates the regs->sp before calling
> handle_trampoline
> 
>         regs->sp += sizeof(r11_cx_ax);

Yes, that is "push * 3" part. And "- ret"  is that the stack entry is consumed
by the "ret", which is stored by call.

1: |--------| <- sp at function entry == ri->stack
0: |ret-addr| <- call pushed it

0: |ret-addr| <- sp at return trampoline

3: |r11     | <- regs->sp at syscall
2: |rcx     |
1: |rax     | <- ri->stack
0: |ret-addr|

(Note: The lower the line, the larger the address.)

Thus, we can check the stack address by (regs->sp + 16 == ri->stack).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

