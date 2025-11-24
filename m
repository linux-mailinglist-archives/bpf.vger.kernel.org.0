Return-Path: <bpf+bounces-75345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17349C81280
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF2B54E8B34
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22130E83A;
	Mon, 24 Nov 2025 14:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF52737FC;
	Mon, 24 Nov 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995786; cv=none; b=p2XKyrbPnem3PVNpcrScM+5fm2lvi1RPFtJ4EzphjIFyi+hKH2N98FIRGi4r4KQnUspB7gBVpGr+gA1HfoGxRRV5dcgkbOKwRWhkt8C3sLhGz9CzfaIeYEtSszfVqeToRkuznTYZ2VvjkKKFSUGzZ4A2Ny1peuQelPgqlAaMkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995786; c=relaxed/simple;
	bh=2U6hn9si5EBJTgmQ8x5RMt+GdbBkV+WBaJFuv4rHB7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWKVG0R6JburwCDZVcBPTQ1+b6HjpGnCt7+1S8DTdCXaVqNw0sWwo7m/kMv3NcEpYiVD4zfN1xwo2SPmOINs8ugWeP1Y5G2CE1WPTrZ73Pin7SvKeoP+HriTa2B4wGFvsI0lfX0Yna77vjkHyUx0Ng1eHFyaH8juwfvLh5Tk+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3DE6013058A;
	Mon, 24 Nov 2025 14:49:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id F3A6C20015;
	Mon, 24 Nov 2025 14:49:29 +0000 (UTC)
Date: Mon, 24 Nov 2025 09:50:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for
 trampoline
Message-ID: <20251124095010.1eaae2b5@gandalf.local.home>
In-Reply-To: <CAADnVQLs-kBMi7VCizH5be8q8Nyzx=KYNPcnF-EDNx7OPs4Aiw@mail.gmail.com>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<20251118123639.688444-7-dongml2@chinatelecom.cn>
	<CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
	<20251118200304.29f2bd7a@gandalf.local.home>
	<CAADnVQLs-kBMi7VCizH5be8q8Nyzx=KYNPcnF-EDNx7OPs4Aiw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F3A6C20015
X-Stat-Signature: tr9cikrqfaqqxo6dtssdwyhke5wzmy8c
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Q0WAcvkeYHyjjC8OZIWkuduGdQ4dIWFQ=
X-HE-Tag: 1763995769-565992
X-HE-Meta: U2FsdGVkX1+/mSZdhlqKJoA5ypmhCHpi/1gfA8sJRta9vF1al0L5bw3DcNB5h19wNGcFotHDRCXNy0BMbCL0ojJKc8DynPW71jlRhjwq1mwaYw4BKDfwhcUpAJaKyyKr8UqSB9RJYsqvuLpu0q7bGYtuR3fHTu+/kFojwWhUGAIh3czA7tpMNAUwApboFVwC3v+awGSLSK/WUEQjXS5UO5alTkKAhj79t+RxZNv2vuP/HNU16O2sfRhKS4GYnBPsZ8y3nMRa4GQk4mbo1DoKnryc58tWCvTCzOUWcRVNSm/RjJKJtnXL+Oa6R4AaJXRD9iEFvKuOUtf5SDv7XdsbU0gQKtca0fVYwucQ8ZxnXT0rMw7EYqIKFbKzljhWsiNkPAeapQrgWch9YO6zX+NSNg==

On Fri, 21 Nov 2025 18:37:02 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 5:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Tue, 18 Nov 2025 16:59:59 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > Steven,
> > > are you happy with patch 1?
> > > Can you pls Ack? =20
> >
> > Let me run patch 1 and 2 through my tests. =20
>=20
> gentle ping.

Yeah, sorry forgot to reply. They did pass.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

