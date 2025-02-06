Return-Path: <bpf+bounces-50698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518BA2B41A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441E93A9236
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C71DFDB4;
	Thu,  6 Feb 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyznFpp4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049891DF97F;
	Thu,  6 Feb 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876953; cv=none; b=QpEnGT44BiAnLcqeTBVn/s9cLnkXkVbBMW09t1VoGwQQTH7b8Ps9SmZZxq3bxoydo99+3U7MF3Tn1Okiy6izJmqrbc4XJS/I4+3z98u2v87/44Fekw+wrLSGFkxy+h8CEVlmyK2Ek/SSS0gB3DDOIYVO/Z8PqWgVG0JRkJJNgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876953; c=relaxed/simple;
	bh=bgzU90sFYWU1zZ8G9qS03xKW0AOUkvVlVRSPKU50ZLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOKMReLPqcc1/I1slvgKBzFz9ffbhqCmslHa5K9MeYidjFdkzmEQiPLmQgPDxBYM+CHPjdSVE21v8j1IAOgC28m/xruoK05xbXxM7fmgCiseP4rS7+0ZdVdCOe1BVYC7sKArkvKwkc3+05j6iuIu1Wrb43Sd/kZjkzJOroqY85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyznFpp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67811C4CEDD;
	Thu,  6 Feb 2025 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738876951;
	bh=bgzU90sFYWU1zZ8G9qS03xKW0AOUkvVlVRSPKU50ZLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyznFpp4VEj9jYaw0v3MLzV1H3pt2tt9yY7TlU5wXWHfpf1Ce2kqIKqguY4q+xDUW
	 h7ZjZ3NkcvkWaIUNGoe8SAyOUqc4mm4ddEzq3hEUdFhAqUzfbYlVdM91zfS27OChvj
	 GkUH1HS/edzMoILemJRGnZ/+IxJslQuHx5qKpRtYfJ4qc6GkmnuanLIOXEnvmydtM1
	 F+d52JiNR4GDSEDsw5EuciVv0J0CcOTFWwGTFjqVhj31qa1HkBYc4WbFbakEdSN9BO
	 FVvEk5s/6yRPL97PfcVx3PDCyPFWdfEY4Y6BD+n37jzR9Cjxv6H6X68m2+y4Ht2D1c
	 cvR1wGCrSumzg==
From: Kees Cook <kees@kernel.org>
To: luto@amacapital.net,
	wad@chromium.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	olsajiri@gmail.com,
	cyphar@cyphar.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii.nakryiko@gmail.com,
	rostedt@goodmis.org,
	rafi@rbk.io,
	shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
Date: Thu,  6 Feb 2025 13:21:34 -0800
Message-Id: <173887689139.3506371.3849387827240027734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250202162921.335813-1-eyal.birger@gmail.com>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 02 Feb 2025 08:29:19 -0800, Eyal Birger wrote:
> uretprobe(2) is an performance enhancement system call added to improve
> uretprobes on x86_64.
> 
> Confinement environments such as Docker are not aware of this new system
> call and kill confined processes when uretprobes are attached to them.
> 
> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, pass this system call
> through seccomp without forcing existing userspace confinement environments
> to be changed.
> 
> [...]

With the changes I mentioned in each patch, I've applied this to
for-next/seccomp, with the intention of getting them into v6.14-rc2.

Thanks!

[1/2] seccomp: passthrough uretprobe systemcall without filtering
      https://git.kernel.org/kees/c/cf6cb56ef244
[2/2] selftests/seccomp: validate uretprobe syscall passes through seccomp
      https://git.kernel.org/kees/c/c2debdb8544f

Take care,

-- 
Kees Cook


