Return-Path: <bpf+bounces-76645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF2CC01CB
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 23:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAC4301D670
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26F3093C8;
	Mon, 15 Dec 2025 22:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605A41A8F;
	Mon, 15 Dec 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765837037; cv=none; b=QCiBzDZU466YLfhe/PP7lh3nuv+tRQPuoAsKtLh1VOH3Ujbf3uOKiVFvqRe02CWOHYOBKheLbR47rVVurrlvX9WnSxLEyHcpKSvrrh8OWczer4uNSTAt3t/CUf/iFhxquyluiFPNnceP+7rmjXgpSIF5dI7RkFJVVmxa4sOci1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765837037; c=relaxed/simple;
	bh=ZsgtmUVSaPSY1fm6aJUzc0sKLMlEF7FL1Gvx7heN1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nez7zbi476j05As6oZNmCV8ctsJEKRpA79ZtSXQnuu4yi7K3vuE+nlmf6AZH5vFGlvnAqxc0MNdFM0HV+2Xx8z286WXVaITrILfc8RkkAuHLKpTdZdELUaBTbM5KUVNIwrKmYbTr1f4/5B13KOIh9J/lhMdi3+yHgAsxE8YXzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 35538588F5;
	Mon, 15 Dec 2025 22:17:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id B2A762001C;
	Mon, 15 Dec 2025 22:17:00 +0000 (UTC)
Date: Mon, 15 Dec 2025 17:18:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
Message-ID: <20251215171832.2b0b24d5@gandalf.local.home>
In-Reply-To: <CAADnVQLZPYc0HWqQw7ma=G-t9UMXXo+aXomVkYAzoQt=0ZrQ=Q@mail.gmail.com>
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
	<CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com>
	<CAADnVQKtvRhbAVunHrwj_pCsmazddADRvRo5zp5O+k5kc-Eoog@mail.gmail.com>
	<CAEf4BzbZwmOCgqhKeyAhEUT0MXyz09cy2dcpB9WCKWP1ikBWdA@mail.gmail.com>
	<CAADnVQLZPYc0HWqQw7ma=G-t9UMXXo+aXomVkYAzoQt=0ZrQ=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B2A762001C
X-Stat-Signature: szfszikdjojfaco4rjbnseont6zpuqdj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18S3CH/ypAfrWjjZJ8OfjeHLL3OuJMV68w=
X-HE-Tag: 1765837020-609219
X-HE-Meta: U2FsdGVkX19zDrs9bRxTdoiy4Vu+dcLHlAf4M/Cp9tLbyJ6cGDLUujRddV0RFwOk8DXAA2vVvqQUaSLkJ9fqIlyyNs5pwBoKB2b1Fxr7mEnFpxrHsDE8R9DXp0KdniM5Wf923+2/QMLYcD/y+8iMc3EsCnyTN02ap6nR9tySNdRJNFqq6tUKqUA3yOeH0dTw3trwW2yXlspqSd99z+1X6O7/x2hcxG39JbVylYI9HAaRTPTMhC7KSTj7kkNdG2CyEvprS/l1ABdPuhVxS5Ti+eu4aI7jo5p5C07ODocwewUCEIhnW1g/16gq26an1PY24rDZFo/5JkJeMT911khZaN0KJN2Y9sO7

On Mon, 15 Dec 2025 10:40:16 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > But I think instead of Makefile changes we should fix the root cause
> > here. And that seems to be just wrong __printf annotations for
> > seq_bprintf and bstr_printf. They are not printf-like, they should not
> > be marked as such, and then the compiler won't be wrongly suggesting
> > bpf_stream_vprintk_impl (and others that make use of either
> > bstr_printf or seq_bprintf) to be marked with __printf. =20
>=20
> yeah. commit 7bf819aa992f ("vsnprintf: Mark binary printing functions
> with __printf() attribute")
> should be reverted,
> but that somebody else problem and the revert would need to silence
> that incorrect warning in lib/vsprintf.c too.

=46rom what I understand, the __printf(X, 0) simply quiets the warning, which
is why those two are:

__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, =
va_list args);
__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt, con=
st u32 *bin_buf);

Hence, it's not a big deal to have that. Actually, it does document that
the printf format is different than a normal printf, and that the arguments
are not the same as a normal printf.

I complained about this at first too (and never gave an acked-by), but
because it does quiet a warning, I also didn't nack it.

-- Steve

