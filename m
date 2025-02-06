Return-Path: <bpf+bounces-50696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA32A2B408
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF1188AA89
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4D1DF97F;
	Thu,  6 Feb 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBSdBfcK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FD1DF73D;
	Thu,  6 Feb 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876732; cv=none; b=JDqOo4NqR1DJgcfttjdzRVaWBmcW/kpeD9sxGzQQ5srGzD42wipyFaCJqurfvl/fKPfJxSFl9yH/ktAUzGltUIBAGwSuvF84aVLqhcjPjRJ2Cb1z50ZpsPtRfpqA6bzFiBEPlbSsffxNj3FLgywh5eXz0NXq6aFV51zXpQz2HRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876732; c=relaxed/simple;
	bh=52sdCJ0gvdsUmKwoKOX0xSR3RgArXDVFCwrU0SpjuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs1kvCXOdju+cWLvGIkbLotB7LNjlh72WAth0Fw9mbZMYztSwQv7dfCVLYbwH5LXNdq9+LXjEZMbNvctt8rgipNFK82SXJHIcOOYK4mi2yypiZ5wJqMTumAX8nEDRXeyoYY1rjf10Et/BIwFy4/WT2bsxgf2xDSvUU/DR+2CMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBSdBfcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EA5C4CEDD;
	Thu,  6 Feb 2025 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738876731;
	bh=52sdCJ0gvdsUmKwoKOX0xSR3RgArXDVFCwrU0SpjuCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBSdBfcK+VfqF/f5FDvHEG1xVt7ZT2z8PWvc0ZYULQyeL5MN4AB6IE3zHRyyJqjhv
	 uARZ26fNq3+XGMj6p9prkGP2aPyuEWmuB5knm9GiZTzNtdgcmQcbgCfNklH1XJ0Rja
	 7RCn9wgqLOwMVXeU2kjT0W1a05/+NQ9TLQQzsdXc2UZC6NteuVYXOTYWRlbMO7PL0Q
	 DL/kI7SOk/Jo2Ex5WTNq6UnOVCOJ/MpzQd4rsS3WIdIiUm1GyzcBwF3BvqiRsdP+Ih
	 PRAi8Z3HsGb9bxevymg4CHXiutJlETc/PktaproWOd1jybGnFTP1E+R5JhG7L3XdtL
	 6qsnPETXz+m9g==
Date: Thu, 6 Feb 2025 13:18:51 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/seccomp: validate uretprobe syscall
 passes through seccomp
Message-ID: <202502061317.3B1F3D834@keescook>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <20250202162921.335813-3-eyal.birger@gmail.com>
 <Z5_a33NQwrVC9n3r@krava>
 <CAHsH6GtpzR5_X4e0KphnyNSkKqBdgivfvyGQ1mbtA8fpnuu5sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtpzR5_X4e0KphnyNSkKqBdgivfvyGQ1mbtA8fpnuu5sg@mail.gmail.com>

On Sun, Feb 02, 2025 at 01:13:28PM -0800, Eyal Birger wrote:
> On Sun, Feb 2, 2025 at 12:51 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sun, Feb 02, 2025 at 08:29:21AM -0800, Eyal Birger wrote:
> >
> > SNIP
> >
> > > +TEST_F(URETPROBE, uretprobe_default_block)
> > > +{
> > > +     struct sock_filter filter[] = {
> > > +             BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > > +                     offsetof(struct seccomp_data, nr)),
> > > +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
> > > +             BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> > > +             BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> > > +     };
> > > +     struct sock_fprog prog = {
> > > +             .len = (unsigned short)ARRAY_SIZE(filter),
> > > +             .filter = filter,
> > > +     };
> > > +
> > > +     ASSERT_EQ(0, run_probed_with_filter(&prog));
> > > +}
> > > +
> > > +TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
> > > +{
> > > +     struct sock_filter filter[] = {
> > > +             BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> > > +                     offsetof(struct seccomp_data, nr)),
> > > +#ifdef __NR_uretprobe
> > > +             BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
> > > +#endif
> >
> > does it make sense to run these tests on archs without __NR_uretprobe ?
> 
> I considered ifdefing them out, but then thought that given it's not
> a lot of code it'd be better for the tests to be compiling and
> ready in case support is added on a new platform than to have to
> worry about that at that point.

The trouble I had is that on other archs, the tests fail. I've added
this, which retains build coverage, but doesn't trigger failures without
__NR_uretprobe:


diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index bee4f424c5c3..14ba51b52095 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4973,6 +4973,10 @@ FIXTURE_SETUP(URETPROBE)
 	ssize_t offset;
 	int type, bit;
 
+#ifndef __NR_uretprobe
+	SKIP(return, "__NR_uretprobe syscall not defined");
+#endif
+
 	if (!variant->attach)
 		return;
 

-- 
Kees Cook

