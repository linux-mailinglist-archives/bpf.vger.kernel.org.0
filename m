Return-Path: <bpf+bounces-34793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D77930DAE
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 07:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D70C1F2147E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 05:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F613B7AE;
	Mon, 15 Jul 2024 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i48NpiMO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D52D2EE;
	Mon, 15 Jul 2024 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721022419; cv=none; b=KmyXOAnLhBHCp5wGL7KTl4SZz2uBLB1NexCv+LTri5l/4hfg8GmsznUVWT0lmZTqMybtwWFCnbONzD4yvgGADEKKZbYAzwgQoCIFfwmvzIn7A7x7YlgAnx7hrLOyFGgXeuuL7QEtV9OV0L07pOGmx9GuzmVUgspHDC3+ONzXoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721022419; c=relaxed/simple;
	bh=v2vMWYHn7MG7zOqKves+1/98n0hJ9KsdGPe/87XOnKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ujtksl0KHPR/b8QkdbqQSj4J337oGMZDdxFqFoSDFTXH+C8Jq6hNffsRhLqr2Y+DIU+Z7uEZRf6HTS8qqWnJpojTi5CMtvlKapHThkqko4QWwPLkKaZyzyzjE/6HTiUupEC0aoV+tn44vEOhCj+r5mznJFGZjitu/Q8MfJQyBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i48NpiMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A120C4AF0A;
	Mon, 15 Jul 2024 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721022418;
	bh=v2vMWYHn7MG7zOqKves+1/98n0hJ9KsdGPe/87XOnKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i48NpiMOjZ559FSxGxl2x6GcUiuHGIcQSbvRu+ZQLYrFHcH0qAnTmu3AMP3K83V+n
	 257PEY2PUqkkFzCgc9qIcsvF7KpmmE2FpIoOvqpr6FUKFthe6E2rFXDssDBTuN4pJD
	 G0xf0eZyT3c08c3p+eGMMrZ5aN5ocZYWjO3Iqsb8OXBwuBCNj7eCS449LwhxO/H5ra
	 zcFqdxR8pSizeWez4F3LXs82jrRIcsriyCxLdPek9juRLnh69SOYV8aTuCRRFIZRoI
	 HZ6Xw8fUlJlizkw9znO8NDJh9RBaIraIO3bx3DNr8uLbtZIVNQM5H2PdzyNbPhbmX5
	 8QSrX2DaHM9fg==
Date: Mon, 15 Jul 2024 14:46:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] selftests/bpf: Change uretprobe syscall number in
 uprobe_syscall test
Message-Id: <20240715144651.98ef93f04a96a7aa9109d55e@kernel.org>
In-Reply-To: <CAEf4BzY3Xo-g02r9TY9tHq49JLrrYoUNoXN=WXhJ02q4xUbGbA@mail.gmail.com>
References: <20240712135228.1619332-1-jolsa@kernel.org>
	<20240712135228.1619332-3-jolsa@kernel.org>
	<CAEf4BzY3Xo-g02r9TY9tHq49JLrrYoUNoXN=WXhJ02q4xUbGbA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 11:27:30 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, Jul 12, 2024 at 6:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Fixing the syscall number value.
> >
> > Fixes: 9e7f74e64ae5 ("selftests/bpf: Add uretprobe syscall call from user space test")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> is this selftest in probes/for-next already? If yes, I'd combine these
> two patches to avoid any bisection problems
> 
> but either way
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, let me pick it to for-next branch.

Thank you,

> 
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index c8517c8f5313..bd8c75b620c2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
> >  }
> >
> >  #ifndef __NR_uretprobe
> > -#define __NR_uretprobe 463
> > +#define __NR_uretprobe 467
> >  #endif
> >
> >  __naked unsigned long uretprobe_syscall_call_1(void)
> > --
> > 2.45.2
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

