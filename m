Return-Path: <bpf+bounces-55096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB9A78207
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8383A969F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09220E6E2;
	Tue,  1 Apr 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gpLgSxwi"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260441D86C6
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531838; cv=none; b=qQeYbWp3DeSolX2K+6LhSGK3QY6UhUZn4iLTzGJM1vQDBuIvs8BF3ywecSQGR7LHM4FBnsJX4dT3CZ2STlqXk4yMwt0hJXe1X+vTrJG1dwoL7sNyESy2Cg7DbJWx7QdTwWeFmrUgbkEtDX6spISCwET/0P+mnscTTu+3lM5iaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531838; c=relaxed/simple;
	bh=1agTIDuuQkoED3aRH/9Tv0oI8Qu78CLDEd6IAeD9J8U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kgYSjsXhcIM0xEOx67MhBNVyusvthWGjtFXi4tFkFoYwYFyzIDcvc6dW09W8ktsObqH4gbpLQgY1feEiNcr9W8E30Wy93Dp1RABKSa8aDA107XmfNRYsxpDjvJmtFIiwL7c315o5AgdbY2IR7GoKtCo+NDCsW6mA1AkQBZvMMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gpLgSxwi; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743531834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1agTIDuuQkoED3aRH/9Tv0oI8Qu78CLDEd6IAeD9J8U=;
	b=gpLgSxwiws/CFRDB9AacSSqmxqbs+8thhI6kz8qBacmU5JlZKEnVnIjDnIdf5AtkM+arpZ
	ssYYsDWA4ibkcQ5Wlx277BuY9wEYB0ZlXX4HaAPNEqXnF2h9EMpjTr9DAhEu2no8Ho89TX
	7LSvXp1Js9cAt+23nPu6jm25VeNMEE0=
Date: Tue, 01 Apr 2025 18:23:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <e9b85e60b138e89ae1768e356ebee127b41498e7@linux.dev>
TLS-Required: No
Subject: Re: s390x: selftests/bpf are failing on CI
To: "iii" <iii@imap.linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <1199a2932ed1800fa0a898e67ba74590@imap.linux.ibm.com>
References: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
 <7d55acbf6e6b20f9e8d679883c1e77391e80b304@linux.dev>
 <1199a2932ed1800fa0a898e67ba74590@imap.linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 4/1/25 1:06 AM, iii wrote:
> On 2025-04-01 00:45, Ihor Solodrai wrote:
>> [...]
>> A little off-topic: it looks like ebpf runners are offline again,
>> could be due to recent github runner version bump.=20
>
>=20The new docker image looks malformed:
>
> $ docker run -it --rm ghcr.io/kernel-patches/runner:main-noble-s390x
> exec /entrypoint.sh: exec format error
>
> $ docker run -it --rm --entrypoint=3D/bin/sh ghcr.io/kernel-patches/run=
ner:main-noble-s390x
> # cat /entrypoint.sh
> 404: Not Found

Please make sure you're using an up-to-date image.

Link: https://github.com/kernel-patches/runner/pkgs/container/runner/3855=
57209?tag=3Dmain-noble-s390x
Digest: sha256:946298c96c51af666f8747be3afcf9a8e59483c40cf790cd94939abf6e=
c22969

A malformed image was pushed on 2025-03-20, then reverted and later
updated correctly.

If you're using the same ansible setup that we do, restarting the
systemd service controlling the runners should help.


>
>>
>>>
>>> Best regards,
>>> Ilya

