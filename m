Return-Path: <bpf+bounces-68192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1344B53DD8
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE744AA222A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCF2E091D;
	Thu, 11 Sep 2025 21:38:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E32DECA5
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626735; cv=none; b=nkoPRYdCeQLb6OLJk1JW7T/Cfz247gMvKj19rqudbN5PgZq9n7iQ/e5Jj5KBKFZ/EDLMvjyKLucwh9wfEB+h5jIB4/aScvImX6rR81peyaogFc8MPzmA2yJR3/xT7Ip8qkuI2Nb59f+8EG0fos9k7azDF3ZWeAeikZJS8RtmDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626735; c=relaxed/simple;
	bh=mbYaMuAUy2Jb2aAvQcs1swUFOpbRrmp+izylNoCDf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeTh7As3MHUJnPT3mI+A83x13q46X21tVLWMRbzV5LUiaTy2HgQhCe0LC+ThQp4Z33bLANw7Bg+CU/uxuYSkggXRxuB3sOL3rattJduTN3VgyP5biZoGVYnKfvGHAzei/yuCxjYc59awt6o4Tb9eR9KbbNdO/14JD1iBo2CFgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id BF9D61605D5;
	Thu, 11 Sep 2025 21:38:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id CEFE520018;
	Thu, 11 Sep 2025 21:38:43 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:39:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, bpf <bpf@vger.kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: bpftool uses wrong order of tracefs search
Message-ID: <20250911173936.3981f416@gandalf.local.home>
In-Reply-To: <CAADnVQL=FE0veZUFuHnwfyNix8_yU8x4_3QdtSp85G6mfYTgxA@mail.gmail.com>
References: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
	<35d7e2b8-c090-46fc-8f45-b976ffbd5dce@kernel.org>
	<CAADnVQL=FE0veZUFuHnwfyNix8_yU8x4_3QdtSp85G6mfYTgxA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CEFE520018
X-Stat-Signature: 8t8qbpq5ssuokrbk811angqo1aoazkdr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/igtwnpCr0Nlj0Ode8+0Z79adymnXLbjA=
X-HE-Tag: 1757626723-393781
X-HE-Meta: U2FsdGVkX1/7QlS2v2+VUPWiWuyTkwdVvGlYtOZKP/nVgrmdOyoHlIOaW7b3AlzsulQHyAUU8y4u1a+CScVXiv9URyGA00acYqHtUMEgFuv0Bm91A/9LAVaqiIQJekMOfgD8mnn3vv32e0cMx7NTI2PCjS413m8uv0vKdfOqj8kWcZyhvhbS/hv/PzOzhBzIghEoeEmlT5vQZa+Z6Ok3Rfr7ukoH2FVHH6cLXMm3laTQQvZBw8SotdW7GzQh5QKtsb/ivEiJg1/KaLqMey7HqP8EQtNHC052lG1rII0SXzcvVue/JdsEbKBCYUkqhmyPAbuIQYdyVHuyqmbpIpsI2RBxbe3b13WV8rc9FBT1AfA6TpPA7klbgQ==

On Thu, 11 Sep 2025 14:32:50 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Older kernels won't have this warn.
> Also I don't know what these are:
>                 "/tracing",
>                 "/trace",

It was common for people to hardcode the tracing and debug directories to
short names. I use to do it, and I believe Arnaldo did it as well.

> I think the fix would be to do:
> "/sys/kernel/tracing",
> "/sys/kernel/debug/tracing",

Note, the libtracefs uses /proc/mounts to find the directory. Feel free to
copy it and tweak it for your needs:

  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89

It has some legacy code to allow finding the debugfs directory first, which
shouldn't be needed anymore.

-- Steve

