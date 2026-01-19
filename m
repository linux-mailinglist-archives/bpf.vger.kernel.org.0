Return-Path: <bpf+bounces-79518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A736CD3BB0C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D6B30471B9
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B212C08CA;
	Mon, 19 Jan 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6FNo7Jk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE12AD0C
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863038; cv=none; b=oyzJWiZm+LDMLROmjIZuEJFuSxTcqZEZJrdZefWdXi2V40RtYDJXlI+vfVy+L+mCP4V/tjqCt8BebrLjAOJzuMs72E9DehlGOUDLI2xz0ojZObOZjHWcHDaqRTiz+H6jC1wE4jw3AGUmtXxv9rFV8t1mI1YIU630yi6ZMAVkjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863038; c=relaxed/simple;
	bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDfRmu6eTzf3+j0zzsjVlnkNBGS3axafC+nZ0/8Qrk3qE79tDwcEPRIxZjFdpJwwkmAeQBWmO7tw+fVKISZlpU33AfAm265ti9aMBnXmEvTu+4dms/afUwAENjKVyLgfcfXY92XE8jD3zz76FK2FPHyYtRSgYxCY+BYm5CE56dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6FNo7Jk; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5384210eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768863036; x=1769467836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
        b=C6FNo7JkV/gN9UL3L2ompNX0I611ibO8sAht9zvwGhgMNZF0vibAEuB2g835HNe2Zn
         Ifv3MCBzN3pjLBx1W9V9iH0w7ztV7zZ0aehsaHFCU9pQFjrZ1iWmG+IAh7QoyhXFWunv
         yNOMv2ggl2qU1orUySzmhWiv0Iug1vZ6ysfEXk9y/FwBZJHPwoGdkQMU09o5I9zWmhuF
         sSXUnYdov/hULMK0uQtfUCuCY/vqCiA77krm6+YJ8QI2Ao82D3CxajmuxOUkRDZLnyY/
         ik/fTIfTT8MDwzXpqfArpU78NxNuwP3iotLjMIWSNyYtQrBn/StHYsaVpt/yswdqUZYE
         Zb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768863036; x=1769467836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
        b=aFP/W3q118FDOPWXZYUrgYZ55POFjn68Ley0LnanOkIEFUS5jeANQJxCrKMRF59BC6
         QpxBj4e6wGmO9xP55df+K2iaopBYPAyW70vcJ5zxaF1cMKr5VfKZJ9zrewBvc8dk2eCQ
         xM3nLabOcSA6BqYvwtw8fEABS6MaOPuq8hAOT9JwmIDX45RZKllr8UmfcPTI8uDR9WwI
         4toSMl43XyOa91bi0+TUaP7Qc41WZvfn+qnMfxCxHJBAtRyfuTwbD6okguolTrqsCxCb
         /E3x6B6XTNgtmk6VDwr2sTSmvr6BUOcAJYOcvr/BEUPj12EbW3BjU1xRlty3sxYqlOBK
         x6FA==
X-Forwarded-Encrypted: i=1; AJvYcCWfOUQUIQoo2I7qYRtGPYWB24RhZQlL+bu9qfibLWSkwKRtxrdPr7GShUApD5RgEoIayH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMZ9TzOZoAeuu7RPoWR/SNO6o7QRyrFr8B6bjgY7uq+38jknY
	cLsJybtBwrI4qCdXjjner8pPPhWGZ6qBpD437FjBQqIULJ+mVN7dzYwQ
X-Gm-Gg: AZuq6aIAJFEXQKLKObRegi0EX/LH6sJXyFBdrBVq4L79Yd9k3tjzXEHcKaAWsbJbos7
	QxExCTWngzWhP5rj8FQRoeYUfnUaw1t1vqVra5VvGpgZn6gdAdFvkfqrvQq1Nw9NOvqyGTx9u73
	FZ/N+yNpZIv5Y3/tikSrWubPIsYJc26QU9Er4SOngFlsQiJAcr32bQxL4Pm5dyxWTr/q/nq664D
	XJS0WAROBoPQKZdXidd8ad1FVMtTk8mIpdX0TTcBC2gQQ9LFT1UiY3BLjDwLXGHoDzd8TYsH3lZ
	4N1PnsqseKy3MAiCPjRkX1fP6bjp0ln4PqZuhAWaHGgOl33Ekl5Z6O7oXyJ9cktXHLfLol6XezU
	aHwr8vpqk0s7if3/VW2GTvSdpU/s160+05arDezhyddLBkaEQoX6fHkugnk/gK4F7K3F5FOeQi4
	fdO37rnRUl1Y5VOyVO5IBxdcAoMg6KfPjV4QpRe8UVAH9FaY9SvjYVe8x/6YyLPSHFNw==
X-Received: by 2002:a05:7301:1687:b0:2ae:5b32:774 with SMTP id 5a478bee46e88-2b6b46d2a6bmr12941699eec.7.1768863036298;
        Mon, 19 Jan 2026 14:50:36 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3651f39sm14825179eec.24.2026.01.19.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:50:36 -0800 (PST)
Message-ID: <b77851c851550f8b932fd2fcd85cb85d16abcbf2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:50:33 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
> helper calls instead of BPF_CALL_KFUNC.
>=20
> Remove the BTF_ID_LIST entries for these functions since they are no long=
er
> registered as kfuncs.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

