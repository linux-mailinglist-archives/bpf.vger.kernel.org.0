Return-Path: <bpf+bounces-65816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE5B28ED7
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A65AE2A99
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1B1865FA;
	Sat, 16 Aug 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xeXI+wWF"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF122E717C
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357330; cv=none; b=UVq47a5dJGYXj5cEE1W2ktP3zP4J49gK9hkD0jY7qFULbj3MzMyIOGwJqKos2SbF9gbc7rYVxtFAP96YO5hdL5InPv9OLqa6MHApnLjt2/HylI2ikRWT0ySocFH8kWkZg8RgmDMAJBhmxT03kc4hKUmL7nYXC9+xDyRqwa9LbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357330; c=relaxed/simple;
	bh=QBoQ2/LRMiA6/AxN/TDAOkOxArwJyzbjun/AzbwTDxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVPmdiFdtuoh25H7EOfH1Wh6OJTWLstSmKQmP5lSSHjEW4uKg1EDh1TBDmltOsdSlyrkjV5lms+tEgYBwsjS8sTQsdUybllGlrTWaVilqxJN4F/fbC+aA6H31Q57WDeEcBy+ExlxVKw3YmKwF8RXrbFoMA4cu9fB5oTkVeukxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xeXI+wWF; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06952937f3dd04e7f68bbd288da23f00ae83c213.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755357315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBoQ2/LRMiA6/AxN/TDAOkOxArwJyzbjun/AzbwTDxs=;
	b=xeXI+wWFkISQZxdselg7Se2ois5v+hY2uVINzY72TsutKFJXYNnQQzMOljZlklva9ON2k1
	dhmQALAKUv6Eup2ZwTiexrX5hxC9OkVp+TnRt2cL2c/6OLsvSDpYxwACRGGERkbOzxXWpl
	ifpVeT1Sv/XdkjxYCFg1e5lElSrRNIw=
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, Puranjay Mohan
 <puranjay12@gmail.com>
Cc: puranjay@kernel.org, xukuohai@huaweicloud.com, ast@kernel.org, 
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org,  sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com,  shuah@kernel.org, mrpre@163.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Date: Sat, 16 Aug 2025 23:14:54 +0800
In-Reply-To: <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
References: <20250813152958.3107403-1-kafai.wan@linux.dev>
	 <20250813152958.3107403-3-kafai.wan@linux.dev>
	 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
	 <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com>
	 <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2025-08-14 at 09:06 -0700, Eduard Zingerman wrote:
> On Thu, 2025-08-14 at 13:23 +0200, Puranjay Mohan wrote:
> > On Thu, Aug 14, 2025 at 2:35=E2=80=AFAM Eduard Zingerman
> > <eddyz87@gmail.com> wrote:
> > >=20
> > > On Wed, 2025-08-13 at 23:29 +0800, KaFai Wan wrote:
> > > > This test verifies socket filter attachment functionality on
> > > > architectures
> > > > supporting either BPF JIT compilation or the interpreter.
> > > >=20
> > > > It specifically validates the fallback to interpreter behavior
> > > > when JIT fails,
> > > > particularly targeting ARMv6 devices with the following
> > > > configuration:
> > > > =C2=A0 # CONFIG_BPF_JIT_ALWAYS_ON is not set
> > > > =C2=A0 CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> > > >=20
> > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > ---
> > >=20
> > > This test should not be landed as-is, first let's do an analysis
> > > for
> > > why the program fails to jit compile on arm.
> > >=20
> > > I modified kernel to dump BPF program before jit attempt, but
> > > don't
> > > see anything obviously wrong with it.=C2=A0 The patch to get
> > > disassembly
> > > and disassembly itself with resolved kallsyms are attached.
> > >=20
> > > Can someone with access to ARM vm/machine take a looks at this?
> > > Puranjay, Xu, would you have some time?
> >=20
> > Hi Eduard,
> > Thanks for the email, I will look into it.
> >=20
> > Let me try to boot a kernel on ARMv6 qemu and reproduce this.
>=20
> Thank you, Puranjay,
>=20
> While looking at the code yesterday I found a legit case for failing
> to jit on armv6:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arc=
h/arm/net/bpf_jit_32.c#n445
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arc=
h/arm/net/bpf_jit_32.c#n2089
>=20
> But attached program does not seem to be that big to hit 0xfff
> boundary.

Hi Eduard, Puranjay

OpenWRT users reported several tests that aren't working properly,
which may be helpful.

https://github.com/openwrt/openwrt/issues/19405#issuecomment-3121390534
https://github.com/openwrt/openwrt/issues/19405#issuecomment-3176820629

--=20
Thanks,
KaFai

