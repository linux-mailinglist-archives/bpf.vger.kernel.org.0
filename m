Return-Path: <bpf+bounces-75021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D0AC6C35C
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91D6C4E880E
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175A2248BD;
	Wed, 19 Nov 2025 01:02:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2E17D2;
	Wed, 19 Nov 2025 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514167; cv=none; b=eVRcvY5JuHR4Fd8kmuJRzO6+bNSbstFTPQ9hLEq2JA+bEDwqPJLuBGX/Gyw2/WR31vj9lJZUJ163AAwV2BzBrigkBNNmvX7xkDwdpMV2GeBqeVJce+4df+A/1S+7atMhik5PVe1wkGNJSSGk7y9GmHPYuKWdcTcXZe42jfdkWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514167; c=relaxed/simple;
	bh=z9kDYG2QXb7cEDRJrWhUQNNgiIwks5S4pcclUl9agdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ovce4ZBRFtWZDwIfZriKiBI/7jRJblDunBZ5GQvzN7bhAbaAYc120Ysh7Bfk3E2wqqc21zxIXoEfFX8quk4Q/20RMf0HlIPTy80S8VZR1FKeVb9HvwsxUmlcu/hlf2MPdLzkgEoL3wLinwkvmaGQbT9dL9Vyj+kqEkL5k8DgmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5FC9C1A0282;
	Wed, 19 Nov 2025 01:02:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 11F792D;
	Wed, 19 Nov 2025 01:02:36 +0000 (UTC)
Date: Tue, 18 Nov 2025 20:03:04 -0500
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
Message-ID: <20251118200304.29f2bd7a@gandalf.local.home>
In-Reply-To: <CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<20251118123639.688444-7-dongml2@chinatelecom.cn>
	<CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 11F792D
X-Stat-Signature: jkrk1kz5krbhs9ymwhtraqr8ifc5i3wu
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189miLHjVX4fEh1ICn3NNa5BybCT1bgSI4=
X-HE-Tag: 1763514156-611674
X-HE-Meta: U2FsdGVkX18axUsKwzWsxWMe1Evn7GsnkYHx/ugETbpESS0+iJBXk/vp4sJjOzlaBhW0Q9kpM51XpKnaG8n1xspzcFaaMSJwV3xUgl7mY46/L30W2AGZbbbEQ2bHXJYH1y23xIKc8waxqVVIzQeyjdUEllKEqVBX76Sj68KXbHgcP82iEo3dFbDMVp6Z9B5rbSkd1DpiE/AgjYsje3EVTCgPKa35wC55PvTf6vWFJDo1X0Wu6NHED5NJzV35vYmTT4qTsQ1o/pREyW1vvhh1rUvbUFKMnTTbb12ygpf3bH8Y1iIYsLBZCzSceHz+CtjtbnSUB38YE9LwSQkUwMFdXh4Wf7NXWs9tY6B9uw96Pu3KT4bU9HQ5FA==

On Tue, 18 Nov 2025 16:59:59 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Steven,
> are you happy with patch 1?
> Can you pls Ack?

Let me run patch 1 and 2 through my tests.

-- Steve

