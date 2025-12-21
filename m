Return-Path: <bpf+bounces-77272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504ACD4428
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D320F300796F
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E84307AF4;
	Sun, 21 Dec 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K1lOQKsm"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E429BD89;
	Sun, 21 Dec 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342714; cv=none; b=tQOvYsjItslQAeSVp+Qq5bH5/SorpsILQi/A2WKWvENOlqKjDSVAwf4oXLRJ9JKMFd1AyKJgnCRQ5JYRagfjJx8erqCTa2s2R5nX0QW/WH7z+nXwQFTt0dl4fBR1tz1Sgr/VDNhFekS1BLtHxcgfmNrBGwARsT+EKC1vj+9i9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342714; c=relaxed/simple;
	bh=uqzf0F9FOuyRCoi0rmOpP9qD37K2Wd+JeGbGEFQldoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyogzwLFDz6IqF2vtR2VgzNZ/E7n6ERhldl5Pi7vgNfYOFYt0baSwfqX44xJlw7ra9Ir3+1xVh+1cjsVkxyBBa3YGrYyZHOJHTmD3w83A5NjTcvMMB5gR9PetuGDy9W0avu1T2P8t3FeJ1S/59Ok8Ps4HtbAwS1t2jsxj5iP5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=K1lOQKsm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dZ9Dt6h8Mz9v3b;
	Sun, 21 Dec 2025 19:45:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766342703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqzf0F9FOuyRCoi0rmOpP9qD37K2Wd+JeGbGEFQldoU=;
	b=K1lOQKsmpc99LY1z4ASEtcypSgfFu6viCOzZ7w12P81Sp8FbTkf3jPa91QDIKONhRTR/Bs
	01DgKIPvJ8t0ZkmqhdzYu4H5egtf9rJWLx1CdGJ6F80NuAh3M4jOkL2L6tuB0A8uwVmZ8M
	q3XcTubvZVJoiopdVEdmDidhWEgFeKv2Ndjnl5m1GoEQmR1PbRDdcvK6noPw3rmsUBpioN
	45HAcinGFtinQNp/f1KyNyNU9Xt1Hfj4pJiQlS/2mbGkQX3f0+GUG5K9fm8QLxeU6n6yIi
	uo7TggrX6H1foj/3bxR2wKUjJBJ47JdzJChSTvsLrC64WHlPrdENz3FWXrNCMw==
Message-ID: <e9ab026c91a2e7da84702d9fd2455ae64f25b32a.camel@mailbox.org>
Subject: Re: [PATCH v4 0/2] kallsyms: Always initialize modbuildid
From: Maurice Hieronymus <mhi@mailbox.org>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org,  yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com,  mathieu.desnoyers@efficios.com
Cc: georges.aureau@hpe.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org
Date: Sun, 21 Dec 2025 19:44:55 +0100
In-Reply-To: <20251220181838.63242-1-mhi@mailbox.org>
References: <20251220181838.63242-1-mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 45a22b6f940ff08cc72
X-MBO-RS-META: hnshh8eifp969k9zopsmzix9ssowzytt

On Sat, 2025-12-20 at 19:18 +0100, Maurice Hieronymus wrote:
> modbuildid is never set when kallsyms_lookup_buildid is returning via
> successful bpf_address_lookup or ftrace_mod_address_lookup.
>=20
> This leads to an uninitialized pointer dereference on x86 when
> CONFIG_STACKTRACE_BUILD_ID=3Dy inside __sprint_symbol.
>=20
> Prevent this by always initializing modbuildid.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220717
>=20
> Changes to v3:
> - Split the changes into separate ftrace and bpf patches
> - Replace IS_ENABLED() with plain #ifdef
>=20
> Maurice Hieronymus (2):
> =C2=A0 kallsyms: Always initialize modbuildid on ftrace address
> =C2=A0 kallsyms: Always initialize modbuildid on bpf address
>=20
> =C2=A0include/linux/filter.h | 6 ++++--
> =C2=A0include/linux/ftrace.h | 4 ++--
> =C2=A0kernel/kallsyms.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/ftrace.c=C2=A0 | 8 +++++++-
> =C2=A04 files changed, 15 insertions(+), 7 deletions(-)
>=20
>=20
> base-commit: dd9b004b7ff3289fb7bae35130c0a5c0537266af

This patch is obsolete and already fixed by [1]

[1]
https://lore.kernel.org/bpf/20251128135920.217303-1-pmladek@suse.com/#t

