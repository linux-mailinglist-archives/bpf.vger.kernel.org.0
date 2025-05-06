Return-Path: <bpf+bounces-57484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC715AAB875
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4E169B51
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5A145348;
	Tue,  6 May 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u+G4jXGP"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435B35AFFC
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500295; cv=none; b=aQZxmB2/Qj5bmog/3XY00sAb/zccXe88n7Br+eOV7m2Lab9KsIwUMlFLnW8MKR90unOuUOE4V2aWQLyPmnZ5fsi73nKxuglKropxxyCRQqWqTrK1VQ46+YemR24RVB8pSIe3AF4KzaDQWGX8degFbot03gEDPS3EbQIiFq8v+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500295; c=relaxed/simple;
	bh=LwbEy3wpNq3kSGayL5fDQ+4evJzz4QR3WrQDC86HT24=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:Cc:
	 In-Reply-To:References; b=rL3gfmRm+C14z/XfJsmp68ubjj5+xs/ZDXQnAN1r9KalmNuXV5CawU1Hhlpiz7pE6of+OdTc14XDvd2zrKr80jpex09WeGVckpAJK2KQY6s4dXBofIH7z2Fcg7NoX1Mb6sAkBRnuSpDhT3kTuYogtxuZ31LJrtTQa6n1BB/w0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u+G4jXGP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746500280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwbEy3wpNq3kSGayL5fDQ+4evJzz4QR3WrQDC86HT24=;
	b=u+G4jXGPZQL5BsfNDyS+uaCXCL6j31zRZ1pCMqijsOaPOeq2hCIdAb8UsTKmWatQofotAK
	dnli//rsDcLLqyTuAIilF5vfpmhsvtgn5qbAlJSaEBiQKm36HcPEGMBaPdGIgslMsFlGzm
	AMXgIALDVBQ5+Qm2F5bN45duE5LEg18=
Date: Tue, 06 May 2025 02:57:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <1c9aa8f91ef683dedbe71a59676ea159a64894d8@linux.dev>
TLS-Required: No
Subject: Re: [RESEND PATCH bpf-next v4 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
Cc: "Cong Wang" <xiyou.wangcong@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20250506025131.136929-1-jiayuan.chen@linux.dev>
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

I am resending this patch as I have discovered that the previous v3 patch=
 which has already
been reviewed was incorrectly marked as 'v2 superseded':
https://github.com/kernel-patches/bpf/pull/8763
(It seems that Patchwork closed it incorrectly?)

The original v3 thread can be found here:
https://lore.kernel.org/all/20250414161153.14990-1-jiayuan.chen@linux.dev

